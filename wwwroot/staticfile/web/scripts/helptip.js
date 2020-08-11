<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function showTipHelp(sHelpTag)
{
  var sRequest = "../admin/share/helptip.jsp?action=getcontent&tag=" + sHelpTag;
//alert("sRequest=" + sRequest);
  getTipHelp(sRequest);
}

function getTipHelp(sRequest)
{
  if (document.getElementById('tiphelp')==null||document.getElementById('tipcontent')==null)
     return;

  var sContent = document.getElementById('tipcontent').innerHTML;
  if (sContent==null || sContent.length==0)
  {
      var sResponse = getUrlContent(sRequest);
//alert("sResponse=" + sResponse);
      
      if (sResponse!=null&&sResponse.length>5)
      {
    //     document.getElementById('tipcontent').innerText = sResponse;
         document.getElementById('tipcontent').innerHTML = sResponse;
      }
  }

  showHideSpan('open','tiphelp');
}

var g_HelpCanHide = true;
function taggleHelp()
{
  g_HelpCanHide = !g_HelpCanHide;
}

function showHelp(sHelpTag)
{
    showTipHelp(sHelpTag);
}
function hideHelp()
{
  if (g_HelpCanHide)
     showHideSpan('close','tiphelp');
}

var g_TermsOpen = false;
function taggleViewTerms(sRequest)
{
  if (!g_TermsOpen)
  {
    getTermsContent(sRequest);
  }

  showHideSpan(g_TermsOpen?'close':"open",'idtermsview');
  g_TermsOpen = !g_TermsOpen;
}

function getTermsContent(sRequest)
{
  var sContent = document.getElementById('idtermscontent').innerHTML;
  if (sContent==null || sContent.length==0)
  {
//      var sRequest = "../admin/share/helptip.jsp?action=getcontent&tag=config";
//      var sRequest = "ser/ajaxresponse.jsp?action=GetServiceTerms";    
      var sResponse = getUrlContent(sRequest);
//alert("sResponse=" + sResponse);      
      if (sResponse!=null&&sResponse.length>5)
      {
    //     document.getElementById('tipcontent').innerText = sResponse;
         document.getElementById('idtermscontent').innerHTML = sResponse;
      }
  }
}

