<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.OrderBean"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.OrderItemInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
  OrderBean bean = new OrderBean(session, 10);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ORDER))
     return;

  DomainInfo dmInfo = bean.getDomainInfo();
  ConfigInfo cfInfo = bean.getConfigInfo();

  String sAction = request.getParameter("action");
  Object[] objArray = null;
  if ("Export".equalsIgnoreCase(sAction))
  {
    bean.outputInvoice(request, response);
    return;
  }
  else if ("View".equalsIgnoreCase(sAction))
  {
    objArray = bean.get(request);
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
    objArray =  bean.getPrevOrNext(sAction);
  }

//    Object[] objArray = bean.getOrderDetail(request);
  OrderInfo orInfo = (OrderInfo)objArray[0];
  List ltOrderItem = (List)objArray[1];
  bean.saveOrderInfo(orInfo, ltOrderItem);

  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  String sHelpTag = "order";
//  String sTitleLinks = "";
//  if (sReturn!=null)
//    sTitleLinks = "<a href=\"" + Utilities.replaceContent(sReturn, "|", "?action=", false) +"\">" + sDisplay + "</a> > ";
//   sTitleLinks += "<b>The Order Invoice</b>";
  String sTitleLinks = bean.getNavigation(request, "The Order Invoice");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this form, you can view the order detail and print or export it.
<table id="hidediv" width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td class="ten" align="left" width="50%" height="20">
     <a class="hightlight" href="javascript:window.print();"><%=DisplayMessage.getLabelText("iso-8859-1", "print-des")%></a> |
     <a class="hightlight" href="order.jsp?action=Export&filetype=pdf"><%=DisplayMessage.getLabelText("iso-8859-1", "exportpdf-des")%></a> |
     <a class="hightlight" href="order.jsp?action=Export&filetype=rtf"><%=DisplayMessage.getLabelText("iso-8859-1", "exportrtf-des")%></a>
   </td>
    <td align="right"><%=bean.getPrevNextLinks("order.jsp?return="+sReturn+"&display="+sDisplay+"&")%></td>
  </tr>
</table>
<table cellpadding=2 border=0 cellspacing=1 align="center" width=99% bgcolor="#666666">
  <tr bgcolor="#ffffff">
    <td class=ten>Order Number: <b><%=orInfo.OrderNo%></b></td>
    <td class=ten>Order Date and Time: <b><%=Utilities.getDateValue(orInfo.CreateDate, 16)%></b></td>
  </tr>
  <tr bgcolor="#4279bd">
    <td class="WB10" align=center width=50%><b>Billing Information</b></td>
    <td class="WB10" align=center width=50%><b>Shipping Address</b></td>
  </tr>
  <tr bgcolor="#ffffff">
    <td class=ten valign="top"><b><%=orInfo.Yourname%><br>
      <%=orInfo.Address%><br>
      <%=orInfo.City%>, <%=orInfo.State%> <%=orInfo.ZipCode%>, <%=orInfo.Country%></b><br>
      Email: <b><%=orInfo.EMail%></b><br>
      Phone: <b><%=orInfo.Phone%></b><br>
      <br><%=bean.getPaymentDesc(orInfo, false)%>
    </td>
    <td class=ten valign="top"><b><%=bean.getShipAddress(orInfo, true)%></b>
    <%=bean.getShipInfo(orInfo, false)%>
    <br><br><%=bean.getNextShopCoupon(orInfo.Coupon)%>
    </td>
  </tr>
</table>
<br>
<br>
<table cellspacing=1 border=0 cellpadding=1 width=98% align=center bgcolor=#666666>
  <tr bgcolor="#4279bd">
    <td class="WB10" width=50% align="center" bgcolor="#9999cc">Products</td>
    <td class="WB10" width=13% align="center" bgcolor="#9999cc">Code</td>
    <td class="WB10" width=8% align="center" bgcolor="#9999cc">Quantity</td>
    <td class="WB10" width=14% align="center" bgcolor="#9999cc">Unit Price</td>
    <td class="WB10" width=15% align="center" bgcolor="#9999cc">Total Price</td>
  </tr>
<%
  for (int i=0; i<ltOrderItem.size(); i++) {
    OrderItemInfo oiInfo = (OrderItemInfo)ltOrderItem.get(i);
%>
  <tr bgcolor="#eeeeee">
    <td class="ten" align="center" width="50%"><%=oiInfo.Name%></td>
    <td class="ten" align="center" width="13%"><%=oiInfo.Code%></td>
    <td class="ten" align="center" width="8%"><%=oiInfo.Quantity%></td>
    <td class="ten" align="right" width="14%"><%=Utilities.getNumberFormat(oiInfo.Price,'$',2)%></td>
    <td class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(oiInfo.Quantity*oiInfo.Price,'$',2)%></td>
  </tr>
<% } %>
  <tr bgcolor="#ffffff">
<% if (orInfo.Discount>0) { %>
   <td class="ten" colspan=2 rowspan=7>
<% } else { %>
   <td class="ten" colspan=2 rowspan=6>
<% } %>
    <table width="100%" border="0">
      <tr>
        <td colspan=2><%=bean.getIncentiveNote(orInfo.Note)%></td>
      </tr>
      <tr>
        <td width="22%" align="right">Order Comment:</td>
        <td width="78%"><%=Utilities.getValue(orInfo.Comment)%></td>
      </tr>
      <tr>
        <td width="22%" height="5" align="right">Ship Method:</td>
        <td width="78%" height="5"><%=Utilities.getValue(orInfo.Description)%></td>
      </tr>
      <tr>
        <td width="22%" align="right">Ship Tracking No:</td>
        <td width="78%"><%=bean.getShipmentTrack(orInfo, true)%></td>
      </tr>
    </table>
   </td>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right">Subtotal:</td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(orInfo.SubTotal,'$',2)%></td>
  </tr>
<% if (orInfo.Discount>0) { %>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right">Discount:</td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%">-<%=Utilities.getNumberFormat(orInfo.Discount,'$',2)%></td>
  </tr>
<% } %>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right">Tax:</td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(orInfo.Tax,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right">Shipping:</td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(orInfo.ShipFee,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right">Grand Total:</td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><b><%=Utilities.getNumberFormat(orInfo.GrandTotal,'$',2)%></b></td>
  </tr>
</table>
<br>
<table cellspacing=0 cellpadding=0 border=0 width=98% align="center">
  <tr><td>
    <%=bean.getTestInfo(dmInfo, cfInfo)%>
 </td></tr>
</table>
<%@ include file="../share/footer.jsp"%>

