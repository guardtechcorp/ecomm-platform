<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onSignUpLoad(form)
{
  setFocus(form.domainname);
}

function validateSignup(form)
{
  //. check the email
  if (checkFieldEmpty(form.domainname))
  {
     alert("You missed to input domainname.");
     setFocus(form.domainname);
     return false;
  }
  if (!checkDomain(form.domainname.value))
  {
     setFocus(form.domainname);
     return false;
  }

  if (checkFieldEmpty(form.yourname))
  {
     alert("You missed to input your name.");
     setFocus(form.yourname);
     return false;
  }

  if (checkFieldEmpty(form.email))
  {
     alert("You missed to input E-Mail.");
     setFocus(form.email);
     return false;
  }
  if (!validateEmail(form.email))
     return false;

  if (checkFieldEmpty(form.phone))
  {
     alert("You missed to input phone number.");
     setFocus(form.phone);
     return false;
  }

  if (checkFieldEmpty(form.companyname))
  {
   alert("You missed to input company name.");
   setFocus(form.companyname);
   return false;
  }

  if (checkFieldEmpty(form.address))
  {
     alert("You missed to input company address.");
     setFocus(form.address);
     return false;
  }
  if (checkFieldEmpty(form.city))
  {
     alert("You missed to input city.");
     setFocus(form.city);
     return false;
  }
  if (checkFieldEmpty(form.state))
  {
     alert("You missed to input state/province.");
     setFocus(form.state);
     return false;
  }
  if (checkFieldEmpty(form.zipcode))
  {
     alert("You missed to input zip/postal code.");
     setFocus(form.zipcode);
     return false;
  }

  if (checkFieldEmpty(form.address_bill))
  {
     alert("You missed to input Credit Card Billing Address.");
     setFocus(form.address_bill);
     return false;
  }
  if (checkFieldEmpty(form.city_bill))
  {
     alert("You missed to input city.");
     setFocus(form.city_bill);
     return false;
  }
  if (checkFieldEmpty(form.state_bill))
  {
     alert("You missed to input state/province.");
     setFocus(form.state_bill);
     return false;
  }
  if (checkFieldEmpty(form.zipcode_bill))
  {
     alert("You missed to input zip/postal code.");
     setFocus(form.zipcode_bill);
     return false;
  }

  if (checkFieldEmpty(form.nameoncard))
  {
    alert("You missed to input the name on credit card.");
    setFocus(form.nameoncard);
    return false;
  }

  if (checkFieldEmpty(form.creditno))
  {
    alert("You missed to input credit card number.");
    setFocus(form.creditno);
    return false;
  }

  if (form.creditno.value.length<15)
  {
    alert("The credit card number you entered is a invalid number.");
    setFocus(form.creditno);
    return false;
  }

  //. check Expired month
  if (form.expiredmonth.selectedIndex==0)
  {
    alert("You missed to select expiration month.");
    form.expiredmonth.focus();
    return false;
  }

  //. check Expiration year
  if (form.expiredyear.selectedIndex==0)
  {
    alert("You missed to select expiration year.");
    form.expiredyear.focus();
    return false;
  }

  //. check  security id
  if (checkFieldEmpty(form.csid))
  {
     alert("You missed to input card verification no.");
     setFocus(form.csid);
     return false;
  }

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
     alert("The confirm password is not the same as the password.");
     setFocus(form.cpassword);
     return false;
  }

  if (!form.agreeto.checked)
  {
     alert("You have to check to agree to the terms and conditions.");
     setFocus(form.agreeto);
     return false;
  }

  form.priceplandesc.value = form.priceplan.options[form.priceplan.selectedIndex].text;

  return true;
}

/*
function showHide(method,section)
{
  if (eval("document.all."+section)!=null){if (method == "open" ){eval( section + ".style.display = 'inline'" );}else if (method == "close"){eval( section + ".style.display = 'none'" );}}
}


function toggleShow(name)
{
  if (eval("document.getElementById('"+name+"').style.display")=="none")
  {
     showHide("open", name);
  }
  else
  {
    showHide("close",name);
  }
}
*/

function displayLayer(name)
{
  if (eval("document.getElementById('"+name+"').style.display")=="none")
  {
    eval("document.getElementById('"+name+"').style.display='inline'");
    showHideSpan("close","off_"+name); showHide("open","on_"+name);
  }
  else
  {
    eval("document.getElementById('"+name+"').style.display='none'");
    showHideSpan("close","on_"+name); showHide("open","off_"+name);
  }
}

function onFreeSignUpLoad(form)
{
  setFocus(form.sitename);
}

function validateFreeSignup(form, prefix, subdomain)
{
  if (checkFieldEmpty(form.sitename))
  {
     alert("You missed to input your website name.");
     setFocus(form.sitename);
     return false;
  }
  if (checkFieldEmpty(form.yourname))
  {
     alert("You missed to input your name.");
     setFocus(form.yourname);
     return false;
  }
  if (checkFieldEmpty(form.phone))
  {
     alert("You missed to input phone number.");
     setFocus(form.phone);
     return false;
  }
  if (checkFieldEmpty(form.email))
  {
     alert("You missed to input E-Mail.");
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
     alert("The confirm password is not the same with the password.");
     setFocus(form.cpassword);
     return false;
  }

  if (checkFieldEmpty(form.input))
  {
   alert("You have to enter the code shown by the below image");
   setFocus(form.input);
   return false;
  }
/*
  if (!form.agreeto.checked)
  {
     alert("You have to check to agree to the terms and conditions.");
     setFocus(form.agreeto);
     return false;
  }
*/
  if (prefix==null)
    form.domainname.value = form.sitename.value + "." + subdomain;
  else
    form.domainname.value = prefix + "." + form.sitename.value + "." + subdomain;

//  return true;
  return onlyonce();
}