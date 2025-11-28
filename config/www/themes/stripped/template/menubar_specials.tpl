<dt>{'Specials'|@translate}</dt>
<dd>
	<ul>{strip}
		{foreach from=$block->data item=link}
      {if isset($link.URL)}
      <li><a href="{$link.URL}" {if isset($link.TITLE)}title="{$link.TITLE}"{/if} {if isset($link.REL)} {$link.REL}{/if}>{$link.NAME}</a></li>
      {/if}
		{/foreach}
	{/strip}</ul>
</dd>
