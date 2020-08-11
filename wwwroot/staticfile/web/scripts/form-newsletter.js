<!--Copyright Info-->
<!--The contents of this file are copyrighted by ZYZ International Technology. -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onWindowClose()
{
   var sRequest = "http://test101.web.zyzit.com/ctr/web/newsletter.jsp?action=subscriber";
   sRequest += "?action=subscriber";
   sRequest += "&yourname=Neil Zhao";
   sRequest += "&email=nzhao@yahoo.com"
   sRequest += "&subscribe=1";
   sRequest += "&time="+new Date().getTime();
   var sResponse = sendActionToServer(sRequest);

   alert("Are you sure you want to stop this session?");
}

function validateNewsletter(form)
{
  if (checkFieldEmpty(form.yourname))
  {
     alert("You missed to input your name.");
     form.yourname.focus();
     form.yourname.select();
     return false;
  }

  if (checkFieldEmpty(form.email))
  {
     alert("You missed to input your E-Mail.");
     form.email.focus();
     form.email.select();
     return false;
  }

  if (!validateEmail(form.email))
     return false;
  else
     return true;
}

function submitNewsletter(form)
{
   if (!validateNewsletter(form))
      return;

   var sRequest = form.serverurl.value;//"http://test101.web.zyzit.com/ctr/web/newsletter.jsp?action=subscriber";
   sRequest += "?action=subscriber";
//   sRequest += "&domainname=" + form.domainname.value;
   sRequest += "&yourname=" + form.yourname.value;
   sRequest += "&email=" + form.email.value;
   sRequest += "&subscribe=" + getRadioValue(form.what);
   sRequest += "&time="+new Date().getTime();

//alert(sRequest);
    var sResponse = getUrlContent(sRequest);
//alert("sResponse=" + sResponse+"!");
    if (sResponse.substring(0,1)=="0")
       response.innerHTML = "<font color='#FF0000'>" + "Your information is received. Thank you." + "</font>";
    else if (sResponse.substring(0,1)=="4")
       response.innerHTML = "<font color='#FF0000'>" + "Your information is received. And you will receive a coupon in email." + "</font>";
    else if (sResponse.substring(0,1)=="1")
       response.innerHTML = "<font color='#FF0000'>" + "Your information is changed. Thank you." + "</font>";
    else if (sResponse.substring(0,1)=="2")
       response.innerHTML = "<font color='#FF0000'>" + "Your information was already existed in our online system." + "</font>";
    else //if (sResponse=="2")
       response.innerHTML = "<font color='#FF0000'>" + "It failed to store your information. Please try it later." + "</font>";

    form.reset();
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

function checkFieldEmpty(objField)
{
  var sValue = trim(objField.value);
  return sValue.length==0;
}

function validateEmail(objEmail)
{
  if (!validateEmailValue(objEmail.value))
  {
    setFocus(objEmail);
    return false;
  }
  else
    return true;
}

function validateEmailValue(strEmail)
{
   var at="@"
   var dot="."
   var lat=strEmail.indexOf(at)
   var lstr=strEmail.length
   var ldot=strEmail.indexOf(dot)

   if (strEmail.indexOf(at)==-1)
   {
       alert("Invalid E-mail Address.");
      return false;
   }

   if (strEmail.indexOf(at)==-1 || strEmail.indexOf(at)==0 || strEmail.indexOf(at)==lstr)
   {
       alert("Invalid E-mail Address.");
       return false;
   }

   if (strEmail.indexOf(dot)==-1 || strEmail.indexOf(dot)==0 || strEmail.indexOf(dot)==lstr)
   {
       alert("Invalid E-mail Address.");
       return false;
   }

   if (strEmail.indexOf(at,(lat+1))!=-1)
   {
       alert("Invalid E-mail Address.");
       return false;
   }

   if (strEmail.substring(lat-1,lat)==dot || strEmail.substring(lat+1,lat+2)==dot)
   {
       alert("Invalid E-mail Address.");
       return false;
   }

   if (strEmail.indexOf(dot,(lat+2))==-1)
   {
       alert("Invalid E-mail Address.");
       return false;
   }

   if (strEmail.indexOf(" ")!=-1)
   {
       alert("Invalid E-mail Address.");
       return false;
   }

   return true;
}

function setFocus(objInput)
{
    objInput.focus();
    objInput.select();
}

function trim(str)
{
  var nStart = 0;
  var nEnd = str.length;
  if (nEnd<0)
     return str;

  for (var i=0; i<=nEnd; i++)
  {
    if (str.charCodeAt(i)!=32)
       break;
    nStart = i+1;
  }

  if (nStart>=nEnd)
     return "";

  for (var i=nEnd; i>=0; i--)
  {
    if (str.charCodeAt(i)!=32)
       break;
    nEnd = i-1;
  }
  nEnd++;
  str = str.substring(nStart, nEnd);
  return str;
}

function getUrlContent(sUrl)
{
  var xmlhttp = new XMLHttpRequest();
  xmlhttp.open("GET", sUrl, false);
  xmlhttp.send(null);
  strDoc = xmlhttp.responseText;
//alert("strDoc=" + strDoc);
  return strDoc;
}

function sendActionToServer(sUrl)
{
  var imageObject = new Image();
  imageObject.src = sUrl;
}
