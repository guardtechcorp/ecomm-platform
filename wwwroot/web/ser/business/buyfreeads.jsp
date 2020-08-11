<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.servlet.PaypalCallback" %>
<%
{
    if (sRealAction.startsWith("SubmitBuy"))
    {
        String sType = request.getParameter("type");
        if ("cancel".equalsIgnoreCase(sType))
        {
          sDisplayMessage = "You have canceled the payment process.";
          nDisplay = 0;
        }
        else
        {
          sDisplayMessage = "You successfully purchased the free ads feature. The new expired will be in " + cfInfo.AdsExpiredDate.substring(0, 10);
          nDisplay = 1;                                  
        }
    }

    String sSubjectNote = mcBean.getTemplateSubject("Apply-Membership");
    String sContentNote = mcBean.getTemplateContent("Apply-Membership");
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<table class1="table-outline" width="100%" align="center" cellspacing="1" cellpadding="2">
<TR>
 <TD>
  <%@ include file="../include/promotenote.jsp"%>
 </TD>
 </TR>
<tr>
 <td height="10" valign="bottom"></td>
</tr>
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>    
<tr>
 <td>
<%
    String sCustom  = mcBean.getDomainName() + ",";
           sCustom += "FreeAds" + ",";
           sCustom += "0,";  //. It is admin of webcenternode.com
           sCustom += mbInfo.MemberID;

    String sUnitPrice = Utilities.getNumberFormat(mcBean.getConfigValue("freeads-fee", "0.01"), 'd', 2);
    String sPayPalAccount = mcBean.getConfigValue("paypal-account", "admin@webcenternode.com");
%>
 <FORM name="form_paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" onSubmit1="return validatePayPal(this);">
 <input type="hidden" name="charset" value="utf8">
 <input type="hidden" name="cmd" value="_ext-enter">
 <input type="hidden" name="redirect_cmd" value="_xclick">
 <input type="hidden" name="first_name" value="<%=mbInfo.FirstName%>">
 <input type="hidden" name="last_name" value="<%=mbInfo.LastName%>">
 <input type="hidden" name="address1" value="<%=Utilities.getValue(mbInfo.Address1)%>">
 <input type="hidden" name="city" value="<%=Utilities.getValue(mbInfo.City)%>">
 <input type="hidden" name="state" value="<%=Utilities.getValue(mbInfo.State)%>">
 <input type="hidden" name="zip" value="<%=Utilities.getValue(mbInfo.Zip)%>">
 <input type="hidden" name="country" value="<%=Utilities.getValue(mbInfo.Country)%>">
 <input type="hidden" name="business" value="<%=sPayPalAccount%>">
 <input type="hidden" name="item_name" value="The Feature of Free Ads">
 <input type="hidden" name="item_number" value="Term of the service">
 <!--input type="hidden" name="quantity" value="1"-->
 <input type="hidden" name="amount" value="<%=sUnitPrice%>">
 <!--input type="hidden" name="tax" value="0.0"-->
 <!--input type="hidden" name="shipping" value="0.0"-->
 <input type="hidden" name="invoice" value="<%=Utilities.getUniqueId(10)%>">
 <input type="hidden" name="custom" value="<%=sCustom%>">
 <input type="hidden" name="rm" value="2">
 <input type="hidden" name="no_note" value="1">
 <input type="hidden" name="no_shipping" value="1">
 <input type="hidden" name="notify_url" value='<%=PaypalCallback.getCallbackUrl(mcBean.getDomainName(), "notify")%>'>
 <input type="hidden" name="return" value='<%=PaypalCallback.getReturnUrl(mcBean.getDomainName(), "SubmitBuy_FreeAds")%>'>
 <input type="hidden" name="cancel_return" value='<%=PaypalCallback.getCancelUrl(mcBean.getDomainName(), "SubmitBuy_FreeAds")%>'>
 <table width="80%" align="center" border="0" cellspacing="4" cellpadding="2">
 <tr>
  <td width="50%"><font size='2'><b>How long do you want:</b></font></td>
  <td align="left">
  <select name="quantity" onChange="onTermChnage('id_totalcharge', this.value, <%=sUnitPrice%>)">
   <option value=1 SELECTED>1</option>
   <option value=2>2</option>
   <option value=3>3</option>
   <option value=4>4</option>
   <option value=5>5</option>
   <option value=6>6</option>
   <option value=7>7</option>
   <option value=8>8</option>
   <option value=9>9</option>
   <option value=10>10</option>
   <option value=11>11</option>
   <option value=12>12</option>
  </select>&nbsp;&nbsp;<b>Month(s)</b>
  </td>
 </tr>
 <tr>
  <td width="50%"><font size='2'><b>Total Charge:</b></font></td>
  <td align="left" id='id_totalcharge'><font color="red"><b>$<%=sUnitPrice%></b></font></td>
 </tr>
 <tr>
  <td colspan="2"><hr class="line"></td>
 </tr>
 <tr>
   <td width="50%">
    <font size='2'><b>Pay by Credit Card</b></font>
   </td>
  <td  align="right"><input type="image" name="submit" src="/staticfile/web/images/paypal_cards.gif" alt="Directly pay securely using your credit card" border="0" ></td>
 </tr>
 <tr>
   <td width="50%">
     <font size="2"><b>Pay via PayPal</b></font>
     </td>
     <td  align="right">
     <input type="image" name="submit" src="/staticfile/web/images/x-click-but01.gif" alt="Use your PayPal account" width="62" height="31" border="0">
   </td>
 </tr>
</table>
</form>
<!--tr>
 <td>
<FORM name="check" action="index.jsp" method="post" onClick1="return validatePayCheck(document.orderconfirm, document.check, 'msInfo.Price);">
<input type="hidden" name="preorderno" value="<%=Utilities.getUniqueId(16)%>">
<input type="hidden" name="custom" value="">
<input type="hidden" name="action1" value="">
  <table width="100%" align="right" border=0>
  <TR vAlign="middle">
   <TD width="73%"><img src="/staticfile/web/images/tp06.gif" align="CENTER"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
   Pay by check or money order -- Please mail it together with your print-out order form.
   </font>
   </TD>
    <TD width="27%" align="right"><input type="submit" value="Purchase by Check" name="orderbycheck" onClick="setAction(document.check, 'Order By Check');" style="WIDTH:138px;HEIGHT:25px"></TD>
  </TR>
  </table>
</FORM>
 </td>
</tr-->
</TD>
</TR>
</TABLE>
<% } %>