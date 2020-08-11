<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onStorageFormLoad(form)
{
  setFocus(form.maxspace);
}

function validateSubdomain(form)
{
  if (checkFieldEmpty(form.maxsapce))
  {
     alert("You missed to input max space.");
     setFocus(form.name);
     return false;
  }

  if (checkFieldEmpty(form.maxbandwidth))
  {
     alert("You missed to input max bandwidth.");
     setFocus(form.name);
     return false;
  }

  return onlyonce();
}
