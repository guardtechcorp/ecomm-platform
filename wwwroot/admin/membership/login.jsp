<%@ page import="java.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberBean"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%
//Old   String sDomainName = MemberBean.getDomainNameFromUrl(session, request, true);
   MemberBean bean = new MemberBean(session, 0);
   if (!bean.setDomainInit(request, application.getRealPath("/")))
      return;
   String sDomainName = bean.getDomainName();

//  bean.showAllParameters(request, out);
//bean.showSessionInfo(request, application, session, out);
   String sAction = request.getParameter("action");
/*
//System.out.println("sAction =" + sAction + "," + sDomainName);
   if ("idle".equalsIgnoreCase(sAction))
   {
     bean.checkIdle(request);
     return;
   }
*/

   String sDisplayMessage = "";
   String sClass = "successful";
   int nError = 0;
   if ("Login".equalsIgnoreCase(sAction))
   {
     MemberBean.Result ret = bean.login(request, sDomainName);
     if (ret.isSuccess())
     {
/*
       //. First check prevuri
       String sRedirUrl = request.getParameter("prevuri");
//System.out.println("First URL =" + sRedirUrl);
       if (sRedirUrl==null||sRedirUrl.trim().length()==0)
       {
          sRedirUrl = bean.getSettingInfo("firsturl").Content;
// System.out.println("First URL =" + sRedirUrl);
          if (sRedirUrl==null)
             sRedirUrl = "http://" + bean.getDomainName();
       }
       response.sendRedirect(sRedirUrl);
*/
       response.sendRedirect((String)ret.getInfoObject());
     }
     else
     {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
       sClass = "failed";
     }
   }
   else if ("Logout".equalsIgnoreCase(sAction))
   {
      String sRedirUrl =  bean.logout1(request);
      if (sRedirUrl!=null)
        response.sendRedirect(sRedirUrl);
   }
   else if ("Forgot Password".equalsIgnoreCase(sAction))
   {
      MemberBean.Result ret = bean.forgotPassword(request);
      if (!ret.isSuccess())
      {
        Errors errObj = (Errors)ret.getInfoObject();
        sDisplayMessage = errObj.getError();
        sClass = "failed";
      }
      else
      {
        sDisplayMessage = (String)ret.getInfoObject();
      }
   }

   String sHeader = bean.getLoginPage(1);
//ctr/admin/membership/login.jsp?action=load&customer=1&prevuri=/ctr/memberarea/doctor/index.html
//ctr/admin/membership/login.jsp?action=load&customer=2&prevuri=/ctr/memberarea/patient/index.html
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Chemistry Survival Publishing'>
<title>Member Login of <%=sDomainName%></title>
</head>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/membership.js"></SCRIPT>
<body bgcolor="<%=bean.getLoginPage(0)%>">
<table width="680" align="center" border="1" bordercolor="#CCCCCC">
<tr>
  <td align="center">
<% if (sHeader!=null) { %>
    <%=sHeader%>
<% } else { %>
 <TABLE WIDTH=680 BORDER=0 CELLPADDING=0 CELLSPACING=0>
   <!--TR>
     <TD ROWSPAN=3><IMG SRC="/staticfile/admin/images/loginheader_01.gif" WIDTH=228 HEIGHT=80 ALT=""></TD>
     <TD><IMG SRC="/staticfile/admin/images/loginheader_02.gif" WIDTH=452 HEIGHT=24 ALT=""></TD>
   </TR-->
   <!--TR>
     <TD height=48 align="left" valign="top">&nbsp;&nbsp;&nbsp
       <font size="5" color="#0061B0" face="Arial"><b><%=sDomainName%><b></font>
     </TD>
   </TR-->
   <!--TR>
      <TD><IMG SRC="/staticfile/admin/images/loginheader_04.gif" WIDTH=452 HEIGHT=8 ALT=""></TD>
   </TR-->
   <TR>
      <TD align="center" colspan=2>
       <font color='#0066CC' size=4 face='Arial, Helvetica, sans-serif'>Member Login</font><br>
       <font color='#999999' size=2 face='Verdana, Arial, Helvetica, sans-serif'>Enter your email and password provided to access this member-only area.</font><font color='#999999'></font><br>
      </TD>
   </TR>
   <TR>
      <TD align="center" colspan=2 height=10></TD>
   </TR>
 </TABLE>
<% } %>
 </td>
