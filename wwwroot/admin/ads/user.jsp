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
    urInfo.AccessFlags = AccessRole.ROLE_SHIPMENT;//|AccessRole.ROLE_EMAILBOX;
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
//Utilities.dumpObject(urInfo);
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
    <th class="thHead" colspan="2" height="25" align="center" valign="middle">User Information</th>
  </tr>
<% if (sDisplayMessage!=null) {%>
    <tr>
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr>
    <td colspan="2" align="center">
    <table width="100%" border="0" align="center">
        <tr class="normal_row">
            <td class="row1" width="24%" align="right">Username: </td>
            <td class="row1"><input type="text" name="username" size="50" maxlength="60" value="<%=Utilities.getValue(urInfo.Username)%>"></td>
        </tr>
        <tr>
          <td class="row1" align="right">Password: </td>
          <td class="row1"><input type="password" name="password" size="50" maxlength="20" value="<%=Utilities.getValue(urInfo.Password)%>"></td>
        </tr>
        <tr>
          <td class="row1" align="right">Confirm password: </td>
          <td class="row1" ><input type="password" name="cpassword" size="50" maxlength="20" value="<%=Utilities.getValue(urInfo.Password)%>"></td>
        </tr>
        <tr>
        <td class="row1" align="right">Real Name: </td>
        <td class="row1" ><input type="text" name="realname" size="50" maxlength="40" value="<%=Utilities.getValue(urInfo.RealName)%>"></td>
        </tr>
        <tr>
        <td class="row1" align="right">Organization: </td>
        <td class="row1" ><input type="text" name="organization" size="50" maxlength="40" value="<%=Utilities.getValue(urInfo.Organization)%>"></td>
        </tr>
        <tr>
          <td class="row1" align="right">E-Mail: </td>
          <td class="row1"><input type="text" name="email" size="50" maxlength="50" value="<%=Utilities.getValue(urInfo.EMail)%>"></td>
        </tr>
        <tr>
          <td class="row1" align="right">Work Phone: </td>
          <td class="row1"><input type="text" name="workphone" size="50" maxlength="20" value="<%=Utilities.getValue(urInfo.WorkPhone)%>"></td>
        </tr>
        <tr>
          <td class="row1" align="right">Home Phone: </td>
          <td class="row1" ><input type="text" name="homephone" size="50" maxlength="20" value="<%=Utilities.getValue(urInfo.HomePhone)%>"></td>
        </tr>
        <tr>
          <td class="row1" align="right">Cell Phone: </td>
          <td class="row1"><input type="text" name="cellphone" size="50" maxlength="20" value="<%=Utilities.getValue(urInfo.CellPhone)%>"></td>
        </tr>
    </table>
  </tr>
  <tr>
    <td class="spaceRow" colspan="2" height="10"><hr class="dotted"></td>
  </tr>
  <tr>
    <td colspan="2" align="center">
    <table width="100%" border="0" align="center">
        <tr class="normal_row">
          <td width="24%" align="right">Credit Card Billing Address:</td>
          <td>
            <input maxlength=60 name="address_bill" value="<%=Utilities.getValue(urInfo.Address_Bill)%>" size="50">
          </td>
        </tr>
        <tr class="normal_row">
          <td width="24%" align="right">City:</td>
          <td>
            <input maxlength=60 name="city_bill" value="<%=Utilities.getValue(urInfo.City_Bill)%>" size="50">
          </td>
        </tr>
        <tr class="normal_row">
          <td width="24%" align="right">State/Province:</td>
          <td>
            <input maxlength=30 name="state_bill" value="<%=Utilities.getValue(urInfo.State_Bill)%>" size="50">
          </td>
        </tr>
        <tr class="normal_row">
          <td width="24%" align="right">Zip/Postal Code:</td>
          <td>
            <input maxlength=12 name="zipcode_bill" value="<%=Utilities.getValue(urInfo.ZipCode_Bill)%>" size="50">
          </td>
        </tr>
        <tr class="normal_row">
          <td width="24%" align="right">Country:</td>
          <td>
            <input maxlength=20 name="country_bill" value="<%=Utilities.getValue(urInfo.Country_Bill)%>" size="50">
          </td>
        </tr>
        <tr class="normal_row">
          <td width="24%" align="right">The Name on Credit Card:</td>
          <td><input name="nameoncard" value="<%=Utilities.getValue(urInfo.NameOnCard)%>" size="50" maxlength="40"></td>
        </tr>
        <tr class="normal_row">
          <td width="24%" align="right">Credit Card Number:</td>
          <td><input name="creditno" value="<%=Utilities.getValue(urInfo.CreditNo)%>" size="50" maxlength="30"></td>
        </tr>
        <tr class="normal_row">
          <td width="24%" align="right">Credit Card Type:</td>
          <td>
            <select name="credittype">
              <option value="Visa" selected>Visa</option>
              <option value="Mastercard">Mastercard</option>
              <option value="American Express">American Express</option>
              <option value="Discover">Discover</option>
            </select>
          </td>
        </tr>
        <tr class="normal_row">
          <td width="24%" align="right">Expiration Date:</td>
          <td>Month: <input maxlength=2 size=4 name="expiredmonth" value="<%=Utilities.getValue(urInfo.ExpiredMonth)%>">
            Year: <input maxlength=4 size=4 name="expiredyear" value="<%=Utilities.getValue(urInfo.ExpiredYear)%>">
          </td>
        </tr>
        <tr class="normal_row">
          <td width="24%" align="right">Card Verification Number:</td>
          <td><input maxlength=8 size=10 name="csid" value="<%=Utilities.getValue(urInfo.Csid)%>"><font size=1>  (For Visa, MasterCard & American Express only.
          <a href="javascript:ChildWin=window.open('/staticfile/web/cards-help.html','cards_help','resizable=yes,scrollbars=no,width=460,height=630');ChildWin.focus()">Help</a>)</font>
          </td>
        </tr>
    </table>
    </td>
  </tr>
<% if (bean.hasGrantRight()) {%>
  <tr>
    <td class="spaceRow" colspan="2" height="10"><hr class="dotted"></td>
  </tr>
    <tr>
      <td class="row1" colspan="2" align="center"><b>User Access Roles</b></td>
    </tr>
    <tr>
      <td colspan="2" height="25" align="center">
        <table cellpadding="2" cellspacing="1" border=0 width="90%" class2="forumline" align="center" style="border: 1px solid #cccccc">
          <tr bgcolor2="#9AAEDA">
            <td width="26%" height="25"><font color2="#ffffff">&nbsp;<b>Role Name</b></font></td>
            <td align="center" width="9%" height="20"><font color2="#ffffff"><b>Privilege</b></font></td>
            <td align="center" width="60%" height="20"><font color2="#ffffff"><b>Description</b></font></td>
          </tr>
<%
  List ltRole = bean.getAllPermitedRoles(true);
  for (int i=0; i<ltRole.size(); i++) {
      AccessRole.Role rl = (AccessRole.Role)ltRole.get(i);
      if (rl.nFlag!=AccessRole.ROLE_GRANT &&
          (rl.nFlag<AccessRole.ROLE_ADS_UPDATE || rl.nFlag>AccessRole.ROLE_ADS_STATISTICS))
      {
         continue;
      }      
%>
          <tr>
            <td class="row1" width="25%">&nbsp;<%=rl.sName%></td>
            <td class="row1" align="center" width="9%"><input type="checkbox" value=1 name="cb_<%=rl.sName.toLowerCase()%>" <%=bean.getCheckFlag(rl.nFlag, urInfo.AccessFlags, urInfo.UserID)%> <%=urInfo.UserID==1?"disabled":""%>></td>
            <td class="row1" width="60%"><%=Utilities.getValue(AccessRole.getRoleDescripiton(rl.sName))%></td>
          </tr>
<% } %>
        </table>
      </td>
    </tr>
    <tr>
      <td class="row1" colspan="2" align="center" height="4"></td>
    </tr>
<% } %>
    <tr>
      <td class="catBottom" colspan="4" align="center" height="28"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
</table>
</form>
<SCRIPT>onUserLoad(document.user, "<%=sAction%>");</SCRIPT>
<%@ include file="../share/footer.jsp"%>
