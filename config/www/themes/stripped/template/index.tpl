{* Stripped Theme - Simplified Index Template *}
{* Critical inline CSS to ensure styles load immediately *}
{html_head}
<style type="text/css">
/* Critical CSS - Ensure base styles load immediately */
* {
  box-sizing: border-box;
}

html {
  scroll-behavior: smooth !important;
  -webkit-overflow-scrolling: touch !important;
}

html, body {
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  font-size: 16px;
  background-color: #000000 !important;
  color: #ffffff !important;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  overflow-x: hidden;
  scroll-behavior: smooth !important;
}

/* Album page background image - when thumbnails are displayed */
{if !empty($THUMBNAILS)}
body {
  background-image: url('{$ROOT_URL}themes/stripped/img/weweb/1112.png') !important;
  background-size: cover !important;
  background-position: center center !important;
  background-repeat: no-repeat !important;
  background-attachment: fixed !important;
}
{/if}

#the_page {
  width: 100% !important;
  max-width: 100% !important;
  margin: 0 !important;
  padding: 0 !important;
  min-height: 100vh;
  display: flex !important;
  flex-direction: column !important;
}

/* Navigation */
.navbar {
  background: rgba(0, 0, 0, 0.85) !important;
  border-bottom: 1px solid rgba(255, 255, 255, 0.3) !important;
  padding: 1rem 2rem !important;
  position: sticky !important;
  top: 0 !important;
  z-index: 1000 !important;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  width: 100% !important;
  max-width: 100% !important;
  margin: 0 !important;
  left: 0 !important;
  right: 0 !important;
  display: block !important;
}

.navbar .container-fluid {
  width: 100% !important;
  max-width: 100% !important;
  padding: 0 !important;
  margin: 0 !important;
  display: flex !important;
  justify-content: space-between !important;
  align-items: center !important;
  flex-wrap: wrap !important;
}

.navbar-content {
  display: flex !important;
  align-items: center !important;
  gap: 1.5rem !important;
  flex: 1 !important;
}

.navbar-brand {
  display: flex !important;
  align-items: center !important;
  color: #ffffff !important;
  text-decoration: none !important;
  font-size: 1.5rem !important;
}

.navbar-logo {
  max-height: 50px !important;
  width: auto !important;
  display: block !important;
}

.navbar-nav {
  display: flex !important;
  align-items: center !important;
  gap: 1rem !important;
}

.navbar-nav .nav-link {
  color: rgba(255, 255, 255, 0.9) !important;
  text-decoration: none !important;
  padding: 0.5rem 1rem !important;
  transition: all 0.3s ease !important;
  font-weight: 400 !important;
  font-size: 0.95rem !important;
}

.navbar-nav .nav-link:hover {
  color: #ffffff !important;
  background: rgba(255, 255, 255, 0.1) !important;
  border-radius: 4px !important;
}

.nav-link {
  display: inline-block !important;
  padding: 0.6rem 1.5rem !important;
  background: rgba(0, 0, 0, 0.5) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  border-radius: 10px !important;
  color: #ffffff !important;
  text-decoration: none !important;
  font-size: 0.9rem !important;
  font-weight: 600 !important;
  transition: all 0.3s ease !important;
}

.nav-link:hover {
  background: rgba(255, 255, 255, 0.2) !important;
  border-color: rgba(255, 255, 255, 0.4) !important;
  transform: translateY(-2px) !important;
}

/* Content */
#content {
  width: 100% !important;
  max-width: 100% !important;
  margin: 0 !important;
  padding: 2rem !important;
  display: block !important;
  color: #ffffff !important;
  background: transparent !important;
}

#content_cell {
  width: 100% !important;
  display: block !important;
  color: #ffffff !important;
  background: transparent !important;
}

#subcontent {
  width: 100% !important;
  display: block !important;
  color: #ffffff !important;
  background: transparent !important;
}

/* All text in content should be white */
#content, #content_cell, #subcontent,
#content *, #content_cell *, #subcontent * {
  color: #ffffff !important;
}

#content a, #content_cell a, #subcontent a {
  color: #ffffff !important;
  text-decoration: none !important;
}

#content a:hover, #content_cell a:hover, #subcontent a:hover {
  color: #3535cc !important;
}

