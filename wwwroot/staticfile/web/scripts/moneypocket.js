<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology. -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function validateCreditAmount(form1, form2)
{
  if (form1.amount.value=="0")
  {
    alert("You have to enter a credit value that more than 0.")
    setFocus(form1.amount);
    return false;
  }

  form2.amount.value = form1.amount.value;
  return true;
}

function validateBillingInfo(form)
{
  //. check the credit card
  if (checkFieldEmpty(form.creditname))
  {
    alert(getAlertMsg(20));
    setFocus(form.creditname);
    return false;
  }
  //. check card no
  if (checkFieldEmpty(form.creditno))
  {
    alert(getAlertMsg(21));
    setFocus(form.creditno);
    return false;
  }

  if (form.creditno.value.length<15)
  {
    alert(getAlertMsg(22));
    setFocus(form.creditno);
    return false;
  }

  //. check Expired month
  if (form.expiredmonth.selectedIndex==0)
  {
    alert(getAlertMsg(23));
    form.expiredmonth.focus();
    return false;
  }
  //. check Expiration year
  if (form.expiredyear.selectedIndex==0)
  {
    alert(getAlertMsg(24));
    form.expiredyear.focus();
    return false;
  }

  //. check  security id
  if (checkFieldEmpty(form.csid))
  {
     alert(getAlertMsg(25));
     setFocus(form.csid);
     return false;
  }

  return onlyonce();
}

function submitFormByAction(form, sAction)
{
//   form.action = "memberlogin.jsp";
   form.action1.value = sAction;
   form.submit();
}

function onAccountFormLoad(form, nCustomerId)
{
  if (nCustomerId>0)
  {
    form.email.disabled = "true";
  }

  setFocus(form.yourname);
}

function validateAccount(form)
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

  //. check the provice
  if (form.country.options[form.country.selectedIndex].value!="USA")
  {//Non-USA
      if (checkFieldEmpty(form.province))
      {
         alert(getAlertMsg(11));
         setFocus(form.province);
         return false;
      }
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

  //. check the email
  if (checkFieldEmpty(form.email))
  {
     alert(getAlertMsg(6));
     setFocus(form.email);
     return false;
  }
  if (!validateEmail(form.email))
     return false;

  //. check the password
  if (checkFieldEmpty(form.password))
  {
     alert("You missed to input password.");
     setFocus(form.password);
     return false;
  }
  //. check the confirm password
  if (checkFieldEmpty(form.cpassword))
  {
     alert("You missed to input confirm password.");
     setFocus(form.cpassword);
     return false;
  }
  //.
  if (form.password.value!=form.cpassword.value)
  {
     alert("The password and confirm password are not the same.");
     setFocus(form.cpassword);
     return false;
  }

  return true;
}

function showAccountInfo(show, sectionname)
{
  if (show=="show")
  {
    showHideSpan('open', sectionname);

    showHideSpan('close', 'show_accountsection');
    showHideSpan('open', 'hide_accountsection');
  }
  else
  {
    showHideSpan('close', sectionname);

    showHideSpan('open', 'show_accountsection');
    showHideSpan('close', 'hide_accountsection');
  }
}

function forgotMemberPassword(form)
{
   form.action1.value = "PropertyForgotPassword";
//alert("submit=" +   form.action.value);
   form.submit();
}