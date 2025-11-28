<?php

if (!defined('PHPWG_ROOT_PATH')) die('Hacking attempt!');

global $prefixeTable, $conf, $stripped;

if (!isset($conf['stripped']))
{
    $config = array(
	'paramVersion' 					=> '2.3',
	
	'themeStyle'					=> 'black',
	'hideMenu'						=> true,
	'animatedMenu'					=> true,
	'noLowercase'					=> false,
	'albumType'						=> 'small',
	'albumFrame'					=> true,
	'thumbFrame'					=> true,
	'showThumbLegend'				=> false,

	'showTitleOnBrowsePath'			=> false,
	'imageFrame'					=> true,
	'imageCaption'					=> 'title',
	'imageArrows'					=> false,
	'navArrows'						=> true,
	'HDlightbox'					=> true,
	'forceLightboxOn'				=> false,
	'defaultZoomSize'				=> 'fit',
	'animatedTabs'					=> true,
	'infoTabAdminOnly'				=> false,
	'defaultTab'					=> "none",

	'albumSize'						=> "thumb",
	'thumbSize'						=> "thumb",
	'imageSize'						=> "medium",
	'hdSize'						=> "xxlarge",
	
	'imageAutosize'					=> true,
	'imageAutosizeMargin'			=> 60,
	'imageAutosizeMinHeight'		=> 200,

	'imagePreload'					=> false,
	'imagePreloadNb'				=> 5,
	'imagePreloadThumbs'			=> false,
	'imagePreloadHD'				=> false,

	'marginContainer'				=> 30,
	'paddingContainer'				=> 10,
	'highResClickMode'				=> 'zoom',
	'maxThumb'						=> 15,
      );

  conf_update_param('stripped', $config, true);
} else {
	
	if (isset($stripped['animatedMenu']) & (!isset($stripped['themeStyle']))) {

		$config = $stripped;
		$config['themeStyle']='original';
		$config['thumbFrame']=true;
		
		if ($stripped['showDescriptionInsteadOfTitle']) {
			$config['imageCaption']='description';
		} else {
			$config['imageCaption']='title';
		}

		$config['HDlightbox']=true;
		$config['forceLightboxOn']=false;
		$config['imageArrows']=true;
		$config['navArrows']=false;
		$config['paramVersion']='2.3';
		$config['albumType']='small';
		$config['albumFrame']=$config['thumbFrame'];
		$config['albumSize']='thumb';
		$config['thumbSize']='thumb';
		$config['imageSize']='medium';
		$config['hdSize']='xxlarge';
		  
		conf_update_param('stripped', $config, true);
	
	} else {
		if (isset($stripped['themeStyle']) & (!isset($stripped['paramVersion']))) {

			$config = $stripped;
			$config['paramVersion']='2.3';
			$config['albumType']='small';
			$config['albumFrame']=$config['thumbFrame'];
			$config['albumSize']='thumb';
			$config['thumbSize']='thumb';
			$config['imageSize']='medium';
			$config['hdSize']='xxlarge';
			$config['HDlightbox']=true;
			$config['forceLightboxOn']=false;
			  
			conf_update_param('stripped', $config, true);
		
		} else {
			
			if ($stripped['paramVersion'] == '2.1') {
				$config = $stripped;
				$config['paramVersion']='2.3';
				$config['albumSize']='thumb';
				$config['thumbSize']='thumb';
				$config['imageSize']='medium';
				$config['hdSize']='xxlarge';
				$config['HDlightbox']=true;
				$config['forceLightboxOn']=false;
				conf_update_param('stripped', $config, true);
			}

			if ($stripped['paramVersion'] == '2.2') {
				$config = $stripped;
				$config['paramVersion']='2.3';
				$config['HDlightbox']=true;
				$config['forceLightboxOn']=false;
				conf_update_param('stripped', $config, true);
			}
				
		}

	}

	}
?>