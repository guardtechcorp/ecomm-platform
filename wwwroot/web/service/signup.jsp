<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
//web.showAllParameters(request, out);
//http://o7planning.org/en/10397/using-google-recaptcha-with-java-web-application7
//.http://o7planning.org/en/11199/java-restful-web-services-tutorial-for-beginners
//. http://o7planning.org/en/11217/create-java-restful-client-with-jersey-client    
%>
<script src='https://www.google.com/recaptcha/api.js'></script>

<div class="panel panel-warning">
<div class="panel-heading" align="center"><font size="3">Register New Account</font></div>
<div class="panel-body">
<FORM name="signup" action="/Clinician" method="post" class="form-horizontal">
<INPUT type="hidden" name="action1" value="SignUp-Submit">
<INPUT type="hidden" name="country" value="USA">
<INPUT type="hidden" name="province" value="CA">
<INPUT type="hidden" name="ship_country" value="USA">
<INPUT type="hidden" name="ship_province" value="CA">
<TABLE class="table table-condensed" width="98%" align="center" border=0 cellpadding="1" cellspacing="1">
    <% if (sErrorMessage!=null) { %>
    <tr>
        <td colspan="3" align="center"><span class="<%=sErrorClass%>"><font size="3"><%=Utilities.getValue(sErrorMessage)%></font></span></td>
    </tr>
    <% } %>

    <tr class="info">
        <td colspan="3"><b>Account Sign-In Information:</b></td>
    </tr>
    <tr>
        <td width="27%" align="right">* Account Email:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=50 size=40 value="<%=Utilities.getValue(request.getParameter("email"))%>" name="email" style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">* Password:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=17 value="<%=Utilities.getValue(request.getParameter("password"))%>" name="password" type="password" style="width:340px" class="form-control input-sm">
        </td>
    </tr>
    <tr>
        <td width="27%" align="right">* Confirm:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=17 value="<%=Utilities.getValue(request.getParameter("cpassword"))%>" name="cpassword" type="password" style="width:340px" class="form-control input-sm">
        </td>
    </tr>

    <tr class="info">
        <td colspan=3><b>Your Personal & Institution Information:</b></td>
    </tr>
    <tr>
        <td width="27%" align="right">* Your Name:</td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=30 size=40 value="<%=Utilities.getValue(request.getParameter("yourname"))%>" name="yourname" style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">* Institution:</td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=60 size=40 value="<%=Utilities.getValue(request.getParameter("companyname"))%>" name="companyname" style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">* Address:</td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=60 size=40 value="<%=Utilities.getValue(request.getParameter("address"))%>" name="address"  style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">* City:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=25 size=40 value="<%=Utilities.getValue(request.getParameter("city"))%>" name="city"  style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">* State:</td>
        <td width="1%">&nbsp;</td>
        <td>
            <select name="state" size="1" onChange="OnSelectStateChange(document.customer)" style="width:340px" class="form-control input-sm">
                <option value="None">[Select State]</option>
            </select>
    </tr>

    <tr>
        <td width="27%" align="right">* Zip:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=10 size=20 value="<%=Utilities.getValue(request.getParameter("zipcode"))%>" name="zipcode" style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">* Phone:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("phone"))%>" name="phone"  style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">Fax:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("fax"))%>" name="fax"  style="width:340px" class="form-control input-sm"></td>

    <tr class="info">
        <td colspan=3><b>Credit Card Information:</b></td>
    </tr>
    <tr>
        <td width="27%" align="right">Name on Credit Card:</td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=30 size=40 value="<%=Utilities.getValue(request.getParameter("creditname"))%>" name="creditname" style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">Billing Address:</td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=60 size=40 value="<%=Utilities.getValue(request.getParameter("ship_address"))%>" name="ship_address"  style="width:340px" class="form-control input-sm"></td>
    </tr>

    <tr>
        <td width="27%" align="right"> City:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=25 size=40 value="<%=Utilities.getValue(request.getParameter("ship_city"))%>" name="ship_city"  style="width:340px" class="form-control input-sm"></td>
    </tr>
    <tr>
        <td width="27%" align="right">State:</td>
        <td width="1%">&nbsp;</td>
        <td>
            <select name="ship_state" size="1" onChange="OnSelectShipStateChange(document.customer)" style="width:340px" class="form-control input-sm">
                <option value="None">[Select State]</option>
            </select>
    </tr>

    <tr>
        <td width="27%" align="right">Zip:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=10 size=20 value="<%=Utilities.getValue(request.getParameter("ship_zipcode"))%>" name="ship_zipcode" style="width:340px" class="form-control input-sm"></td>
    </tr>

    <tr>
        <td width="27%" align="right">Credit Card Type:</td>
        <td width="1%">&nbsp;</td>
        <td>
            <select name="credittype" style="width:340px" class="form-control input-sm">
                <option value="" selected></option>
                <%=web.getCreditCardList3(Utilities.getValue(request.getParameter("credittype")))%>)%>
            </select>
        </td>
    </tr>

    <tr>
        <td width="27%" align="right">Credit Card No:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=25 size=40 value="<%=Utilities.getValue(request.getParameter("creditno"))%>" name="creditno" style="width:340px" class="form-control input-sm"></td>
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
        <td><input maxlength=25 size=40 value="<%=Utilities.getValue(request.getParameter("csid"))%>" name="csid"  style="width:340px" class="form-control input-sm"  onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'></td>
    </tr>

    <tr>
        <td width="27%" align="right">Identify:<br><font size="2">(Just Click Box)</font></td>
        <td width="1%">&nbsp;</td>
        <td align="left"> <div class="g-recaptcha" data-sitekey="6Lfx9y8UAAAAAEfn9F9Wu5XobwexjMmiSvD5X8Vv" data-callback="onCaptchaClicked"></div></td>
    </tr>

    <tr>
        <td class="row1" colspan="3" align="center"><br>
            <input class="btn btn-default active" type="submit" name="submit" value="Sign Up" onClick="return validateSignUp(document.signup)" style="width:220px;height:50px;font-size:18px">
        </td>
    </tr>
