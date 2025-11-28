<div class="titrePage">
	<h2>stripped Theme - Configuration</h2>
</div>

<form method="post" class="properties" action="" name="modern_form">
	<fieldset>
		<legend>{'Modern Gallery Settings'|@translate}</legend>
		<ul>
			<li>
				<label>
					<span class="property">{'Number of random photos per page'|@translate}</span>&nbsp;
					<input type="number" name="random_photos_per_page" value="{$modern_config->random_photos_per_page}" min="1" max="1000" style="width:100px;">
				</label>
			</li>
			<li>
				<label>
					<span class="property">{'Waterfall columns'|@translate}</span>&nbsp;
					<input type="number" name="waterfall_columns" value="{$modern_config->waterfall_columns}" min="2" max="10" style="width:100px;">
				</label>
			</li>
			<li>
				<label>
					<span class="property">{'Gap between items (px)'|@translate}</span>&nbsp;
					<input type="number" name="waterfall_gap" value="{$modern_config->waterfall_gap}" min="0" max="50" style="width:100px;">
				</label>
			</li>
			<li>
				<label>
					<span class="property">{'Minimum column width (px)'|@translate}</span>&nbsp;
					<input type="number" name="min_column_width" value="{$modern_config->min_column_width}" min="100" max="500" style="width:100px;">
				</label>
			</li>
			<li>
				<label>
					<span class="property">{'Layout direction'|@translate}</span>&nbsp;
					<select name="layout_direction" style="min-width:150px;">
						<option value="row" {if isset($modern_config->layout_direction) && $modern_config->layout_direction == 'row'}selected{/if}>{'Row (Justified)'|@translate}</option>
						<option value="column" {if isset($modern_config->layout_direction) && $modern_config->layout_direction == 'column'}selected{/if}>{'Column (Waterfall)'|@translate}</option>
					</select>
				</label>
			</li>
			<li>
				<label>
					<span class="property">{'Target row height (px)'|@translate}</span>&nbsp;
					<input type="number" name="target_row_height" value="{if isset($modern_config->target_row_height)}{$modern_config->target_row_height}{else}300{/if}" min="100" max="1000" style="width:100px;">
					<span style="font-size: 0.9em; color: #666;">{'Only used for row layout'|@translate}</span>
				</label>
			</li>
			<li>
				<label>
					<span class="property">{'Custom CSS'|@translate}</span>
					<textarea name="custom_css" rows="10" cols="80" style="width: 100%; font-family: monospace;">{$modern_config->custom_css}</textarea>
				</label>
			</li>
		</ul>
	</fieldset>
	
	<p><input class="submit" type="submit" value="{'Submit'|@translate}" name="stripped_modern_settings" /></p>
</form>
