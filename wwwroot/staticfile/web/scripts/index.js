<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

NS4 = (document.layers) ? 1 : 0;
IE4 = (document.all) ? 1 : 0;
ver4 = (NS4 || IE4) ? 1 : 0;
if (ver4) {
  with (document) {
    write("<STYLE TYPE='text/css'>");
    if (NS4) {
      write(".parent {position:absolute; visibility:visible}");
      write(".child {position:absolute; visibility:visible}");
      write(".regular {position:absolute; visibility:visible}")
    } else {
        write(".child {display:none}")
    }
    write("</STYLE>");
  }
}

function getIndex(el)
{
  ind = null;
  for (i=0; i<document.layers.length; i++)
  {
    whichEl = document.layers[i];
    if (whichEl.id == el) {
      ind = i;
      break;
    }
  }
  return ind;
}

function arrange()
{
  nextY = document.layers[firstInd].pageY +document.layers[firstInd].document.height;
  for (i=firstInd+1; i<document.layers.length; i++) {
    whichEl = document.layers[i];
    if (whichEl.visibility != "hide") {
      whichEl.pageY = nextY;
      nextY += whichEl.document.height;
    }
  }
}

function initIt()
{
//  if (!ver4) return;
  if (NS4)
  {
    for (i=0; i<document.layers.length; i++) {
      whichEl = document.layers[i];
      if (whichEl.id.indexOf("Child") != -1) whichEl.visibility = "show";
    }
    arrange();
  }
  else
  {
    divColl = document.all.tags("DIV");
    for (i=0; i<divColl.length; i++) {
      whichEl = divColl[i];
      if (whichEl.className == "child") whichEl.style.display = "inline";
    }
  }
}

function expandIt(el)
{
//  if (!ver4) return;
  if (IE4||!NS4)
  {
    whichEl = eval(el + "Child");
    if (whichEl.style.display == "none")
    {
      whichEl.style.display = "block";
    }
    else
    {
      whichEl.style.display = "none";
    }
  } else {
    whichEl = eval("document." + el + "Child");
    if (whichEl.visibility == "hide") {
      whichEl.visibility = "show";
    } else {
      whichEl.visibility = "hide";
    }
    arrange();
  }
}

function getAlertMsg(nId)
{
  if (nId<g_arMsgList.length)
     return g_arMsgList[nId][0];
  else
     return "No mapping =" + nId;
}

function setShopCartID()
{
  var sShopCardID = getCookie("shopcartid");
//alert("CookID" + sShopCardID);
  if (!sShopCardID)
  {
     sShopCardID = getUniqueID();
     setCookie("shopcartid", sShopCardID);
  }

  return true;
}

function getCookie(name)
{
    var start = document.cookie.indexOf(name + "=");
    var len = start + name.length + 1;
    if ((start == -1) || ((!start) && (name != document.cookie.substring(0,name.length))))
       return null;
    var end = document.cookie.indexOf(";",len);
    if (end == -1)
       end = document.cookie.length;
    return unescape(document.cookie.substring(len,end));
}

function setCookie(name,value)
{
   document.cookie = name + "=" + escape(value) + ";expires=Thu, 01-Jan-2050 00:00:01 GMT";
}

function eraseCookie(name)
{
    makeCookie(name,"",-1);
}

function makeCookie(name,data,expireday)
{
  if (expireday) {
    var date = new Date();
    date.setTime(date.getTime()+(expireday*24*60*60*1000));
    var expires = ";expires="+date.toGMTString();
  }
  else expires = "";
  document.cookie = name+"="+data+expires+";path=/;";
}//function makeCookie("w3c_style", "title", 365)

function getUniqueID()
{
    var dt = "" + new Date().getTime();
    var sID = "";
    for (i=dt.length-1; i>dt.length-9; i--)
    {
        sID += dt.substring(i, i+1);
    }

    sID += '_';
    var num = "" + Math.random()*1000000;
    for (i=0; i<4; i++)
    {
       sID += num.substring(i, i+1);
    }

    return sID;
}

function checkFieldEmpty(objField)
{
  var sValue = trim(objField.value);
  return sValue.length==0;
}

function validateDigits(objField, nLen)
{
    if (objField.value.length==nLen)
    {
      reZip = new RegExp(/(^\d{5}$)|(^\d{5}-\d{4}$)/);
      if (!reZip.test(objField.value))
      {
         alert("Zip Code you entered is not valid, Please input it again.");
         objField.value = "";
         return false;
      }
      else
         return true;
    }

    return false;
}

function validateZIP(field)
{
  var valid = "0123456789-";
  var hyphencount = 0;

  if (field.length!=5 && field.length!=10) {
    alert("Please enter your 5 digit or 5 digit+4 zip code.");
    return false;
  }

  for (var i=0; i < field.length; i++) {
    temp = "" + field.substring(i, i+1);
    if (temp == "-") hyphencount++;
    if (valid.indexOf(temp) == "-1") {
      alert("Invalid characters in your zip code.  Please try again.");
      return false;
    }
    if ((hyphencount > 1) || ((field.length==10) && ""+field.charAt(5)!="-"))
    {
      alert("The hyphen character should be used with a properly formatted 5 digit+four zip code, like '12345-6789'.   Please try again.");
      return false;
   }
  }
  return true;
}

