<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onProxyServerLoad(form)
{
  setFocus(form.name);
}

function validateProxyServer(form)
{
  //. check the server name
  if (checkFieldEmpty(form.name))
  {
     alert("You missed to input the serer name.");
     setFocus(form.name);
     return false;
  }
  //. check the IP address
  if (checkFieldEmpty(form.ip))
  {
     alert("You missed to input IP address.");
     setFocus(form.ip);
     return false;
  }

  return true;
}