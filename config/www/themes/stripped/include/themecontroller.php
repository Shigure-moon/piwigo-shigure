<?php
namespace Stripped;

class ThemeController {
    
    private $config;
    
    public function __construct() {
        $this->config = new Config();
    }
    
    public function init() {
        // Assign config to template early
        add_event_handler('init', array($this, 'assignConfig'));
        
        // Handle random photos page
        add_event_handler('loc_begin_index', array($this, 'handleRandomPhotos'), EVENT_HANDLER_PRIORITY_NEUTRAL+5);
        
        // Register video files
        $video_ext = array('mp4', 'm4v', 'webm');
        global $conf;
        $conf['file_ext'] = array_merge($conf['file_ext'], $video_ext, array_map('strtoupper', $video_ext));
    }
    
    public function handleRandomPhotos() {
        global $page, $user;
        
        // Check if this is a random photos request - check URL pattern
        $is_random = false;
        if (isset($_GET['/random'])) {
            $is_random = true;
        } elseif (isset($_SERVER['REQUEST_URI']) && strpos($_SERVER['REQUEST_URI'], '/random') !== false) {
            $is_random = true;
        }
        
        if ($is_random) {
            // Get number of photos per page from config
            $photos_per_page = (int)$this->config->random_photos_per_page;
            if ($photos_per_page <= 0) {
                $photos_per_page = 80; // Default fallback
            }
            
            // Update user's nb_image_page for this request
            $user['nb_image_page'] = $photos_per_page;
            $page['nb_image_page'] = $photos_per_page;
            
            // Use Piwigo's get_available_images function if available, otherwise use simple query
            if (function_exists('get_available_images')) {
                $available_images = get_available_images();
                if (!empty($available_images)) {
                    // Shuffle and take a subset
                    shuffle($available_images);
                    $items = array_slice($available_images, 0, $photos_per_page);
                } else {
                    $items = array();
                }
            } else {
                // Fallback: simple query for all images
                $query = '
                    SELECT id
                    FROM ' . IMAGES_TABLE . '
                    ORDER BY RAND()
                    LIMIT ' . $photos_per_page . '
                ;';
                
                $result = pwg_query($query);
                $items = array();
                while ($row = pwg_db_fetch_assoc($result)) {
                    $items[] = $row['id'];
                }
            }
            
            if (!empty($items)) {
                $page['items'] = $items;
                $page['section'] = 'random';
                $page['start'] = 0;
                
                // Assign random photos count to template
                global $template;
                if (isset($template)) {
                    $template->assign('is_random_photos', true);
                    $template->assign('random_photos_count', count($items));
                }
            }
        }
    }
    
    public function assignConfig() {
        global $template;
        if (isset($template)) {
            $template->assign('theme_config', $this->config);
            
            // Add custom CSS if configured
            if (!empty($this->config->custom_css)) {
                $template->assign('custom_css', $this->config->custom_css);
            }
            
            // Logo, background, and banner images are now hardcoded in templates
            // No need to assign them from config
        }
    }
}

