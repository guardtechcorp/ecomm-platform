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
     alert("Welcoem to use Live Chat Service.");
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
  var sRequest = "livechat.jsp?action=Send Answer&answer=" + form.talkinput.value + getChaterInfo(form);
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

    var sRequest = "livechat.jsp?action=Begin Chat" + getChaterInfo(g_objForm);
    refreshShowArea(getUrlContent(sRequest));
    form.talkinput.focus();

    startTimer();
  }
  else
  {
    if (g_bActive)
    {
       var sRequest = "livechat.jsp?action=Retrieve Question" + getChaterInfo(g_objForm);
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
     return false

  stopTimer();
  g_bActive = false;
  var sRequest = "livechat.jsp?action=Stop Chat" + getChaterInfo(form);
  refreshShowArea(getUrlContent(sRequest));
  form.sendmessage.disabled = "true";
  form.talkinput.disabled = "true";
  form.endchat.value = "Close";
}

function leaveChat(form)
{
  g_bActive = false;
  var sRequest = "livechat.jsp?action=Leave Chat" + getChaterInfo(form);
  refreshShowArea(getUrlContent(sRequest));

  form.sendmessage.disabled = "true";
  form.talkinput.disabled = "true";
  form.endchat.disabled = "true";
}

function getChaterInfo(form)
{
  var sInfo = "&domainname="+form.domainname.value;
  sInfo += "&caseno="+form.caseno.value;
  sInfo += "&talker="+form.talker.value;
  sInfo += "&sid="+form.sid.value;
  sInfo += "&lastlen=" + g_nLastLen;
  sInfo += "&time="+new Date().getTime();

  return sInfo;
}

function refreshShowArea(sNewContent)
{
  if (sNewContent!=null&&sNewContent.length>0)
  {
//alert("!!"+sNewContent+"||");
     var arContent = sNewContent.split("<!!>");
     g_nLastLen = arContent[0];
     var nType = arContent[1];
     parent.frames["vFrame"].appendContent(arContent[2]);
     if (arContent[0]=="-1")
     {//. Disable the buttons because it is terminated
        stopTimer();
        g_bActive = false;
        g_objForm.sendmessage.disabled = "true";
        g_objForm.talkinput.disabled = "true";
        g_objForm.endchat.value = "Close";
     }
  }
}

function showContent(sContent)
{
//  parent.frames["vFrame"].showContent(sContent);
   document.frames.vFrame.showContent(sContent);
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
  if (document.all)
     document.all.chattime.innerHTML = sData;
  else if (document.getElementById)
     document.getElementById("chattime").innerHTML = sData;
}

/*
function printChat2()
{
//  parent.frames[1].frames["vFrame"].printContent();
  parent.frames[1].frames["vFrame"].focus();
  parent.frames[1].frames["vFrame"].print();
//  window.print();
}
*/

//document.frames.editor_iframe.document.

function uploadFile()
{
//  alert("uploadFile");
}

function selectAllChat()
{
//  parent.frames["vFrame"].focus();
  document.frames.vFrame.selectAll();
}

function copyChat()
{
//  parent.frames["vFrame"].focus();
  document.frames.vFrame.copy();
  window.status="The chat contents highlighted was copied to clipboard."
}

function printChat()
{
  document.frames.vFrame.focus();
  window.print();
}

var timerID = 0;
var tStart  = null;
var nHour   = 0;
function startTimer()
{
  tStart   = new Date();
  showTime("00:00:00");
  timerID  = setTimeout("updateTimer()", 1000);
}

function updateTimer()
{
   if(timerID)
   {
      clearTimeout(timerID);
      clockID  = 0;
   }

   var   tDate = new Date();
   var   tDiff = tDate.getTime() - tStart.getTime();
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
 if(timerID)
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

function validateSetting(form)
{
  return true;
}