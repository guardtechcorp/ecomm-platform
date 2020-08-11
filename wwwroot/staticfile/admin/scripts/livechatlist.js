<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->
var g_Div;
var g_RetrieveInerval = 2*1000;
var g_Guide = " ";
function onBodyLoad(nSeconds)
{
//alert("nSeconds=" + nSeconds);
  g_Div = document.createElement("div");
  document.body.appendChild(g_Div);

  setInterval("changeColor()", 1000)

  retrieveTable(nSeconds);
}

function changeColor()
{
  var i=0
  if (document.all)
  {
    while (eval("document.all.flashlink"+i)!=null)
    {
      flashColor(eval("document.all.flashlink"+i));
      i++;
    }
  }
  else if (document.getElementById)
  {
    while (document.getElementById("flashlink"+i)!=null){
    flashColor(document.getElementById("flashlink"+i));
    i++;
    }
  }
}

function flashColor(objFlash)
{
  var flashtype=document.getElementById? objFlash.getAttribute("flashtype")*1 : objFlash.flashtype*1
  var flashcolor=document.getElementById? objFlash.getAttribute("flashcolor") : objFlash.flashcolor
  if (flashtype==0)
  {
    if (objFlash.style.color!=flashcolor)
      objFlash.style.color=flashcolor
    else
      objFlash.style.color=''
  }
  else if (flashtype==1)
  {
    if (objFlash.style.backgroundColor!=flashcolor)
      objFlash.style.backgroundColor=flashcolor
    else
      objFlash.style.backgroundColor=''
  }
}

function retrieveTable(nSeconds)
{
  if (nSeconds!=null)
     g_RetrieveInterval = nSeconds*1000;

//alert("g_RetrieveInterval =" + g_RetrieveInterval);
  var sRequest = "livechatlist.jsp?action=Table List" + getExtraInfo();
  var sContent = getUrlContent(sRequest);
//alert("sContent=" + sContent);
  if (sContent!=null&&sContent.length>4)
  {
     var arContent = sContent.split("<!!>");
     g_Guide = arContent[0];
     g_Div.innerHTML = arContent[1];
  }

  setTimeout('retrieveTable()', g_RetrieveInterval);
}

function getExtraInfo()
{
  sInfo = "&guide=" + g_Guide;
  sInfo += "&time="+new Date().getTime();

  return sInfo;
}

/*
var flashlinks=new Array();
function changelinkcolor()
{
  for (i=0; i< flashlinks.length; i++)
  {
    var flashtype=document.getElementById? flashlinks[i].getAttribute("flashtype")*1 : flashlinks[i].flashtype*1
    var flashcolor=document.getElementById? flashlinks[i].getAttribute("flashcolor") : flashlinks[i].flashcolor
    if (flashtype==0)
    {
      if (flashlinks[i].style.color!=flashcolor)
        flashlinks[i].style.color=flashcolor
        else
          flashlinks[i].style.color=''
    }
    else if (flashtype==1)
    {
      if (flashlinks[i].style.backgroundColor!=flashcolor)
        flashlinks[i].style.backgroundColor=flashcolor
      else
        flashlinks[i].style.backgroundColor=''
    }
  }
}
function init()
{
  var i=0
  if (document.all)
  {
    while (eval("document.all.flashlink"+i)!=null)
    {
      flashlinks[i]= eval("document.all.flashlink"+i)
      i++
    }
  }
  else if (document.getElementById)
  {
    while (document.getElementById("flashlink"+i)!=null){
    flashlinks[i]= document.getElementById("flashlink"+i)
    i++
    }
  }

  setInterval("changelinkcolor()", 1000)
}
if (window.addEventListener)
  window.addEventListener("load", init, false)
else if (window.attachEvent)
  window.attachEvent("onload", init)
else if (document.all)
  window.onload=init
*/

