<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onFeedbackLoad(form)
{
    form.response.focus();
//    form.response.select();
}

function validateFeedback(form)
{
    if (checkFieldEmpty(form.response))
    {
      alert("You have to enter your response.");
      setFocus(form.response);
      return false;
    }

    return true;
}

function validateFeedback2(form, sEditorId)
{
    updateTextArea(sEditorId);//'content');
    
    if (checkFieldEmpty(form.response))
    {
      alert("You have to enter your response.");
      setFocus(form.response);
      return false;
    }

    return true;
}
