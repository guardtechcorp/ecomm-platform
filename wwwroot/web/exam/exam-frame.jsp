<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<html>
<head>
<title>Start Practice / Exam</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/sarissa.js"></SCRIPT-->
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"  type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/session.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js" type="text/javascript"></SCRIPT>
<script type="text/javascript">
function resizeFrame(coltype, settingvalue)
{
  if (coltype=="rows")
     document.body.rows=settingvalue
  else if (coltype=="cols")
     document.body.cols=settingvalue
}
</script>
</head>
<%
//bean.showAllParameters(request, out);
//Url = www.website.com/ctr/web/exam/index.jsp?action=start&sectionid=1
  ExamSectionBean bean = new ExamSectionBean(session, 0);

  ExamSectionBean.Result ret = bean.getInfoFromUrl(request);
  ExamSectionInfo info = (ExamSectionInfo)ret.getUpdateInfo();
  String sAction = request.getParameter("action");
  String sCGIKeyword = "";
  if ("Start".equalsIgnoreCase(sAction))
  {//. Begin a new section
    bean.startStep(request, info, true);
  }
  else if ("Continue".equalsIgnoreCase(sAction))
  {//. Continue an existing section
    bean.startStep(request, info, false);
  }
  else if ("Go To Question".equalsIgnoreCase(sAction))
  {//. jump to an existing question
    bean.startStep(request, info, false);
    if (request.getParameter("keyword")!=null)
       sCGIKeyword = "?keyword=" + request.getParameter("keyword");
  }
  else if ("Next".equalsIgnoreCase(sAction))
  {//. Go to the next page
    bean.moveStep(request, 1);
  }
  else if ("Back".equalsIgnoreCase(sAction))
  {//. Go to the previous page
    bean.moveStep(request, -1);
  }
    //. Check where is the step in the section.
  boolean bInSectionPage = !bean.isInPassage(request);
  long nTimeLeft = bean.getTimeLeftSeconds(request);

  int nStep = bean.getCurrentStep(request) + 1;
  int nTotalSteps = bean.getTotalSteps(request);
  String sPageRange = "<font size=2>Page: <b>" + nStep + "&nbsp;&nbsp;of&nbsp;&nbsp;" + nTotalSteps + "</b></font>";
  String sQuestionRange = "";
  if (!bInSectionPage)
  {//. It is in Passage pages
    int nLocalNo = bean.getCurrentLocalStep(request);
    int nTotalQuestions = bean.getTotalQuestions(request);
    int nStartNo = bean.getQuestionStartNo(request, nLocalNo);
    int nEndNo = bean.getQuestionEndNo(request, nLocalNo);
    sQuestionRange = "&nbsp;<font size=2>( Question: <b>" + nStartNo + " - " + nEndNo + "&nbsp;&nbsp;of&nbsp;&nbsp;" + nTotalQuestions + "</b></font> )";
  }
%>

<% if ("Back".equalsIgnoreCase(sAction)||"Next".equalsIgnoreCase(sAction)) { %>
<Script>
parent.frames["toptitle"].showPageStatus('<%=sPageRange%>', '<%=sQuestionRange%>');
parent.frames["toptitle"].startCountdown(<%=nTimeLeft%>);
parent.frames["bottomnavigation"].showButtons(<%=bean.isFirstPage(request)%>, <%=bean.isLastPage(request)%>);
</Script>
<% } %>

<% if (bInSectionPage) { %>
<frameset cols="*" frameborder="yes" border="0" framespacing="0" rows="*">
  <frame name="leftpassage" scrolling="yes" src="left-passage.jsp">
<% } else { %>
<frameset cols="50%,*" frameborder="yes" border="0" framespacing="0" rows="*">
  <frame name="leftpassage" scrolling="yes" src="left-passage.jsp<%=sCGIKeyword%>">
  <frame name="rightquestion" scrolling="yes" src="right-question.jsp">
<% } %>
</frameset>
<noframes>
<body bgcolor="#FFFFFF" text="#000000">
Your browser does not support frame.
</body>
</noframes>

</html>