</TABLE>


<!--
<table width="80%" align="center">
<tr>
 <td>
 <% if (sErrorMessage!=null) { %>
 <div class="form-group" align="center">
  <span class="<%=sErrorClass%>" id="id_message"><font size="3"><%=Utilities.getValue(sErrorMessage)%></font></span>
 </div>
 <% } %>

 <div class="form-group">
   <label class="control-label col-sm-3" for="yourname">* Name:</label>
   <div class="col-sm-9">
     <input type="text" class="form-control" id="yourname" placeholder2="Enter your name" maxlength=50 name="yourname" value="<%=Utilities.getValue(request.getParameter("yourname"))%>">
   </div>
 </div>
  <div class="form-group">
    <label class="control-label col-sm-3" for="email">* Email:</label>
    <div class="col-sm-9">
      <input type="email" class="form-control" id="email" placeholder2="Enter email" maxlength=50 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>">
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-sm-3" for="pwd">* Password:</label>
    <div class="col-sm-9">
      <input class="form-control" id="pwd" placeholder2="Enter password" type="password" maxlength=20 name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>">
    </div>
  </div>

 <div class="form-group">
   <label class="control-label col-sm-3" for="cpwd">* Confirm:</label>
   <div class="col-sm-9">
     <input class="form-control" id="cpwd" placeholder2="Enter confirm password" type="password" maxlength=20 name="cpassword" value="<%=Utilities.getValue(request.getParameter("cpassword"))%>">
   </div>
 </div>

<div class="form-group">
 <label class="control-label col-sm-3">* Institution:</label>
 <div class="col-sm-9">
   <input class="form-control" maxlength=60 size=40 value="<%=Utilities.getValue(request.getParameter("companyname"))%>" name="companyname">
 </div>
  </div>

  <div class="form-group">
 <label class="control-label col-sm-3">* Address:</label>
 <div class="col-sm-9">
   <input class="form-control"  maxlength=60 size=40 value="<%=Utilities.getValue(request.getParameter("address"))%>" name="address">
 </div>
   </div>

 <div class="form-group">
 <label class="control-label col-sm-3">* City:</label>
 <div class="col-sm-9">
   <input class="form-control" maxlength=25 size=40 value="<%=Utilities.getValue(request.getParameter("city"))%>" name="city">
 </div>
   </div>

 <div class="form-group">
 <label class="control-label col-sm-3">* State:</label>
 <div class="col-sm-9">
     <select name="state" size="1" onChange="OnSelectStateChange(document.customer)" class="form-control">
       <option value="None">[Select State]</option>
     </select>
 </div>
 </div>

 <div class="form-group">
 <label class="control-label col-sm-3">* Zip:</label>
 <div class="col-sm-9">
   <input class="form-control" maxlength=10 size=20 value="<%=Utilities.getValue(request.getParameter("zipcode"))%>" name="zipcode">
 </div>
   </div>

 <div class="form-group">
 <label class="control-label col-sm-3">* Phone:</label>
 <div class="col-sm-9">
   <input class="form-control" maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("phone"))%>" name="phone">
 </div>
   </div>

 <div class="form-group">
 <label class="control-label col-sm-3">Fax:</label>
 <div class="col-sm-9">
 <input class="form-control" maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("fax"))%>" name="fax">
