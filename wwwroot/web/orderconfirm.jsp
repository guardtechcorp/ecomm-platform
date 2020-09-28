<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.model.ShopCartInfo"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  ShopCartWeb shopcart = new ShopCartWeb(session, request, 100);
  DomainInfo dmInfo = shopcart.getDomainInfo();
  ConfigInfo cfInfo = shopcart.getConfigInfo();

//shopcart.showAllParameters(request, out);
  String sAction = shopcart.getRealAction(request);
  String sDisplayMessage = null;
//  if ("Order By Credit Card".equalsIgnoreCase(sAction)||"Order By Check".equalsIgnoreCase(sAction)||"Monthly Charge".equalsIgnoreCase(sAction))
  if ("Order By Check".equalsIgnoreCase(sAction)||"Monthly Charge".equalsIgnoreCase(sAction))
  {
/*Neil00
    int nPayType = ShopCartWeb.PAYTYPE_OFFLINE;
    if ("Order By Check".equalsIgnoreCase(sAction))
       nPayType = ShopCartWeb.PAYTYPE_CHECK;
    else if ("Monthly Charge".equalsIgnoreCase(sAction))
       nPayType = ShopCartWeb.PAYTYPE_MONTHLYCHARGE;
    else
    {
       if (request.getParameter("x_version")!=null)
          nPayType = ShopCartWeb.PAYTYPE_AUTHORIZE;
    }
    ShopCartWeb.Result ret = shopcart.processOrder(request, nPayType);
*/
    BasicBean.Result ret = BasicBean.getRequestResult(session);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
    }
/*Neil00
    else
    {//. Remove Go to invoice page
      response.sendRedirect("invoice.jsp");
    }
*/
  }
  else if ("orderconfirm".equalsIgnoreCase(sAction))
  {
/*
   03/28/06-06:46:55^1001^59424803^www.bevigour.com^orderconfirm
   PayPal Notify-------------------
   03/28/06-06:46:55^1001^59424787^www.bevigour.com^ken.mccurry@worleyparsons.com make a order (1059424804) from unknown, 209.16.63.35
   03/28/06-06:46:56^1002^59424787^www.bevigour.com^A email is send to ken.mccurry@worleyparsons.com
   03/28/06-06:47:01^1002^59424807^www.bevigour.com^A Visitor '1059424806' is login from 204.15.5.45, 192.168.0.2, 193.251.135.118 with total=1
   03/28/06-06:47:01^1001^59424807^www.bevigour.com^webpageload
   03/28/06-06:47:02^1001^59424803^www.bevigour.com^orderconfirm
   PayPal Return----------------------
   03/28/06-06:47:02^1001^59424803^www.bevigour.com^Paypal Return: www.bevigour.com,59424803
*/

   String sType = request.getParameter("type");
   if ("paypalnotify".equalsIgnoreCase(sType))
   {
//System.out.println("PayPal Notify-------------------");
//System.out.println("QueryString=" + request.getQueryString());
//shopcart.dumpAllParameters(request);
//      ShopCartWeb.Result ret = shopcart.paypalNotify(request);
//      return;// Just return to server side.
   }
   else if ("paypalreturn".equalsIgnoreCase(sType))
   {
//System.out.println("PayPal Return----------------------");
//System.out.println("QueryString=" + request.getQueryString());
//shopcart.dumpAllParameters(request);
//     ShopCartWeb.Result ret = shopcart.paypalReturn(request);
     BasicBean.Result ret = BasicBean.getRequestResult(session);
     if (!ret.isSuccess())
     {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
     }
/*Neil00
     else
     {//. Go to invoice page
       response.sendRedirect("invoice.jsp");
     }
*/
   }
   else if ("paypalcancel".equalsIgnoreCase(sType))
   {
//shopcart.showAllParameters(request, out);
//System.out.println("PayPal Cancel");
//System.out.println("QueryString=" + request.getQueryString());
//     ShopCartWeb.Result ret = shopcart.paypalCancel(request);
     BasicBean.Result ret = BasicBean.getRequestResult(session);
     sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_PAYPAL_CANCEL, null);
   }
   else if ("itransact".equalsIgnoreCase(sType))
   {
//System.out.println("It is coming from iTransact.");
//shopcart.showAllParameters(request, out);
//System.out.println("QueryString=" + request.getQueryString());
//    ShopCartWeb.Result ret = shopcart.iTransactReturn(request);
     BasicBean.Result ret = BasicBean.getRequestResult(session);
     if (!ret.isSuccess())
     {
        Errors errObj = (Errors)ret.getInfoObject();
        sDisplayMessage = errObj.getError();
     }
/*Neil00
    else
    {//. Go to invoice page
      response.sendRedirect("invoice.jsp");
    }
*/
   }
 }

