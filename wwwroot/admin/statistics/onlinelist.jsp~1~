<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.bean.StatisticsBean"%>
<%@ page import="com.zyzit.weboffice.session.UserSession"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.omniserve.dbengine.model.CommunityUserInfo"%>
<%
  HttpSession parentSession = StatisticsBean.getHttpSession(request.getParameter("domainname"), request.getParameter("sid"));
  StatisticsBean bean = new StatisticsBean(parentSession, 10);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
//     return;
//  bean.getDateFrame(request);
%>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="21%" class="thCornerL">Username/Email</th>
    <th width="7%" class="thCornerR">Type</th>
    <th width="17%" class="thTop">Log in Time</th>
    <th width="10%" class="thTop">Duration</th>
    <th width="17%" class="thTop">Last Updated</th>
    <th width="10%" class="thTop">Session ID</th>
    <th width="18%" class="thCornerR">IP Address</th>
  </tr>
<%
  List ltArray = bean.getTotalOnlineCustomers();
  for (int i=0; i<ltArray.size(); i++) {
      UserSession us = (UserSession)ltArray.get(i);
%>
  <tr>
    <td width="21%" class="row1"><%=us.getUsername()%></td>
    <td width="7%" align="center" class="row1"><%=us.getTypeOfUser()%></td>
    <td width="17%" align="center" class="row1"><%=us.getLoginTime()%></td>
    <td width="10%" align="center" class="row1"><%=bean.getDuration(us.getStartTime())%></td>
    <td width="17%" align="center" class="row1"><%=us.getLastUpdateTime()%></td>
    <td width="10%" align="center" class="row1"><%=us.getSid()%></td>
    <td width="18%" align="center" class="row1"><%=us.getClientIp()%></td>
  </tr>
<% } %>
<%
  ltArray = bean.getTotalOnlineMembers();
  for (int i=0; i<ltArray.size(); i++) {
      UserSession us = (UserSession)ltArray.get(i);
%>
  <tr>
    <td width="21%" class="row1"><%=us.getUsername()%></td>
    <td width="7%" align="center" class="row1"><%=us.getTypeOfUser()%></td>
    <td width="17%" align="center" class="row1"><%=us.getLoginTime()%></td>
    <td width="10%" align="center" class="row1"><%=bean.getDuration(us.getStartTime())%></td>
    <td width="17%" align="center" class="row1"><%=us.getLastUpdateTime()%></td>
    <td width="10%" align="center" class="row1"><%=us.getSid()%></td>
    <td width="18%" align="center" class="row1"><%=us.getClientIp()%></td>
  </tr>
<% } %>
<%
  ltArray = bean.getTotalOnlineUsers();
  for (int i=0; i<ltArray.size(); i++) {
      UserSession us = (UserSession)ltArray.get(i);
%>
  <tr>
    <td width="21%" class="row1"><%=us.getUsername()%></td>
    <td width="7%" align="center" class="row1"><%=us.getTypeOfUser()%></td>
    <td width="17%" align="center" class="row1"><%=us.getLoginTime()%></td>
    <td width="10%" align="center" class="row1"><%=bean.getDuration(us.getStartTime())%></td>
    <td width="17%" align="center" class="row1"><%=us.getLastUpdateTime()%></td>
    <td width="10%" align="center" class="row1"><%=us.getSid()%></td>
    <td width="18%" align="center" class="row1"><%=us.getClientIp()%></td>
  </tr>
<% } %>
<%
  CommunityUserInfo[] arUser = bean.getTotalOnlineCommunityMembers();
  for (int i=0; arUser!=null && i<arUser.length; i++) {
     if (arUser[i].m_sLocalIp!=null) {
%>
  <tr>
    <td width="21%" class="row1"><%=arUser[i].EMail%></td>
    <td width="7%" align="center" class="row1"><%="Member"%></td>
    <td width="17%" align="center" class="row1"><%=Utilities.getDateTime(arUser[i].m_nSignInTime)%></td>
    <td width="10%" align="center" class="row1"><%=bean.getDuration(arUser[i].m_nSignInTime)%></td>
    <td width="17%" align="center" class="row1"><%=Utilities.getDateTime(arUser[i].m_nLastAccessTime)%></td>
    <td width="10%" align="center" class="row1"><%=arUser[i].m_sSid%></td>
    <td width="18%" align="center" class="row1"><%=arUser[i].m_sClientIp%></td>
  </tr>
<% }} %>
</table>