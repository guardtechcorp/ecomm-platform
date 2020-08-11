<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

var g_titlelink = 0;
function checkFieldEmpty(objField)
{
  var sValue = trim(objField.value);
  return sValue.length==0;
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
     var at="@"
     var dot="."
     var lat=strEmail.indexOf(at)
     var lstr=strEmail.length
     var ldot=strEmail.indexOf(dot)

   if (strEmail.indexOf(at)==-1)
   {
       alert("Invalid E-mail Address.")
           return false;
   }

   if (strEmail.indexOf(at)==-1 || strEmail.indexOf(at)==0 || strEmail.indexOf(at)==lstr)
   {
       alert("Invalid E-mail Address.")
          return false;
   }

   if (strEmail.indexOf(dot)==-1 || strEmail.indexOf(dot)==0 || strEmail.indexOf(dot)==lstr)
   {
       alert("Invalid E-mail Address.")
          return false;
   }

   if (strEmail.indexOf(at,(lat+1))!=-1)
   {
       alert("Invalid E-mail Address.")
          return false;
   }

   if (strEmail.substring(lat-1,lat)==dot || strEmail.substring(lat+1,lat+2)==dot)
   {
       alert("Invalid E-mail Address.")
          return false;
   }

   if (strEmail.indexOf(dot,(lat+2))==-1)
   {
       alert("Invalid E-mail Address.")
          return false;
   }

   if (strEmail.indexOf(" ")!=-1)
   {
       alert("Invalid E-mail Address.")
      return false;
   }

   return true;
}

function checkDomain(nname)
{
  var arr = new Array(
      '.com','.net','.org','.biz','.coop','.info','.museum','.name',
      '.pro','.edu','.gov','.int','.mil','.ac','.ad','.ae','.af','.ag',
      '.ai','.al','.am','.an','.ao','.aq','.ar','.as','.at','.au','.aw',
      '.az','.ba','.bb','.bd','.be','.bf','.bg','.bh','.bi','.bj','.bm',
      '.bn','.bo','.br','.bs','.bt','.bv','.bw','.by','.bz','.ca','.cc',
      '.cd','.cf','.cg','.ch','.ci','.ck','.cl','.cm','.cn','.co','.cr',
      '.cu','.cv','.cx','.cy','.cz','.de','.dj','.dk','.dm','.do','.dz',
      '.ec','.ee','.eg','.eh','.er','.es','.et','.fi','.fj','.fk','.fm',
      '.fo','.fr','.ga','.gd','.ge','.gf','.gg','.gh','.gi','.gl','.gm',
      '.gn','.gp','.gq','.gr','.gs','.gt','.gu','.gv','.gy','.hk','.hm',
      '.hn','.hr','.ht','.hu','.id','.ie','.il','.im','.in','.io','.iq',
      '.ir','.is','.it','.je','.jm','.jo','.jp','.ke','.kg','.kh','.ki',
      '.km','.kn','.kp','.kr','.kw','.ky','.kz','.la','.lb','.lc','.li',
      '.lk','.lr','.ls','.lt','.lu','.lv','.ly','.ma','.mc','.md','.mg',
      '.mh','.mk','.ml','.mm','.mn','.mo','.mp','.mq','.mr','.ms','.mt',
      '.mu','.mv','.mw','.mx','.my','.mz','.na','.nc','.ne','.nf','.ng',
      '.ni','.nl','.no','.np','.nr','.nu','.nz','.om','.pa','.pe','.pf',
      '.pg','.ph','.pk','.pl','.pm','.pn','.pr','.ps','.pt','.pw','.py',
      '.qa','.re','.ro','.rw','.ru','.sa','.sb','.sc','.sd','.se','.sg',
      '.sh','.si','.sj','.sk','.sl','.sm','.sn','.so','.sr','.st','.sv',
      '.sy','.sz','.tc','.td','.tf','.tg','.th','.tj','.tk','.tm','.tn',
      '.to','.tp','.tr','.tt','.tv','.tw','.tz','.ua','.ug','.uk','.um',
      '.us','.uy','.uz','.va','.vc','.ve','.vg','.vi','.vn','.vu','.ws',
      '.wf','.ye','.yt','.yu','.za','.zm','.zw');

  var mai = nname;
  var val = true;
  var dot = mai.lastIndexOf(".");
  var dname = mai.substring(0,dot);
  var ext = mai.substring(dot,mai.length);
  //alert(ext);
  if(dot>2 && dot<57)
  {
    for(var i=0; i<arr.length; i++)
    {
      if(ext == arr[i])
      {
         val = true;
         break;
      }
      else
      {
         val = false;
      }
    }
    if (val == false)
    {
      alert("Your domain extension "+ext+" is not correct");
      return false;
    }
    else
    {
      for(var j=0; j<dname.length; j++)
      {
        var dh = dname.charAt(j);
        var hh = dh.charCodeAt(0);
        if((hh > 47 && hh<59) || (hh > 64 && hh<91) || (hh > 96 && hh<123) || hh==45 || hh==46)
        {
          if((j==0 || j==dname.length-1) && hh == 45)
          {
            alert("Domain name should not begin are end with '-'");
            return false;
          }
        }
        else
        {
           alert("Your domain name should not have special characters");
           return false;
        }
      }
    }
  }
  else
  {
    alert("Invalid domain name.");
    return false;
  }

  return true;
}

