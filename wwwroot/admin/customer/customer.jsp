<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/customer.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CustomerBean"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  CustomerBean bean = new CustomerBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CUSTOMER))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  boolean bSuccessful = false;
  String sClass = "successful";
  CustomerInfo ctInfo = null;
  if ("Add Customer".equalsIgnoreCase(sAction))
  {
    CustomerBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      ctInfo = (CustomerInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      bSuccessful = false;
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "customer");
//      ctInfo = (CustomerInfo)ret.getUpdateInfo();
    }
  }
  else if ("Update Customer".equalsIgnoreCase(sAction))
  {
    CustomerBean.Result ret = bean.update(request, false);
    ctInfo = (CustomerInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      bSuccessful = false;
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "customer");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
      ctInfo =  bean.get(request);
      sAction = "Update Customer";
  }
  else if ("View".equalsIgnoreCase(sAction))
  {
      ctInfo =  bean.getByID(request);
      sAction = null;//"Update Customer";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     ctInfo =  bean.getPrevOrNext(sAction);
//System.out.println("cgInfo = "+ cgInfo);
     sAction = "Update Customer";
  }

  if (ctInfo==null)
  {
    ctInfo = CustomerInfo.getInstance2(true);
    ctInfo.Subscribe = 1;
    ctInfo.Taxable = 1;
    sAction = "Add Customer";
  }

  String sHelpTag = "customer";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Customer".equalsIgnoreCase(sAction))
  {
     sTitleLinks = bean.getNavigation(request, "Add a New Customer");
     sDescription = "The form below will allow you to create a new customer.";
  }
  else
  {
     sTitleLinks = bean.getNavigation(request, "Edit the Customer");
     sDescription = "The form below will allow you to edit and update the customer information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<FORM name="customer" action="customer.jsp" method=post  onSubmit="return validateCustomer(document.customer, '<%=ctInfo.CreditNo%>')">
  <input type="hidden" name="customerid" value="<%=ctInfo.CustomerID%>">
<% if (!"Add Customer".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("customer.jsp?")%></td>
  </tr>
</table>
<% } %>
<TABLE class="forumline" cellSpacing=2 cellPadding=1 width="95%" align="center" border=0>
    <TR>
      <TH class=thHead colSpan=4>Account Information</TH>
    </TR>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="4" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <TR>
      <TD class="row1" colSpan=4 height=12>
        <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
          <TR>
            <TD>Email Address</TD>
            <TD>Password</TD>
            <TD>Confirm Password</TD>
          </TR>
          <TR>
            <TD><INPUT maxLength=40 size=24 value="<%=ctInfo.EMail%>" name="email"> <%=Utilities.getValue(ctInfo.Option1)%></TD>
            <TD><INPUT maxLength=20 size=12 value="<%=ctInfo.Password%>" name="password" type="password">(<%=ctInfo.Password%>)</TD>
            <TD><INPUT maxLength=20 size=12 value="<%=ctInfo.Password%>" name="cpassword" type="password"></TD>
          </TR>
          <TR>
            <TD colspan=3 height=10></TD>
          </TR>
          <TR>
            <TD>Name On Your Credit Card</TD>
            <TD>Credit Card Type</TD>
            <TD>Security ID</TD>
          </TR>
          <TR>
            <TD>
              <INPUT maxLength=20 size=24 value="<%=ctInfo.CreditName%>" name="creditname">
              </TD>
            <TD>
              <SELECT name="credittype" onChange="OnSelectCreditType(document.customer)">
                <option value="None" selected>Select</option>
               <!--%=bean.getCreditCardList(ctInfo)%-->
                <option value="Visa">Visa</option>
                <option value="MasterCard">MasterCard</option>
                <option value="Discover">Discover</option>
                <option value="American Express">American Express</option>
                <option value="Paypal">Paypal</option>
                <option value="Check">Check</option>
              </SELECT>
            </TD>
            <TD><input maxlength=8 size=8 value="<%=Utilities.getValue(ctInfo.CSid)%>" name="csid" type="text"></TD>
          </TR>
          <TR>
            <TD colspan=3 height=10></TD>
          </TR>
          <tr>
            <td>Credit Card Number</td>
            <td>Expiration Date</td>
            <td>&nbsp;</td>
          </tr>
          <TR>
            <TD>
              <input maxlength=20 size=24 value="<%=Utilities.getValue(ctInfo.CreditNo)%>" name="creditno" <%=bean.getCreditNoFieldEnabled()%>>
            </TD>
            <TD>
              <select name="expiredmonth">
                <option value=00 selected>Month</OPTION>
                <option value=01>January</OPTION>
                <option value=02>February</OPTION>
                <option value=03>March</OPTION>
                <option value=04>April</OPTION>
                <option value=05>May</OPTION>
                <option value=06>June</OPTION>
                <option value=07>July</OPTION>
                <option value=08>August</OPTION>
                <option value=09>September</OPTION>
                <option value=10>October</OPTION>
                <option value=11>November</OPTION>
                <option value=12>December</option>
              </select>
              <select name="expiredyear">
                <option value="2000">Year</option>
                <%=bean.getExpiredYear(ctInfo.ExpiredYear)%>
              </select>
            <TD></TD>
          </TR>
          <TR>
            <TD colspan=3 height=10></TD>
          </TR>
          <tr>
            <td>Newsletter</td>
            <td>Taxable</td>
            <td>Member</td>
          </tr>
          <TR>
            <TD>
              <select name="subscribe">
                <option value=1 <%=bean.getSelected(1, ctInfo.Subscribe)%>>Yes</option>
                <option value=0 <%=bean.getSelected(0, ctInfo.Subscribe)%>>No</option>
              </select>
            </TD>
            <TD>
              <select name="taxable">
                <option value=1 <%=bean.getSelected(1, ctInfo.Taxable)%>>Yes</option>
                <option value=0 <%=bean.getSelected(0, ctInfo.Taxable)%>>No</option>
              </select>
            <TD>
              <select name="member">
                <option value=1 <%=bean.getSelected(1, ctInfo.Member)%>>Yes</option>
                <option value=0 <%=bean.getSelected(0, ctInfo.Member)%>>No</option>
              </select>
<% if (ctInfo.Member!=0) {%>
&nbsp;&nbsp;<a href='memberprice.jsp?action=edit&customerid=<%=ctInfo.CustomerID%>'>Edit Member Prices</a>
<% } %>
            </TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR>
      <TD class="row2" colSpan=4><b>Billing Address: </b>(Note: Billing address is the address assigned to your credit card)</TD>
    </TR>
    <TR>
    <TR>
      <TD class="row1" colSpan=4 height=177>
        <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0 height="117">
          <TR>
            <TD colSpan=3>Name</TD>
            <TD width="31%">Company Name(Optional)</TD>
          </TR>
          <TR>
            <TD colSpan=3><INPUT maxLength=20 size=24 value="<%=ctInfo.Yourname%>" name="yourname"></TD>
            <TD width="31%"> <INPUT maxLength=60 size=24 value="<%=Utilities.getValue(ctInfo.CompanyName)%>" name="companyname">
            </TD>
          </TR>
          <TR>
            <TD colspan=4 height=10></TD>
          </TR>
          <TR>
            <TD colSpan=4>Address</TD>
          </TR>
          <TR>
            <TD colSpan=4><INPUT maxLength=60 size=40 value="<%=ctInfo.Address%>" name="address"></TD>
          </TR>
          <tr>
            <td colspan=4 height=10></td>
          </tr>
          <TR>
            <TD width="21%">City</TD>
            <TD width="21%">State</TD>
            <TD width="27%">Other<b> </b></TD>
            <TD width="31%">Zip Code/Postal Code</TD>
          </TR>
          <TR>
            <TD width="21%"><input maxlength=25 size=15  value="<%=ctInfo.City%>" name="city"></TD>
            <TD width="21%"><select name="state" size="1" onChange="OnSelectStateChange(document.customer)">
                <option value="None">Selete State</option>
              </select></TD>
            <TD width="27%"><input type="text" size="11" maxlength="30" name="province" value=""></TD>
            <TD width="31%"><input maxlength=10 size=5 value="<%=ctInfo.ZipCode%>" name="zipcode"></TD>
          </TR>
          <tr>
            <td colspan=4 height=10></td>
          </tr>
          <TR>
            <TD width="21%"> Country</TD>
            <TD colspan="2"><select name="country" size="1"  onChange="OnSelectCountryChange(document.customer)">
                <option value="None">Select Country</option>
              </select>
            </TD>
            <TD width="31%"></TD>
          </TR>
          <tr>
            <td colspan=4 height=10></td>
          </tr>
          <TR>
            <TD colSpan=4>Phone Number</TD>
          </TR>
          <TR>
            <TD colSpan=4><INPUT maxLength=20 size=15 value="<%=ctInfo.Phone%>" name="phone"></TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
    <TR>
      <TD class=row2 colSpan=4><b>Shipping Address:</b> (Note:Filling in shipping address ONLY if it is different from billing address above)</TD>
    </TR>
    <TR>
    <TR>
      <TD class=row1 colSpan=4 height=160>
        <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
          <TR>
            <TD colSpan=3>Name</TD>
            <TD width="40%">Company Name(Optional)</TD>
          </TR>
          <TR>
            <TD colSpan=3><INPUT maxLength=20 size=24 value="<%=ctInfo.Ship_Yourname%>" name="ship_yourname"></TD>
            <TD width="40%"><INPUT maxLength=30 size=24 value="<%=Utilities.getValue(ctInfo.Ship_CompanyName)%>" name="ship_companyname">
            </TD>
          </TR>
          <tr>
            <td colspan=4 height=10></td>
          </tr>
          <TR>
            <TD colSpan=4>Address</TD>
          </TR>
          <TR>
            <TD colSpan=4><INPUT maxLength=60 size=40 value="<%=ctInfo.Ship_Address%>" name="ship_address"></TD>
          </TR>
          <tr>
            <td colspan=4 height=10></td>
          </tr>
          <TR>
            <TD width="21%">City</TD>
            <TD width="21%">State</TD>
            <TD width="27%">Other</TD>
            <TD width="31%">Zip Code/Postal Code</TD>
          </TR>
          <TR>
            <TD width="21%"><INPUT maxLength=25 size=15 value="<%=ctInfo.Ship_City%>" name="ship_city"></TD>
            <TD width="21%"><select name="ship_state" size="1" onChange="OnSelectShipStateChange(document.customer)">
                <option value="None">Select State</option>
              </select></TD>
            <TD width="27%"><input type="text" size="11" maxlength="30" name="ship_province" value=""></TD>
            <TD width="31%"><INPUT maxLength=10 size=5 value="<%=ctInfo.Ship_ZipCode%>" name="ship_zipcode"></TD>
          </TR>
          <tr>
            <td colspan=4 height=10></td>
          </tr>
          <TR>
            <TD>Country</TD>
            <TD colSpan=2><select name="ship_country" size="1" onChange="OnSelectShipCountryChange(document.customer)">
                <option value="None">Select Country</option>
              </select>
            </TD>
            <TD>&nbsp;</TD>
          </TR>
          <tr>
            <td colspan=4 height=10></td>
          </tr>
          <TR>
            <TD colSpan=4>Phone Number</TD>
          </TR>
          <TR>
            <TD colSpan=4><INPUT maxLength=20 size=14 value="<%=ctInfo.Ship_Phone%>" name="ship_phone"></TD>
          </TR>
        </TABLE>
      </TD>
    </TR>
<% if (sAction!=null) {%>
    <TR>
      <TD class=catBottom colSpan=4 align="center"><input type="submit" name="action" value="<%=sAction%>"></TD>
    </TR>
<% } %>
</TABLE>
</FORM>
<!--SCRIPT>setupOption(document.customer.state, g_State, "<%=ctInfo.State%>");</SCRIPT-->
<SCRIPT>setupOption(document.customer.country, g_Country, "<%=ctInfo.Country%>");</SCRIPT>
<SCRIPT>setupStateOption(document.customer, "<%=ctInfo.State%>", 0);</SCRIPT>
<!--SCRIPT>setupOption(document.customer.ship_state, g_State, "<%=ctInfo.Ship_State%>");</SCRIPT-->
<SCRIPT>setupOption(document.customer.ship_country, g_Country, "<%=ctInfo.Ship_Country%>");</SCRIPT>
<SCRIPT>setupStateOption(document.customer, "<%=ctInfo.Ship_State%>", 1);</SCRIPT>
<SCRIPT>OnCustomerLoad(document.customer);</SCRIPT>
<SCRIPT>CreditCardSelect(document.customer, "<%=ctInfo.CreditType%>", "<%=ctInfo.ExpiredMonth%>", "<%=ctInfo.ExpiredYear%>");</SCRIPT>
<%@ include file="../share/footer.jsp"%>
