<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BuyCreditWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  BuyCreditWeb web = new BuyCreditWeb(session, 20);
  String sAction = web.getRealAction(request);
  String sDisplayMessage = null;
  String sClass = "successful";
  if (sAction.endsWith("submit-creditcardpay"))
  { //
    BuyCreditWeb.Result  ret = web.submitPayment(request);
    if (ret.isSuccess())
    {
      sDisplayMessage = "It is successfully to buy credit.";
    }
    else
    {
      sClass = "failed";
      sDisplayMessage = "An error occurred in credit card proccess, please try it later.";
    }
  }
  else if (sAction.endsWith("paypal-creditcardpay"))
  { //
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
    }
    else
      response.sendRedirect("invoice.jsp");

    return;
  }
  else //if ("creditcardpay".equalsIgnoreCase(sAction))
  { //
    web.savePayAmount(request);
  }

//web.dumpAllParameters(request);
  CustomerInfo ctInfo =  web.getCustomerInfo();
  ConfigInfo cfInfo = web.getConfigInfo();
  String sTitleLinks = web.getNavigationWeb(request, "Credit Card Information");
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/moneypocket.js" type="text/javascript"></SCRIPT>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
 <tr>
  <td height=20><%=sTitleLinks%></td>
 </tr>
 <TR>
  <TD height=5></TD>
 </TR>
 <TR>
  <TD align="center"><font class='pagetitle'>Credit Card Information</font></TD>
 </TR>
 <TR>
  <TD height=10></TD>
 </TR>
 <TR>
  <TD>
<%@ include file="../waitprocess.jsp"%>
<SPAN id="Billing_Form">
<FORM name="creditcard_form" action="index.jsp" method="post" onSubmit="return validateBillingInfo(this);">
<INPUT type="hidden" name="money" value="<%=web.getPayAmount()%>">
<INPUT type="hidden" name="memberid" value="<%=ctInfo.CustomerID%>">
<INPUT type="hidden" name="category" value="CreditCard">
<INPUT type="hidden" name="action1" value="submit-creditcardpay">
<TABLE width="99%" border=0 height="300" align="right"  bgcolor="<%=cfInfo.BackColor%>">
  <TR>
    <TD valign="top">
     <table align="center" border="0" cellpadding="10" cellspacing="0" width="100%" class="infobox">
      <tr>
       <td><img src="/staticfile/web/images/info.gif" height=14 width=14 alt="Payment Information">
       <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font color="#FF6633">Information:</font>
       Please complete your order process by providing payment information below. All information is submitted and handled securely via SSL - the industry standard and the best technology for secure commerce transactions.<br>
       Please enter your billing information exactly as it appears on your credit card statement. Then click 'Submit' button to finish payment.
       </font>
       </td>
      </tr>
     </table>
   </TD>
  </TR>
  <TR>
   <TD valign="top">
    <table class="table-1" width="100%" align="center" border=0>
      <tr bgColor="#4279bd" valign="middle">
       <td colspan="3" height=20><font color="#FFFFFF"><%=web.getLabelText(cfInfo, "fillbill-lab")%></font></td>
      </tr>
<% if (sDisplayMessage!=null) { %>
      <tr>
        <td colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
      </tr>
<% } %>
      <tr>
        <td colspan="3" height="12" align="center"></td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "nameoncard-lab")%></td>
        <td width="2%">&nbsp;</td>
        <td width="68%">
          <input maxlength=30 size=40 value="<%=Utilities.getValue(request.getParameter("creditname"))%>" name="creditname">
        </td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "cardtype-lab")%></td>
        <td width="2%">&nbsp; </td>
        <td width="68%">
          <select name="credittype">
            <%=web.getCreditCardList(null)%>
          </select>&nbsp;&nbsp;<%=web.getCardLinks()%>
        </td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "cardno-lab")%></td>
        <td width="2%">&nbsp;</td>
        <td width="68%">
          <input maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("creditno"))%>" name="creditno">
        </td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "expireddate-lab")%></td>
        <td width="2%">&nbsp;</td>
        <td width="68%">
          <select name="expiredmonth">
            <option value="None" selected><%=web.getLabelText(cfInfo, "month-lab")%></option>
            <option value=01>01</option>
            <option value=02>02</option>
            <option value=03>03</option>
            <option value=04>04</option>
            <option value=05>05</option>
            <option value=06>06</option>
            <option value=07>07</option>
            <option value=08>08</option>
            <option value=09>09</option>
            <option value=10>10</option>
            <option value=11>11</option>
            <option value=12>12</option>
          </select>
          <select name="expiredyear">
            <option value="None" selected>Year</option>
            <%=web.getExpiredYear(null)%>
          </select>
        </td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "cardvn-lab")%></td>
        <td width="2%">&nbsp;</td>
        <td width="68%">
          <input maxlength=8 size=10 value="<%=Utilities.getValue(request.getParameter("csid"))%>" name="csid" type="text" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
          <font size=1>(<%=web.getLabelText(cfInfo, "seehelp-lab")%> <a href="javascript:ChildWin=window.open('/staticfile/web/cards-help.html','cards_help','resizable=yes,scrollbars=no,width=460,height=680');ChildWin.focus()"><%=web.getLabelText(cfInfo, "help-lab")%></a>.)</font>
        </td>
      </tr>
      <tr>
        <td width="30%" align="right">Credit Amount:</td>
        <td width="2%">&nbsp;</td>
        <td width="68%"><font size=2 color="green"><b><%=Utilities.getNumberFormat(web.getPayAmount(), '$', 2)%></b></font></td>
      </tr>
      <tr>
        <td colspan=3><hr align="center" width="98%"></td>
      </tr>
      <tr>
        <td colspan=3>
       </td>
      </tr>
<tr>
<td colspan=3>
<table width="100%" border=0>
<tr>
  <td class="row1" colspan=2 align="center">&nbsp;</td>
  <td class="row1" width="60%" align="left">
  <input type="submit" value="Submit" name="submit" onClick="setAction(document.creditcard_form, 'cp-submit-creditcardpay');"></TD>
  </td>
</tr>
<tr>
  <td colspan=3 align="center" height="5"></td>
</tr>
</table>
</td>
</tr>
    </table>
   </TD>
  </TR>
</TABLE>
</FORM>
</SPAN>
</TD>
</TR>
</table>
<SCRIPT>onCustomerBillingLoad(document.creditcard_form);</SCRIPT>
<% } %>