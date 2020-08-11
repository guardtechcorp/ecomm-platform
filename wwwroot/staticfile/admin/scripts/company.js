<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onCompanyLoad(form)
{
  setFocus(form.companyname);
}

function onBillingLoad(form)
{
  setFocus(form.address_bill);
}

function validateCompany(form)
{
  if (checkFieldEmpty(form.companyname))
  {
    alert("You missed to input company name.");
    setFocus(form.companyname);
    return false;
  }
  if (checkFieldEmpty(form.address))
  {
    alert("You missed to input Address.");
    setFocus(form.address);
    return false;
  }
  if (checkFieldEmpty(form.city))
  {
    alert("You missed to input City.");
    setFocus(form.city);
    return false;
  }
  if (checkFieldEmpty(form.state))
  {
    alert("You missed to input State/Province.");
    setFocus(form.state);
    return false;
  }
  if (checkFieldEmpty(form.zipcode))
  {
    alert("You missed to input Zip/Postal Code.");
    setFocus(form.zipcode);
    return false;
  }
  if (checkFieldEmpty(form.country))
  {
    alert("You missed to input Country.");
    setFocus(form.country);
    return false;
  }

  if (checkFieldEmpty(form.yourname))
  {
    alert("You missed to input Your Name.");
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
    alert("You missed to input Phone Number.");
    setFocus(form.phone);
    return false;
  }

  return true;
}

function validateBilling(form)
{
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

//. check the credit card
  if (checkFieldEmpty(form.nameoncard))
  {
    alert("You missed to input Name on Credit Card.");
    setFocus(form.nameoncard);
    return false;
  }

  if (checkFieldEmpty(form.creditno)||form.creditno_x.value.indexOf("X")==-1)
  {
     form.creditno.value = form.creditno_x.value
  }

//. check card no
  if (checkFieldEmpty(form.creditno))
  {
    alert("You missed to input Credit Card Number.");
    setFocus(form.creditno_x);
    return false;
  }
  if (form.creditno.value.length<15)
  {
    alert("The credit card number is a invalid number.");
    setFocus(form.creditno_x);
    return false;
  }

//. check Expired month
  if (checkFieldEmpty(form.expiredmonth))
  {
    alert("You missed to input Expiration Month.");
    form.expiredmonth.focus();
    return false;
  }

//. check Expiration year
  if (checkFieldEmpty(form.expiredyear))
  {
    alert("You missed to input Expiration Year.");
    form.expiredyear.focus();
    return false;
  }

//. check  security id
  if (checkFieldEmpty(form.csid))
  {
    alert("You missed to input Card Verification Number.");
    setFocus(form.csid);
    return false;
  }

  return true;
}
