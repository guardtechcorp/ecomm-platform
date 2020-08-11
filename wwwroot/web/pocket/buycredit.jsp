<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BuyCreditWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  BuyCreditWeb web = new BuyCreditWeb(session, 20);
  String sAction = web.getRealAction(request);
  CustomerInfo ctInfo = web.getCustomerInfo();
  if (ctInfo==null)
  {//. It is not login and we need to forece it to login first
//    response.sendRedirect(web.encodedUrl("index.jsp?action=cp-memberlogin&nextaction=cp-moneypocket"));
    TransferWeb.sendRedirectContent(response, "index.jsp?action=cp-accountlogin&nextaction=cp-buycredit");
    return;
  }

  String sDisplayMessage = null;
  String sClass = "successful";
  if (sAction.endsWith("paypal-buycredit"))
  { //. CallBack from PayPal
web.dumpAllParameters(request);

    BuyCreditWeb.Result ret = web.paypalPayment(request);
    String sType = request.getParameter("type");
    if ("notify".equalsIgnoreCase(sType))
    {
      response.reset();
      response.setContentType("text/html");
      response.getWriter().println("<html>");
      response.getWriter().println("<body>");
      response.getWriter().println("<head><title>Invoice No:" +  request.getParameter("invoice") + "</title></head>");
      response.getWriter().println("We got your notify.");
      response.getWriter().println("</body>");
      response.getWriter().println("</html>");

      return;
    }
    else  if ("return".equalsIgnoreCase(sType))
    {
      float fPay = Utilities.getFloat(request.getParameter("payment_gross"), 0);
      sDisplayMessage = "You have been successful to buy " + Utilities.getNumberFormat(fPay, '$', 2) + " credit through PayPal. Thank you.";
    }
    else  if ("cancel".equalsIgnoreCase(sType))
    {
      sDisplayMessage = "You have canceled your buying credit through PayPal. Please try to buy your credit later.";
      sClass = "failed";
    }
  }

  ConfigInfo cfInfo = web.getConfigInfo();
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/moneypocket.js" type="text/javascript"></SCRIPT>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
 <TR>
  <TD height=20><%=web.getNavigationWeb(request, "Buy Credit")%></TD>
 </TR>
 <TR>
  <TD height=5 valign="top"></TD>
 </TR>
 <TR>
  <TD align="center"><font class='pagetitle'>Buy Credit</font></TD>
 </TR>
 <TR>
  <TD height=10 valign="bottom"></TD>
 </TR>
<% if (sDisplayMessage!=null) { %>
 <TR>
  <TD align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></TD>
 </TR>
<% } %>
 <TR>
  <TD>
<TABLE cellspacing=1 cellpadding=0 border="0" width="96%" align="center">
 <tr>
  <td><HR align="center" width="100%" color="#4279bd" noShade SIZE=1></td>
 </tr>
 <tr>
  <td>
   <FORM name="creditamount_form">
   <table width="100%" align="right" border=0>
    <tr>
     <td height="25" width="40%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Current Credit Balance:</font></td>
     <td height="25" width="30%"><font size=2 color="green"><b><%=Utilities.getNumberFormat(web.getCurrentBalance(),'$',2)%></b></font></td>
     <td height="25" align="right"><!--a href="<%=web.getHttpLink("index.jsp?action=cp-creditlist")%>">Credit List</a--></td>
    </tr>
    <tr>
     <td height="25" width="40%"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">How much credit to buy:</font></td>
     <td height="25" width="30%"><input type="text" name="amount" value="100" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'></td>
     <td height="25"></td>
    </tr>
   </table>
   </FORM>
  </td>
 </tr>
 <tr>
  <td height=15></td>
 </tr>
 <tr>
  <td height="25" valign="bottom"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
  There are several payment options, you can use either one to buy credit: </font>
   <HR align="left" width="100%" color="#4279bd" noShade SIZE=1>
  </td>
 </tr>
