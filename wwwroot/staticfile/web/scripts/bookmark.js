<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

var g_arBookmarkObject = new Array();
var g_arBookmarkType = new Array();
var g_nBookmarkCount = 0;
var g_cHighlightColor = 'Yellow';//'#ffa500';

var g_eventX;
var g_eventY;
var g_objRange;
function checkAction(nType)
{
  var objRange = document.selection.createRange();
  var bUnmark = eraseBookmark(objRange);
  if (!bUnmark)
  {
     if (objRange.text.length>0)
         {
           makeBookmark(objRange, nType);
         }
         else
         {
           workOnTextNote(objRange);
     }
  }
}

function workOnTextNote(objRange)
{
   e = window.event;
   g_eventX = e.x;
   g_eventY = e.y;
   g_objRange = objRange;

   popWin('/staticfile/web/writenote.html', 335, 390);
 //  newWin('writenote.html', 330, 380);
}

function insertNote(sContent)
{
  var arContent = sContent.split("\r\n");
  sContent = "";
  for (var i=0; i<arContent.length; i++)
  {
     if (sContent.length>0)
        sContent += ' ';
    sContent += arContent[i];
  }
//   alert("sContetn=" + sContent);
   g_objRange.pasteHTML("<sub><font color=#0000ff size=3>" + sContent + "</font></sub>");
   var objRangeB = document.body.createTextRange();
//   objRangeB.moveToPoint(g_eventX, g_eventY);
   objRangeB.moveToPoint(0, g_eventY);
   var blnResult = objRangeB.findText(sContent);
   if (blnResult)
   {
//	 objRangeB.select();
//alert("Selction Text = " + objRangeB.text);
     g_arBookmarkType[g_nBookmarkCount] = 3;
     g_arBookmarkObject[g_nBookmarkCount++] = objRangeB;
   }
}

function eraseBookmark(objRange)
{
  try  {
        if (objRange.text.length<=0)
        {
           var e = window.event;
           objRange.moveToPoint(e.x, e.y);
        }

        for(var i=0; i<g_nBookmarkCount; i++)
        {
          if (g_arBookmarkObject[i])
          {
                 var objTmp = g_arBookmarkObject[i];
//if (objTmp.inRange(objRange))
//   alert("Selction check = " + objTmp.inRange(objRange));
                 if(objTmp.inRange(objRange))
                 {
//alert("Type = " + g_arBookmarkType[i]);
                        if (g_arBookmarkType[i]<=2)
                        {
                                if (g_arBookmarkType[i]==1)
                                   objTmp.execCommand('BackColor', false, '');
                                else
                                   objTmp.execCommand('StrikeThrough', true, null);
                                objTmp.execCommand('Unselect');
                        }
                        else //if (g_arBookmarkType[i]==3)
                        {
                                if (confirm('Do you want to delete it?'))
                                {
                                  objTmp.select;
                                  objTmp.pasteHTML('');
                                }
                                else
                                 return true;
                        }

                        g_arBookmarkObject[i] = null;
                        return true;
                 }
          }
        }
 } catch(e) {}

  return false;
}

function makeBookmark(objRange, nType)
{//function highlights selected text and saves a copy of bookmark
    if (nType==1)
    {
       objRange.expand('word');
       objRange.execCommand('BackColor', false, g_cHighlightColor);
    }
    else
    {
      objRange.expand('word');//sentence');
      objRange.execCommand('StrikeThrough', false, null);
    }
    objRange.execCommand('Unselect');

//alert(objRange.text + "," + objRange.offsetLeft+","+objRange.offsetTop);
    g_arBookmarkType[g_nBookmarkCount] = nType;
    g_arBookmarkObject[g_nBookmarkCount++] = objRange;
}

function getAllBookmark()
{
  var sBookmarks = "";
  for(var i=0; i<g_nBookmarkCount; i++)
  {
    if (g_arBookmarkObject[i])
    {
       var objRange = g_arBookmarkObject[i];
       if (sBookmarks.length>0)
           sBookmarks += "<|!>";

      sBookmarks += g_arBookmarkType[i];
      sBookmarks += "{|!}" + objRange.offsetLeft+","+objRange.offsetTop;
      sBookmarks += "{|!}" + objRange.text;
    }
  }

// alert(sBookmarks);
//  escape(artistName)
    return sBookmarks;
}

function restoreAllBookmark(sBookmark)
{
//  var sBookmark = "1{|!}561,188{|!}I am so grateful to God that I found this product after trying many different herbal remedies.";
//  sBookmark += "<|!>" + "3{|!}286,93{|!}This is a bookmark.";
//  sBookmark += "<|!>" + "2{|!}474,117{|!}I am very happy and I will continue taking Proteliv to gain further improvements.";
  if (sBookmark==null||sBookmark.length==0)
     return;

  var arBookmark = sBookmark.split("<|!>")
  for (var i=0; i<arBookmark.length; i++)
  {
     var arData = arBookmark[i].split("{|!}");
     var arCoordinate = arData[1].split(",");

     var nType = parseInt(arData[0]);
     var nX = parseInt(arCoordinate[0]);
     var nY = parseInt(arCoordinate[1]);

     restoreBookmark(nType, nX, nY, arData[2]);
  }
}

function restoreBookmark(nType, nX, nY, sText)
{//function highlights selected text and saves a copy of bookmark

   var objRange = document.body.createTextRange();
   if (nType==3)
   {
       objRange.moveToPoint(nX, nY);
       objRange.pasteHTML("<sub><font color=#0000ff size=3>" + sText + "</font></sub>");
//       sText = "[Note:" + sText + "]";
   }

   objRange.moveToPoint(nX, nY);
   var blnResult = objRange.findText(sText);
   if (blnResult)
   {
      if (nType==1)
      {
        objRange.execCommand('BackColor', false, g_cHighlightColor);
      }
      else if (nType==2)
      {
        objRange.execCommand('StrikeThrough', false, null);
      }
      else
      {
      }

      objRange.execCommand('Unselect');

      g_arBookmarkType[g_nBookmarkCount] = nType;
      g_arBookmarkObject[g_nBookmarkCount++] = objRange;

      return true;
   }
   else
     return false;
}

function popWin(sUrl, nWidth, nHeight)
{
  var nScreenWidth=screen.width;
  var nScreenHeight=screen.height;
  var nLeft=(nScreenWidth-nWidth)/2;
  var nTop=(nScreenHeight-nHeight)/2;

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