function checkEmail(email)
{
	var emailfilter=/^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i
	var returnval=emailfilter.test(email)
	if (returnval==false)
    {
	alert("Please enter a valid email address for "+email)
	}
	return returnval;
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
  strEmail = trim(strEmail);

   var at="@"
   var dot="."
   var lat=strEmail.indexOf(at)
   var lstr=strEmail.length
   var ldot=strEmail.indexOf(dot)

   if (strEmail.indexOf(at)==-1)
   {
       alert(getAlertMsg(0) + " -- " + strEmail);
      return false;
   }

   if (strEmail.indexOf(at)==-1 || strEmail.indexOf(at)==0 || strEmail.indexOf(at)==lstr)
   {
       alert(getAlertMsg(0) + " -- " + strEmail);
       return false;
   }

   if (strEmail.indexOf(dot)==-1 || strEmail.indexOf(dot)==0 || strEmail.indexOf(dot)==lstr)
   {
       alert(getAlertMsg(0)+ " -- " + strEmail);
       return false;
   }

   if (strEmail.indexOf(at,(lat+1))!=-1)
   {
       alert(g_arMsgList[0]+ " -- " + strEmail);
       return false;
   }

   if (strEmail.substring(lat-1,lat)==dot || strEmail.substring(lat+1,lat+2)==dot)
   {
       alert(getAlertMsg(0)+ " -- " + strEmail);
       return false;
   }

   if (strEmail.indexOf(dot,(lat+2))==-1)
   {
       alert(getAlertMsg(0)+ " -- " + strEmail);
       return false;
   }

   if (strEmail.indexOf(" ")!=-1)
   {
       alert(getAlertMsg(0)+ " -- " + strEmail);
       return false;
   }

   return true;
}

function setFocus(objInput)
{
    objInput.focus();
    objInput.select();
}

function createTableOpen(){
  document.write("<TABLE cellspacing='0' cellpadding='0' border='0' align='center'><TR><TD colspan='2' height='7' rowspan='2'><IMG height='7' src='/staticfile/web/images/corner1.gif' width='7'></TD><TD style='border-top: 1px solid #BBBBBB;'><IMG height='1' src='/staticfile/web/images/clearpixel.gif' width='1' border='0'></TD><TD colspan='2' height='7' rowspan='2'><IMG height='7' src='/staticfile/web/images/corner2.gif' width='7'></TD></TR><TR valign='top'><TD><IMG height='5' src='/staticfile/web/images/clearpixel.gif' width='1' border='0'></TD></TR><TR valign='top'><TD width='1' style='border-left: 1px solid #BBBBBB;'><IMG height='1' src='/staticfile/web/images/clearpixel.gif' width='1' border='0'></TD><TD width='5'><IMG height='1' src='/staticfile/web/images/clearpixel.gif' width='5' border='0'></TD><TD bgcolor='#FFFFFF' valign='top'>");
}
function createTableClose(){document.write("</TD><TD width='5'><IMG height='1' src='/staticfile/web/images/clearpixel.gif' width='5' border='0'></TD><TD width='1' style='border-right: 1px solid #BBBBBB;'><IMG height='1' src='/staticfile/web/images/clearpixel.gif' width='1' border='0'></TD></TR><TR valign='bottom'><TD colspan='2' height='7' rowspan='2'><IMG height='7' src='/staticfile/web/images/corner3.gif' width='7'></TD><TD style='border-bottom: 1px solid #BBBBBB;'><IMG height='1' src='/staticfile/web/images/clearpixel.gif' width='1' border='0'></TD><TD colspan='2' height='7' rowspan='2'><IMG height='7' src='/staticfile/web/images/corner4.gif' width='7'></TD></TR></TABLE>");}

function createLeftButton(){
  document.write("<TABLE border='0' cellspacing='0' cellpadding='0' height='22'><TR><TD width='10' height='22'align='left' valign='middle'><IMG src='/staticfile/web/images/btt_left.gif' width='10' height='22'></TD><TD bgcolor='#0C2E82' height='22' nowrap>");
}
function createRightButton(){
  document.write("</TD><TD width='10' align='left' valign='middle'><IMG src='/staticfile/web/images/btt_right.gif' width='10' height='22'></TD></TR></TABLE>");
}

/*
function writeDate(color)
{
  var d = new Date();
  var sWeeks = getAlertMsg(1);
  var weekday = sWeeks.split(",");//new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
  var sMonths = getAlertMsg(2);
  var monthname = sMonths.split(",");//new Array("January","February","March","April","May","June","July","August","September","October","November","December");

  document.write('<b><font size="1" face="Arial,Geneva,Sans Serif" color="#ffffff">');
//  document.write('<div class="seven"><b><font face="Arial,Geneva,Sans Serif" color="' + color + '">');
  document.write(weekday[d.getDay()] + ", ");
  document.write(monthname[d.getMonth()] + " ");
  document.write(d.getDate() + ", ");
  document.write(d.getFullYear());
  document.write('&nbsp;</font></b>');//</div>');
}
*/
function writeDate(color)
{
  var d = new Date();
  var weekday = getAlertMsg(1).split(",");//new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
  var monthname = getAlertMsg(2).split(",");//new Array("January","February","March","April","May","June","July","August","September","October","November","December");

  document.write('<b><font size="1" face="Arial,Geneva,Sans Serif" color="' + color +'">');
//  document.write('<div class="seven"><b><font face="Arial,Geneva,Sans Serif" color="' + color + '">');
  document.write(weekday[d.getDay()] + ", ");
  document.write(monthname[d.getMonth()] + " ");
  document.write(d.getDate() + ", ");
  document.write(d.getFullYear());
  document.write('&nbsp;</font></b>');//</div>');
}

