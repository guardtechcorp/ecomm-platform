<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onSubdomainLoad(form)
{
  setFocus(form.name);
}

function validateSubdomain(form, domain)
{
  if (checkFieldEmpty(form.name))
  {
     alert("You missed to input your sub-domain name.");
     setFocus(form.name);
     return false;
  }

  if (!checkDomain(form.name.value + "." + domain))
  {
    setFocus(form.name);
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

  if (checkFieldEmpty(form.input))
  {
   alert("You have to enter the code shown by the image below");
   setFocus(form.input);
   return false;
  }

  var sRequest = "../util/captcha.jsp?action=validate&userinput=" + form.input.value + "&time="+new Date().getTime();
  var sResponse = getUrlContent(sRequest);
//alert("sResponse=" + sResponse +"!");
  if (sResponse.indexOf("false")==0)
  {
     document.captchaimg.src = "../util/captcha.jsp?action=getimage&time="+new Date().getTime();
     alert("The code you entered did not match with the one shown on the image below.");
     form.input.value = "";
     setFocus(form.input);
     return false;
  }

  if (!form.agreeto.checked)
  {
     alert("You have to check to agree to the terms of service.");
     setFocus(form.agreeto);
     return false;
  }

//  form.domainname.value = form.name.value + "." + domain;

  return onlyonce();
}

function onSubdomainFormLoad(form)
{
  setFocus(form.yourname);
}

function validateSubdomainForm(form, domain)
{
  if (checkFieldEmpty(form.name))
  {
     alert("You missed to input your sub-domain name.");
     setFocus(form.name);
     return false;
  }

  if (!checkDomain(form.name.value + "." + domain))
  {
    setFocus(form.name);
    return false;
  }

  if (checkFieldEmpty(form.yourname))
  {
     alert("You missed to input customer name.");
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

  return onlyonce();
}
