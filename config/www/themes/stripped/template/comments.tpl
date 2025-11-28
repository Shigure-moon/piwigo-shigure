<div class="titrePage">
	<div class="browsePath">
		<h2>
			{if isset($MENUBAR)}
				<span id="menuswitcher" title="{'Show/hide menu'|@translate}">{'Menu'|@translate}</span><span class="arrow"> »</span>
			{/if}
			<a href="{$U_HOME}">{'Home'|@translate}</a>
			{$LEVEL_SEPARATOR}{'User comments'|@translate}
		</h2>
	</div>
</div>
<div id="content">
	{if isset($MENUBAR)}{$MENUBAR}{/if}
	<div id="content_cell">
		<div class="content_block">
			{include file='infos_errors.tpl'} 
			<form class="filter" action="{$F_ACTION}" method="get">
				<fieldset>
					<legend>{'Filter'|@translate}</legend>
					<label>{'Keyword'|@translate}&nbsp;<input type="text" name="keyword" value="{$F_KEYWORD}">&nbsp;&nbsp;</label>
					<label>{'Author'|@translate}&nbsp;<input type="text" name="author" value="{$F_AUTHOR}">&nbsp;&nbsp;</label>
					<label>
						{'Album'|@translate}
						<select name="cat">
							<option value="0">------------</option>
							{html_options options=$categories selected=$categories_selected}
						</select>&nbsp;
					</label>
					<label>
						{'Since'|@translate}
						<select name="since">
							{html_options options=$since_options selected=$since_options_selected}
						</select>
					</label>
				</fieldset>
				<fieldset>
					<legend>{'Display'|@translate}</legend>
					<label>
						{'Sort by'|@translate}
						<select name="sort_by">
							{html_options options=$sort_by_options selected=$sort_by_options_selected}
						</select>&nbsp;
					</label>
					<label>
						{'Sort order'|@translate}
						<select name="sort_order">
							{html_options options=$sort_order_options selected=$sort_order_options_selected}
						</select>&nbsp;
					</label>
					<label>
						{'Number of items'|@translate}
						<select name="items_number">
							{html_options options=$item_number_options selected=$item_number_options_selected}
						</select>
					</label>
				</fieldset>
				<p><input class="submit" type="submit" value="{'Filter and display'|@translate}"></p>
			</form>
			{if !empty($navbar) }{include file='navigation_bar.tpl'|@get_extent:'navbar'}{/if}
			{if isset($comments)}
				<div id="comments">
				{if isset($COMMENT_LIST)}
					{$COMMENT_LIST}
				{else}
					{include file='comment_list.tpl'}
				{/if}
				</div>
			{/if}
		</div>
	</div>
</div> <!-- content -->