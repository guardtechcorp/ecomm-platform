<!--Copyright Info-->
<!--The contents of this file are copyrighted by ZYZ International Technology. -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

var nCountOfTimes = 0;
var nIdleInterval = 590*1000;
var g_IdleJspFile = "../share/idle.jsp";
function sendIdleFlag()
{
  if (nCountOfTimes>0)
  {
    var sRequest = "../signin/login.jsp?action=idle&count="+nCountOfTimes;
    sRequest += "&time="+new Date().getTime();
    sendActionToServer(sRequest);
  }
//alert("sendIdleFlag=" + nCountOfTimes+","+nSeconds);
  nCountOfTimes++;
  setTimeout('sendIdleFlag()', 580*1000);
}

function sendIdleFlag2(nSeconds, sJspFile)
{
  if (sJspFile!=null)
     g_IdleJspFile = sJspFile;

  if (nCountOfTimes>0)
  {
    var sRequest = g_IdleJspFile + "&count="+nCountOfTimes;
    sRequest += "&time="+new Date().getTime();
//alert("sRequestxx=" + sRequest);
    sendActionToServer(sRequest);
  }

  if (nSeconds!=null)
     nIdleInterval = nSeconds*1000;
  nCountOfTimes++;
  setTimeout('sendIdleFlag2()', nIdleInterval);
}

function onWebPageLoad(sAction)
{
  var sRequest;// = "/ctr/web/index.jsp?action=webpageload";
  if (sAction!=null)
     sRequest = "/ctr/admin/share/idle.jsp?action=" + sAction;
  else
     sRequest = "/ctr/admin/share/idle.jsp?action=Home";//webpageload";

//  sRequest += "&time="+new Date().getTime();
//alert(sRequest);
  sendActionToServer(sRequest);
}

function onBrowserClose(sJspFile, bFlag)
{
  if (self.screenTop>9000)// || (window.event!=null && window.event.clientY < 0 && (window.event.clientX > (document.documentElement.clientWidth - 5) || (window.event!=null && window.event.clientX < 15))))
  {
    var sRequest;//
    if (bFlag!=null && bFlag)
    {
      sRequest = sJspFile;
    }
    else
    {
        if (sJspFile!=null)
          sRequest = sJspFile +"?action=logout&type=windowclose";
        else
          sRequest = "/ctr/admin/share/idle.jsp?action=logout&type=windowclose";
    }

    sRequest += "&time="+new Date().getTime();
    var sResponse = getUrlContent(sRequest);
//??    sendActionToServer(sRequest);
  }
}

function showVisitorCount(nFontSize, bkColor, sDomainName, sUseCtr)
{
  var sRequest
  if (sUseCtr==null)
     sRequest = "/ctr/admin/share/idle.jsp";
  else
     sRequest = sUseCtr + "/admin/share/idle.jsp";

  if (sDomainName!=null)
     sRequest += "?domainname=" + sDomainName + "&";
  else
     sRequest += "?";
  sRequest += "action=Get Visitors" + "&time="+new Date().getTime();

  var nTotal = getUrlContent(sRequest);
  document.write('<table border="1" cellspacing=0 cellpadding=0 align="center"><tr><td>');
  document.write('<span style="background-color: '+bkColor+';color: yellow;font: bold '+nFontSize+'px MS Sans Serif;padding: 3px;">');
  document.write('<span style="color: lime;font-size: 60%;">Total</span>');
  document.write(' ' + nTotal + ' ');
  document.write('<span style="color: lime;font-size: 60%;">Visitors</span></span>');
  document.write('</td></tr></table>');
}
//<script type="text/javascript">showVisitorCount(16, 'blue')</script>

