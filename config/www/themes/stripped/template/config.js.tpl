{* template for config variables assignation *}
{literal}
<script type="text/javascript">
// configuration options
var options = { {/literal}
	imageAutosize:{if $stripped.imageAutosize}true{else}false{/if},
	imageAutosizeMargin:{$stripped.imageAutosizeMargin},
	imageAutosizeMinHeight:{$stripped.imageAutosizeMinHeight},
{if $BODY_ID=='thePicturePage'}
	themeStyle:"{$stripped.themeStyle}",
	animatedTabs:{if $stripped.animatedTabs}true{else}false{/if},
	defaultTab:"{$stripped.defaultTab}",
	marginContainer:{$stripped.marginContainer},
	paddingContainer:{$stripped.paddingContainer},
	defaultZoomSize:"{$stripped.defaultZoomSize}",
	highResClickMode:"{$stripped.highResClickMode}",
	navArrows:{if $stripped.navArrows}true{else}false{/if}
{else}
	animatedMenu:{if $stripped.animatedMenu}true{else}false{/if}
{/if} 
{literal}
}
</script>
{/literal}