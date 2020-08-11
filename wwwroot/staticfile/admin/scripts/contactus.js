<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onContactUsLoad(form)
{
  setFocus(form.companyname);
}

function validateContactUs(form)
{
  if (checkFieldEmpty(form.companyname))
  {
    alert("You missed to input company name.");
    setFocus(form.companyname);
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

  if (!checkFieldEmpty(form.email))
  {
    if (!validateEmail(form.email))
       return false;
  }

  if (form.location.selectedIndex==1)
  {
    if (checkFieldEmpty(form.mapimage)&&checkFieldEmpty(form.mapimagefile))
    {
       alert("You have to browser a image file.");
       setFocus(form.mapimagefile);
       return false;
    }
  }

  if (!checkFileType(form.mapimagefile, true))
  {
    setFocus(form.mapimagefile);
    return false;
  }

  return true;
}

function onContactServiceLoad(form)
{
  setFocus(form.name);
}

function validateContactService(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You missed to input Name.");
    setFocus(form.name);
    return false;
  }

  if (checkFieldEmpty(form.description))
  {
    alert("You missed to input Description.");
    setFocus(form.description);
    return false;
  }

  if (!checkFieldEmpty(form.email))
  {
    if (!validateEmail(form.email))
       return false;
  }

  return true;
}