<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onMemberSettingLoad(form)
{
}

function validateMemberSetting(form)
{
  return true;
}


function onMemberAreaLoad(form)
{
  setFocus(form.name);
}

function validateMemberArea(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter name of member area.");
    setFocus(form.name);
    return false;
  }

  return true;
}

function onMemberPlanLoad(form)
{
  setFocus(form.name);
}

function validateMemeberPlan(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter name of plan.");
    setFocus(form.name);
    return false;
  }

  return true;
}

function onMemberLoad(form)
{
  setFocus(form.email);
}

function validateMember(form)
{
/*
  if (checkFieldEmpty(form.firstname))
  {
     alert("You missed to input first name.");
     setFocus(form.firstname);
     return false;
  }
  if (checkFieldEmpty(form.lastname))
  {
     alert("You missed to input last name.");
     setFocus(form.name);
     return false;
  }
*/

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
     alert("The password adn confir password is not the same.");
     setFocus(form.cpassword);
     return false;
  }

  return true;
}

function onMemberLoginLoad(form)
{
  var email = getCookie("member-" + form.domainname.value);
//alert("username =" + username+","+form.domainname.value);
  if (email)
  {
    form.email.value = email;
    form.remember.checked = true;
    setFocus(form.password);
  }
  else
    setFocus(form.email);
}

function validateMemberLogin(form)
{
  if (checkFieldEmpty(form.email))
  {
     alert("You missed to input email.");
     setFocus(form.email);
     return false;
  }

  if (!validateEmail(form.email))
     return false;

  if (checkFieldEmpty(form.password))
  {
    alert("You have to enter password.");
    setFocus(form.password);
    return false;
  }

  setCookie("member-" + form.domainname.value, form.remember.checked ? form.email.value : "");

  return true;
}

function hasEmailAccount(form)
{
  if (checkFieldEmpty(form.email))
  {
     alert("You missed to input email.");
     setFocus(form.email);
     return false;
  }

  if (!validateEmail(form.email))
     return false;
  else
     return true;
}

function forgotPassword(form, sJspFile, sDomainName)
{
//alert("forgot=" + sJspFile + "?action=forgotpassword&email="+form.email.value + "&domainname="+sDomainName);
  window.location.href = sJspFile + "?action=Forgot Password&email="+form.email.value + "&domainname="+sDomainName;//+"&prevuri="+form.prevuri.value;
}

function onSearchFormLoad(form)
{
  setFocus(form.name);
}

function validateSearch(form)
{
    var bRet = false;
    if (!checkFieldEmpty(form.name))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.company))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.workphone))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.email))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.address1))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.city))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.state))
    {
       bRet = true;
    }
    if (!checkFieldEmpty(form.zip))
    {
       bRet = true;
    }

    //. check the order
    if (!checkFieldEmpty(form.country))
    {
       bRet = true;
    }

    //. check the create date from
    if (!checkFieldEmpty(form.createdate_from))
    {
       bRet = true;
    }

    //. check the create date to
    if (!checkFieldEmpty(form.createdate_to))
    {
       bRet = true;
    }

    if (!bRet)
    {
       alert("You have to input at least one of fields.");
       setFocus(form.name);
       return false;
    }
    else
       return true;
}

