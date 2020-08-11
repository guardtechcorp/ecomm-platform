<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%
  MemberBean bean = new MemberBean(session, 0);
//bean.showAllParameters(request, out);


  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  MemberInfo info = null;
//System.out.println("action=" + sAction);
  if ("Sign Up".equalsIgnoreCase(sAction))
  {//Sign Up
    String sDomainName = request.getParameter("domainname");
    MemberBean.Result ret = bean.Signup(request, sDomainName);
    if (!ret.isSuccess())
    {
      info = (MemberInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = "You have successfully sign up. Thank you.";
      //. Change to update of adding its sub-category
      String sReturnURL = request.getParameter("return_url");
      if (sReturnURL!=null)
      {
         response.sendRedirect(sReturnURL);
         return;
      }
    }
  }

  if (info==null)
  {
    info = MemberInfo.getInstance(true);
    sAction = "Sign Up";
  }
%>
<HTML>
<HEAD>
<Title>Sign up Form</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<!--LINK href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet"-->
<!--SCRIPT Language="JavaScript" src="scripts/index.js"></SCRIPT-->
<SCRIPT Language="JavaScript" type="text/javascript">
function onSignupLoad(form)
{
  form.name.focus();
}

function validateSignup(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter your name.");
    form.name.focus();
    return false;
  }

  return true;
}
</SCRIPT>
</HEAD>
<body onLoad="onSignupLoad(document.signup);">
<form name="signup" action="form-signup.jsp" method="post" onsubmit="return validateSignup(this);">
<input type="hidden" name="domainname" value="<%=Utilities.getValue(bean.getDomainNameFromUrl(request))%>">
<input type="hidden" name="memberid" value="<%=info.MemberID%>">
<table width="85%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Sign Up Form</th>
    </tr>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="5" align="center"></td>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr class="normal_row">
    <td class="row1" colspan="2" height="5" align="center"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">Your Name:</td>
    <td><input maxlength=20 size=42 name="name" value="<%=Utilities.getValue(info.getFullName())%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">Company:</td>
    <td><input maxlength=40 size=42 name="company" value="<%=Utilities.getValue(info.Company)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">Address1:</td>
    <td><input maxlength=60 size=42 name="address1" value="<%=Utilities.getValue(info.Address1)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">Address2:</td>
    <td><input maxlength=40 size=42 name="address2" value="<%=Utilities.getValue(info.Address2)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">City:</td>
    <td><input maxlength=25 size=42 name="city" value="<%=Utilities.getValue(info.City)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">State/Province:</td>
    <td><input maxlength=20 size=24 name="state" value="<%=Utilities.getValue(info.State)%>">
     Zip: <input maxlength=10 size=9 name="zip" value="<%=Utilities.getValue(info.Zip)%>">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">Country:</td>
    <td><input maxlength=20 size=42 name="country" value="<%=Utilities.getValue(info.Country)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">Phone Number:</td>
    <td><input maxlength=20 size=24 name="workphone" value="<%=Utilities.getValue(info.WorkPhone)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">Fax Number:</td>
    <td><input maxlength=20 size=24 name="fax" value="<%=Utilities.getValue(info.Fax)%>"> (Optional)</td>
  </tr>
  <tr>
    <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">E-Mail:</td>
    <td><input maxlength=50 size=42 name="email" value="<%=Utilities.getValue(info.EMail)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">Password:</td>
    <td><input maxlength=20 size=24 name="password" type="password" value="<%=Utilities.getValue(info.Password)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="35%" align="right">Confirm Password:</td>
    <td><input maxlength=20 size=24 name="cpassword" type="password" value="<%=Utilities.getValue(info.Password)%>">
    </td>
  </tr>
  <tr>
    <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
</table>
</form>
</body>
</html>