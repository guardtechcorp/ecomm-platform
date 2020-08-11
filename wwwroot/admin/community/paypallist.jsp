<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityPaypalBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityPaypalInfo"%>
<%
  CommunityPaypalBean bean = new CommunityPaypalBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

//  bean.pushAction(request, null);

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request, "paypallist.jsp?");
  String sHelpTag = "CommunityPaypallist";
//  String sTitleLinks = "<a href=\"userlist.jsp?action=User List\">Community Member List</a> > <b>Storage List</b>";
  String sTitleLinks = bean.getNavigation(request, "PayPal List");
//  bean.pushNavigation(request, "Storage List", true);
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all of PayPal transaction and sort them..
<p>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'paypallist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" class="thCornerL">No.</th>
    <th width="21%" align="center" class="thCornerL"><%=bean.getSortNameLink("item_name", "paypallist.jsp", "Product Name")%></th>
    <th width="22%" align="center" class="thCornerL"><%=bean.getSortNameLink("receiver_email", "paypallist.jsp", "Seller")%></th>
    <th width="22%" align="center" class="thCornerL"><%=bean.getSortNameLink("payer_email", "paypallist.jsp", "Buyer")%></th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("payment_gross", "paypallist.jsp", "Charge")%></th>
    <th width="7%" align="center" class="thCornerL"><%=bean.getSortNameLink("payment_status", "paypallist.jsp", "Status")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("submit_date", "paypallist.jsp", "Date and Time")%></th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=9>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt((String)session.getAttribute(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunityPaypalInfo info = (CommunityPaypalInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="5%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="21%"><%=info.item_name%></td>
    <td class="row1" width="22%"><a href="http://home.omniserve.com/<%=bean.getMD5(info.SellerID)%>/index.html" target="_blank"><%=info.receiver_email%></a></td>
    <td class="row1" width="22%"><a href="http://home.omniserve.com/<%=bean.getMD5(info.BuyerID)%>/index.html" target="_blank"><%=info.payer_email%></a></td>
    <td class="row1" width="8%" align="right"><%=Utilities.getNumberFormat(info.payment_gross, '$', 2)%>&nbsp;</td>
    <td class="row1" width="7%"><%=Utilities.getValue(info.payment_status)%></td>
    <td class="row1" width="15%" align="center"><%=Utilities.getDateValue(info.submit_date, 16)%></td>
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
