<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology. -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onSearchFormLoad(form)
{
   buildStateOption(form);

   var sMode = getCookie('propertysave_mode');
   if (sMode==null || sMode.length==0)
      sMode = 'address';
   switchMode(form, sMode, false);
}

function switchMode(form, sMode, bTemp)
{
  var objZip;
  if (sMode=="advanced")
  {
    showAndHide('advanced', 'address', 'owner', 'apn');
    setFocus(form.advanced_houseno);
    objZip = form.advanced_zip;
  }
  else if (sMode=="owner")
  {
    showAndHide('owner', 'address', 'advanced','apn')
    setFocus(form.owner_lastname);
    objZip = form.owner_zip;
  }
  else if (sMode=="apn")
  {
    showAndHide('apn', 'advanced', 'address', 'owner');
    setFocus(form.apn_apn);
    objZip = form.apn_zip;
  }
  else //if (sMode=="address")
  {
    showAndHide('address', 'advanced', 'owner', 'apn')
    setFocus(form.address_street);
    objZip = form.address_zip;
  }

//  if (bTemp)
  setCookie('propertysave_mode', sMode);

  var sZipCode;
  if (bTemp)
    sZipCode = getCookie('propertysearch_zipcode');
  else
  {
    sZipCode = getCookie('propertysave_zipcode');
    setCookie('propertysearch_zipcode', sZipCode);
  }
  if (sZipCode!=null)
     objZip.value = sZipCode;
  else
     objZip.value = "";

  if (sMode!="address")
     setStateCounty(form, sMode, bTemp);
}

function setStateCounty(form, sMode, bTemp)
{
  var sStateCode;
  if (bTemp)
    sStateCode = getCookie('propertysearch_statecode');
  else
  {
    sStateCode = getCookie('propertysave_statecode');
    setCookie('propertysearch_statecode', sStateCode);
  }

  if (sStateCode==null || sStateCode.length==0)
     return;
  setStateCode(form, sMode, sStateCode);

  var sCountyCode;
  if (bTemp)
    sCountyCode = getCookie('propertysearch_countycode');
  else
  {
    sCountyCode = getCookie('propertysave_countycode');
    setCookie('propertysearch_countycode', sCountyCode);
  }
  if (sCountyCode==null || sCountyCode.length==0)
     return;
  setCountyCode(form, sMode, sCountyCode)
}

function validateSearchForm(form)
{
  var sMode = form.mode.value;
  if (sMode=="advanced")
  {
    setFocus(form.advanced_houseno);
    if (checkFieldEmpty(form.advanced_houseno)&&checkFieldEmpty(form.advanced_streetname))
    {
      alert("Please enter either House No AND/OR street name.");
      setFocus(form.advanced_houseno);
      return false;
    }

    if (checkFieldEmpty(form.advanced_zip))
    {
       if (form.advanced_state.selectedIndex<=0)
       {
          alert("Please enter either zipcode OR select state/county.");
          form.advanced_state.focus();
          return false;
       }

       if (form.advanced_county.selectedIndex<=0)
       {
          alert("Please select one of counties.");
          form.advanced_county.focus();
          return false;
       }
    }
  }
  else if (sMode=="owner")
  {
    if (checkFieldEmpty(form.owner_lastname))
    {
      alert("Please enter last name.");
      setFocus(form.owner_lastname);
      return false;
    }

    if (checkFieldEmpty(form.owner_zip))
    {
       if (form.owner_state.selectedIndex<=0)
       {
          alert("Please enter either zipcode OR select state/county.");
          form.owner_state.focus();
          return false;
       }

       if (form.owner_county.selectedIndex<=0)
       {
          alert("Please select one of counties.");
          form.owner_county.focus();
          return false;
       }
    }
  }
  else if (sMode=="apn")
  {
    if (checkFieldEmpty(form.apn_apn))
    {
      alert("Please enter APN.");
      setFocus(form.apn_apn);
      return false;
    }

    if (checkFieldEmpty(form.apn_zip))
    {
       if (form.apn_state.selectedIndex<=0)
       {
          alert("Please enter either zipcode OR select state/county.");
          form.apn_state.focus();
          return false;
       }

       if (form.apn_county.selectedIndex<=0)
       {
          alert("Please select one of counties.");
          form.apn_county.focus();
          return false;
       }
    }
  }
  else //if (sMode=="address")
  {
    if (checkFieldEmpty(form.address_street))
    {
      alert("Please enter street address.");
      setFocus(form.address_street);
      return false;
    }

    if (checkFieldEmpty(form.address_zip))
    {
       if (checkFieldEmpty(form.address_city))
       {
          alert("Please enter zipcode OR city/state.");
          setFocus(form.address_city);
          return false;
       }

       if (checkFieldEmpty(form.address_state))
       {
          alert("Please enter zipcode OR city/state.");
          setFocus(form.address_state);
          return false;
       }
    }
  }

  saveCountyStateZip(form, sMode);

  showHideSpan('close','Search_Form');
  showHideSpan('open','Processing');

  return true;
}