function writeDataOnId(sId, sData)
{
  if (document.all)
  {
    if (eval("document.all." + sId)!=null)
       eval("document.all." + sId + ".innerHTML=" + sData);
  }
  else if (document.getElementById)
  {
    if (eval("document.getElementById('"+sId+"')")!=null)
       eval("document.getElementById('"+sId+"').innerHTML=" + sData);
  }
//  else
//    document.write(sData)
}

function showHide(method,section)
{
  if (eval("document.all."+section)!=null){if (method == "open" ){eval( section + ".style.display = 'inline'" );}else if (method == "close"){eval( section + ".style.display = 'none'" );}}
}

function toggleShow(name)
{
  if (eval("document.getElementById('"+name+"').style.display")=="none")
  {
     showHide("open", name);
  }
  else
  {
     showHide("close",name);
  }
}

function dump_props(obj, obj_name) {
   var result = "";
   for (var i in obj) {
      result += obj_name + "." + i + " = " + obj[i] + "<br>";
   }
   result += "<hr>";
   return result;
}

function checkDateFormat(strValue,strFormat)
{
  var msg = getAlertMsg(3)+strFormat;
  if (strValue.length != strFormat.length)
  {
    alert(msg);
    return false;
  }
  else
  {
    if (strFormat == "MM/DD/YYYY")
    {
      if (strValue.substr(2,1)!="/"||strValue.substr(5,1)!="/"||strValue.substr(0,2)>'12'||strValue.substr(3,2)>'31'||strValue.substr(6,4)>'3000'){
        alert(msg);return false;}
    }
    else if (strFormat == "MM/YYYY")
    {
      if (strValue.substr(2,1)!="/"||strValue.substr(0,2)>'12'||strValue.substr(3,4)>'3000')
      {
        alert(msg);
        return false;
      }
    }
  }
  return true;
}

function autoFormat(obj,type)
{
//Neil  if (event.keyCode!=8){
    var len = obj.value.length;
    var val = obj.value.charAt(len-1);
    var preVal = obj.value.charAt(len-2);
    var maxLen = obj.getAttribute("maxlength");

    if(type=="N"||type=="n") {
      if(!('0' <= val && val <= '9')) obj.value = obj.value.substr(0,len-1);
      if(len > maxLen) obj.value = obj.value.substr(0,len+1);
    }
    else if(type == "D") {
      if('0' <= val && val <= '9'){
        if(len == '1' && val > '1') obj.value = "0" + obj.value + "/";
        else if((len == '5' && preVal == '0' && val != '0') || (len == '2' && val < '3' && preVal != '0') || (len == '2' && preVal == '0' && val != '0') || (len == '5' && preVal < '3' && preVal > '0') || (len == '5' && val < '2' && preVal == '3')) obj.value = obj.value + "/";
        else if((len == '2' && val >= '3' && preVal == '1') || (len == '2' && preVal == '0') || (len == '5' && preVal == '0') || (len == '5' && val > '1' && preVal >= '3')) obj.value = obj.value.substr(0,len-1);
        else if(len == '4' && val > '3') obj.value = obj.value.substr(0,len-1) + "0" + val + "/";
      }
      else if( val == '/') {
        if(len == '2' && preVal == '1') obj.value = "0" + preVal + "/";
        else if(len == '1' && preVal == "") obj.value = "";
        else if((len == '2' && preVal == '0') || len == '4' || (len == '5' && preVal <= '3') || (len == '5' && preVal == '0') || (len < '11' && len >= '7')) obj.value = obj.value.substr(0,len-1);
      }
      else obj.value = obj.value.substr(0,len-1);
    }
    else if(type == 'd') {
      if('0' <= val && val <= '9'){
        if(len == '1' && val > '1') obj.value = "0" + obj.value + "/";
        else if((len == '2' && val < '3' && preVal != '0') || (len == '2' && preVal == '0' && val != '0')) obj.value = obj.value + "/";
        else if((len == '2' && preVal == '0') || (len == '2' && val >= '3' && preVal == '1')) obj.value = obj.value.substr(0,len-1);
      }
      else if( val == '/') {
        if(len == '2' && preVal == '1') obj.value = "0" + preVal + "/";
        else if(len == '1' && preVal == "") obj.value = "";
        else if((len == '2' && preVal == '0') || len == '4' || (len == '5' && preVal <= '3') || (len == '5' && preVal == '0') || (len < '8' && len >= '4')) obj.value = obj.value.substr(0,len-1);
      }
      else obj.value = obj.value.substr(0,len-1);
    }
    else if(type=='F') {
      if(!(('0' <= val && val <= '9') || val == '.'))
        obj.value = obj.value.substr(0,len-1);
    }
    else if(type == "S") { //for String it could be anything
            if(!((val >= 'a' && val <= 'z') || (val >= 'A' && val <='Z') || ('0' <= val && val <= '9') || (val == ' ') || (val == '-')))
                    obj.value = obj.value.substr(0,len-1);
            if(len > maxLen) obj.value = obj.value.substr(0,len+1);
    }
//  }
}

function validateGoSearch(form)
{
  //1. check the product name
  if (checkFieldEmpty(form.productname))
  {
     alert(getAlertMsg(4));
     setFocus(form.productname);
     return false;
  }
  else
    return true;
}

function validateAdvancedSearch(form)
{
  //. check Category
  var bRet = false;
  if (form.category.selectedIndex>0)
  {
     bRet = true;
  }
  //. check sub-category
  if (form.subcategory.selectedIndex>0)
  {
     bRet = true;
  }
  //. check the price from
  if (!checkFieldEmpty(form.price_from))
  {
     bRet = true;
  }
  //. check price to
  if (!checkFieldEmpty(form.price_to))
  {
     bRet = true;
  }
  //. check product name
  if (!checkFieldEmpty(form.name))
  {
     bRet = true;
  }

  if (bRet)
     return true;

  alert(getAlertMsg(5));
  form.category.focus();
  return false;
}

