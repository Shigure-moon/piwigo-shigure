{combine_script id='core.switchbox' load='async' require='jquery' path='themes/default/js/switchbox.js'}

{if isset($MENUBAR)}{$MENUBAR}{/if}
<div id="content"{if isset($MENUBAR)} class="contentWithMenu"{/if}>

{if isset($errors) or not empty($infos)}
{include file='infos_errors.tpl'}
{/if}

{if !empty($PLUGIN_PICTURE_BEFORE)}{$PLUGIN_PICTURE_BEFORE}{/if}

{* Hide navbar and banner on picture page and add critical CSS *}
{html_head}
{literal}
<style>
/* Hide navbar and banner on picture page */
body#thePicturePage .navbar,
body#thePicturePage .page-header {
  display: none !important;
}

/* Critical CSS for picture page - Weweb Design */
body#thePicturePage {
  background: #000000 !important;
  color: #ffffff !important;
}

body#thePicturePage #the_page {
  background: #000000 !important;
  color: #ffffff !important;
}

body#thePicturePage #content {
  background: #000000 !important;
  color: #ffffff !important;
  width: 100% !important;
  max-width: 100% !important;
}

body#thePicturePage #imageHeaderBar {
  background: transparent !important;
  padding: 1rem 2rem !important;
  color: #ffffff !important;
}

body#thePicturePage #imageHeaderBar .browsePath {
  color: #ffffff !important;
}

body#thePicturePage #imageHeaderBar .browsePath h2 {
  color: #ffffff !important;
  font-size: 24px !important;
  font-weight: 400 !important;
  margin: 0 !important;
}

body#thePicturePage #imageHeaderBar .browsePath a {
  color: #ffffff !important;
  text-decoration: none !important;
}

body#thePicturePage #imageHeaderBar .browsePath a:hover {
  color: #3535cc !important;
}

body#thePicturePage #imageToolBar {
  background: rgba(0, 0, 0, 0.85) !important;
  padding: 1rem 2rem !important;
  border-bottom: 1px solid rgba(255, 255, 255, 0.2) !important;
  color: #ffffff !important;
  display: flex !important;
  align-items: center !important;
  justify-content: space-between !important;
  flex-wrap: wrap !important;
  gap: 1rem !important;
  backdrop-filter: blur(10px) !important;
  -webkit-backdrop-filter: blur(10px) !important;
}

body#thePicturePage #theImage {
  background: #000000 !important;
  padding: 2rem !important;
  text-align: center !important;
}

body#thePicturePage #theImage img {
  max-width: 100% !important;
  height: auto !important;
  border-radius: 0 !important;
  box-shadow: none !important;
  cursor: default !important;
}

body#thePicturePage #theImage img:hover {
  cursor: default !important;
}

body#thePicturePage #theMainImage {
  cursor: default !important;
}

body#thePicturePage #theMainImage:hover {
  cursor: default !important;
}

/* 隐藏悬浮时显示的放大镜图标 */
body#thePicturePage .hd_link {
  display: none !important;
}

body#thePicturePage .hd_link:hover {
  display: none !important;
}

body#thePicturePage .actionButtons {
  display: flex !important;
  align-items: center !important;
  gap: 0.5rem !important;
  flex-wrap: wrap !important;
}

body#thePicturePage .actionButtons .pwg-button {
  color: var(--text-secondary) !important;
  font-size: var(--font-size-sm) !important;
  font-weight: 600 !important;
  letter-spacing: 0.05rem !important;
  padding: 0.6rem 1.5rem !important;
  border-radius: var(--border-radius) !important;
  transition: var(--transition) !important;
  position: relative !important;
  text-decoration: none !important;
  white-space: nowrap !important;
  background: rgba(0, 0, 0, 0.85) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  backdrop-filter: blur(10px) !important;
  -webkit-backdrop-filter: blur(10px) !important;
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  gap: 0.5rem !important;
  box-sizing: border-box !important;
}

body#thePicturePage .actionButtons .pwg-button:hover {
  color: var(--text-primary) !important;
  background: rgba(255, 255, 255, 0.2) !important;
  border-color: rgba(255, 255, 255, 0.4) !important;
  transform: translateY(-2px) !important;
}

body#thePicturePage .actionButtons .pwg-button .pwg-icon {
  display: inline-block !important;
  text-indent: -9999px !important;
  overflow: hidden !important;
  background-repeat: no-repeat !important;
  width: 26px !important;
  height: 26px !important;
  vertical-align: middle !important;
  flex-shrink: 0 !important;
  margin-right: 0.5rem !important;
}

body#thePicturePage .actionButtons .pwg-button .pwg-button-text {
  display: inline-block !important;
  line-height: 1.5 !important;
  vertical-align: middle !important;
}

/* Navigation Buttons - 完全参考首页顶部导航设计 */
body#thePicturePage .navButtons {
  display: flex !important;
  align-items: center !important;
  gap: 0.5rem !important;
  flex-wrap: wrap !important;
}

