<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/communityuser.js"></SCRIPT>
<script language="JavaScript" src="/staticfile/admin/scripts/choosedate.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityUserBean"%>
<%@ page import="com.omniserve.dbengine.database.CommunityUser"%>
<%@ page import="com.omniserve.dbengine.model.CommunityUserInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  CommunityUserBean bean = new CommunityUserBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  CommunityUserInfo info = null;
  if ("Add Member".equalsIgnoreCase(sAction))
  {
    CommunityUserBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (CommunityUserInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "user");
      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Member".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    CommunityUserBean.Result ret = bean.update(request, false);
    info = (CommunityUserInfo)ret.getUpdateInfo();
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
    info =  bean.get(request);
    sAction = "Update Member";
  }
  else if ("View".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "View";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Member";
  }

  if (info==null)
  {
    info = CommunityUserInfo.getInstance(true);
    sAction = "Add Member";
  }

  String sHelpTag = "communtiyuser";
  String sTitleLinks;// = "<a href=\"userlist.jsp?action=User List\">Community Member List</a> > ";
  String sDescription;
  if ("Add Member".equalsIgnoreCase(sAction))
  {
//     sTitleLinks += "<b>Add a New Member</b>";
     sTitleLinks = bean.getNavigation(request, "Add a New Member");
     sDescription = "The form below will allow you to add a new member.";
  }
  else
  {
//     sTitleLinks += "<b>Edit the Member</b>";
     sTitleLinks = bean.getNavigation(request, "Edit the Member");
     sDescription = "The form below will allow you to edit & update or view the member information.";
  }

%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="user" action="user.jsp" method="post" onsubmit="return validateUser(this);">
<input type="hidden" name="userid" value="<%=info.UserID%>">
<% if ("Update Member".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("user.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">User Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr class="normal_row">
    <td width="20%" align="right">E-Mail:</td>
    <td><input maxlength=50 size=40 name="email" value="<%=Utilities.getValue(info.EMail)%>" disabled> (MD5: <b><%=info.UserCode%></b>)</td>
  </tr>

  <tr class="normal_row">
    <td width="20%" align="right">Password:</td>
    <td><input maxlength=20 size=20 name="password" type="password" value="<%=Utilities.getValue(info.Password)%>">
    Confirm Password: <input maxlength=20 size=20 name="cpassword" type="password" value="<%=Utilities.getValue(info.Password)%>">
    </td>
  </tr>
  <tr>
    <td class="row1" width="20%" align="right">Status:</td>
    <td class="row1">
      <select name="active">
        <option value=1 <%=bean.getSelected(1, info.Active)%>>Active</option>
        <option value=0 <%=bean.getSelected(0, info.Active)%>>Not Validate</option>
        <option value=2 <%=bean.getSelected(2, info.Active)%>>Cancel</option>
        <option value=3 <%=bean.getSelected(3, info.Active)%>>Terminate</option>
      </select>
    </td>
  </tr>
  <tr>
    <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Nick Name:</td>
    <td><input maxlength=30 size=20 name="nickname" value="<%=Utilities.getValue(info.NickName)%>">
        Gender: <select name="subscribe">
                <option value=0 <%=bean.getSelected(0, info.Gender)%>>Male</option>
                <option value=1 <%=bean.getSelected(1, info.Gender)%>>Female</option>
                </select>
        BirthDay: <input maxlength=10 size=10 name="birthday" value="<%=Utilities.getValue(info.BirthDay)%>">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">First Name:</td>
    <td><input maxlength=30 size=20 name="firstname" value="<%=Utilities.getValue(info.FirstName)%>">
        Last Name: <input maxlength=30 size=20 name="lastname" value="<%=Utilities.getValue(info.LastName)%>">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Security Question:</td>
    <td>
      <SELECT name="securityquestion">
        <OPTION value="0">[Select a Question]
        <OPTION value="1" <%=bean.getSelected(1, info.SecurityQuestion)%>>What is your father's middle name?
        <OPTION value="2" <%=bean.getSelected(2, info.SecurityQuestion)%>>What was the name of your first school?
        <OPTION value="3" <%=bean.getSelected(3, info.SecurityQuestion)%>>Who was your childhood hero?
        <OPTION value="4" <%=bean.getSelected(4, info.SecurityQuestion)%>>What is your favorite pastime?
        <OPTION value="5" <%=bean.getSelected(5, info.SecurityQuestion)%>>What is your all-time favorite sports team?
        <OPTION value="6" <%=bean.getSelected(6, info.SecurityQuestion)%>>What was your high school mascot?
        <OPTION value="7" <%=bean.getSelected(7, info.SecurityQuestion)%>>What make was your first car or bike?
        <OPTION value="8" <%=bean.getSelected(8, info.SecurityQuestion)%>>Where did you first meet your spouse?
        <OPTION value="9" <%=bean.getSelected(9, info.SecurityQuestion)%>>What is your pets name?">What is your pet's name?
    </SELECT>
    Answer: <input maxlength=30 size=20 name="answer" value="<%=Utilities.getValue(info.Answer)%>">
    </td>
  </tr>
  <tr>
    <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Address:</td>
    <td><input maxlength=60 size=40 name="address" value="<%=Utilities.getValue(info.Address)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">City:</td>
    <td><input maxlength=25 size=25 name="city" value="<%=Utilities.getValue(info.City)%>">
     State/Province: <input maxlength=20 size=25 name="state" value="<%=Utilities.getValue(info.State)%>">
     Zip: <input maxlength=10 size=10 name="zip" value="<%=Utilities.getValue(info.Zip)%>">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Country:</td>
    <td><input maxlength=20 size=40 name="country" value="<%=Utilities.getValue(info.Country)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Phone Number:</td>
    <td><input maxlength=20 size=20 name="workphone" value="<%=Utilities.getValue(info.WorkPhone)%>">
    Fax: <input maxlength=20 size=20 name="fax" value="<%=Utilities.getValue(info.Fax)%>">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Google Client:</td>
    <td><input maxlength=255 size=60 name="googleclient" value="<%=Utilities.getValue(info.GoogleClient)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Google Channel:</td>
    <td><input maxlength=255 size=60 name="googlechannel" value="<%=Utilities.getValue(info.GoogleChannel)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Member Type:</td>
    <td>
      <select name="usertype">
        <option value=0 <%=bean.getSelected(0, info.UserType)%>>Common Member</option>
        <option value=1 <%=bean.getSelected(1, info.UserType)%>>Premium Member</option>
      </select>
    </td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">FaceBook Uid:</td>
    <td><input maxlength=255 size=60 name="fbuid" value="<%=Utilities.getValue(info.FBUid)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Expired Date:</td>
    <td><input maxlength=10 name="expireddate" value="<%=Utilities.convertDateValue(info.ExpiredDate, false)%>"
        onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'>
       <input type="button" value="Choose one..." onClick="getCalendarFor(document.user.expireddate)">
        (MM/DD/YYYY) For Preminm member, the expired date should be set.
    </td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">More Information:</td>
    <td>
     <%=bean.getExtraInfo(info.UserID)%>
    </td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>" <%="View".equalsIgnoreCase(sAction)==true?"disabled":""%>></td>
  </tr>
  </table>
</form>
<SCRIPT>onUserLoad(document.user);</SCRIPT>
<%@ include file="../share/choosedate.jsp"%>
<%@ include file="../share/footer.jsp"%>