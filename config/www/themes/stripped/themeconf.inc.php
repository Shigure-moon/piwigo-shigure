<?php
/*
Theme Name: stripped
Version: 15.h
Description: stripped Theme
Theme URI: https://piwigo.org/ext/extension_view.php?eid=471
Author: Julien Capitaine (Zaphod on Piwigo forums)
Author URI: http://www.audreyetjulien.fr/galerie
*/

global $conf, $user, $stripped;

// Load modern gallery functionality
require_once(PHPWG_THEMES_PATH . 'stripped/include/themecontroller.php');
require_once(PHPWG_THEMES_PATH . 'stripped/include/config.php');

$controller = new \Stripped\ThemeController();
$controller->init();

// Need upgrade?
if (!isset($conf['stripped']))
  include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');

$conf['stripped'] = safe_unserialize($conf['stripped']);

$stripped = array_merge($conf['stripped'], (array)$stripped );

// Need upgrade from v1.x?
if (!isset($stripped['themeStyle'])) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge($conf['stripped'], (array)$stripped );
}

// Set default theme style to dark if not set (after upgrade)
if (!isset($stripped['themeStyle']) || empty($stripped['themeStyle'])) {
  $stripped['themeStyle'] = 'dark';
  $conf['stripped'] = serialize($stripped);
  conf_update_param('stripped', $conf['stripped']);
}

// Need upgrade from v2.x?
if (!isset($stripped['paramVersion'])) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge($conf['stripped'], (array)$stripped );
}

// Need upgrade from v2.1 or v2.2?
if ((isset($stripped['paramVersion'])) && ($stripped['paramVersion'] != '2.3')) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge($conf['stripped'], (array)$stripped );
}


add_event_handler('init', 'set_config_values');
function set_config_values()
{
  global $template, $pwg_loaded_plugins, $stripped, $user, $conf, $page;
  
  // Override gallery title with shigure branding (Weweb style)
  if (empty($conf['gallery_title']) || $conf['gallery_title'] == 'Just another Piwigo gallery') {
    $conf['gallery_title'] = 'shigure';
  }
  
  // Override page banner with Weweb style for homepage
  if (empty($page['page_banner']) && (empty($page['section']) || (isset($page['section']) && $page['section'] == 'categories'))) {
    $page['page_banner'] = '<h1 class="banner-title-text">welcome</h1><br><p class="banner-subtitle-text">Shigure</p>';
  }
  
  $template->assign(array(
                          'automatic_size_enabled'=> isset($pwg_loaded_plugins['automatic_size']),
                          'HDShadowbox_loaded'=> isset($pwg_loaded_plugins['HDShadowbox']),
                          'GMaps_loaded'=> isset($pwg_loaded_plugins['GMaps']),
                          'ThumbScroller_loaded'=> isset($pwg_loaded_plugins[ 'rv_tscroller' ]),
                          'usertags'=> isset($pwg_loaded_plugins['user_tags']),
                          'stripped'=> $stripped
                         ));
}

