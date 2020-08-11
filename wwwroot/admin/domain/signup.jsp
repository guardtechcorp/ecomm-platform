<!--%@ include file="../share/header.jsp"%-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<title>Administrator - Sign Up</title>
<style type="text/css">
font,td,p { font-family: Verdana, Arial, Helvetica, sans-serif }
p, td		{ font-size : 12;}
</style>
</head>
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/sarissa.js"></SCRIPT-->
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/customer.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/signup.js"></SCRIPT>
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
    DomainBean.Result ret = bean.signup(request);
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
    cpInfo.Country_Bill = "USA";
  }
%>
<% if (!bRegister) { %>
<form name="domainsignup" method="post" action="signup.jsp" onSubmit="return validateSignup(this);">
<input type="hidden" name="priceplandesc" value="">
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
  <tr>
    <td colspan="3" height="3" align="center"></td>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td colspan="3" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
  <tr>
    <td colspan="3" height="10" align="center"></td>
  </tr>
<% } %>
    <tr>
      <td width="26%" align="right">Service Plan:</td>
      <td width="1%">&nbsp;</td>
      <td>
      <select name="priceplan">
      <option value="1">Standard Service Plan ($50/Month, $200 for Setup)</option>
      <option value="2" selected>Professional Service Plan ($99/Month, $399 for Setup)</option>
      </select>
     </td>
  </tr>
  <!--tr>
    <td width="26%" align="right"><input type="checkbox" name="livechat" value="1"></td>
    <td width="1%">&nbsp;</td>
    <td>Live Chat Service (Plus $30/Month)</td>
  </tr-->
  <tr>
    <td width="26%" align="right"><input type="checkbox" name="forum" value="1"></td>
    <td width="1%">&nbsp;</td>
    <td>Bulletin Board Forum (Plus $20/Month)</td>
  </tr>
  <tr>
    <td colspan="3" height="10" align="center"></td>
  </tr>
  <tr>
    <td width="26%" align="right">Your Website Name:</td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=80 size=40 name="domainname" value="<%=Utilities.getValue(dmInfo.DomainName)%>"> (Example: www.abc.com)</td>
  </tr>
  <tr>
    <td width="26%" align="right" valign="top">Note:</td>
    <td width="1%">&nbsp;</td>
    <td><font size="1">You should create a CName of DNS record (ex. www.youdomain.com) pointing to <b>www.webonlinemanage.com</b> and MX record (for email domain) to <b>mail.webonlinemanage.com</b>.
    If you do not know how to do that, please provide <a href="javascript:toggleShow('DM_PRIVODER');">domain name information</a> to us, our technician will help you to implement.</font>
    </td>
  </tr>
  <tr>
    <td colspan=3>
    <DIV id="DM_PRIVODER" style="display: none">
    <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
    <tr>
      <td width="26%" align="right">Domain name provider:</td>
      <td width="1%">&nbsp;</td>
      <td>
      <select name="provider">
      <option value=none selected>Select Provider</option>
      <option value=www.godady.com>www.godady.com</option>
      <option value=mydomain.com>www.mydomain.com</option>
      <option value=register.com>www.register.com</option>
      <option value=yahoo.com>www.yahoo.com</option>
      <option value=domainrightnow.com>www.domainrightnow.com</option>
      <option value=others>Others</option>
      <option value=Apply Domain Name>Apply Domain Name for Me</option>
      </select>
     </td>
    </tr>
    <tr>
     <td width="26%" align="right">User Name/Account:</td>
     <td width="1%">&nbsp;</td>
     <td><input maxlength=20 size=20 name="account" value="<%=Utilities.getValue(dmInfo.Account)%>"> Password:
         <input maxlength=20 size=20 name="passwd" value="<%=Utilities.getValue(dmInfo.Passwd)%>" type="password">
     </td>
    </tr>
  <tr>
    <td colspan="3" height="10"></td>
  </tr>
   </table></DIV>
   </td>
  </tr>
  <tr>
    <td width="26%" align="right">Your Name:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=40 size=40 name="yourname" value="<%=Utilities.getValue(cpInfo.Yourname)%>"></td>
  </tr>
  <tr>
    <td width="26%" align="right">E-Mail:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=60 size=40 name="email" value="<%=Utilities.getValue(cpInfo.EMail)%>"> (Current active E-Mail)</td>
  </tr>
  <tr>
    <td width="26%" align="right">Phone Number:</td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=20 size=40 name="phone" value="<%=Utilities.getValue(cpInfo.Phone)%>"></td>
  </tr>
  <tr>
    <td width="26%" align="right">Fax Number:</td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=20 size=40 name="fax" value="<%=Utilities.getValue(cpInfo.Fax)%>"> (Optional)</td>
  </tr>
  <tr>
    <td colspan="3" height="10"></td>
  </tr>
  <tr>
    <td width="26%" align="right">Company Name:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=50 size=40 name="companyname" value="<%=Utilities.getValue(cpInfo.CompanyName)%>"></td>
  </tr>
  <tr>
    <td width="26%" align="right">Company Address:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=60 size=40 name="address" value="<%=Utilities.getValue(cpInfo.Address)%>"></td>
  </tr>
  <tr>
    <td width="26%" align="right">City:</td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=60 size=40 name="city" value="<%=Utilities.getValue(cpInfo.City)%>"></td>
  </tr>
  <tr>
    <td width="26%" align="right">State/Province:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=30 size=28 name="state" value="<%=Utilities.getValue(cpInfo.State)%>">
    Zip/Postal:<input maxlength=12 size=10 name="zipcode" value="<%=Utilities.getValue(cpInfo.ZipCode)%>">
   </td>
  </tr>
  <tr>
    <td width="26%" align="right">Country/Region:</td>
    <td width="1%">&nbsp;</td>
    <td>
    <select name="country" size="1">
    </select>
    </td>
  </tr>
  <tr>
    <td colspan="3" height="10"><hr></td>
  </tr>

  <tr>
    <td width="26%" align="right">Credit Card Billing Address:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=60 size=40 name="address_bill" value="<%=Utilities.getValue(cpInfo.Address_Bill)%>"></td>
  </tr>
  <tr>
    <td width="26%" align="right">City:</td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=60 size=40 name="city_bill" value="<%=Utilities.getValue(cpInfo.City_Bill)%>"></td>
  </tr>
  <tr>
    <td width="26%" align="right">State/Province:</td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=30 size=28 name="state_bill" value="<%=Utilities.getValue(cpInfo.State_Bill)%>">
    Zip/Postal:<input maxlength=12 size=10 name="zipcode_bill" value="<%=Utilities.getValue(cpInfo.ZipCode_Bill)%>">
   </td>
  </tr>
  <tr>
    <td width="26%" align="right">Country/Region:</td>
    <td width="1%">&nbsp;</td>
    <td>
    <select name="country_bill" size="1">
    </select>
    </td>
  </tr>
  <tr>
    <td colspan="3" height="10" align="center"></td>
  </tr>
  <tr>
    <td width="26%" align="right">Name on Card:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=40 size=40 name="nameoncard" value="<%=Utilities.getValue(cpInfo.NameOnCard)%>"></td>
  </tr>
  <tr>
    <td width="26%" align="right">Credit Card Type:</td>
    <td width="1%">&nbsp;</td>
    <td >
      <select name="credittype">
      <option value=Visa selected>Visa</option>
      <option value=MasterCard>MasterCard</option>
      <option value=AmericanEx>American Express</option>
      <option value=Discover>Discover</option>
      </select>
    </td>
  </tr>
  <tr>
    <td width="26%" align="right">Credit Card Number:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 name="creditno" value="<%=Utilities.getValue(cpInfo.CreditNo)%>"></td>
  </tr>
  <tr>
    <td width="26%" align="right">Expiration Date:</td>
    <td width="1%">&nbsp;</td>
    <td ><select name="expiredmonth">
        <option value=No selected>Month
        <option value=01>January</option>
        <option value=02>February</option>
        <option value=03>March</option>
        <option value=04>April</option>
        <option value=05>May</option>
        <option value=06>June</option>
        <option value=07>July</option>
        <option value=08>August</option>
        <option value=09>September</option>
        <option value=10>October</option>
        <option value=11>November</option>
        <option value=12>December</option>
      </select>
      <select name="expiredyear">
        <option value="None" selected>Year</option>
        <option value="2005">2005</option>
        <option value="2006">2006</option>
        <option value="2007">2007</option>
        <option value="2008">2008</option>
        <option value="2009">2009</option>
        <option value="2010">2010</option>
        <option value="2011">2011</option>
        <option value="2012">2012</option>
        <option value="2013">2013</option>
        <option value="2014">2014</option>
        <option value="2015">2015</option>
      </select>
    </td>
  </tr>
  <tr>
    <td width="26%" align="right">Card Verification No.:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=8 size=12 name="csid" type="text" value="<%=Utilities.getValue(cpInfo.Csid)%>"><font size=1>(Visa, MasterCard, Discover & American Express only. <a href="javascript:ChildWin=window.open('/cards-help.html','cards_help','resizable=yes,scrollbars=no,width=460,height=630');ChildWin.focus()">Help</a>)</font></td>
  </tr>
  <tr>
    <td height="10" colspan="3"></td>
  </tr>
  <tr>
    <td width="26%" align="right">Password:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=20 name="password" type="password">(for admin account)</td>
  </tr>
  <tr>
    <td width="26%" align="right">Confirm Password:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=20 name="cpassword" type="password"></td>
  </tr>
  <tr>
    <td width="26%" align="right"><input type="checkbox" name="agreeto" value="1"></td>
    <td width="1%">&nbsp;</td>
    <td>I agree to the terms and conditions. <a href="javascript:ChildWin=window.open('/agreement.html','Agreement','resizable=yes,scrollbars=yes,width=500,height=650');ChildWin.focus()">View it </a></td>
  </tr>
  <tr>
    <td colspan="3" height="10"></td>
  </tr>
  <tr>
    <td width="26%">&nbsp;</td>
    <td width="1%">&nbsp;</td>
    <td ><input type="submit" name="action" value="Sign Up Now"></td>
  </tr>
