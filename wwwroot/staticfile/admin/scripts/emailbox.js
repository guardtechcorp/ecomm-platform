<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onEmailBoxFormLoad(form)
{
  setFocus(form.name);
}

function validateEmailBoxForm(form, sDomainName)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter a E-Mail Addrees.")
    setFocus(form.name);
    return false;
  }

//alert(form.name.value+'@'+ sDomainName);
  if (!validateEmailValue(form.name.value+'@'+ sDomainName))
  {
    setFocus(form.name);
    return false;
  }

  if (form.type.selectedIndex>0)
  {
    if (checkFieldEmpty(form.password))
    {
      alert("You have to enter password.");
      setFocus(form.password);
      return false;
    }

    if (checkFieldEmpty(form.cpassword))
    {
      alert("You have to enter confirm password.");
      setFocus(form.cpassword);
      return false;
    }

    if (form.password.value!=form.cpassword.value)
    {
      alert("The password and confirm password is not same.");
      setFocus(form.cpassword);
      return false;
    }
  }
  else
  {
    if (checkFieldEmpty(form.forward))
    {
       alert("You have to input at least one of Forward E-Mail addresses.")
       setFocus(form.forward);
       return false;
    }
  }

  return true;
}

function onEmailTypeChange(form, objSelect)
{
  if (objSelect.selectedIndex==0)
  {
    form.password.disabled = "true";
    form.cpassword.disabled = "true";
    form.userid.disabled = "true";
  }
  else
  {
    form.password.disabled = "";
    form.cpassword.disabled = "";
    form.userid.disabled = "";
  }
}