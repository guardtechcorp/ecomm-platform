<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/community.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityQuotaBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityQuotaInfo"%>
<%@ page import="com.omniserve.dbengine.util.Definition"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  CommunityQuotaBean bean = new CommunityQuotaBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  CommunityQuotaInfo info = null;
  if ("Add Quota".equalsIgnoreCase(sAction))
  {
    CommunityQuotaBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (CommunityQuotaInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "storage");
      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Quota".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    CommunityQuotaBean.Result ret = bean.update(request, false);
    info = (CommunityQuotaInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "storage");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Quota";
  }
  else if ("View".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "View";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Quota";
  }

  if (info==null)
  {
    info = CommunityQuotaInfo.getInstance(true);
    info.UserID = Utilities.getInt(bean.getLinkFieldValue("Add Quota", "userid"), -1);
    info.PaymentID = 0;//
    info.Quantity = (long)1024*1024*1024;//
    info.Type = com.omniserve.dbengine.util.Definition.PAYPAL_STORAGE;
    sAction = "Add Quota";
  }

  String sHelpTag = "communtiyquota";
  String sTitleLinks;// = "<a href=\"storagelist.jsp?action=Storage List\">Storage List</a> > <a href=\"quotalist.jsp?action=Quota List\">Quota List</a> >";
  String sDescription;
  if ("Add Quota".equalsIgnoreCase(sAction))
  {
//     sTitleLinks += "<b>Add a Quota</b>";
     sTitleLinks = bean.getNavigation(request, "Add a Quota");
     sDescription = "The form below will allow you to add a storage.";
  }
  else
  {
//     sTitleLinks += "<b>Edit the Quota</b>";
     sTitleLinks = bean.getNavigation(request, "Edit the Quota");
     sDescription = "The form below will allow you to edit & update or view the storage information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="thisform" action="quota.jsp" method="post" onsubmit="return validateQuotaForm(this);">
<input type="hidden" name="quotaid" value="<%=info.QuotaID%>">
<input type="hidden" name="userid" value="<%=info.UserID%>">
<% if (!"Add Quota".equalsIgnoreCase(sAction)) { %>
<!--table width="85%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("quota.jsp?")%></td>
  </tr>
</table-->
<% } %>
<table width="85%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Quota Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr class="normal_row">
    <td width="25%" align="right">Quantity:</td>
    <td><input maxlength=40 size=25 name="quantity" value="<%=info.Quantity/(1024*1024*1024)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'> GB
    </td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<SCRIPT>onQuotaFormLoad(document.thisform);</SCRIPT>
<%@ include file="../share/footer.jsp"%>