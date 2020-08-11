<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/order.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ShipOrderBean"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.OrderItemInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  ShipOrderBean bean = new ShipOrderBean(session, 10);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ORDER))
     return;

  DomainInfo dmInfo = bean.getDomainInfo();

  String sDisplayMessage = null;
  String sClass = "successful";
  String sAction = request.getParameter("action");
  Object[] objArray = null;
  if ("Export".equalsIgnoreCase(sAction))
  {
    bean.outputInvoice(request, response);
    return;
  }
  else if ("Finish Shipment".equalsIgnoreCase(sAction))
  {
    ShipOrderBean.Result ret = bean.shipment(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_SHIPMENT_SUCCESS, null);
      sAction = "Update Shipment";
      response.sendRedirect("shiporderlist.jsp?action=unshipped");
    }

    objArray = bean.get(request);
  }
  else if ("Update Shipment".equalsIgnoreCase(sAction))
  {//. Update shipment information
    objArray = bean.get(request);
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     objArray =  bean.getPrevOrNext(sAction);
     sAction = "Finish Shipment";
  }
  else
  {
    sAction = "Finish Shipment";
    objArray = bean.get(request);
  }

  OrderInfo orInfo = (OrderInfo)objArray[0];
  List ltOrderItem = (List)objArray[1];
  bean.saveOrderInfo(orInfo, ltOrderItem);

  String sHelpTag = "shiporder";
/*
  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");
  String sTitleLinks = "";
  if (sReturn!=null)
    sTitleLinks += "<a href=\"" + Utilities.replaceContent(sReturn, "|", "?action=", false) +"\">" + sDisplay + "</a> > ";
  sTitleLinks += "<b>The Order Invoice and Shipment</b>";
*/
  String sTitleLinks = bean.getNavigation(request, "The Order Invoice and Shipment");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<font size="2">From this form, you can fill shipping information to finish shipment.</font>
<p>
<table id="hidediv" width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="left" width="50%" height="20">
     <a class="hightlight" href="javascript:window.print();"><%=DisplayMessage.getLabelText("iso-8859-1", "print-des")%></a> |
     <a class="hightlight" href="shiporder.jsp?action=Export&filetype=pdf"><%=DisplayMessage.getLabelText("iso-8859-1", "exportpdf-des")%></a> |
     <a class="hightlight" href="shiporder.jsp?action=Export&filetype=rtf"><%=DisplayMessage.getLabelText("iso-8859-1", "exportrtf-des")%></a>
   </td>
    <!--td align="right">bean.getPrevNextLinks("shiporder.jsp?return="+sReturn+"&display="+sDisplay+"&")</td-->
    <td align="right"><%=bean.getPrevNextLinks("shiporder.jsp?")%></td>
  </tr>
</table>
<table cellpadding=2 border=0 cellspacing=1 align="center" width=98% bgcolor="#666666">
  <tr bgcolor="#ffffff">
    <td class=ten>Order Number: <b><%=orInfo.OrderNo%></b></td>
    <td class=ten>Order Date and Time: <b><%=Utilities.getDateValue(orInfo.CreateDate, 16)%></b></td>
  </tr>
  <tr bgcolor="#4279bd">
    <td class=WB10 align=center width=50%><b>Billing Information</b></td>
    <td class=WB10 align=center width=50%><b>Shipping Address</b></td>
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
    <br><br><%=bean.getNextShopCoupon(orInfo.Coupon)%>
    </td>
  </tr>
</table>
<br>
<table cellspacing=1 border=0 cellpadding=1 width=98% align="center" bgcolor="#666666">
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
    <table width="100%" cellspacing=1 border=0 cellpadding=0>
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
        <td width="22%" align="right">Ship Date:</td>
        <td width="78%"><%=Utilities.getDateValue(orInfo.ShipDate, 16)%></td>
      </tr>
    </table>
   </td>
   <td bgcolor="#ffffff" class="ten" colspan=2 align=right>Subtotal:</td>
   <td bgcolor="#ffffff" class="ten" align=right width="15%"><%=Utilities.getNumberFormat(orInfo.SubTotal,'$',2)%></td>
  </tr>
