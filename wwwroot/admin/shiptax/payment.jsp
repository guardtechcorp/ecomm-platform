<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/shiptax.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.PaymentBean"%>
<%@ page import="com.zyzit.weboffice.model.PaymentInfo"%>
<%
  PaymentBean bean = new PaymentBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CHANGERATE))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  String sGatewayName = null;
  if ("Update Now".equalsIgnoreCase(sAction))
  {
    PaymentBean.Result ret = bean.update(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "payment settings");
    }
  }
  else if ("Gateway Change".equalsIgnoreCase(sAction))
  {
    sGatewayName = request.getParameter("gateway");
  }

  if (sGatewayName==null) //Try to get the saved one
     sGatewayName = bean.getPaymentInfo("creditcard").GatewayName;

  String sHelpTag = "payment";
  String sTitleLinks = "<b>Payment Settings</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below will allow you to setup your payment options.
<form name="payment" action="payment.jsp" method="post" onsubmit="return validatePayment(this);">
  <table width="98%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Payment Processing Options</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" align="center" height="20"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="spaceRow" colspan="3" height="10"></td>
    </tr>
    <tr>
      <td width="20%" height="10" align="right" class="row1"><input name="creditcard" type="checkbox" value=1 onClick="onCreditCardCheck(document.payment)" <%=bean.getCheckFlag("creditcard")%>></td>
      <td class="row1" width="50%">Accept Credit Card Payment through
        <select name="gateway" onChange="onGatewayChange(this, 'payment.jsp');">
          <%=bean.getGetewayList(sGatewayName)%>
        </select>
      </td>
      <td width="30%" rowspan="3" class="row1"><%=bean.getGetewayDescription(sGatewayName)%></td>
    </tr>
    <tr>
      <td width="20%" align="right" class="row1"><%=bean.getAccountLabel(sGatewayName)%></td>
      <td class="row1" width="50%"><%=bean.getAccountFields(sGatewayName)%></td>
    </tr>
    <tr>
      <td width="20%" height="10" align="right" class="row1">Accepted Credit Cards:</td>
      <td class="row1" width="50%">
       <input name="visa" type="checkbox" value="1" <%=bean.getOptionFlag("creditcard", "visa")%>>Visa &nbsp;&nbsp;
       <input name="mastercard" type="checkbox" value="1" <%=bean.getOptionFlag("creditcard", "mastercard")%>>MasterCard &nbsp;&nbsp;
       <input name="discover" type="checkbox" value="1" <%=bean.getOptionFlag("creditcard", "discover")%>>Discover &nbsp;&nbsp;
       <input name="american_express" type="checkbox" value="1" <%=bean.getOptionFlag("creditcard", "american_express")%>>American Express
      </td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
      <td width="20%" height="10" align="right" class="row1"><input name="paypal" type="checkbox" value="1" onClick="onPaypalCheck(document.payment)" <%=bean.getCheckFlag("paypal")%>></td>
      <td class="row1" width="50%">Accept Paypal Payment</td>
      <td width="30%" rowspan="2" class="row1"><a href="http://www.paypal.com" target="_blank">PayPal</a> Account is free to setup and use with your bank account or credit card automatically connected and worldwide accepted.</td>
    </tr>
    <tr>
      <td width="20%" height="10" align="right" class="row1">The PayPal Account:</td>
      <td class="row1" width="50%"><input type="text" name="paypal_account" size=40 maxlength=50 value="<%=Utilities.getValue(bean.getPaymentInfo("paypal").Options)%>"></td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
     <td class="row1" width="20%" height="12" align="right"><input name="check" type="checkbox" value="1" <%=bean.getCheckFlag("check")%>></td>
     <td class="row1" width="50%" height="12">Accept Check Payment</td>
     <td class="row1" width="30%" height="12">Check or Money Order Payment by postal mailing.</td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
     <td class="row1" width="20%" height="12" align="right"><input name="monthlycharge" type="checkbox" value="1" <%=bean.getCheckFlag("monthlycharge")%>></td>
     <td class="row1" width="50%" height="12">Monthly Statement</td>
     <td class="row1" width="30%" height="12">Send a statement or invoice to customer monthly.</td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center"><input type="submit" name="action" value="Update Now"></td>
    </tr>
  </table>
</form>
<SCRIPT>onPaypalLoad(document.payment);</SCRIPT>
<%@ include file="../share/footer.jsp"%>