<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onMemberLoad(form)
{
  setFocus(form.lastname);
}

function validateMember(form)
{
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

  return true;
}