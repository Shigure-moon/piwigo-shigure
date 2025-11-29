<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="{$lang_info.code}" dir="{$lang_info.direction}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset={$CONTENT_ENCODING}">
<meta name="generator" content="shigure">
{if isset($meta_ref) } 
{if isset($INFO_AUTHOR)}
<meta name="author" content="{$INFO_AUTHOR|@strip_tags:false|@replace:'"':' '}">
{/if}
{if isset($related_tags)}
<meta name="keywords" content="{foreach from=$related_tags item=tag name=tag_loop}{if !$smarty.foreach.tag_loop.first}, {/if}{$tag.name}{/foreach}">
{/if}
{if isset($COMMENT_IMG)}
<meta name="description" content="{$COMMENT_IMG|@strip_tags:false|@replace:'"':' '}{if isset($INFO_FILE)} - {$INFO_FILE}{/if}">
{else}
<meta name="description" content="{$PAGE_TITLE}{if isset($INFO_FILE)} - {$INFO_FILE}{/if}">
{/if}
{/if}

{if (isset($REVERSE) and $REVERSE and $PAGE_TITLE == l10n('Home'))}
<title>shigure | {$PAGE_TITLE}</title>{else}
<title>{$PAGE_TITLE} | shigure</title>{/if}
<link rel="shortcut icon" type="image/x-icon" href="{$ROOT_URL}themes/stripped/img/weweb/logo_simple.png">
<link rel="icon" type="image/png" href="{$ROOT_URL}themes/stripped/img/weweb/logo_simple.png">

<link rel="start" title="{'Home'|@translate}" href="{$U_HOME}" >
<link rel="search" title="{'Search'|@translate}" href="{$ROOT_URL}search.php" >
{if isset($first.U_IMG)   }<link rel="first" title="{'First'|@translate}" href="{$first.U_IMG}" >{/if}
{if isset($previous.U_IMG)}<link rel="prev" title="{'Previous'|@translate}" href="{$previous.U_IMG}" >{/if}
{if isset($next.U_IMG)    }<link rel="next" title="{'Next'|@translate}" href="{$next.U_IMG}" >{/if}
{if isset($last.U_IMG)    }<link rel="last" title="{'Last'|@translate}" href="{$last.U_IMG}" >{/if}
{if isset($U_UP)          }<link rel="up" title="{'Thumbnails'|@translate}" href="{$U_UP}" >{/if}

{foreach from=$themes item=theme}
{if $theme.load_css}
{combine_css path="themes/`$theme.id`/theme.css" order=-10}
{/if}
{if !empty($theme.local_head)}{include file=$theme.local_head load_css=$theme.load_css}{/if}
{/foreach}
{get_combined_css}


{if isset($U_PREFETCH)          }<link rel="prefetch" href="{$U_PREFETCH}">{/if}

{if not empty($page_refresh)    }<meta http-equiv="refresh" content="{$page_refresh.TIME};url={$page_refresh.U_REFRESH}">{/if}

{get_combined_scripts load='header'}
<!--[if lt IE 7]>
<script type="text/javascript" src="{$ROOT_URL}themes/default/js/pngfix.js"></script>
<![endif]-->

{combine_script id='jquery.migrate' load='footer' require='jquery' path='themes/stripped/js/jquery-migrate.min.js'}
{combine_script id='banner-shader-text' load='footer' require='jquery' path='themes/stripped/js/banner-shader-text.js'}

{* Visual Effects - Load Three.js and visual effects script *}
{combine_script id='three.js' load='footer' path='https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js'}
{combine_script id='visual-effects' load='footer' require='jquery' path='themes/stripped/js/visual-effects.js'}
{combine_script id='image-viewer-enhancements' load='footer' require='jquery' path='themes/stripped/js/image-viewer-enhancements.js'}

{if not empty($head_elements)}
	{foreach from=$head_elements item=elt}{$elt}
	{/foreach}
{/if}

</head>

