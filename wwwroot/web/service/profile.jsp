<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  ConfigInfo cfInfo = webCustomer.getConfigInfo();
  String sAction = webCustomer.getRealAction(request);
  String sDisplayMessage = null;
  String sClass = "successful";
  CustomerInfo ctInfo = null;

  if ("Profile-Update".equalsIgnoreCase(sAction))
  {
      CustomerWeb.Result ret = webCustomer.update(request, false);
      if (!ret.isSuccess())
      {
        Errors errObj = (Errors)ret.getInfoObject();
        sErrorMessage = errObj.getError();
        sErrorClass = "failed";
      }
      else
      {
         sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "account");
         ctInfo = (CustomerInfo)ret.getUpdateInfo();
      }
  }
  else
  {
      ctInfo = webCustomer.getCustomerInfo();
      if (Utilities.getValueLength(ctInfo.Country)==0)
      {
          ctInfo.Country = "USA";
          ctInfo.State = "CA";
          ctInfo.City = "Irvine";
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
  }

  String sPageTitle = "Account Profile Information";
%>
<div class="panel panel-warning">
<div class="panel-heading" align="center"><font size="3">Account Profile Information</font></div>
<div class="panel-body">
<table width="94%" align="center">
<tr>
 <td>
<FORM name="customer" action="/Clinician" method="post" class="form-horizontal">
<input type="hidden" name="customerid" value="<%=ctInfo.CustomerID%>">
<input type="hidden" name="action1" value="Profile-Update">
<INPUT type="hidden" name="country" value="USA">
<INPUT type="hidden" name="province" value="CA">
<INPUT type="hidden" name="ship_country" value="USA">
<INPUT type="hidden" name="ship_province" value="CA">
<TABLE class="table table-condensed" width="98%" align="center" border=0 cellpadding="1" cellspacing="1">
  <% if (sDisplayMessage!=null) { %>
  <tr>
    <td colspan="3" align="center"><span class="<%=sClass%>"><font size="3"><%=sDisplayMessage%></font></span></td>
  </tr>
  <% } %>
 <tr class="info">
   <td colspan=3><b>Your Personal & Institution Information:</b></td>
 </tr>
  <tr>
    <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "yourname-lab")%></td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=30 size=40 value="<%=ctInfo.Yourname%>" name="yourname" style="width:340px" class="form-control input-sm"></td>
  </tr>
  <tr>
    <td width="27%" align="right">Institution: </td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=60 size=40 value="<%=Utilities.getValue(ctInfo.CompanyName)%>" name="companyname" style="width:340px" class="form-control input-sm"></td>
  </tr>
  <tr>
    <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "address-lab")%></td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=60 size=40 value="<%=ctInfo.Address%>" name="address"  style="width:340px" class="form-control input-sm"></td>
  </tr>
  <tr>
    <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "city-lab")%></td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=25 size=40 value="<%=ctInfo.City%>" name="city"  style="width:340px" class="form-control input-sm"></td>
  </tr>
  <tr>
    <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "state-lab")%></td>
    <td width="1%">&nbsp;</td>
    <td>
      <select name="state" size="1" onChange="OnSelectStateChange(document.customer)" style="width:340px" class="form-control input-sm">
        <option value="None"><%=webCustomer.getLabelText(cfInfo, "state-sel")%></option>
      </select>
  </tr>
  <tr>
    <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "zippostal-lab")%></td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=10 size=20 value="<%=ctInfo.ZipCode%>" name="zipcode" style="width:340px" class="form-control input-sm"></td>
  </tr>
  <tr>
    <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "phone-lab")%></td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 value="<%=ctInfo.Phone%>" name="phone"  style="width:340px" class="form-control input-sm"></td>
  </tr>
