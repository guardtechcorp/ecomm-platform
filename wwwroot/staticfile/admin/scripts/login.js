<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onLoginLoad(form)
{
  var username = form.username.value;
  if (username.length==0)
     username = getCookie(form.domainname.value);

//alert("username =" + username+","+form.domainname.value);
  if (username)
  {
    form.username.value = username;
    form.remember.checked = true;
    setFocus(form.password);
  }
  else
  {
    form.username.value = 'admin';
    setFocus(form.username);
  }
/*
  if (checkFieldEmpty(form.username))
    setFocus(form.username);
  else
    setFocus(form.password);
*/
}

function validateLogin(form)
{
    if (checkFieldEmpty(form.username))
    {
      alert("You have to enter Username.");
      setFocus(form.username);
      return false;
    }

    if (checkFieldEmpty(form.password))
    {
      alert("You have to enter password.");
      setFocus(form.password);
      return false;
    }

    setCookie(form.domainname.value, form.remember.checked ? form.username.value : "");
//    setCookie("account", form.remember.checked ? form.username.value : "");
    return true;
}