<body id="{$BODY_ID}" class={strip}"
	{if isset($stripped.thumbFrame) && !$stripped.thumbFrame} ntf{/if}
	{if isset($stripped.albumFrame) && !$stripped.albumFrame} naf{/if}
	{if isset($stripped.albumType) && ($stripped.albumType == 'small')} ats{elseif isset($stripped.albumType)} atd{/if}
	{if isset($stripped.albumType) && ($stripped.albumType == '1perline')} at1{/if}
	{if isset($stripped.albumType) && ($stripped.albumType == '2perline')} at2{/if}
	{if isset($stripped.albumType) && ($stripped.albumType == '3perline')} at3{/if}
"{/strip}>
<div id="the_page">

{if not empty($header_msgs)}
<div class="header_msgs">
	{foreach from=$header_msgs item=elt}
	{$elt}<br>
	{/foreach}
</div>
{/if}

{* Navigation Bar - Modern Gallery Design - Hardcoded Logo - Should be above banner - Hide in login page and picture page *}
{* Note: Fotorama plugin will handle slideshow mode, so we don't hide navbar here *}
{if $PAGE_TITLE != l10n('Identification') && $BODY_ID != 'thePicturePage'}
{html_head}
<style type="text/css">
.navbar {
  padding: 0.5rem 0 !important;
}

.navbar .container-fluid {
  display: flex !important;
  justify-content: flex-start !important;
  width: 100% !important;
  max-width: 100% !important;
}

.navbar-content {
  display: flex !important;
  justify-content: space-between !important;
  width: 100% !important;
  flex: 1 !important;
}

.navbar-nav {
  display: flex !important;
  margin-left: auto !important;
  justify-content: flex-end !important;
}

.nav-link {
  padding: 0.4rem 1rem !important;
}

.navbar-logo {
  max-height: 30px !important;
}

/* Pagination Navigation Bar - Modern Styling */
.pagination-container {
  display: flex !important;
  justify-content: center !important;
  align-items: center !important;
  text-align: center !important;
  width: 100% !important;
  margin: 2rem auto !important;
}

.navigationBar {
  display: flex !important;
  flex-wrap: wrap !important;
  justify-content: center !important;
  align-items: center !important;
  gap: 0.5rem !important;
  margin: 0 auto !important;
  padding: 1rem !important;
  font-size: 0.9rem !important;
  line-height: 1.5 !important;
  color: var(--text-primary) !important;
}

.navigationBar a {
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  min-width: 36px !important;
  height: 36px !important;
  padding: 0.5rem 0.75rem !important;
  background: rgba(0, 0, 0, 0.5) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  border-radius: 10px !important;
  color: var(--text-primary) !important;
  text-decoration: none !important;
  transition: all 0.3s ease !important;
  white-space: nowrap !important;
  backdrop-filter: blur(10px) !important;
  font-weight: 500 !important;
  margin: 0 0.125rem !important;
  cursor: pointer !important;
  pointer-events: auto !important;
  position: relative !important;
  z-index: 1 !important;
}

.navigationBar a:hover {
  background: rgba(255, 255, 255, 0.2) !important;
  border-color: rgba(255, 255, 255, 0.4) !important;
  transform: translateY(-2px) !important;
  color: var(--text-primary) !important;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3) !important;
}

.navigationBar a:active {
  transform: translateY(0) !important;
}

.navigationBar .pageNumberSelected {
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  min-width: 36px !important;
  height: 36px !important;
  padding: 0.5rem 0.75rem !important;
  background: rgba(255, 255, 255, 0.3) !important;
  border: 1px solid rgba(255, 255, 255, 0.5) !important;
  border-radius: 10px !important;
  color: var(--text-primary) !important;
  font-weight: 600 !important;
  margin: 0 0.125rem !important;
  cursor: default !important;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2) !important;
}