//shopcart.showAllParameters(request, out);
  List ltShopCart = shopcart.getShopItemList(request, response);
  CustomerWeb bean = new CustomerWeb(session, request, 10);
  CustomerInfo ctInfo = bean.getInfo(request);
  shopcart.calculateTax(ctInfo);

//Utilities.dumpObject(ctInfo);
  String sMemberConditionPrice = "";
  if (!shopcart.isReachCondition())
  {
    sMemberConditionPrice = Utilities.getNumberFormat(shopcart.getMemberCondtionPrice(), '$', 2);
  }
%>
<div class="checkoutWrap">
<div class="breadcrumbWrap">
  <a href="<%=shopcart.getContinueShop()%>"><%=shopcart.getLabelText(cfInfo, "shopping-link")%></a> &gt; <a href="<%=shopcart.encodedUrl("index.jsp?action=shopcart")%>"><%=shopcart.getLabelText(cfInfo, "cart-link")%> </a> &gt;
   <font color="#FF0000"><%=shopcart.getLabelText(cfInfo, "confirm-link")%> </font> &gt; <%=shopcart.getLabelText(cfInfo, "bill-link")%> &gt; <%=shopcart.getLabelText(cfInfo, "finish-link")%>
</div>
<table cellspacing=0 cellpadding=0 width="99%" height="230" align="right" bgcolor="<%=cfInfo.BackColor%>">
<tr>
 <td valign="top">
 <TABLE class="table-1 acctInfoTable" width="100%" align="right" border=0>
   <thead>
  <tr vAlign="middle">
    <th align="center" width="50%" bgcolor="#4279bd"><font color="#FFFFFF"><%=shopcart.getLabelText(cfInfo, "billing-lab")%></font></th>
    <th align="center" width="50%" bgcolor="#4279bd"><font color="#FFFFFF"><%=shopcart.getLabelText(cfInfo, "shipaddress-lab")%></font></th>
  </tr>
</thead>
  <% if (sDisplayMessage!=null) { %>
    <TR>
      <TD height=20 colspan="2" align="center"><b><span class="failed"><%=sDisplayMessage%></span></b></TD>
    </TR>
  <% } %>
  <tr vAlign="top">
    <td bgcolor="#f7f7f7">
      <table cellSpacing=0 cellPadding=0 width="100%" border=0>
        <tr>
          <td valign="top">
          <%=bean.getShipAddress(ctInfo, false)%>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
    <td bgcolor="#f7f7f7">
      <table cellSpacing=0 cellPadding=0 width="100%" border=0>
        <tr>
          <td><%=bean.getShipAddress(ctInfo, true)%></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr vAlign="middle">
    <td align="center" colspan="2" bgcolor="#f7f7f7" valign="top" height="15" class="editBillBtn"><a href="<%=shopcart.encodedUrl("index.jsp?action=editaccount")%>"><%=shopcart.getLabelText(cfInfo, "billship-des")%></a></td>
  </tr>
 </table>
 </td>