</tr>
<tr>
  <td align="center">
<form name="Login" method="post" action="login.jsp" onsubmit="return validateMemberLogin(this);">
  <input type="hidden" name="domainname" value="<%=sDomainName%>">
  <input type="hidden" name="prevuri" value="<%=Utilities.getValue(request.getParameter("prevuri"))%>">
  <input type="hidden" name="customer" value="<%=Utilities.getValue(request.getParameter("customer"))%>">
  <table border="0" width="440" cellspacing="0" cellpadding="0" align="center" height="200">
    <tr>
      <td colspan="3" bordercolor="#C0C0C0" bgcolor="#0065B3" align="center">
        <font face="Arial" size="2" color="#FFFFFF">Please enter your E-Mail and password:</font></td>
    </tr>
    <tr bgcolor="#EBEBEB">
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr bgcolor="#EBEBEB">
      <td colspan="3" align="center"><font color="red"><%=sDisplayMessage%></font></td>
    </tr>
    <tr bgcolor="#EBEBEB">
      <td colspan="3" height=10></td>
    </tr>
    <tr bgcolor="#EBEBEB">
      <td align="right" valign="middle" width="40%" align="right"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Your Email</strong>:</font></td>
      <td width="5%">&nbsp;</td>
      <td width="55%"><input name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>" size="30" maxlength="50" style="width:180"></td>
    </tr>
    <tr bgcolor="#EBEBEB">
      <td align="right" valign="middle" width="40%" align="right"><font size="2" face="Arial, Helvetica, sans-serif"><strong>Password</strong>:</font></td>
      <td width="5%">&nbsp;</td>
      <td width="55%"><input name="password" type="password" value="" size="30" maxlength="20" style="width:180"></td>
    </tr>
    <tr bgcolor="#EBEBEB">
      <td width="40%" align="right">&nbsp;<input type="checkbox" name="remember"></td>
      <td width="5%">&nbsp;</td>
      <td width="55%"><font size="2" face="Arial, Helvetica, sans-serif">Remember My E-Mail</font></td>
    </tr>
    <tr bgcolor="#EBEBEB">
      <td colspan="3" bgcolor="#EBEBEB" height="2">&nbsp;</td>
    </tr>
    <tr bgcolor="#EBEBEB">
      <td width="40%" height="15" align="center">
      <a onClick="return hasEmailAccount(document.Login);" href="javascript:forgotPassword(document.Login, 'login.jsp', '<%=sDomainName%>')"><font size="2" face="Arial, Helvetica, sans-serif">Forgot Your Password?</font></a></td>
      <td width="5%" height="15">&nbsp;</td>
      <td valign="middle" align="left" width="55%" height="15">
<% if (nError==0) {%>
          <input type="submit" value="Login" name="action">
<% } else { %>
          <input type="submit" value="Login" name="action" disabled>
<% } %>
      </td>
    </tr>
    <tr bgcolor="#EBEBEB">
      <td bgcolor="#EBEBEB" height="2" colspan="3">&nbsp;</td>
    </tr>
  </table>
</form>
</td></tr></table>
<SCRIPT>onMemberLoginLoad(document.Login);</SCRIPT>
<p>
<p>
<br>
<br>
<div align="center"><hr width="85%"><font face="arial" size=2><%=bean.getCopyRight()%><br><%=bean.getPowerBy()%></font></div>
<%@ include file="../share/footer.jsp"%>
<%
  if ("Logout".equalsIgnoreCase(sAction))
  {//. Clear all the cache information
//     session.invalidate();
  }
%>