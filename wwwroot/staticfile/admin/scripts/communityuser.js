<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onUserLoad(form)
{
//  setFocus(form.email);
}

function validateUser(form)
{
/*
  //. check the last name
  if (checkFieldEmpty(form.lastname))
  {
     alert("You missed to input last name.");
     setFocus(form.lastname);
     return false;
  }
  //. check the first name
  if (checkFieldEmpty(form.firstname))
  {
     alert("You missed to input first name.");
     setFocus(form.firstname);
     return false;
  }

  //. check the city name
  if (checkFieldEmpty(form.address))
  {
     alert("You missed to input address.");
     setFocus(form.city);
     return false;
  }

  //. check the city name
  if (checkFieldEmpty(form.city))
  {
     alert("You missed to input city.");
     setFocus(form.city);
     return false;
  }

  //. check the state name
  if (checkFieldEmpty(form.state))
  {
     alert("You missed to input state.");
     setFocus(form.state);
     return false;
  }

  //. check the zip code
  if (checkFieldEmpty(form.zip))
  {
     alert("You missed to input zip code.");
     setFocus(form.zip);
     return false;
  }

  //. check the home phone
  if (checkFieldEmpty(form.homephone))
  {
     alert("You missed to input home phone.");
     setFocus(form.homephone);
     return false;
  }

  //. check the email
  if (checkFieldEmpty(form.email))
  {
     alert("You missed to input home email.");
     setFocus(form.homephone);
     return false;
  }
*/

  if (form.usertype.selectedIndex==1)
  {
    if (checkFieldEmpty(form.expireddate))
    {
       alert("You have to enter Expired Date.");
       setFocus(form.expireddate);
       return false;
    }
  }


  return true;
}

function onUserSearchLoad(form)
{
  setFocus(form.firstname);
}

function validateUserSearch(form)
{
  //. check the email
  var bRet = false;
  //. check the your name
  if (!checkFieldEmpty(form.firstname))
  {
     return true;
  }
  if (!checkFieldEmpty(form.lastname))
  {
     return true;
  }
  //. User ID
  if (!checkFieldEmpty(form.userid))
  {
     bRet = true;
  }

  //. Ref ID
  if (!checkFieldEmpty(form.refid))
  {
     bRet = true;
  }

  if (!checkFieldEmpty(form.email))
  {
     bRet = true;
  }

  //. check the usercode
  if (!checkFieldEmpty(form.usercode))
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

  //. check the login date from
  if (!checkFieldEmpty(form.logindate_from))
  {
     bRet = true;
  }
  //. check the login date to
  if (!checkFieldEmpty(form.logindate_to))
  {
     bRet = true;
  }

  if (form.usertype.selectedIndex>0)
  {
     bRet = true;
  }

  if (!bRet)
  {
     alert("You at least to input one of fields.");
     setFocus(form.firstname);
     return false;
  }
  else
     return true;
}