<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onMemberAreaLoad(form)
{
  setFocus(form.webcontent);
}

function validateMemberArea(form)
{
  if (checkFieldEmpty(form.webcontent))
  {
    alert("You have to enter name of content.");
    setFocus(form.webcontent);
    return false;
  }

  if (checkFieldEmpty(form.path))
  {
    alert("You have to enter relative path.");
    setFocus(form.path);
    return false;
  }

  return true;
}