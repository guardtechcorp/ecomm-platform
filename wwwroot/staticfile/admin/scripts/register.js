<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onRegisterLoad(form)
{
   form.yourname.focus();
   form.yourname.select();	
}

function validateRegister(form)
{
    if (checkFieldEmpty(form.yourname))
    {
		alert("You have to input Your name.");
		setFocus(form.yourname);
		return false;
	}

    if (!validateEmail(form.email))
    {
		return false;
	}

    if (checkFieldEmpty(form.phone))
    {
		alert("You have to input phone number.");
		setFocus(form.phone);
		return false;
	}

    if (checkFieldEmpty(form.domainname))
    {
		alert("You have to input website name.");
		setFocus(form.domainname);
		return false;
	}

   if (checkFieldEmpty(form.password))
    {
		alert("You have to input password.");
		setFocus(form.password);
		return false;
	}

	if (form.password.value!=form.cpassword.value)
	{
		alert("The password and confirm password is not same.");
		setFocus(form.cpassword);
		return false;	
	}
	
	return true;
}