<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onResponseFormLoad(form)
{
  setFocus(form.name);
}

function validateResponseForm(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter a name of auto-response group.")
    setFocus(form.name);
    return false;
  }

  if (checkFieldEmpty(form.fromemail))
  {
     alert("You have to input a from E-Mail address.")
     setFocus(form.fromemail);
     return false;
  }

  if (getRadioButton(form.typeflag, false)==-1)
  {
    alert("You have to select one of Send E-Mail To.");
    return false;
  }

  if (getRadioButton(form.typeflag, true)=="256")
  {
      if (form.maillistid.selectedIndex==0)
      {
         alert("You have to select one of group.")
         setFocus(form.maillistid);
         return false;
      }
  }

  if (getRadioButton(form.typeflag, true)=="4096")
  {
    if (checkFieldEmpty(form.emaillist))
    {
       alert("You have to input at least one email address.")
       setFocus(form.emaillist);
       return false;
    }
  }

  return true;
}

function onLetterFormLoad(form)
{
}

function validateLetterForm(form)
{
  return true;
}

function showCheck(form, objField)
{
  if (form.customers.checked)
     return;
  else if (form.subscribers.checked)
     return;
  else if (form.members.checked)
     return;

  objField.checked = true;
}

function validateTestMailForm(form1, form2)
{
  if (checkFieldEmpty(form1.subject))
  {
    alert("You have to enter Subject.")
    setFocus(form1.subject);
    return false;
  }

  updateTextArea('content');

  if (checkFieldEmpty(form1.content))
  {
    alert("You have to enter Content.")
//    setFocus(form1.subject);
    return false;
  }

  if (checkFieldEmpty(form2.yourname))
  {
    alert("You have to enter your name.")
    setFocus(form2.yourname);
    return false;
  }

  if (checkFieldEmpty(form2.email))
  {
    alert("You have to enter your E-Mail.")
    setFocus(form2.email);
    return false;
  }

  if (!validateEmail(form2.email))
      return false;

  form2.subject.value = form1.subject.value;
  form2.emailcontent.value = form1.content.value;

  //sendTestMail(form1, form2);

  return true;
}

function sendTestMail(form1, form2)
{
try {
  updateTextArea('content');

  var sRequest = "name=" + escape(form2.yourname.value)+"&email="+escape(form2.email.value);
  sRequest += "&subject=" + escape(form1.subject.value)+"&content="+escape(form1.content.value);
  sRequest += "&time="+new Date().getTime();
//alert("sRequest=" + sRequest);

  var sResponse = postContent("letter.jsp?action=Test Mail", sRequest);
//  alert("sResponse=!" + sResponse+"!");
  if (sResponse.substring(0,1)=="1")
     alert("It is successfully to send testing email to " + form2.email.value);
  else
     alert("It is failed to send testing email to " + form2.email.value + ". Please try it later.");

}
catch (e)
{
  alert(e.getMessage());
}
}

function onToListChange(section, show)
{
  if (show)
    showHideSpan('open',section);
  else
    showHideSpan('close',section);    
}