<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/contactus.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ContactServiceBean"%>
<%@ page import="com.zyzit.weboffice.model.ContactServiceInfo"%>
<%
  ContactServiceBean bean = new ContactServiceBean(session, 100);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  ContactServiceInfo info = null;

  if ("Add Service".equalsIgnoreCase(sAction))
  {
    ContactServiceBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (ContactServiceInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Contact Service");
      //. Change to update of adding its sub-category
//      info = (ContactServiceInfo)ret.getUpdateInfo();
      sAction = "Update Service";
    }
  }
  else if ("Update Service".equalsIgnoreCase(sAction))
  {
    ContactServiceBean.Result ret = bean.update(request, false);
    info = (ContactServiceInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Contact Service");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
      info =  bean.get(request);
      sAction = "Update Service";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
      info =  bean.getPrevOrNext(sAction);
      sAction = "Update Service";
  }

  if (info==null)
  {
    info = ContactServiceInfo.getInstance(true);
    sAction = "Add Service";
  }

  String sHelpTag = "contactservice";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Service".equalsIgnoreCase(sAction))
  {
     sTitleLinks = bean.getNavigation(request, "Create a Contact Service");
     sDescription = "The form below will allow you to create a new contact service.";
  }
  else
  {
     sTitleLinks = bean.getNavigation(request, "Edit the Contact Service");
     sDescription = "The form below will allow you to edit and update the contact service.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="serviceform" action="contactservice.jsp" method="post" onsubmit="return validateContactService(this);">
<input type="hidden" name="serviceid" value="<%=info.ServiceID%>">
<!--input type="hidden" name="candelete" value="<%=info.CanDelete%>"-->
<% if (info.ServiceID>=0) { %>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"></td>
    <td align="right"><%=bean.getPrevNextLinks("contactservice.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Contact Service</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="20%" align="right">Name:</td>
      <td class="row1">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="128" style="width: 400px;"> The Name of service.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right" valign="top">Description:</td>
      <td class="row1">
        <textarea name="description" rows="6" cols="48" wrap="virtual" style="width: 400px;"><%=Utilities.getValue(info.Description)%></textarea>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">E-Mail:</td>
      <td class="row1">
        <input type="text" name="email" value="<%=bean.getEmail(info)%>" maxlength="60" style="width: 400px;"> The E-Mail of service.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Phone Number:</td>
      <td class="row1">
        <input type="text" name="phone" value="<%=Utilities.getValue(info.Phone)%>" maxlength="20" style="width: 400px;"> The Phone number of service.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Fax Number:</td>
      <td class="row1">
        <input type="text" name="fax" value="<%=Utilities.getValue(info.Fax)%>" maxlength="20" style="width: 400px;"> The Fax number of service.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Active:</td>
      <td class="row1">
        <select name="active">
          <option value=1 <%=bean.getSelected(1, info.Active)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Active)%>>No</option>
        </select> If selects 'No', this service will not show on ContactUs page.
      </td>
    </tr>
    <tr class="normal_row">
      <td colSpan=2 height=5></td>
    </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<SCRIPT>onContactServiceLoad(document.serviceform);</SCRIPT>
<%@ include file="../share/footer.jsp"%>