<% if (orInfo.Discount>0) { %>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right">Discount:</td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%">-<%=Utilities.getNumberFormat(orInfo.Discount,'$',2)%></td>
  </tr>
<% } %>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align="right">Tax:</td>
   <td bgcolor="#ffffff" class="ten" align=right width="15%"><%=Utilities.getNumberFormat(orInfo.Tax,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align=right>Shipping:</td>
   <td bgcolor="#ffffff" class="ten" align=right width="15%"><%=Utilities.getNumberFormat(orInfo.ShipFee,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor="#ffffff" class="ten" colspan=2 align=right>Grand Total:</td>
   <td bgcolor="#ffffff" class="ten" align=right width="15%"><b><%=Utilities.getNumberFormat(orInfo.GrandTotal,'$',2)%></b></td>
  </tr>
</table>
<br>
<form name="shiporder" action="shiporder.jsp"  method="post">
  <input type="hidden" name="orderid" value="<%=orInfo.OrderID%>">
  <input type="hidden" name="return" value="<%=request.getParameter("return")%>">
  <input type="hidden" name="display" value="<%=request.getParameter("display")%>">
  <table id="hidediv" border="0" cellpadding="1" cellspacing="1" width="98%" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="4" height="25" valign="middle" align="center">Payment Status and Shipping Information</th>
    </tr>
<% if (sDisplayMessage!=null) {%>
    <tr>
      <td class="row1" colspan="4" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="20%" align="right"><%=bean.getPayOption(orInfo.CreditType)%>: </td>
      <td class="row1" width="40%"><%=bean.getPayOptionInfo(orInfo)%>
      </td>
      <td class="row1" width="20%" align="right">Payment Status:</td>
      <td class="row1" width="20%">
      <select name="paystatus">
        <option value="Waiting" selected>Waiting</option>
        <option value="Pending">Pending</option>
        <option value="Completed">Completed</option>
      </select>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Shipper: </td>
      <td class="row1" width="40%">
      <select name="shipid_charge" onChange="onShipMethodChange(document.shiporder)">
        <%=bean.getShipMethodList(orInfo.ShipID)%>
      </select>
      </td>
      <td class="row1" width="20%" align="right">Ship Quantity:</td>
      <td class="row1" width="20%"><input type="text" name="shipqty" size="5" maxlength="10" value="<%=Utilities.getValue(orInfo.ShipQty)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
<!--input type="text" name="shipfee" size="5" maxlength="10" value="<%=Utilities.getValue(orInfo.ShipFee)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'-->
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Tracking No: </td>
      <td class="row1" width="40%"> <input type="text" name="trackno" size="30" maxlength="30" value="<%=Utilities.getValue(orInfo.TrackNo)%>"></td>
      <td class="row1" width="20%" align="right" height="2">Estimated Ship Weight: </td>
      <td class="row1" width="20%"><input type="text" name="shipweight" size="5" maxlength="10" value="<%=Utilities.getValue(orInfo.ShipWeight)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'> (lb)</td>
    </tr>
    <tr class="normal_row">
      <td width="20%" align="right">
       <select name="sendmail">
        <option value=1 selected>Yes</option>
        <option value=0>No</option>
       </select>
      </td>
      <td width="80%" colspan="3">Send a shipping notify email to <b><%=orInfo.EMail%></b>.</td>
    </tr>
    <tr>
      <td class="catBottom" colspan="4" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
  </table>
</form>
<SCRIPT>onShipOrderLoad(document.shiporder, "<%=Utilities.getValue(orInfo.PayStatus)%>");</SCRIPT>
<%@ include file="../share/footer.jsp"%>