</div>
  </div>

     <div class="form-group">
         <label class="control-label col-sm-3">Name on Card:</label>
         <div class="col-sm-9">
             <input class="form-control" maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("creditname"))%>" name="creditname">
         </div>
     </div>

     <div class="form-group">
         <label class="control-label col-sm-3">Address on Card:</label>
         <div class="col-sm-9">
            <input maxlength=60 size=40 value="<%=Utilities.getValue(request.getParameter("ship_address"))%>" name="ship_address"  class="form-control input-sm">
         </div>
     </div>

    <div class="form-group">
         <label class="control-label col-sm-3">Credit Card Type:</label>
         <div class="col-sm-9">
             <select name="credittype" class="form-control input-sm">
                 <option value="" selected></option>
                 <%=web.getCreditCardList3(Utilities.getValue(request.getParameter("credittype")))%>)%>
             </select>
         </div>
     </div>

     <div class="form-group">
         <label class="control-label col-sm-3">Credit Card No:</label>
         <div class="col-sm-9">
             <input class="form-control" maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("creditno"))%>" name="creditno">
         </div>
     </div>

     <div class="form-group">
         <label class="control-label col-sm-3">Expiration Month:</label>
         <div class="col-sm-9">
             <select name="expiredmonth" class="form-control input-sm">
                 <option value="" selected></option>
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
         </div>
     </div>

     <div class="form-group">
         <label class="control-label col-sm-3">Expiration Year:</label>
         <div class="col-sm-9">
             <select name="expiredyear" class="form-control input-sm">
                 <option value="" selected></option>
                 <%=web.getExpiredYear(null)%>
             </select>
         </div>
     </div>

     <div class="form-group">
         <label class="control-label col-sm-3"><a title="What is it?" href="javascript:ChildWin=window.open('/staticfile/web/cards-help.html','cards_help','resizable=yes,scrollbars=no,width=460,height=680');ChildWin.focus()">Verification Number</a>:</label>
         <div class="col-sm-9">
             <input class="form-control" maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("csid"))%>" name="csid" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
         </div>
     </div>

 <div class="form-group">
 <label class="control-label col-sm-3">Identify:<br><font size="1">(Just Click Box)</font></label>
  <div class="col-sm-9 g-recaptcha" data-sitekey="6Lfx9y8UAAAAAEfn9F9Wu5XobwexjMmiSvD5X8Vv" data-callback="onCaptchaClicked"></div>
 </div>

<div class="form-group">
<br>
</div>
     
 <div align="center">
    <input type="submit" value="Sign Up" class="btn btn-default btn-md" name="sumbit" onClick="return validateSignUp(document.signup)" style="width:220px;height:50px;font-size:22px">
 </div>

 </td>
</tr>
</table>
-->

</FORM>
<SCRIPT>
$(document).ready(function()
{
    setupStateOption(document.signup, "California", 0);
    setupStateOption(document.signup, "California", 1);

    document.signup.state.selectedIndex = 6;
    document.signup.ship_state.selectedIndex = 6;

    setFocus(document.signup.email);
});

var g_CaptchaClicked = false;
function onCaptchaClicked()
{
//   alert("You click it now");
    g_CaptchaClicked = true;
}

function validateSignUp(form)
{
  //. check the email
  if (checkFieldEmpty(form.email))
  {
     alert(getAlertMsg(6));
     setFocus(form.email);
     return false;
  }
  if (!validateEmail(form.email))
     return false;

    //. check the confirm password
   if (checkFieldEmpty(form.password) || form.password.value.length<6 || form.password.value.length>12)
   {
       alert("You need to input a password which length should be beteen 6 and 12.");
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

    //. check the your name
    if (checkFieldEmpty(form.yourname))
    {
        alert(getAlertMsg(8));
        setFocus(form.yourname);
        return false;
    }

    if (checkFieldEmpty(form.companyname))
    {
       alert("You missed to enter Institution.");
       setFocus(form.companyname);
       return false;
    }

    if (checkFieldEmpty(form.address))
    {
       alert(getAlertMsg(9));
       setFocus(form.address);
       return false;
    }

    if (checkFieldEmpty(form.city))
    {
       alert(getAlertMsg(10));
       setFocus(form.city);
       return false;
    }

    if (checkFieldEmpty(form.zipcode))
    {
       alert(getAlertMsg(12));
       setFocus(form.zipcode);
       return false;
    }

    if (checkFieldEmpty(form.phone))
    {
       alert(getAlertMsg(13));
       setFocus(form.phone);
       return false;
    }

    if (!g_CaptchaClicked)
    {
       alert("You have click the box of \"I'm not a robot\" to identify yourself.")
       return false;
    }

    return true;
}
</SCRIPT>
</div>
</div>