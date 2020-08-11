<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onPaypalLoad(form)
{
  onCreditCardCheck(form);
  onPaypalCheck(form);
}

function onCreditCardCheck(form)
{
    if (form.creditcard.checked)
    {
      form.visa.disabled = "";
      form.mastercard.disabled = "";
      form.discover.disabled = "";
      form.american_express.disabled = "";

    }
    else
    {
      form.visa.disabled = "true";
      form.mastercard.disabled = "true";
      form.discover.disabled = "true";
      form.american_express.disabled = "true";
    }
}

function onGatewayChange(objSelect, sJspFile)
{
//alert("updateMaqRows = " + sJspFile + "?action=updaterows&maxrows=" + objSelect.selectedIndex);
  window.location.href = sJspFile + "?action=Gateway Change&gateway=" + objSelect.options[objSelect.selectedIndex].value;
}

function onPaypalCheck(form)
{
  if (form.paypal.checked)
  {
    form.paypal_account.disabled = "";
  }
  else
  {
    form.paypal_account.disabled = "true";
  }
}

function validatePayment(form)
{
  if (form.creditcard.checked)
  {
     if (form.username!=null)
     {
       if (checkFieldEmpty(form.username))
       {
         alert("You have to enter value for this field.");
         setFocus(form.username);
         return false;
       }
     }

     if (form.password!=null)
     {
       if (checkFieldEmpty(form.password))
       {
         alert("You have to enter value for this field.");
         setFocus(form.password);
         return false;
       }
     }

     if (!(form.visa.checked||form.mastercard.checked||form.discover.checked||form.american_express.checked))
     {
       alert("You have to select at aleast one of credit cards.");
       return false;
     }
  }

  if (form.paypal.checked)
  {
    if (checkFieldEmpty(form.paypal_account))
    {
      alert("You have to enter PayPal account name.");
      setFocus(form.paypal_account);
      return false;
    }
  }

  return true;
}

/*
function validatePayment(form)
{
  if (form.offline.checked)
  {
     if (!(form.visa.checked||form.mastercard.checked||form.discover.checked||form.american_express.checked))
     {
       alert("You have to select at aleast one of credit cards.");
       return false;
     }
  }

  if (form.paypal.checked)
  {
    if (checkFieldEmpty(form.options_paypal))
    {
      alert("You have to enter PayPal account name.");
      setFocus(form.options_paypal);
      return false;
    }
  }

  if (form.itransact.checked)
  {
    if (checkFieldEmpty(form.options_itransact))
    {
      alert("You have to enter Gateway ID of iTransact.");
      setFocus(form.options_itransact);
      return false;
    }
  }

  if (form.authorize.checked)
  {
    if (checkFieldEmpty(form.authorize_loginid))
    {
      alert("You have to enter Login ID of Authorize.net.");
      setFocus(form.authorize_loginid);
      return false;
    }
    if (checkFieldEmpty(form.authorize_tran_key))
    {
      alert("You have to enter transaction key of Authorize.net.");
      setFocus(form.authorize_tran_key);
      return false;
    }
  }

  return true;
}
*/

function onShipmentLoad(form, vendor)
{
    for(i=0; i<form.vendor.length; i++)
    {
      if (form.vendor.options[i].value==vendor)
      {
        form.vendor.selectedIndex = i;
        break;
      }
    }

    form.name.focus();
    form.name.select();
}

function validateShipment(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter name.");
    setFocus(form.name);
    return false;
  }

  if (checkFieldEmpty(form.charge))
  {
    alert("You have to enter ship charge.");
    setFocus(form.charge);
    return false;
  }

  return true;
}

function onTaxRateLoad(form, sCountyCode)
{
//alert("CountyCode = " + sCountyCode);
  if (sCountyCode.length!=5)
    return;

  var sState = sCountyCode.substring(0,2);
  for(i=0; i<form.state.length; i++)
  {
    if (form.state.options[i].value==sState)
    {
    form.state.selectedIndex = i;
    break;
  }
  }

  for(i=0; i<form.countycode.length; i++)
  {
    if (form.countycode.options[i].value==sCountyCode)
    {
    form.countycode.selectedIndex = i;
    break;
  }
  }

  setFocus(form.rate);
}

function OnStateChange(form)
{
  window.location.href = "tax.jsp?action=statechange&countycode="+form.state.options[form.state.selectedIndex].value + "000";
}

function OnCountyChange(form)
{
  window.location.href = "tax.jsp?action=countychange&countycode="+form.countycode.options[form.countycode.selectedIndex].value;
}

function validateTaxRate(form)
{
  if (checkFieldEmpty(form.rate))
    {
      alert("You have to enter tax rate.");
      setFocus(form.rate);
      return false;
    }

    return true;
}

function validateShipZone(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter zone name.");
    setFocus(form.name);
    return false;
  }

  if (checkFieldEmpty(form.coverzips))
  {
    alert("You have to enter Covered Zip Codes.");
    setFocus(form.coverzips);
    return false;
  }

  if (checkFieldEmpty(form.fees))
  {
    alert("You have to enter charge values.");
    setFocus(form.fees);
    return false;
  }

/*
  if (form.incflag.selectedIndex>0)
  {
  }
*/
  return true;
}


