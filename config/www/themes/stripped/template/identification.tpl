{* Critical inline CSS for login page - ensures styles load immediately *}
{html_head}
<style type="text/css">
/* Golden Ratio Layout: Left 38.2% (login form), Right 61.8% (background image) */

body {
  margin: 0 !important;
  padding: 0 !important;
  min-height: 100vh !important;
  overflow-x: hidden !important;
  background: #000000 !important;
}

#the_page {
  background: #000000 !important;
  max-width: 100% !important;
  width: 100% !important;
  margin: 0 !important;
  padding: 0 !important;
}

/* Login Page Critical Styles - Scoped to login page only */
.login-page-content .titrePage {
  display: none !important;
  visibility: hidden !important;
  height: 0 !important;
  margin: 0 !important;
  padding: 0 !important;
  overflow: hidden !important;
}

#content.login-page-content {
  max-width: 100% !important;
  width: 100% !important;
  margin: 0 !important;
  padding: 0 !important;
  background: #000000 !important;
  position: relative !important;
  display: flex !important;
  min-height: 100vh !important;
  height: 100vh !important;
  overflow: hidden !important;
}

/* Left side - 38.2% (Golden Ratio) - Pure black login form */
#content.login-page-content #content_cell {
  width: 38.2% !important;
  max-width: 38.2% !important;
  background: #000000 !important;
  min-height: 100vh !important;
  height: 100vh !important;
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  position: fixed !important;
  left: 0 !important;
  top: 0 !important;
  z-index: 2 !important;
  flex-shrink: 0 !important;
  margin: 0 !important;
  padding: 0 !important;
  box-sizing: border-box !important;
}

#content.login-page-content .content_block.login-form-container {
  width: 100% !important;
  max-width: 100% !important;
  padding: 3rem 4rem !important;
  display: flex !important;
  justify-content: center !important;
  align-items: center !important;
  min-height: 100vh !important;
  height: 100vh !important;
  margin: 0 !important;
  background: #000000 !important;
}

/* Right side - 61.8% (Golden Ratio) - Background image */
#content.login-page-content::after {
  content: '' !important;
  position: fixed !important;
  top: 0 !important;
  right: 0 !important;
  width: 61.8% !important;
  height: 100vh !important;
  min-height: 100vh !important;
  background-image: url('{$ROOT_URL}themes/stripped/img/weweb/2222.jpeg') !important;
  background-size: cover !important;
  background-position: center center !important;
  background-repeat: no-repeat !important;
  z-index: 1 !important;
  pointer-events: none !important;
}

.login-form-wrapper {
  width: 100% !important;
  max-width: 420px !important;
  background: transparent !important;
  border: none !important;
  border-radius: 0 !important;
  padding: 0 !important;
  box-shadow: none !important;
  position: relative !important;
  z-index: 2 !important;
}

.login-form {
  width: 100% !important;
}

.login-title {
  font-family: 'DM Serif Display', Georgia, serif !important;
  font-size: 36px !important;
  font-weight: 400 !important;
  color: #ffffff !important;
  text-align: center !important;
  margin: 0 0 3rem 0 !important;
  letter-spacing: -0.02em !important;
  line-height: 1.2 !important;
}

.login-form .form-group {
  margin-bottom: 1.75rem !important;
}

.login-form label {
  display: block !important;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
  font-size: 13px !important;
  font-weight: 500 !important;
  color: rgba(255, 255, 255, 0.85) !important;
  margin-bottom: 0.75rem !important;
  letter-spacing: 0.02em !important;
  text-transform: uppercase !important;
}

.login-form .form-input,
.login-form input[type="text"],
.login-form input[type="password"] {
  width: 100% !important;
  padding: 1rem 1.25rem !important;
  background: rgba(255, 255, 255, 0.08) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  border-radius: 8px !important;
  color: #ffffff !important;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
  font-size: 15px !important;
  line-height: 1.5 !important;
  box-sizing: border-box !important;
  transition: all 0.3s ease !important;
}

.login-form .form-input:focus,
.login-form input[type="text"]:focus,
.login-form input[type="password"]:focus {
  outline: none !important;
  border-color: #3535cc !important;
  background: rgba(255, 255, 255, 0.12) !important;
  box-shadow: 0 0 0 3px rgba(53, 53, 204, 0.15) !important;
}

.login-form .form-input::placeholder,
.login-form input[type="text"]::placeholder,
.login-form input[type="password"]::placeholder {
  color: rgba(255, 255, 255, 0.4) !important;
  opacity: 1 !important;
}

.login-form .submit-group {
  margin-top: 2.5rem !important;
  margin-bottom: 0 !important;
}

.login-form .submit-btn,
.login-form input[type="submit"] {
  width: 100% !important;
  padding: 1.125rem 2rem !important;
  background: #3535cc !important;
  border: none !important;
  border-radius: 8px !important;
  color: #ffffff !important;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
  font-size: 15px !important;
  font-weight: 600 !important;
  letter-spacing: 0.05em !important;
  cursor: pointer !important;
  text-transform: uppercase !important;
  box-shadow: 0 4px 16px rgba(53, 53, 204, 0.3) !important;
  transition: all 0.3s ease !important;
}

.login-form .submit-btn:hover,
.login-form input[type="submit"]:hover {
  background: #4FB7DD !important;
  transform: translateY(-2px) !important;
  box-shadow: 0 6px 24px rgba(79, 183, 221, 0.4) !important;
}

.login-form .submit-btn:active,
.login-form input[type="submit"]:active {
  transform: translateY(0) !important;
}

.login-form .checkbox-group {
  margin-top: 0.5rem !important;
  margin-bottom: 0 !important;
}