.navigationBar > span:not(.pageNumberSelected),
.navigationBar .nav-disabled {
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  min-width: 36px !important;
  height: 36px !important;
  padding: 0.5rem 0.75rem !important;
  background: rgba(0, 0, 0, 0.3) !important;
  border: 1px solid rgba(255, 255, 255, 0.1) !important;
  border-radius: 10px !important;
  color: rgba(255, 255, 255, 0.4) !important;
  margin: 0 0.125rem !important;
  user-select: none !important;
  cursor: not-allowed !important;
  opacity: 0.6 !important;
  font-weight: 500 !important;
}

/* Ensure all navigation links are clickable */
.navigationBar a.nav-page-link {
  cursor: pointer !important;
  pointer-events: auto !important;
  position: relative !important;
  z-index: 1 !important;
}

@media (max-width: 768px) {
  .navigationBar {
    font-size: 0.85rem !important;
    padding: 0.75rem !important;
    gap: 0.375rem !important;
  }
  
  .navigationBar a,
  .navigationBar .pageNumberSelected,
  .navigationBar .nav-disabled {
    min-width: 32px !important;
    height: 32px !important;
    padding: 0.4rem 0.6rem !important;
    font-size: 0.85rem !important;
  }
}

@media (max-width: 480px) {
  .navigationBar {
    font-size: 0.8rem !important;
    padding: 0.5rem !important;
    gap: 0.25rem !important;
  }
  
  .navigationBar a,
  .navigationBar .pageNumberSelected,
  .navigationBar .nav-disabled {
    min-width: 28px !important;
    height: 28px !important;
    padding: 0.35rem 0.5rem !important;
    font-size: 0.8rem !important;
  }
}
</style>
{/html_head}
<nav class="navbar">
	<div class="container-fluid">
		<div class="navbar-content">
			<a href="{$U_HOME}" class="navbar-brand">
				<img src="{$ROOT_URL}themes/stripped/img/weweb/logo-text.png" alt="shigure" class="navbar-logo" />
			</a>
			<div class="navbar-nav">
				<a href="{$U_HOME}" class="nav-link">首页</a>
				<a href="index.php?/random" class="nav-link random-photos-link">随机照片</a>
			</div>
		</div>
	</div>
</nav>
{/if}

{* Page Header / Banner - Bootstrap Darkroom Style - Hardcoded - Hide on album pages with thumbnails, login page, and picture page *}
{* Note: Fotorama plugin will handle slideshow mode, so we don't hide banner here *}
{if empty($THUMBNAILS) && $PAGE_TITLE != l10n('Identification') && $BODY_ID != 'thePicturePage'}
<div class="page-header page-header-small">
	<div class="page-header-image" style="background-image: url('{$ROOT_URL}themes/stripped/img/weweb/1111.png'); background-size: cover; background-position: center center; background-repeat: no-repeat; width: 100%; height: 100%; position: absolute; top: 0; left: 0; z-index: -1;"></div>
	<div class="container">
		<div id="theHeader" class="content-center banner-shader-container">
			{$PAGE_BANNER}
		</div>
	</div>
</div>

{* Album Navigation Bar - Below Banner *}
{html_head}
<style type="text/css">
/* Album Navigation Bar - Below Banner */
.album-navigation-bar {
  width: 100% !important;
  background: rgba(0, 0, 0, 0.85) !important;
  border-bottom: 1px solid rgba(255, 255, 255, 0.2) !important;
  padding: 1.5rem 0 !important;
  position: relative !important;
  z-index: 100 !important;
  backdrop-filter: blur(10px) !important;
  -webkit-backdrop-filter: blur(10px) !important;
  margin: 0 !important;
}

.album-nav-container {
  width: 100% !important;
  max-width: 1200px !important;
  margin: 0 auto !important;
  padding: 0 2rem !important;
  display: flex !important;
  align-items: center !important;
  gap: 2rem !important;
  flex-wrap: wrap !important;
  justify-content: flex-start !important;
}

@media (min-width: 768px) {
  .album-nav-container {
    justify-content: flex-start !important;
  }
}

.album-nav-item {
  display: flex !important;
  flex-direction: row !important;
  align-items: center !important;
  gap: 1rem !important;
  flex: 1 !important;
  min-width: 200px !important;
  max-width: 400px !important;
}

.album-nav-label {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
  font-size: 14px !important;
  font-weight: 600 !important;
  color: rgba(255, 255, 255, 0.9) !important;
  letter-spacing: 0.05em !important;
  text-transform: uppercase !important;
  margin: 0 !important;
  padding: 0 !important;
  white-space: nowrap !important;
  flex-shrink: 0 !important;
}

/* Album Archive Select Dropdown */
.album-nav-item {
  position: relative !important;
}

.custom-dropdown-wrapper {
  flex: 1 !important;
  min-width: 0 !important;
  position: relative !important;
}

.album-archive-select {
  width: 100% !important;
  padding: 0.75rem 1rem 0.75rem 1rem !important;
  background: rgba(0, 0, 0, 0.5) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  border-radius: 10px !important;
  color: #ffffff !important;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
  font-size: 14px !important;
  font-weight: 400 !important;
  cursor: pointer !important;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
  appearance: none !important;
  -webkit-appearance: none !important;
  -moz-appearance: none !important;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23ffffff' d='M6 9L1 4h10z'/%3E%3C/svg%3E") !important;
  background-repeat: no-repeat !important;
  background-position: right 1rem center !important;
  background-size: 12px !important;
  padding-right: 2.5rem !important;
  backdrop-filter: blur(10px) !important;
  -webkit-backdrop-filter: blur(10px) !important;
  box-sizing: border-box !important;
  position: relative !important;
  transform: translateY(0) !important;
}

.album-archive-select:hover {
  background-color: rgba(255, 255, 255, 0.1) !important;
  border-color: rgba(255, 255, 255, 0.3) !important;
  transform: translateY(-1px) !important;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3) !important;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23ffffff' d='M6 8.5L2 4.5h8z' opacity='0.9'/%3E%3C/svg%3E") !important;
}

