<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->
function OnKeyDownEvent(evt)
{
    evt=event;
    var nChar = evt.keyCode;
    if (nChar==13)
    {
      sendMessage(g_objForm)
    }

    return 0;
}

function onRightClickEvent(evt)
{
  if (event.button == 2 || event.button == 3)
  {
     alert(getAlertMsg(33));
     return false;
  }

  return true;
}

document.onkeydown=OnKeyDownEvent;
if (document.layers) window.captureEvents(Event.KEYDOWN);
window.onkeydown=OnKeyDownEvent;

document.onmousedown=onRightClickEvent;
if (document.layers) window.captureEvents(Event.MOUSEDOWN);
window.onmousedown=onRightClickEvent;

function onLiveChatFormLoad(form)
{
//  alert("question=" + form.question);
   form.question.focus();
   form.question.select();
}

function validateLiveChat(form)
{
  if (checkFieldEmpty(form.question))
  {
     alert(getAlertMsg(34));
     form.question.focus();
     form.question.select();
     return false;
  }

  if (checkFieldEmpty(form.firstname))
  {
     alert(getAlertMsg(35));
     form.firstname.focus();
     form.firstname.select();
     return false;
  }

  if (checkFieldEmpty(form.lastname))
  {
     alert(getAlertMsg(36));
     form.lastname.focus();
     form.lastname.select();
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

  return true;
}

var g_objForm;
var g_RetrieveInerval = 2*1000;
var g_bActive = false;
var g_nLastLen = "0";

//var myclose = false;
function confirmClose()
{
  if (g_bActive && event.clientY < 0)
  {
    event.returnValue = 'And do you want to quit this chat session also?';
//    setTimeout('myclose=false',100);
//    myclose=true;
  }
}

function sendMessage(form)
{
  var sRequest = "form-livechat.jsp?action=Send Question&question=" + form.talkinput.value + getChaterInfo(form);
  refreshShowArea(getUrlContent(sRequest));
  form.talkinput.value="";
}

function retrieveMessage(form, nSeconds)
{
  if (form!=null)
  {
    g_objForm = form;
    if (nSeconds!=null)
       g_RetrieveInterval = nSeconds*1000;
    g_bActive = true;

    var sRequest = "form-livechat.jsp?action=Start Chat" + getChaterInfo(g_objForm);
    refreshShowArea(getUrlContent(sRequest));
    form.talkinput.focus();
  }
  else
  {
    if (g_bActive)
    {
       var sRequest = "form-livechat.jsp?action=Get Answer" + getChaterInfo(g_objForm);
       refreshShowArea(getUrlContent(sRequest));
    }
  }

  if (g_bActive)
     setTimeout('retrieveMessage()', g_RetrieveInterval);
}

function stopChat(form)
{
  if (form.endchat.value=="Close")
  {
    window.close();
    return;
  }

  if (!confirm('Are you sure you want to end this chat session?'))
     return false;

  stopTimer();
  g_bActive = false;
  var sRequest = "form-livechat.jsp?action=End Chat&type=Click Button" + getChaterInfo(form);
  refreshShowArea(getUrlContent(sRequest));
  form.sendmessage.disabled = "true";
  form.talkinput.disabled = "true";
  form.endchat.value = "Close";

  return true;
}

function endChat(form)
{
  if (g_bActive)
  {
    g_bActive = false;
    var sRequest = "form-livechat.jsp?action=End Chat&type=Close Window" + getChaterInfo(form);
    refreshShowArea(getUrlContent(sRequest));
    form.sendmessage.disabled = "true";
    form.talkinput.disabled = "true";
    form.endchat.value = "Close";
  }
}

function getChaterInfo(form)
{
  var sInfo = "&domainname="+form.domainname.value;
  sInfo += "&sid="+form.sid.value;
  sInfo += "&caseno="+form.caseno.value;
  sInfo += "&firstname="+form.firstname.value;
  sInfo += "&lastname="+form.lastname.value;
  sInfo += "&lastlen=" + g_nLastLen;
  sInfo += "&time="+new Date().getTime();

  return sInfo;
}

function refreshShowArea(sNewContent)
{
  if (sNewContent!=null&&sNewContent.length>0)
  {
//alert(sNewContent);
     var arContent = sNewContent.split("<!!>");
//updateChatWith("Jason Warren");
     var nType = arContent[1];
     if (nType=="1")
     {
       g_nLastLen = arContent[0];
//alert("|" + arContent[2] + "|");
       parent.frames["vFrame"].appendContent(arContent[2]);
       if (arContent[0]=="-1")
       {//. Disable the buttons because it is terminated
         g_bActive = false;
         g_objForm.sendmessage.disabled = "true";
         g_objForm.talkinput.disabled = "true";
         g_objForm.endchat.value = "Close";

         stopTimer();
       }
     }
     else if (nType=="2")
     {
       updateChatWith(arContent[2]);
     }
  }
}

function updateChatWith(sData)
{
  if (sData==null)
     sData = "";
  var arNames = sData.split(",");
  if (arNames.length>2)
  {//. Only list two names
    sData = arNames[0] + "," + arNames[1] + ", ...";
  }

  if (sData.length>0)
     startTimer(); //Try to start timer because some service person is start.

  if (document.all)
     document.all.chatwith.innerHTML = sData;
  else if (document.getElementById)
     document.getElementById("chatwith").innerHTML = sData;
}

var timerID = 0;
var tStart  = null;
var nHour   = 0;
function startTimer()
{
  if (tStart==null)
  {
    showTime("00:00:00");
    tStart   = new Date();
    timerID  = setTimeout("updateTimer()", 1000);
  }
}

function updateTimer()
{
   if (timerID!=0)
      clearTimeout(timerID);

   var  tDate = new Date();
   var  tDiff = tDate.getTime() - tStart.getTime();
   tDate.setTime(tDiff);

   var sData;
   if (nHour<10)
      sData = "0" + nHour + ":";
   else
      sData = nHour + ":";
   if (tDate.getMinutes()>=59 && tDate.getSeconds()>=59)
      nHour++;
   if (tDate.getMinutes()<10)
      sData += "0";
   sData += tDate.getMinutes() + ":";
   if (tDate.getSeconds()<10)
      sData += "0";
   sData += tDate.getSeconds();
   showTime(sData);

   timerID = setTimeout("updateTimer()", 1000);
}

function stopTimer()
{
  if(timerID!=0)
  {
     clearTimeout(timerID);
     timerID  = 0;
  }
  tStart = null;
}

function showTime(sData)
{
  if (document.all && document.all.chattime!=null)
     document.all.chattime.innerHTML = sData;
  else if (document.getElementById && document.getElementById("chattime")!=null)
     document.getElementById("chattime").innerHTML = sData;
}

/*
function printChat(form)
{
  parent.frames["vFrame"].focus();
//  parent.frames["vFrame"].printContent();
  window.print();
}
*/

function uploadFile()
{
//  alert("uploadFile");
}

function selectAllChat()
{
//  parent.frames["vFrame"].focus();
  parent.frames["vFrame"].selectAll();
}

function copyChat()
{
//  parent.frames["vFrame"].focus();
  parent.frames["vFrame"].copy();
  window.status=getAlertMsg(37);
}

function printChat()
{
  parent.frames["vFrame"].focus();
  window.print();
}
