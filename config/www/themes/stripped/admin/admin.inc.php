<?php

global $conf;

// Load modern gallery config
require_once(PHPWG_THEMES_PATH . 'stripped/include/config.php');
$modern_config = new \Stripped\Config();

// Need upgrade?
if (!isset($conf['stripped']))
  include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');

$stripped = unserialize( $conf['stripped'] );

// Need upgrade from v1.x?
if (!isset($stripped['themeStyle'])) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge( unserialize( $conf['stripped'] ), (array)$stripped );
}

// Need upgrade from v2.x?
if (!isset($stripped['paramVersion'])) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge( unserialize( $conf['stripped'] ), (array)$stripped );
}

load_language('theme.lang', PHPWG_THEMES_PATH.'stripped/');

$config= array ();

// Handle modern gallery settings
if (isset($_POST['stripped_modern_settings'])) {
    // Save settings
    $modern_config->fromPost($_POST);
    $modern_config->save();
    array_push($page['infos'], l10n('Modern Gallery settings updated'));
}

$template->set_filenames(array(
    'theme_admin_content' => dirname(__FILE__) . '/admin.tpl'));

$template->assign('options', safe_unserialize($conf['stripped']));
$template->assign('modern_config', $modern_config);

$template->assign_var_from_handle('ADMIN_CONTENT', 'theme_admin_content');
  
?>