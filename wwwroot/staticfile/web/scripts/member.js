<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

//To automatically open the console when a JavaScript error occurs which of the following is added to prefs.js
//   user_pref("javascript.console.open_on_error", true);
//  user_pref("javascript.classic.error_alerts", true);
//<image src="http://www.omniserve.com/images/min.gif">

function onMemberFormLoad(form)
{
    setFocus(form.firstname);
//alert("Your Name here");
}

function validateAccount(form)
{
  //. check the your name
  if (checkFieldEmpty(form.firstname))
  {
     alert("You have to enter First Name.");
     setFocus(form.firstname);
     return false;
  }

  //. check the your name
  if (checkFieldEmpty(form.lastname))
  {
     alert("You have to enter Last Name.");
     setFocus(form.lastname);
     return false;
  }

  return true;
}

function validateMemberSignup(form)
{
  try {
      //. check the your name
      if (checkFieldEmpty(form.firstname))
      {
         alert("You have to enter First Name.");
         setFocus(form.firstname);
         return false;
      }

      if (checkFieldEmpty(form.lastname))
      {
         alert("You have to enter Last Name.");
         setFocus(form.lastname);
         return false;
      }

      if (form.gender.selectedIndex<=0)
      {
         alert("You have to select one of Gender.");
         form.gender.focus();
         return false;
      }

    /*
      //. check the street address
      if (checkFieldEmpty(form.address1))
      {
         alert("You have to enter Address.");
         setFocus(form.address1);
         return false;
      }
      //. check the city name
      if (checkFieldEmpty(form.city))
      {
         alert("You have to enter City.");
         setFocus(form.city);
         return false;
      }

      //. check the provice
      if (form.country.options[form.country.selectedIndex].value!="USA")
      {//Non-USA
          if (checkFieldEmpty(form.province))
          {
             alert("You have to enter Province.");
             setFocus(form.province);
             return false;
          }
      }
      //. check the zip code
      if (checkFieldEmpty(form.zip))
      {
         alert("You have to enter Zip/Postcode.");
         setFocus(form.zip);
         return false;
      }
    */

      //. check the email
      if (checkFieldEmpty(form.email))
      {
         alert("You have to enter Email.");
         setFocus(form.email);
         return false;
      }
      if (!validateEmail(form.email))
         return false;

      if (checkFieldEmpty(form.remail))
      {
           alert("You have to enter Re-Type Email.");
           setFocus(form.remail);
           return false;
      }

      if (form.email.value!=form.remail.value)
      {
          alert("The Email you entered is not the same as Re-Type Email.");
          setFocus(form.remail);
          return false;
      }

      //. check the password is empty or not
      if (checkFieldEmpty(form.password))
      {
          alert("You have to enter Password.");
          setFocus(form.password);
          return false;
      }

       //. check the confirm password
      if (checkFieldEmpty(form.cpassword))
      {
        alert("You have to enter Confirm Password.");
        setFocus(form.cpassword);
        return false;
      }

      if (form.password.value!=form.cpassword.value)
      {
        alert("The password you entered is not the same as the confirm password.");
        setFocus(form.cpassword);
        return false;
      }

    /*
      if (checkFieldEmpty(form.imagecode))
      {
         alert("You have to enter the same code shown by the below image");
         setFocus(form.imagecode);
         return false;
      }
    */
      if (!form.agreeto.checked)
      {
         alert("You have to check to agree to the terms and conditions.");
         setFocus(form.agreeto);
         return false;
      }

      showProcessBar();

      //  return true;
      return true;
  }
  catch (e)
  {
    alert("An exception occurred in the functon: validateMemberSignup()\nError name: " + e.name + "\nError message: " + e.message);
    return false;
  }
}

