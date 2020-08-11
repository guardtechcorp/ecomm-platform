<!--Copyright Info-->
<!--The contents of this file are copyrighted by ZYZ International Technology. -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function sendPageHit(sAction)
{
  if (sAction!=null&&sAction.length>0)
  {
    var sRequest = "/ctr/web/website.jsp?action=" + sAction;
//    var sRequest = "http://localhost:8082/web/website.jsp?action=" + sAction;
    sRequest += "&time="+new Date().getTime();
    var imageObject = new Image();
    imageObject.src = sRequest;
  }
}