function validateJumpPage(form, nMinPageNo, nMaxPageNo)
{
  if (checkFieldEmpty(form.page))
  {
     alert("You have to enter a number between " + nMinPageNo + " and " + nMaxPageNo);
     setFocus(form.page);
     return false;
  }

  if (form.page.value<nMinPageNo || form.page.value>nMaxPageNo)
  {
     alert("The number you enter should be between " + nMinPageNo + " and " + nMaxPageNo);
     setFocus(form.page);
     return false;
  }

  return true;
}

function OnLogonLoad(form)
{
  var sEmail = getCookie('account_email');
  if (sEmail==null||sEmail.length==0)
     setFocus(form.email);
  else
  {
     form.email.value = sEmail;
     setFocus(form.password);
  }
}

function validateLogon(form, value)
{
  //1. check the email
  if (checkFieldEmpty(form.email))
  {
     alert(getAlertMsg(6));
     setFocus(form.email);
     return false;
  }

  if (!validateEmail(form.email))
     return false;

  if (checkFieldEmpty(form.password))
  {
     alert(getAlertMsg(7));
     setFocus(form.password);
     return false;
  }

  setAction(form, value);

  setCookie('account_email', form.email.value);

  return true;
}

function setAction(form, value)
{
  form.action1.value = value;
}

function validateCheckOut(form, value, membercondvalue)
{
  if (!validateMemberCondition(membercondvalue))
     return false;

  setAction(form, value);
  return true;
}

function validateMemberCondition(membercondvalue)
{
  if (membercondvalue.length>0)
  {
    alert("Your order have to be more than " + membercondvalue + ". Then you will get the discount member price.");
    return false;
  }
  else
  {
    return true;
  }
}

function validateMemberLogon(form, value)
{
  //1. check the email
  if (checkFieldEmpty(form.email))
  {
     alert(getAlertMsg(6));
     setFocus(form.email);
     return false;
  }

  if (!validateEmail(form.email))
     return false;

  if (checkFieldEmpty(form.password))
  {
     alert(getAlertMsg(7));
     setFocus(form.password);
     return false;
  }

  setAction(form, value);

  return true;
}

//. For forgot account
function hasEmailAccount(form)
{
  if (checkFieldEmpty(form.email))
  {
     alert(getAlertMsg(6));
     setFocus(form.email);
     return false;
  }

  if (!validateEmail(form.email))
     return false;
  else
     return true;
}

function submitForgotPassword(form)
{
   form.action1.value = "forgotpassword";
//alert("submit=" +   form.action.value);
   form.submit();
}

function validatePayByCreditCard(form1, form2, membercondvalue)
{
  if (!validateMemberCondition(membercondvalue))
     return false;

  assignCustomField(form1, form2);
  return true;
}

function submitOrderProcess(form)
{
  form.submit();
//  return onlyonce();
}

function validatePayPal(form1, form2, membercondvalue)
{
  if (!validateMemberCondition(membercondvalue))
     return false;

//  if (!confirmOrder())
//     return false;
//  form2.amount.value = "0.01";
  assignCustomField(form1, form2);

  return onlyonce();
//  return true;
}

function validateiTransact(form1, form2, membercondvalue)
{
  if (!validateMemberCondition(membercondvalue))
     return false;

  assignCustomField(form1, form2);
  return onlyonce();
}

function validatePayCheck(form1, form2, membercondvalue)
{
  if (!validateMemberCondition(membercondvalue))
     return false;

  if (!confirm(getAlertMsg(28)))
     return false;

  assignCustomField(form1, form2);
  return onlyonce();
}

function validateMonthlyCharge(form1, form2, membercondvalue)
{
  if (!validateMemberCondition(membercondvalue))
     return false;

  if (!confirm(getAlertMsg(44)))
     return false;

  assignCustomField(form1, form2);

  return onlyonce();
}

function assignCustomField(form1, form2)
{
  form2.custom.value = form1.comment.value;
  if (form1.recursive_order!=null && form1.recursive_order.selectedIndex>0)
  {
    if (form2.custom.value.length>0)
       form2.custom.value +="<br>"
    form2.custom.value += "<b>"+ form1.recursive_order.options[form1.recursive_order.selectedIndex].text+".</b>";
    if (form1.recusive_date.value.length>0)
    {
      form2.custom.value += "<br><b>Order started in " + form1.recusive_date.value + " and ship orders every " + form1.recursive_days.options[form1.recursive_days.selectedIndex].text + " days.</b>";
    }

  }
//  alert("form2.custom.value=" + form2.custom.value);
}

function confirmOrder()
{
   if (confirm(getAlertMsg(29)))
      return onlyonce();
   else
      return false;
}

numberoftimes = 0;
function onlyonce()
{
   numberoftimes += 1;
   if (numberoftimes > 1)
   {
     var themessage = getAlertMsg(30);
     if (numberoftimes == 3)
     {
        themessage = getAlertMsg(31);
     }
     alert(themessage);
     return false;
   }
   else
   {
      return true;
   }
}

function onlyonce2()
{
   numberoftimes += 1;
   if (numberoftimes > 1)
   {
     return false;
   }
   else
   {
      return true;
   }
}

