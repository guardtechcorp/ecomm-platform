<!--%@ include file="../share/header.jsp"%-->
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/login.js"></SCRIPT-->
<%@ page import="java.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.LoginBean"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%
//  response.setHeader("Cache-Control","no-store");
//  response.setHeader("Pragma","no-cache");
//  response.setDateHeader ("Expires", 0);

//   String sDomainName = LoginBean.getDomainNameFromUrl(session, request, true);
//   LoginBean bean = new LoginBean(session, sDomainName, application.getRealPath("/"));
   LoginBean bean = new LoginBean(session);
   String sAction = request.getParameter("action");
   if ("idle".equalsIgnoreCase(sAction))
   {
     bean.checkIdle(request);
     return;
   }

   if (!bean.setDomainInit(request, application.getRealPath("/")))
      return;
   String sDomainName = bean.getDomainName();

//  bean.showAllParameters(request, out);
//bean.showSessionInfo(request, application, session, out);
   String sDisplayMessage = "";
   int nError = 0;
   LoginBean.Result ret = bean.checkActive(sDomainName);
   if (!ret.isSuccess())
   {
     Errors errObj = (Errors)ret.getInfoObject();
     sDisplayMessage = errObj.getError();
     nError = errObj.getErrorNo();
   }
   else
   {
     if ("Login".equalsIgnoreCase(sAction))
     {
       ret = bean.login(request, sDomainName);
//System.out.println("It is forward now="+ret.isSuccess());
       if (ret.isSuccess())
         response.sendRedirect("../frame/frame.jsp?action=Console");
       else
       {
         Errors errObj = (Errors)ret.getInfoObject();
         sDisplayMessage = errObj.getError();
       }
     }
     else if ("Logout".equalsIgnoreCase(sAction))
     {
       boolean bRet = bean.logout(request);
       if ("windowclose".equalsIgnoreCase(request.getParameter("type")))
          return;
     }
     else if ("emailbox".equalsIgnoreCase(sAction))
     {
       String sUrl = bean.emailbox(request);
       response.sendRedirect(sUrl);
     }
     else
     {
       LoginBean.recordAction(request, null, session.getId(), LoginBean.WEBHIT_ADMIN, "Load Login Page");
     }
   }
//From here you can logon to your account and enter the administration area.
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<!--link rel="stylesheet" href="/staticfile/admin/css/main.css" type="text/css"-->
<title>Administration Console Login of <%=sDomainName%></title>
</head>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/login.js"></SCRIPT>
<body>
<p>&nbsp;
<br>
<TABLE borderColor=#cccccc width=680 align=center border=1>
  <TR>
    <TD>

<TABLE WIDTH=680 BORDER=0 CELLPADDING=0 CELLSPACING=0>
  <TR>
    <TD ROWSPAN=3><IMG SRC="/staticfile/admin/images/loginheader_01.gif" WIDTH=228 HEIGHT=80 ALT=""></TD>
    <TD><IMG SRC="/staticfile/admin/images/loginheader_02.gif" WIDTH=452 HEIGHT=24 ALT=""></TD>
  </TR>
  <TR>
    <TD height=48 align="left" valign="top">&nbsp;&nbsp;&nbsp<!--IMG SRC="/staticfile/admin/images/loginheader_03.gif" WIDTH=452 HEIGHT=39 ALT=""-->
      <font size="5" color="#0061B0" face="Arial"><b><%=sDomainName%></b></font>
    </TD>
  </TR>
  <TR>
     <TD><IMG SRC="/staticfile/admin/images/loginheader_04.gif" WIDTH=452 HEIGHT=8 ALT=""></TD>
  </TR>
</TABLE>
<br>
<script>createTableOpen();</script><br>
<form name="Login" method="post" action="login.jsp" target="_parent" onsubmit="return validateLogin(this);">
 <input type="hidden" name="domainname" value="<%=sDomainName%>">
 <table border="0" width="450" cellspacing="0" cellpadding="0" align="center" height="200">
    <tr>
      <td colspan="3" height="20" bgcolor1="#000080" align="center">
        <font face="Arial" size="2" color1="#FFFFFF">Please enter your username and password:</font></td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td colspan="3" height=5></td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td colspan="3" align="center"><font face="Arial" size="2" color="#FF0000"><%=sDisplayMessage%></font></td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td colspan="3" height=5></td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td align="right" valign="middle" width="200" align="right">Username:</td>
      <td width="10">&nbsp;</td>
      <td width="226"><input name="username" value="<%=Utilities.getValue(request.getParameter("username"))%>" maxlength="20" style="width:150"></td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td align="right" valign="middle" width="200" align="right">Password:</td>
      <td width="10">&nbsp;</td>
      <td width="226"><input name="password" type="password" value="" maxlength="20" style="width:150"></td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td width="200" align="right">&nbsp;<input type="checkbox" name="remember"></td>
      <td width="10">&nbsp;</td>
      <td width="226">&nbsp;Remember Username</td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td colspan="3"  height="2">&nbsp;</td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td width="200" height="15">&nbsp;</td>
      <td width="10" height="15">&nbsp;</td>
      <td width="260" valign="middle" align="left" height="15">
<% if (nError==0) {%>
          <input type="submit" value="Login" name="action">
<% } else { %>
          <input type="submit" value="Login" name="action" disabled>
<% } %>
      </td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td colspan="3" height="10"></td>
    </tr>
    <tr bgcolor1="#CCCCCC">
      <td colspan="3" height="2" align="center"><%=bean.getTestDriveMessage(sDomainName)%></td>
    </tr>
    <!--tr bgcolor1="#CCCCCC">
      <td height="2" width="159">&nbsp;</td>
      <td width="6" height="2">&nbsp;</td>
      <td width="208" height="2">&nbsp;</td>
    </tr-->
  </table>
</form>
<script>createTableClose();</script>
<SCRIPT>onLoginLoad(document.Login);</SCRIPT>
<table cellpadding=0 cellspacing=0 border=0 width="100%">
  <tr>
    <td height="30"></td>
  </tr>
</table>
 </TD>
 </TR>
</TABLE>
<p>
<TABLE WIDTH=690 BORDER=0 CELLPADDING=0 CELLSPACING=0 ALIGN="CENTER">
  <TR><TD>
   <div align="center"><hr><font face="arial" size=1><%=bean.getCopyRight()%> <%=bean.getPowerBy()%></font></div>
  </TD></TR>
</TABLE>
<%@ include file="../share/footer.jsp"%>
<%
  if ("Logout".equalsIgnoreCase(sAction))
  {//. Clear all the cache information
//     String sUrl = "../signin/login.jsp?domainname=" + bean.getDomainName();
//System.out.println("Invalidate session");
//       response.sendRedirect(sUrl);
     session.invalidate();
  }
%>