// Get archive data (albums grouped by year)
add_event_handler('loc_end_index', 'get_archive_data');
function get_archive_data()
{
  global $template, $user;
  
  // Get albums grouped by year based on date_available
  // First, get all photos with their years
  $forbidden_clause = '';
  if (!empty($user['forbidden_categories'])) {
    $forbidden_clause = ' AND ic.category_id NOT IN ('.$user['forbidden_categories'].')';
  }
  
  $query = '
SELECT 
    YEAR(FROM_UNIXTIME(i.date_available)) as archive_year,
    COUNT(DISTINCT ic.category_id) as album_count,
    COUNT(DISTINCT i.id) as photo_count
  FROM '.IMAGES_TABLE.' i
  INNER JOIN '.IMAGE_CATEGORY_TABLE.' ic ON ic.image_id = i.id
  INNER JOIN '.CATEGORIES_TABLE.' c ON c.id = ic.category_id
  WHERE i.level <= '.$user['level'].'
    AND c.status = "public"
    AND i.date_available IS NOT NULL
    AND i.date_available > 0'.$forbidden_clause.'
  GROUP BY YEAR(FROM_UNIXTIME(i.date_available))
  HAVING archive_year IS NOT NULL
  ORDER BY archive_year DESC';
  
  $result = pwg_query($query);
  $archive_years = array();
  
  while ($row = pwg_db_fetch_assoc($result)) {
    if (!empty($row['archive_year'])) {
      $archive_years[] = array(
        'year' => (int)$row['archive_year'],
        'album_count' => (int)$row['album_count'],
        'photo_count' => (int)$row['photo_count']
      );
    }
  }
  
  // Also get all top-level albums for "全部相册" option
  $query_all = '
SELECT COUNT(DISTINCT c.id) as total_albums
  FROM '.CATEGORIES_TABLE.' c
  WHERE c.status = "public"';
  
  if (!empty($user['forbidden_categories'])) {
    $query_all .= ' AND c.id NOT IN ('.$user['forbidden_categories'].')';
  }
  
  $result_all = pwg_query($query_all);
  $total_albums = 0;
  if ($row_all = pwg_db_fetch_assoc($result_all)) {
    $total_albums = (int)$row_all['total_albums'];
  }
  
  // Get recent albums (last 30 days)
  $query_recent = '
SELECT COUNT(DISTINCT c.id) as recent_albums
  FROM '.CATEGORIES_TABLE.' c
  LEFT JOIN '.IMAGE_CATEGORY_TABLE.' ic ON ic.category_id = c.id
  LEFT JOIN '.IMAGES_TABLE.' i ON ic.image_id = i.id AND i.level <= '.$user['level'].'
  WHERE c.status = "public" 
    AND i.date_available > UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY))';
  
  if (!empty($user['forbidden_categories'])) {
    $query_recent .= ' AND c.id NOT IN ('.$user['forbidden_categories'].')';
  }
  
  $result_recent = pwg_query($query_recent);
  $recent_albums = 0;
  if ($row_recent = pwg_db_fetch_assoc($result_recent)) {
    $recent_albums = (int)$row_recent['recent_albums'];
  }
  
  $template->assign(array(
    'archive_years' => $archive_years,
    'total_albums' => $total_albums,
    'recent_albums' => $recent_albums
  ));
}
	
$themeconf = array(
  'parent' => 'default',
  'load_parent_css' => false,
  'load_parent_local_head' => false,
  'load_css' => true,
  'name' => 'stripped',
  'theme_dir' => 'stripped',
  'icon_dir' => 'themes/stripped/icon',
  'img_dir'      => 'themes/stripped/images',
  'admin_icon_dir' => 'themes/default/icon/admin',
  'mime_icon_dir' => 'themes/default/icon/mimetypes/',
  'local_head' => 'local_head.tpl',
  'colorscheme' => 'dark', // Always use dark theme
  'use_standard_pages' => false, // Disable standard_pages to use stripped theme's identification.tpl
);

load_language('theme.lang', PHPWG_THEMES_PATH.'stripped/');

pwg_set_session_var('show_metadata', true);

// max number of thumbnails by page 

add_event_handler('loc_begin_index', 'modify_nb_thumbnail_page');
function modify_nb_thumbnail_page()
{
	global $user, $page, $stripped;

	if (!isset($stripped['maxThumb'])) { $stripped['maxThumb']=15;}
	$user['nb_image_page']=$stripped['maxThumb'];
	$page['nb_image_page']=$stripped['maxThumb'];
}

// Preload function

if (isset($stripped['imagePreload']) && ($user['theme'] == 'stripped')) {
	add_event_handler('loc_end_picture', 'assign_next_images_url');
}

function assign_next_images_url()
{
	global $page, $template, $conf, $stripped;

	$nb_image =$stripped['imagePreloadNb'];
	$nb_max = $page['last_rank'] - $page['current_rank'];
	$nb_image = min ($nb_image, $nb_max);

	if ($nb_image < 1) return;

	for ($n = 1; $n <= $nb_image; $n++) {
		$pagenext[$n] = $page['items'][ $page['current_rank'] + $n ];
	}

	$picturenext = array();
	$idnext = array();

	for ($n = 1; $n <= $nb_image; $n++) {
		array_push($idnext, $pagenext[$n]);
	}

	$query = '
	SELECT *
	  FROM '.IMAGES_TABLE.'
	  WHERE id IN ('.implode(',', $idnext).')
	;';

	$result = pwg_query($query);

	while ($rownext = pwg_db_fetch_assoc($result))
	{
		for ($n = 1; $n <= $nb_image; $n++) {
			if (isset($pagenext[$n]) and $rownext['id'] == $pagenext[$n]) {$in = $n;}
		}

		$picturenext[$in] = $rownext;

		$derivative = new DerivativeImage($stripped['imageSize'], new SrcImage($rownext));
		$picturenext[$in]['image_url'] = $derivative->get_url();
	}

	for ($n = 1; $n <= $nb_image; $n++) {
		if (isset($picturenext[$n]['image_url'])) { $image_next[$n] = $picturenext[$n]['image_url']; }
	}
  
  $template->assign('U_IMGNEXT', $image_next );

}

?>
