<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.OrderItemInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  ShopCartWeb shopcart = new ShopCartWeb(session, request, 10);
  shopcart.updateAccessHit(request, ShopCartWeb.WEBHIT_FRONT, null);
  String sAction = request.getParameter("action");

  if ("Export".equalsIgnoreCase(sAction))
  {
    shopcart.outputInvoice(request, response);
    return;
  }

//shopcart.showAllParameters(request, out);    
//. https://www.hepahealth.com/ctr/web/invoice.jsp?customerid=5363&preorderno=1364179947

  DomainInfo dmInfo = shopcart.getDomainInfo();
  ConfigInfo cfInfo = shopcart.getConfigInfo();

//shopcart.writeToLog(1000, "Going to Invoice PreOrderNo12 = " + dmInfo + ", " + cfInfo, ShopCartWeb.WEBHIT_FRONT);

  OrderInfo orInfo;
  List ltOrderItem;


  if ("Get Inovice".equalsIgnoreCase(sAction))
  {
//    OrderBean bean = new OrderBean(shopcart.getHttpSession(), 10);
//    Object[] objArray = bean.getOrderDetail(request);
    Object[] objArray = shopcart.getOrderDetail(request);
    orInfo = (OrderInfo)objArray[0];
    ltOrderItem = (List)objArray[1];
  }
  else
  {
     String preorderno  = request.getParameter("preorderno");
     if (Utilities.getValueLength(preorderno)>0)
     {
         orInfo = shopcart.getOrderInfo(preorderno);
         ltOrderItem = shopcart.getOrderItem(preorderno);
     }
     else
     {
         orInfo = shopcart.getOrderInfo();
         ltOrderItem = shopcart.getOrderItem();
     }
  }

  shopcart.saveOrderInfo(orInfo, ltOrderItem);
%>
<html>
<head>
<title>The Invoice of <%=shopcart.getDomainName()%> (Invoice No: <%=orInfo.OrderNo%>)</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet">
<link media=print  rel="stylesheet" href="/staticfile/web/css/print.css" type="text/css">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
</head>
<body bgcolor="#ffffff">
<%
    if (!"get".equalsIgnoreCase(sAction)) {%>
<br>
<table cellspacing=0 cellpadding=0 border=0 width=95% align="center">
  <tr>
    <td align="center" class="ten"><%=shopcart.getLabelText(cfInfo, "orderdone-des")%> <%=shopcart.getLabelText(cfInfo, "thankorder-des")%></td>
  </tr>
</table>
<br>
<% } %>
<table id=hidediv cellpadding=0 border=0 cellspacing=0 align="center" width=95% bgcolor="#666666">
  <tr bgcolor="#ffffff">
    <td class="ten" align="right" height="20">
     <a class="hightlight" href="javascript:window.print();"><%=shopcart.getLabelText(cfInfo, "print-des")%></a> |
     <a class="hightlight" href="<%="invoice.jsp?action=Export&filetype=pdf"%>"><%=shopcart.getLabelText(cfInfo, "exportpdf-des")%></a> |
     <a class="hightlight" href="<%="invoice.jsp?action=Export&filetype=rtf"%>"><%=shopcart.getLabelText(cfInfo, "exportrtf-des")%></a>
   </td>
  </tr>
</table>
<table cellpadding=2 border=0 cellspacing=1 align="center" width=95% bgcolor="#666666">
  <tr bgcolor="#ffffff">
    <td class="ten"><%=shopcart.getLabelText(cfInfo, "orderno-des")%> <b><%=orInfo.OrderNo%></b></td>
    <td class="ten"><%=shopcart.getLabelText(cfInfo, "orderdate-des")%> <b><%=Utilities.getDateValue(orInfo.CreateDate, 16)%></b></td>
  </tr>
  <tr bgcolor="#4279bd">
    <td class="WB10" align="center" width=50%><b><%=shopcart.getLabelText(cfInfo, "billinfo-des")%></b></td>
    <td class="WB10" align="center" width=50%><b><%=shopcart.getLabelText(cfInfo, "billaddress-des")%></b></td>
  </tr>
  <tr bgcolor="#ffffff">
    <td class="ten" valign="top"><b><%=orInfo.Yourname%><br>
      <%=orInfo.Address%><br>
      <%=orInfo.City%>, <%=orInfo.State%> <%=orInfo.ZipCode%>, <%=orInfo.Country%></b><br>
      <br><%=shopcart.getPaymentDesc(orInfo, false)%>
    </td>
    <td class="ten" valign="top"><b><%=shopcart.getShipAddress(orInfo, true)%></b>
    <%=shopcart.getShipInfo(orInfo, false)%>
    <br>
    </td>
  </tr>
</table>
<br>
<table cellspacing=1 border=0 cellpadding=1 width=95% align="center" bgcolor="#666666">
  <tr bgcolor="#9999cc">
    <td class="WB10" width=50% align="center"><%=shopcart.getLabelText(cfInfo, "productname-col")%></td>
    <td class="WB10" width=13% align="center"><%=shopcart.getLabelText(cfInfo, "productcode-col")%></td>
    <td class="WB10" width=8% align="center"><%=shopcart.getLabelText(cfInfo, "quantity-col")%></td>
    <td class="WB10" width=14% align="center"><%=shopcart.getLabelText(cfInfo, "price-col")%></td>
    <td class="WB10" width=15% align="center"><%=shopcart.getLabelText(cfInfo, "total-col")%></td>
  </tr>
