<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.OrderBean"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%
  OrderBean bean = new OrderBean(session, 21);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ORDER))
     return;

  String sAction = request.getParameter("action");
  int nTotalRecords = 0;
  String sDisplayMessage = null;
  if ("orders".equalsIgnoreCase(sAction))//.LISTACTION_ALL.equalsIgnoreCase(sAction))
  {
    nTotalRecords = bean.getAll(request);
  }
  else if (OrderBean.LISTACTION_CUSTOMER.equalsIgnoreCase(sAction))
  {
    nTotalRecords = bean.getCustomerList(request);
  }
  else if (OrderBean.LISTACTION_SEARCH.equalsIgnoreCase(sAction))
  {
    nTotalRecords = bean.getSearchList(request);
  }
  else if ("Delete".equalsIgnoreCase(sAction))
  {
    nTotalRecords = bean.delete(request);
    if (nTotalRecords<0)
       sDisplayMessage = "Delete the order was fialed, Please try it later.";
  }
  else if ("Stop".equalsIgnoreCase(sAction)||"Active".equalsIgnoreCase(sAction))
  {
    int nRet = bean.StopActive(request, sAction);
    if (nRet<=0)
      sDisplayMessage = "Stop or Active the order was fialed, Please try it later.";
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getPageList(request);
  String sHelpTag = "orderlist";
/*
String sReturn = request.getParameter("return");
String sDisplay = request.getParameter("display");
  String sUrl = "orderlist.jsp";
  String sTitleLinks = "";
  if (sReturn!=null)
  {
    sUrl += "?return=" + sReturn;
    sUrl += "&display=" + sDisplay;
    sTitleLinks += "<a href=\"" + Utilities.replaceContent(sReturn, "|", "?action=", false) +"\">" + sDisplay + "</a> > ";
  }
  sTitleLinks += "<b>Order List</b>";
*/
  String sTitleLinks = bean.getNavigation(request, "Order List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can get a quick view of all orders and you can easily sort them. You can enter to the search page to get a group of specific order list. You can export them to MS-Excel or other database applications.
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
   <td width="20%"><a href="ordersearch.jsp?action=Search Order&return=orderlist.jsp|Orders&display=Order List">Search Orders</a></td>
   <td width="20%"><%=bean.getExportLink()%></td>
   <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'orderlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="10" align="center"><span class="failed"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>

<% if (!bean.getDomainName().endsWith("molecularsoft.com")) { %>
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("OrderNo", "orderlist.jsp", "Order No")%></th>
    <th width="9%" align="center" class="thCornerL"><%=bean.getSortNameLink("SubTotal", "orderlist.jsp", "Subtotal")%></th>
    <th width="7%" align="center" class="thCornerL"><%=bean.getSortNameLink("Tax", "orderlist.jsp")%></th>
    <th width="7%" align="center" class="thCornerL"><%=bean.getSortNameLink("ShipFee", "orderlist.jsp", "Ship")%></th>
    <th width="9%" align="center" class="thCornerL"><%=bean.getSortNameLink("GrandTotal", "orderlist.jsp", "Total")%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "orderlist.jsp", "Order Date")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("ShipDate", "orderlist.jsp", "Ship Date")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("Yourname", "orderlist.jsp", "Customer")%></th>
    <th width="10%" align="center" class="thCornerL">Actions</th>
  </tr>
<% } else {%>
    <tr>
      <th width="5%" align="center" class="thCornerL"><%=bean.getSortNameLink("OrderID", "orderlist.jsp", "No.")%></th>
      <th width="17%" align="center" class="thCornerL"><%=bean.getSortNameLink("Yourname", "orderlist.jsp", "Customer")%></th>
      <th width="21%" align="center" class="thCornerL"><%=bean.getSortNameLink("EMail", "orderlist.jsp", "E-Mail")%></th>
      <th width="13%" align="center" class="thCornerL"><%=bean.getSortNameLink("Description", "orderlist.jsp", "Modules")%></th>
      <!--th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("OrderNo", "orderlist.jsp", "Order No")%></th-->
      <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("TrackNo", "orderlist.jsp", "Serial No")%></th>
      <th width="7%" align="center" class="thCornerL"><%=bean.getSortNameLink("GrandTotal", "orderlist.jsp", "Total")%></th>
      <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "orderlist.jsp", "Order Date")%></th>
      <th align="center" class="thCornerL">Action</th>
    </tr>
<% } %>

