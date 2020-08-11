<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/membership.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%
//http://www2.hepahealth.com/ctr/admin/membership/member-update.jsp?action=edit
  MemberBean bean = new MemberBean(session, 0);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERS))
//     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
//  String sReturn = request.getParameter("return");
//  String sDisplay = request.getParameter("display");
  MemberInfo info = null;
  if ("Edit".equalsIgnoreCase(sAction))
  {
     info = bean.getMemberInfo(request);
     if (info==null)
        return; //It is not login
  }
  else if ("Update".equalsIgnoreCase(sAction))
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
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "your information");
//Utilities.dumpObject(info);
      String sReturn = bean.getFirstPageUrl(request, bean.getDomainName(), info);
//System.out.println("sReturnUrl1=" + sReturn);

      response.sendRedirect(sReturn);
    }
  }
  else if ("Cancel".equalsIgnoreCase(sAction))
  {
//    info =  bean.get(request);
//     response.sendRedirect(sReturn);
    info = bean.getMemberInfo(request);
    String sReturn = bean.getFirstPageUrl(request, bean.getDomainName(), info);
//System.out.println("sReturnUrl2=" + sReturn);
    response.sendRedirect(sReturn);
  }
  else
    return;
%>
<p>
<h2 align="center">Member Profile Infomation</h2>
The form below will allow you to edit & update your information.
<form name="member" action="member-update.jsp" method="post" onsubmit="return validateMember(this);">
<input type="hidden" name="memberid" value="<%=info.MemberID%>">
<input type="hidden" name="selftupdate" value="1">
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
    <td class="catBottom" colspan="2" align="center">
     <input type="submit" name="action" value="Update">
     <input type="submit" name="action" value="Cancel">
    </td>
  </tr>
  </table>
</form>
<SCRIPT>onMemberLoad(document.member);</SCRIPT>
<%@ include file="../share/footer.jsp"%>