.album-archive-select:focus {
  outline: none !important;
  border-color: rgba(255, 255, 255, 0.4) !important;
  background-color: rgba(255, 255, 255, 0.15) !important;
  box-shadow: 0 0 0 3px rgba(53, 53, 204, 0.2), 0 4px 12px rgba(0, 0, 0, 0.4) !important;
  transform: translateY(-1px) !important;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23ffffff' d='M6 3.5L10 7.5H2z'/%3E%3C/svg%3E") !important;
  animation: dropdownArrowRotate 0.3s ease !important;
}

.album-archive-select:active {
  transform: translateY(0) !important;
  transition: all 0.15s ease !important;
}

/* Dropdown arrow rotation animation */
@keyframes dropdownArrowRotate {
  0% {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23ffffff' d='M6 9L1 4h10z'/%3E%3C/svg%3E") !important;
  }
  50% {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23ffffff' d='M6 6L3 3h6z'/%3E%3C/svg%3E") !important;
  }
  100% {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23ffffff' d='M6 3.5L10 7.5H2z'/%3E%3C/svg%3E") !important;
  }
}

/* Option hover animation */
.album-archive-select option {
  background: #000000 !important;
  color: #ffffff !important;
  padding: 0.5rem !important;
  transition: background-color 0.2s ease !important;
}

.album-archive-select option:hover {
  background: rgba(53, 53, 204, 0.3) !important;
}

.album-archive-select option:checked {
  background: rgba(53, 53, 204, 0.5) !important;
}

/* Smooth dropdown animation - using CSS to enhance native select */
.album-archive-select--opening {
  animation: dropdownSmoothOpen 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
}

.album-archive-select--closing {
  animation: dropdownSmoothClose 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
}

.album-archive-select--changed {
  animation: dropdownValueChanged 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
}

@keyframes dropdownSmoothOpen {
  0% {
    opacity: 0.95;
    transform: translateY(0) scale(1);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
  }
  50% {
    opacity: 1;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.4);
  }
  100% {
    opacity: 1;
    transform: translateY(-1px) scale(1);
    box-shadow: 0 0 0 3px rgba(53, 53, 204, 0.2), 0 4px 12px rgba(0, 0, 0, 0.4);
  }
}

