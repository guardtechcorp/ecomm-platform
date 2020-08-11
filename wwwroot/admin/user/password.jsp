<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/user.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.database.User"%>
<%@ page import="com.zyzit.weboffice.bean.UserBean"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  UserBean bean = new UserBean(session, 20);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_USER))
//     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  UserInfo urInfo = null;
  String sClass = "successful";
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
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "user");
    }
  }
  else
  {
    urInfo =  bean.getMyInfo(request);
  }
  sAction = "Update Now";
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25" valign="top"><font size="2"><b>Change My Password</b></font></td>
  </tr>
  <tr>
    <td height="25" valign="top">From this form you can change the password.</td>
  </tr>
</table>
<form name="user" action="password.jsp"  method="post" onsubmit="return validateUser(document.user);">
  <input type="hidden" name="userid" value="<%=urInfo.UserID%>">
  <input type="hidden" name="passwordupdate" value="1">
  <table border="0" cellpadding="2" cellspacing="1" width="94%" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="4" height="25" valign="middle">
        <div align="center">User Information</div>
      </th>
    </tr>
<% if (sDisplayMessage!=null) {%>
    <tr>
      <td class="row1" colspan="4" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="25%" align="right">Username: </td>
      <td class="row1" width="20%"><input type="text" name="username" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.Username)%>" disabled></td>
      <td class="row1" width="25%" align="right">Real Name: </td>
      <td class="row1" width="30%"><input type="text" name="realname" size="20" maxlength="40" value="<%=Utilities.getValue(urInfo.RealName)%>"></td>
    </tr>
    <tr>
      <td class="row1" width="25%" align="right" height="2">Password: </td>
      <td class="row1" width="20%"><input type="password" name="password" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.Password)%>"></td>
      <td class="row1" width="25%" align="right">Confirm password: </td>
      <td class="row1" width="30%"> <input type="password" name="cpassword" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.Password)%>"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="4" align="center" height="28">
        <input type="submit" name="action" value="<%=sAction%>">
      </td>
    </tr>
  </table>
</form>
<SCRIPT>onUserLoad(document.user, "<%=sAction%>");</SCRIPT>
<%@ include file="../share/footer.jsp"%>
