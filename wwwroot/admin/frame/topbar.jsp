<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.AccessRole"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<HTML>
<HEAD>
<TITLE>Web Online Management Center - Top Bar Page</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="/staticfile/admin/css/topstyle.css" type="text/css" rel="stylesheet">
</HEAD>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/windows.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js"></SCRIPT>
<SCRIPT Language="JavaScript">
function showHelp()
{
  if (parent.frames["main"].g_titlelink!=0)
     parent.frames["main"].showHelp();
}
function hideHelp()
{
  if (parent.frames["main"].g_titlelink!=0)
     parent.frames["main"].hideHelp();
}
</SCRIPT>
<%
   BasicBean bean = new BasicBean(session, null);
   UserInfo urInfo = (UserInfo)session.getAttribute(Definition.KEY_COMPANYUSER);
   CompanyInfo cpInfo = bean.getCompanyInfo();
   DomainInfo dmInfo = bean.getDomainInfo();

//   | <A class="button" href="javascript:newWindow('about.jsp?action=About','_blank',400,180,'no','center')" onmouseover="window.status='About product and version';return true" onmouseout="window.status='';return true">About</A>&nbsp;
%>
<BODY bgColor="#ffffff" leftMargin=0 topMargin=0 marginheight="0" marginwidth="0">
<TABLE class="header" cellSpacing=0 cellPadding=0 width="100%" border=0>
<TR>
<TD width="10%"><IMG height=50 width=200 src="/staticfile/admin/images/womglogo.gif"></TD>
<TD width="40%">
    <Table cellSpacing=0 cellPadding=0 width="100%" height="100%" border=0 align="center">
    <tr>
      <td align="center" height="14" colspan="2"></td>
    </tr>
    <tr>
      <td width="2"></td>
      <td align="left"><font face="Geneva, Arial, Helvetica, san-serif" color="#E9E6ED" size=4><b> of <%=bean.getDomainName()%></b></font></td>
    </tr>
    <tr>
      <td height=5 colspan="2"></td>
    </tr>
    </Table>
</TD>
<TD vAlign="top" align="right">
  <TABLE cellSpacing=0 cellPadding=0 border=0>
  <TR>
     <TD><IMG height=20 src="/staticfile/admin/images/topcorner.gif" width=17></TD>
     <TD class="headertab" noWrap valign="middle">&nbsp;
	<A class="button" onmouseover="window.status='My Profile';return true" onmouseout="window.status='';return true"
	href="../user/myprofile.jsp?action=My Profile" target="main">My Profile</A>
<% if (dmInfo.EmailDomain!=null) {%>
        | <A class="button" onmouseover="window.status='My Email Box';return true" onmouseout="window.status='';return true"
	href="../signin/login.jsp?action=Emailbox" target="EmailBox">My Mail Box</A>
<% } %>
        | <A class="button" href="../util/welcome.jsp" target="main" onmouseover="window.status='Features and Functions in Control Panel';return true" onmouseout="window.status='';return true">Contol Panel</A>
        | <A class="button" href="javascript:modalWin('../frame/support.jsp?action=Technical Support',600,500)" onmouseover="window.status='Ask a question for technical support';return true" onmouseout="window.status='';return true">Support</A>
        | <A class="button" href="javascript:;" onmouseover="showHelp();" onmouseout="hideHelp();"><IMG src="/staticfile/admin/images/quickhelp.gif" width=14 height=16 align="absMiddle" border="0">Help</A>
	| <A class="button" href="javascript:modalWin('../frame/about.jsp?action=About',400,200)" onmouseover="window.status='About product and version';return true" onmouseout="window.status='';return true">About</A>&nbsp;
     </TD>
  </TR>
  <TR>
    <TD colSpan=2 height=10></TD>
  </TR>
  <TR>
    <TD colSpan=2 height=20 align="right"><font size=2 color="#FF8400"><b><i>Hello, <%=Utilities.getValue(urInfo.RealName)%>!</i></b></font>&nbsp;&nbsp;&nbsp;<A class=button2 href='<%=bean.encodedAdminUrl("../signin/login.jsp?action=logout&domainname=" + bean.getDomainName())%>' target="_parent">[ Log Out ] </A>&nbsp;</TD>
  </TR>
  </TABLE>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>
