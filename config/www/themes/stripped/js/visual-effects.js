/**
 * Visual Effects Integration
 * Combines WebGL Blobs, Shaders on Scroll, Shape Morph, and Masked Hero effects
 */

(function($) {
    'use strict';

    // Check if WebGL is supported
    const hasWebGL = (function() {
        try {
            const canvas = document.createElement('canvas');
            return !!(window.WebGLRenderingContext && 
                    (canvas.getContext('webgl') || canvas.getContext('experimental-webgl')));
        } catch (e) {
            return false;
        }
    })();

    // Visual Effects Manager
    const VisualEffects = {
        init: function() {
            if (!hasWebGL) {
                console.log('WebGL not supported, skipping visual effects');
                return;
            }

            // Initialize effects based on page type
            this.initBackgroundBlobs();
            this.initScrollEffects();
            this.initMaskedHero();
            this.initShapeMorph();
        },

        // WebGL Background Blobs Effect
        initBackgroundBlobs: function() {
            // Only show on home page or album pages
            if ($('#thePicturePage').length > 0) return;

            // Check if Three.js is available (we'll load it conditionally)
            if (typeof THREE === 'undefined') {
                // Load Three.js dynamically if needed
                this.loadScript('https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js', () => {
                    this.createBlobBackground();
                });
            } else {
                this.createBlobBackground();
            }
        },

        createBlobBackground: function() {
            if (typeof THREE === 'undefined') return;

            const canvas = document.createElement('canvas');
            canvas.id = 'webgl-blobs';
            canvas.style.cssText = 'position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; pointer-events: none; opacity: 0.3;';
            document.body.appendChild(canvas);

            const scene = new THREE.Scene();
            const camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 1000);
            camera.position.set(0, 0, 18);

            const renderer = new THREE.WebGLRenderer({ canvas: canvas, alpha: true, antialias: true });
            renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5));
            renderer.setSize(window.innerWidth, window.innerHeight);
            renderer.setClearColor(0x000000, 0);

            // Create simple blob-like geometry
            const geometry = new THREE.IcosahedronGeometry(2, 32);
            const material = new THREE.MeshStandardMaterial({
                color: 0x3535cc,
                wireframe: true,
                transparent: true,
                opacity: 0.2
            });

            const blob1 = new THREE.Mesh(geometry, material);
            blob1.position.set(-5, 3, 0);
            scene.add(blob1);

            const blob2 = new THREE.Mesh(geometry, material);
            blob2.position.set(5, -3, -5);
            scene.add(blob2);

            const blob3 = new THREE.Mesh(geometry, material);
            blob3.position.set(0, -4, 3);
            scene.add(blob3);

            // Animation
            const clock = new THREE.Clock();
            function animate() {
                requestAnimationFrame(animate);
                const elapsedTime = clock.getElapsedTime();

                blob1.rotation.x = elapsedTime * 0.2;
                blob1.rotation.y = elapsedTime * 0.3;
                blob2.rotation.x = -elapsedTime * 0.15;
                blob2.rotation.y = elapsedTime * 0.25;
                blob3.rotation.x = elapsedTime * 0.1;
                blob3.rotation.y = -elapsedTime * 0.2;

                renderer.render(scene, camera);
            }

            // Handle resize
            window.addEventListener('resize', () => {
                camera.aspect = window.innerWidth / window.innerHeight;
                camera.updateProjectionMatrix();
                renderer.setSize(window.innerWidth, window.innerHeight);
            });

            animate();
        },

        // Scroll-based Shader Effects
        initScrollEffects: function() {
            // Add scroll-based animations to images
            const $images = $('.waterfall-item img, .album-img');
            
            if ($images.length === 0) return;

            // Use Intersection Observer for performance
            if (typeof IntersectionObserver !== 'undefined') {
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            $(entry.target).addClass('scroll-reveal');
                        }
                    });
                }, {
                    threshold: 0.1,
                    rootMargin: '50px'
                });

                $images.each(function() {
                    observer.observe(this);
                });
            }
        },

        // Masked Hero Effect for Titles
        initMaskedHero: function() {
            const $heroTitles = $('.page-header h1, .titrePage h2, .browsePath h2');
            
            if ($heroTitles.length === 0) return;

            $heroTitles.each(function() {
                const $title = $(this);
                const text = $title.text();
                
                // Split text into characters if not already done
                if ($title.find('.char').length === 0) {
                    const chars = text.split('').map(char => 
                        char === ' ' ? '<span class="char">&nbsp;</span>' : `<span class="char">${char}</span>`
                    ).join('');
                    $title.html(chars);
                }

                // Animate on load
                setTimeout(() => {
                    $title.find('.char').each(function(index) {
                        $(this).css({
                            'opacity': '0',
                            'transform': 'translateY(20px)'
                        }).delay(index * 50).animate({
                            'opacity': '1',
                            'transform': 'translateY(0)'
                        }, 600, 'swing');
                    });
                }, 300);
            });
        },

        // Shape Morph on Scroll
        initShapeMorph: function() {
            // Add shape morph effect to content sections
            const $sections = $('.content, #subcontent, .waterfall-gallery');
            
            if ($sections.length === 0) return;

            let ticking = false;
            const updateOnScroll = () => {
                if (!ticking) {
                    window.requestAnimationFrame(() => {
                        const scrollY = window.pageYOffset || document.documentElement.scrollTop;
                        const windowHeight = window.innerHeight;
                        
                        $sections.each(function() {
                            const $section = $(this);
                            const sectionTop = $section.offset().top;
                            const sectionHeight = $section.outerHeight();
                            const scrollProgress = Math.max(0, Math.min(1, 
                                (scrollY + windowHeight - sectionTop) / (windowHeight + sectionHeight)
                            ));
                            
                            // Apply transform based on scroll
                            $section.css({
                                'transform': `translateY(${scrollProgress * 20}px)`,
                                'opacity': 0.8 + scrollProgress * 0.2
                            });
                        });
                        
                        ticking = false;
                    });
                    ticking = true;
                }
            };

            $(window).on('scroll', updateOnScroll);
            updateOnScroll();
        },

        // Load script dynamically
        loadScript: function(src, callback) {
            const script = document.createElement('script');
            script.src = src;
            script.onload = callback;
            script.onerror = () => console.log('Failed to load script:', src);
            document.head.appendChild(script);
        }
    };

    // Enhanced Image Hover Effects
    const ImageEffects = {
        init: function() {
            this.initParallax();
            this.initHoverGlow();
            this.initTiltEffect();
        },

        initParallax: function() {
            const $images = $('.waterfall-item, .album-item');
            
            $images.on('mousemove', function(e) {
                const $item = $(this);
                const rect = this.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                
                const centerX = rect.width / 2;
                const centerY = rect.height / 2;
                
                const moveX = (x - centerX) / centerX * 10;
                const moveY = (y - centerY) / centerY * 10;
                
                $item.find('img').css({
                    'transform': `translate(${moveX}px, ${moveY}px) scale(1.05)`,
                    'transition': 'transform 0.3s ease-out'
                });
            });

            $images.on('mouseleave', function() {
                $(this).find('img').css({
                    'transform': 'translate(0, 0) scale(1)',
                    'transition': 'transform 0.5s ease-out'
                });
            });
        },

        initHoverGlow: function() {
            const $images = $('.waterfall-item img, .album-img');
            
            $images.on('mouseenter', function() {
                $(this).css({
                    'filter': 'brightness(1.2) contrast(1.1)',
                    'transition': 'filter 0.3s ease'
                });
            });

            $images.on('mouseleave', function() {
                $(this).css({
                    'filter': 'brightness(1) contrast(1)',
                    'transition': 'filter 0.3s ease'
                });
            });
        },

        initTiltEffect: function() {
            const $items = $('.waterfall-item, .album-item');
            
            $items.on('mousemove', function(e) {
                const $item = $(this);
                const rect = this.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                
                const centerX = rect.width / 2;
                const centerY = rect.height / 2;
                
                const rotateX = (y - centerY) / centerY * -5;
                const rotateY = (x - centerX) / centerX * 5;
                
                $item.css({
                    'transform': `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg)`,
                    'transition': 'transform 0.1s ease-out'
                });
            });

            $items.on('mouseleave', function() {
                $(this).css({
                    'transform': 'perspective(1000px) rotateX(0) rotateY(0)',
                    'transition': 'transform 0.5s ease-out'
                });
            });
        }
    };

    // Smooth Scroll Enhancement
    const SmoothScroll = {
        init: function() {
            // Only if Lenis is available
            if (typeof Lenis !== 'undefined') {
                this.initLenis();
            } else {
                this.initNativeSmooth();
            }
        },

        initLenis: function() {
            const lenis = new Lenis({
                lerp: 0.1,
                smoothWheel: true
            });

            function raf(time) {
                lenis.raf(time);
                requestAnimationFrame(raf);
            }
            requestAnimationFrame(raf);
        },

        initNativeSmooth: function() {
            // Native smooth scroll is already handled in theme.js
            // Just add some easing
            $('html').css('scroll-behavior', 'smooth');
        }
    };

    // Initialize when DOM is ready
    $(document).ready(function() {
        // Wait a bit for page to load
        setTimeout(() => {
            VisualEffects.init();
            ImageEffects.init();
            SmoothScroll.init();
        }, 500);
    });

    // Expose globally
    window.VisualEffects = VisualEffects;
    window.ImageEffects = ImageEffects;

})(jQuery);

