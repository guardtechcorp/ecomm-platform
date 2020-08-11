<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onQuotaFormLoad(form)
{
  setFocus(form.quantity);
}

function validateQuotaForm(form)
{
  if (checkFieldEmpty(form.quantity))
  {
     alert("You missed to input quantity.");
     setFocus(form.quantity);
     return false;
  }

  return onlyonce();
}
