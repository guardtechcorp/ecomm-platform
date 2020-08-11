<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->
function onEmailLoad(form)
{
//  alert("onEmailLoad");
  onGroupChange(form);
}

function onGroupChange(form)
{
    if (form.group.selectedIndex==0)
    {
       form.toemail.disabled = "";
       if (checkFieldEmpty(form.toemail))
         setFocus(form.toemail);
       else
         setFocus(form.subject);
    }
    else
    {
       form.toemail.disabled = "true";
       setFocus(form.subject);
    }

    if (form.group.options[form.group.selectedIndex].value=="selectedcustomers")
//    if (form.group.selectedIndex==2)
      showHide('open','EDIT_SELECTION');
    else
      showHide('close','EDIT_SELECTION');
}

function onFormatChange(form)
{
   if (form.format.selectedIndex==0)
   {
      showHide('close','HTML_MSG');
      showHide('open','TEXT_MSG');
      form.content.focus();
   }
   else //if (format.selectedIndex==1)
   {
      showHide('close','TEXT_MSG');
      showHide('open','HTML_MSG');
      initOuterIFrame();
      form.subject.focus();
   }
}

function validateSendEmail(form)
{
//alert("validate Email now");
  if (form.group.selectedIndex==0)
  {
    if (checkFieldEmpty(form.toemail))
    {
      alert("You have to enter email address.")
      setFocus(form.toemail);
      return false;
    }

    var arEmail = form.toemail.value.split(";");
    for (i=0; i<arEmail.length; i++)
    {
       if (!validateEmailValue(arEmail[i]))
         return false;
    }
  }

  if (form.copyto.checked)
  {
    if (checkFieldEmpty(form.ccemail))
    {
      alert("You have to enter email address at copy To field.")
      setFocus(form.ccemail);
      return false;
    }

    if (!validateEmail(form.ccemail))
        return false;
  }

  if (checkFieldEmpty(form.subject))
  {
     alert("You have to input some text on the subject.")
     setFocus(form.subject);
     return false;
  }

  if (form.group.selectedIndex==0)
  {
    if (!confirm('Are you sure you want to send email to ' + form.toemail.value + '.'))
      return false;
  }
  else
  {
    var sRecipients = form.group.options[form.group.selectedIndex].text
    if (!confirm('Are you sure you want to send email to ' + sRecipients + '.'))
      return false;
  }

  return true;
}

function showSelection(nTotalSelection)
{
//   if (eval("document.all.totalselection")!=null)
  document.getElementById('totalselection').innerHTML = "(<font color='#ffff00'><b>"+ g_nTotalSelection + "</b></font> selected)";
}

function validateTestMailForm(form1, form2)
{
  if (checkFieldEmpty(form1.subject))
  {
    alert("You have to enter Subject.")
    setFocus(form1.subject);
    return false;
  }

  if (form1.format.selectedIndex==0)
  {
    if (checkFieldEmpty(form1.content))
    {
      alert("You have to enter Content.")
      setFocus(form1.content);
      return false;
    }
  }
  else
  {
//alert("form.innerHTML=" + post.innerHTML);
/*
    if (checkFieldEmpty(form1.msg_html))
    {
      alert("You have to enter Content.")
//      setFocus(form1.msg);
      return false;
    }
*/
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

  sendTestMail(form1, form2);

  return false;
}

function sendTestMail(form1, form2)
{
//alert("form1.content.value=" + form1.content.value);
    var sRequest = "name=" + escape(form2.yourname.value)+"&email="+escape(form2.email.value);
    if (form1.format.selectedIndex==0)
      sRequest += "&format=text";
    else
      sRequest += "&format=html";
    sRequest += "&subject=" + escape(form1.subject.value)+"&from=" + escape(form1.fromemail.options[form1.fromemail.selectedIndex].value);
    if (form1.format.selectedIndex==0)
       sRequest +="&content="+escape(form1.content.value);
    else
       sRequest +="&content="+escape(post.innerHTML);
    sRequest += "&time="+new Date().getTime();
    var sResponse = postContent("email.jsp?action=Test Mail", sRequest);
//    var sResponse = getUrlContent("email.jsp?action=Test Mail&"+sRequest);
//  alert("sResponse=!" + sResponse+"!");
    if (sResponse.substring(0,1)=="1")
      alert("It is successfully to send testing email to " + form2.email.value);
    else
      alert("It is failed to send testing email to " + form2.email.value + ". Please try it later.");
}
