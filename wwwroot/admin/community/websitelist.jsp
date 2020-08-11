<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityWebsiteBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityWebsiteInfo"%>
<%
  CommunityWebsiteBean bean = new CommunityWebsiteBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    CommunityWebsiteBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request, "websitelist.jsp?");
  String sHelpTag = "CommunityWebsitelist";
  String sTitleLinks = bean.getNavigation(request, "Website List");

%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all of Website and sort them. You can delete any of them or enter the Website page to edit it.
<p>
<table width="100%" cellpadding="2" cellspacing="1" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'quotalist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" class="thCornerL">No.</th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("SiteName", "websitelist.jsp", "Site Name")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Description", "websitelist.jsp", "Description")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Feature", "websitelist.jsp", "Feature")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "websitelist.jsp", "Created Date")%></th>
    <th width="18%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=9>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunityWebsiteInfo info = (CommunityWebsiteInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="6%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="18%"><%=info.SiteName%></td>
    <td class="row1" width="20%"><%=info.Description%></td>
    <td class="row1" width="20%"><%=info.Feature%></td>
    <td class="row1" width="18%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td class="row1" width="18%" align="center" ><a title="View or edit Quota information" href="website.jsp?action=Edit&siteid=<%=info.SiteID%>">Edit</a>
     | <a onClick="return confirm('Are you sure you want to delete it?');" href="websitelist.jsp?action=delete&siteid=<%=info.SiteID%>">Delete</a>
    </td>
  </tr>
<%}}%>
  <tr>
    <td colspan="9" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="website.jsp?action=AddWebsite">Add Website</a></td>
          <td width="70%" align="right"><b><%=Utilities.getValue(bean.getCacheData(bean.KEY_PAGELINKS))%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>