<% //if (!"get".equalsIgnoreCase(sAction)) {
  for (int i=0; i<ltOrderItem.size(); i++) {
     OrderItemInfo oiInfo = (OrderItemInfo) ltOrderItem.get(i);
%>
  <tr bgcolor="#eeeeee">
    <!--td class="ten" align=center width="50%"><A  href="index.jsp?action=productdetail&productid=<%=oiInfo.ProductID%>"><%=oiInfo.Name%></a></td-->
    <td class="ten" align="center" width="50%"><%=oiInfo.Name%></td>
    <td class="ten" align="center" width="13%"><%=oiInfo.Code%></td>
    <td class="ten" align="center" width="8%"><%=oiInfo.Quantity%></td>
    <td class="ten" align="right" width="14%"><%=Utilities.getNumberFormat(oiInfo.Price,'$',2)%></td>
    <td class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(oiInfo.Quantity*oiInfo.Price,'$',2)%></td>
  </tr>
<% } %>
  <tr bgcolor="#ffffff">
<%
    if (orInfo.Discount>0) { %>
   <td class="ten" colspan=2 rowspan=5>
<% } else { %>
   <td class="ten" colspan=2 rowspan=4>
<% } %>
    <table width="100%" border="0">
      <tr>
        <td colspan=2><!--%=shopcart.getIncentiveNote(orInfo.Note)% --></td>
      </tr>
      <tr>
        <td class="eight" width="22%" align="right" valign="top"><%=shopcart.getLabelText(cfInfo, "ordercomment-col")%></td>
        <td class="eight" width="78%"><%=Utilities.getValue(orInfo.Comment)%></td>
      </tr>
      <tr>
        <td class="eight" width="22%" align="right"><%=shopcart.getLabelText(cfInfo, "shipmethod-col")%></td>
        <td class="eight" width="78%" ><%=Utilities.getValue(orInfo.Description)%></td>
      </tr>
      <tr>
        <td class="eight" width="22%" align="right"><%=shopcart.getLabelText(cfInfo, "trackno-col")%></td>
        <td class="eight" width="78%"><%=shopcart.getShipmentTrack(orInfo, true)%></td>
      </tr>
    </table>
   </td>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right"><%=shopcart.getLabelText(cfInfo, "subtotal-col")%></td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(orInfo.SubTotal,'$',2)%></td>
  </tr>
<% if (orInfo.Discount>0) { %>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right"><%=shopcart.getLabelText(cfInfo, "discount-col")%></td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%">-<%=Utilities.getNumberFormat(orInfo.Discount,'$',2)%></td>
  </tr>
<% } %>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right"><%=shopcart.getLabelText(cfInfo, "tax-col")%></td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(orInfo.Tax,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right"><%=shopcart.getLabelText(cfInfo, "ship-col")%></td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(orInfo.ShipFee,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right"><%=shopcart.getLabelText(cfInfo, "grant-col")%></td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><b><%=Utilities.getNumberFormat(orInfo.GrandTotal,'$',2)%></b></td>
  </tr>
</table>
<br>
<% if ("Check".equalsIgnoreCase(orInfo.CreditType)) {%>
<table cellspacing=0 cellpadding=0 border=0 width=95% align="center">
  <tr><td>
   <table align="center" border="0" cellpadding="1" cellspacing="0" width="100%" class="infobox">
    <tr>
     <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b><%=shopcart.getLabelText(cfInfo, "orderpolicy-til")%></b><br>
      <%=shopcart.getLabelText(cfInfo, "orderpolicy-des")%></font>
     </td>
    </tr>
   </table>
</td></tr>
</table>
<br>
<% }%>
<%=shopcart.getOnlineProducts(orInfo, false)%>
<br>
<table cellspacing=0 cellpadding=0 border=0 width=95% align="center">
  <tr><td>
    <%=shopcart.getTestInfo(dmInfo, cfInfo)%>
 </td></tr>
</table>
<%
    if (!"get".equalsIgnoreCase(sAction)) {%>
<table border=0 cellspacing=0 cellpadding=0 align="center" width=95%>
  <tr>
    <td class="ten" align="center" height=10 colspan=3></td>
  </tr>
<%
    if (!"Get Inovice".equalsIgnoreCase(sAction)){ %>
  <tr>
    <td class="ten" align="center">
    <script>createLeftButton();</script>
    <a class="button" href="http://<%=shopcart.getDomainName()%>"><%=shopcart.getLabelText(cfInfo, "gohome-link")%></a>
    <script>createRightButton();</script>
    </td>
    <td class="ten" align="center">
    <script>createLeftButton();</script>
    <a class="button" href="<!--=shopcart.getContinueShop()% -->"><%=shopcart.getLabelText(cfInfo, "continueshop-link")%></a>
    <script>createRightButton();</script>
   </td>
    <td class="ten" align="center">
    <script>createLeftButton();</script>
    <a class="button" href="javascript:window.close()"><%=shopcart.getLabelText(cfInfo, "closeexit-link")%></a>
    <script>createRightButton();</script>
   </td>
  </tr>
<% } else { %>
  <tr>
    <td class="ten" align="center" colspan="3">
    <script>createLeftButton();</script>
    <a class="button" href="javascript:window.close()"><%=shopcart.getLabelText(cfInfo, "closeexit-link")%></a>
    <script>createRightButton();</script>
   </td>
  </tr>
<% } %>
</table>
<% } %>
</body>
</html>
<% } %>
