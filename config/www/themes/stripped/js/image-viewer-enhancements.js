/**
 * Image Viewer Enhancements
 * Combines Diagonal Slideshow effects and scanning effects for better image viewing
 */

(function($) {
    'use strict';

    const ImageViewerEnhancements = {
        init: function() {
            // Only run on picture pages
            if ($('#thePicturePage').length === 0) return;

            this.initImageTransitions();
            this.initScanningEffect();
            this.initKeyboardNavigation();
            this.initSwipeGestures();
        },

        // Smooth image transitions with diagonal effect
        initImageTransitions: function() {
            const $image = $('#theMainImage');
            if ($image.length === 0) return;

            // Add transition wrapper
            if ($image.parent('#theImg').find('.image-transition-wrapper').length === 0) {
                $image.wrap('<div class="image-transition-wrapper"></div>');
            }

            const $wrapper = $image.parent('.image-transition-wrapper');
            
            // Preload next/previous images
            this.preloadAdjacentImages();

            // Add diagonal slide effect on navigation
            $(document).on('click', '.img_nav', function(e) {
                const $link = $(this);
                const href = $link.attr('href');
                
                if (!href) return;

                // Create diagonal transition
                $wrapper.addClass('diagonal-transition');
                
                // After transition, navigate
                setTimeout(() => {
                    window.location.href = href;
                }, 300);
            });
        },

        // Preload adjacent images for smooth transitions
        preloadAdjacentImages: function() {
            const $prevLink = $('.img_prev');
            const $nextLink = $('.img_next');
            
            const preloadImage = (url) => {
                if (!url) return;
                const img = new Image();
                img.src = url;
            };

            if ($prevLink.length > 0) {
                const prevUrl = $prevLink.attr('href');
                if (prevUrl) preloadImage(prevUrl);
            }

            if ($nextLink.length > 0) {
                const nextUrl = $nextLink.attr('href');
                if (nextUrl) preloadImage(nextUrl);
            }
        },

        // Scanning effect with depth map
        initScanningEffect: function() {
            const $image = $('#theMainImage');
            if ($image.length === 0) return;

            // Add scanning overlay
            const $scanOverlay = $('<div class="scan-overlay"></div>');
            $image.parent().append($scanOverlay);

            // Create scanning line animation
            let scanning = false;
            const scan = () => {
                if (scanning) return;
                scanning = true;

                $scanOverlay.css({
                    'background': 'linear-gradient(to bottom, transparent 0%, rgba(53, 53, 204, 0.3) 50%, transparent 100%)',
                    'animation': 'scanLine 2s ease-in-out'
                });

                setTimeout(() => {
                    $scanOverlay.css('animation', '');
                    scanning = false;
                }, 2000);
            };

            // Scan on image load
            $image.on('load', scan);

            // Scan on mouse move (with throttle)
            let scanTimer = null;
            $image.on('mousemove', function(e) {
                clearTimeout(scanTimer);
                scanTimer = setTimeout(() => {
                    const rect = this.getBoundingClientRect();
                    const y = ((e.clientY - rect.top) / rect.height) * 100;
                    
                    $scanOverlay.css({
                        'background': `linear-gradient(to bottom, transparent ${y - 5}%, rgba(53, 53, 204, 0.4) ${y}%, transparent ${y + 5}%)`,
                        'opacity': '1'
                    });

                    setTimeout(() => {
                        $scanOverlay.css('opacity', '0');
                    }, 300);
                }, 50);
            });
        },

        // Enhanced keyboard navigation
        initKeyboardNavigation: function() {
            $(document).on('keydown', function(e) {
                // Don't interfere with input fields
                if ($(e.target).is('input, textarea')) return;

                switch(e.key) {
                    case 'ArrowLeft':
                        e.preventDefault();
                        $('.img_prev').first().click();
                        break;
                    case 'ArrowRight':
                        e.preventDefault();
                        $('.img_next').first().click();
                        break;
                    case 'Escape':
                        // Go back to thumbnails if available
                        const $upLink = $('.cat_up');
                        if ($upLink.length > 0) {
                            window.location.href = $upLink.attr('href');
                        }
                        break;
                }
            });
        },

        // Swipe gestures for mobile
        initSwipeGestures: function() {
            const $image = $('#theMainImage');
            if ($image.length === 0) return;

            let startX = 0;
            let startY = 0;
            let isSwiping = false;
            const minSwipeDistance = 50;

            $image.on('touchstart', function(e) {
                const touch = e.originalEvent.touches[0];
                startX = touch.clientX;
                startY = touch.clientY;
                isSwiping = true;
            });

            $image.on('touchmove', function(e) {
                if (!isSwiping) return;
                e.preventDefault();
            });

            $image.on('touchend', function(e) {
                if (!isSwiping) return;

                const touch = e.originalEvent.changedTouches[0];
                const deltaX = touch.clientX - startX;
                const deltaY = touch.clientY - startY;

                // Check if primarily horizontal swipe
                if (Math.abs(deltaX) > Math.abs(deltaY) && Math.abs(deltaX) > minSwipeDistance) {
                    if (deltaX > 0) {
                        // Swipe right - previous
                        $('.img_prev').first().click();
                    } else {
                        // Swipe left - next
                        $('.img_next').first().click();
                    }
                }

                isSwiping = false;
            });
        }
    };

    // Image Zoom Enhancement
    const ImageZoom = {
        init: function() {
            const $image = $('#theMainImage');
            if ($image.length === 0) return;

            let isZoomed = false;
            let zoomLevel = 2;

            // Double click to zoom
            $image.on('dblclick', function(e) {
                e.preventDefault();
                
                if (!isZoomed) {
                    // Zoom in
                    const rect = this.getBoundingClientRect();
                    const x = ((e.clientX - rect.left) / rect.width) * 100;
                    const y = ((e.clientY - rect.top) / rect.height) * 100;

                    $(this).css({
                        'transform': `scale(${zoomLevel})`,
                        'transform-origin': `${x}% ${y}%`,
                        'transition': 'transform 0.3s ease',
                        'cursor': 'zoom-out'
                    });
                    isZoomed = true;
                } else {
                    // Zoom out
                    $(this).css({
                        'transform': 'scale(1)',
                        'transform-origin': 'center center',
                        'transition': 'transform 0.3s ease',
                        'cursor': 'zoom-in'
                    });
                    isZoomed = false;
                }
            });

            // Mouse wheel zoom
            $image.on('wheel', function(e) {
                if (!e.ctrlKey && !e.metaKey) return;
                e.preventDefault();

                const delta = e.originalEvent.deltaY > 0 ? -0.1 : 0.1;
                zoomLevel = Math.max(1, Math.min(5, zoomLevel + delta));

                const rect = this.getBoundingClientRect();
                const x = ((e.clientX - rect.left) / rect.width) * 100;
                const y = ((e.clientY - rect.top) / rect.height) * 100;

                $(this).css({
                    'transform': `scale(${zoomLevel})`,
                    'transform-origin': `${x}% ${y}%`,
                    'transition': 'transform 0.1s ease'
                });

                if (zoomLevel > 1) {
                    isZoomed = true;
                    $(this).css('cursor', 'zoom-out');
                } else {
                    isZoomed = false;
                    $(this).css('cursor', 'zoom-in');
                }
            });
        }
    };

    // Initialize when DOM is ready
    $(document).ready(function() {
        ImageViewerEnhancements.init();
        ImageZoom.init();
    });

    // Expose globally
    window.ImageViewerEnhancements = ImageViewerEnhancements;
    window.ImageZoom = ImageZoom;

})(jQuery);

