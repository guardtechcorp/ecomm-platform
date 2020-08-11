<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function validateQuickSearch(form)
{
  //1. check the product name
  if (checkFieldEmpty(form.productname))
  {
     alert("You have to input product key word.");
     setFocus(form.productname);
     return false;
  }
  else
    return true;
}

function onAdvanceSearchFormLoad(form)
{
    setCheckboxes(form, "cat_", form.category.value);
    setCheckboxes(form, "country_", form.refinedregion.value);
        
    setFocus(form.keywords);
}

function validateAdvanceSearch(form)
{
  var bRet = false;
   //. check product name
  if (!checkFieldEmpty(form.keywords))
  {
     bRet = true;
  }

  var sCategory = getMultipleCheckboxIds(form, "cat_", ',');
  if (sCategory.length>0)
  {
     bRet = true;
  }

  var sCountry = getMultipleCheckboxIds(form, "country_", ',');
  if (sCategory.length>0)
  {
    bRet = true;
  }

  //. check the price from
  if (!checkFieldEmpty(form.price_from))
  {
     bRet = true;
  }
  //. check price to
  if (!checkFieldEmpty(form.price_to))
  {
     bRet = true;
  }

  //. check the date from
  if (!checkFieldEmpty(form.createdate_from))
  {
     bRet = true;
  }
  //. check date to
  if (!checkFieldEmpty(form.createdate_to))
  {
     bRet = true;
  }

  if (!bRet)
  {
     alert("You have to input value in or select at least one of fields.");
     setFocus(form.keywords);
     return false;
  }

  form.category.value = sCategory;
  form.refinedregion.value = sCountry; 

  showProcessBar();
 
  return true;
}

function onBuyLeadSearchFormLoad(form)
{
    setCheckboxes(form, "cat_", form.category.value);
        
    setFocus(form.keywords);
}

function validateBuyLeadSearch(form)
{
  if (checkFieldEmpty(form.keywords))
  {
     alert("You have to input the key words to search.");
     setFocus(form.keywords);
     return false;
  }

  form.category.value = getMultipleCheckboxIds(form, "cat_", ',');

  showHideSpan('close','BuyLeadSearch');
  showHideSpan('open','Processing');

  return true;
}

function showContactSection(form, show, sectionname)
{
//alert("show=" + show + "," + sectionname);
  showHideSpan(show, sectionname);
  if (show=="open")
  { //contact_section
    showHideSpan("close", "open_" + sectionname);
    showHideSpan("open", "close_" + sectionname);
    setFocus(form.subject);
  }
  else
  {
    showHideSpan("close", "close_" + sectionname);
    showHideSpan("open", "open_" + sectionname);
  }
}

function validateSendMessage(form)
{
  if (checkFieldEmpty(form.subject))
  {
     alert("You have to input subject.")
     setFocus(form.subject);
     return false;
  }

  if (checkFieldEmpty(form.content))
  {
    alert("You have to enter Content.")
    setFocus(form.content);
    return false;
  }

  return true;
}

function sendMessage(form, sUrl)
{
  if (!validateSendMessage(form))
     return false;
/*
  var sRequest = "";
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
*/
  var sRequest = getFormQuery(form);

  //  sRequest += "&time="+new Date().getTime();
//alert("sRequest=" + sRequest);
  var sResponse = postUrlContent(sUrl, sRequest);
//alert("sResponse=" + sResponse+"!");
  if ("1"==sResponse.substring(0,1))
     alert("Your message was successfully send to " + form.companyname.value+".");
  else if ("2"==sResponse.substring(0,1))
     alert("The same message was already send to " + form.companyname.value+". Please not send it again." );
  else
     alert("It was failed to send the mail to " + form.companyname.value+". \nPlease try it later. ");

  return true;
}