.login-form .checkbox-label {
  display: flex !important;
  align-items: center !important;
  cursor: pointer !important;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
  font-size: 14px !important;
  color: rgba(255, 255, 255, 0.8) !important;
  margin-bottom: 0 !important;
}

.login-form .checkbox-label input[type="checkbox"] {
  width: 18px !important;
  height: 18px !important;
  margin-right: 0.75rem !important;
  cursor: pointer !important;
  accent-color: #3535cc !important;
  flex-shrink: 0 !important;
}

.login-links {
  text-align: center !important;
  margin-top: 2rem !important;
  padding-top: 2rem !important;
  border-top: 1px solid rgba(255, 255, 255, 0.15) !important;
}

.login-link {
  color: rgba(255, 255, 255, 0.7) !important;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
  font-size: 14px !important;
  text-decoration: none !important;
  transition: color 0.3s ease !important;
}

.login-link:hover {
  color: #3535cc !important;
  text-decoration: none !important;
}

.link-separator {
  color: rgba(255, 255, 255, 0.4) !important;
  margin: 0 0.75rem !important;
  opacity: 0.6 !important;
}

.login-page-content fieldset {
  border: none !important;
  padding: 0 !important;
  margin: 0 !important;
}

.login-page-content fieldset legend {
  display: none !important;
}

/* Hide navbar and menubar on login page - Use body selector to ensure it only applies on this page */
body .navbar,
body nav.navbar {
  display: none !important;
  visibility: hidden !important;
  height: 0 !important;
  margin: 0 !important;
  padding: 0 !important;
  overflow: hidden !important;
}

body #menubar,
body .menubar,
body #menuswitcher {
  display: none !important;
  visibility: hidden !important;
  height: 0 !important;
  margin: 0 !important;
  padding: 0 !important;
  overflow: hidden !important;
}

/* Responsive Design - Mobile */
@media (max-width: 1024px) {
  /* On smaller screens, stack vertically: background on top, form on bottom */
  #content.login-page-content {
    flex-direction: column !important;
  }
  
  /* Background image on top (mobile) */
  #content.login-page-content::after {
    position: absolute !important;
    width: 100% !important;
    height: 50vh !important;
    min-height: 50vh !important;
    top: 0 !important;
    left: 0 !important;
    right: 0 !important;
    z-index: 1 !important;
  }
  
  /* Login form on bottom (mobile) */
  #content.login-page-content #content_cell {
    width: 100% !important;
    max-width: 100% !important;
    min-height: 50vh !important;
    height: auto !important;
    margin-top: 50vh !important;
    padding: 0 !important;
    order: 2 !important;
    position: relative !important;
    left: auto !important;
    top: auto !important;
  }
  
  #content.login-page-content .content_block.login-form-container {
    min-height: auto !important;
    padding: 3rem 2rem !important;
    align-items: flex-start !important;
    justify-content: flex-start !important;
  }
  
  .login-form-wrapper {
    width: 100% !important;
    max-width: 100% !important;
    background: rgba(0, 0, 0, 0.95) !important;
    backdrop-filter: blur(10px) !important;
    -webkit-backdrop-filter: blur(10px) !important;
    border-radius: 0 !important;
    padding: 2.5rem 2rem !important;
  }
}
</style>
{/html_head}

{* Hide titrePage on login page *}
<div class="titrePage" style="display: none !important; visibility: hidden !important;">
	<div class="browsePath">
		<h2>
			{if isset($MENUBAR)}
				<span id="menuswitcher" title="{'Show/hide menu'|@translate}">{'Menu'|@translate}</span><span class="arrow"> »</span>
			{/if}
			<a href="{$U_HOME}">{'Home'|@translate}</a>
			{$LEVEL_SEPARATOR}{'Identification'|@translate}
		</h2>
	</div>
</div>
<div id="content" class="login-page-content">
	{* Hide MENUBAR (sidebar) on login page *}
	<div id="content_cell">
		<div class="content_block login-form-container">
			{include file='infos_errors.tpl'} 
			<div class="login-form-wrapper">
				<form action="{$F_LOGIN_ACTION}" method="post" name="login_form" class="login-form">
					<h2 class="login-title">{'Connection settings'|@translate}</h2>
					<input type="hidden" name="redirect" value="{$U_REDIRECT|urlencode}">
					<div class="form-group">
						<label for="username">{'Username'|@translate}</label>
						<input tabindex="1" class="form-input" type="text" name="username" id="username" placeholder="{'Username'|@translate}" autocomplete="username">
					</div>
					<div class="form-group">
						<label for="password">{'Password'|@translate}</label>
						<input tabindex="2" class="form-input" type="password" name="password" id="password" placeholder="{'Password'|@translate}" autocomplete="current-password">
					</div>
					{if $authorize_remembering }
						<div class="form-group checkbox-group">
							<label for="remember_me" class="checkbox-label">
								<input tabindex="3" type="checkbox" name="remember_me" id="remember_me" value="1">
								<span>{'Auto login'|@translate}</span>
							</label>
						</div>
					{/if}
					<div class="form-group submit-group">
						<input class="submit-btn" tabindex="4" type="submit" name="login" value="{'Submit'|@translate}">
					</div>
					<div class="login-links">
						{if isset($U_REGISTER) }
							<a href="{$U_REGISTER}" title="{'Register'|@translate}" class="login-link">{'Register'|@translate}</a>
							<span class="link-separator">•</span>
						{/if}
						<a href="{$U_LOST_PASSWORD}" title="{'Forgot your password?'|@translate}" class="login-link">{'Forgot your password?'|@translate}</a>
					</div>
				</form>
			</div>
			<script type="text/javascript">
				<!--
				document.login_form.username.focus();
				//-->
			</script>
		</div>
	</div>
</div> <!-- content -->