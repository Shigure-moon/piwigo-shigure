<div class="titrePage">
	<div class="browsePath">
		<h2>
			{if isset($MENUBAR)}
				<span id="menuswitcher" title="{'Show/hide menu'|@translate}">{'Menu'|@translate}</span><span class="arrow"> »</span>
			{/if}
			<a href="{$U_HOME}">{'Home'|@translate}</a>
			{$LEVEL_SEPARATOR}{'Notification'|@translate}
		</h2>
	</div>
</div>
<div id="content">
	{if isset($MENUBAR)}{$MENUBAR}{/if}
	<div id="content_cell">
		<div class="content_block">
			{include file='infos_errors.tpl'} 
		</div>
	</div>
</div>