/**
 * Modern Gallery Theme - JavaScript
 * Waterfall layout implementation based on react-photo-gallery
 * Mobile gesture support
 * Smooth scroll enhancement
 */

(function($) {
    'use strict';
    
    // Smooth Scroll Enhancement
    (function() {
        // Check if smooth scroll is supported
        if ('scrollBehavior' in document.documentElement.style) {
            // Native smooth scroll is supported
            document.documentElement.style.scrollBehavior = 'smooth';
        } else {
            // Fallback for browsers that don't support native smooth scroll
            let isScrolling = false;
            
            function smoothScroll(e) {
                if (isScrolling) return;
                
                const delta = e.wheelDelta || -e.deltaY || -e.detail;
                const scrollAmount = delta * 0.5; // Reduce scroll speed for smoother effect
                
                isScrolling = true;
                
                window.scrollBy({
                    top: scrollAmount,
                    behavior: 'smooth'
                });
                
                setTimeout(function() {
                    isScrolling = false;
                }, 10);
            }
            
            // Add event listeners for smooth scrolling
            let wheelEvent = 'onwheel' in document ? 'wheel' : 'mousewheel';
            if (wheelEvent === 'mousewheel') {
                $(document).on('mousewheel', smoothScroll);
            } else {
                $(document).on('wheel', smoothScroll);
            }
        }
        
        // Enhanced smooth scroll for anchor links
        $('a[href^="#"]').on('click', function(e) {
            const target = $(this.getAttribute('href'));
            if (target.length) {
                e.preventDefault();
                $('html, body').animate({
                    scrollTop: target.offset().top - 80 // Offset for fixed navbar
                }, 800, 'swing');
            }
        });
    })();
    
    // Round function from react-photo-gallery
    function round(value, decimals) {
        if (!decimals) decimals = 0;
        return Number(Math.round(value + 'e' + decimals) + 'e-' + decimals);
    }
    
    // Ratio function from react-photo-gallery
    function ratio(photo) {
        return round(photo.width / photo.height, 2);
    }
    
    // BinaryHeap from react-photo-gallery
    function BinaryHeap(scoreFunction) {
        this.content = [];
        this.scoreFunction = scoreFunction;
    }
    
    BinaryHeap.prototype = {
        push: function(element) {
            this.content.push(element);
            this.bubbleUp(this.content.length - 1);
        },
        pop: function() {
            const result = this.content[0];
            const end = this.content.pop();
            if (this.content.length > 0) {
                this.content[0] = end;
                this.sinkDown(0);
            }
            return result;
        },
        size: function() {
            return this.content.length;
        },
        bubbleUp: function(n) {
            const element = this.content[n];
            const score = this.scoreFunction(element);
            while (n > 0) {
                const parentN = Math.floor((n + 1) / 2) - 1;
                const parent = this.content[parentN];
                if (score >= this.scoreFunction(parent)) break;
                this.content[parentN] = element;
                this.content[n] = parent;
                n = parentN;
            }
        },
        sinkDown: function(n) {
            const length = this.content.length;
            const element = this.content[n];
            const elemScore = this.scoreFunction(element);
            while (true) {
                const child2N = (n + 1) * 2;
                const child1N = child2N - 1;
                let swap = null;
                if (child1N < length) {
                    const child1 = this.content[child1N];
                    const child1Score = this.scoreFunction(child1);
                    if (child1Score < elemScore) swap = child1N;
                }
                if (child2N < length) {
                    const child2 = this.content[child2N];
                    const child2Score = this.scoreFunction(child2);
                    if (child2Score < (swap == null ? elemScore : this.scoreFunction(this.content[child1N]))) swap = child2N;
                }
                if (swap == null) break;
                this.content[n] = this.content[swap];
                this.content[swap] = element;
                n = swap;
            }
        }
    };
    
    // Dijkstra's algorithm from react-photo-gallery
    function buildPrecedentsMap(graph, startNode, endNode) {
        const precedentsMap = {};
        const visited = {};
        const storedShortestPaths = {};
        storedShortestPaths[startNode] = 0;
        const pQueue = new BinaryHeap(function(n) { return n.weight; });
        pQueue.push({ id: startNode, weight: 0 });
        
        while (pQueue.size()) {
            const shortestNode = pQueue.pop();
            const shortestNodeId = shortestNode.id;
            if (visited[shortestNodeId]) continue;
            const neighboringNodes = graph(shortestNodeId) || {};
            visited[shortestNodeId] = 1;
            
            for (let neighbor in neighboringNodes) {
                const newTotalWeight = shortestNode.weight + neighboringNodes[neighbor];
                if (typeof storedShortestPaths[neighbor] === 'undefined' || storedShortestPaths[neighbor] > newTotalWeight) {
                    storedShortestPaths[neighbor] = newTotalWeight;
                    pQueue.push({ id: neighbor, weight: newTotalWeight });
                    precedentsMap[neighbor] = shortestNodeId;
                }
            }
        }
        
        if (typeof storedShortestPaths[endNode] === 'undefined') {
            throw new Error(`There is no path from ${startNode} to ${endNode}`);
        }
        
        return precedentsMap;
    }
    
    function getPathFromPrecedentsMap(precedentsMap, endNode) {
        const nodes = [];
        let n = endNode;
        while (n) {
            nodes.push(n);
            n = precedentsMap[n];
        }
        return nodes.reverse();
    }
    
    function findShortestPath(graph, startNode, endNode) {
        const precedentsMap = buildPrecedentsMap(graph, startNode, endNode);
        return getPathFromPrecedentsMap(precedentsMap, endNode);
    }
    
    // Find ideal node search from react-photo-gallery
    function findIdealNodeSearch(targetRowHeight, containerWidth) {
        const rowAR = containerWidth / targetRowHeight;
        return round(rowAR / 1.5) + 8;
    }
    
    // Compute row layout (justified layout) from react-photo-gallery
    function computeRowLayout(photos, containerWidth, targetRowHeight, limitNodeSearch, margin) {
        // Get common height for a set of photos in a potential row
        function getCommonHeight(row, containerWidth, margin) {
            const rowWidth = containerWidth - row.length * (margin * 2);
            const totalAspectRatio = row.reduce((acc, photo) => acc + ratio(photo), 0);
            return rowWidth / totalAspectRatio;
        }
        
        // Calculate the cost of breaking at this node
        function cost(photos, i, j, width, targetHeight, margin) {
            const row = photos.slice(i, j);
            const commonHeight = getCommonHeight(row, width, margin);
            return Math.pow(Math.abs(commonHeight - targetHeight), 2);
        }
        
        // Return function that gets the neighboring nodes
        function makeGetNeighbors(targetHeight, containerWidth, photos, limitNodeSearch, margin) {
            return function(start) {
                const results = {};
                start = +start;
                results[+start] = 0;
                for (let i = start + 1; i < photos.length + 1; ++i) {
                    if (i - start > limitNodeSearch) break;
                    results[i.toString()] = cost(photos, start, i, containerWidth, targetHeight, margin);
                }
                return results;
            };
        }
        
        const getNeighbors = makeGetNeighbors(targetRowHeight, containerWidth, photos, limitNodeSearch, margin);
        let path = findShortestPath(getNeighbors, '0', photos.length);
        path = path.map(node => +node);
        
        let currentTop = 0;
        for (let i = 1; i < path.length; ++i) {
            const row = photos.slice(path[i - 1], path[i]);
            const height = getCommonHeight(row, containerWidth, margin);
            for (let j = path[i - 1]; j < path[i]; ++j) {
                photos[j].width = round(height * ratio(photos[j]), 1);
                photos[j].height = height;
                photos[j].top = currentTop;
            }
            currentTop += height + margin * 2;
        }
        
        return photos;
    }
    
    // Compute column layout (exact implementation from react-photo-gallery)
    function computeColumnLayout(photos, columns, containerWidth, margin) {
        // Calculate each colWidth based on total width and column amount
        const colWidth = (containerWidth - margin * 2 * columns) / columns;
        
        // Map through each photo to assign adjusted height and width based on colWidth
        const photosWithSizes = photos.map(photo => {
            const newHeight = photo.height / photo.width * colWidth;
            return {
                ...photo,
                width: round(colWidth, 1),
                height: round(newHeight, 1),
            };
        });
        
        // Store all possible left positions and current top positions for each column
        const colLeftPositions = [];
        const colCurrTopPositions = [];
        for (let i = 0; i < columns; i++) {
            colLeftPositions[i] = round(i * (colWidth + margin * 2), 1);
            colCurrTopPositions[i] = 0;
        }
        
        // Map through each photo, find column with smallest height and assign to photo's 'top'
        // Update that column's height with this photo's height
        const photosPositioned = photosWithSizes.map(photo => {
            const smallestCol = colCurrTopPositions.reduce((acc, item, i) => {
                acc = item < colCurrTopPositions[acc] ? i : acc;
                return acc;
            }, 0);
            
            photo.top = colCurrTopPositions[smallestCol];
            photo.left = colLeftPositions[smallestCol];
            colCurrTopPositions[smallestCol] = colCurrTopPositions[smallestCol] + photo.height + margin * 2;
            
            // Store the tallest col to use for gallery height because of abs positioned elements
            const tallestCol = colCurrTopPositions.reduce((acc, item, i) => {
                acc = item > colCurrTopPositions[acc] ? i : acc;
                return acc;
            }, 0);
            photo.containerHeight = colCurrTopPositions[tallestCol];
            return photo;
        });
        
        return photosPositioned;
    }
    
    // Waterfall Layout Implementation
    const WaterfallLayout = {
        instances: {},
        config: {
            waterfall_columns: 4,
            min_column_width: 250,
            waterfall_gap: 5,
            direction: 'row', // 'row' for justified layout, 'column' for waterfall layout
            targetRowHeight: 300, // Target height for row layout
            limitNodeSearch: null // Auto-calculated if null
        },
        
        setConfig: function(config) {
            if (config) {
                if (typeof config.waterfall_columns !== 'undefined') {
                    this.config.waterfall_columns = parseInt(config.waterfall_columns) || 4;
                }
                if (typeof config.min_column_width !== 'undefined') {
                    this.config.min_column_width = parseInt(config.min_column_width) || 250;
                }
                if (typeof config.waterfall_gap !== 'undefined') {
                    this.config.waterfall_gap = parseInt(config.waterfall_gap) || 5;
                }
                if (typeof config.direction !== 'undefined') {
                    this.config.direction = config.direction === 'column' ? 'column' : 'row';
                }
                if (typeof config.targetRowHeight !== 'undefined') {
                    this.config.targetRowHeight = parseInt(config.targetRowHeight) || 300;
                }
                if (typeof config.limitNodeSearch !== 'undefined') {
                    this.config.limitNodeSearch = config.limitNodeSearch === null ? null : parseInt(config.limitNodeSearch);
                }
            }
        },
        
        init: function(containerSelector, customColumns) {
            const $container = $(containerSelector);
            if ($container.length === 0) return;
            
            const instanceId = containerSelector;
            if (!this.instances[instanceId]) {
                this.instances[instanceId] = {
                    container: $container,
                    resizeObserver: null,
                    resizeTimer: null,
                    isProcessing: false,
                    customColumns: null
                };
            }
            
            const instance = this.instances[instanceId];
            if (typeof customColumns !== 'undefined' && customColumns !== null) {
                instance.customColumns = parseInt(customColumns);
            }
            
            // Add layout direction class to container
            const direction = this.config.direction || 'row';
            $container.removeClass('row-layout column-layout');
            $container.addClass(direction + '-layout');
            $container.attr('data-layout', direction);
            
            this.processLayout(instance);
            this.setupResizeObserver(instance);
        },
        
        processLayout: function(instance) {
            if (instance.isProcessing) return;
            instance.isProcessing = true;
            
            const $container = instance.container;
            const $items = $container.find('.waterfall-item');
            
            if ($items.length === 0) {
                instance.isProcessing = false;
                return;
            }
            
            // Wait for container to have width
            // Use the container's actual width, but ensure it uses full viewport width if container is constrained
            let containerWidth = $container.width();
            if (containerWidth === 0) {
                setTimeout(() => {
                    instance.isProcessing = false;
                    this.processLayout(instance);
                }, 100);
                return;
            }
            
            // If container width is less than viewport width, use viewport width minus padding
            const viewportWidth = window.innerWidth || document.documentElement.clientWidth;
            const containerPadding = parseInt($container.css('padding-left')) + parseInt($container.css('padding-right')) || 0;
            const availableWidth = viewportWidth - containerPadding;
            
            // Use the larger of container width or available viewport width
            if (availableWidth > containerWidth) {
                containerWidth = availableWidth;
            }
            
            // Calculate number of columns
            const margin = this.config.waterfall_gap || 5;
            const minColWidth = window.innerWidth <= 768 ? 150 : (instance.customColumns ? 
                Math.floor(containerWidth / instance.customColumns) : this.config.min_column_width || 250);
            
            let columns;
            if (instance.customColumns) {
                // Use custom column count if set
                columns = instance.customColumns;
                if (columns < 2) columns = 2;
                if (columns > 10) columns = 10;
            } else {
                // Auto-calculate based on container width and min column width
                columns = Math.floor(containerWidth / minColWidth);
                if (columns < 2) columns = 2;
                // Use configured max columns or default to 6
                const maxColumns = this.config.waterfall_columns || 6;
                if (columns > maxColumns) columns = maxColumns;
            }
            
            // Collect photo data
            const photos = [];
            const $photoElements = [];
            
            $items.each(function(index) {
                const $item = $(this);
                const $img = $item.find('img');
                
                // Get dimensions
                let width = parseFloat($item.data('width')) || 0;
                let height = parseFloat($item.data('height')) || 0;
                
                // If data attributes don't exist, try to get from image
                if (width === 0 || height === 0) {
                    if ($img.length > 0 && $img[0].naturalWidth > 0 && $img[0].naturalHeight > 0) {
                        width = $img[0].naturalWidth;
                        height = $img[0].naturalHeight;
                    } else {
                        // Use default aspect ratio
                        width = 400;
                        height = 300;
                    }
                }
                
                photos.push({
                    index: index,
                    width: width,
                    height: height,
                    src: $img.attr('src') || $img.data('src') || '',
                    key: $item.data('image-id') || $item.data('category-id') || index
                });
                
                $photoElements.push($item);
            });
            
            // Wait for all images to load before computing layout
            let loadedCount = 0;
            const totalImages = photos.length;
            
            if (totalImages === 0) {
                instance.isProcessing = false;
                return;
            }
            
            const checkAndLayout = () => {
                loadedCount++;
                if (loadedCount === totalImages) {
                    // All images loaded, compute layout
                    setTimeout(() => {
                        this.applyLayout(instance, photos, $photoElements, columns, margin, containerWidth);
                    }, 50);
                }
            };
            
            // Check each image - but don't wait if images are already loaded
            let imagesToWait = 0;
            let imagesLoaded = 0;
            
            $items.each(function(index) {
                const $img = $(this).find('img');
                if ($img.length > 0) {
                    if ($img[0].complete && $img[0].naturalWidth > 0) {
                        // Image already loaded
                        if ($img[0].naturalWidth > 0) {
                            photos[index].width = $img[0].naturalWidth;
                            photos[index].height = $img[0].naturalHeight;
                        }
                        imagesLoaded++;
                    } else {
                        // Need to wait for image
                        imagesToWait++;
                        $img.one('load', function() {
                            if (this.naturalWidth > 0) {
                                photos[index].width = this.naturalWidth;
                                photos[index].height = this.naturalHeight;
                            }
                            imagesLoaded++;
                            if (imagesLoaded === totalImages) {
                                setTimeout(() => {
                                    WaterfallLayout.applyLayout(instance, photos, $photoElements, columns, margin, containerWidth);
                                }, 50);
                            }
                        });
                        $img.one('error', function() {
                            imagesLoaded++;
                            if (imagesLoaded === totalImages) {
                                setTimeout(() => {
                                    WaterfallLayout.applyLayout(instance, photos, $photoElements, columns, margin, containerWidth);
                                }, 50);
                            }
                        });
                    }
                } else {
                    imagesLoaded++;
                }
            });
            
            // If all images are already loaded, layout immediately
            if (imagesLoaded === totalImages && imagesToWait === 0) {
                setTimeout(() => {
                    WaterfallLayout.applyLayout(instance, photos, $photoElements, columns, margin, containerWidth);
                }, 50);
            }
        },
        
        applyLayout: function(instance, photos, $photoElements, columns, margin, containerWidth) {
            const direction = this.config.direction || 'row';
            let photosPositioned;
            let containerHeight = 0;
            
            if (direction === 'row') {
                // Use row layout (justified layout)
                const targetRowHeight = this.config.targetRowHeight || 300;
                let limitNodeSearch = this.config.limitNodeSearch;
                
                // Auto-calculate limitNodeSearch if not set
                if (limitNodeSearch === null || limitNodeSearch === undefined) {
                    limitNodeSearch = 2;
                    if (containerWidth >= 450) {
                        limitNodeSearch = findIdealNodeSearch(targetRowHeight, containerWidth);
                    }
                }
                
                photosPositioned = computeRowLayout(photos, containerWidth, targetRowHeight, limitNodeSearch, margin);
                
                // Apply positions to DOM elements for row layout
                let currentLeft = margin;
                let currentTop = 0;
                let lastTop = -1;
                
                photosPositioned.forEach((photo, index) => {
                    const $item = $photoElements[photo.index];
                    if ($item && $item.length > 0) {
                        // Reset left position when starting a new row
                        if (lastTop !== -1 && photo.top !== lastTop) {
                            currentLeft = margin;
                        }
                        
                        $item.css({
                            'position': 'absolute',
                            'left': currentLeft + 'px',
                            'top': photo.top + 'px',
                            'width': photo.width + 'px',
                            'height': photo.height + 'px',
                            'opacity': '1',
                            'visibility': 'visible'
                        });
                        
                        const $img = $item.find('img');
                        $img.css({
                            'width': '100%',
                            'height': '100%',
                            'object-fit': 'cover',
                            'display': 'block'
                        });
                        
                        // Update left position for next photo
                        currentLeft += photo.width + margin * 2;
                        lastTop = photo.top;
                        
                        // Track container height
                        const photoBottom = photo.top + photo.height;
                        if (photoBottom > containerHeight) {
                            containerHeight = photoBottom;
                        }
                    }
                });
            } else {
                // Use column layout (waterfall layout)
                photosPositioned = computeColumnLayout(photos, columns, containerWidth, margin);
                
                // Apply positions to DOM elements for column layout
                photosPositioned.forEach((photo, index) => {
                    const $item = $photoElements[photo.index];
                    if ($item && $item.length > 0) {
                        $item.css({
                            'position': 'absolute',
                            'left': photo.left + 'px',
                            'top': photo.top + 'px',
                            'width': photo.width + 'px',
                            'opacity': '1',
                            'visibility': 'visible'
                        });
                        
                        const $img = $item.find('img');
                        $img.css({
                            'width': '100%',
                            'height': 'auto',
                            'display': 'block'
                        });
                    }
                });
                
                // Set container height from column layout
                containerHeight = photosPositioned.length > 0 
                    ? photosPositioned[photosPositioned.length - 1].containerHeight 
                    : 0;
            }
            
            // Set container height
            instance.container.css('height', containerHeight + 'px');
            
            instance.isProcessing = false;
        },
        
        setupResizeObserver: function(instance) {
            // Use ResizeObserver if available, otherwise fall back to window resize
            if (window.ResizeObserver) {
                if (instance.resizeObserver) {
                    instance.resizeObserver.disconnect();
                }
                
                instance.resizeObserver = new ResizeObserver(entries => {
                    if (entries.length > 0) {
                        const newWidth = entries[0].contentRect.width;
                        clearTimeout(instance.resizeTimer);
                        instance.resizeTimer = setTimeout(() => {
                            this.processLayout(instance);
                        }, 250);
                    }
                });
                
                instance.resizeObserver.observe(instance.container[0]);
            } else {
                // Fallback to window resize
                $(window).off('resize.waterfall-' + instance.container.attr('id'));
                $(window).on('resize.waterfall-' + instance.container.attr('id'), () => {
                    clearTimeout(instance.resizeTimer);
                    instance.resizeTimer = setTimeout(() => {
                        this.processLayout(instance);
                    }, 250);
                });
            }
        },
        
        destroy: function(containerSelector) {
            const instanceId = containerSelector;
            if (this.instances[instanceId]) {
                const instance = this.instances[instanceId];
                if (instance.resizeObserver) {
                    instance.resizeObserver.disconnect();
                }
                clearTimeout(instance.resizeTimer);
                $(window).off('resize.waterfall-' + instance.container.attr('id'));
                delete this.instances[instanceId];
            }
        }
    };
    
    // Mobile Gesture Support
    const MobileGestures = {
        init: function() {
            if (window.innerWidth > 768) return; // Desktop only
            
            const $image = $('#theImage img');
            const $container = $('#theImage');
            if ($container.length === 0) return;
            
            let startX = 0;
            let startY = 0;
            let currentX = 0;
            let currentY = 0;
            let isSwiping = false;
            const minSwipeDistance = 50;
            
            // Create swipe indicator
            const $swipeIndicator = $('<div class="swipe-indicator"><i class="fas fa-arrow-right"></i></div>');
            $('body').append($swipeIndicator);
            
            // Touch start
            $container.on('touchstart', function(e) {
                const touch = e.originalEvent.touches[0];
                startX = touch.clientX;
                startY = touch.clientY;
                isSwiping = true;
            });
            
            // Touch move
            $container.on('touchmove', function(e) {
                if (!isSwiping) return;
                
                const touch = e.originalEvent.touches[0];
                currentX = touch.clientX;
                currentY = touch.clientY;
                
                const deltaX = currentX - startX;
                const deltaY = currentY - startY;
                
                // If primarily horizontal swipe
                if (Math.abs(deltaX) > Math.abs(deltaY) && Math.abs(deltaX) > 10) {
                    e.preventDefault();
                    
                    // Show swipe indicator
                    if (deltaX > 0) {
                        $swipeIndicator.find('i').removeClass('fa-arrow-right').addClass('fa-arrow-left');
                    } else {
                        $swipeIndicator.find('i').removeClass('fa-arrow-left').addClass('fa-arrow-right');
                    }
                    $swipeIndicator.addClass('active');
                }
            });
            
            // Touch end
            $container.on('touchend', function(e) {
                if (!isSwiping) return;
                
                const deltaX = currentX - startX;
                const deltaY = currentY - startY;
                
                // Hide indicator
                $swipeIndicator.removeClass('active');
                
                // Check if swipe meets threshold
                if (Math.abs(deltaX) > Math.abs(deltaY) && Math.abs(deltaX) > minSwipeDistance) {
                    if (deltaX > 0) {
                        // Swipe right - previous
                        $('#navigationButtons a#navPrevPicture i').click();
                    } else {
                        // Swipe left - next
                        $('#navigationButtons a#navNextPicture i').click();
                    }
                }
                
                isSwiping = false;
                startX = 0;
                startY = 0;
                currentX = 0;
                currentY = 0;
            });
            
            // Double tap to zoom
            let lastTap = 0;
            $image.on('touchend', function(e) {
                const currentTime = new Date().getTime();
                const tapLength = currentTime - lastTap;
                
                if (tapLength < 300 && tapLength > 0) {
                    // Double tap
                    e.preventDefault();
                    const $img = $(this);
                    const transform = $img.css('transform');
                    if (transform === 'none' || transform === 'matrix(1, 0, 0, 1, 0, 0)') {
                        $img.css({
                            'transform': 'scale(2)',
                            'transition': 'transform 0.3s ease',
                            'transform-origin': 'center center'
                        });
                    } else {
                        $img.css({
                            'transform': 'scale(1)',
                            'transition': 'transform 0.3s ease'
                        });
                    }
                }
                lastTap = currentTime;
            });
        }
    };
    
    // Infinite Scroll / Lazy Loading Implementation
    const InfiniteScroll = {
        isLoading: false,
        hasMore: true,
        nextUrl: null,
        currentPage: 1,
        
        init: function() {
            // Only enable infinite scroll on thumbnail pages, not category/album selection pages
            // Check multiple possible selectors for thumbnails
            const checkThumbnails = () => {
                const $thumbnails = $('#waterfall-thumbnails, #thumbnails, ul#thumbnails, .thumbnails, #thumbnails_block1, #thumbnails_block2');
                const $categories = $('#album-grid, #waterfall-categories, .album-grid-container');
                
                // Check if thumbnails container has actual items
                let hasThumbnailItems = false;
                $thumbnails.each(function() {
                    if ($(this).find('.waterfall-item, li, img').length > 0) {
                        hasThumbnailItems = true;
                        return false; // break
                    }
                });
                
                // If only categories are present (no thumbnails), don't initialize
                if ($categories.length > 0 && !hasThumbnailItems) {
                    return; // This is normal on category pages
                }
                
                // If no thumbnails container found or no items, don't initialize
                if (!hasThumbnailItems) {
                    return; // This is normal on empty pages or category pages
                }
                
                // Found thumbnails, continue initialization
                this.findNextPageUrl();
                
                // Hide pagination if we have infinite scroll enabled
                if (this.hasMore) {
                    $('body').addClass('infinite-scroll-active');
                    $('.pagination, .navigationBar').hide();
                }
                
                // Setup scroll listener
                this.setupScrollListener();
                
                // Setup Intersection Observer for better performance
                this.setupIntersectionObserver();
            };
            
            // Try immediately
            checkThumbnails();
            
            // Also try after delays to catch late-loading content
            setTimeout(() => checkThumbnails(), 100);
            setTimeout(() => checkThumbnails(), 500);
            setTimeout(() => checkThumbnails(), 1000);
        },
        
        findNextPageUrl: function() {
            // Look for next page link in navigation - check multiple selectors
            const $nextLink = $('.navigationBar a[rel="next"], .pagination a[rel="next"], .pagination .next a, .pagination a:contains("下一页"), .pagination a:contains("Next")');
            if ($nextLink.length > 0) {
                this.nextUrl = $nextLink.attr('href');
                this.hasMore = true;
                // Found next page URL
            } else {
                // Check if we're on last page - look for disabled next button
                const $disabledNext = $('.pagination .page-link.disabled:has(.fa-forward), .navigationBar .disabled');
                if ($disabledNext.length > 0) {
                    this.hasMore = false;
                    // No more pages
                } else {
                    // If no pagination at all, assume no more pages
                    const $pagination = $('.pagination, .navigationBar');
                    if ($pagination.length === 0) {
                        this.hasMore = false;
                    } else {
                        // Try to find if there's a "last" link
                        const $lastLink = $('.pagination a[rel="last"]');
                        if ($lastLink.length > 0) {
                            // There's a last page, but no next - we might be on last page
                            const $activePage = $('.pagination .active, .pagination .page-link.active');
                            if ($activePage.length > 0) {
                                // Check if we can find a next page number
                                const currentPage = parseInt($activePage.text()) || 1;
                                const $allPages = $('.pagination .page-link:not(.disabled)');
                                let maxPage = currentPage;
                                $allPages.each(function() {
                                    const pageNum = parseInt($(this).text());
                                    if (pageNum && pageNum > maxPage) {
                                        maxPage = pageNum;
                                    }
                                });
                                this.hasMore = currentPage < maxPage;
                            } else {
                                this.hasMore = false;
                            }
                        } else {
                            this.hasMore = false;
                        }
                    }
                }
            }
        },
        
        setupScrollListener: function() {
            let scrollTimer = null;
            const self = this;
            
            $(window).on('scroll.infinite', function() {
                clearTimeout(scrollTimer);
                scrollTimer = setTimeout(function() {
                    self.checkScrollPosition();
                }, 100);
            });
        },
        
        setupIntersectionObserver: function() {
            // Use Intersection Observer for better performance
            if (typeof IntersectionObserver === 'undefined') {
                return; // Fall back to scroll listener
            }
            
            const self = this;
            
            // Create a sentinel element at the bottom of the content
            let $sentinel = $('#infinite-scroll-sentinel');
            if ($sentinel.length === 0) {
                $sentinel = $('<div id="infinite-scroll-sentinel" style="height: 1px; visibility: hidden; position: absolute; bottom: 0;"></div>');
                const $content = $('#content');
                if ($content.length > 0) {
                    $content.css('position', 'relative');
                    $content.append($sentinel);
                } else {
                    $('body').append($sentinel);
                }
            }
            
            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(function(entry) {
                    if (entry.isIntersecting && self.hasMore && !self.isLoading) {
                        self.loadNextPage();
                    }
                });
            }, {
                rootMargin: '300px' // Start loading 300px before reaching the bottom
            });
            
            observer.observe($sentinel[0]);
            
            // Update sentinel position when content changes
            const updateSentinel = function() {
                const $container = $('#waterfall-thumbnails');
                if ($container.length > 0) {
                    const containerBottom = $container.offset().top + $container.outerHeight();
                    $sentinel.css({
                        'top': containerBottom + 'px',
                        'position': 'absolute'
                    });
                } else {
                    // Fallback: place at bottom of content div
                    const $content = $('#content');
                    if ($content.length > 0) {
                        const contentHeight = $content.outerHeight();
                        $sentinel.css({
                            'top': contentHeight + 'px',
                            'position': 'absolute'
                        });
                    }
                }
            };
            
            // Update on layout changes
            $(document).on('waterfall:layoutComplete', updateSentinel);
            $(document).on('waterfall:contentLoaded', updateSentinel);
            setTimeout(updateSentinel, 500);
            setTimeout(updateSentinel, 1500);
        },
        
        checkScrollPosition: function() {
            if (this.isLoading || !this.hasMore) return;
            
            const windowHeight = $(window).height();
            const scrollTop = $(window).scrollTop();
            const documentHeight = $(document).height();
            
            // Load when within 300px of bottom
            if (scrollTop + windowHeight >= documentHeight - 300) {
                this.loadNextPage();
            }
        },
        
        loadNextPage: function() {
            if (this.isLoading || !this.hasMore) return;
            
            // If no next URL, try to find it again
            if (!this.nextUrl) {
                this.findNextPageUrl();
                if (!this.nextUrl) {
                    this.hasMore = false;
                    return;
                }
            }
            
            this.isLoading = true;
            this.showLoadingIndicator();
            
            const self = this;
            const url = this.nextUrl;
            
            // Add AJAX parameter if not present
            let ajaxUrl = url;
            if (url.indexOf('rvts=') === -1) {
                ajaxUrl = url + (url.indexOf('?') === -1 ? '?' : '&') + 'rvts=1';
            }
            
            $.ajax({
                url: ajaxUrl,
                type: 'GET',
                dataType: 'html',
                success: function(html) {
                    self.appendContent(html);
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load next page:', error);
                    self.hideLoadingIndicator();
                    self.isLoading = false;
                }
            });
        },
        
        appendContent: function(html) {
            const self = this;
            const $newContent = $(html);
            
            // Find thumbnails or categories in the new content
            const $newThumbnails = $newContent.find('#waterfall-thumbnails .waterfall-item, #thumbnails .waterfall-item, #thumbnails li.gthumb, ul#thumbnails li.gthumb');
            const $newCategories = $newContent.find('#album-grid .album-item, #waterfall-categories .waterfall-item');
            
            // Get existing containers
            const $thumbnailsContainer = $('#waterfall-thumbnails');
            const $categoriesContainer = $('#album-grid, #waterfall-categories');
            
            // If containers don't exist, try to find them in new content
            if ($thumbnailsContainer.length === 0 && $newContent.find('#waterfall-thumbnails').length > 0) {
                const $newContainer = $newContent.find('#waterfall-thumbnails');
                $('#content').append($newContainer);
            } else if ($thumbnailsContainer.length > 0 && $newThumbnails.length > 0) {
                // Append new items to existing container
                $newThumbnails.each(function() {
                    const $item = $(this);
                    // Convert GThumb li to waterfall-item if needed
                    if ($item.hasClass('gthumb')) {
                        const $newItem = $('<div class="waterfall-item"></div>');
                        $newItem.html($item.html());
                        const $img = $item.find('img');
                        $newItem.attr('data-image-id', $item.find('a').attr('href') || '');
                        $newItem.attr('data-width', $img.attr('width') || $img.data('width') || '400');
                        $newItem.attr('data-height', $img.attr('height') || $img.data('height') || '300');
                        $newItem.attr('data-url', $item.find('a').attr('href') || '');
                        $thumbnailsContainer.append($newItem);
                    } else {
                        $thumbnailsContainer.append($item.clone());
                    }
                });
            }
            
            // Handle categories similarly
            if ($categoriesContainer.length > 0 && $newCategories.length > 0) {
                $newCategories.each(function() {
                    $categoriesContainer.append($(this).clone());
                });
            }
            
            // Update next URL from new content
            const $newNextLink = $newContent.find('.navigationBar a[rel="next"], .pagination a[rel="next"], .pagination .next a');
            if ($newNextLink.length > 0) {
                this.nextUrl = $newNextLink.attr('href');
                this.hasMore = true;
                console.log('Updated next URL:', this.nextUrl);
            } else {
                // Check if there's a next page
                const $pagination = $newContent.find('.navigationBar, .pagination');
                if ($pagination.length === 0 || $pagination.find('a[rel="next"]').length === 0) {
                    this.hasMore = false;
                    this.hideLoadingIndicator();
                    console.log('No more pages available');
                }
            }
            
            // Hide pagination if infinite scroll is working
            $('.pagination, .navigationBar').hide();
            
            // Reinitialize waterfall layout
            setTimeout(function() {
                initAllWaterfalls();
                self.hideLoadingIndicator();
                self.isLoading = false;
                
                // Update sentinel position
                setTimeout(function() {
                    const $sentinel = $('#infinite-scroll-sentinel');
                    if ($sentinel.length > 0) {
                        const $container = $('#waterfall-thumbnails');
                        if ($container.length > 0) {
                            const containerBottom = $container.offset().top + $container.outerHeight();
                            $sentinel.css({
                                'top': containerBottom + 'px',
                                'position': 'absolute'
                            });
                        }
                    }
                }, 200);
                
                // Trigger custom event
                $(document).trigger('waterfall:contentLoaded');
            }, 100);
        },
        
        showLoadingIndicator: function() {
            let $indicator = $('#infinite-scroll-loader');
            if ($indicator.length === 0) {
                $indicator = $('<div id="infinite-scroll-loader" style="text-align: center; padding: 20px; display: none;"><div class="spinner-border" role="status"><span class="sr-only">加载中...</span></div></div>');
                $('#content').append($indicator);
            }
            $indicator.show();
        },
        
        hideLoadingIndicator: function() {
            $('#infinite-scroll-loader').hide();
        }
    };
    
    // Make WaterfallLayout globally accessible for debugging
    window.WaterfallLayout = WaterfallLayout;
    window.InfiniteScroll = InfiniteScroll;
    
    // Initialize waterfall layout for a container
    function initWaterfall(selector) {
        const $container = $(selector);
        if ($container.length > 0) {
            const itemCount = $container.find('.waterfall-item').length;
            if (itemCount > 0) {
                console.log('Initializing waterfall for', selector, 'with', itemCount, 'items');
                // Destroy existing instance if any
                WaterfallLayout.destroy(selector);
                // Initialize new instance
                setTimeout(() => {
                    WaterfallLayout.init(selector);
                }, 50);
                return true;
            } else {
                // Container exists but no items yet - this is OK, don't log as error
                return false;
            }
        }
        // Container doesn't exist - this is OK if page doesn't have that content
        return false;
    }
    
    // Initialize all waterfalls
    function initAllWaterfalls() {
        // Only initialize waterfall for photos (thumbnails), not albums
        initWaterfall('#waterfall-thumbnails');
    }
    
    // Initialize when DOM is ready
    $(document).ready(function() {
        // Wait a bit for all templates to render
        setTimeout(function() {
            initAllWaterfalls();
        }, 100);
        
        // Function to force remove border-radius from waterfall images
        function forceRemoveBorderRadius() {
            $('.waterfall-img, .waterfall-item img').css({
                'border-radius': '0 !important',
                '-webkit-border-radius': '0 !important',
                '-moz-border-radius': '0 !important'
            });
        }
        
        // Also try after longer delays to catch late-loading content
        setTimeout(function() {
            initAllWaterfalls();
            forceRemoveBorderRadius();
        }, 500);
        setTimeout(function() {
            initAllWaterfalls();
            forceRemoveBorderRadius();
        }, 1000);
        setTimeout(function() {
            initAllWaterfalls();
            forceRemoveBorderRadius();
        }, 2000);
        
        // Initialize infinite scroll / lazy loading (only on thumbnail pages)
        setTimeout(function() {
            InfiniteScroll.init();
        }, 500);
        
        // Initialize mobile gestures
        MobileGestures.init();
        
        // Re-initialize on window resize
        $(window).on('resize', function() {
            MobileGestures.init();
            initAllWaterfalls();
        });
        
    // Use MutationObserver to watch for new content (for AJAX updates)
    if (window.MutationObserver) {
        const observer = new MutationObserver(function(mutations) {
            let shouldReinit = false;
            
            mutations.forEach(function(mutation) {
                if (mutation.addedNodes.length > 0) {
                    mutation.addedNodes.forEach(function(node) {
                        if (node.nodeType === 1) { // Element node
                            const $node = $(node);
                            if ($node.find('#waterfall-thumbnails').length > 0 ||
                                $node.is('#waterfall-thumbnails') ||
                                $node.find('.waterfall-item').length > 0) {
                                shouldReinit = true;
                            }
                        }
                    });
                }
            });
            
            if (shouldReinit) {
                setTimeout(initAllWaterfalls, 100);
            }
        });
            
            const $content = $('#content');
            if ($content.length > 0) {
                observer.observe($content[0], {
                    childList: true,
                    subtree: true
                });
            }
            
            // Also observe document body for full page changes
            observer.observe(document.body, {
                childList: true,
                subtree: true
            });
        }
        
        // Expose initAllWaterfalls globally so templates can call it
        window.initAllWaterfalls = initAllWaterfalls;
        
    // Listen for AJAX complete events (for Piwigo's AJAX pagination)
    $(document).ajaxComplete(function() {
        setTimeout(initAllWaterfalls, 100);
    });
        
        // Also listen for Piwigo-specific events if available
        if (typeof window.piwigo !== 'undefined') {
            $(window).on('piwigo:thumbnailsLoaded', function() {
                setTimeout(initAllWaterfalls, 100);
            });
        }
        
        // Page Loader
        function initPageLoader() {
            // Add loading class to body
            $('body').addClass('loading');
            
            // Preload images
            const images = document.querySelectorAll('img[data-src], .waterfall-img');
            let loadedCount = 0;
            const totalImages = images.length;
            
            if (totalImages === 0) {
                // No images to load, remove loader immediately
                setTimeout(function() {
                    $('body').removeClass('loading').addClass('loaded');
                }, 300);
                return;
            }
            
            images.forEach(function(img) {
                const image = new Image();
                image.onload = image.onerror = function() {
                    loadedCount++;
                    if (loadedCount >= totalImages) {
                        setTimeout(function() {
                            $('body').removeClass('loading').addClass('loaded');
                        }, 500);
                    }
                };
                image.src = img.src || img.getAttribute('data-src') || img.getAttribute('src');
            });
        }
        
        // Initialize page loader
        initPageLoader();
    });
    
})(jQuery);
