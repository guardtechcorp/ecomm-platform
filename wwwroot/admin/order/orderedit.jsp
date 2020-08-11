<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/order.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.OrderBean"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%
  OrderBean bean = new OrderBean(session, 20);
  OrderInfo orInfo = null;// bean.get(request);

  if (orInfo==null)
  {
    orInfo = OrderInfo.getInstance(true);
  }

  String sTitleLinks = bean.getNavigation(request, "Edit the Order");
%>
<h3>The order form of the customer</h3>
<p>From this panel you can edit this order.</p>
<form name="orderedit" action="#"  method="post">
  <input type="hidden" name="orderid" value="<%=orInfo.OrderID%>">
  <table cellpadding=2 border=1 cellspacing=0 align=center width=95%>
    <tr>
      <td class=ten colspan=2 align=center>Thank You For Your Order.</td>
    </tr>
    <tr>
      <td class=ten>Order Number: <%=orInfo.OrderNo%></td>
      <td class=ten>Order Date: <%=orInfo.CreateDate%></td>
    </tr>
    <tr bgcolor=lightblue>
      <td class=ten align=center width=50%><b>Billing Information</b></td>
      <td class=ten align=center width=50%><b>Shipping Address</b></td>
    </tr>
    <tr>
      <td class=ten>&nbsp;<%=orInfo.Yourname%><br>
        &nbsp;714 Vine Ave<br>
        &nbsp;anaheim hills CA 92807<br>
        &nbsp;<br>
        &nbsp;7140000000<br>
        &nbsp;nzhao@watercalc.com<br>
        &nbsp;<br>
        &nbsp;Payment Method: credit card - visa<br>
        &nbsp;Credit Card: <a href="javascript: var numberwindow=window.open('https://secure.box88.com/.sc/as/zyzit.aacart.com/cn/11551', 'number', 'width=300,height=150,status'); numberwindow.focus();">7890XXXXXXXXXXXX</a><br>
        &nbsp;Expiration: 03/07<br>
        &nbsp;<br>
        &nbsp;Order Comments: <br>
        &nbsp;</td>
      <td class=ten>&nbsp;Neil Zhang<br>
        &nbsp;714 Vine Ave<br>
        &nbsp;anaheim hills CA 92807<br>
        &nbsp;<br>
        &nbsp;7140000000</td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table cellspacing=0 border=1 cellpadding=1 width=95% align=center>
    <tr bgcolor=lightblue>
      <td class=ten width=42% align=center>Products</td>
      <td class=ten width=7% align=center>PN</td>
      <td class=ten width=13% align=center>Availability</td>
      <td class=ten width=10% align=center>Quantity</td>
      <td class=ten width=14%  align=center>Unit Price</td>
      <td class=ten width=14%  align=center>Total Price</td>
    </tr>
    <tr bgcolor=yellow>
      <td class=ten align=center>
        <input type=text name=pname0 size=45 maxlength=8000 value="Product1">
      </td>
      <td class=eight align=center>abcid</td>
      <td class=eight align=center>In Stock</td>
      <td class=eight align=center>
        <input type=text size=5 maxlength=5 name=item0 value="1" onChange="cal()">
      </td>
      <td class=eight align=right>
        <input type=text size=8 maxlength=8 name=item1 value="24.79" onChange="cal()">
      </td>
      <td class=eight align=right>
        <input type=text size=8 maxlength=8 name=item2 value="24.79" READONLY onFocus="if (!document.all && !document.getElementById) this.blur()" style="background-color: #c0c0c0">
      </td>
    </tr>
    <tr>
      <td colspan=3 rowspan=6>&nbsp;</td>
      <td class=ten colspan=2 align=right>Subtotal:</td>
      <td class=eight align=right>
        <input type=text size=8 maxlength=8 name=subtotal value="<%=orInfo.SubTotal%>" READONLY onFocus="if (!document.all && !document.getElementById) this.blur()" style="background-color: #c0c0c0">
      </td>
    </tr>
    <tr>
    <td class=ten colspan=2 align=right>Discount:</td>
    <td class=eight align=right>
      <input type=text size=8 maxlength=8 name=discount value="0" onChange="cal2()">
    </td>
    </tr>
    <tr>
    <td class=ten colspan=2 align=right>2 Day Air Shipping:</td>
    <td class=eight align=right>
      <input type=text size=8 maxlength=8 name=ShipFee value="<%=orInfo.ShipFee%>" onChange="cal2()">
    </td>
    </tr>
    <tr>
    <td class=ten colspan=2 align=right>Tax:</td>
    <td class=eight align=right>
      <input type=text size=8 maxlength=8 name=tax value="<%=orInfo.Tax%>" onChange="cal2()">
    </td>
    </tr>
    <tr>
    <td class=ten colspan=2 align=right>Grand Total:</td>
    <td class=eight align=right>
      <input type=text size=8 maxlength=8 name=grandtotal value="<%=orInfo.GrandTotal%>" READONLY onFocus="if (!document.all && !document.getElementById) this.blur()" style="background-color: #c0c0c0">
    </td>
    </tr>
  </table>
  <p>&nbsp;</p>
  <table border=0 cellspacing=0 cellpadding=0 width=95%>
    <tr>
      <td align=center width=50%>Payment Method:&nbsp;
        <input type=text name=payment size=26 maxlength=100 value="check">
        <br>
        <select name=emailmod>
          <option value=f>Do Not Email Customer Regarding Order Modification
          <option value=t>Email Customer Regarding Order Modification
        </select>
        <br>
        <input type=submit value="Update and Save This Order" name="submit">
      <td align=center width=50%>
        <input type=hidden name=emailmod value=f>
        <input type=hidden name=invoicenumber value=11552>
        <input type=hidden name=incomplete value="yes">
        <select name=voidreason>
          <option value=others>Reason For Void
          <option value="CC Declined">CC Declined
          <option value="Expired CC">Expired CC
          <option value="No match - mailing address and billing address">No match
          - mailing address and billing address
          <option value="Bad Location">Bad Location
          <option value=others>Type In Reason In Box Below
        </select>
        <br>
        <input type=text name=otherreason size=36 maxlength=100>
        <br>
        <input type=submit value="Void This Order" name="submit">
  </table>
  </form>
