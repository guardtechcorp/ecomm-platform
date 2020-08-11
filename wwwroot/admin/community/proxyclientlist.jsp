<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityProxyClientBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityProxyClientInfo"%>
<%
  CommunityProxyClientBean bean = new CommunityProxyClientBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }
  List ltArray = bean.getAll(request, "proxyclientlist.jsp?");

  String sHelpTag = "communittyclientlist";
  String sTitleLinks = bean.getNavigation(request, "Proxy Client List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all of community proxy clients and sort them.
<p>
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'proxyclientlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" class="thCornerL">No.</th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("UserID", "proxymemberlist.jsp", "User ID")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("Sid", "proxymemberlist.jsp", "Session ID")%></th>
    <th width="17%" align="center" class="thCornerL"><%=bean.getSortNameLink("ClientIP", "proxymemberlist.jsp", "Client IP")%></th>
    <th width="22%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "proxymemberlist.jsp", "Login Date and Time")%></th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=7>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunityProxyClientInfo info = (CommunityProxyClientInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="6%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="10%" align="center"><a title="View user profile information" href="user.jsp?action=View&userid=<%=info.UserID%>"><%=(info.UserID)%></a></td>
    <td class="row1" width="18%" align="center"><%=info.Sid%></td>
    <td class="row1" width="17%" align="center"><%=info.ClientIP%></td>
    <td class="row1" width="22%" align="center"><%=Utilities.getDateValue(info.CreateDate, 19)%></td>
  </tr>
<%}}%>
  <tr>
    <td colspan="7" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%">Total Online Clients: <b><%=bean.getTotalUsers(request)%></b></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
