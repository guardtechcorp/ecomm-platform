<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/register.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.bean.RegisterBean"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%
   RegisterBean bean = new RegisterBean();
//  bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayError = "";
  RegisterBean.Result ret = null;
  if ("Register".equalsIgnoreCase(sAction))
  {
    ret = bean.register(session, request);
    if (!ret.isSuccess())
    {
      Errors er = (Errors)ret.getInfoObject();
      sDisplayError = er.getError();
    }
  }
%>
<% if (ret==null||!ret.isSuccess()) { %>
<h2 align="center">The registration form</h2>
<form name="register" method="post" action="register.jsp" onsubmit="return validateRegister(this);">
  <div align="center">
    <table cellspacing=0 cellpadding=0 width="63%" border=0>
      <tr>
        <td width="10%">&nbsp;</td>
        <td colspan="2">
          <div align="center"><span class="failed"><%=sDisplayError%></span></div>
        </td>
      </tr>
      <tr>
        <td width="10%">&nbsp;</td>
        <td colspan="2">
          <div align="center"></div>
        </td>
      </tr>
      <tbody>
      <tr>
        <td width="10%">
          <input type="hidden" name="testflag" value="1">
        </td>
        <td width="31%">Your Name:</td>
        <td width="59%">
          <input maxlength=40 name=yourname value="Neil Zhao">
        </td>
      </tr>
      <tr>
        <td width="10%">&nbsp;</td>
        <td width="31%">Your Email:</td>
        <td width="59%">
          <input maxlength=40 name=email value="nzhao@demo.com">
        </td>
      </tr>
      <tr>
        <td width="10%">&nbsp;</td>
        <td width="31%">Phone Number:</td>
        <td width="59%">
          <input maxlength=40 name=phone value="(714) 779-9988">
        </td>
      </tr>
      <tr>
        <td width="10%">&nbsp;</td>
        <td width="31%">WebSite Name:</td>
        <td width="59%">
          <input maxlength=65 name=domainname value="test101">
          .<%=bean.getSubDomain()%></td>
      </tr>
      <tr>
        <td width="10%">&nbsp;</td>
        <td width="31%">password:</td>
        <td width="59%">
          <input type=password maxlength=40 name=password value="123456">
        </td>
      </tr>
      <tr>
        <td width="10%">&nbsp;</td>
        <td width="31%">Confirm Password:</td>
        <td width="59%">
          <input type=password maxlength=40 name=cpassword value="123456">
        </td>
      </tr>
      <tr>
        <td height="19" width="10%">&nbsp;</td>
        <td height="19" width="31%">Zip Code:</td>
        <td height="19" width="59%">
          <input maxlength=5 size=5 name=zipcode value="92805">
        </td>
      </tr>
      <tr>
        <td height="19" colspan="3">
          <table width="100%" border="0" cellspacing="1" cellpadding="1">
            <tr>
              <td width="1%">&nbsp;</td>
              <td width="22%">&nbsp;</td>
              <td width="31%">&nbsp;</td>
              <td width="40%">&nbsp;</td>
              <td width="6%">&nbsp;</td>
            </tr>
            <tr>
              <td width="1%">&nbsp;</td>
              <td width="22%">&nbsp;</td>
              <td width="31%">
                <input type="submit" name="action" value="Register" onClick="return validateRegister(document.register);">
              </td>
              <td width="40%">
                <input type="reset" value="Reset" name="reset">
              </td>
              <td width="6%">&nbsp;</td>
            </tr>
          </table>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</form>
<SCRIPT>onRegisterLoad(document.register);</SCRIPT>
<% } else { %>
<%
//  CompanyInfo cyInfo = (CompanyInfo)session.getAttribute(Definition.KEY_COMPANYINFO);
  String sDomainName = bean.getDomainName();
  String sEmailUrl   = bean.getEmailUrl();
  String sPassword   = request.getParameter("password");
%>
  <div align="center">
    <table width="75%" border="0" height="111">
      <tr>
        <td width="3%" height="21">&nbsp;</td>
        <td width="95%" height="21">
          <h2 align="center">Congratulations!</h2>
          </td>
        <td width="2%" height="21">&nbsp;</td>
      </tr>
      <tr>
        <td width="3%">&nbsp;</td>
      <td width="95%">
<div align="left">
  <p>Congratulations!!! Your test website have been successfully setup and an
    admin account of this website is alos created.<br>
    You can visit your web site any time at:<a href="http://<%=sDomainName%>"><br>
    http://<%=sDomainName%></a>. </p>
  <p>You can login your admin account to set up and manage your web site now.<br>
    Your administration address(URL) is: <a href="http://<%=sDomainName%>/admin">
    http://<%=sDomainName%>/admin</a><br>
    Your user name is: <b>admin</b><br>
    Your password is: <b><%=sPassword%></b> </p>
  <div align="left">
    <p>Your email account is also created and you can send and receive email now.
    </p>
    <p>Your email box address(URL) is: <a href="<%=sEmailUrl%>"><%=sEmailUrl%></a><br>
      Your UserID is: <b>admin@<%=sDomainName%></b><br>
      Your Password is: <b><%=sPassword%></b> (the same as admin account of your test website)</p>
  </div>
  </div>
<p align="left">The six forwarding email addresses are also generated. They will
  automatically forward to <b>admin@<%=sDomainName%></b> now. You can change
  these forwardings and reassign each of them to other employees of your company
  later. The six forwarding emails are:</p>
<p align="left"><b>1. customerservice@<%=sDomainName%></b><br>
  <b>2. info@<%=sDomainName%></b><br>
  <b>3. sales@<%=sDomainName%></b><br>
  <b>4. support@<%=sDomainName%></b><br>
  <b>5. newsletter@<%=sDomainName%></b><br>
  <b>6. staff@<%=sDomainName%></b><br>
</p>
<p align="left">Thank you for using Web Office service from Zyzit.com!</p>
          </td>
        <td width="2%">&nbsp;</td>
      </tr>
    </table>
  </div>
    <p>&nbsp;</p>
<% } %>
<%@ include file="../share/footer.jsp"%>
