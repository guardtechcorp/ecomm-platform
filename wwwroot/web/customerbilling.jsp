<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 10);
  ConfigInfo cfInfo = web.getConfigInfo();

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  boolean bSuccessful = true;
  String sDisplayMessage = null;
  String sClass = "successful";
  CustomerInfo ctInfo = null;
  if ("Update Billing Information".equalsIgnoreCase(sAction))
  {
//    CustomerWeb.Result ret = web.update(request, false);
    BasicBean.Result ret = BasicBean.getRequestResult(session);
    ctInfo = (CustomerInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      bSuccessful = false;
      sClass = "failed";
    }
/*Neil00
    else
    {//. Should remove
//      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "customer");
      response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm"));
    }
*/
  }
  else if ("EditBillingInfo".equalsIgnoreCase(sAction))
  {
      ctInfo =  web.getInfo(request);
      sAction = "Update Billing Information";
  }

  if (ctInfo==null)
  {
    ctInfo = CustomerInfo.getInstance2(true);
    ctInfo.Country = "USA";
    ctInfo.State = "CA";
    ctInfo.Subscribe = 1;
    ctInfo.Taxable = 1;
    sAction = "Create My Account";
  }
%>
<FORM name="customer" action="index.jsp" method="post">
<input type="hidden" name="customerid" value="<%=ctInfo.CustomerID%>">
<TABLE width="99%" align="right" border=0 height="300" align="right" bgcolor="<%=cfInfo.BackColor%>">
  <TR vAlign="middle">
    <TD height=20><img src="/staticfile/web/images/tp06.gif" align=CENTER><a href="<%=web.encodedUrl("index.jsp")%>">Shopping</a> > <a href="<%=web.encodedUrl("index.jsp?action=shopcart")%>">Shopping Cart</a> >
     <font color="#FF0000"><%=web.getAccountLink(null, ctInfo)%></font> > Confirm > Finish Purchase & Print Invoice
    </TD>
  </TR>
  <TR>
    <TD valign="top">
     <table align="center" border="0" cellpadding="10" cellspacing="0" width="100%" class="infobox">
      <tr>
       <td><img src="/staticfile/web/images/info.gif" height=14 width=14 alt="Payment Information">
       <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font color="#FF6633">Information:</font>
       Your information is only used for your ordering, shipping and order tracking, not for other purposes. It is protected
       by our Privacy Policy. Your information will be encrypted to sent to the secure server by using Secure Socket Layer (SSL)
       - the industry standard and the best technology for secure commerce transactions.</font>
       </td>
      </tr>
     </table>
   </TD>
  </TR>
  <TR>
   <TD valign="top">
        <table class="table-1" width="100%" align="center" border=0>
          <tr bgColor="#4279bd" valign="middle">
           <td colspan="3" height=20><font color="#FFFFFF">Please fill out your credit card information:</font></td>
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
            <td width="30%" height="9">
              <div align="right">Name On Your Credit Card:</div>
            </td>
            <td width="2%" height="9">&nbsp; </td>
            <td width="68%" height="9">
              <input maxlength=20 size=40 value="<%=ctInfo.CreditName%>" name="creditname">
            </td>
          </tr>
          <tr>
            <td width="30%" height="2">
              <div align="right">Credit Card Type:</div>
            </td>
            <td width="2%" height="2">&nbsp; </td>
            <td width="68%" height="2">
              <select name="credittype">
                <%=web.getPayOptions(ctInfo)%>
              </select>
            </td>
          </tr>
          <tr>
            <td width="30%">
              <div align="right">Credit Card Number:</div>
            </td>
            <td width="2%">&nbsp; </td>
            <td width="68%">
              <input maxlength=20 size=40 value="<%=ctInfo.CreditNo%>" name="creditno">
            </td>
          </tr>
          <tr>
            <td width="30%" height="4">
              <div align="right">Expiration Date:</div>
            </td>
            <td width="2%" height="4">&nbsp;</td>
            <td width="68%" height="4">
              <select name="expiredmonth">
                <option value=None selected>Month
                <option value=01>January</option>
                <option value=02>February</option>
                <option value=03>March</option>
                <option value=04>April</option>
                <option value=05>May</option>
                <option value=06>June</option>
                <option value=07>July</option>
                <option value=08>August</option>
                <option value=09>September</option>
                <option value=10>October</option>
                <option value=11>November</option>
                <option value=12>December</option>
              </select>
              <select name="expiredyear">
                <option value="None" selected>Year <%=web.getExpiredYear(ctInfo.ExpiredYear)%>
              </select>
            </td>
          </tr>
          <tr>
            <td width="30%" height="23" align="right">Card Verification Number:</td>
            <td width="2%" height="23">&nbsp;</td>
            <td width="68%" height="23">
              <input maxlength=8 size=10 value="<%=Utilities.getValue(ctInfo.CSid)%>" name="csid" type="text" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
              <font size=1>(Visa, MasterCard & American Express only.
              <a href="javascript:ChildWin=window.open('/staticfile/web/cards-help.html','cards_help','resizable=yes,scrollbars=no,width=460,height=630');ChildWin.focus()">Help</a>)</font>
            </td>
          </tr>
          <tr>
            <td width="30%">&nbsp;</td>
            <td width="2%">&nbsp;</td>
            <td width="68%">&nbsp;</td>
          </tr>
          <tr>
            <td class="row1" colspan=2 align="center">&nbsp; </td>
            <td class="row1" width="68%" align="center">
              <div align="left">
                <input type="submit" name="action" value="<%=sAction%>" onClick="return validateCustomerBilling(document.customer);">
                &nbsp;&nbsp;
                <input type="submit" name="action" value="Cancel Update">
              </div>
            </td>
          </tr>
          <tr>
            <td colspan=3 align="center" height="10">&nbsp; </td>
          </tr>
        </table>
   </TD>
  </TR>
</TABLE>
</FORM>
<!--SCRIPT>setupOption(document.customer.state, g_State, "<%=ctInfo.State%>");</SCRIPT-->
<!--SCRIPT>setupOption(document.customer.country, g_Country, "<%=ctInfo.Country%>");</SCRIPT-->
<SCRIPT>onCustomerBillingLoad(document.customer);</SCRIPT>
<SCRIPT>CreditCardSelect(document.customer, "<%=ctInfo.CreditType%>", "<%=ctInfo.ExpiredMonth%>", "<%=ctInfo.ExpiredYear%>");</SCRIPT>
<% } %>