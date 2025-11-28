<div class="titrePage">
 <div class="browsePath">
  <h2>
   {if isset($MENUBAR)}
    <span id="menuswitcher" title="{'Show/hide menu'|@translate}">{'Menu'|@translate}</span><span class="arrow"> »</span>
   {/if}
   <a href="{$U_HOME}">{'Home'|@translate}</a>
   {$LEVEL_SEPARATOR}{'Registration'|@translate}
  </h2>
 </div>
</div>
<div id="content">
 {if isset($MENUBAR)}{$MENUBAR}{/if}
 <div id="content_cell">
  <div class="content_block">
   {include file='infos_errors.tpl'} 
   <form method="post" action="{$F_ACTION}" class="properties" name="register_form">
    <fieldset>
     <legend>{'Enter your personnal informations'|@translate}</legend>
     <ul>
      <li>
       <span class="property">
        <label for="login">{'Username'|@translate}</label>
       </span>
       <input type="text" name="login" id="login" value="{$F_LOGIN}" >&nbsp;<span class="mandatorystar">*</span>
      </li>
      <li>
       <span class="property">
        <label for="password">{'Password'|@translate}</label>
       </span>
       <input type="password" name="password" id="password" >&nbsp;<span class="mandatorystar">*</span>
      </li>
      <li>
       <span class="property">
        <label for="password_conf">{'Confirm Password'|@translate}</label>
       </span>
       <input type="password" name="password_conf" id="password_conf" >&nbsp;<span class="mandatorystar">*</span>
      </li>
      <li>
       <span class="property">
        <label for="mail_address">{'Email address'|@translate}</label>
       </span>
       <input type="text" name="mail_address" id="mail_address" value="{$F_EMAIL}" >{if $obligatory_user_mail_address}&nbsp;<span class="mandatorystar">*</span>{/if}
       ({'useful when password forgotten'|@translate})
      </li>
     </ul>
    </fieldset>
    <p class="bottomButtons">
     <input type="hidden" name="key" value="{$F_KEY}" >
     <input class="submit" type="submit" name="submit" value="{'Register'|@translate}">
     <input class="submit" type="reset" value="{'Reset'|@translate}">
    </p>
   </form>
   <p><span class="mandatorystar">*</span> : {'obligatory'|@translate}</p>
   <script type="text/javascript">
    <!--
    document.register_form.login.focus();
    //-->
   </script>
  </div>
 </div>
</div> <!-- content -->