</tr>
<% if (ltShopCart==null||ltShopCart.size()==0) {%>
<tr>
  <td align="center"><h3 class="emptyCart">Your cart is currently empty</h3><!-- <IMG src="/staticfile/web/images/<%=cfInfo.Language%>/cart-empty.gif"> --></td>
</tr>
<% } else {%>
<tr>
  <td align="center" height="20" valign="bottom" class="verifyBillAlert"><%=shopcart.getLabelText(cfInfo, "billship2-des")%></td>
</tr>
<tr>
 <td>
 <FORM name="orderconfirm" action="index.jsp" method="post">
  <table width="100%" align="right" border=0 class="orderTable">
    <thead>
    <tr vAlign="middle">
      <th width="62%" height=20 align="center"><%=shopcart.getLabelText(cfInfo, "item-col")%></th>
      <th width="10%" height=20 align="center"><%=shopcart.getLabelText(cfInfo, "quantity-col")%></th>
      <th width="14%" height=20 align="center"><%=shopcart.getLabelText(cfInfo, "price-col")%></th>
      <th width="14%" height=20 align="center"><%=shopcart.getLabelText(cfInfo, "total-col")%></th>
    </tr>
  </thead>
<%
   for (int i=0; i<ltShopCart.size(); i++) {
     ShopCartInfo scInfo = (ShopCartInfo) ltShopCart.get(i);
%>
    <tr vAlign="middle" bgColor="#f7f7f7" class="lineItm">
      <!--TD width="62%"><A href="index.jsp?action=productdetail&productid=<%=scInfo.ProductID%>"><%=scInfo.Name%></a></TD-->
      <td width="62%" class="cartProdName"><%=scInfo.Name%></td>
      <td width="10%" class="quantityCell">
        <label>Qty</label>
        <%=scInfo.Quantity%></td>
      <td width="14%" class="unitPriceCell">
        <label>Unit Price</label>
        <%=Utilities.getNumberFormat(shopcart.getPrice(scInfo),'$',2)%></td>
      <td width="14%" class="totalPriceCell">
        <label>Qty Price</label>
        <%=Utilities.getNumberFormat(shopcart.getPrice(scInfo)*scInfo.Quantity,'$',2)%></td>
    </tr>
<% } %>
    <TR vAlign="middle" bgColor="#f7f7f7" class="commentRow zipShipRow">
<% if (shopcart.hasDiscount()&&!shopcart.isMember()) {%>
     <TD height=46 colspan="2" rowspan="5">
<% } else { %>
     <TD height=46 colspan="2" rowspan="4">
<% } %>
      <table width="100%" border="0">
        <tr>
          <td><font color="#CC6600"><%=shopcart.getShippingNote()%></font></td>
        </tr>
<% if ("www.test101.wlmg.net".equalsIgnoreCase(dmInfo.DomainName) || "www.hepahealth.com".equalsIgnoreCase(dmInfo.DomainName)) { %>
        <tr>
          <td height=5></td>
        </tr>
        <tr>
          <td>Reordering type:
    <SELECT name="recursive_order">
    <OPTION value="0" selected>Order only for this time</OPTION>
    <OPTION value="3">Recurring order in three months</OPTION>
    <OPTION value="6">Recurring order in six months</OPTION>
    <OPTION value="9">Recurring order in nine months</OPTION>
    <OPTION value="12">Recurring order in one year.</OPTION>
    <OPTION value="100">Continual Recurring Order until Call to Stop.</OPTION>
    </SELECT>
         </td>
        </tr>
        <tr>
          <td>&nbsp;Order started in <input style="WIDTH:80px" maxlength=10 name="recusive_date" value="" onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'>
    &nbsp;&nbsp;&nbsp;Ship orders every
    <SELECT name="recursive_days">
    <OPTION value="25">25</OPTION>
    <OPTION value="26">26</OPTION>
    <OPTION value="27">27</OPTION>
    <OPTION value="28">28</OPTION>
    <OPTION value="29">29</OPTION>
    <OPTION value="20" selected>30</OPTION>
    </SELECT> days.
         </td>
        </tr>
        <tr>
          <td height=5></td>
        </tr>
<% } %>
        <tr>
          <td><%=shopcart.getLabelText(cfInfo, "ordercomment-lab")%></td>
        </tr>
        <tr>
          <td><textarea rows="3" wrap="virtual" name="comment"></textarea></td>
        </tr>
      </table>
    </TD>
    <TD width="14%" align="right"><%=shopcart.getLabelText(cfInfo, "subtotal-col")%></TD>
    <TD width="14%" align="right"><%=Utilities.getNumberFormat(shopcart.getSummary(1),'$',2)%></TD>
   </TR>
<% if (shopcart.hasDiscount()&&!shopcart.isMember()) {%>
    <TR vAlign="middle" bgColor="#f7f7f7" class="discountRow">
      <TD width="14%" align="right"><%=shopcart.getLabelText(cfInfo, "discount-col")%></TD>
      <TD width="14%" align="right">-<%=Utilities.getNumberFormat(shopcart.getSummary(5),'$',2)%></TD>
    </TR>
<% } %>
    <TR vAlign="middle" bgColor="#f7f7f7" class="taxRow">
      <TD width="14%" align="right"><%=shopcart.getLabelText(cfInfo, "tax-col")%></TD>
      <TD width="14%" align="right"><%=Utilities.getNumberFormat(shopcart.getSummary(2),'$',2)%></TD>
    </TR>
    <TR vAlign="middle" bgColor="#f7f7f7" class="shipCostRow">
      <TD width="14%" align="right"><%=shopcart.getLabelText(cfInfo, "ship-col")%></TD>
      <TD width="14%" align="right"><%=Utilities.getNumberFormat(shopcart.getSummary(3),'$',2)%></TD>
    </TR>
    <TR vAlign="middle" bgColor="#f7f7f7" class="gTotalRow">
      <!--TD height=10 colspan="2" align="center">&nbsp; &nbsp; &nbsp;</TD-->
      <TD width="14%" align="right"><%=shopcart.getLabelText(cfInfo, "grant-col")%></TD>
      <TD width="14%" align="right"><b><%=Utilities.getNumberFormat(shopcart.getSummary(4),'$',2)%></b></TD>
    </TR>
 </table>
 </FORM>
 </td>
</tr>
<tr>
  <td colSpan=4 height="25" valign="bottom"><font size="2" face="Verdana, Arial, Helvetica, sans-serif"><%=shopcart.getLabelText(cfInfo, "payoption-des")%></font>
   <HR align="left" width="100%" color="#4279bd" noShade SIZE=1>
  </td>
</tr>
<% if (shopcart.isPayOptionOn("creditcard")) {%>
<tr class="cardRow">
 <td>
  <FORM name="creditcard" action="<%=shopcart.encodedUrl("index.jsp")%>" method="post" onSubmit="return validatePayByCreditCard(document.orderconfirm, document.creditcard, '<%=sMemberConditionPrice%>');">
  <input type="hidden" name="preorderno" value="<%=shopcart.getPreOrderNo()%>">
  <input type="hidden" name="custom" value="">
  <input type="hidden" name="action1" value="">
  <table width="100%" align="right" border=0>
  <TR vAlign="middle">
   <TD width="73%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
     <%=shopcart.getLabelText(cfInfo, "creditcard-des")%></font>
   </TD>
   <TD width="27%" align="right"><input type="submit" value="<%=shopcart.getLabelText(cfInfo, "orderbycard-but")%>" name="orderbycard" onClick="setAction(document.creditcard, 'Order By Credit Card');" style="WIDTH:190px;HEIGHT:28px"></TD>
  </TR>
  </table>
  </FORM>
 </td>
</tr>
<% } %>
<% if (shopcart.isPayOptionOn("paypal", ctInfo)) {%>
<tr class="paypalRow">
 <td>
  <form name="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" onSubmit="return validatePayPal(document.orderconfirm, document.paypal, '<%=sMemberConditionPrice%>');">
  <input type="hidden" name="charset" value="utf8">
  <input type="hidden" name="cmd" value="_ext-enter">
  <input type="hidden" name="redirect_cmd" value="_xclick">
  <input type="hidden" name="first_name" value="<%=shopcart.getPatialName(ctInfo.Yourname, 1)%>">
  <input type="hidden" name="last_name" value="<%=shopcart.getPatialName(ctInfo.Yourname, 2)%>">
  <input type="hidden" name="address1" value="<%=ctInfo.Address%>">
  <input type="hidden" name="city" value="<%=ctInfo.City%>">
  <input type="hidden" name="state" value="<%=ctInfo.State%>">
  <input type="hidden" name="zip" value="<%=ctInfo.ZipCode%>">
  <!--input type="hidden" name="country" value="<%=ctInfo.Country%>"-->
  <input type="hidden" name="business" value="<%=Utilities.getValue(shopcart.getPaymentInfo("paypal").Options)%>">
  <input type="hidden" name="item_name" value="The Shopping Item(s)">
  <input type="hidden" name="item_number" value="<%=shopcart.getShopCartId(request, response)%>">
  <!--input type="hidden" name="quantity" value="1"-->
  <input type="hidden" name="amount" value="<%=Utilities.getNumberFormat(shopcart.getSummary(4), 'd', 2)%>">
  <!--input type="hidden" name="tax" value="<%=shopcart.getSummary(2)%>"-->
  <!--input type="hidden" name="shipping" value="<%=shopcart.getSummary(3)%>"-->
  <input type="hidden" name="invoice" value="<%=shopcart.getPreOrderNo()%>">
  <input type="hidden" name="custom" value="">
  <input type="hidden" name="rm" value="2">
  <input type="hidden" name="no_note" value="1">
  <input type="hidden" name="no_shipping" value="1">
  <input type="hidden" name="notify_url" value="<%=shopcart.getCallbackUrl("paypalnotify")%>">
  <input type="hidden" name="return" value="<%=shopcart.getCallbackUrl("paypalreturn")%>">
  <input type="hidden" name="cancel_return" value="<%=shopcart.getCallbackUrl("paypalcancel")%>">
  <table width="100%" align="right" border="0">
  <TR>
    <td width="73%">
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
        <%=shopcart.getLabelText(cfInfo, "paypal-des")%></font>
      </td>
      <td width="27%" align="right">
      <input type="image" name="submit" src="/staticfile/web/images/x-click-but01.gif" alt="<%=shopcart.getLabelText(cfInfo, "paypal-alt")%>" width="62" height="31" border="0">
      <br>
      <input type="image" name="submit" src="/staticfile/web/images/paypal_cards.gif" alt="<%=shopcart.getLabelText(cfInfo, "paypal-alt")%>" border="0" >
    </td>
  </TR>
 </table>
 </form>
 </td>
</tr>
<% } %>
<% if (shopcart.isPayOptionOn("check", ctInfo)) {%>
<tr class="checkRow">
 <td>
<FORM name="check" action="index.jsp" method="post" onClick="return validatePayCheck(document.orderconfirm, document.check, '<%=sMemberConditionPrice%>');">
<input type="hidden" name="preorderno" value="<%=shopcart.getPreOrderNo()%>">
<input type="hidden" name="custom" value="">
<input type="hidden" name="action1" value="">
  <table width="100%" align="right" border=0>
  <TR vAlign="middle">
   <TD width="73%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
     <%=shopcart.getLabelText(cfInfo, "check-des")%></font>
   </TD>
    <TD width="27%" align="right"><input type="submit" value="<%=shopcart.getLabelText(cfInfo, "orderbycheck-but")%>" name="orderbycheck" onClick="setAction(document.check, 'Order By Check');" style="WIDTH:190px;HEIGHT:28px"></TD>
  </TR>
  </table>
</FORM>
 </td>
</tr>
<% } %>
<% if (shopcart.isPayOptionOn("monthlycharge", ctInfo)) {%>
<tr class="monthlyRow">
 <td>
<FORM name="monthlycharge" action="index.jsp" method="post" onClick="return validateMonthlyCharge(document.orderconfirm, document.monthlycharge, '<%=sMemberConditionPrice%>');">
<input type="hidden" name="preorderno" value="<%=shopcart.getPreOrderNo()%>">
<input type="hidden" name="custom" value="">
<input type="hidden" name="action1" value="">
  <table width="100%" align="right" border=0>
  <TR vAlign="middle">
   <TD width="73%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
     <%=shopcart.getLabelText(cfInfo, "monthlycharge-des")%></font>
   </TD>
    <TD width="27%" align="right"><input type="submit" value="<%=shopcart.getLabelText(cfInfo, "monthlycharge-but")%>" name="monthlycharge" onClick="setAction(document.monthlycharge, 'Monthly Charge');" style="WIDTH:144px;HEIGHT:25px"></TD>
  </TR>
  </table>
</FORM>
 </td>
</tr>
<% } %>
<% if (shopcart.isPayOptionOn("itransact", ctInfo)) {%>
<tr class="itransactRow">
 <td>
  <form name="itransact" method="POST" action="https://secure.itransact.com/cgi-bin/buynow/buynow.cgi" onSubmit="return validateiTransact(document.orderconfirm, document.itransact, '<%=sMemberConditionPrice%>');">
      <input type="hidden" name="mername" value="Shopping Items to Check out at <%=bean.getDomainName()%>">
      <input type="hidden" name="home_page" value="http://<%=bean.getDomainName()%>">
      <input type="hidden" name="ret_addr"  value="<%=shopcart.getCallbackUrl("itransact")%>">
      <input type="hidden" name="ret_mode" value="post">
      <!--input type="hidden" name="post_back_on_error" value="1"-->
      <!--INPUT NAME="cvv2_number" SIZE=5-->
      <!--INPUT type=checkbox NAME="cvv2_illegible" value="1"-->
      <input type="hidden" name="vendor_id" value="<%=Utilities.getValue(shopcart.getPaymentInfo("itransact").Options)%>">
      <input type='hidden' name='showaddr' value='0'>
      <input type="hidden" name="showcvv" value="1">
      <input type="hidden" name="acceptcards" value="1">
      <input type="hidden" name="visaimage" value="1">
      <input type="hidden" name="mcimage" value="1">
      <input type="hidden" name="ameximage" value="1">
      <input type="hidden" name="discimage" value="1">
      <input type="hidden" name="acceptchecks" value="1">
      <input type="hidden" name="1-cost" value="<%=Utilities.getNumberFormat(shopcart.getSummary(4), 'd', 2)%>">
      <input type="hidden" name="1-desc" value="The Shopping Item(s)">
      <input type="hidden" name="1-qty" value="1">
      <input type="hidden" name="email_text" value="Thank you for shopping with us today.">
      <!--input type="hidden" name="confemail" value="1"-->
      <!--input type="hidden" name="lookup" value="first_name"-->
      <input type="hidden" name="first_name" value="<%=shopcart.getPatialName(ctInfo.Yourname, 1)%>">
      <!--input type="hidden" name="lookup" value="last_name"-->
      <input type="hidden" name="last_name" value="<%=shopcart.getPatialName(ctInfo.Yourname, 2)%>">
      <!--input type="hidden" name="lookup" value="address"-->
      <input type="hidden" name="address" value="<%=ctInfo.Address%>">
      <!--input type="hidden" name="lookup" value="city"-->
      <input type="hidden" name="city" value="<%=ctInfo.City%>">
      <!--input type="hidden" name="lookup" value="state"-->
      <input type="hidden" name="state" value="<%=ctInfo.State%>">
      <!--input type="hidden" name="lookup" value="zip"-->
      <input type="hidden" name="zip" value="<%=ctInfo.ZipCode%>">
      <!--input type="hidden" name="lookup" value="country"-->
      <input type="hidden" name="country" value="<%=ctInfo.Country%>">
      <!--input type="hidden" name="lookup" value="phone"-->
      <input type="hidden" name="phone" value="<%=ctInfo.Phone%>">
      <!--input type="hidden" name="lookup" value="email"-->
      <input type="hidden" name="email" value="<%=ctInfo.EMail%>">
      <input type="hidden" name="lookup" value="authcode">
      <input type="hidden" name="lookup" value="xid">
      <input type="hidden" name="lookup" value="cc_last_four">
      <input type="hidden" name="lookup" value="total">
      <input type="hidden" name="lookup" value="when">
      <input type="hidden" name="lookup" value="ck_last_four">
      <input type="hidden" name="lookup" value="cc_name">
      <input type="hidden" name="lookup" value="test_mode">
      <input type="hidden" name="lookup" value="avs_response">
      <input type="hidden" name="lookup" value="cvv2_response">

      <input type="hidden" name="passback" value="preorderno">
      <input type="hidden" name="preorderno" value="<%=shopcart.getPreOrderNo()%>">
      <input type="hidden" name="passback" value="custom">
      <input type="hidden" name="custom" value="">
  <table width="100%" align="right" border="0">
  <TR>
    <td width="73%">
      <p><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
        Pay by Credit Cards or Checks -- You can pay securely using your credit card or personal or business check to complete this purchase in real time.</font>
      </td>
      <td width="27%" align="right"><input type="submit" value="Order By Credit Card" name="action" style="WIDTH:144px;HEIGHT:25px">
      <br>
      <input type="image" border="0" name="submit" src="/staticfile/web/images/paypal_cards.gif" alt="Make payments with your credit cards - it's fast, free and secure!">
    </td>
  </TR>
 </table>
 </form>
 </td>
</tr>
<% } %>
<% if (shopcart.isPayOptionOn("authorize", ctInfo)) {%>
<tr class="authorizeRow">
 <td>
  <FORM name="authorize" action="index.jsp" method="post" onSubmit="return validatePayByCreditCard(document.orderconfirm, this, '<%=sMemberConditionPrice%>');">
      <input type="hidden" name="preorderno" value="<%=shopcart.getPreOrderNo()%>">
      <input type="hidden" name="custom" value="">
      <input type='hidden' name='x_version' value='3.1'>
      <input type="hidden" name="x_delim_data" value="True">
      <input type="hidden" name="x_delim_char" value=";">
      <input type="hidden" name="x_relay_response" value="False">
      <input type="hidden" name="x_login" value="<%=Utilities.getValue(shopcart.getPartofOptions("authorize", 0))%>">
      <input type="hidden" name="x_tran_key" value="<%=Utilities.getValue(shopcart.getPartofOptions("authorize", 1))%>">
      <input type="hidden" name="x_text_request" value="True">
      <input type="hidden" name="x_amount" value="<%=Utilities.getNumberFormat(shopcart.getSummary(4), 'd', 2)%>">
      <input type="hidden" name="x_card_num" value="<%=ctInfo.CreditNo%>">
      <input type="hidden" name="x_card_code" value="<%=ctInfo.CSid%>">
      <input type="hidden" name="x_exp_date" value="<%=ctInfo.ExpiredMonth%>/<%=ctInfo.ExpiredYear%>">
      <input type="hidden" name="x_method" value="CC">
      <!--input type="hidden" name="x_type" value="AUTH_CAPTURE"-->
      <input type="hidden" name="x_first_name" value="<%=shopcart.getPatialName(ctInfo.Yourname, 1)%>">
      <input type="hidden" name="x_last_name" value="<%=shopcart.getPatialName(ctInfo.Yourname, 2)%>">
      <input type="hidden" name="x_address" value="<%=ctInfo.Address%>">
      <input type="hidden" name="x_city" value="<%=ctInfo.City%>">
      <input type="hidden" name="x_state" value="<%=ctInfo.State%>">
      <input type="hidden" name="x_zip" value="<%=ctInfo.ZipCode%>">
      <input type="hidden" name="x_country" value="<%=ctInfo.Country%>">
      <input type="hidden" name="x_phone" value="<%=ctInfo.Phone%>">
      <input type="hidden" name="x_cust_id" value="<%=ctInfo.CustomerID%>">
      <input type="hidden" name="x_customer_ip" value="<%=shopcart.getCustomerIp()%>">
      <input type="hidden" name="x_email" value="<%=ctInfo.EMail%>">
      <input type="hidden" name="x_email_customer" value="True">
      <input type="hidden" name="x_footer_email_receipt" value="Thank you for ordering the above product(s).">
      <input type="hidden" name="x_merchant_email" value="<%=Utilities.getValue(shopcart.getCompanyEmail(null))%>">
      <input type="hidden" name="x_invoice_num" value="<%=shopcart.getPreOrderNo()%>">
  <table width="100%" align="right" border=0>
  <TR vAlign="middle">
   <TD width="73%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
     Pay by your credit card -- You have to provide your credit card information. Please
     <a href="javascript:toggleShow('DM_CREDITCARD');">VIEW</a> or <a href="<%=shopcart.encodedUrl("index.jsp?action=editbillinginfo")%>">EDIT</a> it to make sure it is correct.</font>
   </TD>
   <TD width="27%" align="right"><input type="submit" value="Order By Credit Card" name="action" style="WIDTH:144px;HEIGHT:25px"></TD>
  </TR>
  </table>
  </FORM>
 </td>
</tr>
<tr>
  <td colspan="2"><DIV id="DM_CREDITCARD" style="display: none">
  <table class="table-1 ccInfoTable" width="73%" align="left" border=0>
  <tr>
    <td>
      <label>Name on Credit Card</label>
      <b><%=Utilities.getValue(ctInfo.CreditName)%></b></td>
  </tr>
  <tr>
    <td>
      <label>Credit Card Type</label>
      <b><%=Utilities.getValue(ctInfo.CreditType)%></b></td>
  </tr>
  <tr>
    <td>
      <label>Credit Card Number</label>
      <b><%=Utilities.getValue(ctInfo.CreditNo)%></b></td>
  </tr>
  <tr>
    <td>
      <label>Exp Date</label>
      <b><%=Utilities.getValue(ctInfo.ExpiredMonth)%>, <%=Utilities.getValue(ctInfo.ExpiredYear)%></b></td>
  </tr>
  <tr>
    <td>
      <label>Card Verification Number</label>
      <b><%=Utilities.getValue(ctInfo.CSid)%></b></td>
  </tr>
  <tr><td colspan="3" height="3"></td></tr>
 </table>
 </DIV></td>
</tr>
<% } %>
<% } %>
<tr>
  <td align="center">
  <%=shopcart.getTestInfo(dmInfo, cfInfo)%>
  </td>
</tr>
</TABLE>
</div>
<% } %>
