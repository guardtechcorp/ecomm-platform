<%@ include file="../share/header.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ControlPanelBean"%>
<%@ page import="com.zyzit.weboffice.model.BookInfo"%>
<%
  ControlPanelBean bean = new ControlPanelBean(session);
  UserInfo urInfo = (UserInfo)session.getAttribute(Definition.KEY_COMPANYUSER);

  List ltArray = bean.getAccessBookList(request);
%>
<table width="100%" border="0" align="center">
  <tr>
    <td width="3%" height="5"></td>
    <td width="94%" height="5" align="center">
      <!--h2>Welcome to Administration Console of <a href="http://<%=bean.getDomainName()%>" target="_blank"><%=bean.getDomainName()%></a></h2-->
    </td>
    <td width="3%" height="5"></td>
  </tr>
  <tr>
    <td width="3%"></td>
    <td width="94%" align="center"><font size=3>The control panel below lists all the functions that you can access.</font></td>
    <td width="3%" ></td>
  </tr>
</table>
<!--br-->
<table width="90%" cellpadding="2" cellspacing="2" border="1" align="center">
<tr><td>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
<%
  for (int i=0; i<ltArray.size(); i+=3) {
     String sPanel = (String)ltArray.get(i);
%>
<tr><td>
<table cellspacing=0 cellpadding=2 width=100% border=0 align=center>
 <tr>
  <td valign=top width=33%>
   <%=sPanel%>
  </td>
  <td valign="top" width="33%">
<% if (i+1<ltArray.size()) {
    sPanel = (String)ltArray.get(i+1);
%>
   <%=sPanel%>
<% } %>
    </td>
    <td valign="top" width="33%">
<% if (i+2<ltArray.size()) {
  sPanel = (String)ltArray.get(i+2);
%>
   <%=sPanel%>
<% } %>
    </td>
  </tr>
</table>
</td></tr>
<% } %>
</table>
</td></tr>
</table>
<br>
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td colspan=3 height="5">
   </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="94%" align="center"><hr>
      <%=bean.getCopyRight()%><br><%=bean.getPowerBy()%>
    </td>
    <td width="3%">&nbsp;</td>
  </tr>
</table>
</body>
</html>