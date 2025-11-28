<div class="navButtons">
{if $DISPLAY_NAV_BUTTONS or isset($slideshow)}

  {if isset($slideshow.U_STOP_REPEAT)}
    <a id="icon_stop_repeat" class="navButton" href="{$slideshow.U_STOP_REPEAT}" title="{'Not repeat the slideshow'|@translate}">&nbsp;</a>
  {/if}

  {if isset($slideshow.U_START_REPEAT)}
    <a id="icon_start_repeat" class="navButton" href="{$slideshow.U_START_REPEAT}" title="{'Repeat the slideshow'|@translate}">&nbsp;</a>
  {/if}

  {if isset($U_SLIDESHOW_STOP)}
    <a id="icon_stop" class="navButton" href="{$U_SLIDESHOW_STOP}" title="{'stop the slideshow'|@translate}">&nbsp;</a>
  {/if}

  {if isset($slideshow.U_STOP_PLAY)}
    <a id="icon_pause" class="navButton" href="{$slideshow.U_STOP_PLAY}" title="{'Pause of slideshow'|@translate}">&nbsp;</a>
  {/if}

  {if isset($slideshow.U_START_PLAY)}
    <a id="icon_play" class="navButton" href="{$slideshow.U_START_PLAY}" title="{'Play of slideshow'|@translate}">&nbsp;</a>
  {/if}

 <!-- {if isset($U_SLIDESHOW_START) }
	<a id="icon_play" class="navButton" href="{$U_SLIDESHOW_START}" title="{'slideshow'|@translate}">&nbsp;</a>
  {/if}-->

<!--  {if isset($first)}
    <a id="icon_first" class="navButton" href="{$first.U_IMG}" title="{'First'|@translate} : {$first.TITLE}" rel="first">&nbsp;</a>
  {else}
    <a id="icon_first_0" class="navButton">&nbsp;</a>
  {/if}-->

  {if isset($U_UP) and !isset($slideshow)}
    <a id="icon_up" class="navButton" href="{$U_UP}" title="{'Thumbnails'|@translate}" rel="up">&nbsp;</a>
  {/if}

  {if isset($previous)}
    <a id="icon_left" class="navButton" href="{$previous.U_IMG}" title="{'Previous'|@translate} : {$previous.TITLE}" rel="prev">&nbsp;</a>
  {else}
    <a id="icon_left_0" class="navButton">&nbsp;</a>
  {/if}

  {if isset($next)}
    <a id="icon_right" class="navButton" href="{$next.U_IMG}" title="{'Next'|@translate} : {$next.TITLE}" rel="next">&nbsp;</a>
  {else}
    <a id="icon_right_0" class="navButton">&nbsp;</a>
  {/if}

<!--  {if isset($last)}
    <a id="icon_last" class="navButton" href="{$last.U_IMG}" title="{'Last'|@translate} : {$last.TITLE}" rel="last">&nbsp;</a>
  {else}
    <a id="icon_last_0" class="navButton">&nbsp;</a>
  {/if}-->

 	<div class="imageNumber">{$PHOTO}</div>

{/if}
</div>




<script type="text/javascript">// <![CDATA[
{literal}
function keyboardNavigation(e)
{
        if(!e) e=window.event;
        if (e.altKey) return true;
        var target = e.target || e.srcElement;
        if (target && target.type) return true; //an input editable element
        var keyCode=e.keyCode || e.which;
        var docElem = document.documentElement;
        switch(keyCode) {
{/literal}
{if isset($next)}
        case 63235: case 39: if (e.ctrlKey || docElem.scrollLeft==docElem.scrollWidth-docElem.clientWidth ){ldelim}window.location="{$next.U_IMG}".replace( "&amp;", "&" ); return false; } break;
{/if}
{if isset($previous)}
        case 63234: case 37: if (e.ctrlKey || docElem.scrollLeft==0){ldelim}window.location="{$previous.U_IMG|@escape:javascript}".replace("&amp;","&"); return false; } break;
{/if}
{if isset($first)}
        /*Home*/case 36: if (e.ctrlKey){ldelim}window.location="{$first.U_IMG|@escape:javascript}".replace("&amp;","&"); return false; } break;
{/if}
{if isset($last)}
        /*End*/case 35: if (e.ctrlKey){ldelim}window.location="{$last.U_IMG|@escape:javascript}".replace("&amp;","&"); return false; } break;
{/if}
{if isset($U_UP) and !isset($slideshow)}
        /*Up*/case 38: if (e.ctrlKey){ldelim}window.location="{$U_UP|@escape:javascript}".replace("&amp;","&"); return false; } break;
{/if}

{if isset($slideshow.U_START_PLAY)}
        /*Pause*/case 32: {ldelim}window.location="{$slideshow.U_START_PLAY|@escape:javascript}".replace("&amp;","&"); return false; } break;
{/if}
{if isset($slideshow.U_STOP_PLAY)}
        /*Play*/case 32: {ldelim}window.location="{$slideshow.U_STOP_PLAY|@escape:javascript}".replace("&amp;","&"); return false; } break;
{/if}
        }
        return true;
}
document.onkeydown=keyboardNavigation;
// ]]></script>