//style="filter:alpha(opacity=20);-moz-opacity:0.2" onMouseover="makevisible(this,0)" onMouseout="makevisible(this,1)"
function makevisible(cur,which)
{
  strength=(which==0)? 1 : 0.7
  if (cur.style.MozOpacity)
    cur.style.MozOpacity=strength;
  else if (cur.filters)
    cur.filters.alpha.opacity=strength*100;
}

//class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')"
function borderit(which,color)
{//if IE 4+ or NS 6+
  if (document.all||document.getElementById)
     which.style.borderColor=color
}

var w3c=(document.getElementById)?true:false;
var ie=(document.all)?true:false;
var N=-1;
function createBar(w,h,bgc,brdW,brdC,blkC,speed,blocks,count,action)
{
    if(ie||w3c){
    var t='<div id="_xpbar'+(++N)+'" style="visibility:visible; position:relative; overflow:hidden; width:'+w+'px; height:'+h+'px; background-color:'+bgc+'; border-color:'+brdC+'; border-width:'+brdW+'px; border-style:solid; font-size:1px;">';
    t+='<span id="blocks'+N+'" style="left:-'+(h*2+1)+'px; position:absolute; font-size:1px">';
    for(i=0;i<blocks;i++){
            t+='<span style="background-color:'+blkC+'; left:-'+((h*i)+i)+'px; font-size:1px; position:absolute; width:'+h+'px; height:'+h+'px; '
            t+=(ie)?'filter:alpha(opacity='+(100-i*(100/blocks))+')':'-Moz-opacity:'+((100-i*(100/blocks))/100);
            t+='"></span>';
    }
    t+='</span></div>';
    document.write(t);
    var bA=(ie)?document.all['blocks'+N]:document.getElementById('blocks'+N);
    bA.bar=(ie)?document.all['_xpbar'+N]:document.getElementById('_xpbar'+N);
    bA.blocks=blocks; bA.N=N; bA.w=w; bA.h=h; bA.speed=speed; bA.ctr=0; bA.count=count;
    bA.action=action;
    bA.showBar=function(){this.bar.style.visibility="visible";}
    bA.hideBar=function(){this.bar.style.visibility="hidden";}
    bA.tid=setInterval('startBar('+N+')',speed);
    return bA;
    }
}

function startBar(bn)
{
  var t=(ie)?document.all['blocks'+bn]:document.getElementById('blocks'+bn);
  if(parseInt(t.style.left)+t.h+1-(t.blocks*t.h+t.blocks)>t.w){
    t.style.left=-(t.h*2+1)+'px'; t.ctr++;
    if(t.ctr>=t.count){eval(t.action);t.ctr=0;}
  }else t.style.left=(parseInt(t.style.left)+t.h+1)+'px';
}

function validEmail2(email) {				// Chedck email address
    invalidChars = " /\|?><:,;[]{}+=)(*&%$#!"

    if (email == "") {						// cannot be empty
            return false;
    }
     for (i=0; i<invalidChars.length; i++) {// does it contain any invalid characters?
            badChar = invalidChars.charAt(i)
            if (email.indexOf(badChar,0) > -1) {
                    return false;
            }
    }
    atPos = email.indexOf("@",1)			// there must be one "@" symbol
    if (atPos == -1) {
            return false;
    }
    if (email.indexOf("@",atPos+1) != -1) {	// and only one "@" symbol
            return false;
    }
    periodPos = email.indexOf(".",atPos)
    if (periodPos == -1) {					// and at least one "." after the "@"
            return false;
    }
    if (periodPos+3 > email.length)	{		// must be at least 2 characters after the "."
            return false;
    }
    return true
}

function addjustmentDecimal(strTemp)
{
  var nPos = strTemp.indexOf('.', 0);
  if (nPos>=0 && strTemp.length-nPos>2)
     return strTemp.substring(0, nPos+3);
  else
     return strTemp;
}

function showHideSpan(method, section)
{
//  if (eval("document.all."+section)!=null){if (method=="open" ){eval(section + ".style.display='inline'" );}else if (method=="close"){eval(section + ".style.display='none'" );}}
  if (eval("document.getElementById('"+section+"')")!=null)
    {if (method=="open" ){eval("document.getElementById('"+section+"').style.display='inline'" );}else if (method=="close"){eval("document.getElementById('"+section+"').style.display='none'");}}
}

function goToLinkPage(sUrl)
{
  window.location.href = sUrl;
}

var g_ElementClassName = null;
function selrow (element, i)
{
  if (i==0){
//   if ("highlight_row"!=element.className)

     g_ElementClassName = element.className;
     element.className='highlight2_row';//mousein';
  }
  else if (i==1)
  {
//     if ("highlight_row"!=element.className)
      if (g_ElementClassName!=null)
         element.className = g_ElementClassName;
      else
         element.className= 'normal_row';//'mouseout';
  }
  else if ((i==2)){
     element.className='mousechecked';
  }
}

function highlightCheckedRow(objCheckBox)
{
  if (objCheckBox.checked)
     objCheckBox.parentNode.parentNode.className="highlight_row";
  else
     objCheckBox.parentNode.parentNode.className="normal_row";
//  g_ElementClassName = objCheckBox.parentNode.parentNode.className;
}

function updateMaxRows(objSelect, sJspFile, sAction)
{
  if (sJspFile.indexOf("?")==-1)
     window.location.href = sJspFile + "?action=" + sAction + "&maxrows=" + objSelect.options[objSelect.selectedIndex].value;
  else
     window.location.href = sJspFile + "&action=" + sAction + "&maxrows=" + objSelect.options[objSelect.selectedIndex].value;
}

function updateMaxRows2(objSelect, sJspFile)
{
  window.location.href = sJspFile + "&maxrows=" + objSelect.options[objSelect.selectedIndex].value;
}