body#thePicturePage .navButtons .navButton {
  color: var(--text-secondary) !important;
  font-size: var(--font-size-sm) !important;
  font-weight: 600 !important;
  letter-spacing: 0.05rem !important;
  padding: 0.6rem 1.5rem !important;
  border-radius: var(--border-radius) !important;
  transition: var(--transition) !important;
  position: relative !important;
  text-decoration: none !important;
  white-space: nowrap !important;
  background: rgba(0, 0, 0, 0.85) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  backdrop-filter: blur(10px) !important;
  -webkit-backdrop-filter: blur(10px) !important;
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  box-sizing: border-box !important;
  width: auto !important;
  min-width: auto !important;
  max-width: none !important;
  height: auto !important;
  min-height: auto !important;
  max-height: none !important;
}

body#thePicturePage .navButtons .navButton:hover {
  color: var(--text-primary) !important;
  background: rgba(255, 255, 255, 0.2) !important;
  border-color: rgba(255, 255, 255, 0.4) !important;
  transform: translateY(-2px) !important;
}

body#thePicturePage .actionButtons .pwg-button:hover {
  color: var(--text-primary) !important;
  background: rgba(255, 255, 255, 0.2) !important;
  border-color: rgba(255, 255, 255, 0.4) !important;
  transform: translateY(-2px) !important;
}

body#thePicturePage .navButtons #icon_up::before {
  content: "返回" !important;
  display: inline-block !important;
}

body#thePicturePage .navButtons #icon_left::before,
body#thePicturePage .navButtons #icon_left_0::before {
  content: "上一张" !important;
  display: inline-block !important;
}

body#thePicturePage .navButtons #icon_right::before,
body#thePicturePage .navButtons #icon_right_0::before {
  content: "下一张" !important;
  display: inline-block !important;
}

/* Hide empty nav buttons */
body#thePicturePage .navButtons .navButton:empty,
body#thePicturePage .navButtons .navButton:not([href]) {
  display: none !important;
}

body#thePicturePage .navButtons .imageNumber {
  color: var(--text-secondary) !important;
  font-size: var(--font-size-sm) !important;
  font-weight: 600 !important;
  letter-spacing: 0.05rem !important;
  padding: 0.6rem 1.5rem !important;
  border-radius: var(--border-radius) !important;
  background: rgba(0, 0, 0, 0.85) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  backdrop-filter: blur(10px) !important;
  -webkit-backdrop-filter: blur(10px) !important;
  margin: 0 !important;
  white-space: nowrap !important;
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  box-sizing: border-box !important;
}

body#thePicturePage #footer {
  color: #ffffff !important;
}

body#thePicturePage #footer a {
  color: #ffffff !important;
}

body#thePicturePage #footer a:hover {
  color: #3535cc !important;
}
</style>
{/literal}
{/html_head}

<div id="imageHeaderBar">
	<div class="browsePath">
		{$SECTION_TITLE}{if isset($stripped.showTitleOnBrowsePath) && $stripped.showTitleOnBrowsePath}<span class="browsePathSeparator">{$LEVEL_SEPARATOR}</span><h2>{$current.TITLE}</h2>{/if}
	</div>
</div>

<div id="imageToolBar">
{include file='picture_nav_buttons.tpl'|@get_extent:'picture_nav_buttons'}

<div class="actionButtons">
{if isset($current.unique_derivatives) && count($current.unique_derivatives)>1}
{footer_script require='jquery'}{literal}
function changeImgSrc(url,typeSave,typeMap)
{
	var theImg = document.getElementById("theMainImage");
	if (theImg)
	{
		theImg.removeAttribute("width");theImg.removeAttribute("height");
		theImg.src = url;
		theImg.useMap = "#map"+typeMap;
	}
	jQuery('#derivativeSwitchBox .switchCheck').css('visibility','hidden');
	jQuery('#derivativeChecked'+typeMap).css('visibility','visible');
	document.cookie = 'picture_deriv='+typeSave+';path={/literal}{$COOKIE_PATH}{literal}';
}
(window.SwitchBox=window.SwitchBox||[]).push("#derivativeSwitchLink", "#derivativeSwitchBox");
{/literal}{/footer_script}
{strip}<a id="derivativeSwitchLink" title="{'Photo sizes'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
  <span class="pwg-button-text">{'Photo sizes'|@translate}</span>
</a>
<div id="derivativeSwitchBox" class="switchBox">
  <div class="switchBoxTitle">{'Photo sizes'|@translate}</div>
  {foreach from=$current.unique_derivatives item=derivative key=derivative_type}
  <span class="switchCheck" id="derivativeChecked{$derivative->get_type()}"{if $derivative->get_type() ne $current.selected_derivative->get_type()} style="visibility:hidden"{/if}>&#x2714; </span>
  <a href="javascript:changeImgSrc('{$derivative->get_url()|@escape:javascript}','{$derivative_type}','{$derivative->get_type()}')">
    {$derivative->get_type()|@translate}<span class="derivativeSizeDetails"> ({$derivative->get_size_hr()})</span>
  </a><br>
  {/foreach}
  {if isset($U_ORIGINAL)}
    {combine_script id='core.scripts' load='async' path='themes/default/js/scripts.js'}
  <a href="javascript:phpWGOpenWindow('{$U_ORIGINAL}','xxx','scrollbars=yes,toolbar=no,status=no,resizable=yes')" rel="nofollow">{'Original'|@translate}</a>
  {/if}
