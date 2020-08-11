<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onFeedbackLoad(form)
{
   form.yourname.focus();
   form.yourname.select();
}

function validateFeedback(form)
{
  if (checkFieldEmpty(form.yourname))
  {
     alert(getAlertMsg(8));
     form.yourname.focus();
     form.yourname.select();
     return false;
  }

  if (checkFieldEmpty(form.email))
  {
     alert(getAlertMsg(6));
     form.email.focus();
     form.email.select();
     return false;
  }
  if (!validateEmail(form.email))
     return false;

  if (checkFieldEmpty(form.content))
  {
     alert(getAlertMsg(32));
     form.content.focus();
     form.content.select();
     return false;
  }

  return true;
}

function validateFeedback2(form, sEditorId)
{
  updateTextArea(sEditorId);

  return validateFeedback(form);
}
