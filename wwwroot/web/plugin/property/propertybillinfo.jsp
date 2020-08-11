<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.RSPropertyWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.plugin.PropertyResult"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{

  RSPropertyWeb web = new RSPropertyWeb(session, 20);
  String sAction = web.getRealAction(request);

  PropertyResult result = web.getResult();
  int nRecNo;
  if (request.getParameter("recno")==null)
     nRecNo = result.getRecordNo();
  else
    nRecNo = Integer.parseInt(request.getParameter("recno"));

  if (sAction.endsWith("generatereports"))
  { //. Try to generate reports
    result = web.generateReports(request);
    if (result.getReportsError(nRecNo)==0)
    {
      web.removeNavigation("Billing Information");
      TransferWeb.sendRedirectContent(response, "index.jsp?action=pi-propertyreports");
      return;
    }
    else
    {
//System.out.println("Description=" + result.getReportsDesc(nRecNo));
    }
  }

  ConfigInfo cfInfo = web.getConfigInfo();
  CustomerInfo ctInfo = web.getCustomerInfo();
  String sDisplayMessage = null;
  String sClass = "successful";
//  <li>I further affirm that the name and personal information provided on this form are true and correct.</li>
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/propertysearch.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/moneypocket.js" type="text/javascript"></SCRIPT>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
 <TR>
  <TD height=5></TD>
 </TR>
 <TR>
  <TD colspan="2"><%=web.getNavigationWeb(request, "Billing Information")%></TD>
 </TR>
 <TR>
  <TD height=5></TD>
 </TR>
 <TR>
  <TD align="center"><font class='pagetitle'>Billing Information</font></TD>
 </TR>
 <TR>
  <TD height=10></TD>
 </TR>
 <TR>
  <TD>
   <table align="center" border="0" cellpadding="2" cellspacing="1" width="572" class="highinfo">
    <tr>
     <td align="right" width="30%">Address:&nbsp;&nbsp;</td>
     <td><b><%=result.getFieldData("C_ADDRESS")%></b></td>
    </tr>
    <tr>
     <td align="right" width="30%">Onwer:&nbsp;&nbsp;</td>
     <td><b><%=result.getFieldData("C_OWNERS")%></b></td>
    </tr>
    <tr>
     <td align="right" width="30%">APN:&nbsp;&nbsp;</td>
     <td><b><%=result.getFieldData("APN")%></b></td>
    </tr>
    <tr>
     <td align="right" width="30%">Total Charge:&nbsp;&nbsp;</td>
     <td><font size=2 color="#FF6633"><b><%=Utilities.getNumberFormat(result.TempTotalCharge, '$', 2)%></b></font> (<%=result.TempReportCount%> report<%=result.TempReportCount>1?"s are":" is"%> selected)</td>
    </tr>
   </table>
  </TD>
 </TR>
 <TR>
  <TD height=10></TD>
 </TR>
 <TR>
  <TD>&nbsp;&nbsp;<font size=2>There are two options to order the reports. You can select one of them.</font> </TD>
 </TR>
 <TR>
  <TD><hr width="98%" color="#4279bd"></TD>
 </TR>
 <TR>
  <TD>
<%@ include file="../../waitprocess.jsp"%>
<SPAN id="Billing_Form">
<TABLE width="100%" border=0>
 <TR>
  <TD>&nbsp;<img src="/staticfile/web/images/tp06.gif" align="CENTER"><b> Use your credit to order reports.</b></TD>
 </TR>
 <TR>
  <TD>
   <FORM name="creditpocket_from" action="index.jsp" method="post" onSubmit="return validateBillingInfo(this);">
   <INPUT type="hidden" name="recno" value="<%=nRecNo%>">
   <INPUT type="hidden" name="customerid" value="<%=ctInfo!=null?ctInfo.CustomerID:-1%>">
   <INPUT type="hidden" name="action1" value="pi-generatereports">
   <INPUT type="hidden" name="type" value="10">
   <table class="table-1" width="98%" align="center" border=0>
<%
 String sDisabled = "";
 if (ctInfo!=null)
 {
   if (result.TempTotalCharge>web.getCurrentBalance())
      sDisabled = "disabled";
 }