</div>
{/strip}
{/if}
{strip}{if isset($U_SLIDESHOW_START)}
	<a href="{$U_SLIDESHOW_START}" title="{'slideshow'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
		<span class="pwg-button-text">{'slideshow'|@translate}</span>
	</a>
{/if}{/strip}
{strip}{if isset($U_METADATA)}
	<a href="{$U_METADATA}" title="{'Show file metadata'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
		<span class="pwg-button-text">{'Show file metadata'|@translate}</span>
	</a>
{/if}{/strip}
{strip}{if isset($current.U_DOWNLOAD)}
	<a id="downloadSwitchLink" href="{$current.U_DOWNLOAD}" title="{'Download this file'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
		<span class="pwg-button-text">{'Download'|@translate}</span>
	</a>

{if !empty($current.formats)}
{footer_script require='jquery'}{literal}
jQuery().ready(function() {
  jQuery("#downloadSwitchLink").removeAttr("href");

  (window.SwitchBox=window.SwitchBox||[]).push("#downloadSwitchLink", "#downloadSwitchBox");
});
{/literal}{/footer_script}
<div id="downloadSwitchBox" class="switchBox">
  <div class="switchBoxTitle">{'Download'|@translate}</div>
  {foreach from=$current.formats item=format}
  <a href="{$format.U_DOWNLOAD}" rel="nofollow">{$format.label}</a><br>
  {/foreach}
</div>
{/if}
{/if}{/strip}
{strip}{if isset($U_PHOTO_ADMIN) or isset($U_CADDIE) or !empty($U_SET_AS_REPRESENTATIVE)}
	<a id="adminSwitchLink" href="#" title="{'Administration'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
		<span class="pwg-button-text">{'Administration'|@translate}</span>
	</a>
<div id="adminSwitchBox" class="switchBox">
{if isset($U_PHOTO_ADMIN)}
	<a href="{$U_PHOTO_ADMIN}" title="{'Edit'|@translate}">{$current.TITLE}</a><br>
{/if}
{if isset($U_CADDIE)}
	<a href="{$U_CADDIE}" onclick="addToCadie(this, '{$ROOT_URL}', {$current.id}); return false;" title="{'add to caddie'|@translate}" rel="nofollow">{'caddie'|@translate}</a><br>
{/if}
{if !empty($U_SET_AS_REPRESENTATIVE)}
	<a href="{$U_SET_AS_REPRESENTATIVE}" title="{'set as album representative'|@translate}" rel="nofollow">{'set as album representative'|@translate}</a>
{/if}
</div>
{footer_script}
{literal}function addToCadie(aElement, rootUrl, id)
{
if (aElement.disabled) return;
aElement.disabled=true;
var y = new PwgWS(rootUrl);
y.callService(
	"pwg.caddie.add", {image_id: id} ,
	{
		onFailure: function(num, text) { alert(num + " " + text); document.location=aElement.href; },
		onSuccess: function(result) { aElement.disabled = false; }
	}
	);
}{/literal}
(window.SwitchBox=window.SwitchBox||[]).push("#adminSwitchLink", "#adminSwitchBox");
{/footer_script}
{/if}{/strip}
</div>{*<!-- actionButtons -->*}
</div>{*<!-- imageToolBar -->*}

<div id="theImageAndInfos">
<div id="theImage">
{$ELEMENT_CONTENT}

{* Display image caption based on configuration *}
{if isset($stripped.imageCaption) && $stripped.imageCaption == 'title' && isset($current.TITLE)}
<p class="imageComment">{$current.TITLE}</p>
{elseif isset($stripped.imageCaption) && $stripped.imageCaption == 'description' && isset($COMMENT_IMG)}
<p class="imageComment">{$COMMENT_IMG}</p>
{/if}

{if isset($U_SLIDESHOW_STOP)}
<p>
	[ <a href="{$U_SLIDESHOW_STOP}">{'stop the slideshow'|@translate}</a> ]
</p>
{/if}

</div>{*<!-- theImage -->*}
<div id="infoSwitcher"></div>
<div id="imageInfos">
{* Navigation thumbnails and picture info sections removed - not available in stripped theme *}
{* These sections are optional and will be handled by plugins if needed *}
</div>{*<!-- imageInfos -->*}
</div>{*<!-- theImageAndInfos -->*}

{if !empty($PLUGIN_PICTURE_AFTER)}{$PLUGIN_PICTURE_AFTER}{/if}

</div>{*<!-- content -->*}