function onMemberLoad()
{
  if (nCountOfTimes>0)
  {
    var sRequest = "/ctr/admin/membership/login.jsp?action=idle&count="+nCountOfTimes;
    sRequest += "&time="+new Date().getTime();
    sendActionToServer(sRequest);
  }

  var nSeconds = 4*60;
  if (nSeconds!=null)
     nIdleInterval = nSeconds*1000;
//alert("onMemberLoad" + nCountOfTimes+","+nSeconds);
  nCountOfTimes++;
  setTimeout('onMemberLoad()', nIdleInterval);
}

function onMemberUnload()
{
  var top=self.screenTop;
//alert("top=" + top);
  if (top>9000)
  {// alert('window was closed');
    var sRequest = "/ctr/admin/membership/login.jsp?action=logout&type=windowclose";
    sRequest += "&time="+new Date().getTime();
    getUrlContent(sRequest);
  }
}

function getUrlContent(sUrl)
{
   var xmlhttp = getHttpObject();
   xmlhttp.open("GET", sUrl, false);
   xmlhttp.setRequestHeader("Accept-Charset","UTF-8");
   xmlhttp.send(null);
   strDoc = xmlhttp.responseText;
//alert("strDoc=" + strDoc);
   return strDoc;
}

function postUrlContent(sUrl, sRequest)
{
   var xmlhttp = getHttpObject();
   xmlhttp.open("Post", sUrl, false);
   xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
   xmlhttp.setRequestHeader("Content-length", sRequest.length);
   xmlhttp.setRequestHeader("Accept-Charset","UTF-8");
//   xmlhttp.setRequestHeader("Connection", "close");
   xmlhttp.send(sRequest);

   strDoc = xmlhttp.responseText;
//alert("strDoc=" + strDoc);
   return strDoc;
}

function getHttpObject()
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

function sendActionToServer(sUrl)
{
  var imageObject = new Image();
  imageObject.src = sUrl;
}

function showSendEmail(form, idhtml)
{
  $('#' + idhtml).toggle();
  setFocus(form.emailto);
  form.senditembutton.disabled = false;

  return false;
}

function submitSendEmail(form, ctr, idhtml)
{
  if (form.emailto.value.length==0)
  {
     alert("You have to enter at least one email address.");
     setFocus(form.emailto);
     return false;
  }

  if (!checkEmails(form.emailto.value))
  {
     setFocus(form.emailto);
     return false;
  }

  $('#' + idhtml).html("<p align='center'><img src='/staticfile/web/images/loading.gif' width='16' height='16' alt=''><font size=3 color='orange'> Please wait...</font> </p>");
  form.senditembutton.disabled = true;

  var sRequest = getFormQuery(form) + "&te="+new Date().getTime();
//alert("sRequest=" + sRequest);

  var sUrl = ctr + "/web/ajax/ajaxhandle.jsp?action=sendProductEmail";
  $.ajax({
        url: sUrl,
        type: 'post',
        data: sRequest,
        async: true,
        success: function (data) {
            var json = eval("("+data+")");
            $('#' + idhtml).html(json.message);
        }
  });

  return false;
}

function setFocus(objInput)
{
    objInput.focus();
    objInput.select();
}

var emailfilter=/^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i;
var emailfilter2=/^(.*?)<\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)>$/i;
function checkEmails(emails)
{
    var arEmail = emails.split(/[\s+,;\s+]/);
    for (var i=0; i<arEmail.length; i++)
    {
        var sEmail = trim(arEmail[i]);
        if (sEmail.length>0 && !(emailfilter.test(sEmail)||emailfilter2.test(sEmail)))
        {
           alert("'" + sEmail + "' you entered is an invalid email address.");
           return false;
        }
    }

    return true;
}

function getFormQuery(form)
{
    var sRequest = "";
    for(i=0; i<form.elements.length; i++)
    {
      var e = form.elements[i];
      if (e.type=='checkbox'||e.type=='radio')
      {
        if (e.checked)
           sRequest += '&' + e.name + '=' +  encodeURIComponent(e.value);
      }
      else
        sRequest += '&' + e.name + '=' +  encodeURIComponent(e.value);
   }

   return sRequest;
}


