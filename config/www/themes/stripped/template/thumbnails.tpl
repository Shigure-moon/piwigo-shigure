{* Stripped Theme - Waterfall Layout for Photos *}
{footer_script}
  var error_icon = "{$ROOT_URL}{$themeconf.icon_dir}/errors_small.png"{if isset($maxRequests)}, max_requests = {$maxRequests}{/if};
{/footer_script}

{if !empty($thumbnails)}
{* Image dimensions *}
{if $derivative_params->type == "thumb"}
{assign var=width value=520}
{assign var=height value=360}
{else}
{assign var=width value=$derivative_params->sizing->ideal_size[0]}
{assign var=height value=$derivative_params->sizing->ideal_size[1]}
{/if}

{define_derivative name='derivative_params' width=$width height=$height crop=true}
{assign var=idx value=0+$START_ID}

{* Waterfall Gallery Container *}
<div id="waterfall-thumbnails" class="waterfall-gallery">
	{foreach from=$thumbnails item=thumbnail}
{assign var=derivative value=$pwg->derivative($derivative_params, $thumbnail.src_image)}
  {if !$derivative->is_cached()}
  {combine_script id='jquery.ajaxmanager' path='themes/default/js/plugins/jquery.ajaxmanager.js' load='footer'}
  {combine_script id='thumbnails.loader' path='themes/default/js/thumbnails.loader.js' require='jquery.ajaxmanager' load='footer'}
  {/if}

{* Get original image dimensions for aspect ratio calculation *}
{assign var=imgWidth value=$thumbnail.width|default:400}
{assign var=imgHeight value=$thumbnail.height|default:300}

<div class="waterfall-item" data-image-id="{$thumbnail.id}" data-width="{$imgWidth}" data-height="{$imgHeight}" data-url="{$thumbnail.URL}">
    <a href="{$thumbnail.URL}" class="waterfall-link">
        <img class="waterfall-img" 
             {if $derivative->is_cached()}src="{$derivative->get_url()}"{else}src="{$ROOT_URL}{$themeconf.icon_dir}/img_small.png" data-src="{$derivative->get_url()}"{/if} 
             alt="{$thumbnail.TN_ALT}" 
             {if $stripped.showThumbLegend}title="{$thumbnail.TN_TITLE}"{/if}
             loading="lazy"
             width="{$imgWidth}"
             height="{$imgHeight}"
             style="border-radius: 0 !important; -webkit-border-radius: 0 !important; -moz-border-radius: 0 !important;">
    </a>
    {if $stripped.showThumbLegend && !empty($thumbnail.TN_TITLE)}
    <div class="waterfall-caption">{$thumbnail.TN_TITLE}</div>
    {/if}
</div>
{assign var=idx value=$idx+1}
	{/foreach}
</div>
{footer_script require='jquery'}{strip}
// Ensure waterfall layout is initialized after thumbnails are rendered
(function() {
    function initThumbnailsWaterfall() {
        var $container = $('#waterfall-thumbnails');
        if ($container.length > 0 && $container.find('.waterfall-item').length > 0) {
            if (typeof window.WaterfallLayout !== 'undefined') {
                window.WaterfallLayout.init('#waterfall-thumbnails');
            } else if (typeof WaterfallLayout !== 'undefined') {
                WaterfallLayout.init('#waterfall-thumbnails');
            }
            return true;
        }
        return false;
    }
    
    // Try immediately
    if (!initThumbnailsWaterfall()) {
        // If not ready, try after delays
        setTimeout(initThumbnailsWaterfall, 100);
        setTimeout(initThumbnailsWaterfall, 500);
        setTimeout(initThumbnailsWaterfall, 1000);
    }
})();
{/strip}{/footer_script}

{/if}