</table>
</form>
<SCRIPT>setupOption(document.domainsignup.country, g_Country, "<%=cpInfo.Country%>");</SCRIPT>
<SCRIPT>setupOption(document.domainsignup.country_bill, g_Country, "<%=cpInfo.Country_Bill%>");</SCRIPT>
<SCRIPT>CreditCardSelect(document.domainsignup, "<%=cpInfo.CreditType%>", "<%=cpInfo.ExpiredMonth%>", "<%=cpInfo.ExpiredYear%>");</SCRIPT>
<SCRIPT>onSignUpLoad(document.domainsignup);</SCRIPT>
<% } else { %>
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
  <tr>
    <td colspan="3" height="20" align="center"></td>
  </tr>
  <tr>
    <td width="5%"></td>
    <td width="90%">
Congratulations!!! You have successfully signed up. And thank you for selecting <%=dmInfo.m_sPricePlanDesc%>.
KZ Company will charge your credit card for the amount of the setup fee plus first monthly fee specified by the plan you choose.
We will charge your credit card for monthly fee in the first day of each month.<br><br>
Your website and online store will open within 24-hour if we confirm all the information you filled in are correct.<br>
You can visit your website at: <a href="http://<%=dmInfo.DomainName%>" target="_blank">http://<%=dmInfo.DomainName%></a>.
<p>
You can login your admin account to set up and manage your web site any time from anywhere.<br>
Your administration console URL is: <a href="http://<%=dmInfo.DomainName%>/console" target="_blank">http://<%=dmInfo.DomainName%>/console</a><br>
Your username is: <b>admin</b><br>
Your password is: <b><%=cpInfo.Password%></b></p>
<p>
Your email account will also be created and you can send and receive email by using a web browser.<br>
Your email box address (URL) is: <a href="http://<%=dmInfo.DomainName%>/webmail" target="_blank">http://<%=dmInfo.DomainName%>/webmail</a><br>
Your UserID is: <b>admin@<%=dmInfo.EmailDomain%></b><br>
Your Password is: <b><%=cpInfo.Password%></b> (the same as admin account of your website)</p>
<p>
The six company forwarding email addresses will also be generated. They will automatically forward to
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