function validateUpdateMember(form)
{
  try {
      //. check the your name
      if (checkFieldEmpty(form.firstname))
      {
         alert("You have to enter First Name.");
         setFocus(form.firstname);
         return false;
      }

      if (checkFieldEmpty(form.lastname))
      {
         alert("You have to enter Last Name.");
         setFocus(form.lastname);
         return false;
      }

      //. check the email
      if (checkFieldEmpty(form.email))
      {
         alert("You have to enter Email.");
         setFocus(form.email);
         return false;
      }
      if (!validateEmail(form.email))
         return false;


      if (form.msexpireddate.value.length==10)
      {
         var now = new Date();
         var oldDate = parseDate(form.msexpireddate.value);
         if (now>=oldDate)
         {
           alert("You have to select date later than today.");
           return false;
         }
      }

      if (form.gender.selectedIndex==0)
      {
         alert("You have to select one of genders.");
         form.gender.focus();
         return false;
      }

      showProcessBar();

      //  return true;
      return true;
  }
  catch (e)
  {
    alert("An exception occurred in the functon: validateUpdateMember()\nError name: " + e.name + "\nError message: " + e.message);
    return false;
  }
}

function onSignInLoad(form, bFocus)
{
  var email = form.email.value;
  if (email.length==0)
     email = getCookie(form.domain_email.value);

//alert("username =" + username+","+form.domainname.value);
  if (email)
  {
    form.email.value = email;
    form.remember.checked = true;
//    setFocus(form.password);
  }
  else
  {
//    form.email.value = 'admin';
  }

  if (bFocus)
     setFocus(form.email);
}

function validateSignIn(form)
{
    //. check the email
    if (checkFieldEmpty(form.email))
    {
       alert("You have to enter E-Mail.");
       setFocus(form.email);
       return false;
    }
    if (!validateEmail(form.email))
       return false;

    //. check the password is empty or not
    if (checkFieldEmpty(form.password))
    {
        alert("You have to enter Password.");
        setFocus(form.password);
        return false;
    }

    setCookie(form.domain_email.value, form.remember.checked ? form.email.value : "");

    showProcessBar();
    
    return true;
}

function forgotPassword(form, sAction)
{
    setCookie(form.domain_email.value, form.remember.checked ? form.email.value : "");

    form.action1.value = sAction;//"Forgot Password_SignIn";
    form.submit();
}

function onPhotoFormLoad(form)
{
  setFocus(form.slogan);
}

function validatePhoto(form)
{
  try {
/*
    if (checkFieldEmpty(form.photofile))
    {
      alert("You have to browse a file first.");
      setFocus(form.browserfile);
      return false;
    }
*/
  if (!checkFieldEmpty(form.photofile))
  {
    if (!checkImageFileType(form.photofile, true))
    {
      setFocus(form.photofile);
      return false;
    }
  }

  if(form.photofile.value.length>0)
  {
    loadStatusPage(form.photofile.value);
  }
  else
  {
    showProcessBar();
  }

  return true;
 }
 catch(ex)
 {
  return false;
 }
}

function onCompanyFormLoad(form)
{
  setFocus(form.companyname);
}

