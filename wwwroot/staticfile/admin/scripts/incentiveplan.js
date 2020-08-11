<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onIncentiveLoad(form)
{
}

function validateIncentive(form)
{

  return true;
}

function onCouponLoad(form)
{
  setFocus(form.name);
}

function validateCoupon(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter group name.");
    setFocus(form.name);
    return false;
  }

  if (checkFieldEmpty(form.count))
  {
    alert("You have to enter total count.");
    setFocus(form.count);
    return false;
  }

  if (checkFieldEmpty(form.nolength))
  {
    alert("You have to enter string length.");
    setFocus(form.name);
    return false;
  }


  return true;
}

