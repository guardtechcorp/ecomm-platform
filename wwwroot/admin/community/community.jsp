<%@ include file="../share/uparea.jsp"%>
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
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_USER))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  UserInfo urInfo = null;
  String sClass = "successful";
  if ("Add User".equalsIgnoreCase(sAction))
  {
    UserBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      urInfo = (UserInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "user");
//      ctInfo = (CustomerInfo)ret.getUpdateInfo();
    }
  }
  else if ("Update User".equalsIgnoreCase(sAction))
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
  else if ("Edit".equalsIgnoreCase(sAction))
  {
      urInfo =  bean.get(request);
      sAction = "Update User";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     urInfo =  bean.getPrevOrNext(sAction);
//System.out.println("cgInfo = "+ cgInfo);
     sAction = "Update User";
  }

  if (urInfo==null)
  {
    urInfo = UserInfo.getInstance(true);
    urInfo.AccessFlags = AccessRole.ROLE_SHIPMENT|AccessRole.ROLE_EMAILBOX;
    urInfo.Relations = bean.getRelationFlag("staff");
    sAction = "Add User";
  }

  String sHelpTag = "user";
  String sTitleLinks = "";
  String sDescription;
  if ("Add User".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<a href=\"userlist.jsp?action=list\">User List</a> > <b>Add a New User</b>";
     sDescription = "The form below will allow you to create a new user.";
  }
  else
  {
     sTitleLinks += "<a href=\"userlist.jsp?action=list\">User List</a> > <b>Edit the User</b>";
     sDescription = "The form below will allow you to edit and update the user information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="user" action="user.jsp"  method="post" onsubmit="return validateUser(document.user);">
<input type="hidden" name="userid" value="<%=urInfo.UserID%>">
<%=bean.getHideCheckedRoles(urInfo.AccessFlags)%>
<% if (!"Add User".equalsIgnoreCase(sAction)) {%>
<table width="95%" cellpadding="1" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("user.jsp?")%></td>
  </tr>
</table>
<% } %>
<table border="0" cellpadding="2" cellspacing="1" width="95%" class="forumline" align="center">
  <tr>
    <th class="thHead" colspan="4" height="25" align="center" valign="middle">User Information</th>
  </tr>
<% if (sDisplayMessage!=null) {%>
    <tr>
      <td class="row1" colspan="4" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="15%" align="right">Username: </td>
      <td class="row1" width="30%"><input type="text" name="username" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.Username)%>"></td>
      <td class="row1" width="25%" align="right">Real Name: </td>
      <td class="row1" width="30%"><input type="text" name="realname" size="20" maxlength="40" value="<%=Utilities.getValue(urInfo.RealName)%>"></td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">E-Mail: </td>
      <td class="row1" width="30%"><input type="text" name="email" size="36" maxlength="50" value="<%=Utilities.getValue(urInfo.EMail)%>"></td>
      <td class="row1" colspan="2"><%=bean.getEmail(urInfo, sAction.equals("Add User"))%>
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">As a Role: </td>
      <td class="row1" width="30%"><input type="text" name="rolename" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.RoleName)%>"></td>
      <td class="row1" width="25%" align="right">Work Phone: </td>
      <td class="row1" width="30%"><input type="text" name="workphone" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.WorkPhone)%>"></td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">Home Phone: </td>
      <td class="row1" width="30%"><input type="text" name="homephone" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.HomePhone)%>"></td>
      <td class="row1" width="25%" align="right">Cell Phone: </td>
      <td class="row1" width="30%"><input type="text" name="cellphone" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.CellPhone)%>"></td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right" height="2">Password: </td>
      <td class="row1" width="30%"><input type="password" name="password" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.Password)%>"></td>
      <td class="row1" width="25%" align="right">Confirm password: </td>
      <td class="row1" width="30%"> <input type="password" name="cpassword" size="20" maxlength="20" value="<%=Utilities.getValue(urInfo.Password)%>"></td>
    </tr>
<% if (bean.hasGrantRight()) {%>
    <tr>
      <td class="row1" colspan="4" align="center"><b>User Access Roles</b></td>
    </tr>
    <tr>
      <td colspan="4" height="25" align="center">
        <table cellpadding="3" cellspacing="1" border=0 width="100%" lass="forumline" align="center">
          <tr bgcolor="#9AAEDA">
            <td width="26%" height="25"><font color="#ffffff">&nbsp;<b>Role Name</b></font></td>
            <td align="center" width="9%" height="20"><font color="#ffffff"><b>Privilege</b></font></td>
            <td align="center" width="60%" height="20"><font color="#ffffff"><b>Description</b></font></td>
          </tr>
<%
  List ltRole = bean.getAllPermitedRoles(true);
  for (int i=0; i<ltRole.size(); i++) {
      AccessRole.Role rl = (AccessRole.Role)ltRole.get(i);
%>
          <tr>
            <td class="row1" width="25%">&nbsp;<%=rl.sName%></td>
            <td class="row1" align="center" width="9%"><input type="checkbox" value=1 name="cb_<%=rl.sName.toLowerCase()%>" <%=bean.getCheckFlag(rl.nFlag, urInfo.AccessFlags, urInfo.UserID)%>></td>
            <td class="row1" width="60%"><%=Utilities.getValue(AccessRole.getRoleDescripiton(rl.sName))%></td>
          </tr>
<% } %>
        </table>
      </td>
    </tr>
<% if (bean.hasEmailDomain()) { %>
    <tr>
      <td class="row1" colspan="4" height="5" align="center"><b>Company E-Mails forward to <%=Utilities.getValue(urInfo.Username)%>@<%=bean.getEmailDomain()%></b></td>
    </tr>
    <tr>
      <td colspan="4" height="47" align="center">
        <table cellpadding="3" cellspacing="1" border=0 width="100%" lass="forumline" align="center">
          <tr bgcolor="#9AAEDA">
            <td width="26%" height="25"><font color="#ffffff">&nbsp;<b>Company E-Mail</b></font></td>
            <td align="center" width="9%" height="20"><font color="#ffffff"><b>Forward</b></font></td>
            <td align="center" width="60%" height="20"><font color="#ffffff"><b>Description</b></font></td>
          </tr>
<%
  List ltVirtualUsers = bean.getVirtualUsers();
  String sSuffixDomain = '@'+bean.getEmailDomain();
  for (int i=0; i<ltVirtualUsers.size(); i++) {
      UserInfo vurInfo = (UserInfo)ltVirtualUsers.get(i);
%>
          <tr>
            <td class="row1" width="25%">&nbsp;<%=vurInfo.Username%><%=sSuffixDomain%></td>
            <td class="row1" width="9%" align="center">
              <input type="checkbox" value="<%=vurInfo.UserID%>" name="relation_<%=vurInfo.UserID%>" <%=bean.getRelationCheckFlag(urInfo.Relations, vurInfo.UserID)%>>
            </td>
            <td class="row1" width="60%">If check it, this email will automatically forward to the email box of this user.</a></td>
          </tr>
<% } %>
        </table>
      </td>
    </tr>
<% } %>
<% } %>
    <tr>
      <td class="catBottom" colspan="4" align="center" height="28"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
</table>
</form>
<SCRIPT>onUserLoad(document.user, "<%=sAction%>");</SCRIPT>
<%@ include file="../share/footer.jsp"%>