@keyframes dropdownSmoothClose {
  0% {
    transform: translateY(-1px) scale(1);
    box-shadow: 0 0 0 3px rgba(53, 53, 204, 0.2), 0 4px 12px rgba(0, 0, 0, 0.4);
  }
  100% {
    transform: translateY(0) scale(1);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
  }
}

@keyframes dropdownValueChanged {
  0% {
    background-color: rgba(255, 255, 255, 0.15);
  }
  50% {
    background-color: rgba(53, 53, 204, 0.2);
  }
  100% {
    background-color: rgba(255, 255, 255, 0.15);
  }
}

/* Enhanced focus state with smooth transition */
.album-archive-select:focus {
  animation: dropdownFocusPulse 0.4s cubic-bezier(0.4, 0, 0.2, 1) !important;
}

@keyframes dropdownFocusPulse {
  0% {
    box-shadow: 0 0 0 0 rgba(53, 53, 204, 0.2), 0 4px 12px rgba(0, 0, 0, 0.4);
  }
  50% {
    box-shadow: 0 0 0 4px rgba(53, 53, 204, 0.3), 0 6px 16px rgba(0, 0, 0, 0.5);
  }
  100% {
    box-shadow: 0 0 0 3px rgba(53, 53, 204, 0.2), 0 4px 12px rgba(0, 0, 0, 0.4);
  }
}

/* Smooth option hover effect */
.album-archive-select option {
  transition: background-color 0.2s ease, color 0.2s ease !important;
}

.album-archive-select option:hover {
  background: rgba(53, 53, 204, 0.3) !important;
  color: #ffffff !important;
  animation: optionHoverSlide 0.2s ease !important;
}

@keyframes optionHoverSlide {
  0% {
    padding-left: 0.5rem;
  }
  100% {
    padding-left: 0.75rem;
  }
}

.album-archive-select option {
  background: #000000 !important;
  color: #ffffff !important;
  padding: 0.5rem !important;
}

/* Album Search Input */
.album-search-wrapper {
  position: relative !important;
  width: 100% !important;
  display: flex !important;
  align-items: center !important;
}

.album-search-input {
  flex: 1 !important;
  min-width: 0 !important;
  padding: 0.75rem 1rem 0.75rem 2.5rem !important;
  background: rgba(0, 0, 0, 0.5) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  border-radius: 10px !important;
  color: #ffffff !important;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
  font-size: 14px !important;
  font-weight: 400 !important;
  transition: all 0.3s ease !important;
  backdrop-filter: blur(10px) !important;
  -webkit-backdrop-filter: blur(10px) !important;
  box-sizing: border-box !important;
}

.album-search-input::placeholder {
  color: rgba(255, 255, 255, 0.5) !important;
  opacity: 1 !important;
}

.album-search-input:hover {
  background-color: rgba(255, 255, 255, 0.1) !important;
  border-color: rgba(255, 255, 255, 0.3) !important;
}

.album-search-input:focus {
  outline: none !important;
  border-color: rgba(255, 255, 255, 0.4) !important;
  background-color: rgba(255, 255, 255, 0.15) !important;
  box-shadow: 0 0 0 3px rgba(53, 53, 204, 0.2) !important;
}

.album-search-icon {
  position: absolute !important;
  left: 1rem !important;
  top: 50% !important;
  transform: translateY(-50%) !important;
  color: rgba(255, 255, 255, 0.6) !important;
  width: 20px !important;
  height: 20px !important;
  pointer-events: none !important;
  z-index: 1 !important;
  display: block !important;
  opacity: 0.7 !important;
  transition: opacity 0.3s ease !important;
}

.album-search-icon svg {
  width: 100% !important;
  height: 100% !important;
  display: block !important;
}

.album-search-input:focus + .album-search-icon {
  opacity: 1 !important;
  color: rgba(255, 255, 255, 0.9) !important;
}

