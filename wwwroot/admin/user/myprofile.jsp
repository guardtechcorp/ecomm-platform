<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/user.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/emailbox.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.database.User"%>
<%@ page import="com.zyzit.weboffice.bean.UserBean"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%@ page import="com.zyzit.weboffice.bean.EmailBoxBean"%>
<%@ page import="com.zyzit.weboffice.model.EmailBoxInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  UserBean bean = new UserBean(session, 20);

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  UserInfo urInfo = null;
  String sClass = "successful";

  EmailBoxBean beanBox = new EmailBoxBean(session, 20);
  String sDisplayMessageBox = null;
  String sClassBox = "successful";
  EmailBoxInfo infoBox = null;

  if ("Update Now".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    UserBean.Result ret = bean.update(request, false);
    urInfo = (UserInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "profile information");
    }
  }
  else if ("Update E-Mail".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    EmailBoxBean.Result ret = beanBox.update(request, false);
    infoBox = (EmailBoxInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessageBox = errObj.getError();
      sClassBox = "failed";
    }
    else
    {
      sDisplayMessageBox = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "E-Mail");
    }
  }

  if (urInfo==null)
    urInfo =  bean.getMyInfo(request);

  //Try to get E-Mail Box Info
  if (infoBox==null)
     infoBox =  beanBox.getMyBox(request);

  sAction = "Update Now";
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25" valign="top"><font size="2"><b>Edit the profile Information</b></font></td>
  <tr>
    <td height="20" valign="top">. From this page, you can edit and update your profile information except the Usernname field. And you can edit your E-Mail box settings</td>
  </tr>
</table>
<form name="user" action="myprofile.jsp"  method="post" onsubmit="return validateUser(document.user);">
  <input type="hidden" name="userid" value="<%=urInfo.UserID%>">
  <input type="hidden" name="passwordupdate" value="1">
  <table cellspacing="1" cellpadding="1" border="0" align="center" class="forumline" width="95%">
    <tr>
      <th class="thHead" colspan="2" align="center">Profile Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr class="normal_row">
      <td width="24%" align="right">Username:</td>
      <td><input type="text" name="username" size="40" maxlength="20" value="<%=Utilities.getValue(urInfo.Username)%>" disabled></td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Real Name:</td>
      <td><input type="text" name="realname" size="40" maxlength="40" value="<%=Utilities.getValue(urInfo.RealName)%>"></td>
    </tr>

    <tr class="normal_row">
      <td width="24%" align="right">As a Role:</td>
      <td><input type="text" name="rolename" size="40" maxlength="20" value="<%=Utilities.getValue(urInfo.RoleName)%>"></td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">E-Mail:</td>
      <td><input type="text" name="email" size="40" maxlength="50" value="<%=Utilities.getValue(urInfo.EMail)%>"></td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Work Phone:</td>
      <td><input type="text" name="workphone" size="40" maxlength="20" value="<%=Utilities.getValue(urInfo.WorkPhone)%>"></td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Home Phone:</td>
      <td><input type="text" name="homephone" size="40" maxlength="20" value="<%=Utilities.getValue(urInfo.HomePhone)%>"></td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Cell Phone:</td>
      <td><input type="text" name="cellphone" size="40" maxlength="20" value="<%=Utilities.getValue(urInfo.CellPhone)%>"></td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Password:</td>
      <td><input type="password" name="password" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.Password)%>"></td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Confirm password:</td>
      <td><input type="password" name="cpassword" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.Password)%>"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="2" align="center"><input type="submit" value="Update Now" name="action"></td>
    </tr>
  </table>
</form>
<SCRIPT>onUserLoad(document.user, "<%=sAction%>");</SCRIPT>
<% if (infoBox!=null) { %>
<form name="thisform" action="myprofile.jsp" method="post" onsubmit="return validateEmailBoxForm(this, '<%=beanBox.getEmailDomain()%>');">
<input type="hidden" name="emailid" value="<%=infoBox.EmailID%>">
<table width="95%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">E-Mail Information</th>
    </tr>
<% if (sDisplayMessageBox!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClassBox%>"><%=sDisplayMessageBox%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="15%" align="right">E-Mail Address:</td>
      <td class="row1">
        <input type="text" name="name" value="<%=Utilities.getValue(infoBox.Name)%>" size=20 maxlength="40" disabled><b>@<%=beanBox.getEmailDomain()%></b>
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">Password:</td>
      <td class="row1">
        <input type="password" name="password" size=20 maxlength="20" value="<%=Utilities.getValue(infoBox.Password)%>" <%=(infoBox.Type==1?"":"disabled")%>>
        Confirm Password: <input type="password" name="cpassword" size="20" maxlength="20" value="<%=Utilities.getValue(infoBox.Password)%>" <%=(infoBox.Type==1?"":"disabled")%>>
      </td>
    </tr>
    <!--tr>
      <td class="row1" width="15%" align="right">Description:</td>
      <td class="row1" valign="top">
       <textarea rows="3" cols="50" wrap="virtual" name="description"><%=Utilities.getValue(infoBox.Description)%></textarea> The description for this E-Mail box.
      </td>
    </tr-->
    <tr>
      <td class="row1" width="15%" align="right">E-Mail Type:</td>
      <td class="row1">
        <select name="type" onChange="onEmailTypeChange(document.thisform, this)">
          <option value=0 <%=bean.getSelected(0, infoBox.Type)%>>Forward E-Mail Box</option>
          <option value=1 <%=bean.getSelected(1, infoBox.Type)%>>Normal E-Mail Box</option>
        </select> Forward E-Mail box can only distribute incoming emails to the mail list below.
       </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">E-Mail List:</td>
      <td class="row1" valign="top">
       <textarea rows="3" cols="50" wrap="virtual" name="forward"><%=beanBox.getForwardList(infoBox)%></textarea> The email addresses separated by comma.
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">Active:</td>
      <td class="row1">
        <select name="active">
          <option value=1 <%=beanBox.getSelected(1, infoBox.Active)%>>Yes</option>
          <option value=0 <%=beanBox.getSelected(0, infoBox.Active)%>>No</option>
        </select> If selects 'No', the E-Mail box will stop to send and receive any E-Emails.
      </td>
    </tr>
    <TR class="normal_row">
      <TD colSpan=2 height=5></TD>
    </TR>
    <tr>
      <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="Update E-Mail"></td>
    </tr>
  </table>
</form>
<!--SCRIPT>onEmailBoxFormLoad(document.thisform);</SCRIPT-->
<% } %>
<%@ include file="../share/footer.jsp"%>