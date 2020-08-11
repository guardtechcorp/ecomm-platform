<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ShipOrderBean"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%
  ShipOrderBean bean = new ShipOrderBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_SHIPMENT))
     return;

  String sAction = request.getParameter("action");
  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  int nTotalRecords = bean.getAll(request);
  List ltArray = bean.getPageList(request);

  String sHelpTag = "shiporderlist";
/*
  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");
  String sTitleLinks = "";
  if (sReturn!=null)
    sTitleLinks += "<a href=\"" + Utilities.replaceContent(sReturn, "|", "?action=", false) +"\">" + sDisplay + "</a> > ";
  sTitleLinks += "<b>Unshipped Order List</b>";
*/
  String sTitleLinks = bean.getNavigation(request, "Unshipped Order List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can get a quick view of all unshipped orders and you can easily sort them. You can enter to the shipment page to
fill shipment information to finish shipping process.
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'shiporderlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL">No.</th>
    <th width="11%" align="center" class="thCornerL"><%=bean.getSortNameLink("OrderNo", "shiporderlist.jsp", "Order No")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("SubTotal", "shiporderlist.jsp", "Subtotal")%></th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Tax", "shiporderlist.jsp")%></th>
    <th width="7%" align="center" class="thCornerL"><%=bean.getSortNameLink("ShipFee", "shiporderlist.jsp", "Ship")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("GrandTotal", "shiporderlist.jsp", "Total")%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "shiporderlist.jsp", "Order Date")%></th>
    <th width="12%" align="center" class="thCornerL"><%=bean.getSortNameLink("PayStatus", "shiporderlist.jsp", "Pay Status")%></th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("Yourname", "shiporderlist.jsp", "Customer")%></th>
    <th width="7%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=10>There is no any order available.</td>
  </tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     OrderInfo info = (OrderInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="5%"><%=(nStartNo+i)%></td>
    <td width="11%"><%=info.OrderNo%></td>
    <td width="10%" align="right"><%=Utilities.getNumberFormat(info.SubTotal,'$',2)%></td>
    <td width="8%" align="right"><%=Utilities.getNumberFormat(info.Tax,'$',2)%></td>
    <td width="7%" align="right"><%=Utilities.getNumberFormat(info.ShipFee,'$',2)%></td>
    <td width="10%" align="right"><%=Utilities.getNumberFormat(info.GrandTotal,'$',2)%></td>
    <td width="14%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="12%" align="center"><%=Utilities.getValue(info.PayStatus)%></td>
    <td width="16%" align="center"><a href="../customer/customer.jsp?action=view&customerid=<%=info.CustomerID%>&return=<%=Utilities.getUrlEncode("./order/shiporderlist.jsp|Unshipped Orders")%>.&display=Unshipped Order List"><%=info.Yourname%></a></td>
    <td width="7%" align="center"><a href="shiporder.jsp?action=edit&orderid=<%=info.OrderID%>&customerid=<%=info.CustomerID%>&return=<%=Utilities.getUrlEncode("../order/shiporderlist.jsp|Unshipped Orders")%>&display=Unshipped Order List">Shipment</a></td>
  </tr>
<%}%>
<% } %>
  <tr>
    <td colspan="10" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>