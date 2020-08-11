<SCRIPT Language="JavaScript">
var g_sHelpTag = "";
var g_sP1 = "";
var g_sP2 = "";
function setHelp(sHelpTag, sP1, sP2)
{
  g_sHelpTag = sHelpTag;
  g_sP1 = sP1;
  g_sP2 = sP2;
  g_titlelink = 1;
}
function showHelp()
{
  if (g_sHelpTag.length>0)
  {
//alert("g_sP=" + g_sP1 + "|" +g_sP2+"|" + g_sP1.length);
    if (g_sP2!=null && g_sP2.length>0)
    {
      showTipHelp2(g_sHelpTag, g_sP1, g_sP2);
    }
    else if (g_sP1!=null && g_sP1.length>0)
    {
      showTipHelp1(g_sHelpTag, g_sP1);
    }
    else
      showTipHelp(g_sHelpTag);
  }
}
function hideHelp()
{
  showHideSpan('close','tiphelp');
}
function setNavigation(sTitleLink)
{
  if (sTitleLink!=null&&sTitleLink.length>0)
  {
     document.getElementById('navigations').innerHTML = sTitleLink;
  }
}
function setUpArea(sHelpTag, sTitleLink, sP1, sP2)
{
  setHelp(sHelpTag, sP1, sP2);
  setNavigation(sTitleLink);
}
</SCRIPT>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td class="navtitlebar" noWrap height="24"><font size="1"><span id="navigations"></span></font></td>
  </tr>
  <tr>
    <td height="1" valign="top">
     <DIV id="tiphelp" style="DISPLAY: none">
     <table width="100%" cellpadding="4" cellspacing="0" class="infobox">
      <tr>
       <td bgcolor="#FFFFCC"><DIV id="tipcontent"></DIV></td>
      </tr>
     </table>
     </DIV>
    </td>
  </tr>
</table>