%>
<% if (ctInfo!=null) { %>
    <tr bgColor="#4279bd" valign="middle">
      <td colspan="3" height=20><font color="#FFFFFF">View your credit balance.</font></td>
    </tr>
    <tr valign="middle">
      <td colspan="3" height=10></td>
    </tr>
    <tr>
     <td width="40%" align="right">Current Balance:</td>
     <td width="30%">&nbsp;&nbsp;<font size=2 color="green"><b><%=Utilities.getNumberFormat(web.getCurrentBalance(),'$',2)%></b></font></td>
     <td align="center"><a href="<%=web.getHttpLink("index.jsp?action=cp-buycredit")%>">Buy More Credit</a></td>
    </tr>
    <tr>
     <td width="40%" align="right">New Balance After Run Reports:</td>
     <td colspan=2>&nbsp;&nbsp;<font size=2 color="green"><b><%=Utilities.getNumberFormat(web.getCurrentBalance()-result.TempTotalCharge,'$',2)%></b></font>
     &nbsp;(<%=Utilities.getNumberFormat(web.getCurrentBalance(),'$',2)%> - <%=Utilities.getNumberFormat(result.TempTotalCharge, '$', 2)%>)
     </td>
    </tr>
    <tr>
     <td colspan="3" height=5></td>
    </tr>
    <tr>
      <td colspan=3><hr align="center" width="98%"></td>
    </tr>
    <tr>
     <td colspan=3 align="center"><input type="submit" value="Order Reports" name="submit" onClick="setAction(document.creditpocket_form, 'pi-generatereports');" style="WIDTH:100px" <%=sDisabled%>></td>
    </tr>
<% } else { %>
    <tr bgColor="#4279bd" valign="middle">
      <td height=20><font color="#FFFFFF">Login your account or setup an account.</font></td>
    </tr>
    <tr>
     <td>Login your account and use your credit to buy reports. You do not need to fill in your credit card information again and again.
        If you do not have an account in our online system and want to create an account to store your information for future purchase and tracking.
        We recommand you setup a account. With the account you can manage your credit, track your transaction history
        and get any archived reports generated before at any time for free.
     </td>
    </tr>
    <tr>
    <tr>
     <td height=1></td>
    </tr>
    <tr>
      <td ><hr align="center" width="98%"></td>
    </tr>
    <tr>
      <!--td align="center">
       <script>createLeftButton();</script>
       <a class="button" href="<%=web.getHttpsLink("index.jsp?action=cp-accountlogin&nextaction=pi-propertybillinfo")%>">Login Account/Setup Account</a>
       <script>createRightButton();</script>
      </td-->
      <td align="center">
        <input type="button" value="Login Account/Setup Account" name="login" onClick="goToLinkPage('<%=web.getHttpsLink("index.jsp?action=cp-accountlogin&nextaction=pi-propertybillinfo")%>');">
      </td>
   </tr>
<% } %>
    <tr>
     <td colspan="3" height=5></td>
    </tr>
  </table>
  </FORM>
  </TD>
 </TR>
<!------------>
  <TR>
  <TD>&nbsp;<img src="/staticfile/web/images/tp06.gif" align="CENTER"><b> Use credit card to order reports.</b></TD>
 </TR>
 <TR><TD>
<FORM name="creditcard_form" action="index.jsp" method="post" onSubmit="return validateBillingInfo(this);">
<INPUT type="hidden" name="customerid" value="<%=ctInfo!=null?ctInfo.CustomerID:-1%>">
<INPUT type="hidden" name="recno" value="<%=nRecNo%>">
<INPUT type="hidden" name="type" value="11">
<INPUT type="hidden" name="action1" value="pi-generatereports">
  <table class="table-1" width="98%" align="center" border=0>
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
      <td colspan=3><hr align="center" width="98%"></td>
    </tr>
    <!--tr>
      <td colspan=3>
      <table width="100%" border=0>
       <tr>
        <td class="row1" width="5" align="right" valign="top"><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#FF6633">Note:</font></td>
        <td class="row1"><font size="2"><ul>
         <li>The total charge is not refundable. It may be less if not all selected reports available for this property.</li>
         <li>By pressing the 'Order Reports' button below, I authorize ZYZ IT Company to charge me for the above total.</li>
         <li>I further declare that I have read, understand and accept ZYZ IT Company's <a href="#">terms</a> as published on their web site.</li>
         <li>Your information will be encrypted to sent to the secure server by using Secure Socket Layer (SSL)</li>
         </ul></font>
        </td>
       </tr>
      </table>
     </td>
    </tr-->
    <tr>
     <td colspan=3 align="center"><input type="submit" value="Order Reports" name="submit" onClick="setAction(document.creditcard_form, 'pi-generatereports');" style="WIDTH:100px"></td>
    </tr>
    <tr>
      <td colspan=3 height="5"></td>
    </tr>
   </table>
 </FORM>
 <SCRIPT>onCustomerBillingLoad(document.creditcard_form);</SCRIPT>
 </TD>
 </TR>
</TABLE>
</SPAN>
  </TD>
 </TR>
</table>
<% } %>