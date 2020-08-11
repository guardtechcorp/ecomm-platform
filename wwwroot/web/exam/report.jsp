<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<%@ page import="com.zyzit.weboffice.model.ExamPassageInfo"%>
<%@ page import="com.zyzit.weboffice.model.ExamQuestionInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
/*
  body,td,th {
          font-family: Arial, Helvetica, sans-serif;
          font-size: 10px;
          color: #000000;
}
*/
  ExamSectionBean bean = new ExamSectionBean(session, 1000);
  String sAction = request.getParameter("action");
  if ("Go Report".equalsIgnoreCase(sAction))
  { //. Try to update choices
    bean.updateChoices(request);
  }

  int nSectionId = Utilities.getInt(request.getParameter("sectionid"), -1);
  int nSessionId = Utilities.getInt(request.getParameter("sessionid"), -1);
  List ltPassage = bean.getPassageListById(nSectionId);
  int nQuestionNo = 0;
  int nPassageNo = 0;

  ExamSectionInfo info = bean.getSectionInfo(nSectionId);
  ConfigInfo cfInfo = bean.getConfigInfo();
%>
<html>
<head>
<title>Start Practice / Exam</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<STYLE>
body,td,th {
        font-family: Arial, Helvetica, sans-serif;
        font-size: 11px;
        color: #000000;
}
</STYLE>

<!--link rel="stylesheet" href="../../admin/css/main.css" type="text/css"-->
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/sarissa.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/session.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js" type="text/javascript"></SCRIPT>
</head>
<% if ("Go Report".equalsIgnoreCase(sAction)) {%>
<body bgcolor="<%=info.BackColor%>" text="#000000">
<% } else { %>
<body bgcolor="<%=info.BackColor%>" text="#000000" onLoad="sendIdleFlag(<%=(bean.getTimeoutSeconds()-60)%>, '../../admin/share/idle.jsp');" onUnload1="onBrowserClose('index.jsp');">
<% } %>
<center><h3>Practice/Test Report</h3></center>
<table width="85%" align="center" border="0" cellpadding="1" cellspacing="1">
  <TR>
    <TD width="65%"><b><%=info.Name%></b> of Test stated since <b><%=Utilities.getDateValue(info.CreateDate, 16)%></b></TD>
    <TD align="right">
<% if (!"Go Report".equalsIgnoreCase(sAction)) {%>
    <a href="index.jsp">Back to Section Area</a>&nbsp;&nbsp;
    <a href="start-frame.jsp?action=Continue&sessionid=<%=nSessionId%>&sectionid=<%=nSectionId%>">Restart a new Test</a>
<% } %>
   </TD>
  </TR>
  <TR>
   <TD colspan="2">
<table width="100%" align="center" border="1" cellpadding="0" cellspacing="0">
  <TR vAlign="middle" bgColor="#4959A7">
    <td width="15%" align="center" height="24"><FONT color="#ffffff" size=2><b>Question No.</b></FONT></td>
    <td width="15%" align="center" height="24"><FONT color="#ffffff" size=2><b>Question Score</b></FONT></td>
    <td width="15%" align="center" height="24"><FONT color="#ffffff" size=2><b>Correct Answer</b></FONT></td>
    <td width="15%" align="center" height="24"><FONT color="#ffffff" size=2><b>Your Choice</b></FONT></td>
    <td width="20%" align="center" height="24"><FONT color="#ffffff" size=2><b>Your Score</b></FONT></td>
    <td width="20%" align="center" height="24"><FONT color="#ffffff" size=2><b>Action</b></FONT></td>
  </TR>
