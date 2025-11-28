{* Stripped Theme - Simple Album Display (No names, no descriptions) *}
{footer_script}
  var error_icon = "{$ROOT_URL}{$themeconf.icon_dir}/errors_small.png", max_requests = {$maxRequests};
{/footer_script}

{* Simple grid layout for albums - no waterfall, just clean grid *}
{assign var=width value=400}
{assign var=height value=300}
{define_derivative name='derivative_params' width=$width height=$height crop=true}

{* Simple Grid Container for Albums *}
<div id="album-grid" class="album-grid-container">
{foreach from=$category_thumbnails item=cat name=cat_loop}
{assign var=derivative value=$pwg->derivative($derivative_params, $cat.representative.src_image)}
  {if !$derivative->is_cached()}
  {combine_script id='jquery.ajaxmanager' path='themes/default/js/plugins/jquery.ajaxmanager.js' load='footer'}
  {combine_script id='thumbnails.loader' path='themes/default/js/thumbnails.loader.js' require='jquery.ajaxmanager' load='footer'}
  {/if}

<div class="album-item">
    <a href="{$cat.URL}" class="album-link">
        <img class="album-img" 
             {if $derivative->is_cached()}src="{$derivative->get_url()}"{else}src="{$ROOT_URL}{$themeconf.icon_dir}/img_small.png" data-src="{$derivative->get_url()}"{/if} 
             alt="{$cat.TN_ALT}" 
             title="{$cat.NAME|@replace:'"':' '|@strip_tags:false}" 
             loading="lazy"
             style="border-radius: 0 !important; -webkit-border-radius: 0 !important; -moz-border-radius: 0 !important;">
			</a>
		</div>
{/foreach}
	</div>