function sortByField(objSelect, sJspFile)
{
  var arSort = objSelect.options[objSelect.selectedIndex].value.split(" ");
  window.location.href = sJspFile + "&sort=" + arSort[0] + "&asc=" + arSort[1];
}

function checkImageFileType(objFile, allEmpty)
{
    var sFile = objFile.value;
    if (sFile.length>0)
    {
      if (sFile.toLowerCase().indexOf(".gif")!=-1||sFile.toLowerCase().indexOf(".jpg")!=-1||sFile.toLowerCase().indexOf(".jpeg")!=-1)//||sFile.toLowerCase().indexOf(".pdf")!=-1)
        return true
      else
      {
        alert("The selected file is not a image file. The browser only can support gif, jpg, jpeg, jpe and png file.");
        return false;
      }
    }
    else
      return allEmpty;
}

function checkUploadFileType(objFile, sFileType)
{ //sFiletype="png|gif|jpe|jpg|jpeg"
   try {

    if (sFileType==null || sFileType.length==0 || sFileType=="*")
       return true;

    var sFilename = objFile.value.toLowerCase();
    var arFileType = sFileType.split("|");
    var sDesc = "";
    for (var i=0; i<arFileType.length; i++)
    {
       if (sFilename.indexOf("." + arFileType[i])!=-1)
          return true;

       if (sDesc.length>0)
       {
         if (i<sDesc-1)
            sDesc += ", ";
         else
            sDesc += " or ";
       }

       sDesc += "." + arFileType[i];
    }

    alert("The file you will be uploaded is not allowed, because only file name with extension (" + sDesc + ") can be uploaded.");

    return false;
   }
   catch (ex)
   {
     showException(ex, "checkUploadFileType()");
     return false;
   }
}


function getMultipleOptionIds(objSelect, sSeparator)
{
  var sIds = "";
  for(i=0; i<objSelect.length; i++)
  {
     if (objSelect.options[i].selected)
     {
        if (sIds.length>0)
           sIds += sSeparator;
        sIds += objSelect.options[i].value;
     }
  }

//alert("Vallues =" + sIds);    
  return sIds;
}

function getMultipleOptionSelectCount(objSelect)
{
  var nCount = 0;
  for(i=0; i<objSelect.length; i++)
  {
     if (objSelect.options[i].selected)
       nCount++;
  }

  return nCount;
}

function getMultipleCheckboxIds(form, prefix, sSeparator)
{
  var sIds = "";
  for(i=0; i<form.elements.length; i++)
  {
    var e = form.elements[i];
    if (e.type=='checkbox' && e.checked)
    {
       if (prefix==null || e.name.indexOf(prefix)==0)
       {
         if (sIds.length>0)
            sIds += sSeparator;
         sIds += e.value;
       }
    }
  }

//alert("Vallues =" + sIds);
  return sIds;
}

function getMultipleCheckboxValue(form, prefix)
{
  var nValue = 0;
  for(i=0; i<form.elements.length; i++)
  {
    var e = form.elements[i];
    if (e.type=='checkbox' && e.checked)
    {
       if (prefix==null || e.name.indexOf(prefix)==0)
       {
         nValue |= parseInt(e.value);
       }
    }
  }

  return nValue;
}

function getMultipleCheckboxCount(form, prefix)
{
    var nCount = 0;
    for(i=0; i<form.elements.length; i++)
    {
      var e = form.elements[i];
      if (e.type=='checkbox' && e.checked)
      {
         if (prefix==null || e.name.indexOf(prefix)==0)
            nCount++;
      }
    }

    return nCount;
}

function setCheckboxes(form, prefix, sValues)
{
  if (sValues==null || sValues.length==0)
     return;

  var arValue = sValues.split(",");
  for (var i=0; i<arValue.length; i++)
  {
      if (arValue[i].length>0)
      {
         var e = eval("form." + prefix + arValue[i]);
//alert("check box" + e);
         if (e!=null && e.type=="checkbox")
            e.checked = true;
      }
  }
}