<tr>
  <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "fax-lab")%></td>
  <td width="1%">&nbsp;</td>
  <td><input maxlength=20 size=40 value="<%=ctInfo.Fax%>" name="fax"  style="width:340px" class="form-control input-sm"></td>

    <tr class="info">
        <td colspan=3><b>Credit Card Information:</b></td>
    </tr>
    <tr>
        <td width="27%" align="right">Name on Credit Card:</td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=30 size=40 value="<%=Utilities.getValue(ctInfo.CreditName)%>" name="creditname" style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">Billing Address:</td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=60 size=40 value="<%=ctInfo.Ship_Address%>" name="ship_address"  style="width:340px" class="form-control input-sm"></td>
    </tr>

    <tr>
        <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "city-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=25 size=40 value="<%=ctInfo.Ship_City%>" name="ship_city"  style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">State: </td>
        <td width="1%">&nbsp;</td>
        <td>
            <select name="ship_state" size="1" onChange="OnSelectShipStateChange(document.customer)" style="width:340px" class="form-control input-sm">
                <option value="None"><%=webCustomer.getLabelText(cfInfo, "state-sel")%></option>
            </select>
        </td>
    </tr>
    <tr>
        <td width="27%" align="right">Zip:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=10 size=20 value="<%=ctInfo.Ship_ZipCode%>" name="ship_zipcode" style="width:340px" class="form-control input-sm"></td>
    </tr>

    <tr>
        <td width="27%" align="right">Credit Card Type:</td>
        <td width="1%">&nbsp;</td>
        <td>
            <select name="credittype" style="width:340px" class="form-control input-sm">
                <option value="" selected></option>
                <%=web.getCreditCardList3(Utilities.getValue(ctInfo.CreditType))%>)%>
            </select>
        </td>
    </tr>
    <tr>
        <td width="27%" align="right">Credit Card No:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=25 size=40 value="<%=ctInfo.CreditNo%>" name="creditno" style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">Expiration Month:</td>
        <td width="1%">&nbsp;</td>
        <td>
            <select name="expiredmonth" style="width:340px" class="form-control input-sm">
                <option value="" selected>Month</option>
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
        <td width="27%" align="right">Expiration Year:</td>
        <td width="1%">&nbsp;</td>
        <td>
            <select name="expiredyear" style="width:340px" class="form-control input-sm">
                <option value="" selected>Year</option>
                <%=web.getExpiredYear(null)%>
            </select>
        </td>
    </tr>

    <tr>
        <td width="27%" align="right">Verification Number:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=25 size=40 value="<%=ctInfo.CSid%>" name="csid"  style="width:340px" class="form-control input-sm"  onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'></td>
    </tr>

    <tr class="info">
      <td colspan="3"><b>Account Sign-In Information:</b></td>
    </tr>
  <tr>
    <td width="27%" align="right">Your Account Email:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=50 size=40 value="<%=ctInfo.EMail%>" name="email" style="width:340px" disabled class="form-control input-sm"></td>
  </tr>
  <tr>
    <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "password-lab")%></td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=17 value="<%=ctInfo.Password%>" name="password" type="password" disabled style="width:340px" class="form-control input-sm">
    </td>
  </tr>
  <tr>
    <td width="27%" align="right"><%=webCustomer.getLabelText(cfInfo, "confirmpass-lab")%></td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=17 value="<%=ctInfo.Password%>" name="cpassword" type="password" disabled style="width:340px" class="form-control input-sm">
        <input type="checkbox" name="enablepassword" value="1" onchange="enableChangePassword(document.customer)"> Enable to change password
    </td>
  </tr>
  <tr>
    <td class="row1" colspan="3" align="center"><br>
      <input class="btn btn-default active" type="submit" name="update" value="Update Profile" onClick="return submitValidateForm(validateClientAccount, document.customer, 'id_mainarea');" style="width:220px;height:50px;font-size:18px">
    </td>
  </tr>
</TABLE>
</FORM>
 </td>
</tr>
</table>
</div>
</div>
<SCRIPT>setupStateOption(document.customer, "<%=ctInfo.State%>", 0)</SCRIPT>
<SCRIPT>setupStateOption(document.customer, "<%=ctInfo.Ship_State%>", 1)</SCRIPT>
<SCRIPT>selectDropdownMenu(document.customer.expiredmonth, "<%=ctInfo.ExpiredMonth%>")</SCRIPT>
<SCRIPT>selectDropdownMenu(document.customer.expiredyear, "<%=ctInfo.ExpiredYear%>")</SCRIPT>
<SCRIPT>
function enableChangePassword(form)
{
   if (form.enablepassword.checked)
   {
      form.password.disabled = false;
      form.cpassword.disabled = false;
      setFocus(form.password);
   }
   else
   {
      form.password.disabled = true;
      form.cpassword.disabled = true;
   }
}

function validateClientAccount(form)
{
  //. check the your name
  if (checkFieldEmpty(form.yourname))
  {
     alert(getAlertMsg(8));
     setFocus(form.yourname);
     return false;
  }
  //. check the street address
  if (checkFieldEmpty(form.address))
  {
     alert(getAlertMsg(9));
     setFocus(form.address);
     return false;
  }
  //. check the city name
  if (checkFieldEmpty(form.city))
  {
     alert(getAlertMsg(10));
     setFocus(form.city);
     return false;
  }

  //. check the zip code
  if (checkFieldEmpty(form.zipcode))
  {
     alert(getAlertMsg(12));
     setFocus(form.zipcode);
     return false;
  }

  //.check the phone
  if (checkFieldEmpty(form.phone))
  {
     alert(getAlertMsg(13));
     setFocus(form.phone);
     return false;
  }

  //. check the password is empty or not
  if (form.enablepassword.checked)
  {
      //. check the confirm password
     if (checkFieldEmpty(form.password))
     {
         alert(getAlertMsg(19));
         setFocus(form.password);
         return false;
     }

    //. check the confirm password
    if (checkFieldEmpty(form.cpassword))
    {
       alert(getAlertMsg(19));
       setFocus(form.cpassword);
       return false;
    }

    if (form.password.value!=form.cpassword.value)
    {
      alert("The password and confirm password you entered is not the same.");
      setFocus(form.cpassword);
      return false;
    }
  }

  return true;
}

</SCRIPT>
</table>