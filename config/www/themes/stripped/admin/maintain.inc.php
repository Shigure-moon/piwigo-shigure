<?php

function theme_activate($id, $version, &$errors)
{
  global $prefixeTable, $conf;

  if (!isset($conf['stripped']))
  {
    $config = array(
	'paramVersion' 					=> '2.3',
	
	'themeStyle'					=> 'original',

	'marginContainer'				=> 30,
	'paddingContainer'				=> 10,
	'highResClickMode'				=> 'zoom',
	'maxThumb'						=> 15,
      );
      
    $query = "
INSERT INTO " . CONFIG_TABLE . " (param,value,comment)
VALUES ('stripped' , '".pwg_db_real_escape_string(serialize($config))."' , 'stripped theme parameters');";

    pwg_query($query);
  }
}

function theme_deactivate()
{
  global $prefixeTable;

  $query = "DELETE FROM " . CONFIG_TABLE . " WHERE param='stripped';";
  pwg_query($query);
}

?>