<% if (ltPassage==null||ltPassage.size()==0){ %>
  <tr class="normal_row">
    <td colspan="6">There is no record available.</td>
  </tr>
<% } else {
  int nCount = 0;
  String sRowColor = "#f7f7f7";
  for (int i=0; i<ltPassage.size(); i++) {
     ExamPassageInfo passageInfo = (ExamPassageInfo)ltPassage.get(i);
     List ltQuestion = bean.getQuestionListById(passageInfo.PassageID);
     for (int j=0; j<ltQuestion.size(); j++) {
         ExamQuestionInfo questionInfo = (ExamQuestionInfo)ltQuestion.get(j);
         nQuestionNo++;
     //. Determine color
     if ((nCount%2)==0)
        sRowColor = "#f7f7f7";
     else
        sRowColor = "#cccccc";
     nCount++;
%>
  <tr bgColor="<%=sRowColor%>">
    <td width="15%" align="center" height="20"><%=nQuestionNo%></td>
    <td width="15%" align="center">&nbsp;<%=questionInfo.Score%></td>
    <td width="15%" align="center">&nbsp;<%=bean.getCorrectAnswer(questionInfo.QuestionID)%></td>
    <td width="15%" align="center">&nbsp;<%=bean.getYourChoice(nSessionId, questionInfo.QuestionID)%></td>
    <td width="20%" align="center">&nbsp;<%=bean.getScore(nSessionId, questionInfo)%></td>
    <td width="20%" align="center">
<% if ("Go Report".equalsIgnoreCase(sAction)) {%>
     <a href="exam-frame.jsp?action=Go To Question&sessionid=<%=nSessionId%>&sectionid=<%=nSectionId%>&passageno=<%=nPassageNo%>&questionid=<%=questionInfo.QuestionID%>">Go to this Question</a>
<% } else { %>
     <a href="start-frame.jsp?action=Go To Question&sessionid=<%=nSessionId%>&sectionid=<%=nSectionId%>&passageno=<%=nPassageNo%>&questionid=<%=questionInfo.QuestionID%>">Go to this Question</a>
<% } %>
    </td>
  </tr>
<%
    }
     nPassageNo++;
  }

  String[] arSummary = bean.getSummary(nSectionId, nSessionId);
%>
  <tr>
   <td colspan=4 rowspan=8 valign="top">&nbsp;
    <table width="100%" border="0">
      <tr>
        <td></td>
      </tr>
    </table>
   </td>
   <td colspan=2 align="center" bgColor="#f7f7f7"><b>Summary</b></td>
  </tr>
  <tr bgColor="#cccccc">
   <td width="20%" align="right" height="16">Total Questions:&nbsp;</td>
   <td width="20%" align="center"><b><%=arSummary[0]%></b></td>
  </tr>
   <tr bgColor="#f7f7f7">
    <td width="20%" align="right" height="16">Finished Questions:&nbsp;</td>
    <td width="20%" align="center"><b><%=arSummary[1]%></b></td>
   </tr>
   <tr bgColor="#cccccc">
    <td width="20%" align="right" height="16">Unfinished Questions:&nbsp;</td>
    <td width="20%" align="center"><b><%=arSummary[2]%></b></td>
   </tr>
   <tr bgColor="#f7f7f7">
    <td width="20%" align="right" height="16">Correct Choices:&nbsp;</td>
    <td width="20%" align="center"><b><%=arSummary[3]%></b></td>
   </tr>
   <tr bgColor="#cccccc">
    <td width="20%" align="right" height="16">Incorrect Choices:&nbsp;</td>
    <td width="20%" align="center"><b><%=arSummary[4]%></b></td>
   </tr>
   <tr bgColor="#f7f7f7">
    <td width="20%" align="right" height="16">Total Score:&nbsp;</td>
    <td width="20%" align="center"><b><%=arSummary[5]%></b></td>
   </tr>
   <tr bgColor="#cccccc">
    <td width="20%" align="right" height="16">Grade:&nbsp;</td>
    <td width="20%" align="center"><b><%=arSummary[6]%></b></td>
   </tr>
<% } %>
</table>
 </td>
  </tr>
  <tr>
   <td colspan="2" height="5"></td>
  </tr>
</table>
</body>