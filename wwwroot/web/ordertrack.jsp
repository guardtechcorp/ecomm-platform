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

//web.showAllParameters(request, out);
//CustomerWeb.dumpAllParameters(request);

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
<table cellspacing=2 cellpadding=2 width="100%" height="530" align="center"><tr><td valign="top">
<table width="100%" align="right" border="0">
  <TR>
    <TD height=20 align="center" colspan=9><b><font class='pagetitle'>Order Tracking</font></b></TD>
  </TR>
  <TR vAlign="middle" bgColor="#4959A7">
    <td width="5%" align="center" height=25><FONT color="#ffffff"><b><%=web.getLabelText(cfInfo, "no-col")%></b></FONT></td>
    <td width="12%" align="center" height=25><%=web.getSortNameLink("OrderNo", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "orderno-col"), true)%></td>
    <td width="11%" align="center" height=25><%=web.getSortNameLink("SubTotal", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "subtotal2-col"), true)%></td>
    <td width="10%" align="center" height=25><%=web.getSortNameLink("Tax", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "tax2-col"), true)%></td>
    <td width="10%" align="center" height=25><%=web.getSortNameLink("ShipFee", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "ship2-col"), true)%></td>
    <td width="12%" align="center" height=25><%=web.getSortNameLink("GrandTotal", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "total2-col"), true)%></td>
    <td width="20%" align="center" height=25><%=web.getSortNameLink("CreateDate", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "orderdate-col"), true)%></td>
    <td width="20%" align="center" height=25><%=web.getSortNameLink("ShipDate", web.encodedUrl("index.jsp?action=ordertracklist"), web.getLabelText(cfInfo, "shipdate-col"), true)%></td>
  </TR>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=9><%=web.getLabelText(cfInfo, "noorder-des")%></td>
  </tr>
<% } else {
  int nStartNo = Utilities.getInt(web.getCacheData(web.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     OrderInfo info = (OrderInfo)ltArray.get(i);
%>
  <tr bgColor="#f7f7f7">
    <td width="5%" align="center"><a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=(nStartNo+i)%></a></td>
    <td width="12%"><a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + "&type=2" + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=info.OrderNo%></a></td>
    <td width="11%" align="right"><a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getNumberFormat(info.SubTotal,'$',2)%></a></td>
    <td width="10%" align="right"><a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getNumberFormat(info.Tax,'$',2)%></a></td>
    <td width="10%" align="right"><a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getNumberFormat(info.ShipFee,'$',2)%></a></td>
    <td width="12%" align="right"><a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getNumberFormat(info.GrandTotal,'$',2)%></a></td>
    <td width="20%" align="center"><a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderid="+info.OrderID+"&orderno="+info.OrderNo+"&customerid="+ctInfo.CustomerID + '&'+ web.getDomainSidCGI())%>" target="_blank"><%=Utilities.getDateValue(info.CreateDate, 16)%></a></td>
    <td width="20%" align="center"><%=web.getShipmentTrack(info, false)%></td>
  </tr>
<%}%>
  <tr><td colspan=9 height=2><HR align="left" width="100%" color="#4279bd" noShade SIZE=1></td></tr>
  <tr>
    <td colspan=9 align="right"><%=web.encodedHrefLink(web.getCacheData(web.KEY_PAGELINKS))%></td>
  </tr>
<% } %>
</table>
</td></tr></table>
<% } %>