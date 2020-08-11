<%@ page import="java.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.LoginBean"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%
   LoginBean bean = new LoginBean(session);
   String sAction = request.getParameter("action");
   if (!bean.setDomainInit(request, application.getRealPath("/")))
      return;
   String sDomainName = bean.getDomainName();
System.out.println("sDomainName=" + sDomainName);
//bean.showAllParameters(request, out);
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
//         response.sendRedirect("../frame/frame.jsp?action=Console");
         response.sendRedirect(bean.encodedAdminUrl("../frame/frame.jsp?action=Console"));
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
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/login.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js" type="text/javascript"></SCRIPT>
<body>
<p>&nbsp;
<br>
<TABLE width=680 align="center" border=1>
  <TR>
    <TD>

<TABLE WIDTH=680 BORDER=0 CELLPADDING=0 CELLSPACING=0>
  <TR>
    <TD ROWSPAN=3><IMG SRC="/staticfile/admin/images/loginheader_01.gif" WIDTH=228 HEIGHT=80 ALT=""></TD>
    <TD><IMG SRC="/staticfile/admin/images/loginheader_02.gif" WIDTH=452 HEIGHT=24 ALT=""></TD>
  </TR>
  <TR>
    <TD height=48 align="left" valign="top">&nbsp;&nbsp;&nbsp<!--IMG SRC="/staticfile/admin/images/loginheader_03.gif" WIDTH=452 HEIGHT=39 ALT=""-->
      <font size="5" color="#0061B0" face="Verdana, Arial, Helvetica, sans-serif"><b><%=sDomainName%></b></font>
    </TD>
  </TR>
  <TR>
     <TD><IMG SRC="/staticfile/admin/images/loginheader_04.gif" WIDTH=452 HEIGHT=8 ALT=""></TD>
  </TR>
</TABLE>
<br>
<script type="text/javascript">createTableOpen();</script><br>
<form name="Login" method="post" action="../signin/login.jsp" target="_parent" onsubmit="return validateLogin(this);">
 <input type="hidden" name="domainname" value="<%=sDomainName%>">
 <table border="0" width="520" cellspacing="0" cellpadding="0" align="center" height="200">
    <tr>
      <td colspan="3" align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF0000"><%=sDisplayMessage%></font></td>
    </tr>
    <tr>
      <td colspan="3" height=5></td>
    </tr>
    <tr>
      <td colspan="3" height="20" bgcolor1="#000080" align="center">
        <font face="Verdana, Arial, Helvetica, sans-serif" size="2" color1="#FFFFFF">Please enter your username and password:</font></td>
    </tr>
    <tr>
      <td colspan="3" height=5></td>
    </tr>
    <tr>
      <td align="right" valign="middle" width="45%">Username:</td>
      <td width="2%">&nbsp;</td>
      <td><input name="username" value="<%=Utilities.getValue(request.getParameter("username"))%>" maxlength="20" style="width:150"></td>
    </tr>
    <tr>
      <td align="right" valign="middle" width="45%">Password:</td>
      <td width="2%">&nbsp;</td>
      <td ><input name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>" type="password" value="" maxlength="20" style="width:150"></td>
    </tr>
    <tr>
      <td width="45%" align="right">&nbsp;<input type="checkbox" name="remember"></td>
      <td width="2%">&nbsp;</td>
      <td>&nbsp;Remember Username</td>
    </tr>
    <tr>
      <td colspan="3"  height="2">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="3" valign="middle" align="center" height="15">
        <input type="submit" value="Login" name="action" style="width:100" <%=nError==0?"":"disabled"%>>
      </td>
    </tr>
    <tr>
      <td colspan="3" height="10"></td>
    </tr>
    <tr>
      <td colspan="3" height="2" align="center"><%=bean.getTestDriveMessage(sDomainName)%></td>
    </tr>
    <!--tr>
      <td height="2" width="159">&nbsp;</td>
      <td width="6" height="2">&nbsp;</td>
      <td width="208" height="2">&nbsp;</td>
    </tr-->
  </table>
</form>
<script type="text/javascript">createTableClose();</script>
<SCRIPT type="text/javascript">onLoginLoad(document.Login);</SCRIPT>
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
   <div align="center"><hr><font face="Verdana, Arial, Helvetica, sans-serif" size=1><%=bean.getCopyRight()%> <%=bean.getPowerBy()%></font></div>
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