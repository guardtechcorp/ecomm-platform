<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onDomainLoad(form, action)
{
   if (action=="Add Company Domain")
   {
     form.domainname.focus();
     form.domainname.select();
   }
   else
   {
     form.domainname.disabled="true";
   }
}

function validateDomain(form)
{
  if (checkFieldEmpty(form.domainname))
  {
      alert("You have to enter domain name.");
      setFocus(form.domainname);
      return false;
  }

  return true;
}

function onInvoiceLoad(form, action)
{
}

function validateInvoice(form)
{
  return true;
}