function dump_props(obj, obj_name) {
   var result = "";
   for (var i in obj) {
      result += obj_name + "." + i + " = " + obj[i] + "<br>";
   }
   result += "<hr>";
   return result;
}

function checkFileType(objFile, allEmpty)
{
    var sFile = objFile.value;
    if (sFile.length>0)
    {
      if (sFile.toLowerCase().indexOf(".gif")!=-1||sFile.toLowerCase().indexOf(".jpg")!=-1||sFile.toLowerCase().indexOf(".jpeg")!=-1||sFile.toLowerCase().indexOf(".png")!=-1)
        return true
      else
      {
        alert("The selected file is not image file. The browser only can support gif, jpg, jpeg, jpe or png file.");
        return false;
      }
    }
    else
      return allEmpty;
}

function setFocus(objInput)
{
    objInput.focus();
    objInput.select();
}

function trim(str)
{
  var nStart = 0;
  var nEnd = str.length;//-1;
  if (nEnd<0)
     return str;

  for (var i=0; i<=nEnd; i++)
  {
    if (str.charCodeAt(i)!=32)
       break;
    nStart = i+1;
  }

  if (nStart>=nEnd)
     return "";

  for (var i=nEnd; i>=0; i--)
  {
    if (str.charCodeAt(i)!=32)
       break;
    nEnd = i-1;
  }
  nEnd++;
  str = str.substring(nStart, nEnd);
  return str;
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
//alert("cookie=" + name+","+value);
   document.cookie = name + "=" + escape(value) + ";expires=Thu, 01-Jan-2010 00:00:01 GMT";
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

function writeText(sContent)
{
  document.write(sContent);
}

function checkDateFormat(strValue,strFormat)
{
    var msg = "Invalid date format.\nCorrect date format is "+strFormat;
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

function validateTimeRange(fromTime, toTime)
{
//  alert("fromTime=" + fromTime.length + ", toTime=" + toTime);
    if (fromTime.length>0)
    {
       if (fromTime.length<5)
          return 1;
    }

    if (toTime.length>0)
    {
        if (toTime.length<5)
           return 2;
    }

    if (fromTime.length>0 && fromTime.length>0)
    {
       if (fromTime>toTime)
          return 3;
    }

    return 0;
}

function validateDateRange(fromDate, toDate)
{
   if (fromDate.length>0)
   {
      if (fromDate.length<10)
         return 1;
   }

   if (toDate.length>0)
   {
       if (toDate.length<10)
          return 2;
   }

   if (fromDate.length>=10 && toDate.length>=10)
   {
       var fromDT = getDateTime(fromDate);
       var toDT = getDateTime(toDate);

       if (fromDT.getTime()>toDT.getTime())
          return 3;
   }

   return 0;
}

function getDateTime(datetime)
{
   if (datetime.length==16)
      return getDateTimeByFormat(datetime, "yyyy-mm-dd hh:ii");
   else if (datetime.length==13)
      return getDateTimeByFormat(datetime, "yyyy-mm-dd hh");
   else if (datetime.length==10)
      return getDateTimeByFormat(datetime, "yyyy-mm-dd");
   else
      return getDateTimeByFormat(datetime, "yyyy-mm-dd hh:ii:ss");
}

function getDateTimeByFormat(sdate, format)
{
  var normalized      = sdate.replace(/[^a-zA-Z0-9]/g, '-');
  var normalizedFormat= format.toLowerCase().replace(/[^a-zA-Z0-9]/g, '-');
  var formatItems     = normalizedFormat.split('-');
  var dateItems       = normalized.split('-');

  var monthIndex  = formatItems.indexOf("mm");
  var dayIndex    = formatItems.indexOf("dd");
  var yearIndex   = formatItems.indexOf("yyyy");
  var hourIndex     = formatItems.indexOf("hh");
  var minutesIndex  = formatItems.indexOf("ii");
  var secondsIndex  = formatItems.indexOf("ss");

  var today = new Date();

  var year  = yearIndex>-1  ? dateItems[yearIndex]    : today.getFullYear();
  var month = monthIndex>-1 ? dateItems[monthIndex]-1 : today.getMonth()-1;
  var day   = dayIndex>-1   ? dateItems[dayIndex]     : today.getDate();

  var hour    = hourIndex>-1      ? dateItems[hourIndex]    : today.getHours();
  var minute  = minutesIndex>-1   ? dateItems[minutesIndex] : today.getMinutes();
  var second  = secondsIndex>-1   ? dateItems[secondsIndex] : today.getSeconds();

//alert("Date = " + year+"-" + month+"-"+ day + "  " + hour + ":" + minute+":"+second +" -->" + secondsIndex);

  return new Date(year,month,day,hour,minute,second);
}

function autoFormat(obj,type)
{
  if (event.keyCode!=8){
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
    /*else if(type == "S") { //for String it could be anything
            if(!((val >= 'a' && val <= 'z') || (val >= 'A' && val <='Z') || ('0' <= val && val <= '9') || (val == ' ') || (val == '-')))
                    obj.value = obj.value.substr(0,len-1);
            if(len > maxLen) obj.value = obj.value.substr(0,len+1);
    }*/
  }
}

function selectAll(form, obj)
{
   for (var i=0;i<form.elements.length;i++)
   {
      var e = form.elements[i];
      if ((e.name !=  obj.name) && (e.type=='checkbox'))
      {
         if (e.checked != obj.checked)
            e.click();
      }
   }
}

function getRadioButton(objRadio, bValue)
{
  for (i=0; i<objRadio.length; i++)
  {
    if (objRadio[i].checked)
    {
       if (bValue)
          return objRadio[i].value;
       else
          return i;
    }
  }

  if (bValue)
     return "";
  else
     return -1;
}

function submitSwitchPage(form, rpp, page)
{
   form.rpp.value = ""+rpp;
   form.page.value = ""+page;
   if (form.sort!=null)
   {
      form.sort.disabled = "true";
      form.asc.disabled = "true";
   }

   form.submit();
}

function submitSortPage(form, name, asc)
{
   form.sort.value = name;
   form.asc.value = asc;
   if (form.rpp!=null)
   {
      form.rpp.disabled = "true";
      form.page.disabled = "true";
   }
   form.submit();
}

function submitForm(form, action)
{
   if (form.actionlink!=null)
      form.actionlink.value = action;
   form.submit();
}

function validateSelection(form)
{
   for (var i=0;i<form.elements.length;i++)
   {
      var e = form.elements[i];
      if (e.type=='checkbox')
      {
       if (!e.checked)
       {
          e.checked=true;
          e.value="0";
       }
      }
   }

   return true;
}

function onSelectChange(objSelect, objInput)
{
  if (objSelect.selectedIndex<objSelect.length-1)
     objInput.value = objSelect.options[objSelect.selectedIndex].value;
  else
     setFocus(objInput);
}

function selectAtLeastOne(objSelect, sValue)
{//2005-06-27|2005-05-07-21
  for(i=0; i<objSelect.length; i++)
  {
    if (objSelect.options[i].value==sValue)
    {
      objSelect.selectedIndex = i;
      return;
    }
  }

  objSelect.selectedIndex = objSelect.length-1;
}

function selectDropdownMenu(objSelect, sValue)
{//2005-06-27|2005-05-07-21
  for(i=0; i<objSelect.length; i++)
  {
    if (objSelect.options[i].value==sValue)
    {
      objSelect.selectedIndex = i;
      break;
    }
  }
}

function selectMultpleOptions(objSelect, sSelection, sSparator)
{
  if (sSelection==null||sSelection.length==0)
     return;

/*
  //5,3,12,4,
  sSelection += sSparator;
  for(i=0; i<objSelect.length; i++)
  {
    var sValue = objSelect.options[i].value + sSparator;
    if (sSelection.indexOf(sValue)!=-1)
    {
       objSelect.options[i].selected = true;
    }
  }
*/
  var sTemp = sSparator + sSelection + sSparator;
  for(i=0; i<objSelect.length; i++)
  {
    var sValue = sSparator + objSelect.options[i].value + sSparator;
    if (sTemp.indexOf(sValue)!=-1)
    {
       objSelect.options[i].selected = true;
    }
  }
}

function setupOption(objSelect, objArray, sSelected)
{
  objSelect.length = 0;
  for (i=0; i<objArray.length; i++)
  {
     objSelect.options[objSelect.length] = new Option(objArray[i][1], objArray[i][0]);
     if (objArray[i][0] == sSelected)
        objSelect.selectedIndex = i;
  }
}

function hasMultpleOptionsSelected(objSelect)
{
  for (i=0; i<objSelect.length; i++)
  {
     if (objSelect.options[i].selected);
        return true;
  }

  alert("You have to at least select one of itmes.");
  objList.focus();

  return false;
}

numberoftimes = 0;
function onlyonce()
{
   numberoftimes += 1;
   if (numberoftimes > 1)
   {
     var themessage = "Please be patient. You have already submitted this form.";
     if (numberoftimes == 3)
     {
        themessage = "DO NOT PRESS SUBMIT MULTIPLE TIMES!!! Processing may take up to one minute.";
     }
     alert(themessage);
     return false;
   }
   else
   {
      return true;
   }
}

function updateMaxRows(objSelect, sJspFile)
{
//alert("updateMaqRows = " + sJspFile + "?action=updaterows&maxrows=" + objSelect.selectedIndex);
  if (sJspFile.indexOf("?")==-1)
     window.location.href = sJspFile + "?action=updaterows&maxrows=" + objSelect.options[objSelect.selectedIndex].value;
  else
     window.location.href = sJspFile + "&action=updaterows&maxrows=" + objSelect.options[objSelect.selectedIndex].value;
//window.navigate(strRequest);
}

function validateSelections(objList)
{
  if (objList.selectedIndex >= 0)
     return true;

  alert("You have to at least select one of itmes.");
  objList.focus();
  return false;
}

function highlightRow(obj)
{
  var tbl = obj.parentNode.parentNode.parentNode;

  for (var j=0;j<tbl.rows.length;j++)
  {
      tbl.rows(j).className = "normal_row";
//	  obj.parentNode.parentNode.className="highlight_row";
  }

  obj.parentNode.parentNode.className="highlight_row";
}

function highlightCheckedRow(objCheckBox)
{
  if (objCheckBox.checked)
     objCheckBox.parentNode.parentNode.className="highlight_row";
  else
     objCheckBox.parentNode.parentNode.className="normal_row";
}

function selrow (element, i)
{
  if (i==0){
     element.className='highlight2_row';//mousein';
  }
  else if (i==1){
     element.className= 'normal_row';//'mouseout';
  }
  else if ((i==2)){
     element.className='mousechecked';
  }

/*
	var erst;
	CheckBrowser();
	if ((OP==1)||(MS==1)) erst = element.firstChild.firstChild;
	else if (DOM==1) erst = element.firstChild.nextSibling.firstChild;
	if (i==0){
		if (erst.checked == true) element.className='mousechecked';
		else element.className='mousein';
	}
	else if (i==1){
		if (erst.checked == true) element.className='checked';
		else element.className='mouseout';
	}
	else if ((i==2)&&(!check)){
		if (erst.checked==true) element.className='mousein';
		else element.className='mousechecked';
		erst.click();
	}
	else check=false;
*/
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

function showTipHelp(sHelpTag)
{
  var sRequest = "../share/helptip.jsp?action=getcontent&tag=" + sHelpTag;
  getTipHelp(sRequest);
}

function showTipHelp1(sHelpTag, sP1)
{
  var sRequest = "../share/helptip.jsp?action=getcontent&tag=" + sHelpTag + "&p1="+sP1;
  getTipHelp(sRequest);
}

function showTipHelp2(sHelpTag, sP1, sP2)
{
  var sRequest = "../share/helptip.jsp?action=getcontent&tag=" + sHelpTag + "&p1="+sP1 + "&p2="+sP2;
  getTipHelp(sRequest);
}

function getTipHelp(sRequest)
{
  if (document.getElementById('tiphelp')==null||document.getElementById('tipcontent')==null)
     return;
  var sResponse = getUrlContent(sRequest);
//alert("sResponse=" + sResponse + "!!" + sResponse.length);
  if (sResponse!=null&&sResponse.length>5)
  {
//     document.getElementById('tipcontent').innerText = sResponse;
     document.getElementById('tipcontent').innerHTML = sResponse;//"<b>Test Html<br> format</b>";
     showHideSpan('open','tiphelp');
  }
}

function toggleShow(name)
{
  if (eval("document.getElementById('"+name+"').style.display")=="none")
  {
    showHideSpan("open", name);
  }
  else
  {
    showHideSpan("close",name);
  }
}

function openAndClose(openname, closename)
{
  showHideSpan("close", closename);
  showHideSpan("open", openname);
}

function showHideSpan(method,section)
{
//  if (eval("document.all."+section)!=null){if (method=="open" ){eval(section + ".style.display='inline'" );}else if (method=="close"){eval(section + ".style.display='none'" );}}
  if (eval("document.getElementById('"+section+"')")!=null)
    {if (method=="open" ){eval("document.getElementById('"+section+"').style.display='inline'" );}else if (method=="close"){eval("document.getElementById('"+section+"').style.display='none'");}}
}

function getUrlContent(sUrl)
{
  var xmlhttp;
  if (navigator.appName == "Microsoft Internet Explorer")
     xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  else
     xmlhttp = new XMLHttpRequest();

  try {
    xmlhttp.open("GET", sUrl, false);
    xmlhttp.send(null);
    return xmlhttp.responseText;
  }
  catch (ex)
  {
//    alert(ex.message);
  }
}

function postContent(sUrl, Request)
{
  var xmlhttp;
  if (navigator.appName == "Microsoft Internet Explorer")
     xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  else
     xmlhttp = new XMLHttpRequest();

   xmlhttp.open("Post", sUrl, false);
   xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

   xmlhttp.send(Request);
   return xmlhttp.responseText;
}

function sendActionToServer(sUrl)
{
  var imageObject = new Image();
  imageObject.src = sUrl;
}

//style="filter:alpha(opacity=20);-moz-opacity:0.2" onMouseover="makevisible(this,0)" onMouseout="makevisible(this,1)"
function makevisible(cur,which)
{
  strength=(which==0)? 1 : 0.2
  if (cur.style.MozOpacity)
    cur.style.MozOpacity=strength
  else if (cur.filters)
    cur.filters.alpha.opacity=strength*100
}

//class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')"
function borderit(which,color)
{//if IE 4+ or NS 6+
  if (document.all||document.getElementById)
     which.style.borderColor=color
}

var ie=(document.all)?1:0;
var ns=(document.layers)?1:0;
function LightOn(what)
{
        if (ie) what.style.backgroundColor = '#E0E0D0';
        else return;
}
function FocusOn(what)
{
        if (ie) what.style.backgroundColor = '#EBEBEB';
        else return;
}
function LightOut(what)
{
        if (ie) what.style.backgroundColor = '#C0C0A8';
        else return;
}
function FocusOff(what)
{
        if (ie) what.style.backgroundColor = '#DDDDDD';
        else return;
}

function createTableOpen(){
  document.write("<TABLE cellspacing='0' cellpadding='0' border='0' align='center'><TR><TD colspan='2' height='7' rowspan='2'><IMG height='7' src='/staticfile/admin/images/corner1.gif' width='7'></TD><TD style='border-top: 1px solid #BBBBBB;'><IMG height='1' src='/staticfile/admin/images/clearpixel.gif' width='1' border='0'></TD><TD colspan='2' height='7' rowspan='2'><IMG height='7' src='/staticfile/admin/images/corner2.gif' width='7'></TD></TR><TR valign='top'><TD><IMG height='5' src='/staticfile/admin/images/clearpixel.gif' width='1' border='0'></TD></TR><TR valign='top'><TD width='1' style='border-left: 1px solid #BBBBBB;'><IMG height='1' src='/staticfile/admin/images/clearpixel.gif' width='1' border='0'></TD><TD width='5'><IMG height='1' src='/staticfile/admin/images/clearpixel.gif' width='5' border='0'></TD><TD bgcolor='#E8EBF4' valign='top'>");
}

function createTableClose(){document.write("</TD><TD width='5'><IMG height='1' src='/staticfile/admin/images/clearpixel.gif' width='5' border='0'></TD><TD width='1' style='border-right: 1px solid #BBBBBB;'><IMG height='1' src='/staticfile/admin/images/clearpixel.gif' width='1' border='0'></TD></TR><TR valign='bottom'><TD colspan='2' height='7' rowspan='2'><IMG height='7' src='/staticfile/admin/images/corner3.gif' width='7'></TD><TD style='border-bottom: 1px solid #BBBBBB;'><IMG height='1' src='/staticfile/admin/images/clearpixel.gif' width='1' border='0'></TD><TD colspan='2' height='7' rowspan='2'><IMG height='7' src='/staticfile/admin/images/corner4.gif' width='7'></TD></TR></TABLE>");}

var g_objInput;
function loadSelectColor(objInput, nType)
{
  g_objInput = objInput;

//  var w = screen.availWidth;
//  var h = screen.availHeight;
  var popW = 215, popH = 165;
//  var leftPos = (w-popW)/2, topPos = (h-popH)/2;
  var currentColor = objInput.value;
  if (nType==1)
//     window.open('/staticfile/admin/popup/select-color.html?color=' + currentColor + '&command=Select Color','popup','location=0,status=0,scrollbars=0,width=' + popW + ',height=' + popH + ',top=' + topPos + ',left=' + leftPos);
     modalWin('/staticfile/admin/popup/select-color.html?color=' + currentColor + '&command=Select Color', popW, popH);
  else
     modalWin('/staticfile/admin/popup/select-fullcolor.html?color=' + currentColor + '&command=Select Color', popW+40, popH+200);
//     window.open('/staticfile/admin/popup/select-fullcolor.html?color=' + currentColor + '&command=Select Color','popup','location=0,status=0,scrollbars=1,width=' + (popW+40) + ',height=' + (popH+200) + ',top=' + topPos + ',left=' + leftPos);
}

function setSelectColor(sColor)
{
  if (sColor=="#FFFFFF")
     g_objInput.style.color = "#000000";
  else
     g_objInput.style.color = sColor;
  g_objInput.value = sColor;
//  g_objInput.style.backgroundColor = value;
}

var g_qsParm = new Array();
function parseParameters()
{
  var query = window.location.search.substring(1);
//alert("query=" + query);
  var parms = query.split('&');
  for (var i=0; i<parms.length; i++) {
    var pos = parms[i].indexOf('=');
    if (pos > 0) {
       var key = parms[i].substring(0,pos);
       var val = parms[i].substring(pos+1);
       g_qsParm[key] = val;
    }
  }
}

function getParameter(sName)
{
  return g_qsParm[sName];
}


/*
//<INPUT onmouseover=LightOn(this) onclick=selectCode() onmouseout=LightOut(this) type=button value=Select name=select>
function newWindow(mypage,myname,w,h,scroll,pos)
{
  if(pos=="random"){LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;}
  if(pos=="center"){LeftPosition=(screen.width)?(screen.width-w)/2:100;TopPosition=(screen.height)?(screen.height-h)/2:100;}
  else if((pos!="center" && pos!="random") || pos==null)
  {LeftPosition=0;TopPosition=20}

  settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=yes,menubar=no,toolbar=no,resizable=no';
  var win =window.open(mypage,myname,settings);
  win.focus();
}

function centerWindow(width, height)
{
  left = (screen.width) ? (screen.width-width)/2 : 0;
  top = (screen.height) ? (screen.height-height)/2 : 0;
//alert("left=" + left + "," + top);
  moveWindow(left, top, width, height);
}

function moveWindow(left, top, width, height)
{
  window.moveTo(left, top);
  if (document.all) {
    window.resizeTo(width, height);
  }
  else if (document.layers||document.getElementById)
  {
    window.outerWidth = width;//screen.availWidth;
    window.outerHeight = height;//screen.availHeight
  }
}
*/