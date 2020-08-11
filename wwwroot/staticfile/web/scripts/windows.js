<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function newWindow(mypage,myname,w,h,scroll,pos)
{
  if(pos=="random"){LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;}
  if(pos=="center"){LeftPosition=(screen.width)?(screen.width-w)/2:100;TopPosition=(screen.height)?(screen.height-h)/2:100;}
  else if((pos!="center" && pos!="random") || pos==null)
  {LeftPosition=0;TopPosition=0}

  settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=yes,menubar=no,toolbar=no,resizable=no';
//alert("mypage=" + mypage);
  var win = window.open(mypage,myname,settings);
  win.focus();
}

function centerWindow(width, height)
{
  var left1 = (screen.width) ? (screen.width-width)/2 : 0;
  var top1 = (screen.height) ? (screen.height-height)/2 : 0;

//alert("left=" + left + "," + top);
  moveWindow(left1, top1, width, height);
}

function moveWindow(left1, top1, width, height)
{
  window.moveTo(left1, top1);
  if (document.all) {
    window.resizeTo(width, height);
  }
  else if (document.layers||document.getElementById)
  {
    window.outerWidth = width;//screen.availWidth;
    window.outerHeight = height;//screen.availHeight
  }
}

function maxWindow(sUrl, sWinName)
{
//  newWindow(sUrl, sWinName, screen.availWidth,  screen.availHeight, 'no');
  var sSettings ='width='+screen.width+',height='+screen.height+',top='+0+',left='+0+',scrollbars=no,location=no,directories=no,status=yes,menubar=no,toolbar=no,resizable=no';
  var win = window.open(sUrl, sWinName, sSettings);
  win.moveTo(0,0);
  if (document.all) {
     win.resizeTo(screen.availWidth,screen.availHeight);
  }
  else if (document.layers||document.getElementById)
  {
    if (win.outerHeight<screen.availHeight||win.outerWidth<screen.availWidth)
    {
      win.outerHeight = screen.availHeight;
      win.outerWidth = screen.availWidth;
    }
  }
}

function maximizeWindow() {
 if (parseInt(navigator.appVersion)>3) {
  if (navigator.appName=="Netscape") {
   if (top.screenX>0 || top.screenY>0) top.moveTo(0,0);
   if (top.outerWidth < screen.availWidth)
      top.outerWidth=screen.availWidth;
   if (top.outerHeight < screen.availHeight)
      top.outerHeight=screen.availHeight;
  }
  else {
   top.moveTo(-4,-4);
   top.resizeTo(screen.availWidth+8,screen.availHeight+8);
  }
 }
}

function fullWin(sUrl, sWinName)
{
   window.open(sUrl, sWinName, "fullscreen,scrollbars");
}

function modelessWin(sUrl, nWidth, nHeight)
{
  var nScreenWidth=screen.width;
  var nScreenHeight=screen.height;
  var nLeft=(nScreenWidth-nWidth)/2;
  var nTop=(nScreenHeight-nHeight)/2;

//  if (document.all&&window.print) //if ie5
  if (navigator.appName.indexOf("Microsoft")!=-1)
  {
    nHeight+=20;
    var myObject = new Object();
    myObject.parentWin = self;   //Parent Window
    eval('window.showModelessDialog(sUrl, myObject, "help:0;resizable:1;dialogWidth:'+nWidth+'px;dialogHeight:'+nHeight+'px;resizable:no;status:no;scroll:yes;help:no;center:yes;")');
  }
  else
    window.open(sUrl, "Dialog Box", "dependent,innerHeight="+nHeight+",innerWidth="+nWidth+",height="+nHeight+",width="+nWidth+",resizable=no,menubar=no,location=no,personalbar=no,status=no,scrollbars=yes,toolbar=no,screenX="+nLeft+",screenY="+nTop);
}

function modalWin(sUrl, nWidth, nHeight)
{
  var nScreenWidth=screen.width;
  var nScreenHeight=screen.height;
  var nLeft=(nScreenWidth-nWidth)/2;
  var nTop=(nScreenHeight-nHeight)/2;
  if (navigator.appName.indexOf("Microsoft")!=-1)
  {
//      if (gbIE5)
        nHeight+=20;
//      else
//        nHeight+=40;
     var myObject = new Object();
     myObject.parentWin = self;   //Parent Window
//     myObject.firstName = aForm.oFirstName.value;
     window.showModalDialog(sUrl, myObject, "dialogHeight:"+nHeight+"px;dialogWidth:"+nWidth+"px;resizable:no;status:no;scroll:yes;help:no;center:yes;");
  }
  else
     window.open(sUrl, "Dialog Box", "dependent,innerHeight="+nHeight+",innerWidth="+nWidth+",height="+nHeight+",width="+nWidth+",resizable=no,menubar=no,location=no,personalbar=no,status=no,scrollbars=yes,toolbar=no,screenX="+nLeft+",screenY="+nTop);
}

function resizeIframe(framebody, frameid)
{
// if (self==parent)
//    return false;
//  parent.frames["vFrame"].document.body.style.height = FramePageHeight;
//<iframe src="/ctr/admin/domain/freetest.jsp" name="vFrame" id="vFrame" width="600" height="260" marginwidth="0" marginheight="0" frameborder="0" onload="resizeIframe(this, 'vFrame')"></iframe>
   var newheight;
   var newwidth;
   if (framebody==null && document.getElementById)
      framebody = document.getElementById(frameid);

    if (framebody!=null)
    {
      newheight = framebody.contentWindow.document.body.scrollHeight;
      newwidth  = framebody.contentWindow.document.body.scrollWidth;
      framebody.height= (newheight) + "px";
//   framebody.width= (newwidth) + "px";
    }
 }

function updateFrameHeight(frameid, height) 
{
  var iframe = document.getElementById(frameid);
  if (iframe!=null)
     iframe.setAttribute('height', height);
  else
  {
     alert("'" + frameid + "' is not the frame window.");
  }
}

function adjustChildFrameHeight(frameid) 
{
  var iframe = document.getElementById(frameid);
//alert( 'Try to Updating IFrame =' + iframe);
  if (iframe!=null)
  {
    var height = Math.max(iframe.contentWindow.document.body.offsetHeight, iframe.contentWindow.document.body.scrollHeight) + 20;
    iframe.setAttribute('height', height);
//iframe.style.height = height + "px";
  }
}

function tryadjustFrameHeight(frameid) 
{
    if (document.getElementById(frameid)!=null)
    {//   setTimeout( function() {adjustChildFrameHeight('vFrame'); }, 1000);
        document.getElementById(frameid).onload = function() { adjustChildFrameHeight(frameid); };
    }
}
/*
if (document.getElementById('vFrame')!=null)
{
//   setTimeout( function() {adjustChildFrameHeight('vFrame'); }, 1000);
   document.getElementById("vFrame").onload = function() { adjustChildFrameHeight('vFrame'); };
}
*/