function saveCountyStateZip(form, sMode)
{
  var objZip;
  var objState;
  var objCounty;
  if (sMode=="advanced")
  {
    objState = form.advanced_state;
    objCounty = form.advanced_county;
    objZip = form.advanced_zip;
  }
  else if (sMode=="owner")
  {
    objState = form.owner_state;
    objCounty = form.owner_county;
    objZip = form.owner_zip;
  }
  else if (sMode=="apn")
  {
    objState = form.apn_state;
    objCounty = form.apn_county;
    objZip = form.apn_zip;
  }
  else //if (sMode=="address")
  {
    objZip = form.address_zip;
  }

  setCookie('propertysave_zipcode', objZip.value);
  setCookie('propertysearch_zipcode', objZip.value);
  if (sMode!="address")
  {
    var sStateCode = objState.options[objState.selectedIndex].value;
    setCookie('propertysave_statecode', sStateCode);
    setCookie('propertysearch_statecode', sStateCode);
    var sCountyCode = objCounty.options[objCounty.selectedIndex].value;
    setCookie('propertysave_countycode', sCountyCode);
    setCookie('propertysearch_countycode', sCountyCode);
  }
}

function buildStateOption(form)
{
  form.advanced_state.length = 0;
  form.advanced_state.options[form.advanced_state.length] = new Option("----", "00");
  for (i=0; i<g_USState.length; i++)
  {
    form.advanced_state.options[form.advanced_state.length] = new Option(g_USState[i][1], g_USState[i][0]);
  }

  form.owner_state.length = 0;
  form.owner_state.options[form.owner_state.length] = new Option("----", "00");
  for (i=0; i<g_USState.length; i++)
  {
    form.owner_state.options[form.owner_state.length] = new Option(g_USState[i][1], g_USState[i][0]);
  }

  form.apn_state.length = 0;
  form.apn_state.options[form.apn_state.length] = new Option("----", "00");
  for (i=0; i<g_USState.length; i++)
  {
    form.apn_state.options[form.apn_state.length] = new Option(g_USState[i][1], g_USState[i][0]);
  }
}

function setStateCode(form, sMode, sStateCode)
{
  var objState;
  if (sMode=="advanced")
  {
    objState = form.advanced_state;
  }
  else if (sMode=="owner")
  {
    objState = form.owner_state;
  }
  else// if (sMode=="apn")
  {
    objState = form.apn_state;
  }

  for (var i=0; i<objState.length; i++)
  {
     if (sStateCode==objState.options[i].value)
     {
       objState.selectedIndex = i;
       onStateChanged(form, sMode, false);
       break;
     }
  }
}

function setCountyCode(form, sMode, sCountyCode)
{
  var objCounty;
  if (sMode=="advanced")
  {
    objCounty = form.advanced_county;
  }
  else if (sMode=="owner")
  {
    objCounty = form.owner_county;
  }
  else// if (sMode=="apn")
  {
    objCounty = form.apn_county;
  }

  for (var i=0; i<objCounty.length; i++)
  {
     if (sCountyCode==objCounty.options[i].value)
     {
       objCounty.selectedIndex = i;
       break;
     }
  }
}

function onStateChanged(form, sMode, bEmptyZip)
{
  var objState;
  var objCounty;
  var objZip;
  if (sMode=="advanced")
  {
    objState = form.advanced_state;
    objCounty = form.advanced_county;
    objZip = form.advanced_zip;
  }
  else if (sMode=="owner")
  {
    objState = form.owner_state;
    objCounty = form.owner_county;
    objZip = form.owner_zip;
  }
  else// if (sMode=="apn")
  {
    objState = form.apn_state;
    objCounty = form.apn_county;
    objZip = form.apn_zip;
  }

  objCounty.length = 0;
  objCounty.options[objCounty.length] = new Option("Select County", "00000");
  if (objState.selectedIndex>0)
  {
    for (var i=0; i<g_USCounty.length; i++)
    {
      if (g_USCounty[i][0].substring(0,2)==objState.options[objState.selectedIndex].value)
        objCounty.options[objCounty.length] = new Option(g_USCounty[i][1], g_USCounty[i][0]);
    }
  }

  if (bEmptyZip)
  {
     objZip.value = "";
     setCookie('propertysearch_zipcode', "");
  }
}

