{combine_css id='standard_pages_css' path="themes/standard_pages/css/standard_pages.css" order=100}
{combine_css path="themes/default/vendor/fontello/css/gallery-icon.css" order=-10}

<script>
  var selected_language = `{$language_options[$current_language]}`;
  var url_logo_light = `{$ROOT_URL}themes/stripped/img/weweb/logo-text.png`;
  var url_logo_dark = `{$ROOT_URL}themes/stripped/img/weweb/logo-text.png`;
</script>
{combine_script id='standard_pages_js' load='async' require='jquery' path='themes/standard_pages/js/standard_pages.js'}

{* Golden Ratio Layout Override - Only layout and colors, preserve original functionality *}
{html_head}
<style type="text/css">
/* Golden Ratio Layout: Left 38.2% (login form), Right 61.8% (background image) */

body#theIdentificationPage,
#theIdentificationPage {
  margin: 0 !important;
  padding: 0 !important;
  min-height: 100vh !important;
  overflow-x: hidden !important;
  background: #000000 !important;
}

#theIdentificationPage #the_page {
  background: #000000 !important;
  max-width: 100% !important;
  width: 100% !important;
  margin: 0 !important;
  padding: 0 !important;
  min-height: 100vh !important;
  height: 100vh !important;
}

/* Main container - Golden Ratio Layout */
#theIdentificationPage container#mode {
  display: flex !important;
  flex-direction: row !important;
  min-height: 100vh !important;
  height: 100vh !important;
  margin: 0 !important;
  padding: 0 !important;
  background: #000000 !important;
  position: relative !important;
  overflow: hidden !important;
}

/* Left side - 38.2% (Golden Ratio) - Pure black login form */
#theIdentificationPage #login-form {
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
  border-radius: 0 !important;
  box-shadow: none !important;
}

#theIdentificationPage #login-form > div {
  width: 100% !important;
  max-width: 420px !important;
  padding: 3rem 4rem !important;
  background: transparent !important;
  border: none !important;
  border-radius: 0 !important;
  box-shadow: none !important;
}

/* Right side - 61.8% (Golden Ratio) - Background image */
#theIdentificationPage container#mode::after {
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

/* Override light mode background for black theme */
#theIdentificationPage .light {
  background: #000000 !important;
}

/* Adjust form colors for dark background - preserve original structure */
#theIdentificationPage .light #login-form {
  background-color: transparent !important;
}

#theIdentificationPage .light h1 {
  color: #ffffff !important;
}

#theIdentificationPage .light .input-container {
  background-color: rgba(0, 0, 0, 0.5) !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  backdrop-filter: blur(10px) !important;
  -webkit-backdrop-filter: blur(10px) !important;
}

#theIdentificationPage .light .input-container:focus-within {
  border: 1px solid rgba(255, 255, 255, 0.4) !important;
  background-color: rgba(255, 255, 255, 0.2) !important;
}

#theIdentificationPage .light .input-container input {
  color: #ffffff !important;
  background-color: transparent !important;
  background: transparent !important;
  -webkit-appearance: none !important;
  -moz-appearance: none !important;
  appearance: none !important;
}

/* Remove white background from autofill */
#theIdentificationPage .light .input-container input:-webkit-autofill,
#theIdentificationPage .light .input-container input:-webkit-autofill:hover,
#theIdentificationPage .light .input-container input:-webkit-autofill:focus {
  -webkit-text-fill-color: #ffffff !important;
  -webkit-box-shadow: 0 0 0px 1000px rgba(0, 0, 0, 0.5) inset !important;
  box-shadow: 0 0 0px 1000px rgba(0, 0, 0, 0.5) inset !important;
  transition: background-color 5000s ease-in-out 0s !important;
}

#theIdentificationPage .light .input-container i {
  color: rgba(255, 255, 255, 0.6) !important;
}

#theIdentificationPage .light .properties label {
  color: rgba(255, 255, 255, 0.9) !important;
}

