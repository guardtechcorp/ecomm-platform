<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/contactus.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ContactUsBean"%>
<%@ page import="com.zyzit.weboffice.model.ContactUsInfo"%>
<%
  ContactUsBean bean = new ContactUsBean(session, 20, false);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
//     return;

  String sAction = request.getParameter("action");
  ContactUsInfo info = null;
  String sDisplayMessage = null;
  String sClass = "successful";

  if (bean.isMultiPartForm(request))
  {//. It is coming from form submitting (Add Page or Update Page)
    ContactUsBean.Result ret = bean.update(request);
    sAction = ret.m_sAction;
    //. Update tracing table
    bean.updateAccessHit(request, ContactUsBean.WEBHIT_ADMIN, sAction);
    if (ret.isSuccess())
    {
      info = (ContactUsInfo)ret.getUpdateInfo();
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "ContactUs");
    }
    else
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      info = (ContactUsInfo)ret.getUpdateInfo();
      sClass = "failed";
    }
  }
  else
  {
     if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
         return;

    if ("removeimage".equalsIgnoreCase(sAction))
    {
      info = (ContactUsInfo)bean.getCacheMap().get(bean.KEY_TEMPINFO);
      info.MapImage = "";
//      sAction = "Update Now";
      sDisplayMessage = "The file is temporarily removed and you have to click 'Update Now' button to permanently remove it.";
    }
    else
      info = bean.getContactUs();
  }

  String sHelpTag = "contactusfo";
  String sTitleLinks = bean.getNavigation(request, "Edit ContactUs Page");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can edit and update your company information. These information (except Your Name and E-Mail) will show on contact page of your website.
<form name="contactus" action="contactus.jsp" enctype="multipart/form-data" method="post" onSubmit="return validateContactUs(this);">
  <input type="hidden" name="contactid" value="<%=info.ContactID%>">
<table width="82%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="20%"></td>
    <td align="right"><a href="contactservicelist.jsp?action=Get List">Contact Service List</a>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
</table>
<table cellspacing="1" cellpadding="4" border="0" align="center" class="forumline" width="82%">
  <tr>
    <th class="thHead" colspan="2" align="center">ContactUs Information</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr class="normal_row">
    <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
  <tr class="normal_row">
    <td width="24%" align="right">Company Name:</td>
    <td>
      <input maxlength=50 name="companyname" value="<%=Utilities.getValue(info.CompanyName)%>" size="50">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="24%" align="right" valign="top">Company Description:</td>
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
    <td width="24%" align="right">E-Mail:</td>
    <td>
      <input maxlength=60 name="email" value="<%=Utilities.getValue(info.Email)%>" size="50">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="24%" align="right">Phone Number:</td>
    <td>
      <input maxlength=20 name="phone" value="<%=Utilities.getValue(info.Phone)%>" size="50">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="24%" align="right">Fax Number:</td>
    <td>
      <input maxlength=20 name="fax" value="<%=Utilities.getValue(info.Fax)%>" size="50">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="24%" align="right">Display Location Map:</td>
    <td>
    <select name="location">
      <option value=0 <%=bean.getSelected(0, info.Location)%>>No</option>
      <option value=1 <%=bean.getSelected(1, info.Location)%>>Yes</option>
    </select>
    </td>
  </tr>
  <tr class="normal_row">
    <td width="24%" align="right">Map Image Files:</td>
    <td>
      <input type="hidden" name="mapimage" value="<%=Utilities.getValue(info.MapImage)%>">
      <input type="file" name="mapimagefile" size="40">
<% if (info.MapImage!=null&&info.MapImage.length()>0) { %>
      &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=info.MapImage%>" target="imageview">Preview
      Image</a>&nbsp;&nbsp;<a href="contactus.jsp?action=removeimage&name=mapimage">Remove</a>
<% } %>
    </td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" value="Update Now" name="action"></td>
  </tr>
</table>
</form>
<SCRIPT>onContactUsLoad(document.contactus);</SCRIPT>
<%@ include file="../share/footer.jsp"%>