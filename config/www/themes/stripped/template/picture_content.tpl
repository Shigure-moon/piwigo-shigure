{* Use selected_derivative if available, otherwise use first available derivative *}
{if isset($current.selected_derivative)}
	{assign var='derivative' value=$current.selected_derivative}
{else}
	{* Fallback: use first available derivative from unique_derivatives *}
	{assign var='derivative' value=null}
	{if isset($current.unique_derivatives) && count($current.unique_derivatives) > 0}
		{foreach from=$current.unique_derivatives item=deriv key=derivative_type}
			{if $derivative == null}
				{assign var='derivative' value=$deriv}
			{/if}
		{/foreach}
	{/if}
{/if}

{if isset($derivative) && $derivative != null}
{if ((!isset($stripped.HDlightbox)) or ($stripped.HDlightbox))}
	{assign var='HDlightbox' value=true}
{/if}

{if isset($HDlightbox)}
	{if isset($stripped.hdSize) && ($stripped.hdSize == 'original')}
		{if isset($U_ORIGINAL)}
			{assign var='displayHD' value=true}
			{assign var='HD_url' value=$U_ORIGINAL}
		{else}
			{foreach from=$current.unique_derivatives item=deriv key=derivative_type}
				{if ($deriv->get_type() == 'Original')}
					{assign var='HD_url' value=$deriv->get_url()}
					{if ($deriv->get_size() != $derivative->get_size())}
						{assign var='displayHD' value=true}
					{/if}
				{/if}
			{/foreach}
		{/if}
	{else}
		{* Use largest available derivative as HD *}
		{assign var='HDderivative' value=null}
		{assign var='maxWidth' value=0}
		{if isset($current.unique_derivatives) && count($current.unique_derivatives) > 0}
			{foreach from=$current.unique_derivatives item=deriv key=derivative_type}
				{assign var='derivSize' value=$deriv->get_size()}
				{assign var='derivWidth' value=$derivSize[0]}
				{if !isset($HD_url) or ($derivWidth > $maxWidth)}
					{assign var='HDderivative' value=$deriv}
					{assign var='HD_url' value=$deriv->get_url()}
					{assign var='maxWidth' value=$derivWidth}
				{/if}
			{/foreach}
			{if isset($HD_url) && isset($HDderivative)}
				{assign var='HDderivSize' value=$HDderivative->get_size()}
				{assign var='derivSize' value=$derivative->get_size()}
				{if ($HDderivSize != $derivSize)}
					{assign var='displayHD' value=true}
				{/if}
			{/if}
		{/if}
	{/if}
	{if isset($stripped.forceLightboxOn) and ($stripped.forceLightboxOn)}
		{assign var='displayHD' value=true}
		{if !isset($HD_url)}
			{assign var='HD_url' value=$derivative->get_url()}
		{/if}
	{/if}
	{if isset($displayHD)}
		{if ($HDShadowbox_loaded)}
			{assign var='pwghigh' value=true}
		{else}
			{assign var='winhigh' value=true}
		{/if}
	{/if}
{/if}

<div id="theImg" {if isset($stripped.imageFrame) && $stripped.imageFrame}class="img_frame"{/if}>
	{if isset($displayHD)}
		{if isset($pwghigh)}<a href="{$HD_url}" rel="shadowbox" class="hd_link">&nbsp;</a>{/if}
		{if isset($winhigh)}<div onclick="openDisplayHigh('{$HD_url}');" class="hd_link">&nbsp;</div>{/if}
		{if isset($stripped.imagePreloadHD) && $stripped.imagePreloadHD}<div class="preload" style="display:none;">{$HD_url}</div>{/if}
	{/if}
	{if isset($stripped.imageArrows) && $stripped.imageArrows}
		{if isset($U_UP)}
			<a href="{$U_UP}" class="img_nav cat_up" alt="{'Thumbnails'|@translate}">&nbsp;</a>
		{/if}
		{if isset($previous)}
			<a href="{$previous.U_IMG}" class="img_nav img_prev" alt="{$previous.TITLE}">&nbsp;</a>
		{/if}
		{if isset($next)}
			<a href="{$next.U_IMG}" class="img_nav img_next" alt="{$next.TITLE}">&nbsp;</a>
		{/if}
	{/if}
	<img src="{$derivative->get_url()}" {$derivative->get_size_htm()} alt="{$ALT_IMG}" id="theMainImage" class="hideTabs">
</div>
{else}
{* Error fallback: show error message or use default template *}
<div id="theImg" class="img_frame">
	<p>{'Error loading image'|@translate}</p>
</div>
{/if}
