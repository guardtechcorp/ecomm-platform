<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

var TRange = null;
var dupeRange = null;
var TestRange = null;
var win = null;
var nom = navigator.appName.toLowerCase();
var agt = navigator.userAgent.toLowerCase();
var is_major   = parseInt(navigator.appVersion);
var is_minor   = parseFloat(navigator.appVersion);
var is_ie      = (agt.indexOf("msie") != -1);
var is_ie4up   = (is_ie && (is_major >= 4));
var is_not_moz = (agt.indexOf('netscape')!=-1)
var is_nav     = (nom.indexOf('netscape')!=-1);
var is_nav4    = (is_nav && (is_major == 4));
var is_mac     = (agt.indexOf("mac")!=-1);
var is_gecko   = (agt.indexOf('gecko') != -1);
var is_opera   = (agt.indexOf("opera") != -1);
//  GECKO REVISION
var is_rev=0
if (is_gecko) {
temp = agt.split("rv:")
is_rev = parseFloat(temp[1])
}
function search(sKeyword, whichframe)
{
//alert("sKeyword=" + sKeyword);
//  TEST FOR IE5 FOR MAC (NO DOCUMENTATION)
  if (is_ie4up && is_mac) return;
//  TEST FOR NAV 6 (NO DOCUMENTATION)
  if (is_gecko && (is_rev <1)) return;
//  TEST FOR Opera (NO DOCUMENTATION)
  if (is_opera) return;
//  INITIALIZATIONS FOR FIND-IN-PAGE SEARCHES
  if (sKeyword!=null && sKeyword!='')
  {
    str = sKeyword;//whichform.findthis.value;
    win = whichframe;
    var frameval=false;
/*
    if (win!=self)
    {
      frameval = true;  // this will enable Nav7 to search child frame
      win = parent.frames[whichframe];
    }
*/
  }
  else
    return;  //  i.e., no search string was entered

  var strFound;
//  NAVIGATOR 4 SPECIFIC CODE
  if(is_nav4 && (is_minor < 5))
  {
    strFound=win.find(str); // case insensitive, forward search by default
  }

//  NAVIGATOR 7 and Mozilla rev 1+ SPECIFIC CODE (WILL NOT WORK WITH NAVIGATOR 6)
  if (is_gecko && (is_rev >= 1))
  {
    if(frameval!=false) win.focus(); // force search in specified child frame
    strFound=win.find(str, false, false, true, false, frameval, false);
//    if (is_not_moz)
//	   whichform.findthis.focus();
  }

  if (is_ie4up)
      {// EXPLORER-SPECIFIC CODE revised 5/21/03
    if (TRange!=null)
    {
      TestRange=win.document.body.createTextRange();
      if (dupeRange.inRange(TestRange))
      {
        TRange.collapse(false);
        strFound=TRange.findText(str);
        if (strFound)
        {
          //the following line added by Mike and Susan Keenan, 7 June 2003
          win.document.body.scrollTop = win.document.body.scrollTop + TRange.offsetTop;
          TRange.select();
        }
      }
      else
      {
        TRange=win.document.body.createTextRange();
        TRange.collapse(false);
        strFound=TRange.findText(str);
        if (strFound)
            {//the following line added by Mike and Susan Keenan, 7 June 2003
          win.document.body.scrollTop = TRange.offsetTop;
          TRange.select();
        }
      }
    }

    if (TRange==null || strFound==0)
    {
      TRange=win.document.body.createTextRange();
      dupeRange = TRange.duplicate();
      strFound=TRange.findText(str);
      if (strFound)
          {//the following line added by Mike and Susan Keenan, 7 June 2003
        win.document.body.scrollTop = TRange.offsetTop;
        TRange.select();
      }
    }
  }

  if (!strFound)
    alert ("No match found.") // string not found}
}