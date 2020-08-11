<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.OrderBean"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.OrderItemInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%
{
  OrderBean bean = new OrderBean(session, 10);
  DomainInfo dmInfo = bean.getDomainInfo();

  Object[] objArray = bean.getOrderDetail(request);
  OrderInfo orInfo = (OrderInfo)objArray[0];
  CustomerInfo ctInfo = (CustomerInfo)objArray[1];
  List ltArray = (List)objArray[2];

//Utilities.dumpObject(ctInfo);
%>
<html>
<head>
<style type="text/css">
<!--
 .cccc { ;}
.ten { font: 10pt Arial }
.eight { font: 8pt Arial }
-->
.WB10 { color: white; font: bold 10pt Arial,Helvetica;}
</style>
<title><%=bean.getDomainName()%> Sales Receipt</title>
</head>
<body bgcolor="#ffffff">
<center>
  <br>
</center>
<table cellspacing=0 cellpadding=0 border=0 width=95% align="center">
  <tr>
    <td align="center">This is your order invoice. Your can <a href="javascript:window.print();">print</a> this page for your reference. Thank you for your order.</td>
  </tr>
</table>
<br>
<table cellpadding=2 border=0 cellspacing=1 align="center" width=95% bgcolor="#666666">
  <tr bgcolor="#ffffff">
    <td class=ten>Order Number: <b><%=orInfo.OrderNo%></b></td>
    <td class=ten>Order Date and Time: <b><%=Utilities.getDateValue(orInfo.CreateDate, 16)%></b></td>
  </tr>
  <tr bgcolor="#4279bd">
    <td class=WB10 align=center width=50%><b>Billing Information</b></td>
    <td class=WB10 align=center width=50%><b>Shipping Address</b></td>
  </tr>
  <tr bgcolor=#ffffff>
    <td class=ten><b><%=ctInfo.Yourname%><br>
      <%=ctInfo.Address%><br>
      <%=ctInfo.City%>, <%=ctInfo.State%> <%=ctInfo.ZipCode%></b><br>
      <br>
      Payment Method:<b><%=ctInfo.CreditType%></b><br>
      Credit Card No:<b><%=bean.getCreditNo(ctInfo.CreditNo, false)%></b><br>
      Expiration: <b><%=ctInfo.ExpiredMonth%>/<%=ctInfo.ExpiredYear%></b><br>
    </td>
    <td class=ten><b><%=bean.getShipAddress(ctInfo, true)%></b>
    </td>
  </tr>
</table>
<br>
<br>
<table cellspacing=1 border=0 cellpadding=1 width=95% align=center bgcolor=#666666>
  <tr bgcolor="#4279bd">
    <td class=WB10 width=50% align=center bgcolor="#9999cc">Products</td>
    <td class=WB10 width=13% align=center bgcolor="#9999cc">Code</td>
    <td class=WB10 width=8% align=center bgcolor="#9999cc">Quantity</td>
    <td class=WB10 width=14% align=center bgcolor="#9999cc">Unit Price</td>
    <td class=WB10 width=15% align=center bgcolor="#9999cc">Total Price</td>
  </tr>
<%
  for (int i=0; i<ltArray.size(); i++) {
    OrderItemInfo oiInfo = (OrderItemInfo)ltArray.get(i);
%>
  <tr bgcolor=#eeeeee>
    <td class=ten align="center" width="50%"><A  href="<%=bean.encodedUrl("index.jsp?action=productdetail&productid=" + oiInfo.ProductID + "&name=" + oiInfo.Name)%>"><%=oiInfo.Name%></a></td>
    <td class=eight align=center width="13%"><%=oiInfo.Code%></td>
    <td class=ten align=center width="8%"><%=oiInfo.Quantity%></td>
    <td class=ten align=right width="14%"><%=Utilities.getNumberFormat(oiInfo.Price,'$',2)%></td>
    <td class=ten align=right width="15%"><%=Utilities.getNumberFormat(oiInfo.Quantity*oiInfo.Price,'$',2)%></td>
  </tr>
<% } %>
  <tr bgcolor=#ffffff>
   <td class=ten colspan=2 rowspan=6>&nbsp;</td>
   <td bgcolor=#ffffff class=ten colspan=2 align=right>Subtotal:</td>
   <td bgcolor=#ffffff class=ten align=right width="15%"><%=Utilities.getNumberFormat(orInfo.SubTotal,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor=#ffffff class=ten colspan=2 align=right>Tax:</td>
   <td bgcolor=#ffffff class=ten align=right width="15%"><%=Utilities.getNumberFormat(orInfo.Tax,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor=#ffffff class=ten colspan=2 align=right>Shipping:</td>
   <td bgcolor=#ffffff class=ten align=right width="15%"><%=Utilities.getNumberFormat(orInfo.ShipFee,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor=#ffffff class=ten colspan=2 align=right>Grand Total:</td>
   <td bgcolor=#ffffff class=ten align=right width="15%"><b><%=Utilities.getNumberFormat(orInfo.GrandTotal,'$',2)%></b></td>
  </tr>
</table>
<% if (dmInfo.TestFlag>0) {%>
<center>
  <p>&nbsp;</p>
  <p align="left">
      <font face="arial" color="red" size="3"><br>
        This website is for test purposes only and will be removed in no more
        than 30 days. Please do not try to buy from this website unless you are
        testing this site. Orders placed on this site is for test purposes only
        and will not be shipped under any circumstances.</font> </p>
</center>
<% } %>
<br>
<table border=0 cellspacing=0 cellpadding=0 align="center" width=95%>
  <tr>
    <td class=ten></td>
  </tr>
</table>
</body>
</html>
<% } %>