<% if (web.isPayOptionOn("creditcard")) {%>
 <tr>
  <td height=5></td>
 </tr>
 <tr>
  <td>
  <FORM name="creditcard" action="index.jsp" method="post" onSubmit="return validateCreditAmount(document.creditamount_form, this);">
  <input type="hidden" name="amount" value="">
  <input type="hidden" name="invoice" value="<%=web.getPreOrderNo()%>">
  <input type="hidden" name="action1" value="">
  <table width="100%" align="right" border=0>
  <TR vAlign="middle">
   <TD width="73%"><img src="/staticfile/web/images/tp06.gif" align="CENTER"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
   <b>Pay by credit card</b> -- Please provide your credit card information.</font>
   </TD>
   <TD width="27%" align="right"><input type="submit" value="Pay By Credit Card" name="paybycard" onClick="setAction(document.creditcard, 'cp-creditcardpay');" style="WIDTH:138px;HEIGHT:25px"></TD>
  </TR>
  </table>
  </FORM>
  </td>
 </tr>
<% } %>
<% if (web.isPayOptionOn("paypal", ctInfo)) {%>
 <tr>
  <td height=10></td>
 </tr>
 <tr>
 <td>
  <form name="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" onSubmit="return validateCreditAmount(document.creditamount_form, this);">
  <input type="hidden" name="charset" value="utf8">
  <input type="hidden" name="cmd" value="_ext-enter">
  <input type="hidden" name="redirect_cmd" value="_xclick">
  <input type="hidden" name="first_name" value="<%=web.getPatialName(ctInfo.Yourname, 1)%>">
  <input type="hidden" name="last_name" value="<%=web.getPatialName(ctInfo.Yourname, 2)%>">
  <input type="hidden" name="address1" value="<%=ctInfo.Address%>">
  <input type="hidden" name="city" value="<%=ctInfo.City%>">
  <input type="hidden" name="state" value="<%=ctInfo.State%>">
  <input type="hidden" name="zip" value="<%=ctInfo.ZipCode%>">
  <input type="hidden" name="country" value="<%=ctInfo.Country%>">
  <input type="hidden" name="email" value="<%=ctInfo.EMail%>">
  <input type="hidden" name="H_PhoneNumber" value="<%=ctInfo.Phone%>">
  <input type="hidden" name="country" value="<%=ctInfo.Country%>">
  <input type="hidden" name="business" value="<%=Utilities.getValue(web.getPaymentInfo("paypal").Options)%>">
  <input type="hidden" name="item_name" value="But Credit">
  <input type="hidden" name="item_number" value="<%=web.getShopCartId(request, response)%>">
  <!--input type="hidden" name="quantity" value="1"-->
  <input type="hidden" name="amount" value="<%=web.getCurrentBalance()%>">
  <!--input type="hidden" name="tax" value="web.getSummary(2"-->
  <!--input type="hidden" name="shipping" value="web.getSummary(3)"-->
  <input type="hidden" name="invoice" value="<%=web.getPreOrderNo()%>">
  <input type="hidden" name="custom" value="<%=ctInfo.CustomerID%>">
  <input type="hidden" name="rm" value="2">
  <input type="hidden" name="no_note" value="1">
  <input type="hidden" name="no_shipping" value="1">
  <input type="hidden" name="notify_url" value="<%=web.getCallbackUrl("notify")%>">
  <input type="hidden" name="return" value="<%=web.getCallbackUrl("return")%>">
  <input type="hidden" name="cancel_return" value="<%=web.getCallbackUrl("cancel")%>">

  <table width="100%" align="right" border="0">
  <tr>
    <td width="73%">
      <p><img src="/staticfile/web/images/tp06.gif" align="CENTER"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
       <b>Pay via PayPal or Credit Card</b> -- You can use your PayPal account or directly pay securely using your credit card to complete this purchase. </font>
      </td>
      <td width="27%" align="right">
      <input type="image" name="submit" src="/staticfile/web/images/x-click-but01.gif" alt="<%=web.getLabelText(cfInfo, "paypal-alt")%>" width="62" height="31" border="0">
      <br>
      <input type="image" name="submit" src="/staticfile/web/images/paypal_cards.gif" alt="<%=web.getLabelText(cfInfo, "paypal-alt")%>" border="0" >
    </td>
  </tr>
 </table>
 </form>
 </td>
 </tr>
<% } %>
<% if (web.isPayOptionOn("check", ctInfo)) {%>
 <tr>
  <td height=10></td>
 </tr>
 <tr>
  <td>
  <FORM name="check" action="index.jsp" method="post" onClick="return validatePayCheck(document.orderconfirm, document.check);">
  <input type="hidden" name="preorderno" value="<%=web.getPreOrderNo()%>">
  <input type="hidden" name="custom" value="">
  <input type="hidden" name="action1" value="">
  <table width="100%" align="right" border=0>
  <TR vAlign="middle">
   <TD width="73%"><img src="/staticfile/web/images/tp06.gif" align="CENTER"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
     <%=web.getLabelText(cfInfo, "check-des")%></font>
   </TD>
    <TD width="27%" align="right"><input type="submit" value="<%=web.getLabelText(cfInfo, "orderbycheck-but")%>" name="orderbycheck" onClick="setAction(document.check, 'cp-buycreditbycheck');" style="WIDTH:138px;HEIGHT:25px"></TD>
  </TR>
  </table>
 </FORM>
 </td>
 </tr>
<% } %>
<% if (web.isPayOptionOn("monthlycharge", ctInfo)) {%>
 <tr>
  <td height=10></td>
 </tr>
 <tr>
  <td>
  <FORM name="monthlycharge" action="index.jsp" method="post" onClick="return validateMonthlyCharge(document.orderconfirm, document.monthlycharge);">
  <input type="hidden" name="preorderno" value="<%=web.getPreOrderNo()%>">
  <input type="hidden" name="custom" value="">
  <input type="hidden" name="action1" value="">
  <table width="100%" align="right" border=0>
  <TR vAlign="middle">
   <TD width="73%"><img src="/staticfile/web/images/tp06.gif" align="CENTER"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
     <%=web.getLabelText(cfInfo, "monthlycharge-des")%></font>
   </TD>
    <TD width="27%" align="right"><input type="submit" value="<%=web.getLabelText(cfInfo, "monthlycharge-but")%>" name="monthlycharge" onClick="setAction(document.monthlycharge, 'cp-buycreditbymonthlycharge');" style="WIDTH:138px;HEIGHT:25px"></TD>
  </TR>
  </table>
 </FORM>
 </td>
 </tr>
<% } %>
</TABLE>
  </TD>
 </TR>
</table>
<% } %>