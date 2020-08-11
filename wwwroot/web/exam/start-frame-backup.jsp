<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<html>
<head>
<title>Start Practice / Exam</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT Language="JavaScript" src="../../admin/scripts/sarissa.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="../../admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="../../admin/scripts/session.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js"></SCRIPT>
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
  String sDisplayMessage = null;
  ExamSectionInfo info = null;
  boolean bInSectionPage = true;
  if (ret.isSuccess())
  {
    info = (ExamSectionInfo)ret.getUpdateInfo();
    String sAction = request.getParameter("action");
    if ("Start".equalsIgnoreCase(sAction))
    {//. Begin a new section
      bean.startStep(request, info, true);
    }
    else if ("Continue".equalsIgnoreCase(sAction))
    {//. Continue an existing section
      bean.startStep(request, info, false);
    }
    else if ("Go To Question".equalsIgnoreCase(sAction))
    {//. jump to an existing section
      bean.startStep(request, info, false);
    }
    else if ("Next".equalsIgnoreCase(sAction))
    {//. Begin a new section
      bean.moveStep(request, 1);
    }
    else if ("Back".equalsIgnoreCase(sAction))
    {//. Begin a new section
      bean.moveStep(request, -1);
    }

    //. Check where is step.
    bInSectionPage = !bean.isInPassage(request);
  }
  else
  {//.
    Errors errObj = (Errors)ret.getInfoObject();
    sDisplayMessage = errObj.getError();
  }
%>
<% if (ret.isSuccess()) {%>
<frameset rows="36,853" cols="*" onLoad="sendIdleFlag(<%=(bean.getTimeoutSeconds()-60)%>, '../../admin/share/idle.jsp');" onUnload="onBrowserClose('index.jsp');">
  <frame name="toptitle" scrolling="no" src="top-title.jsp">
  <frameset rows="*,30" frameborder="yes" border="0" framespacing="0" cols="*">
<% if (bInSectionPage) { %>
    <frame name="leftpassage" scrolling="yes" src="left-passage.jsp">
<% } else { %>
    <frameset cols="50%,*" frameborder="yes" border="0" framespacing="0" rows="*">
      <frame name="leftpassage" scrolling="yes" src="left-passage.jsp">
      <frame name="rightquestion" scrolling="yes" src="right-question.jsp">
    </frameset>
<% } %>
    <frame name="bottomnavigation" scrolling="no" noresize src="bottom-navigation.jsp">
  </frameset>
</frameset>
<noframes>
<body bgcolor="#FFFFFF" text="#000000">
Your browser does not support frame.
</body>
</noframes>
<% } else { %>
<body bgcolor="#FFFFFF" text="#000000">
Error: <%=sDisplayMessage%>.
</body>
<% } %>
</html>
