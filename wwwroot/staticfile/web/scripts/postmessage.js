<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onPostMessageFormLoad(form)
{
  setFocus(form.subject);
}

function validatePostMessage(form)
{
  //. check the price from
  if (checkFieldEmpty(form.subject))
  {
     alert("You have to input subject.")
     setFocus(form.subject);
     return false;
  }

  //. check price to
  if (checkFieldEmpty(form.keywords))
  {
      alert("You have to input keywords.")
      setFocus(form.keywords);
      return false;
  }

  //. check product name
  if (checkFieldEmpty(form.briefdesc))
  {
      alert("You have to input brief description.")
      setFocus(form.briefdesc);
      return false;
  }

  return true;
}