/* Waterfall Gallery */
.waterfall-gallery,
#waterfall-thumbnails {
  position: relative !important;
  width: 100% !important;
  max-width: 100% !important;
  display: block !important;
  min-height: 200px !important;
  margin: 2rem 0 !important;
  padding: 0 2rem !important;
  box-sizing: border-box !important;
}

/* Ensure thumbnail containers don't limit width */
#thumbnails_block1,
#thumbnails_block2,
#thumbnails,
.thumbnails {
  width: 100% !important;
  max-width: 100% !important;
  margin: 0 !important;
  padding: 0 !important;
  box-sizing: border-box !important;
}


.waterfall-item {
  position: absolute !important;
  display: block !important;
  margin: 0 !important;
  padding: 0 !important;
}

.waterfall-link {
  display: block !important;
  width: 100% !important;
  height: 100% !important;
  text-decoration: none !important;
  overflow: hidden !important;
}

.waterfall-img {
  width: 100% !important;
  height: auto !important;
  display: block !important;
}

/* Album Grid */
.album-grid-container {
  display: grid !important;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)) !important;
  gap: 8px !important;
  width: 100% !important;
  max-width: 100% !important;
  margin: 2rem 0 !important;
  padding: 0 2rem !important;
}

.album-item {
  position: relative !important;
  width: 100% !important;
  display: block !important;
  overflow: hidden !important;
  background: rgba(0, 0, 0, 0.9) !important;
  border: 1px solid rgba(255, 255, 255, 0.3) !important;
  border-radius: 0 !important;
  -webkit-border-radius: 0 !important;
  -moz-border-radius: 0 !important;
}

.album-link {
  display: block !important;
  width: 100% !important;
  height: 100% !important;
  text-decoration: none !important;
}

.album-img {
  width: 100% !important;
  height: auto !important;
  display: block !important;
}

/* Title */
.titrePage {
  width: 100% !important;
  padding: 2rem 0 !important;
  display: block !important;
}

.titrePage h2 {
  color: #ffffff !important;
  font-size: 2rem !important;
  margin: 0 !important;
  font-family: 'DM Serif Display', Georgia, serif !important;
}

.titrePage h2 a,
.titrePage h2 a:link,
.titrePage h2 a:visited,
.titrePage h2 a:active,
.titrePage .browsePath h2 a,
.titrePage .browsePath h2 a:link,
.titrePage .browsePath h2 a:visited,
.titrePage .browsePath h2 a:active {
  color: #ffffff !important;
  text-decoration: none !important;
  transition: all 0.3s ease !important;
  font-weight: 400 !important;
  display: inline-block !important;
}

.titrePage h2 a:hover,
.titrePage .browsePath h2 a:hover {
  color: #3535cc !important;
}

/* Browse Path */
.browsePath {
  color: #ffffff !important;
  width: 100% !important;
  display: block !important;
}

.browsePath * {
  color: #ffffff !important;
}

.browsePath h2 {
  color: #ffffff !important;
  font-size: 2rem !important;
  margin: 0 !important;
  padding: 0 !important;
  font-family: 'DM Serif Display', Georgia, serif !important;
  font-weight: 400 !important;
  line-height: 1.2 !important;
}

.browsePath h2 a,
.browsePath h2 a:link,
.browsePath h2 a:visited,
.browsePath h2 a:active {
  color: #ffffff !important;
  text-decoration: none !important;
  transition: all 0.3s ease !important;
  font-weight: 400 !important;
  display: inline-block !important;
  cursor: pointer !important;
}

.browsePath h2 a:hover {
  color: #3535cc !important;
}

.browsePath a {
  color: #ffffff !important;
  text-decoration: none !important;
}

.browsePath a:link {
  color: #ffffff !important;
}

.browsePath a:visited {
  color: #ffffff !important;
}

.browsePath a:hover {
  color: #3535cc !important;
}

.browsePath a:active {
  color: #3535cc !important;
}

/* Page Header / Banner */
.page-header {
  height: 100vh !important;
  max-height: none !important;
  min-height: 100vh !important;
  padding: 0 !important;
  color: rgba(255, 255, 255, 0.9) !important;
  position: relative !important;
  background-position: center center !important;
  background-size: cover !important;
  margin-bottom: 0 !important;
  display: block !important;
  overflow: hidden !important;
  width: 100% !important;
  max-width: 100% !important;
  margin-left: 0 !important;
  margin-right: 0 !important;
  left: 0 !important;
  right: 0 !important;
}

