{* Fotorama Slideshow Template for Stripped Theme *}
{* Hide navbar and banner in slideshow mode *}
{html_head}
{literal}
<style>
.navbar, .page-header {display: none !important;}
#footer {display: none;}
</style>
{/literal}
{/html_head}

{* Use Fotorama's content template *}
{include file=$FOTORAMA_CONTENT_PATH}