function validateCompany(form)
{
  if (checkFieldEmpty(form.companyname))
  {
    alert("You missed to input company name.");
    setFocus(form.companyname);
    return false;
  }
  if (checkFieldEmpty(form.companydesc))
  {
      alert("You missed to input company description.");
      setFocus(form.companydesc);
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

  if (checkFieldEmpty(form.country))
  {
    alert("You missed to input Country.");
    setFocus(form.country);
    return false;
  }

  if (checkFieldEmpty(form.yourname))
  {
    alert("You missed to input contact person.");
    setFocus(form.yourname);
    return false;
  }

  if (checkFieldEmpty(form.email))
  {
    alert("You missed to input contact Email.");
    setFocus(form.email);
    return false;
  }

  if (!validateEmail(form.email))
     return false;

  if (checkFieldEmpty(form.phone))
  {
    alert("You missed to input contact phone.");
    setFocus(form.phone);
    return false;
  }

  if (!checkFieldEmpty(form.mapimagefile))
  {
     if (!checkImageFileType(form.mapimagefile, true))
      {
        setFocus(form.mapimagefile);
        return false;
      }
  }

  if (form.mapimagefile.value.length>0)
  {
     loadStatusPage(form.mapimagefile.value);
  }
  else
  {
     showProcessBar();
  }

  return true;
}

function onPasswordFormLoad(form)
{
    setFocus(form.opassword);
//alert("Your Name here");
}

function validatePassword(form)
{
  if (checkFieldEmpty(form.opassword))
  {
    alert("You missed to input old password.");
    setFocus(form.opassword);
    return false;
  }

  //. check the password is empty or not
  if (checkFieldEmpty(form.password))
  {
      alert("You have to enter Password.");
      setFocus(form.password);
      return false;
  }

  if (form.password.value==form.opassword.value)
  {
      alert("The new password can not be the same as the old password.");
      setFocus(form.password);
      return false;
  }
    
   //. check the confirm password
  if (checkFieldEmpty(form.cpassword))
  {
    alert("You have to enter Confirm Password.");
    setFocus(form.cpassword);
    return false;
  }

  if (form.password.value!=form.cpassword.value)
  {
    alert("The password you entered is not the same as the confirm password.");
    setFocus(form.cpassword);
    return false;
  }

  return true;
}

function validateCancel(form)
{
  if (confirm('Are you sure you want to close your account and remove all of your information?.'))
  {
    showHideSpan('close','WaitProcessId');
    showHideSpan('open','Processing');

    return true;
  }
  else
    return false;    
}

function validateSignInShareFile(form)
{
 try {
    //. check the email
    if (checkFieldEmpty(form.email))
    {
       alert("You have to enter E-Mail.");
       setFocus(form.email);
       return false;
    }
    if (!validateEmail(form.email))
       return false;

    //. check the password is empty or not
    if (checkFieldEmpty(form.password))
    {
        alert("You have to enter Password.");
        setFocus(form.password);
        return false;
    }

    setAction(form, 'SubmitSignIn_ShareFile');
    return true;
}
catch (ex)
{
  showException(ex, "validateSignInShareFile()");
  return false;
}

}

function onMembershipFormLoad(form)
{
//    setFocus(form.jointype);
//alert("Your Name here");
}

function onJoinTypeChange(form, bActive)
{
   showHideSpan(form.jointype.selectedIndex==2?'open':'close','payment_section');
   if (form.jointype.value==2)
   {
      setFocus(form.price);
//alert("bActive=" + bActive);
      if (!bActive)
        form.submit.disabled = "true";
   }
   else
      form.submit.disabled = "";


   if (form.jointype.value==3)
   {
      form.terms.disabled = "true";
   }
   else
   {
      form.terms.disabled = "";
   }
}

function validateMembership(form)
{
   try {
     if (form.jointype.selectedIndex==2)
     {
        if (checkFieldEmpty(form.price))
        {
          alert("You missed to input Service Fee.");
          setFocus(form.price);
          return false;
        }

        if (checkFieldEmpty(form.account))
        {
          alert("You missed to input Account Name.");
          setFocus(form.account);
          return false;
        }
     }
     return true;
  }
  catch (ex)
  {
    showException(ex, "validateMembership()");
    return false;
  }
}

function onServiceFormLoad(form, sUnitPrices)
{
    var arPrice = sUnitPrices.split(",");
    var fTotal = 0;
    for (var i=0; i<arPrice.length; i++)
    {
       var nTerm = parseInt(eval("form.term_" + i).value);
       var fUnitPrice = parseFloat(arPrice[i]);
       var fSubTotal = nTerm*fUnitPrice;
       setHtmlValueByElementId('id_subtotal_'+i, "<b>$"+fSubTotal.toFixed(2)+"</b>&nbsp;&nbsp;");

       fTotal += fSubTotal;
    }

    setHtmlValueByElementId('id_totalcharge', "<b>$"+fTotal.toFixed(2)+"</b>&nbsp;&nbsp;");

    form.amount.value = fTotal;
}

function onQuantityChange(form, nIndex, sUnitPrices)
{
   onServiceFormLoad(form, sUnitPrices);
}

function validateSubmitService(form, BuyerId, SellerId, sProductIds, sUnitPrices)
{
    var arPrice = sUnitPrices.split(",");
    var arProductId = sProductIds.split(",");

    var fTotal = 0;
    var sCustom = form.custom.value +  BuyerId + "," + SellerId + "|";
    var nCount = 0;
    for (var i=0; i<arPrice.length; i++)
    {
        var nTerm = parseInt(eval("form.term_" + i).value);
        var fUnitPrice = parseFloat(arPrice[i]);
        var fSubTotal = nTerm*fUnitPrice;
        if (nTerm>0)
        {
          fTotal += fSubTotal;
          if (nCount>0)
          {
            sCustom += ",";
          }
          sCustom += arProductId[i] + ":" + nTerm + ":"+fUnitPrice + ":3"; //Monthly 
          nCount++;
        }
    }

    if (fTotal==0)
    {
       alert("You have to select one of services.");
       return false;
    }

    form.amount.value = fTotal;
    form.custom.value = sCustom;    
//alert("sCustom=" + form.custom.value);

    return true;
}

function onLoadSearchUser(form)
{
   setFocus(form.firstname);
}

function validateSearchUser(form)
{
  try {
      //. check the your name
      var nCount = 0;
      if (!checkFieldEmpty(form.firstname))
      {
        nCount++;
      }

      if (!checkFieldEmpty(form.lastname))
      {
        nCount++;
      }

      if (!checkFieldEmpty(form.email))
      {
        nCount++;
      }

      if (nCount==0)
      {
         alert("You at least to input one of fields.");
         setFocus(form.firstname);      
         return false;
      }

      return true;
  }
  catch (ex)
  {
    showException(ex, "validateSearchUser()");
    return false;
  }
}

function validateUnlockcode(form)
{
try {
  if (checkFieldEmpty(form.unlockcode))
  {
     alert("You missed to input an unlock code.");
     setFocus(form.unlockcode);
     return false;
  }

  setAction(form, 'SubmitUnlockCode_ShareFile');
  return true;
}
catch (ex)
{
  showException(ex, "validateUnlockcode()");
  return false;
}

}

function startDownload(form, sAjaxUrl)
{
   setAction(form, 'Download_ShareFile');

   return tryDownload(form, sAjaxUrl);
}

function signInDownload(form, sAjaxUrl)
{
  if (!validateSignInShareFile(form))
    return false;
  else
    return tryDownload(form, sAjaxUrl);
}

function unLockDownload(form, sAjaxUrl)
{
  if (!validateUnlockcode(form))
    return false;
  else
    return tryDownload(form, sAjaxUrl);
}

function tryDownload(form, sAjaxUrl)
{
   try {

    var sRequest = getFormQuery(form);//  + "&time="+new Date().getTime();
//  alert("sRequest=" + sRequest);
    var sResponse = postUrlContent(sAjaxUrl, sRequest);
    var arReturn = sResponse.split("<!--!>");
 //alert("sResponse=" + sResponse+"!");
    document.getElementById('id_message').innerHTML = arReturn[1];

    if ("1"==arReturn[0])
    {
//       form.submit.disabled = "true";
       document.getElementById("download_submit").disabled = true;
       window.location.href = arReturn[2];
//       showDownloadFile('DownloadWin', 'Download is processing and Close it when the process ends', arReturn[2]);
    }

    return false;
  }
  catch (ex)
  {
     showException(ex, "tryDownload()");
     return false;
  }
}
