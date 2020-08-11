<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/company.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.CompanyBean"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%
  CompanyBean bean = new CompanyBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_INFOMATION))
     return;

  String sAction = request.getParameter("action");
  CompanyInfo info;
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Update Now".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    CompanyBean.Result ret = bean.update(request);
    info = (CompanyInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "billing information");
    }
  }
  else if ("Billing Edit".equalsIgnoreCase(sAction))
  {//. It is a new domain company without finish of website setup
    info = bean.getCompayInfo(request);
  }
  else
  {
    info = bean.get(request);
  }

  String sHelpTag = "billinginfo";
  String sTitleLinks = "<b>Edit Credit Card Information</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can edit and update your credit card information.
<form name="company" action="billing.jsp" method="post" onSubmit="return validateBilling(this);">
  <input type="hidden" name="companyid" value="<%=info.CompanyID%>">
  <input type="hidden" name="creditno" value="<%=Utilities.getValue(info.CreditNo)%>">
  <input type="hidden" name="setup" value="<%=Utilities.getValue(request.getParameter("setup"))%>">
  <table cellspacing="1" cellpadding="2" border="0" align="center" class="forumline" width="90%">
    <tr>
      <th class="thHead" colspan="2" align="center">Billing Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
<% if ("0".equals(request.getParameter("setup"))) { %>
    <tr class="normal_row">
      <td width="24%" align="right" valign="top">Company Info:</td>
      <td valign="top"><b><%=info.CompanyName%><br>
      <%=info.Address%><br>
      <%=info.City%>, <%=info.State%> <%=info.ZipCode%></b><br>
      Email: <b><%=info.EMail%></b><br>
      Phone: <b><%=info.Phone%></b>&nbsp;&nbsp;&nbsp;Fax: <b><%=info.Fax%></b><br>&nbsp;
      </td>
    </tr>
<% } %>
    <tr class="normal_row">
      <td width="24%" align="right">Credit Card Billing Address:</td>
      <td>
        <input maxlength=60 name="address_bill" value="<%=Utilities.getValue(info.Address_Bill)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">City:</td>
      <td>
        <input maxlength=60 name="city_bill" value="<%=Utilities.getValue(info.City_Bill)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">State/Province:</td>
      <td>
        <input maxlength=30 name="state_bill" value="<%=Utilities.getValue(info.State_Bill)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Zip/Postal Code:</td>
      <td>
        <input maxlength=12 name="zipcode_bill" value="<%=Utilities.getValue(info.ZipCode_Bill)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Country:</td>
      <td>
        <input maxlength=20 name="country_bill" value="<%=Utilities.getValue(info.Country_Bill)%>" size="50">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">The Name on Credit Card:</td>
      <td><input name="nameoncard" value="<%=Utilities.getValue(info.NameOnCard)%>" size="40" maxlength="40"></td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Credit Card Number:</td>
      <td><input maxlength=20 name="creditno_x" value="<%=bean.getCreditNo(info.CreditNo)%>" size="30"> (If your card no is the same as before, leave it as is)</td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Credit Card Type:</td>
      <td>
        <select name="credittype">
          <option value="Visa" selected>Visa</option>
          <option value="Mastercard">Mastercard</option>
          <option value="American Express">American Express</option>
          <option value="Discover">Discover</option>
        </select>
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Expiration Date:</td>
      <td>Month: <input maxlength=2 size=4 name="expiredmonth" value="<%=Utilities.getValue(info.ExpiredMonth)%>">
        Year: <input maxlength=4 size=4 name="expiredyear" value="<%=Utilities.getValue(info.ExpiredYear)%>">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="24%" align="right">Card Verification Number:</td>
      <td><input maxlength=8 size=10 name="csid" value="<%=Utilities.getValue(info.Csid)%>"><font size=1>(For Visa, MasterCard & American Express only.
      <a href="javascript:ChildWin=window.open('/staticfile/web/cards-help.html','cards_help','resizable=yes,scrollbars=no,width=460,height=630');ChildWin.focus()">Help</a>)</font>
      </td>
    </tr>
    <tr>
      <td class="catBottom" colspan="2" align="center"><input type="submit" value="Update Now" name="action"></td>
    </tr>
  </table>
</form>
<SCRIPT>selectDropdownMenu(document.company.credittype, "<%=info.CreditType%>");</SCRIPT>
<SCRIPT>onBillingLoad(document.company);</SCRIPT>
<%@ include file="../share/footer.jsp"%>