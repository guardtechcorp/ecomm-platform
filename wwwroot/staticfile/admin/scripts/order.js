<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onOrderLoad(form)
{
//   form.username.focus();
//   form.username.select();
}

function validateOrder(form)
{
    if (checkFieldEmpty(form.username))
    {
        alert("You have to enter username.");
        setFocus(form.username);
        return false;
    }

    return true;
}

function roundOff(value, precision)
{
    if(value==0)
      return 0;
    value = "" + value;
    precision = parseInt(precision);
    var whole = "" + Math.round(value * Math.pow(10, precision));
    var decPoint = whole.length - precision;
    if(decPoint != 0)
    {
       result = whole.substring(0, decPoint);
       result += ".";
       result += whole.substring(decPoint, whole.length);
     }
     else
     {
        result = whole;
     }
     return result;
}

function cal()
{
  var itemtotal=0.0;
  var subtotal=0.0;
  var taxamount=0.0;
  var grandtotal=0.0;
  var f=document.editinvoice;
  for(var i=0; i<itemcount; i++)
  {
     eval('itemtotal=parseFloat(f.item'+(i*3)+'.value)*parseFloat(f.item'+(i*3+1)+'.value)');
     subtotal=subtotal+itemtotal;
     eval('f.item'+(i*3+2)+'.value=roundOff(itemtotal, 2)');
  }
  f.subtotal.value=roundOff(subtotal, 2);
  taxamount=(subtotal-parseFloat(f.discount.value))*0.008200;
  f.taxamount.value=roundOff(taxamount, 2);
  grandtotal=subtotal-parseFloat(f.discount.value)+parseFloat(f.shipping.value)+taxamount;
  f.grandtotal.value=roundOff(grandtotal, 2);
}

function cal2()
{
    var f=document.editinvoice;
    var grandtotal=parseFloat(f.subtotal.value)-parseFloat(f.discount.value)+parseFloat(f.shipping.value)+parseFloat(f.taxamount.value);
    f.grandtotal.value=roundOff(grandtotal, 2);
}

//. For Order search
function onOrderSearchLoad(form, shipvalue, payvalue)
{
  ShipmentSelect(form, shipvalue);
  PaymentSelect(form, payvalue);
  setFocus(form.yourname);
}

function ShipmentSelect(form, value)
{
   for(i=0; i<form.shipment.length; i++)
   {
     if (form.shipment.options[i].value==value)
      {
         form.shipment.selectedIndex = i;
         break;
      }
   }
}

function PaymentSelect(form, value)
{
   for(i=0; i<form.payment.length; i++)
   {
     if (form.payment.options[i].value==value)
     {
        form.payment.selectedIndex = i;
        break;
     }
   }
}

function validateSearch(form)
{
    var bRet = false;
    if (!checkFieldEmpty(form.yourname))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.companyname))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.phone))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.email))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.ship_address))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.ship_city))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.ship_state))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.ship_zipcode))
    {
       bRet = true;
    }
    //. check the order
    if (!checkFieldEmpty(form.orderno))
    {
       bRet = true;
    }
    //. check the order date from
    if (!checkFieldEmpty(form.createdate_from))
    {
       bRet = true;
    }
    //. check the order date to
    if (!checkFieldEmpty(form.createdate_to))
    {
       bRet = true;
    }
    //. check the grand total from
    if (!checkFieldEmpty(form.grandtotal_from))
    {
       bRet = true;
    }
    //. check the grand total to
    if (!checkFieldEmpty(form.grandtotal_to))
    {
       bRet = true;
    }
    //. check the shipment
    if (form.shipment.selectedIndex>0)
    {
       bRet = true;
    }
    //. check the payment
    if (form.payment.selectedIndex>0)
    {
       bRet = true;
    }
    if (!bRet)
    {
       alert("You have to input at least or select one of fields.");
       setFocus(form.yourname);
       return false;
    }
    else
       return true;
}

function onShipOrderLoad(form, paystatus)
{
  for(i=0; i<form.paystatus.length; i++)
  {
    if (form.paystatus.options[i].value==paystatus)
    {
      form.paystatus.selectedIndex = i;
      break;
    }
  }

/*
  if (paystatus=="Completed")
  {
     form.trackno.focus();
     form.trackno.select();
  }
  else
    form.creditno.focus();
*/
}

function onShipMethodChange(form)
{
//   var shipidcharge = form.shipid_charge.options[form.shipid_charge.selectedIndex].value;
//   alert("shipidcharge=" + shipidcharge);
//   var columns = shipidcharge.split("|");
//   form.shipfee.value = columns[1];
}