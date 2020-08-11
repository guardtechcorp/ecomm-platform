<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<title>Administrator - Free Test Drive Sign Up</title>
</head>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/signup.js"></SCRIPT>
<body>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.bean.DomainBean"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%
  DomainBean bean = new DomainBean(session, 20);
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "failed";
  DomainInfo dmInfo = null;
  CompanyInfo cpInfo = null;
  boolean bRegister = false;
  if ("Sign Up Now".equalsIgnoreCase(sAction))
  {
// bean.dumpAllParameters(request);
    DomainBean.Result ret = bean.freeSignup(request, null);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
    }
    else
    {
      bRegister = true;
      sClass = "successful";
      sDisplayMessage = "It is successfully to register your domain.";

      Object[] arInfo = (Object[])ret.getUpdateInfo();
      dmInfo = (DomainInfo)arInfo[0];
      cpInfo = (CompanyInfo)arInfo[1];
    }
  }
  if (dmInfo==null)
  {
    dmInfo = DomainInfo.getInstance(true);
    cpInfo = CompanyInfo.getInstance(true);
    cpInfo.Country = "USA";
  }

//  Don't miss this opportunity! We're currently offering a 14 Day TRIAL VERSION, so that you can experience the power of Volusion Ecommerce for yourself, including the powerful administration area. You'll be able to add your products, place and receive test orders, and much more!
//Our free trial is a fully functional TRIAL VERSION which you may use to test out Volusion Ecommerce before you decide to order. Your trial version includes both the frontend (what the customer sees), and the backend (the administration area

%>
<% if (!bRegister) { %>
<form name="domainsignup" method="post" action="freetest.jsp" onSubmit="return validateFreeSignup(this, 'www', 'webcenter123.com');">
<input type="hidden" name="domainname" value="">
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td colspan="3" align="center"><Font color="red"><%=sDisplayMessage%></Font></td>
  </tr>
  <tr>
    <td colspan="3" height="10" align="center"></td>
  </tr>
<% } %>
  <tr>
    <td width="25%" align="right">Your Website Name:</td>
    <td width="1%">&nbsp;</td>
    <td><b>www.</b><input maxlength=20 size=20 name="sitename" value="<%=Utilities.getValue(request.getParameter("sitename"))%>"><b>.webcenter123.com</b></td>
  </tr>
  <tr>
    <td width="25%" align="right">Your Name:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=40 size=40 name="yourname" value="<%=Utilities.getValue(request.getParameter("yourname"))%>"></td>
  </tr>
  <tr>
    <td width="25%" align="right">Phone Number:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 name="phone" value="<%=Utilities.getValue(request.getParameter("phone"))%>"></td>
  </tr>
  <tr>
    <td width="25%" align="right">E-Mail:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=60 size=40 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>"> (Current active E-Mail)</td>
  </tr>
  <tr>
    <td height="10" colspan="3"></td>
  </tr>
  <tr>
    <td width="25%" align="right">Password:</td>
    <td width="1%">&nbsp;</td>
    <td>
    <input maxlength=20 size=20 name="password" type="password" value="<%=Utilities.getValue(request.getParameter("password"))%>">
    (Admin account passowrd)
    </td>
  </tr>
  <tr>
    <td width="25%" align="right">Confirm Password:</td>
    <td width="1%">&nbsp;</td>
    <td>
     <input maxlength=20 size=20 name="cpassword" type="password" value="<%=Utilities.getValue(request.getParameter("cpassword"))%>">
    </td>
  </tr>
  <tr>
    <td width="25%" align="right" valign="top">Enter the code shown below:</td>
    <td width="1%">&nbsp;</td>
    <td valign="top">
     <input maxlength=20 size=20 name="input">&nbsp;This will prevent automated registrations. <a href="javascript:ChildWin=window.open('/staticfile/web/imagecode-help.html','imagecode_help','resizable=yes,scrollbars=no,width=460,height=450');ChildWin.focus()">Help</a>
     <br><img name="captchaimg" src="../util/captcha.jsp?action=getimage" align="top" alt="Enter the characters appearing in this image" border="1"/>
    </td>
  </tr>
  <tr>
    <td width="25%" align="right"><input type="hidden" name="agreeto" value="1"></td>
    <td width="1%"></td>
    <!--td>I agree to the terms and conditions. <a href="javascript:ChildWin=window.open('/agreement.html','Agreement','resizable=yes,scrollbars=yes,width=500,height=650');ChildWin.focus()">View it </a></td-->
    <td></td>
  </tr>
  <tr>
    <td colspan="3" height="10"></td>
  </tr>
  <tr>
    <td width="25%">&nbsp;</td>
    <td width="1%">&nbsp;</td>
    <td ><input type="submit" name="action" value="Sign Up Now"></td>
  </tr>
</table>
</form>
<SCRIPT>onFreeSignUpLoad(document.domainsignup);</SCRIPT>
<% } else { %>
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
  <tr>
    <td colspan="3" height="5" align="center"></td>
  </tr>
  <tr>
    <td width="5%"></td>
    <td width="90%">
Congratulations!!! You have successfully signed up a free test website and online store.<br>
Your test website and online store is open now and will be closed in 30 days.<br>
You can visit your website at: <a href="http://<%=dmInfo.DomainName%>" target="_blank">http://<%=dmInfo.DomainName%></a>.
<p>
You can login your admin account to set up and manage your web site any time from anywhere.<br>
Your administration console URL is: <a href="http://<%=dmInfo.DomainName%>/console" target="_blank">http://<%=dmInfo.DomainName%>/console</a><br>
Your username is: <b>admin</b><br>
Your password is: <b><%=cpInfo.Password%></b></p>
<p>
Your email account was also created and you can send and receive email by using a web browser.<br>
Your email box address (URL) is: <a href="http://<%=dmInfo.DomainName%>/webmail" target="_blank">http://<%=dmInfo.DomainName%>/webmail</a><br>
Your UserID is: <b>admin@<%=dmInfo.EmailDomain%></b><br>
Your Password is: <b><%=cpInfo.Password%></b> (the same as admin account of your website)</p>
<p>
The six company forwarding email addresses were also generated. They will automatically forward to
<b>admin@<%=dmInfo.EmailDomain%></b> at first. You can reassign each of them to other employees of your company
later. The six forwarding emails are:<br>
   <b>1. customerservice@<%=dmInfo.EmailDomain%></b><br>
   <b>2. sales@<%=dmInfo.EmailDomain%></b><br>
   <b>3. support@<%=dmInfo.EmailDomain%></b><br>
   <b>4. newsletter@<%=dmInfo.EmailDomain%></b><br>
   <b>5. rma@<%=dmInfo.EmailDomain%></b><br>
   <b>6. staff@<%=dmInfo.EmailDomain%></b><br>
</p>
<p>Thank you again for using <%=bean.getConfigValue("productname")%> service from <%=bean.getConfigValue("company")%>!</p>
   </td>
   <td width="5%"></td>
  </tr>
  <tr>
    <td colspan="3" height="10" align="center"></td>
  </tr>
</table>
<% } %>
<%@ include file="../share/footer.jsp"%>