/* Responsive */
@media (max-width: 768px) {
  .album-navigation-bar {
    padding: 1rem 0 !important;
  }
  
  .album-nav-container {
    flex-direction: column !important;
    gap: 1rem !important;
    padding: 0 1rem !important;
  }
  
  .album-nav-item {
    width: 100% !important;
    max-width: 100% !important;
    flex-direction: row !important;
  }
  
  .album-nav-label {
    min-width: 80px !important;
  }
}

</style>
{/html_head}

<div class="album-navigation-bar">
	<div class="album-nav-container">
		<div class="album-nav-item">
			<label for="album-archive-select" class="album-nav-label">归档</label>
			<div class="custom-dropdown-wrapper">
				<select id="album-archive-select" class="album-archive-select">
					<option value="">选择相册分类</option>
					{if isset($total_albums) && $total_albums > 0}
					<option value="all">全部相册 ({$total_albums})</option>
					{/if}
					{if isset($recent_albums) && $recent_albums > 0}
					<option value="recent">最近更新 ({$recent_albums})</option>
					{/if}
					{if isset($archive_years) && !empty($archive_years)}
					{foreach from=$archive_years item=archive}
					<option value="year_{$archive.year}">{$archive.year}年 ({$archive.album_count} 相册, {$archive.photo_count} 照片)</option>
					{/foreach}
					{/if}
				</select>
			</div>
		</div>
		<div class="album-nav-item">
			<label for="album-search-input" class="album-nav-label">搜索相册</label>
			<div class="album-search-wrapper">
				<input type="text" id="album-search-input" class="album-search-input" placeholder="输入相册名称或关键词..." />
				<span class="album-search-icon">
					<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<circle cx="11" cy="11" r="8"></circle>
						<path d="m21 21-4.35-4.35"></path>
					</svg>
				</span>
			</div>
		</div>
	</div>
</div>

{* JavaScript for smooth dropdown animation and archive functionality *}
{footer_script require='jquery'}{strip}
(function() {
  const select = document.getElementById('album-archive-select');
  if (!select) return;
  
  let isOpening = false;
  
  // Add smooth open animation class
  select.addEventListener('mousedown', function() {
    if (!isOpening) {
      isOpening = true;
      this.classList.add('album-archive-select--opening');
      
      // Remove class after animation
      setTimeout(() => {
        this.classList.remove('album-archive-select--opening');
        isOpening = false;
      }, 300);
    }
  });
  
  // Add smooth close animation
  select.addEventListener('blur', function() {
    this.classList.add('album-archive-select--closing');
    setTimeout(() => {
      this.classList.remove('album-archive-select--closing');
    }, 200);
  });
  
  // Archive functionality - handle selection
  select.addEventListener('change', function() {
    const value = this.value;
    
    // Smooth value change animation
    this.classList.add('album-archive-select--changed');
    setTimeout(() => {
      this.classList.remove('album-archive-select--changed');
    }, 300);
    
    // Handle archive selection
    if (!value) {
      return; // No selection
    }
    
    let url = '';
    if (value === 'all') {
      // Show all albums - go to categories page
      url = '{$ROOT_URL}index.php?/categories';
    } else if (value === 'recent') {
      // Show recent albums - use Piwigo search with 30d preset
      url = '{$ROOT_URL}search.php?date_posted_preset=30d';
    } else if (value.startsWith('year_')) {
      // Filter by year - use custom date format yYYYY
      const year = value.replace('year_', '');
      url = '{$ROOT_URL}search.php?date_posted_custom=y' + year;
    }
    
    if (url) {
      window.location.href = url;
    }
  });
})();
{/strip}{/footer_script}
{/if}

{if isset($theSwiftHeader)}{$theSwiftHeader}{/if}
{if not empty($header_notes)}
<div class="header_notes">
	{foreach from=$header_notes item=elt}
	<p>{$elt}</p>
  	{/foreach}
</div>
{/if}