.page-header .page-header-image {
  position: absolute !important;
  top: 0 !important;
  left: 0 !important;
  background-size: cover !important;
  background-position: center center !important;
  background-repeat: no-repeat !important;
  width: 100% !important;
  height: 100% !important;
  z-index: 1 !important;
  opacity: 1 !important;
  visibility: visible !important;
}

.page-header > .container {
  height: 100% !important;
  z-index: 3 !important;
  text-align: center !important;
  position: relative !important;
  width: 100% !important;
  max-width: 100% !important;
  margin: 0 !important;
  padding: 0 var(--container-padding, 2rem) !important;
  box-sizing: border-box !important;
}

.page-header > .container > .content-center {
  position: absolute !important;
  top: 50% !important;
  left: 0 !important;
  transform: translateY(-50%) !important;
  text-align: left !important;
  padding: 0 5vw !important;
  color: #fff !important;
  width: 100% !important;
  max-width: 100% !important;
  display: block !important;
  visibility: visible !important;
  z-index: 10 !important;
}

.page-header > .container > .content-center h1,
.page-header > .container > .content-center p {
  color: #ffffff !important;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5) !important;
}

.page-header:before {
  position: absolute !important;
  z-index: 2 !important;
  width: 100% !important;
  height: 100% !important;
  display: block !important;
  left: 0 !important;
  top: 0 !important;
  content: "" !important;
  background-color: rgba(0, 0, 0, 0.4) !important;
}

/* Hide default Piwigo elements */
#menubar, #menuswitcher {
  display: none !important;
}

/* Hide default #theHeader only if not inside page-header */
#theHeader:not(.content-center) {
  display: none !important;
}

/* Hide titrePage browsePath (Home link) - moved to navbar */
.titrePage .browsePath {
  display: none !important;
  visibility: hidden !important;
  height: 0 !important;
  margin: 0 !important;
  padding: 0 !important;
  overflow: hidden !important;
}

/* Hide titrePage if it only contains browsePath with home link */
.titrePage:has(.browsePath h2 a[href="/"]) {
  display: none !important;
  visibility: hidden !important;
  height: 0 !important;
  margin: 0 !important;
  padding: 0 !important;
  overflow: hidden !important;
}

/* Ensure page-header and its content are visible */
.page-header {
  display: block !important;
  visibility: visible !important;
}

.page-header #theHeader.content-center {
  display: block !important;
  visibility: visible !important;
}

/* Footer - Weweb Style - Reduced Height */
#footer {
  width: 100% !important;
  max-width: 100% !important;
  margin: auto 0 0 0 !important;
  padding: 0.5rem var(--container-padding, 2rem) !important;
  background: transparent !important;
  border-top: 1px solid rgba(255, 255, 255, 0.1) !important;
  display: flex !important;
  flex-direction: column !important;
  gap: 0.5rem !important;
  align-items: stretch !important;
  box-sizing: border-box !important;
  justify-content: space-between !important;
  margin-top: auto !important;
}

@media (min-width: 768px) {
  #footer {
    flex-direction: row !important;
    align-items: center !important;
  }
}

#footer_left {
  display: flex !important;
  flex-wrap: wrap !important;
  align-items: center !important;
  gap: 0.5rem !important;
  justify-content: center !important;
  font-size: 0.875rem !important;
  font-weight: 300 !important;
  letter-spacing: 0.02em !important;
  color: rgba(255, 255, 255, 0.7) !important;
  text-align: center !important;
  flex: 1 !important;
  padding: 0.25rem 0 !important;
}

@media (min-width: 768px) {
  #footer_left {
    justify-content: flex-start !important;
    text-align: left !important;
  }
}

#footer_left a {
  color: rgba(255, 255, 255, 0.7) !important;
  text-decoration: none !important;
  transition: all 0.3s ease !important;
  padding: 0.2rem 0.5rem !important;
  border-radius: 4px !important;
  font-weight: 400 !important;
}

#footer_left a:hover {
  color: #ffffff !important;
  background: rgba(255, 255, 255, 0.1) !important;
}

#footer_left .footer_login,
#footer_left .footer_customize {
  color: rgba(255, 255, 255, 0.7) !important;
  font-weight: 300 !important;
}

