<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<html>
<head>
<title>Navigation Bottom Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet">
<LINK href="/staticfile/web/css/tabs.css" type="text/css" rel="stylesheet">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js" type="text/javascript"></SCRIPT>
</head>
<%
//bean.showAllParameters(request, out);
//Url = www.website.com/ctr/web/exam/index.jsp?action=start&sectionid=1
  ExamSectionBean bean = new ExamSectionBean(session, 0);
  ExamSectionInfo info = bean.getSectionInfo(request);
%>
<script LANGUAGE="JavaScript">
function onButtonGo(nDirection)
{
   parent.frames["leftpassage"].switchPage(nDirection);
}

function go(sAction)
{
  var sUrl = "exam-frame.jsp?action=" + sAction;

  loadUrl(sUrl);
}

function loadUrl(sUrl)
{
  if (parent.frames["examarea"].frames["rightquestion"]!=null)
  {
    var sChoices = parent.frames["examarea"].frames["rightquestion"].getChoices();
    sUrl += sChoices
//alert("sUrl=" + sUrl);
  }

  if (parent.frames["examarea"].frames["leftpassage"]!=null)
  {
    var sBookmarks = parent.frames["examarea"].frames["leftpassage"].getAllBookmark();
    if (sBookmarks.length>0)
    {
      sUrl += "&bookmarks1=" + sBookmarks;
    }
  }

  if (parent.frames["examarea"].frames["rightquestion"]!=null)
  {
    var sBookmarks = parent.frames["examarea"].frames["rightquestion"].getAllBookmark();
    if (sBookmarks.length>0)
    {
      sUrl += "&bookmarks2=" + sBookmarks;
    }
  }

//  parent.location = sUrl;
  parent.frames["examarea"].location = sUrl;
}

function pauseTest()
{
  var sMsg = "You have press Pause Button to pause your practice test.\nYou may resume your practice test at a later time.\n"
      sMsg +="\nTo pause the practice test, click OK.\n";
      sMsg += "To remain in your practice test, click Cancel.";
  if (confirm(sMsg))
  {
     parent.window.close();
  }

  return false;
}

function showButtons(bFirstPage, bLastPage)
{
  if (bFirstPage)
     showHide("close", 'TS_BACK');
  else
     showHide("open", 'TS_BACK');

  if (bLastPage)
     showHide("close", 'TS_NEXT');
  else
     showHide("open", 'TS_NEXT');
}
</script>

<body bgcolor="<%=info.BackColor%>" text="#000000" LEFTMARGIN=5 TOPMARGIN=1>
<table width="98%" height="100%" cellpadding="0" cellspacing="0" border="0" align="center">
 <tr>
   <td width="50%" align="left">
    <table width="100%">
     <tr>
       <td width="18%" align="left">
         <!--a href="javascript:loadUrl('index.jsp?action=Go Section')" class="cssbutton">Go To Section Area</a-->
         <script>createLeftButton();</script>
         <a href="javascript:;" onClick="javascript:pauseTest()" class="button">Pause</a>
         <script>createRightButton();</script>
       </td>
       <td width="18%" align="left">
         <script>createLeftButton();</script>
         <a href="javascript:loadUrl('report.jsp?action=Go Report&sessionid=<%=bean.getCurrentSessionId()%>&sectionid=<%=info.SectionID%>')" class="button">Review</a>
         <script>createRightButton();</script>
       </td>
       <td></td>
     </tr>
    </table>
   </td>
   <td align="right">
    <table width="100%">
     <tr>
      <td width="70%">&nbsp;</td>
      <td width="15%">
<SPAN id='TS_BACK' style='display: none'>
   <script>createLeftButton();</script>
     <!--A href="start-frame.jsp?action=Back" class="button">< Back </A-->
     <A href="javascript:go('Back')" class="button">< Back </A>
   <script>createRightButton();</script>
</SPAN>
      </td>
      <td align="right" valign="middle">
<SPAN id='TS_NEXT' style='display: inline'>
    <script>createLeftButton();</script>
      <!--A href="start-frame.jsp?action=Next" class="button" target="_parent"> Next ></A-->
      <A href="javascript:go('Next')" class="button"> Next ></A>
    <script>createRightButton();</script>
</SPAN>
     </td>
   </tr>
   </table>
  </td>
  </tr>
</table>
</body>
</html>