function setCheckboxesByBits(form, prefix, flag)
{
    for(i=0; i<form.elements.length; i++)
    {
      var e = form.elements[i];
      if (e.type=='checkbox')
      {
         if (prefix==null || e.name.indexOf(prefix)==0)
         {
//alert(e.name + "=" + e.value);
            if ((e.value&flag)==e.value)
               e.checked = true;
         }
      }
    }
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

var g_objInput;
function loadSelectColor(objInput, nType)
{
  g_objInput = objInput;

  var popW = 215, popH = 165;
  var currentColor = objInput.value;

  if (nType==1)
     modalWin('/staticfile/admin/popup/select-color.html?color=' + currentColor + '&command=Select Color', popW, popH);
  else
  {
     dhtmlmodal.open('SelectColor', 'iframe', '/staticfile/admin/popup/select-fullcolor-mask.html?color=' + currentColor.substring(1) + '&command=Select Color', 'Select Color', 'width=255px,height=365px,center=1,resize=1,scrolling=1', 'recal');
  }
}

function setSelectColor(sColor)
{
  if (sColor=="#FFFFFF")
     g_objInput.style.color = "#000000";
  else
     g_objInput.style.color = sColor;
  g_objInput.value = sColor;
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

function resetInput(name, default_txt)
{
    if (name.value == "") {
        name.value = default_txt;
    }
}

function clearInput(name, default_txt)
{
	if (name.value == default_txt)
		name.value = "";
}

function showProcessBar()
{
//  showHideSpan('close','MainPageArea'); showHideSpan('open','HideProcessing');
//   agewindow=dhtmlmodal.open('processbox', 'div', 'Processing', 'Process Status', 'width=600px,height=400px,center=1,resize=0,scrolling=0', 'recal', false);
    doProcess('MaskProcessing', 'MainPageTable');
}

function pageWidth() {
//  return window.innerWidth != null ? window.innerWidth : document.documentElement && document.documentElement.clientWidth ? document.documentElement.clientWidth : document.body != null ? document.body.clientWidth : null;
  return Math.max( document.body.offsetWidth, document.body.scrollWidth ) + 20;
}

function pageHeight() {
//  return window.innerHeight != null? window.innerHeight : document.documentElement && document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body != null? document.body.clientHeight : null;
  return Math.max( document.body.offsetHeight, document.body.scrollHeight ) + 20;
}

function topPosition() {
  return typeof window.pageYOffset != 'undefined' ? window.pageYOffset : document.documentElement && document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop ? document.body.scrollTop : 0;
}

function leftPosition() {
  return typeof window.pageXOffset != 'undefined' ? window.pageXOffset : document.documentElement && document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft ? document.body.scrollLeft : 0;
}

function getLinkOffset(what, offsettype)
{
    var totaloffset=(offsettype=="left")? what.offsetLeft : what.offsetTop;
    var parentEl=what.offsetParent;
    while (parentEl!=null){
        totaloffset=(offsettype=="left")? totaloffset+parentEl.offsetLeft : totaloffset+parentEl.offsetTop;
        parentEl=parentEl.offsetParent;
    }
    return totaloffset;
}

function showImageFile(sWinName, sTitle, sUrl, nWidth, nHeight)
{
// alert("sUrl=" + sUrl);    
  try {
    if (nWidth>800)
       nWidth = 800;
    if (nHeight>560)
       nHeight = 560;
    var sAttributes = 'width=' + nWidth + 'px,height=' + nHeight + 'px,center=1,resize=0,scrolling=0';
    dhtmlmodal.open(sWinName, 'IFRAME', sUrl, sTitle, sAttributes);
  }
  catch (ex)
  {
    showException(ex, "showImageFile()");
  }
}

function showRegularFile(sWinName, sTitle, sUrl)
{
  try {
    var sAttributes = 'width=' + 800 + 'px,height=' + 560 + 'px,center=1,resize=1,scrolling=1';
    dhtmlmodal.open(sWinName, 'IFRAME', sUrl, sTitle, sAttributes);
  }
  catch (ex)
  {
    showException(ex, "showRegularFile()");
  }
}

var g_modalwin = null;
var g_bConfirm = false;
function openModalWin(sTitle, sUrl, nWidth, nHeight, bConfirm)
{
  try {

    if (bConfirm!=null)
       g_bConfirm = bConfirm;
    var sAttributes = 'width=' + nWidth + 'px,height=' + nHeight + 'px,center=1,resize=1,scrolling=1';
    g_modalwin = dhtmlmodal.open("WindUrl", 'IFRAME', sUrl, sTitle, sAttributes);
    g_modalwin.onclose=function()
    {
      var bRet = true;
      if (g_bConfirm)
         bRet = confirm("You are about to close this window. Are you sure?");
      return bRet;
    }
  }
  catch (ex)
  {
    showException(ex, "openModalWin()");
  }
}

function closeModalWin()
{
  if (parent.g_modalwin!=null)
     parent.g_modalwin.hide();   //close();
}

function initModalWin()
{
    try{
        if (getQueryValue("closewin")=="yes"){
            if (null!=self.opener)
              window.close();
            else
              closeModalWin();
        }
//alert("nameurl=" + document.forms['Share'].nameurl.value);
    }
    catch (ex)
    {
      showException(ex, "initModalWin()");
    }
}

function getQueryValue(variable)
{
   return getUrlFieldValue(window.location.search, variable);
}

function getUrlFieldValue(query, variable)
{
	try {
        if (query.length>0 && query.substring(0,1)=='?')
           query = query.substring(1);            
		var vars = query.split("&");
		for (var i=0;i<vars.length;i++) {
			var pair = vars[i].split("=");
			if (pair[0] == variable) {
				var sVal = pair[1];
				sVal = sVal.replace(/\+/gi," ");
				return unescape(sVal);
			}
		}
	}
    catch(ex)
    {
      showException(ex, "getUrlFieldValue()");
    }

    return null;
}

function showDownloadFile(sWinName, sTitle, sUrl)
{
  try {
    var sAttributes = 'width=' + 500 + 'px,height=' + 400 + 'px,center=1,resize=0,scrolling=0';
    dhtmlmodal.open(sWinName, 'IFRAME', sUrl, sTitle, sAttributes);
  }
  catch (ex)
  {
    showException(ex, "showDownloadFile()");
  }
}

function showException(ex, sFunctionName)
{
  alert("An exception occurred in the functon: " + sFunctionName + "\nError name: " + ex.name + "\nError message: " + ex.message);
}


function viewSampleImage(type, value)
{
  var url = "../../admin/util/displayimage.jsp?type=" + type + "&value=" + value;
//alert("url = " + url);
  var newWin = window.open(url,"imagewin",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=630,height=610');
}

function getValueByElementId(sIdName)
{
   if (document.getElementById(sIdName)!=null)
   {
       if (document.all)
       {
         return document.getElementById(sIdName).innerText;
       }
       else
       {
         return document.getElementById(sIdName).textContent;
       }
   }

   return "";
}

function setValueByElementId(sIdName, sValue)
{
   if (document.getElementById(sIdName)!=null)
   {
       if (document.all)
       {
         document.getElementById(sIdName).innerText = sValue;
       }
       else
       {
         document.getElementById(sIdName).textContent = sValue;
       }
   }
}

function setHtmlValueByElementId(sIdName, sHtmlValue)
{
   if (document.getElementById(sIdName)!=null)
   {
     document.getElementById(sIdName).innerHTML = sHtmlValue;
   }
}

function initFormDefaultText(sIdValue, sClassName)
{
   g_arIdValue = sIdValue.split("|");
   g_sClassName = sClassName;
   for (var i=0; i<g_arIdValue.length; i++)
   {
       var arField = g_arIdValue[i].split(":");
       setupDefaultText(arField[0], arField[1]);
   }
}

function setupDefaultText(sId, sValue)
{
   var objInput = document.getElementById(sId);
   objInput.value = sValue;
   objInput.className = g_sClassName;
/*
   objInput.focus = function() {
        onInputFocus(sId);
	};

   objInput.blur = function() {
       onInputBlur(sId);
	};
*/
}

function getDefaultText(sId)
{
  for (var i=0; i<g_arIdValue.length; i++)
  {
     var arField = g_arIdValue[i].split(":");
	 if (arField[0]==sId)
	 {
	    return arField[1];
	 }
  }

  return null;
}

function onInputFocus(objInput)
{
// alert("id=" + getDefaultText(objInput.id));
   if (objInput.value==getDefaultText(objInput.id))//objInput.attributes['hinttext'].value)
   {
      objInput.value = '';
      objInput.className = '';
   }
}

function onInputBlur(objInput)
{
   if (objInput.value.length==0)
   {
      objInput.value = getDefaultText(objInput.id);//objInput.attributes['hinttext'].value;
      objInput.className = g_sClassName;
   }
}

var g_requestSubmittedOnce = false;
function submitOnce()
{
    if (!g_requestSubmittedOnce)
    {
       g_requestSubmittedOnce = true;
       return true;
    }
    else
    {
//      alert("submit Once!");
      return false;
    }
}

function validDomainName(sDomainName)
{
   var tomatch = /^([a-z][a-z0-9\-]+(\.|\-*\.))+[a-z]{2,6}$/;
   return tomatch.test(trim(sDomainName));
}

function validIPAddress(sIp)
{
//   var tomatch = /^(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]){3}$/;
//   return tomatch.test(trim(sIp));

    var re = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
    if (re.test(trim(sIp))) {
      var parts = trim(sIp).split(".");
      if (parseInt(parseFloat(parts[0])) == 0) { return false; }
      for (var i=0; i<parts.length; i++) {
        if (parseInt(parseFloat(parts[i])) > 255) { return false; }
      }
      return true;
    } else {
      return false;
    }
}

function trim(sValue)
{
  return sValue.replace(/^\s+|\s+$/g,"");
}
function ltrim(sValue)
{
  return sValue.replace(/^\s+/,"");
}
function rtrim(sValue)
{
  return sValue.replace(/\s+$/,"");
}

var g_arValidateList = new Array();
g_arValidateList[0] = /^\d+$/; //Positive Integers
g_arValidateList[1] = /^-\d+$/; //Nagative Integers
g_arValidateList[2] = /^-{0,1}\d+$/;//Integer
g_arValidateList[3] = /^\d*\.{0,1}\d+$/;//Positive Number
g_arValidateList[4] = /^-\d*\.{0,1}\d+$/;//Nagative Number
g_arValidateList[5] = /^-{0,1}\d*\.{0,1}\d+$/;//Positive or Nagative Number
g_arValidateList[6] = /^\+?[\d\s]{3,}$/;//Phone number
g_arValidateList[7] = /^\+?[\d\s]+\(?[\d\s]{10,}$/;//Phone with area code
g_arValidateList[8] = /^(19|20)[\d]{2,2}$/;//Year 1900-2099
g_arValidateList[9] = /^([1-9]|0[1-9]|[12][0-9]|3[01])\D([1-9]|0[1-9]|1[012])\D(19[0-9][0-9]|20[0-9][0-9])$/;//Date (dd mm yyyy, d/m/yyyy, etc.)
g_arValidateList[10] = /^(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]){3}$/;//IP v4
g_arValidateList[11] = /^[\w\.\']{2,}([\s][\w\.\']{2,})+$/; //Personal Name
g_arValidateList[12] = /^[\w\d\_\.]{4,}$/; //Username
g_arValidateList[13] = /^.{6,}$/;//Password at least 6 symbols
g_arValidateList[14] = /^.{6,}$|^$/;//Password or empty input
g_arValidateList[15] = /^[\_]*([a-z0-9]+(\.|\_*)?)+@([a-z][a-z0-9\-]+(\.|\-*\.))+[a-z]{2,6}$/;//email
g_arValidateList[16] = /^([a-z][a-z0-9\-]+(\.|\-*\.))+[a-z]{2,6}$/;//domain
g_arValidateList[17] = /^$/;//Match no input 
g_arValidateList[18] = /^(http(s)?|ftp):\/\/[A-Za-z0-9\.-]{3,}\.[A-Za-z]{3}/; //Url
g_arValidateList[19] = /^$/;//Match no input
g_arValidateList[20] = /^\s[\t]*$/;//Match blank input
g_arValidateList[21] = /[\r\n]|$/;//Match New line
g_arValidateList[22] = /^\S+\.(gif|jpg|jpeg|png)$/;//FileName
function checkRegulation(nIndex, sText)
{
   return g_arValidateList[nIndex].test(sText);
}