<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=10>There is no any order available.</td>
  </tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     OrderInfo info = (OrderInfo)ltArray.get(i);
%>
<% if (!bean.getDomainName().endsWith("molecularsoft.com")) { %>
  <tr class="normal_row">
    <td width="6%"><%=(nStartNo+i)%></td>
    <td width="10%"><%=info.OrderNo%></td>
    <td width="9%" align="right"><%=Utilities.getNumberFormat(info.SubTotal,'$',2)%></td>
    <td width="7%" align="right"><%=Utilities.getNumberFormat(info.Tax,'$',2)%></td>
    <td width="7%" align="right"><%=Utilities.getNumberFormat(info.ShipFee,'$',2)%></td>
    <td width="9%" align="right"><%=Utilities.getNumberFormat(info.GrandTotal,'$',2)%></td>
    <td width="14%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="10%" align="center"><%=Utilities.getDateValue(info.ShipDate, 10)%></td>
    <td width="18%"><a href="../customer/customer.jsp?action=view&customerid=<%=info.CustomerID%>&return=../order/orderlist.jsp|Orders&display=Order List"><%=info.Yourname%></a></td>
    <td width="10%" align="center"><a href="order.jsp?action=view&orderid=<%=info.OrderID%>&customerid=<%=info.CustomerID%>&return=../order/orderlist.jsp|Orders&display=Order List">View</a>|<a href="orderlist.jsp?action=delete&orderid=<%=info.OrderID%>&customerid=<%=info.CustomerID%>&return=../order/orderlist.jsp&display=Order List" onClick="return confirm('Are you sure you want to delete this order.');">Delete</a></td>
  </tr>
<% } else {
   if (info.CreateDate.compareTo("2014-03-01 18:21:41")>0)
      continue;
%>
<tr class="normal_row">
  <!--td width="5%" align="center"><a href="javascript:ChildWin=window.open('msiinvoice.jsp?action=GetForm&orderid=<%=(info.OrderID)%>','InvoiceForm','resizable=yes,scrollbars=no,width=650,height=820');ChildWin.focus()"><%=(info.OrderID)%></a></td-->
  <td width="5%" align="center"><a title="View Order Invoice." href="#" onClick="return window.open('msiinvoice.jsp?action=GetForm&orderid=<%=(info.OrderID)%>','InvoiceForm','menubar=yes,resizable=yes,scrollbars=yes,width=700,height=850'); return false;"><%=(info.OrderID)%></a></td>
  <td width="17%"><%=info.Yourname%></td>
  <td width="21%"><a href="../util/email.jsp?action=person&toemail=<%=info.EMail%>&name=<%=info.Yourname%>&group=recipients&return=../customer/customerlist.jsp|Customers&display=Customer List" title="Email to <%=info.EMail%>"><%=info.EMail%></a></td>
  <td width="13%"><%=bean.getShortModules(info)%></td>
  <!--td width="10%"><%=info.OrderNo%></td-->
  <td width="16%"><a href="order.jsp?action=view&orderid=<%=info.OrderID%>&customerid=<%=info.CustomerID%>&return=../order/orderlist.jsp|Orders&display=Order List"><%=info.TrackNo%></a></td>
  <td width="7%" align="right"><%=Utilities.getNumberFormat(info.GrandTotal,'$',2)%></td>
  <td width="16%" align="left"> <%=Utilities.getDateValue(info.CreateDate, 19)%> <%=info.CreditType.startsWith("Paypal")?" (<b>P</b>)":""%> </td>
  <td align="center">
<% if (Utilities.getValue(info.Ship_Phone).length()==0) {%>
    <a href="orderlist.jsp?action=Stop&orderid=<%=info.OrderID%>" onClick="return confirm('Are you sure you want to stop this customer (No: <%=(info.OrderID)%>)?');">Stop</a>
<% } else { %>
    <a href="orderlist.jsp?action=Active&orderid=<%=info.OrderID%>" onClick="return confirm('Are you sure you want to active this customer (No: <%=(info.OrderID)%>)?');">Active</a>      
<% } %>
  </td>
</tr>
<% } %>
<%}%>
<% } %>
  <tr>
    <td colspan="10" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="15%"></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>