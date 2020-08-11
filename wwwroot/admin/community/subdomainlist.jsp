<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunitySubdomainBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunitySubdomainInfo"%>
<%

  CommunitySubdomainBean bean = new CommunitySubdomainBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    CommunitySubdomainBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getAll(request, "subdomainlist.jsp?");

  String sHelpTag = "CommunitySubdomainlist";
  String sTitleLinks = "<b>Community User List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all of subdomain names and sort them. You can delete any of them or enter the subdomain page to edit it.
<p>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'subdomainlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="7%" class="thCornerL">No.</th>
    <th width="12%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "subdomainlist.jsp", "Sub Name")%></th>
    <th width="17%" align="center" class="thCornerL"><%=bean.getSortNameLink("YourName", "subdomainlist.jsp", "Customer Name")%></th>
    <th width="30%" align="center" class="thCornerL"><%=bean.getSortNameLink("EMail", "subdomainlist.jsp", "E-Mail")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("PayStatus", "subdomainlist.jsp", "Pay Status")%></th>
    <th width="13%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "subdomainlist.jsp", "Submit Date")%></th>
    <th width="9%" align="center" class="thCornerL">Actions</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=7>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunitySubdomainInfo info = (CommunitySubdomainInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="7%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="12%"><%=Utilities.getValue(info.Name)%></td>
    <td class="row1" width="17%"><%=Utilities.getValue(info.YourName)%></td>
    <td class="row1" width="30%"><%=info.EMail%></td>
    <td class="row1" width="10%" align="center"><%=bean.getPayStatus(info.PayStatus)%></td>
    <td class="row1" width="13%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td class="row1" width="9%" align="center" ><a title="View or edit Sub-Domain information" href="subdomain.jsp?action=Edit&subid=<%=info.SubID%>">Edit</a>
     | <!--a onClick="return confirm('Are you sure you want to delete it?');" href="subdomainlist.jsp?action=delete&subid=<%=info.SubID%>">Delete</a-->
    </td>
  </tr>
<%}}%>
  <tr>
    <td colspan="7" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="subdomain.jsp?action=Add SubDomain">Add Sub-Domain</a></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