#footer_left .footer_login a,
#footer_left .footer_customize a {
  color: rgba(255, 255, 255, 0.7) !important;
  font-weight: 400 !important;
}

#footer_left .footer_login a:hover,
#footer_left .footer_customize a:hover {
  color: #ffffff !important;
  background: rgba(255, 255, 255, 0.1) !important;
}

#copyright {
  display: flex !important;
  flex-wrap: wrap !important;
  align-items: center !important;
  gap: 0.5rem !important;
  justify-content: center !important;
  font-size: 0.875rem !important;
  font-weight: 300 !important;
  letter-spacing: 0.02em !important;
  color: rgba(255, 255, 255, 0.6) !important;
  text-align: center !important;
  width: 100% !important;
  max-width: 100% !important;
  margin: 0 !important;
  padding: 0.25rem 0 !important;
  box-sizing: border-box !important;
  flex-shrink: 0 !important;
}

@media (min-width: 768px) {
  #copyright {
    justify-content: flex-end !important;
    text-align: right !important;
    width: auto !important;
    flex: 0 0 auto !important;
  }
}

#copyright a {
  color: rgba(255, 255, 255, 0.7) !important;
  text-decoration: none !important;
  transition: all 0.3s ease !important;
  padding: 0.25rem 0.5rem !important;
  border-radius: 4px !important;
  font-weight: 400 !important;
}

#copyright a:hover {
  color: #ffffff !important;
  background: rgba(255, 255, 255, 0.1) !important;
}

#copyright .Piwigo {
  color: rgba(255, 255, 255, 0.7) !important;
  font-weight: 500 !important;
  letter-spacing: 0.05em !important;
}

#copyright .Piwigo:hover {
  color: #ffffff !important;
}

/* Footer separators - use spacing instead of pseudo-elements */
#footer_left > *:not(:last-child)::after,
#copyright > *:not(:last-child)::after {
  content: "" !important;
}

#footer_left span,
#copyright span {
  color: rgba(255, 255, 255, 0.6) !important;
  font-weight: 300 !important;
}

/* All links should be white by default */
a {
  color: #ffffff !important;
  text-decoration: none !important;
}

a:link {
  color: #ffffff !important;
}

a:visited {
  color: #ffffff !important;
}

a:hover {
  color: #3535cc !important;
}

a:active {
  color: #3535cc !important;
}

/* Force all h2 links to be white - including nested in titrePage and browsePath */
h2 a,
h2 a:link,
h2 a:visited,
h2 a:active,
.titrePage h2 a,
.titrePage h2 a:link,
.titrePage h2 a:visited,
.titrePage h2 a:active,
.browsePath h2 a,
.browsePath h2 a:link,
.browsePath h2 a:visited,
.browsePath h2 a:active,
.titrePage .browsePath h2 a,
.titrePage .browsePath h2 a:link,
.titrePage .browsePath h2 a:visited,
.titrePage .browsePath h2 a:active {
  color: #ffffff !important;
  text-decoration: none !important;
  font-weight: 400 !important;
  display: inline-block !important;
  cursor: pointer !important;
}

h2 a:hover,
.titrePage h2 a:hover,
.browsePath h2 a:hover,
.titrePage .browsePath h2 a:hover {
  color: #3535cc !important;
}

/* Footer login and customize */
.footer_login, .footer_customize {
  color: #ffffff !important;
}

.footer_login a, .footer_customize a {
  color: #ffffff !important;
}

.footer_login a:hover, .footer_customize a:hover {
  color: #3535cc !important;
}

/* Browse path - Enhanced for nested structure */
.browsePath {
  color: #ffffff !important;
  width: 100% !important;
  display: block !important;
}

.browsePath * {
  color: #ffffff !important;
}

.browsePath h2 {
  color: #ffffff !important;
  font-size: 2rem !important;
  margin: 0 !important;
  padding: 0 !important;
  font-family: 'DM Serif Display', Georgia, serif !important;
  font-weight: 400 !important;
}

.browsePath h2 a,
.browsePath h2 a:link,
.browsePath h2 a:visited,
.browsePath h2 a:active {
  color: #ffffff !important;
  text-decoration: none !important;
  font-weight: 400 !important;
  display: inline-block !important;
  cursor: pointer !important;
  transition: all 0.3s ease !important;
}

