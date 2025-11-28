{* Stripped Theme - CSS and JS Loading *}
{if $load_css} 
{combine_css path='themes/stripped/css/fonts.css' order=-10}
{combine_css path='themes/stripped/css/modern-styles.css' order=-5}
{combine_css path='themes/stripped/theme.css' order=0}
{/if}

{* Load JavaScript *}
{combine_script id='jquery' path='themes/default/js/jquery.min.js' load='footer'}
{combine_script id='stripped-theme' path='themes/stripped/js/theme.js' require='jquery' load='footer'}
