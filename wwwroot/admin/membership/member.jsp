<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/membership.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%
  MemberBean bean = new MemberBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERS))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  MemberInfo info = null;
  if ("Add Member".equalsIgnoreCase(sAction))
  {
    MemberBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (MemberInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "member");
      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Member".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    MemberBean.Result ret = bean.update(request, false);
    info = (MemberInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "member");
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
    info = MemberInfo.getInstance(true);
    sAction = "Add Member";
  }

  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  String sHelpTag = "member";
  String sTitleLinks = "";
  if (sReturn!=null)
    sTitleLinks = "<a href=\"" + Utilities.replaceContent(sReturn, "|", "?action=", false) +"\">" + sDisplay + "</a> > ";
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
<form name="member" action="member.jsp" method="post" onsubmit="return validateMember(this);">
<input type="hidden" name="memberid" value="<%=info.MemberID%>">
<input type="hidden" name="return" value="<%=Utilities.getValue(sReturn)%>">
<input type="hidden" name="display" value="<%=Utilities.getValue(sDisplay)%>">
<% if (!"Add Member".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("member.jsp?return="+sReturn+"&display="+sDisplay+"&")%></td>
  </tr>
</table>
<% } %>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Member Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr class="normal_row">
    <td width="20%" align="right">E-Mail:</td>
    <td><input maxlength=50 size=40 name="email" value="<%=Utilities.getValue(info.EMail)%>"></td>
  </tr>

  <tr class="normal_row">
    <td width="20%" align="right">Password:</td>
    <td><input maxlength=20 size=20 name="password" type="password" value="<%=Utilities.getValue(info.Password)%>">
    Confirm Password: <input maxlength=20 size=20 name="cpassword" type="password" value="<%=Utilities.getValue(info.Password)%>"> (<%=Utilities.getValue(info.Password)%>)
    </td>
  </tr>
  <tr>
    <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Member Name:</td>
    <td><input maxlength=20 size=40 name="name" value="<%=Utilities.getValue(info.Name)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Company:</td>
    <td><input maxlength=40 size=40 name="company" value="<%=Utilities.getValue(info.Company)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Address1:</td>
    <td><input maxlength=60 size=40 name="address1" value="<%=Utilities.getValue(info.Address1)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Address2:</td>
    <td><input maxlength=40 size=40 name="address2" value="<%=Utilities.getValue(info.Address2)%>"></td>
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
  <tr>
    <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
  </tr>
  <tr class="normal_row">
    <td colspan=2>
    <table><tr>
    <td width="20%" align="right" valign="top">Service Plan:</td>
    <td width="22%">
      <select name="plans" size="5" multiple>
       <%=bean.getAllPlans()%>
      </select>
    </td>
    <td valign="top">Other Information:<br><%=bean.getPaymentInfo(info)%></td>
    </tr></table>
    </td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Concurrent login:</td>
    <td><input name="currentlogins" size=10 maxlength=10 value="<%=Utilities.getValue(info.CurrentLogins)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      The max number of concurrent login for this user. If it is 0, the member can not login any more.
    </td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Expired Date:</td>
    <td><input name="expireddate" size=20 maxlength=10 value="<%=Utilities.getValue(info.ExpiredDate)%>" onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'>
      (MM/DD/YYYY) If it is empty, no expired date is applied.
    </td>
  </tr>
  <SCRIPT>selectMultpleOptions(document.member.plans, "<%=info.PlanID%>", ",");</SCRIPT>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>" <%="View".equalsIgnoreCase(sAction)==true?"disabled":""%>></td>
  </tr>
  </table>
</form>
<SCRIPT>onMemberLoad(document.member);</SCRIPT>
<%@ include file="../share/footer.jsp"%>