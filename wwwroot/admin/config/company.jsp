<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/company.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.CompanyBean"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=iso-8859-1" %>
<%
  CompanyBean bean = new CompanyBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_INFOMATION))
     return;

  String sAction = request.getParameter("action");
  CompanyInfo info;
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Update Now".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    CompanyBean.Result ret = bean.update(request);
    info = (CompanyInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "company information");
    }
  }
  else
  {
    info = bean.get(request);
  }

  String sHelpTag = "companyinfo";
  String sTitleLinks = "<b>Edit the Company Information</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can edit and update your company information. These information (except Your Name and E-Mail) will show on contact page of your website.
<form name="company" action="company.jsp" method="post" onSubmit="return validateCompany(this);">
  <input type="hidden" name="companyid" value="<%=info.CompanyID%>">
  <table cellspacing="1" cellpadding="4" border="0" align="center" class="forumline" width="82%">
    <tr>
      <th class="thHead" colspan="2" align="center">Company Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr class="normal_row">
      <td width="24%">
        <div align="right">Company Name:</div>
      </td>
      <td>
        <input maxlength=50 name="companyname" value="<%=Utilities.getValue(info.CompanyName)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%">
        <div align="right">Company Description:</div>
      </td>
      <td>
        <textarea name="companydesc" rows="3" cols="60" wrap="virtual"><%=Utilities.getValue(info.CompanyDesc)%></textarea>
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Street Address:</td>
      <td>
        <input maxlength=60 name="address" value="<%=Utilities.getValue(info.Address)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">City:</td>
      <td>
        <input maxlength=60 name="city" value="<%=Utilities.getValue(info.City)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">State/Province:</td>
      <td>
        <input maxlength=30 name="state" value="<%=Utilities.getValue(info.State)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Zip/Postal Code:</td>
      <td>
        <input maxlength=12 name="zipcode" value="<%=Utilities.getValue(info.ZipCode)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Country:</td>
      <td>
        <input maxlength=20 name="country" value="<%=Utilities.getValue(info.Country)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%">
        <div align="right">Your Name:</div>
      </td>
      <td>
        <input maxlength=40 name="yourname" value="<%=Utilities.getValue(info.Yourname)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%">
        <div align="right">E-Mail:</div>
      </td>
      <td>
        <input maxlength=60 name="email" value="<%=Utilities.getValue(info.EMail)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%">
        <div align="right">Phone Number:</div>
      </td>
      <td>
        <input maxlength=20 name="phone" value="<%=Utilities.getValue(info.Phone)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%">
        <div align="right">Fax Number:</div>
      </td>
      <td>
        <input maxlength=20 name="fax" value="<%=Utilities.getValue(info.Fax)%>" size="50">
      </td>
    </tr>
    <tr>
      <td class="catBottom" colspan="2" align="center"><input type="submit" value="Update Now" name="action"></td>
    </tr>
  </table>
</form>
<SCRIPT>onCompanyLoad(document.company);</SCRIPT>
<%@ include file="../share/footer.jsp"%>