.browsePath a {
  color: #ffffff !important;
  text-decoration: none !important;
}

.browsePath a:hover,
.browsePath h2 a:hover {
  color: #3535cc !important;
}

/* Piwigo brand */
.Piwigo {
  color: #ffffff !important;
}

/* Ensure all text is white */
body, p, span, div, li, td, th {
  color: #ffffff !important;
}

/* Override any blue link colors */
a:link {
  color: #ffffff !important;
}
</style>
{/html_head}

{* Background Image - Hardcoded *}
{html_head}
<style type="text/css">
html {
  background-image: url('{$ROOT_URL}themes/stripped/img/weweb/1112.png') !important;
  background-size: cover !important;
  background-position: center !important;
  background-repeat: no-repeat !important;
  background-attachment: fixed !important;
  background-color: #000000 !important;
  min-height: 100% !important;
}

body {
  background-image: url('{$ROOT_URL}themes/stripped/img/weweb/1112.png') !important;
  background-size: cover !important;
  background-position: center !important;
  background-repeat: no-repeat !important;
  background-attachment: fixed !important;
  background-color: #000000 !important;
  min-height: 100vh !important;
}

#the_page, #content, #content_cell, #subcontent {
  background: transparent !important;
}
</style>
{/html_head}

{* Custom CSS *}
{if isset($custom_css) && !empty($custom_css)}
{html_head}
<style type="text/css">
{$custom_css}
</style>
{/html_head}
{/if}

<div class="titrePage">
	<div class="browsePath">
		<h2>{$TITLE}</h2>
	</div>
</div>

<div id="content" class="menuShown">
	{$MENUBAR}
	<div id="content_cell">
		{include file='infos_errors.tpl'} 
		{if !empty($PLUGIN_INDEX_CONTENT_BEFORE)}<div class="subcontent">{$PLUGIN_INDEX_CONTENT_BEFORE}</div>{/if}
		<div id="subcontent">
			{* Categories (Albums) - Simple display, no names/descriptions *}
			{if !empty($CATEGORIES) }
				{$CATEGORIES}
				{if !empty($cats_navbar)}
					<div class="pagination-container">
						{include file='navigation_bar.tpl'|@get_extent:'navbar' navbar=$cats_navbar}
					</div>
				{/if}
			{/if}

			{* Thumbnails (Photos) - Waterfall layout with infinite scroll *}
			{if !empty($THUMBNAILS) }
				<div id="thumbnails_block1">
					<div id="thumbnails_block2">
						<div class="thumbnails" id="thumbnails">{$THUMBNAILS}</div>
					</div>
					{if !empty($thumb_navbar) }
						<div class="pagination-container">
							{include file='navigation_bar.tpl'|@get_extent:'navbar' navbar=$thumb_navbar}
						</div>
					{/if}
				</div>
			{else if !empty($SEARCH_ID)}
				<div class="empty-state">
					<p>{'No results are available.'|@translate}</p>
				</div>
			{/if}
			
			{if !empty($PLUGIN_INDEX_CONTENT_END) }<div class="content_block">{$PLUGIN_INDEX_CONTENT_END}</div>{/if}
		</div> <!-- subcontent -->
		{if !empty($PLUGIN_INDEX_CONTENT_AFTER)}<div class="subcontent">{$PLUGIN_INDEX_CONTENT_AFTER}</div>{/if}
	</div>
	<div style="clear: both;"></div>
</div>

{* Pass waterfall config to JavaScript *}
{if isset($theme_config)}
{footer_script require='jquery'}{strip}
// Set waterfall layout configuration
if (typeof WaterfallLayout !== 'undefined') {
    WaterfallLayout.setConfig({
        waterfall_columns: {if isset($theme_config->waterfall_columns)}{$theme_config->waterfall_columns}{else}4{/if},
        min_column_width: {if isset($theme_config->min_column_width)}{$theme_config->min_column_width}{else}250{/if},
        waterfall_gap: {if isset($theme_config->waterfall_gap)}{$theme_config->waterfall_gap}{else}5{/if},
        direction: {if isset($theme_config->layout_direction)}'{$theme_config->layout_direction}'{else}'row'{/if},
        targetRowHeight: {if isset($theme_config->target_row_height)}{$theme_config->target_row_height}{else}300{/if}
    });
}
{/strip}{/footer_script}
{/if}
