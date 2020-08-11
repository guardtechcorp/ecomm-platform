<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/liveclock.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.zyzit.weboffice.bean.MemberBean"%>
<%@ page import="com.zyzit.weboffice.session.UserSession"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%
  MemberBean bean = new MemberBean(session, 10);
//bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERAREA))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Stop Member".equalsIgnoreCase(sAction))
  {
    MemberBean.Result ret = bean.stop(request);
  }

  DomainInfo dmInfo = bean.getDomainInfo();
  List ltArray = bean.getTotalOnlineUsers(UserSession.USAGETYPE_MEMBER);

  String sHelpTag = "onlinelist";
  String sTitleLinks = "<b>Who is Online</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can get a brief view of all the members online in your website.
<p>
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="50%" height="25">Web Site Started since: <b><%=Utilities.getDateValue(dmInfo.CreateDate, 16)%></b></td>
    <td width="50%" height="25" align="right">Current Time: <b><span id="clock"></span></b>&nbsp;</td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="19%" class="thCornerL">Account Name</th>
    <th width="15%" class="thCornerR">Member Name</th>
    <th width="16%" class="thTop">Log in Time</th>
    <th width="7%" class="thTop">Duration</th>
    <th width="16%" class="thTop">Last Updated</th>
    <th width="7%" class="thTop">Session</th>
    <th width="12%" class="thCornerR">IP Address</th>
    <th width="9%" class="thCornerR">Action</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=9>There is no any member online.</td></tr>
<% } else {
  for (int i=0; i<ltArray.size(); i++) {
      UserSession us = (UserSession)ltArray.get(i);
%>
  <tr>
    <td width="19%" class="row1">
      <a href="../util/email.jsp?action=person&toemail=<%=us.getUsername()%>&name=&group=recipients&return=../membership/onlinelist.jsp&display=Who is online" title="Email to <%=us.getUsername()%>"><%=us.getUsername()%></a>
    </td>
    <td width="15%" align="center" class="row1"><%=us.getRealName()%></td>
    <td width="16%" align="center" class="row1"><%=us.getLoginTime()%></td>
    <td width="7%" align="center" class="row1"><%=bean.getDuration(us.getStartTime())%></td>
    <td width="16%" align="center" class="row1"><%=us.getLastUpdateTime()%></td>
    <td width="7%" align="center" class="row1"><%=us.getSid()%></td>
    <td width="12%" align="center" class="row1"><%=us.getClientIp()%></td>
    <td width="9%" align="center" class="row1"><a href='member.jsp?action=View&memberid=<%=us.getUserID()%>&return=onlinelist.jsp&display=Who is Online'>View</a>|<a onClick="return confirm('Are you sure you want to stop this member session?');" href='onlinelist.jsp?action=Stop Member&sid=<%=us.getSid()%>'>Stop</a>
    </td>
  </tr>
<%}}%>
</table>
<script>goforit();</script>
<%@ include file="../share/footer.jsp"%>