<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onUserLoad(form, action)
{
   if (action=="Update User"||action=="Update Now")
   {
     form.username.disabled="true";
     form.realname.focus();
     form.realname.select();
   }
   else
   {
     form.username.focus();
     form.username.select();
   }
}

function validateUser(form)
{
    if (checkFieldEmpty(form.username))
    {
        alert("You have to enter username.");
        setFocus(form.username);
        return false;
    }

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

    form.username.disabled="";
    if (form.cb_grant!=null)
       form.cb_grant.disabled="";

    return true;
}
