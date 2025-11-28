<?php
namespace Stripped;

class Config {
    
    // Layout settings
    public $waterfall_columns = 4;          // Number of columns in waterfall layout
    public $waterfall_gap = 5;               // Gap between items in pixels
    public $min_column_width = 250;         // Minimum column width in pixels
    public $layout_direction = 'row';       // 'row' for justified layout, 'column' for waterfall layout
    public $target_row_height = 300;        // Target height for row layout in pixels
    
    // Random photos settings
    public $random_photos_per_page = 80;     // Number of random photos per page
    
    // Custom CSS
    public $custom_css = '';                 // Custom CSS code
    
    public function __construct() {
        // Load configuration from database
        global $conf;
        if (isset($conf['stripped_modern'])) {
            $saved_config = unserialize($conf['stripped_modern']);
            if (is_array($saved_config)) {
                foreach ($saved_config as $key => $value) {
                    if (property_exists($this, $key)) {
                        $this->$key = $value;
                    }
                }
            }
        }
    }
    
    public function save() {
        global $conf;
        $config_array = array(
            'random_photos_per_page' => $this->random_photos_per_page,
            'waterfall_columns' => $this->waterfall_columns,
            'waterfall_gap' => $this->waterfall_gap,
            'min_column_width' => $this->min_column_width,
            'layout_direction' => $this->layout_direction,
            'target_row_height' => $this->target_row_height,
            'custom_css' => $this->custom_css
        );
        conf_update_param('stripped_modern', serialize($config_array));
    }
    
    public function fromPost($post) {
        if (isset($post['random_photos_per_page'])) {
            $this->random_photos_per_page = max(1, (int)$post['random_photos_per_page']);
        }
        if (isset($post['waterfall_columns'])) {
            $this->waterfall_columns = max(2, min(10, (int)$post['waterfall_columns']));
        }
        if (isset($post['waterfall_gap'])) {
            $this->waterfall_gap = max(0, (int)$post['waterfall_gap']);
        }
        if (isset($post['min_column_width'])) {
            $this->min_column_width = max(100, (int)$post['min_column_width']);
        }
        if (isset($post['layout_direction'])) {
            $this->layout_direction = $post['layout_direction'] === 'column' ? 'column' : 'row';
        }
        if (isset($post['target_row_height'])) {
            $this->target_row_height = max(100, min(1000, (int)$post['target_row_height']));
        }
        if (isset($post['custom_css'])) {
            $this->custom_css = stripslashes($post['custom_css']);
        }
    }
}

