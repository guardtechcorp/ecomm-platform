<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onExportLoad(form)
{
  if (form.label!=null)
     onFormatSelect(form);

  onRecordSelect(form);
}

function onFormatSelect(form)
{
  if (form.format[0].checked)
  {
    form.headrow.disabled="true";
    form.label[0].disabled="";
    form.label[1].disabled="";
    form.label[2].disabled="";
  }
  else
  {
    form.headrow.disabled="";
    form.label[0].disabled="true";
    form.label[1].disabled="true";
    form.label[2].disabled="true";
  }
}

function onRecordSelect(form)
{
  if (form.record[0].checked)
  {
    form.rangefrom.disabled="true";
    form.rangeto.disabled="true";
  }
  else
  {
    form.rangefrom.disabled="";
    form.rangeto.disabled="";
    setFocus(form.rangefrom);
  }
}

function validateExport(form, sTotal)
{
//alert("Len= " + form.record.length);
//alert("" + form.record[0].checked + "," + form.record[1].checked);
  if (form.record[1].checked)
  {
    var nTotal = parseInt(sTotal);
    var nFrom = parseInt(form.rangefrom.value);
    var nTo = parseInt(form.rangeto.value);
    if (nFrom>nTo)
    {
      alert("Range From should be less than or equal to Range To.");
      setFocus(form.rangefrom);
      return false;
    }

    if (nTo>nTotal)
    {
      alert("Range To should be less than or equal to " + sTotal);
      setFocus(form.rangeto);
      return false;
    }
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
function OnOrderSearchLoad(form, shipvalue, payvalue)
{
  ShipmentSelect(form, shipvalue);
  PaymentSelect(form, payvalue);
  setFocus(form.orderno);
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
    //. check the order
    var bRet = false;
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
       setFocus(form.orderno);
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

  if (paystatus=="Completed")
  {
     form.trackno.focus();
     form.trackno.select();
  }
  else
    form.creditno.focus();
}

function onShipMethodChange(form)
{
   var shipidcharge = form.shipid_charge.options[form.shipid_charge.selectedIndex].value;
//   alert("shipidcharge=" + shipidcharge);
   var columns = shipidcharge.split("|");
   form.shipfee.value = columns[1];
}