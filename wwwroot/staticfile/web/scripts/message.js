<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onMessageLoad(form)
{
    setFocus(form.response);
}

function validateMessage(form)
{
 if (form.action1.value=="Replay_MsgInbox")
 {
     if (checkFieldEmpty(form.response))
     {
        alert("You have to enter response message.");
        setFocus(form.response);
        return false;
     }
 }
 else
 {
    if (!validateForwardMessage(form))
       return false;
 }

 return true;
}

function validateForwardMessage(form)
{
 if (checkFieldEmpty(form.emails))
 {
    alert("You have to enter email(s).");
    setFocus(form.emails);
    return false;
 }

 var arEmails = form.emails.value.split(",");
 for (var i=0; i<arEmails.length; i++)
 {
    if (!validateEmail(arEmails[i]))
    {
       setFocus(form.emails);
       return false;
    }
 }
    
 return true;
}

function onPostMessageFormLoad(form)
{
  setFocus(form.subject);
}

function validatePostMessage(form)
{
  //. check the price from
  if (checkFieldEmpty(form.subject))
  {
     alert("You have to input subject.")
     setFocus(form.subject);
     return false;
  }

  //. check price to
  if (checkFieldEmpty(form.keywords))
  {
      alert("You have to input keywords.")
      setFocus(form.keywords);
      return false;
  }

  //. check product name
  if (checkFieldEmpty(form.briefdesc))
  {
      alert("You have to input brief description.")
      setFocus(form.briefdesc);
      return false;
  }

  form.categoryids.value = getMultipleCheckboxIds(form, "cat_", ',');
  if (form.categoryids.value.length==0)
  {
     alert("You have to select at least one of categories.");
     return false;
  }
  form.categoryids.value += ",";

  return true;
}



