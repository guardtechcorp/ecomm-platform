<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 35);
  CustomerInfo ctInfo = web.getInfo(request);
  ConfigInfo cfInfo = web.getConfigInfo();

  String sType = request.getParameter("type");
  if ("afterlogin".equalsIgnoreCase(sType))
  {
     int nTotalRecords = web.getCustomerList(request);
  }
  else
  {//. Page switch
  }
  List ltArray = web.getPageList(request);
//web.showAllParameters(request, out);
%>
<style>
tr:hover {background: silver;cursor: pointer;}
tr:nth-child(even) {background: #f2f2f2}
tr:nth-child(odd) {background: #fff}

</style>
<div class="trackignWrap">
<h2>Order Tracking</h2>
<table cellspacing=2 cellpadding=2 width="100%" height="530" align="center"><tr><td valign="top">
<table width="100%" align="right" border="0" class="trackTable">
  <thead>
  <tr vAlign="middle">
    <th width="5%" align="center" height=25><b><%=web.getLabelText(cfInfo, "no-col")%></b></th>
    <th width="12%" align="center"><%=web.getSortNameLink("OrderNo", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "orderno-col"), true)%></th>
    <th width="11%" align="center"><%=web.getSortNameLink("SubTotal", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "subtotal2-col"), true)%></th>
    <th width="10%" align="center"><%=web.getSortNameLink("Tax", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "tax2-col"), true)%></th>
    <th width="10%" align="center"><%=web.getSortNameLink("ShipFee", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "ship2-col"), true)%></th>
    <th width="12%" align="center"><%=web.getSortNameLink("GrandTotal", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "total2-col"), true)%></th>
    <th width="20%" align="center"><%=web.getSortNameLink("CreateDate", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "orderdate-col"), true)%></th>
    <th width="20%" align="center"><%=web.getSortNameLink("ShipDate", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "shipdate-col"), true)%></th>
  </tr>
</thead>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr>
    <td colspan=9><%=web.getLabelText(cfInfo, "noorder-des")%></td>
  </tr>
<% } else {
  int nStartNo = Utilities.getInt(web.getCacheData(web.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     OrderInfo info = (OrderInfo)ltArray.get(i);
%>
  <tr bgColor="#eeeee" class="trackItm">
    <td width="5%" align="center">
      <a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=(nStartNo+i)%></a></td>
    <td width="12%">
      <label>Order No.</label>
      <a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + "&type=2" + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=info.OrderNo%></a></td>
    <td width="11%" align="right">
      <label>Subtotal</label>
      <a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getNumberFormat(info.SubTotal,'$',2)%></a></td>
    <td width="10%" align="right">
      <label>Tax</label>
      <a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getNumberFormat(info.Tax,'$',2)%></a></td>
    <td width="10%" align="right">
      <label>Ship</label>
      <a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getNumberFormat(info.ShipFee,'$',2)%></a></td>
    <td width="12%" align="right">
      <label>Total</label>
      <a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getNumberFormat(info.GrandTotal,'$',2)%></a></td>
    <td width="20%" align="center">
      <label>Order Date</label>
      <a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getDateValue(info.CreateDate, 16)%></a></td>
    <td width="20%" align="center">
      <label>Ship Date</label>
      <%=web.getShipmentTrack(info, false)%></td>
  </tr>
<%}%>
  <tr>
    <td colspan=9 align="right" height=25 class="pageNumLinks"><%=web.encodedHrefLink(web.getCacheData(web.KEY_PAGELINKS))%> </td>
  </tr>
<% } %>
</table>
</td></tr></table>
</div>
<% } %>
