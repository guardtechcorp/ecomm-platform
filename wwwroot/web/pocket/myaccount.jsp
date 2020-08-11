<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 10);
//web.dumpAllParameters(request);
  String sAction = web.getRealAction(request);
  CustomerInfo ctInfo = web.getCustomerInfo();
  if (ctInfo==null)
  {//. It is not login and we need to forece it to login first
    TransferWeb.sendRedirectContent(response, "index.jsp?action=cp-accountlogin&nextaction=cp-view-myaccount");
    return;
  }

  ConfigInfo cfInfo = web.getConfigInfo();
  String sTitleLinks = web.getNavigationWeb(request, "My Account");
%>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
<tr>
<td height=20>
  <TABLE width="98%" align="center" border=0 cellpadding="0" cellspacing="1">
  <TR vAlign="middle" bgColor="#4959A7">
    <td align="left"><a href="<%=web.encodedUrl("index.jsp?action=cp-edit-accountinfo")%>" class="button">Profile</a></td>
   </TR>
  <TR vAlign="middle" bgColor="#4959A7">
    <td align="left" height=20><a href="<%=web.encodedUrl("index.jsp?action=cp-buycredit")%>" class="button">Buy Credit</a></td>
   </TR>
  <TR vAlign="middle" bgColor="#4959A7">
    <td align="left" height=20><a href="<%=web.encodedUrl("index.jsp?action=cp-transactionlist")%>" class="button">Buy Credit List</a></td>
   </TR>
  <TR vAlign="middle" bgColor="#4959A7">
    <td align="left" height=20><a href="<%=web.encodedUrl("index.jsp?action=ordertrack")%>" class="button">Get Reports History</a></td>
   </TR>
 </TABLE>
</td>
</tr>
<TR>
<TD height=5 valign="top"></TD>
</TR>
<TR>
<TD align="center"><font class='pagetitle'>My Account</font></TD>
</TR>
<TR>
<TD height=10 valign="bottom"></TD>
</TR>
</table>
<% } %>