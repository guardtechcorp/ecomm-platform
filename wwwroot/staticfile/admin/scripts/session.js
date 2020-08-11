<!--Copyright Info-->
<!--The contents of this file are copyrighted by ZYZ International Technology. -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

var nCountOfTimes = 0;
var nIdleInterval = 590*1000;
var g_IdleJspFile = "../share/idle.jsp";
function sendIdleFlag(nSeconds, sJspFile)
{
  if (sJspFile!=null)
     g_IdleJspFile = sJspFile;

  if (nCountOfTimes>0)
  {
    var sRequest = g_IdleJspFile + "?action=idle&count="+nCountOfTimes;
    sRequest += "&time="+new Date().getTime();
    sendActionToServer(sRequest);
  }

  if (nSeconds!=null)
     nIdleInterval = nSeconds*1000;
//alert("sendIdleFlag=" + nCountOfTimes+","+nSeconds);
  nCountOfTimes++;
  setTimeout('sendIdleFlag()', nIdleInterval);
}

function onWebPageLoad()
{
  var sRequest = "/ctr/web/index.jsp?action=webpageload";
//  sRequest += "&time="+new Date().getTime();
  sendActionToServer(sRequest);
}

function onBrowserClose(sJspFile)
{
  var top=self.screenTop;
//alert("top=" + top);
  if (top>9000)
  {// alert('window was closed');
    var sRequest = sJspFile +"?action=Logout&type=windowclose";
    sRequest += "&time="+new Date().getTime();
    var sResponse = getUrlContent(sRequest);
//??    sendActionToServer(sRequest);
  }
}

function onMemberLoad()
{
  if (nCountOfTimes>0)
  {
//    var sRequest = "/admin/membership/login.jsp?action=idle&count="+nCountOfTimes;
    var sRequest = "/admin/share/idle.jsp?action=Idle&count="+nCountOfTimes;
    sRequest += "&time="+new Date().getTime();
    sendActionToServer(sRequest);
  }

  nIdleInterval = 60*1000;
  nCountOfTimes++;
  setTimeout('onMemberLoad()', nIdleInterval);
}

function onMemberUnload()
{
  var top=self.screenTop;
//alert("top=" + top);
  if (top>9000)
  {// alert('window was closed');
//    var sRequest = "/admin/membership/login.jsp?action=logout&type=windowclose";
    var sRequest = "/admin/share/idle.jsp?action=Logout&type=windowclose";
    sRequest += "&time="+new Date().getTime();
    var sResponse = getUrlContent(sRequest);
//??    sendActionToServer(sRequest);
  }
}

/*
var cc_tagVersion = "1.0";
var cc_accountID = "6113440160";
var cc_marketID =  "0";
var cc_protocol="http";
var cc_subdomain = "convctr";
if(location.protocol == "https:")
{
    cc_protocol="https";
    cc_subdomain="convctrs";
}
var cc_queryStr = "?" + "ver=" + cc_tagVersion + "&aID=" + cc_accountID + "&mkt=" + cc_marketID +"&ref=" + escape(document.referrer);
var cc_imageUrl = cc_protocol + "://" + cc_subdomain + ".overture.com/images/cc/cc.gif" + cc_queryStr;
var cc_imageObject = new Image();
cc_imageObject.src = cc_imageUrl;
*/