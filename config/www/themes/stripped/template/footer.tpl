			<div id="footer">
				<div id="footer_left">
					{if isset($USERNAME)}
						<div class="footer_login">
							{if isset($U_PROFILE)}
								<div class="footer_customize">
									<a href="{$U_PROFILE}" title="{'customize the appareance of the gallery'|@translate}">{$USERNAME}</a>
								</div>
							{else}
								<span>{$USERNAME}</span>
							{/if}
						</div>
					{/if}

					{if isset($U_LOGIN)}
						<a href="{$U_LOGIN}" rel="nofollow">{'Login'|@translate}</a>
					{/if}
					
					{if isset($U_REGISTER)}
						<a href="{$U_REGISTER}" title="{'Create a new account'|@translate}" rel="nofollow">{'Register'|@translate}</a>
					{/if}

					{if isset($U_LOGOUT)}
						<a href="{$U_LOGOUT}">{'Logout'|@translate}</a>
					{/if}

					{if isset($U_ADMIN)}
						<a href="{$U_ADMIN}" title="{'available for administrators only'|@translate}">{'Administration'|@translate}</a>
					{/if}

					{get_combined_scripts load='footer'}

					{if isset($footer_elements)}
						{foreach from=$footer_elements item=v}
							{$v}
						{/foreach}
					{/if}
				</div>
				
				<div id="copyright">
					{*
						Please, do not remove this copyright. If you really want to,
								contact us on http://piwigo.org to find a solution on how
								to show the origin of the script...
					*}
					<span>{'Powered by'|@translate}</span>
					<a href="{$U_HOME}" class="Piwigo"><span class="Piwigo">shigure</span></a>
					<span>{$VERSION}</span>

					{if isset($CONTACT_MAIL)}
						<span> - </span>
						<span>{'Contact'|@translate}</span>
						<a href="mailto:{$CONTACT_MAIL}?subject={'A comment on your site'|@translate|@escape:url}">{'Webmaster'|@translate}</a>
					{/if}

					{if isset($TOGGLE_MOBILE_THEME_URL)}
						<span> - </span>
						<span>{'View in'|@translate}:</span>
						<a href="{$TOGGLE_MOBILE_THEME_URL}">{'Mobile'|@translate}</a>
						<span> | </span>
						<span>{'Desktop'|@translate}</span>
					{/if}

					{if isset($debug.TIME) }
						<span> - </span>
						<span>{'Page generated in'|@translate} {$debug.TIME} ({$debug.NB_QUERIES} {'SQL queries in'|@translate} {$debug.SQL_TIME})</span>
					{/if}

				</div>{* copyright *}
			</div>
		</div>{* the_page *}
		{if isset($debug.QUERIES_LIST)}
			<div id="debug">
				{$debug.QUERIES_LIST}
			</div>
		{/if}
	</body>
</html>
