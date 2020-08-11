<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityStorageBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityStorageInfo"%>
<%
  CommunityStorageBean bean = new CommunityStorageBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

//  bean.pushAction(request, null);

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    CommunityStorageBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getAll(request, "storagelist.jsp?");
  String sHelpTag = "CommunityStoragelist";
//  String sTitleLinks = "<a href=\"userlist.jsp?action=User List\">Community Member List</a> > <b>Storage List</b>";
  String sTitleLinks = bean.getNavigation(request, "Storage List");
//  bean.pushNavigation(request, "Storage List", true);
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all of Storage and sort them. You can delete any of them or enter the Storage page to edit it.
<p>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'storagelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" class="thCornerL">No.</th>
    <th width="29%" align="center" class="thCornerL">E-Mail (Member Account)</th>
    <th width="9%" align="center" class="thCornerL">Private File</th>
    <th width="11%" align="center" class="thCornerL">Private Space</th>
    <th width="8%" align="center" class="thCornerL">Public File</th>
    <th width="10%" align="center" class="thCornerL">Public Space</th>
    <th width="9%" align="center" class="thCornerL">Quota</th>
    <th width="9%" align="center" class="thCornerL">Available</th>
    <th width="9%" align="center" class="thCornerL">Transfer</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=9>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunityStorageInfo info = (CommunityStorageInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="6%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="29%"><%=Utilities.getValue(info.m_EMail)%></td>
    <td class="row1" width="9%"><%=info.PrivateFiles%></td>
    <td class="row1" width="11%"><%=Utilities.convertFileSize(info.PrivateSpaceUsed)%></td>
    <td class="row1" width="8%"><%=info.PublicFiles%></td>
    <td class="row1" width="10%"><%=Utilities.convertFileSize(info.PublicSpaceUsed)%></td>
    <td class="row1" width="9%"><a title="View the detail of quota information" href="quotalist.jsp?action=View&userid=<%=info.UserID%>"><%=Utilities.convertFileSize(info.m_Quota)%></a></td>
    <td class="row1" width="9%"><%=Utilities.convertFileSize(info.m_Quota - info.m_BandwidthUsed)%></td>
    <td class="row1" width="9%"><%=Utilities.convertFileSize(info.m_BandwidthUsed)%></td>
  </tr>
<%}}%>
  <tr>
    <td colspan="9" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <!--td width="30%"><a href="storage.jsp?action=AddStorage">Add Storage</a></td-->
          <td width="70%" align="right"><b><%=Utilities.getValue(bean.getCacheData(bean.KEY_PAGELINKS))%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