/* Button styling - Reference homepage nav-link design */
#theIdentificationPage .light .btn-main {
  background: rgba(0, 0, 0, 0.85) !important;
  color: #ffffff !important;
  border: 1px solid rgba(255, 255, 255, 0.2) !important;
  padding: 0.6rem 1.5rem !important;
  border-radius: 10px !important;
  font-size: 14px !important;
  font-weight: 600 !important;
  letter-spacing: 0.05rem !important;
  cursor: pointer !important;
  text-decoration: none !important;
  transition: all 0.3s ease !important;
  backdrop-filter: blur(10px) !important;
  -webkit-backdrop-filter: blur(10px) !important;
  width: 100% !important;
  margin-top: 15px !important;
}

#theIdentificationPage .light .btn-main:hover {
  color: #ffffff !important;
  background: rgba(255, 255, 255, 0.2) !important;
  border-color: rgba(255, 255, 255, 0.4) !important;
  transform: translateY(-2px) !important;
}

/* Secondary links styling - Reference homepage text design */
#theIdentificationPage .light .secondary-links {
  color: rgba(255, 255, 255, 0.6) !important;
  margin-top: 2.5rem !important;
  padding-top: 2rem !important;
  border-top: 1px solid rgba(255, 255, 255, 0.15) !important;
  text-align: center !important;
  font-size: 14px !important;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif !important;
}

#theIdentificationPage .light .secondary-links p {
  color: rgba(255, 255, 255, 0.6) !important;
  margin-bottom: 0.75rem !important;
  font-size: 14px !important;
}

#theIdentificationPage .light .secondary-links a {
  color: rgba(255, 255, 255, 0.6) !important;
  text-decoration: none !important;
  transition: all 0.3s ease !important;
  font-size: 14px !important;
}

#theIdentificationPage .light .secondary-links a:hover {
  color: #ffffff !important;
  text-decoration: none !important;
}

#theIdentificationPage .light #separator {
  border-bottom: 1px solid rgba(255, 255, 255, 0.15) !important;
  width: 100% !important;
  margin: 1rem auto !important;
}

/* Checkbox styling - preserve original functionality */
#theIdentificationPage .light .remember-me-container {
  color: rgba(255, 255, 255, 0.9) !important;
}

#theIdentificationPage .light .gallery-icon-checkmark {
  border-color: rgba(255, 255, 255, 0.5) !important;
}

#theIdentificationPage .light input[type="checkbox"]#remember_me:checked + label ~ .gallery-icon-checkmark::before,
#theIdentificationPage .light input[type="checkbox"]#remember_me:checked + .gallery-icon-checkmark::before {
  color: #3535cc !important;
}

/* Hide other sections */
#theIdentificationPage #header-options,
#theIdentificationPage #logo-section,
#theIdentificationPage #return-to-gallery,
#theIdentificationPage #language-switch {
  display: none !important;
}

/* Hide error messages container if empty */
#theIdentificationPage .error_block_container:empty {
  display: none !important;
}

/* Responsive Design - Mobile */
@media (max-width: 1024px) {
  #theIdentificationPage container#mode {
    flex-direction: column !important;
  }
  
  #theIdentificationPage container#mode::after {
    position: absolute !important;
    width: 100% !important;
    height: 50vh !important;
    min-height: 50vh !important;
    top: 0 !important;
    left: 0 !important;
    right: 0 !important;
  }
  
  #theIdentificationPage #login-form {
    width: 100% !important;
    max-width: 100% !important;
    min-height: 50vh !important;
    height: auto !important;
    margin-top: 50vh !important;
    position: relative !important;
    left: auto !important;
    top: auto !important;
  }
  
  #theIdentificationPage #login-form > div {
    padding: 3rem 2rem !important;
    background: rgba(0, 0, 0, 0.95) !important;
    backdrop-filter: blur(10px) !important;
    -webkit-backdrop-filter: blur(10px) !important;
  }
}
</style>
{/html_head}