function onCountyChanged(form, sMode)
{
  var objState;
  var objCounty;
  var objZip;
  if (sMode=="advanced")
  {
    objState = form.advanced_state;
    objCounty = form.advanced_county;
    objZip = form.advanced_zip;
  }
  else if (sMode=="owner")
  {
    objState = form.owner_state;
    objCounty = form.owner_county;
    objZip = form.owner_zip;
  }
  else// if (sMode=="apn")
  {
    objState = form.apn_state;
    objCounty = form.apn_county;
    objZip = form.apn_zip;
  }

  if (objState.selectedIndex>0)
  {
    var sStateCode = objState.options[objState.selectedIndex].value;
    setCookie('propertysearch_statecode', sStateCode);

    if (objCounty.selectedIndex>0)
    {
      var sCountyCode = objCounty.options[objCounty.selectedIndex].value;
      setCookie('propertysearch_countycode', sCountyCode);
    }
  }

  objZip.value = "";
  setCookie('propertysearch_zipcode', "");
}

function onZipChanged(objField, form, sMode)
{
   if (validateDigits(objField, 5))
   {//. Only zip code invalide
      var sRequest = "plugin/property/propertysearch.jsp?action=pi-getfipcodebyzip&zip=" + objField.value;
      sRequest += "&time="+new Date().getTime();
//alert("sRequest="+ sRequest);
      var sResponse = getUrlContent(sRequest);
//alert("Code=" + sResponse +"!");
      if (sResponse.length>7)
      {
        var arReturn = sResponse.split("!");
        if ("0"==arReturn[0])
        {
//           alert("CountyCode=" + arReturn[1] + "|");
          if (sMode!="address")
          {
            setStateCode(form, sMode, arReturn[1].substring(0, 2));
            setCountyCode(form, sMode, arReturn[1]);
          }
          setCookie('propertysearch_statecode', arReturn[1].substring(0, 2));
          setCookie('propertysearch_countycode', arReturn[1]);
          setCookie('propertysearch_zipcode', objField.value);
        }
        else
        {
          alert("The zip code you entered is not valid. Please enter another one.");
          objField.value = "";
          setFocus(objField);
        }
      }
   }
}

function showAndHide(openname, closename1, closename2, closename3)
{
  showHideSpan("open", openname+"_section");
  showHideSpan("close", closename1+"_section");
  showHideSpan("close", closename2+"_section");
  showHideSpan("close", closename3+"_section");

  document.getElementById(openname + "_tab").className = "selected";
  document.getElementById(closename1 + "_tab").className = "";
  document.getElementById(closename2 + "_tab").className = "";
  document.getElementById(closename3 + "_tab").className = "";
  document.propertysearch_form.mode.value = openname;
}

function selectAll(form, obj)
{
   for (var i=0;i<form.elements.length;i++)
   {
      var e = form.elements[i];
      if ((e.name !=  obj.name) && (e.type=='checkbox'))
      {
         if (e.checked != obj.checked)
            e.click();
      }
   }

   onCheckReport(form);
}

function initReportOption(form, size)
{
  var sReports = getCookie('propertysave_reports');
  if (sReports==null || sReports.length==0)
     sReports = "30,";

  for (var i=0; i<size; i++)
  {
    var checkbox = eval("form.check_" + i);
    var sValue = checkbox.value + ",";
    if (sReports.indexOf(sValue)!=-1)
       checkbox.checked = true;
  }

  onCheckReport(form);
}

function onCheckReport(form)
{
  var arPrice = form.eachprice.value.split(",");
//alert("arPrice=" + form.eachprice.value);
  var fTotalCharge = 0;
  for (var i=0; i<arPrice.length; i++)
  {
     var checkbox = eval("form.check_" + i);
     if (checkbox.checked)
     {
       fTotalCharge += parseFloat(arPrice[i]);
     }
  }

  if (fTotalCharge==0)
  {
//    alert("You have to at least select one of reports.");
//    form.check_2.checked = true;
    form.nextstep.disabled = "true";

  }
  else
    form.nextstep.disabled = "";

//alert("TotalPrice=" + '$'+fTotalCharge);
  var total = addjustmentDecimal("$"+fTotalCharge);
  writeDataOnId("totalcharge", "'"+total+"'");
}

function validateReports(form, size)
{
  var sReports = "";
  for (var i=0; i<size; i++)
  {
    var checkbox = eval("form.check_" + i);
    if (checkbox.checked)
    {
       sReports += checkbox.value + ",";
    }
  }

//alert("sReports=" + sReports);
  setCookie('propertysave_reports', sReports);

  showHideSpan('close','Summary_Form');
  showHideSpan('open','Processing');
//alert("Display process bar");

  return true;
}

function validateBillingInfo(form)
{
  showHideSpan('close','Billing_Form');
  showHideSpan('open','Processing');

  return true;
}

