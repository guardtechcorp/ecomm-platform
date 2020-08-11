<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<html>
<head>
<title>Header Page of Practice / Exam</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/session.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js" type="text/javascript"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/liveclock.js" type="text/javascript"></script>
<script language="javascript" src="/staticfile/admin/scripts/exam.js" type="text/javascript"></script>
<script language="javascript" src="/staticfile/admin/scripts/search.js" type="text/javascript"></script>
<script LANGUAGE="JavaScript">
function showPageStatus(sPageRange, sQuestionRange)
{
//   alert("Show Title");
  if (document.all)
  {
     document.all.pagerange.innerHTML=sPageRange;
     document.all.questionrange.innerHTML=sQuestionRange;
  }
  else if (document.getElementById)
  {
     document.getElementById("pagerange").innerHTML=sPageRange;
     document.getElementById("questionrange").innerHTML=sQuestionRange;
  }
//  else
//     document.write(cTime);

}
</script>

</head>
<%
  ExamSectionBean bean = new ExamSectionBean(session, 0);
  ExamSectionInfo info = bean.getSectionInfo(request);

  int nStep = bean.getCurrentStep(request) + 1;
  int nTotalSteps = bean.getTotalSteps(request);
  String sPageRange = "<font size=2>Page: <b>" + nStep + "&nbsp;&nbsp;of&nbsp;&nbsp;" + nTotalSteps + "</b></font>";
  String sQuestionRange = "";
  if (bean.isInPassage(request))
  {//. It is in Passage pages
    int nLocalNo = bean.getCurrentLocalStep(request);
    int nTotalQuestions = bean.getTotalQuestions(request);
    int nStartNo = bean.getQuestionStartNo(request, nLocalNo);
    int nEndNo = bean.getQuestionEndNo(request, nLocalNo);
    sQuestionRange = "&nbsp;<font size=2>( Question: <b>" + nStartNo + " - " + nEndNo + "&nbsp;&nbsp;of&nbsp;&nbsp;" + nTotalQuestions + "</b></font> )";
  }

  long nTimeLeft = bean.getTimeLeftSeconds(request);
%>
<body bgcolor="<%=info.BackColor%>" text="#000000" LEFTMARGIN=5 TOPMARGIN=1>
<table width="100%" height="100%" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3" align="center"><font size=4><b><%=info.Name%></b></font></td>
  </tr>
  <tr>
   <form name="search" action="#" method="post">
    <INPUT type="hidden" name="domainname" value="<%=bean.getDomainName()%>">
    <INPUT type="hidden" name="sectionid" value="<%=info.SectionID%>">
    <INPUT type="hidden" name="sessionid" value="<%=bean.getCurrentSessionId()%>">
    <td width="35%" align="left" valign="middle"><font size=2>Keyword: </font>
     <input name='keyword' size='20' maxlength='128' style="HEIGHT:22px">
     <a onClick="javascript:goSearch(document.search)" href="javascript:;"><img src="/staticfile/web/images/searchicon.gif" align="CENTER" border="0"></a>
     <!--INPUT type="button" value="Go" name="submit" onclick="submitSearch(document.search);" title='Do keyword search to jump to a passage' style="HEIGHT:22px"-->
    </td>
    <td width="30%" align="center"><span id="pagerange"></span> <span id="questionrange"></span>
    <td width="35%" align="right" valign="bottom"><font size=2>Current Time: <b><span id="clock"></span></b><span id="countdown"></span></font></td>
  </form>
  </tr>
</table>
<script>goforit(true);</script>
<script>startCountdown(<%=nTimeLeft%>);</script>
<script>showPageStatus('<%=sPageRange%>', '<%=sQuestionRange%>')</script>
</body>
</html>