<container id="mode" class="light">

  <section id="header-options">
    <div>
      <i class="gallery-icon-moon toggle-mode" id="toggle_mode_light" onclick="toggle_mode('dark')"></i>
      <i class="gallery-icon-sun toggle-mode" id="toggle_mode_dark" onclick="toggle_mode('light')"></i>
    </div>
    <div>
      <a href="{$HELP_LINK}" target="_blank">{'Help'|translate}</a>
{if isset($errors['login_page_error'])}
      <div class="error_block_container">
  {foreach from=$errors['login_page_error'] item=error}
        <div class="error_block"> 
          <i class="gallery-icon-cancel"></i>
          <p>{$error}</p>
        </div>
  {/foreach}
      </div>
{/if}
    </div>
  </section>

  <section id="logo-section">
    <img id="piwigo-logo" src="{$ROOT_URL}themes/stripped/img/weweb/logo-text.png" alt="shigure">
  </section>

  <section id="login-form">
    <div class="">
      <h1 class="">
        {'Login'|translate}
      </h1>
        
      <form class="properties" action="{$F_LOGIN_ACTION}" method="post" name="login_form">

        <div class="column-flex">
          <label for="username">{'Username'|translate}</label>
          <div class="row-flex input-container">
            <i class="gallery-icon-user"></i>
            <input type="text" class="" type="text" name="username" id="username" size="25" autofocus data-required="true">
          </div>
          <p class="error-message"><i class="gallery-icon-attention-circled"></i> {'must not be empty'|translate}</p>
        </div>

        <div class="column-flex">
          <label for="password">{'Password'|translate}</label>
          <div class="row-flex input-container">
            <i class="gallery-icon-lock"></i>
            <input type="password" class="" name="password" id="password" size="25">
            <i class="gallery-icon-eye togglePassword"></i>
          </div>
          <p class="error-message"><i class="gallery-icon-attention-circled"></i> {'must not be empty'|translate}</p>
        </div>

{if $authorize_remembering }
        <div class="column-flex">
          <div class="row-flex remember-me-container">
          <label for="remember_me">
            <input tabindex="3" type="checkbox" name="remember_me" id="remember_me" value="1">
            <span class="gallery-icon-checkmark"></span>
            {'Auto login'|@translate}</label>
          </div>
        </div>
{/if}
            
        <div class="column-flex">
          <input type="hidden" name="redirect" value="{$U_REDIRECT|@urlencode}">
          <input tabindex="4" type="submit" name="login" value="{'Login'|translate}" class="btn btn-main ">
{if isset($errors['login_form_error'])}
          <p class="error-message" style="display:block;bottom:-20px;"><i class="gallery-icon-attention-circled"></i> {$errors['login_form_error']}</p>
{/if}
        </div>
      </form>

      <div class="secondary-links">
        
{if isset($U_REGISTER)}
        <p>{'Don\'t have an account yet ?'|translate} <a href="register.php" title="{'Register'|translate}">{'Create an account'|translate}</a></p>
        <span id="separator"></span>
{/if}
        <a href="password.php" title="{'Forgot your password?'|translate}">{'Forgot your password?'|translate}</a>

      </div>
            
    </div>
  </section>

  <a href="index.php" id="return-to-gallery"><i class="gallery-icon-left"></i> {'Return to the gallery'|translate}</a>

{if count($language_options) > 1}
  <section id="language-switch">
    <div id="lang-select">
      <span id="other-languages">
  {foreach from=$language_options key=code item=lang}
          <span id="lang={$code}" onclick="setCookie('lang','{$code}',30)">{$lang}</span>
  {/foreach}
      </span>
      <div id="selected-language-container">
        <i class="gallery-icon-left-chevron"></i><span id="selected-language">{$language_options[$current_language]}</span>
      </div>

    </div>
  </section>
{/if}

</container>
