<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology. -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onTellFriendLoad(form, nErrorNo)
{       
   if (nErrorNo!=5002)
   {
     form.friendemail1.focus();
     form.friendemail1.select();
   }
   else
   {
     form.input.focus();
     form.input.select();
   }
}

function validateTellFriend(form)
{
    if (checkFieldEmpty(form.friendemail1))
    {
       alert(getAlertMsg(43));
       form.friendemail1.focus();
       form.friendemail1.select();
       return false;
    }
    if (!validateEmail(form.friendemail1))
         return false;

    if (!checkFieldEmpty(form.friendemail2))
    {
      if (!validateEmail(form.friendemail2))
         return false;
    }

    if (!checkFieldEmpty(form.friendemail3))
    {
      if (!validateEmail(form.friendemail3))
         return false;
    }

    if (!checkFieldEmpty(form.friendemail4))
    {
      if (!validateEmail(form.friendemail4))
         return false;
    }

    if (!checkFieldEmpty(form.friendemail5))
    {
        if (!validateEmail(form.friendemail5))
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

    if (checkFieldEmpty(form.input))
    {
       alert("You have to enter the code shown by the below image");
       form.input.focus();
       form.input.select();
       return false;
    }

    return true;
}

function onFormatChange(form)
{
   if (form.format.selectedIndex==0)
   {
       showHide('close','TEXT_MSG');
       showHide('open','HTML_MSG');
       form.content.focus();
   }
   else //if (format.selectedIndex==1)
   {
       showHide('close','HTML_MSG');
       showHide('open','TEXT_MSG');
       form.contenttext.focus(); 
   }
}

function validateSendEmail(form)
{
  try
  {
     if (checkFieldEmpty(form.toemail))
     {
        alert("You have to enter email address.")
        setFocus(form.toemail);
        return false;
     }

     if (form.copyto.checked)
     {
        if (checkFieldEmpty(form.fromemail))
        {
          alert("You have to enter from email address.")
          setFocus(form.fromemail);
          return false;
        }
    //    if (!validateEmail(form.ccemail))
    //        return false;
     }

     if (checkFieldEmpty(form.subject))
     {
         alert("You have to input some text on the subject.")
         setFocus(form.subject);
         return false;
     }

     if (form.format.selectedIndex==0)
     {
          updateTextArea('content');
          if (form.content.value.length<5)
          {
             alert("You have to input some content.");
             form.content.focus();
             return false;
          }
     }
     else
     {
         if (checkFieldEmpty(form.contenttext))
         {
             alert("You have to input some text on the content.")
             setFocus(form.contenttext);
             return false;
         }
    }

    return true;
  }
  catch (ex)
  {
     showException(ex, "validateSendEmail()");
     return false;
  }
}

function validateTestMailForm(form, form2, sUrl)
{
  try
  {
    if (checkFieldEmpty(form.subject))
    {
        alert("You have to input some text on the subject.")
        setFocus(form.subject);
        return false;
    }

    if (form.format.selectedIndex==0)
    {
         updateTextArea('content');
         if (form.content.value.length<5)
         {
            alert("You have to input some content.");
            form.content.focus();
            return false;
         }
    }
    else
    {
        if (checkFieldEmpty(form.contenttext))
        {
            alert("You have to input some text on the content.")
            setFocus(form.contenttext);
            return false;
        }
    }

    if (checkFieldEmpty(form2.toemail))
    {
        alert("You have to enter your E-Mail.")
        setFocus(form2.toemail);
        return false;
    }

    sendTestMail(form, form2, sUrl);
 }
 catch (ex)
 {
   showException(ex, "validateTestEmail()");
 }

  return false;
}

function sendTestMail(form, form2, sUrl)
{
    var sRequest;
    if (form.format.selectedIndex==0)
      sRequest = "format=html";
    else
      sRequest = "format=text";
    sRequest += "&toemail=" + encodeURIComponent(form2.toemail.value);
    sRequest += "&fromemail=" + encodeURIComponent(form.fromemail.value);
    sRequest += "&subject=" + encodeURIComponent(form.subject.value);
    if (form.format.selectedIndex==0)
    {
       updateTextArea('content');
       sRequest +="&content="+encodeURIComponent(form.content.value);
    }
    else
       sRequest +="&contenttext="+encodeURIComponent(form.contenttext.value);
    sRequest += "&time="+new Date().getTime();
//alert("sRequest=" + sRequest);
    
    var sResponse = postUrlContent(sUrl, sRequest);
//    var sResponse = getUrlContent("email.jsp?action=Test Mail&"+sRequest);
//  alert("sResponse=!" + sResponse+"!");
    if (sResponse.substring(0,1)=="0")
      alert("It is successfully to send testing email to " + form2.toemail.value);
    else
      alert("It failed to send testing email to " + form2.toemail.value + ". Please try it later.");
}
