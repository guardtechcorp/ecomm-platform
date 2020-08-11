<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSessionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamSessionInfo"%>
<%
  ExamSectionBean bean = new ExamSectionBean(session, 1000);
  String sAction = request.getParameter("action");
  if ("Logout".equalsIgnoreCase(sAction))
  {//. Browser close
    bean.logout(request);
    return;
  }

  if (!bean.setDomainInit(request, application.getRealPath("/")))
     return;
//ExamSectionBean.Result ret = bean.login(request, bean.getDomainName());

  ExamSessionBean sessionbean = new ExamSessionBean(session, 1000);
  if ("Go Exam".equalsIgnoreCase(sAction))
  { //. Go To exam area  index.jps?action=Go To Exam&sectionids=1,3

  }
  else if ("Delete".equalsIgnoreCase(sAction))
  { //. Try to delete session
    ExamSessionBean.Result ret1 = sessionbean.delete(request);
  }
  else if ("Go Section".equalsIgnoreCase(sAction))
  { //. Try to update choices
    bean.updateChoices(request);
  }
//  else
//    return;

  String sDomainName = bean.getDomainNameFromUrl(session, request, true);
  List ltArray = bean.getAllSection(request);

  //. Get the existing exam sessions
  List ltSession = sessionbean.getAllSession(request);
%>
<html>
<head>
<title>Start Practice / Exam</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/sarissa.js"></SCRIPT-->
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/session.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" type="text/javascript">
<!--
top.window.moveTo(0,0);
if (document.all) {
  top.window.resizeTo(screen.availWidth,screen.availHeight);
}
else if (document.layers||document.getElementById)
{
  if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){
     top.window.outerHeight = screen.availHeight;
     top.window.outerWidth = screen.availWidth;
  }
}
//-->
</SCRIPT>
</head>
<body bgcolor="#ffffff" text="#000000" onLoad="sendIdleFlag(<%=(bean.getTimeoutSeconds()-60)%>, '../../admin/share/idle.jsp');" onUnload1="onBrowserClose('index.jsp');">
<center><h2>Welcome to Exam and Practice Section</h2></center>
<p>There are <%=ltArray.size()%> sections available now. You can enter to either one of them to start a new practice and test.
<table width="99%" cellpadding="1" cellspacing="1" border="0" align="center">
<%
  for (int i=0; ltArray!=null && i<ltArray.size(); i+=3) {
    ExamSectionInfo info = (ExamSectionInfo)ltArray.get(i);
%>
<tr><td>
<table cellspacing=1 cellpadding=1 width="100%" border=0 align="center">
  <tr>
    <td valign="top" width="33%">
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign="top" width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/web/images//book-icon.jpg" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks diffpointer">
             <li><a href="start-frame.jsp?action=start&sectionid=<%=info.SectionID%>">Start Practice</a></li>
           </ul>
          </td>
        </tr>
      </table>
    </td>
    <td valign="top" width="34%">
<% if (i+1<ltArray.size()) {
  info = (ExamSectionInfo)ltArray.get(i+1);
%>
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign=top width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/web/images/book-icon.jpg" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks diffpointer">
             <li><a href="start-frame.jsp?action=start&sectionid=<%=info.SectionID%>">Start Practice</a></li>
           </ul>
          </td>
        </tr>
      </table>
<% } %>
    </td>
    <td valign="top" width="33%">
<% if (i+2<ltArray.size()) {
  info = (ExamSectionInfo)ltArray.get(i+2);
%>
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign="top" width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/web/images/book-icon.jpg" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks diffpointer">
             <li><a href="start-frame.jsp?action=start&sectionid=<%=info.SectionID%>">Start Practice</a></li>
           </ul>
          </td>
        </tr>
      </table>
<% } %>
    </td>
  </tr>
</table>
</td></tr>
<% } %>
<tr>
</tr>
</table>
<p>
<table width="99%" align="center" border="0" cellpadding="1" cellspacing="1">
  <TR>
    <TD height=20 align="center"><b><font size="3" Color="#4279bd" face="Verdana, Arial, Helvetica, sans-serif">List of Exams/Practices made before</font></b></TD>
  </TR>
  <TR>
   <TD>
<table width="100%" align="center" border="1" cellpadding="0" cellspacing="0">
  <TR vAlign="middle" bgColor="#4959A7">
    <td width="5%" align="center" height=20><FONT color="#ffffff" size=2><b>No</b></FONT></td>
    <td width="23%" align="center" height=20><FONT color="#ffffff" size=2><b>Section Name</b></FONT></td>
    <td width="11%" align="center" height=20><FONT color="#ffffff" size=2><b>Total Questions</b></FONT></td>
    <td width="11%" align="center" height=20><FONT color="#ffffff" size=2><b>Finished Questions</b></FONT></td>
    <td width="13%" align="center" height=20><FONT color="#ffffff" size=2><b>Stat Date</b></FONT></td>
    <td width="25%" align="center" height=20><FONT color="#ffffff" size=2><b>Actions</b></FONT></td>
  </TR>
<% if (ltSession==null||ltSession.size()==0){ %>
  <tr class="normal_row">
    <td colspan="6">There is no record available.</td>
  </tr>
<% } else {
  int nStartNo = Utilities.getInt(sessionbean.getCacheData(ExamSessionBean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltSession.size(); i++) {
     ExamSessionInfo info = (ExamSessionInfo)ltSession.get(i);
%>
  <tr bgColor="#f7f7f7">
    <td width="5%" align="center"><%=(nStartNo+i)%></td>
    <td width="23%" align="center"><%=Utilities.getValue(bean.getSectionName(info.SectionID))%></td>
    <td width="10%" align="center"><%=bean.getTotalQuestionsById(info.SectionID)%></td>
    <td width="10%" align="center"><%=bean.getFinishedQuestionsById(info.SessionID)%></td>
    <td width="13%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="25%" align="center"><a href="start-frame.jsp?action=Continue&sessionid=<%=info.SessionID%>&sectionid=<%=info.SectionID%>">Resume</a>
     | <a href="report.jsp?action=Show Report&sessionid=<%=info.SessionID%>&sectionid=<%=info.SectionID%>">Show Report</a>
     | <a onClick="return confirm('Are you sure you want to delete it?');" href="index.jsp?action=Delete&sessionid=<%=info.SessionID%>">Delete</a>
    </td>
  </tr>
<%}%>
<% } %>
</table>
 </td>
  </tr>
</table>
</body>