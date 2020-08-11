<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BuyCreditWeb"%>
<% {
    ConfigInfo cfInfo = webCustomer.getConfigInfo();
    String sAction = webCustomer.getRealAction(request);
    String sDisplayMessage = null;
    String sClass = "successful";
    CustomerInfo ctInfo = null;

    if ("Billing-Update".equalsIgnoreCase(sAction))
    {
        BasicBean.Result ret = webCustomer.update(request, false);
        if (!ret.isSuccess())
        {
          Errors errObj = (Errors)ret.getInfoObject();
          sErrorMessage = errObj.getError();
          sErrorClass = "failed";
        }
        else
        {
           sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "credit card billing information");
           ctInfo = (CustomerInfo)ret.getUpdateInfo();
        }
    }
    else
    {
        ctInfo = webCustomer.getCustomerInfo();
    }

    String sPageTitle = "Your Billing Information";
%>
<div class="panel panel-warning">
<div class="panel-heading" align="center"><font size="3">Credit Card Information</font></div>
<div class="panel-body">
<FORM name="creditcard" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="Billing-Update">
<INPUT type="hidden" name="customerid" value="<%=ctInfo.CustomerID%>">
 <table class="table table-condensed" width="90%" align="center" border=0 cellpadding="1" cellspacing="1">
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td colspan="3" height="12" align="center"><span class="<%=sClass%>"><font size="3"><%=sDisplayMessage%></font></span></td>
  </tr>
<% } %>
  <tr>
    <td colspan="3" height="12" align="center"></td>
  </tr>
  <tr>
    <td width="30%" align="right"><%=webCustomer.getLabelText(cfInfo, "nameoncard-lab")%></td>
    <td width="1%">&nbsp;</td>
    <td>
      <input maxlength=30 size=40 value="<%=Utilities.getValue(ctInfo.CreditName)%>" name="creditname" style="width:340px" class="form-control input-sm">
    </td>
  </tr>
<tr>
  <td colspan="3" height="4" align="center"></td>
</tr>
  <tr>
    <td align="right"><%=webCustomer.getLabelText(cfInfo, "cardtype-lab")%></td>
    <td>&nbsp;</td>
    <td>
      <select name="credittype" style="width:340px" class="form-control input-sm">
        <%=webCustomer.getCreditCardList(ctInfo)%>
      </select><br>Supports Card: <%=webCustomer.getCardLinks()%>
    </td>
  </tr>
  <tr>
    <td align="right"><%=webCustomer.getLabelText(cfInfo, "cardno-lab")%></td>
    <td>&nbsp;</td>
    <td>
      <input maxlength=20 size=40 value="<%=Utilities.getValue(ctInfo.CreditNo)%>" name="creditno" style="width:340px" class="form-control input-sm">
    </td>
  </tr>
  <tr>
    <td align="right">Expire Month:</td>
    <td>&nbsp;</td>
    <td>
      <select name="expiredmonth" style="width:340px" class="form-control input-sm">
        <option value="None" selected><%=webCustomer.getLabelText(cfInfo, "month-lab")%></option>
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
    </td>
  </tr>
    <tr>
      <td align="right">Expire Year:</td>
      <td>&nbsp;</td>
      <td>
        <select name="expiredyear" style="width:340px" class="form-control input-sm">
          <option value="None" selected>Year</option>
          <%=webCustomer.getExpiredYear(null)%>
        </select>
      </td>
    </tr>
  <tr>
    <td align="right" valign="top"><%=webCustomer.getLabelText(cfInfo, "cardvn-lab")%></td>
    <td>&nbsp;</td>
    <td>
      <input maxlength=8 size=10 value="<%=Utilities.getValue(ctInfo.CSid)%>" name="csid" type="text" style="width:340px" class="form-control input-sm" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      <font size=2>(<%=webCustomer.getLabelText(cfInfo, "seehelp-lab")%> <a href="javascript:ChildWin=window.open('/staticfile/web/cards-help.html','cards_help','resizable=yes,scrollbars=no,width=460,height=680');ChildWin.focus()"><%=webCustomer.getLabelText(cfInfo, "help-lab")%></a>.)</font>
    </td>
  </tr>
<tr>
 <td colspan=3 align="center">
   <input class="btn btn-default active" type="submit" name="update" value="Update Now" style="width:160px;height:40px" onClick="return submitValidateForm(validateCreditCardInfo, document.creditcard, 'id_mainarea');">
</td>
</tr>
<TR>
 <TD height=10 colspan="3"></TD>
</TR>
</table>
 </FORM>
</div>
</div>
<SCRIPT>selectDropdownMenu(document.creditcard.expiredmonth, "<%=ctInfo.ExpiredMonth%>")</SCRIPT>
<SCRIPT>selectDropdownMenu(document.creditcard.expiredyear, "<%=ctInfo.ExpiredYear%>")</SCRIPT>
<% } %>