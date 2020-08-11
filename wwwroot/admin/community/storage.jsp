<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/community.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityStorageBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityStorageInfo"%>
<%@ page import="com.omniserve.dbengine.util.Definition"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  CommunityStorageBean bean = new CommunityStorageBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  CommunityStorageInfo info = null;
  if ("Add Storage".equalsIgnoreCase(sAction))
  {
    CommunityStorageBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (CommunityStorageInfo)ret.getUpdateInfo();
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
  else if ("Update Storage".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    CommunityStorageBean.Result ret = bean.update(request, false);
    info = (CommunityStorageInfo)ret.getUpdateInfo();
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
    sAction = "Update Storage";
  }
  else if ("View".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "View";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Storage";
  }

  if (info==null)
  {
    info = CommunityStorageInfo.getInstance(true);
//    info.Bucket = Utilities.getUniqueId(8);
    info.PrivateSpaceUsed = 0;//
    info.PublicSpaceUsed = 0;//
    sAction = "Add Storage";
  }

  String sHelpTag = "communtiystorage";
  String sTitleLinks = "<a href=\"userlist.jsp?action=User List\">Community User List</a> > <a href=\"storagelist.jsp?action=Storage List\">Storage List</a> > ";
  String sDescription;
  if ("Add Storage".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a Storage</b>";
     sDescription = "The form below will allow you to add a storage.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Storage</b>";
     sDescription = "The form below will allow you to edit & update or view the storage information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="thisform" action="storage.jsp" method="post" onsubmit="return validateStorageForm(this);">
<input type="hidden" name="storeid" value="<%=info.StoreID%>">
<% if (!"Add Storage".equalsIgnoreCase(sAction)) { %>
<table width="85%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("storage.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="85%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Storage Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <!--tr class="normal_row">
    <td width="25%" align="right">MD5:</td>
    <td><input maxlength=40 size=36 name="md5" value="Utilities.getValue(info.MD5)" disabled>
    </td>
  </tr-->
  <!--tr class="normal_row">
    <td width="25%" align="right">Available Space:</td>
    <td><input maxlength=40 size=25 name="quota" value="info.Quota" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'> ( Utilities.convertFileSize(info.Quota) )
    </td>
  </tr-->
  <tr class="normal_row">
    <td width="25%" align="right">Private Files:</td>
    <td><input maxlength=40 size=25 name="privatefiles" value="<%=info.PrivateFiles%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");' disabled>
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Private Space Used:</td>
    <td><input maxlength=40 size=25 name="privatespaceused" value="<%=info.PrivateSpaceUsed%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");' disabled> ( <%=Utilities.convertFileSize(info.PrivateSpaceUsed)%> )
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Public Files:</td>
    <td><input maxlength=40 size=25 name="publicfiles" value="<%=info.PublicFiles%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");' disabled>
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Public Space Used:</td>
    <td><input maxlength=40 size=25 name="publicspaceused" value="<%=info.PublicSpaceUsed%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");' disabled> ( <%=Utilities.convertFileSize(info.PublicSpaceUsed)%> )
    </td>
  </tr>
  <!--tr class="normal_row">
    <td width="25%" align="right">Transfer Bandwidth:</td>
    <td><input maxlength=40 size=25 name="bandwidthused" value="<%=info.m_BandwidthUsed%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");' disabled> ( <%=Utilities.convertFileSize(info.m_BandwidthUsed)%>)
    </td>
  </tr-->
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<!--SCRIPT>onStorageFormLoad(document.thisform);</SCRIPT-->
<%@ include file="../share/footer.jsp"%>