<!--Copyright Info-->
<!--The contents of this file are copyrighted by ZYZ International Technology. -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function validateNewsletter(form)
{
  if (form.yourname.value.length==0)
  {
     alert("You have to enter your name.");
     form.yourname.focus();
     form.yourname.select();
     return false;
  }

  if (form.email.value.length==0)
  {
     alert("You have to enter your E-Mail");
     form.email.focus();
     form.email.select();
     return false;
  }

  if (!checkNewsEmail(form.email))
  {
      alert("Please enter a valid E-Mail address.");
      form.email.focus();
      form.email.select();

      return false;
  }

  return true;
}

function submitNewsletter(form, sJsp)
{
  try {

   if (!validateNewsletter(form))
      return;

   var sRequest = sJsp;//"/ctr/web/newsletter.jsp?action=subscriber";
   sRequest += "&domainname=" + form.domainname.value;
   sRequest += "&yourname=" + form.yourname.value;
   sRequest += "&email=" + form.email.value;
   sRequest += "&subscribe=1";// + getRadioValue(form.what);
   sRequest += "&time="+new Date().getTime();

//alert(sRequest);
    var sResponse = getUrlNewsContent(sRequest);
//alert("sResponse=" + sResponse+"!");
    if (sResponse.substring(0,1)=="0")
       document.getElementById("response").innerHTML = "<font color='green'>" + "Sign up is successful. Thank you." + "</font>";
    else if (sResponse.substring(0,1)=="4")
       document.getElementById("response").innerHTML = "<font color='green'>" + "Sign up is successful. Thank you." + "</font>";
    else if (sResponse.substring(0,1)=="1")
       document.getElementById("response").innerHTML = "<font color='green'>" + "Your information is changed. Thank you." + "</font>";
    else if (sResponse.substring(0,1)=="2")
       document.getElementById("response").innerHTML = "<font color='yellow'>" + "Your information was already existed in our online system." + "</font>";
    else //if (sResponse=="2")
       document.getElementById("response").innerHTML = "<font color='#FF0000'>" + "It failed to store your information. Please try it later." + "</font>";

    form.reset();
    form.submit.disabled = "true";
 }
 catch (ex)
 {
   alert("An exception occurred in the functon: submitNewsletter. \nError name: " + ex.name + "\nError message: " + ex.message);
   return false;
 }
}

function submitNewsletter2(form, sJsp)
{
  try {

   if (!validateNewsletter(form))
      return;

   var sRequest = sJsp;//"/ctr/web/newsletter.jsp?action=subscriber";
   sRequest += "&domainname=" + form.domainname.value;
   sRequest += "&yourname=" + form.yourname.value;
   sRequest += "&email=" + form.email.value;
   sRequest += "&subscribe=1";
   sRequest += "&note=" + getRadioValue(form.whoradio);
   sRequest += "&time="+new Date().getTime();

//alert(sRequest);
    var sResponse = getUrlNewsContent(sRequest);
//alert("sResponse=" + sResponse+"!");
    if (sResponse.substring(0,1)=="0")
       document.getElementById("response").innerHTML = "<font color='green'>" + "Sign up is successful. Thank you." + "</font>";
    else if (sResponse.substring(0,1)=="4")
       document.getElementById("response").innerHTML = "<font color='green'>" + "Sign up is successful. Thank you." + "</font>";
    else if (sResponse.substring(0,1)=="1")
       document.getElementById("response").innerHTML = "<font color='green'>" + "Your information is changed. Thank you." + "</font>";
    else if (sResponse.substring(0,1)=="2")
       document.getElementById("response").innerHTML = "<font color='yellow'>" + "Your information was already existed in our online system." + "</font>";
    else //if (sResponse=="2")
       document.getElementById("response").innerHTML = "<font color='#FF0000'>" + "It failed to store your information. Please try it later." + "</font>";

    form.reset();
    form.submit.disabled = "true";
 }
 catch (ex)
 {
   alert("An exception occurred in the functon: submitNewsletter. \nError name: " + ex.name + "\nError message: " + ex.message);
   return false;
 }
}

function getRadioValue(objRadio)
{
    var  sValue = "";
    for (i=0; i<objRadio.length;i++)
    {
      if (objRadio[i].checked)
      {
        sValue =  objRadio[i].value;
        break;
      }
    }
    return sValue;
}

function checkNewsEmail(email)
{
   var strEmail = email.value;    
   var at="@"
   var dot="."
   var lat=strEmail.indexOf(at)
   var lstr=strEmail.length
   var ldot=strEmail.indexOf(dot)

   if (strEmail.indexOf(at)==-1)
   {
      return false;
   }

   if (strEmail.indexOf(at)==-1 || strEmail.indexOf(at)==0 || strEmail.indexOf(at)==lstr)
   {
       return false;
   }

   if (strEmail.indexOf(dot)==-1 || strEmail.indexOf(dot)==0 || strEmail.indexOf(dot)==lstr)
   {
       return false;
   }

   if (strEmail.indexOf(at,(lat+1))!=-1)
   {
       return false;
   }

   if (strEmail.substring(lat-1,lat)==dot || strEmail.substring(lat+1,lat+2)==dot)
   {
       return false;
   }

   if (strEmail.indexOf(dot,(lat+2))==-1)
   {
       return false;
   }

   if (strEmail.indexOf(" ")!=-1)
   {
       return false;
   }

   return true;
}

function getUrlNewsContent(sUrl)
{
   var xmlhttp = getHttpNewsObject();
   xmlhttp.open("GET", sUrl, false);
   xmlhttp.send(null);
   strDoc = xmlhttp.responseText;
//alert("strDoc=" + strDoc);
   return strDoc;
}

function getHttpNewsObject()
{
    var xmlhttp;
    if (window.XMLHttpRequest)
    { // Mozilla, Safari,...
       xmlhttp = new XMLHttpRequest();
    }
    else if (window.ActiveXObject)
    { // IE
      try { // ??? IE
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
      }
      catch (e)
      {
        try { // ??? IE
          xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {}
      }
   }

   return xmlhttp;
}

function onMailListLoad(form)
{
   form.yourname.focus();
   form.yourname.select();
}

function onValidateMailList(form)
{
    if (form.yourname.value.length==0)
    {
       alert("You have to enter Receiver Name.");
       form.yourname.focus();
       form.yourname.select();
       return false;
    }

    if (form.email.value.length==0)
    {
       alert("You have to enter E-Mail");
       form.email.focus();
       form.email.select();
       return false;
    }

    return true;
}

function onMailListGroupLoad(form)
{
   form.name.focus();
   form.name.select();
}

function onValidateMailListGroup(form)
{
    if (form.name.value.length==0)
    {
       alert("You have to enter a group name.");
       form.name.focus();
       form.name.select();
       return false;
    }

    if (form.merge.selectedIndex>0)
    {
       if (form.togroupid.selectedIndex==0)
       {
          alert("You have to select one of group to merge.");
          return false;
       }
    }

    return true;
}

function onMergeChange(form)
{
   if (form.merge.selectedIndex==0)
      form.togroupid.disabled = true;
   else
      form.togroupid.disabled = false;       
}
