<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityProxyServerBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityProxyServerInfo"%>
<%
  CommunityProxyServerBean bean = new CommunityProxyServerBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";

  if ("Server List".equalsIgnoreCase(sAction))
  {
    int nTotalRecords = bean.getAll(request);
  }
  else  if ("Delete".equalsIgnoreCase(sAction))
  {
    CommunityProxyServerBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getPageList(request, "proxyserverlist.jsp?");

  String sHelpTag = "communityproxyserverlist";
  String sTitleLinks = bean.getNavigation(request, "Proxy Server List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all community servers and sort them. You can delete any of them or enter the user page to edit it.
<p>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'proxyserverlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" class="thCornerL">No.</th>
    <th width="28%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "proxyserverlist.jsp", "Server Name")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("IP", "proxyserverlist.jsp", "IP Address")%></th>
    <th width="6%" align="center" class="thCornerL"><%=bean.getSortNameLink("Port", "proxyserverlist.jsp", "Port")%></th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Active", "proxyserverlist.jsp", "Status")%></th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "proxyserverlist.jsp", "Created Date")%></th>
    <th width="7%" align="center" class="thCornerL">Clients</th>
    <th width="22%" align="center" class="thCornerL">Actions</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=8>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunityProxyServerInfo info = (CommunityProxyServerInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="5%" align="center"><%=(i + nStartNo)%></td>
    <td class="row1" width="28%" align="center"><%=info.Name%></td>
    <td class="row1" width="18%" align="center"><%=info.IP%></td>
    <td class="row1" width="6%" align="center"><%=info.Port%></td>
    <td class="row1" width="8%" align="center"><%=info.Active!=0?"On":"Off"%></td>
    <td class="row1" width="16%" align="center"><%=Utilities.getDateValue(info.CreateDate, 19)%></td>
    <td class="row1" width="7%" align="center"><a title="View the user list" href="proxyclientlist.jsp?action=View&serverid=<%=info.ServerID%>"><%=bean.getTotalUsers(info.ServerID)%></a></td>
    <td class="row1" width="22%" align="center">
        <a title="Edit proxy server information" href="proxyserver.jsp?action=Edit&serverid=<%=info.ServerID%>">Edit</a>
      | <a onClick="return confirm('Are you sure you want to delete it?');" href="proxyserverlist.jsp?action=delete&serverid=<%=info.ServerID%>">Delete</a>
    </td>
  </tr>
<%}}%>
  <tr>
    <td colspan="8" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="proxyserver.jsp?action=add">Add New Server</a></td>
          <td align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>