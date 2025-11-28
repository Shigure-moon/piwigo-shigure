/**
 * Banner Text with Shaders-on-Scroll Style
 * Large text effect inspired by shaders-on-scroll
 * Enhanced with GSAP animations and scroll effects
 */

(function($) {
    'use strict';

    const BannerShaderText = {
        init: function() {
            const $banner = $('#theHeader.content-center');
            if ($banner.length === 0) {
                // Try again later if banner not found
                setTimeout(() => {
                    this.init();
                }, 500);
                return;
            }

            this.wrapBannerText($banner);
            
            // Initialize scroll fade after text is wrapped
            setTimeout(() => {
                this.initScrollFade();
            }, 200);
        },

        // Wrap banner text in shaders-on-scroll style structure
        wrapBannerText: function($banner) {
            // Check if already processed - more strict check
            if ($banner.find('.banner-shader-text').length > 0) {
                // Already processed, just ensure styles are applied
                $banner.find('.banner-title-text').css({
                    'font-size': 'min(15.3vw, 10.2rem)',
                    'text-align': 'left'
                });
                return;
            }

            // Get all text content - preserve original HTML structure
            let html = $banner.html();
            if (!html || html.trim() === '') return;
            
            // Clear any existing content first to prevent duplication
            $banner.empty();

            // Create wrapper structure
            const $wrapper = $('<div class="banner-shader-text"></div>');
            const $titleWrapper = $('<div class="banner-title-wrapper"></div>');
            
            // Try multiple methods to split text
            let lines = [];
            
            // Method 0: Check for existing h1/h2 and p tags (preserve structure)
            const $tempHtml = $('<div>').html(html);
            const $existingTitle = $tempHtml.find('h1.banner-title-text, h2.banner-title-text, .banner-title-text');
            const $existingSubtitle = $tempHtml.find('p.banner-subtitle-text, .banner-subtitle-text');
            
            if ($existingTitle.length > 0 && $existingSubtitle.length > 0) {
                lines = [
                    $existingTitle.text().trim(),
                    $existingSubtitle.text().trim()
                ].filter(line => line && line.length > 0);
            }
            
            // Method 1: Check for <br> tags
            if (lines.length <= 1 && (html.indexOf('<br') !== -1 || html.indexOf('<BR') !== -1)) {
                lines = html.split(/<br\s*\/?>/i).map(line => {
                    const $line = $('<div>').html(line);
                    return $line.text().trim();
                }).filter(line => line && line.length > 0);
            }
            
            // Method 2: Check for actual newlines in text
            if (lines.length <= 1) {
                const $temp = $('<div>').html(html);
                const text = $temp.text();
                if (text.indexOf('\n') !== -1) {
                    lines = text.split('\n').map(line => line.trim()).filter(line => line && line.length > 0);
                }
            }
            
            // Method 3: Try to split by common separators
            if (lines.length <= 1) {
                const $temp = $('<div>').html(html);
                const text = $temp.text().trim();
                const separators = ['\n', '•', '·', '—', '—', '|'];
                for (let sep of separators) {
                    if (text.indexOf(sep) !== -1) {
                        lines = text.split(sep).map(line => line.trim()).filter(line => line && line.length > 0);
                        if (lines.length > 1) break;
                    }
                }
            }
            
            // Method 4: Intelligent splitting for Chinese text
            if (lines.length <= 1) {
                const $temp = $('<div>').html(html);
                const text = $temp.text().trim();
                // Split by common Chinese break points
                const breakPoints = ['图库', '相册', '欢迎', 'Piwigo', '的', '崭新'];
                for (let i = 0; i < breakPoints.length; i++) {
                    const index = text.indexOf(breakPoints[i]);
                    if (index > 0 && index < text.length - 5) {
                        lines = [
                            text.substring(0, index + breakPoints[i].length).trim(),
                            text.substring(index + breakPoints[i].length).trim()
                        ];
                        break;
                    }
                }
            }
            
            // If still single line, use it as is
            if (lines.length === 0) {
                const $temp = $('<div>').html(html);
                const text = $temp.text().trim();
                if (text) lines = [text];
            }
            
            // Create title structure like shaders-on-scroll
            if (lines.length > 0) {
                // Main title (large text) - like section__title-text
                const $titleText = $('<h2 class="banner-title-text"></h2>');
                $titleText.text(lines[0]);
                $titleWrapper.append($titleText);
                
                // Subtitle if exists - like section__title-arrow
                if (lines.length > 1) {
                    const $subtitle = $('<p class="banner-subtitle-text"></p>');
                    $subtitle.text(lines[1]);
                    $titleWrapper.append($subtitle);
                }
            }

            $wrapper.append($titleWrapper);
            $banner.html($wrapper);
            
            // Force apply large font size and left alignment immediately
            const $titleText = $banner.find('.banner-title-text');
            const $subtitleText = $banner.find('.banner-subtitle-text');
            
            if ($titleText.length > 0) {
                $titleText.css({
                    'font-size': 'min(15.3vw, 10.2rem)',
                    'font-weight': '500',
                    'line-height': '1.2',
                    'letter-spacing': '0.05ch',
                    'text-transform': 'none',
                    'text-align': 'left',
                    'opacity': '0.9',
                    'transform': 'none',
                    'display': 'block',
                    'width': '100%',
                    'margin': '0',
                    'padding': '0'
                });
            }
            
            if ($subtitleText.length > 0) {
                $subtitleText.css({
                    'font-size': 'min(7.65vw, 5.1rem)',
                    'text-align': 'left',
                    'opacity': '0.9',
                    'transform': 'none',
                    'display': 'block',
                    'width': '100%'
                });
            }
            
            // Ensure wrapper is left aligned
            $banner.find('.banner-shader-text, .banner-title-wrapper').css({
                'text-align': 'left',
                'align-items': 'flex-start',
                'justify-content': 'flex-start'
            });
        },

        // Scroll fade effect - banner becomes darker and less visible on scroll
        initScrollFade: function() {
            const $banner = $('.page-header');
            if ($banner.length === 0) {
                console.log('Banner not found for scroll fade');
                return;
            }

            let ticking = false;

            const updateScrollFade = () => {
                const scrollTop = $(window).scrollTop();
                const bannerHeight = $banner.outerHeight() || window.innerHeight;
                
                // Calculate scroll progress (0 to 1) within banner area
                // Start fading immediately when scrolling
                const fadeStart = 0;
                const fadeEnd = bannerHeight * 0.6; // Fade completes at 60% of banner height
                
                let scrollProgress = 0;
                if (fadeEnd > 0) {
                    scrollProgress = Math.min(1, Math.max(0, 
                        (scrollTop - fadeStart) / fadeEnd
                    ));
                }
                
                // Calculate opacity (from 1 to 0.1 - almost invisible)
                const opacity = Math.max(0.1, 1 - scrollProgress * 0.9);
                
                // Calculate brightness (from 100% to 20% - very dark)
                const brightness = Math.max(20, 100 - scrollProgress * 80);
                
                // Apply effects to banner text container
                const $bannerText = $('.banner-shader-text');
                if ($bannerText.length > 0) {
                    $bannerText.css({
                        'opacity': opacity,
                        'filter': `brightness(${brightness}%)`,
                        '-webkit-filter': `brightness(${brightness}%)`,
                        'transition': 'opacity 0.2s ease-out, filter 0.2s ease-out'
                    });
                }
                
                // Apply to individual text elements
                const $titleText = $('.banner-title-text');
                const $subtitleText = $('.banner-subtitle-text');
                
                if ($titleText.length > 0) {
                    $titleText.css({
                        'opacity': opacity,
                        'filter': `brightness(${brightness}%)`,
                        '-webkit-filter': `brightness(${brightness}%)`,
                        'transition': 'opacity 0.2s ease-out, filter 0.2s ease-out'
                    });
                }
                
                if ($subtitleText.length > 0) {
                    $subtitleText.css({
                        'opacity': opacity,
                        'filter': `brightness(${brightness}%)`,
                        '-webkit-filter': `brightness(${brightness}%)`,
                        'transition': 'opacity 0.2s ease-out, filter 0.2s ease-out'
                    });
                }
                
                // Also darken the background image
                const $bannerImage = $('.page-header-image');
                if ($bannerImage.length > 0) {
                    const imageOpacity = Math.max(0.3, 1 - scrollProgress * 0.7);
                    const imageBrightness = Math.max(30, 100 - scrollProgress * 70);
                    $bannerImage.css({
                        'opacity': imageOpacity,
                        'filter': `brightness(${imageBrightness}%)`,
                        '-webkit-filter': `brightness(${imageBrightness}%)`,
                        'transition': 'opacity 0.2s ease-out, filter 0.2s ease-out'
                    });
                }

                ticking = false;
            };

            // Use both scroll and scroll.banner events
            $(window).off('scroll.banner-fade').on('scroll.banner-fade', function() {
                if (!ticking) {
                    window.requestAnimationFrame(updateScrollFade);
                    ticking = true;
                }
            });

            // Also listen to regular scroll as fallback
            $(window).on('scroll', function() {
                if (!ticking) {
                    window.requestAnimationFrame(updateScrollFade);
                    ticking = true;
                }
            });

            // Initial call
            setTimeout(() => {
                updateScrollFade();
            }, 100);
            
            // Also call after a delay to ensure elements exist
            setTimeout(() => {
                updateScrollFade();
            }, 500);
            setTimeout(() => {
                updateScrollFade();
            }, 1000);
        },

        // Enter animation like shaders-on-scroll
        initEnterAnimation: function() {
            const $titleText = $('.banner-title-text');
            const $subtitleText = $('.banner-subtitle-text');
            
            if ($titleText.length === 0) return;

            // Use jQuery animate for compatibility (GSAP would be better but requires library)
            setTimeout(() => {
                $titleText.css({
                    'transition': 'opacity 1.6s cubic-bezier(0.19, 1, 0.22, 1), transform 1.6s cubic-bezier(0.19, 1, 0.22, 1)',
                    'opacity': '1',
                    'transform': 'translateY(0)'
                });
                
                if ($subtitleText.length > 0) {
                    setTimeout(() => {
                        $subtitleText.css({
                            'transition': 'opacity 1.6s cubic-bezier(0.19, 1, 0.22, 1), transform 1.6s cubic-bezier(0.19, 1, 0.22, 1)',
                            'opacity': '0.9',
                            'transform': 'translateY(0)'
                        });
                    }, 200);
                }
            }, 300);
        },

        // Scroll-based animation effect
        initScrollEffect: function() {
            const $banner = $('.page-header');
            if ($banner.length === 0) return;

            // Create progress line like shaders-on-scroll
            let $progressLine = $('.banner-progress-line');
            if ($progressLine.length === 0) {
                $progressLine = $('<div class="banner-progress-line"></div>');
                $('body').append($progressLine);
            }

            let scrollProgress = 0;
            let ticking = false;

            const updateScroll = () => {
                const scrollTop = $(window).scrollTop();
                const windowHeight = $(window).height();
                const bannerHeight = $banner.outerHeight();
                const documentHeight = $(document).height();
                
                // Calculate scroll progress (0 to 1)
                scrollProgress = Math.min(1, Math.max(0, scrollTop / (documentHeight - windowHeight)));

                // Update progress line
                $progressLine.css({
                    'transform': `scaleX(${scrollProgress})`,
                    'transition': 'transform 0.1s ease-out'
                });

                // Apply transform based on scroll - like shaders-on-scroll
                const $titleText = $('.banner-title-text');
                const $subtitleText = $('.banner-subtitle-text');
                
                // Only animate when scrolling past banner
                const bannerScrollProgress = Math.min(1, Math.max(0, scrollTop / (bannerHeight * 0.8)));
                
                if ($titleText.length > 0) {
                    // More subtle scroll effect
                    const scale = 1 - bannerScrollProgress * 0.05;
                    const opacity = Math.max(0.3, 0.9 - bannerScrollProgress * 0.4);
                    const translateY = bannerScrollProgress * 30;
                    
                    $titleText.css({
                        'transform': `translateY(${translateY}px) scale(${scale})`,
                        'opacity': opacity,
                        'transition': 'transform 0.1s ease-out, opacity 0.1s ease-out'
                    });
                }
                
                if ($subtitleText.length > 0) {
                    const opacity = Math.max(0.2, 0.9 - bannerScrollProgress * 0.5);
                    $subtitleText.css({
                        'opacity': opacity,
                        'transition': 'opacity 0.1s ease-out'
                    });
                }

                ticking = false;
            };

            $(window).on('scroll', function() {
                if (!ticking) {
                    window.requestAnimationFrame(updateScroll);
                    ticking = true;
                }
            });

            // Initial call
            updateScroll();
        }
    };

    // Initialize when DOM is ready
    $(document).ready(function() {
        // Try multiple times to ensure it runs
        BannerShaderText.init();
        setTimeout(() => {
            BannerShaderText.init();
        }, 100);
        setTimeout(() => {
            BannerShaderText.init();
        }, 500);
        setTimeout(() => {
            BannerShaderText.init();
        }, 1000);
    });
    
    // Also try on window load
    $(window).on('load', function() {
        setTimeout(() => {
            BannerShaderText.init();
        }, 200);
    });

    // Expose globally
    window.BannerShaderText = BannerShaderText;
    
    // Force apply styles on window load
    $(window).on('load', function() {
        setTimeout(() => {
            $('.banner-title-text').each(function() {
                const $el = $(this);
                $el.css({
                    'font-size': 'min(15.3vw, 10.2rem)',
                    'font-weight': '500',
                    'line-height': '0.75',
                    'letter-spacing': '0.1ch',
                    'text-transform': 'uppercase'
                });
            });
            $('.banner-subtitle-text').each(function() {
                $(this).css({
                    'font-size': 'min(7.65vw, 5.1rem)'
                });
            });
        }, 500);
    });

})(jQuery);

