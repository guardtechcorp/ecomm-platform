<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 10);
  ConfigInfo cfInfo = web.getConfigInfo();
//bean.showAllParameters(request, out);
  String sAction = web.getRealAction(request);
  String sCancel = web.getLabelText(cfInfo, "cancelupdate-but");//"cancelupdate-but=Cancel Update";
  String sDisplayMessage = null;
  String sClass = "successful";
  CustomerInfo ctInfo = null;
  String sSubmitValue = "Submit Update";
  String sCancelValue = "Cancel Update";

  if ("Submit Information".equalsIgnoreCase(sAction))
  {
//    CustomerWeb.Result ret = web.update(request, true);
    BasicBean.Result ret = BasicBean.getRequestResult(session);
    if (!ret.isSuccess())
    {
      ctInfo = (CustomerInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
      sCancel = web.getLabelText(cfInfo, "cancel-but");//"cancel-but=Cancel";
      sCancelValue = "Cancel";
      sSubmitValue = "Submit Information";
    }
  }
  else if ("Submit Update".equalsIgnoreCase(sAction))
  {
    BasicBean.Result ret = BasicBean.getRequestResult(session);
    ctInfo = (CustomerInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  else
  {
    if ("EditAccount".equalsIgnoreCase(sAction))
    {
      ctInfo =  web.getInfo(request);
      sAction = web.getLabelText(cfInfo, "submitupdate-but");//"submitupdate-but=Submit Update";
      sSubmitValue = "Submit Update";
    }
  }

  if (ctInfo==null)
  {
    ctInfo = CustomerInfo.getInstance2(true);
    ctInfo.Country = "USA";
    ctInfo.State = "CA";
    ctInfo.Ship_Country = "USA";
    ctInfo.Ship_State = "CA";
    ctInfo.Subscribe = 1;
    ctInfo.Taxable = 1;
    sAction = web.getLabelText(cfInfo, "submitinfo-but");//"submitinfo-but=Submit Infomation";
    sCancel = web.getLabelText(cfInfo, "cancel-but");//"Cancel";

    sSubmitValue = "Submit Information";
    sCancelValue = "Cancel";
  }
//Utilities.dumpObject(ctInfo);
%>
<div class="breadcrumbWrap">
  <a href="<%=web.encodedUrl("index.jsp")%>"><%=web.getLabelText(cfInfo, "shopping-link")%></a> &gt; <a href="<%=web.encodedUrl("index.jsp?action=shopcart")%>"><%=web.getLabelText(cfInfo, "cart-link")%></a>
  &gt; <font color="#FF0000"><%=web.getAccountLink(cfInfo, ctInfo)%></font> &gt; <%=web.getLabelText(cfInfo, "confirm-link")%> > <%=web.getLabelText(cfInfo, "finish-link")%>
</div>
<div class="newCustomerFormWrap">
<form name="customer" action="index.jsp" method="post">
<input type="hidden" name="customerid" value="<%=ctInfo.CustomerID%>">
<input type="hidden" name="action1" value="">
  <!-- <p><%=web.getLabelText(cfInfo, "filladdress-des")%></p> -->

      <% if (sDisplayMessage!=null) { %>
        <div class="<%=sClass%>"><%=sDisplayMessage%></div>
      <% } %>
<h2 class="pageHead">Account Information</h2>
      <div class="newCustBillWrap">
        <h5>Billing Address <!-- <%=web.getLabelText(cfInfo, "billaddress-lab")%> --></h5>
        <p class="headInfo">Fill in billing address for your payment method</p>
      <label><%=web.getLabelText(cfInfo, "yourname-lab")%></label>
        <input maxlength=30 size=40 value="<%=ctInfo.Yourname%>" name="yourname">
        <!--<br><%=web.getLabelText(cfInfo, "firstname-des")%> -->

      <label><%=web.getLabelText(cfInfo, "companyname-lab")%> <span class="optionalLabel"><%=web.getLabelText(cfInfo, "optional-des")%></span></label>
        <input maxlength=60 size=40 value="<%=Utilities.getValue(ctInfo.CompanyName)%>" name="companyname">
        <label><%=web.getLabelText(cfInfo, "address-lab")%></label>
        <input maxlength=60 size=40 value="<%=ctInfo.Address%>" name="address">

        <label><%=web.getLabelText(cfInfo, "city-lab")%></label>
      <input maxlength=25 size=40 value="<%=ctInfo.City%>" name="city">

          <div class="stateDropWrap">
              <label><%=web.getLabelText(cfInfo, "state-lab")%></label>
            <select name="state" size="1" onChange="OnSelectStateChange(document.customer)">
            <option value="None"><%=web.getLabelText(cfInfo, "state-sel")%></option>
          </select>
        </div>
        <div class="otherStateWrap">
          <label><%=web.getLabelText(cfInfo, "other-lab")%></label>
          <input type="text" size="17" maxlength="30" name="province" value="">
        </div>

      <label><%=web.getLabelText(cfInfo, "zippostal-lab")%></label>
        <input maxlength=10 size=20 value="<%=ctInfo.ZipCode%>" name="zipcode">

      <label><%=web.getLabelText(cfInfo, "country-lab")%></label>
          <select name="country" size="1" onChange="OnSelectCountryChange(document.customer)">
            <option value="None"><%=web.getLabelText(cfInfo, "country-sel")%></option>
          </select>

        <label><%=web.getLabelText(cfInfo, "phone-lab")%></label>
      <input maxlength=20 size=40 value="<%=ctInfo.Phone%>" name="phone">
</div>

  <div class="newCustShipWrap">
    <h5>Shipping Address<!-- <%=web.getLabelText(cfInfo, "shipaddress-des")%> --></h5>
    <p class="headInfo">Enter <strong>ONLY</strong> if different from billing address</p>

      <label><%=web.getLabelText(cfInfo, "shipname-lab")%></label>
        <input maxlength=30 size=40 value="<%=Utilities.getValue(ctInfo.Ship_Yourname)%>" name="ship_yourname">
        <!-- <br><%=web.getLabelText(cfInfo, "firstname-des")%> -->

      <label><%=web.getLabelText(cfInfo, "companyname-lab")%> <span class="optionalLabel"><%=web.getLabelText(cfInfo, "optional-des")%></span></label>
        <input maxlength=30 size=40 value="<%=Utilities.getValue(ctInfo.Ship_CompanyName)%>" name="ship_companyname">

      <label><%=web.getLabelText(cfInfo, "shipaddress-lab")%></label>
        <input maxlength=60 size=40 value="<%=Utilities.getValue(ctInfo.Ship_Address)%>" name="ship_address">

      <label><%=web.getLabelText(cfInfo, "city-lab")%></label>
      <input maxlength=25 size=40 value="<%=Utilities.getValue(ctInfo.Ship_City)%>" name="ship_city">

      <div class="stateDropWrap">
          <label><%=web.getLabelText(cfInfo, "state-lab")%></label>
          <select name="ship_state" size="1" onChange="OnSelectShipStateChange(document.customer)">
            <option value="None"><%=web.getLabelText(cfInfo, "state-sel")%>Select State</option>
          </select>
        </div>
        <div class="otherStateWrap">
          <label><%=web.getLabelText(cfInfo, "other-lab")%></label>
          <input type="text" size="17" maxlength="30" name="ship_province" value="">
        </div>

      <label><%=web.getLabelText(cfInfo, "zippostal-lab")%></label>
      <input maxlength=10 size=20 value="<%=Utilities.getValue(ctInfo.Ship_ZipCode)%>" name="ship_zipcode">

      <label><%=web.getLabelText(cfInfo, "country-lab")%></label>
          <select name="ship_country" size="1" onChange="OnSelectShipCountryChange(document.customer)">
            <option value="None"><%=web.getLabelText(cfInfo, "country-sel")%></option>
          </select>

      <label><%=web.getLabelText(cfInfo, "phone-lab")%> <span class="optionalLabel"><%=web.getLabelText(cfInfo, "optional-des")%></span></label>
      <input maxlength=20 size=40 value="<%=Utilities.getValue(ctInfo.Ship_Phone)%>" name="ship_phone">
  </div>
  <div class="newCustEmailWrap">
      <h5>Email info <!-- <%=web.getLabelText(cfInfo, "emailinfo-lab")%> --></h5>
      <p class="headInfo">Order confirmations will be sent here</p>

      <label><%=web.getLabelText(cfInfo, "email-lab")%></label>
        <input maxlength=50 size=40 value="<%=Utilities.getValue(ctInfo.EMail)%>" name="email">

        <label><%=web.getLabelText(cfInfo, "acceptnews-lab")%></label>
          <select name="subscribe">
            <option value=1 <%=web.getSelected(1, ctInfo.Subscribe)%>><%=web.getLabelText(cfInfo, "yes-sel")%></option>
            <option value=0 <%=web.getSelected(0, ctInfo.Subscribe)%>><%=web.getLabelText(cfInfo, "no-sel")%></option>
          </select>
  </div>
<div class="newCustPwWrap">
        <h5>Account Information</h5>
        <p class="headInfo">Please enter a password, our online system will create an account for you, and the account name is your Email address. You can login to your account at any time, and you do not need to fill in information again for future purchase.</p>

      <label><%=web.getLabelText(cfInfo, "password-lab")%></label>
        <input maxlength=20 size=17 value="<%=ctInfo.Password%>" name="password" type="password">

      <label><%=web.getLabelText(cfInfo, "confirmpass-lab")%></label>
        <input maxlength=20 size=17 value="<%=ctInfo.Password%>" name="cpassword" type="password">
</div>
<div class="submitWrap">
      <input class="newCustSubmit" type="submit" name="update" value="<%=sAction%>" onClick="setAction(document.customer, '<%=sSubmitValue%>'); return validateCustomerAccount(document.customer);">
      <input class="newCustClear" type="submit" name="cancel" value="<%=sCancel%>" onClick="setAction(document.customer, '<%=sCancelValue%>');">
</div>
</form>
</div>
<div class="disclaimerBox">
<!-- <%=web.getLabelText(cfInfo, "info-lab")%> -->
  <%=web.getLabelText(cfInfo, "info-des")%>
</div>
<script>setupOption(document.customer.country, g_Country, "<%=ctInfo.Country%>");</script>
<script>setupStateOption(document.customer, "<%=ctInfo.State%>", 0);</script>
<script>onCustomerAccountLoad(document.customer, <%=ctInfo.CustomerID%>);</script>
<script>setupOption(document.customer.ship_country, g_Country, "<%=ctInfo.Ship_Country%>");</script>
<script>setupStateOption(document.customer, "<%=ctInfo.Ship_State%>", 1);</script>
<% } %>
