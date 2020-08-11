<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityQuotaBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityQuotaInfo"%>
<%
  CommunityQuotaBean bean = new CommunityQuotaBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    CommunityQuotaBean.Result ret = bean.delete(request);
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
  String sHelpTag = "CommunityQuotalist";
//  String sTitleLinks = "<a href=\"storagelist.jsp?action=Storage List\">Storage List</a> > <b>Quota List</b>";
  String sTitleLinks = bean.getNavigation(request, "Quota List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all of Quota and sort them. You can delete any of them or enter the Quota page to edit it.
<p>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
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
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("Type", "quotalist.jsp", "Type")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Quantity", "quotalist.jsp", "Quantity")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("PaymentID", "quotalist.jsp", "Payment Way")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "quotalist.jsp", "Add Time")%></th>
    <th width="18%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=9>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunityQuotaInfo info = (CommunityQuotaInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="6%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="18%"><%=info.Type==1?"Storage":"SubDomain"%></td>
    <td class="row1" width="20%"><%=Utilities.convertFileSize(info.Quantity)%></td>
    <td class="row1" width="20%"><%=info.PaymentID>0?"Buy from PayPal":"Free"%></td>
    <td class="row1" width="18%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td class="row1" width="18%" align="center" ><a title="View or edit Quota information" href="quota.jsp?action=Edit&quotaid=<%=info.QuotaID%>">Edit</a>
     | <a onClick="return confirm('Are you sure you want to delete it?');" href="quotalist.jsp?action=delete&quotaid=<%=info.QuotaID%>">Delete</a>
    </td>
  </tr>
<%}}%>
  <tr>
    <td colspan="9" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="quota.jsp?action=AddQuota">Add Quota</a></td>
          <td width="70%" align="right"><b><%=Utilities.getValue(bean.getCacheData(bean.KEY_PAGELINKS))%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>