{if isset($U_LOGIN)}
  <dt>{'Quick connect'|@translate}</dt>
  <dd>
    <form method="post" action="{$U_LOGIN}" id="quickconnect">
      <div>
        <label for="username">{'Username'|@translate}</label>
        <input type="text" name="username" id="username" value="">
      </div>
      <div>
        <label for="password">{'Password'|@translate}</label>
        <input type="password" name="password" id="password" value="">
      </div>
      {if $AUTHORIZE_REMEMBERING}
        <div>
          <label for="remember_me">{'Auto login'|@translate}
          <input type="checkbox" name="remember_me" id="remember_me" value="1">
          </label>
        </div>
      {/if}
      <div class="submit_block">
        <input type="hidden" name="redirect" value="{$smarty.server.REQUEST_URI|@urlencode}">
        <input class="submit" type="submit" name="login" value="{'Submit'|@translate}">
        <ul class="actions">
          <li>{if isset($U_LOST_PASSWORD)}<a href="{$U_LOST_PASSWORD}" title="{'Forgot your password?'|@translate}" rel="nofollow">{'Forgot your password?'|@translate}</a>{/if}</li>
          <li>{if isset($U_REGISTER)}<a href="{$U_REGISTER}" title="{'Create a new account'|@translate}" rel="nofollow">{'Register'|@translate}</a>{/if}</li>
        </ul>
      </div>
    </form>
    
  </dd>
{/if}