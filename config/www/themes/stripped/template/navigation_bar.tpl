<div class="navigationBar">
  {if isset($navbar.URL_FIRST) && $navbar.URL_FIRST != ''}
  <a href="{$navbar.URL_FIRST}" rel="first" class="nav-page-link">{'First'|@translate}</a> |
  {else}
  <span class="nav-disabled">{'First'|@translate}</span> |
  {/if}
  {if isset($navbar.URL_PREV) && $navbar.URL_PREV != ''}
  <a href="{$navbar.URL_PREV}" rel="prev" class="nav-page-link">{'Previous'|@translate}</a> |
  {else}
  <span class="nav-disabled">{'Previous'|@translate}</span> |
  {/if}

  {assign var='prev_page' value=0}
  {foreach from=$navbar.pages key=page item=url}
    {if $page > $prev_page+1}...{/if}
    {if $page == $navbar.CURRENT_PAGE}
    <span class="pageNumberSelected">{$page}</span>
    {else}
    <a href="{$url}" class="nav-page-link">{$page}</a>
    {/if}
    {assign var='prev_page' value=$page}
  {/foreach}

  {if isset($navbar.URL_NEXT) && $navbar.URL_NEXT != ''}
  | <a href="{$navbar.URL_NEXT}" rel="next" class="nav-page-link">{'Next'|@translate}</a>
  {else}
  | <span class="nav-disabled">{'Next'|@translate}</span>
  {/if}
  {if isset($navbar.URL_LAST) && $navbar.URL_LAST != ''}
  | <a href="{$navbar.URL_LAST}" rel="last" class="nav-page-link">{'Last'|@translate}</a>
  {else}
  | <span class="nav-disabled">{'Last'|@translate}</span>
  {/if}
</div>