function onEmailFormLoad(form)
{
  var yourname = getCookie('propertysearch_email_yourname');
  var fromemail = getCookie('propertysearch_email_from');
  var sendyourself = getCookie('propertysearch_email_sendyourself');
  var emailsubject = getCookie('propertysearch_email_subject');
  var emailcomment = getCookie('propertysearch_email_comment');

  if (yourname!=null && form.yourname.value.length==0)
     form.yourname.value = yourname;
  if (fromemail!=null&&form.fromemail.value.length==0)
     form.fromemail.value = fromemail;

  if ("1"==sendyourself)
    form.sendyourself.checked = true;
  else
    form.sendyourself.checked = false;

  if (emailsubject==null)
     form.subject.value = "Your property Reports";
  else
     form.subject.value = emailsubject;
  if (emailcomment==null)
     form.comment.value = "Hi, \n\nThe attachement is your property reports you have requested.\nIf you have any questions, let me know.\n\nThank you.";
  else
     form.comment.value = emailcomment;
}

function showEmailSection(form, show, sectionname)
{
//alert("show=" + show + "," + sectionname);
  showHideSpan(show, sectionname);
  if (show=="open")
  {
    setFocus(form.toemail);
  }
}

function validateEmailSection(form)
{
  if (checkFieldEmpty(form.toemail))
  {
     alert("You missed to input To E-Mail address.");
     setFocus(form.toemail);
     return false;
  }

  var arEmail = form.toemail.value.split(",");
  for (var i=0; i<arEmail.length; i++)
  {
    if (!validateEmailValue(arEmail[i]))
    {
       setFocus(form.toemail);
       return false;
    }
  }

  if (checkFieldEmpty(form.fromemail))
  {
     alert("You missed to input from E-Mail address.");
     setFocus(form.fromemail);
     return false;
  }
  if (!validateEmailValue(form.fromemail.value))
  {
     setFocus(form.fromemail);
     return false;
  }

  setCookie('propertysearch_email_yourname', form.yourname.value);
  setCookie('propertysearch_email_from', form.fromemail.value);
  if (form.sendyourself.checked)
     setCookie('propertysearch_email_sendyourself', "1");
  else
     setCookie('propertysearch_email_sendyourself', "0");

  setCookie('propertysearch_email_subject', form.subject.value);
  setCookie('propertysearch_email_comment', form.comment.value);

  return true;
}

function onViewReportFormLoad(form)
{
  var coverpage = getCookie('propertysearch_coverpage');
  if (coverpage!=null)
  {
    if ("1"==coverpage)
      form.coverpage.checked = true;
    else
      form.coverpage.checked = false;
  }
}

function submitViewReport(form)
{
//alert("submit=" +   form.action.value);
  if (form.coverpage.checked)
     setCookie('propertysearch_coverpage', "1");
  else
     setCookie('propertysearch_coverpage', "0");

   form.submit();
}

function sendEmailNow(form, form2, sUrl)
{
  if (!validateEmailSection(form))
     return false;

  if (form2.coverpage.checked)
     setCookie('propertysearch_coverpage', "1");
  else
     setCookie('propertysearch_coverpage', "0");

  var sRequest;
  if (form2.coverpage.checked)
    sRequest = "coverpage=1";
  else
    sRequest = "coverpage=0";

  for(i=0; i<form.elements.length; i++)
  {
    var e = form.elements[i];
    if (e.type=='checkbox')
    {
      if (e.checked)
        sRequest += '&' + e.name + '=' +  encodeURIComponent(e.value);
    }
    else
      sRequest += '&' + e.name + '=' +  encodeURIComponent(e.value);
  }
//  sRequest += "&time="+new Date().getTime();
//alert("sRequest=" + sRequest);
  var sResponse = postUrlContent(sUrl, sRequest);
//alert("sResponse=" + sResponse+"!");
  if ("1"==sResponse.substring(0,1))
     alert("The email was sent successfully to " + form.toemail.value+".");
  else
     alert("It was failed to send the mail to " + form.toemail.value+". \nPlease try it later. ");

  return true;
}

function validateCreditAmount(form1, form2)
{
  if (form1.amount.value=="0")
  {
    alert("You have to enter the credit value more than 0.")
    setFocus(form1.amount);
    return false;
  }

  form2.amount.value = form1.amount.value;
  return true;
}

function onCoverPageFormLoad(form)
{
  if (checkFieldEmpty(form.yourname))
    setFocus(form.yourname);
  else
    setFocus(form.m_ct_yourname);
}

function validateCoverPage(form)
{
  return true;
}

function clearFields(form)
{
  form.m_ct_yourname.value = "";
  form.m_ct_company.value = "";
  form.m_ct_street.value = "";
  form.m_ct_citystatezip.value = "";
  form.m_ct_phone.value = "";
  form.m_ct_fax.value = "";
  form.m_ct_comments.value = "";

  onCoverPageFormLoad(form);
}
