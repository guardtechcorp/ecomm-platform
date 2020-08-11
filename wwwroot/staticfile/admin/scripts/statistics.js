<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

yearfebList = new Array();
yearfebList[0] = new Array("2005","28");
yearfebList[1] = new Array("2006","28");
yearfebList[2] = new Array("2007","28");
yearfebList[3] = new Array("2008","29");
yearfebList[4] = new Array("2009","28");
yearfebList[5] = new Array("2010","28");
yearfebList[6] = new Array("2011","28");
yearfebList[7] = new Array("2012","29");
yearfebList[8] = new Array("2013","28");
yearfebList[9] = new Array("2014","28");
yearfebList[10] = new Array("2015","28");
yearfebList[11] = new Array("2016","29");
yearfebList[12] = new Array("2017","28");
yearfebList[13] = new Array("2018","28");
yearfebList[14] = new Array("2019","28");
yearfebList[15] = new Array("2020","29");
yearfebList[16] = new Array("2021","28");
yearfebList[17] = new Array("2022","28");
yearfebList[18] = new Array("2023","28");
yearfebList[19] = new Array("2024","29");
yearfebList[20] = new Array("2025","28");
yearfebList[21] = new Array("2026","28");
yearfebList[22] = new Array("2027","28");
yearfebList[23] = new Array("2028","29");
yearfebList[24] = new Array("2029","28");
yearfebList[25] = new Array("2030","28");
yearfebList[26] = new Array("2031","28");
yearfebList[27] = new Array("2032","29");
yearfebList[28] = new Array("2033","28");
yearfebList[29] = new Array("2034","28");
yearfebList[30] = new Array("2035","28");
yearfebList[31] = new Array("2036","29");
yearfebList[32] = new Array("2037","28");
yearfebList[33] = new Array("2038","28");
yearfebList[34] = new Array("2039","28");
yearfebList[35] = new Array("2040","29");

function onStatisticsLoad(form, daterange, sFieldValue)
{
  selectDateRange(form, daterange);

  if (sFieldValue!=null&&sFieldValue.length>0)
  {// year_last=2004"
    if (sFieldValue.indexOf("!")==-1)
    {
      var arField = sFieldValue.split("=");
      var objField = eval("form." + arField[0]);
//      makeDefaultSelect(objField, arField[1])
      selectDropdownMenu(objField, arField[1]);
    }
    else
    {
      var arFields = sFieldValue.split("!");
      //. Month_Which
      var arField = arFields[0].split("=");
      var objField = eval("form." + arField[0]);
//      makeDefaultSelect(objField, arField[1])
      selectDropdownMenu(objField, arField[1]);
      //. Year_Which
      arField = arFields[1].split("=");
      objField = eval("form." + arField[0]);
//      makeDefaultSelect(objField, arField[1])
      selectDropdownMenu(objField, arField[1]);
    }
  }
}

function makeDefaultSelect(objField, sValue)
{//all, week, month or year
//alert("objField=" + objField);
  for(i=0; i<objField.length; i++)
  {
    if (objField.options[i].value==sValue)
    {
      objField.selectedIndex = i;
      break;
    }
  }
}

function selectDateRange(form, daterange)
{//2005-06-27|2005-05-07-21
//alert ("datarange = " + daterange);
   var arDates = daterange.split("|");
   var arFroms = arDates[0].split("-");
   var arTos = arDates[1].split("-");
//alert ("to = " + arDates[1]);
   for(i=0; i<form.year_from.length; i++)
   {
     if (form.year_from.options[i].value==arFroms[0])
     {
       form.year_from.selectedIndex = i;
       break;
     }
   }
   for(i=0; i<form.month_from.length; i++)
   {
     if (form.month_from.options[i].value==arFroms[1])
     {
       form.month_from.selectedIndex = i;
       break;
     }
   }
   for(i=0; i<form.day_from.length; i++)
   {
     if (form.day_from.options[i].value==arFroms[2])
     {
       form.day_from.selectedIndex = i;
       break;
     }
   }

   for(i=0; i<form.year_to.length; i++)
   {
     if (form.year_to.options[i].value==arTos[0])
     {
       form.year_to.selectedIndex = i;
       break;
     }
   }
   for(i=0; i<form.month_to.length; i++)
   {
     if (form.month_to.options[i].value==arTos[1])
     {
       form.month_to.selectedIndex = i;
       break;
     }
   }
   for(i=0; i<form.day_to.length; i++)
   {
     if (form.day_to.options[i].value==arTos[2])
     {
       form.day_to.selectedIndex = i;
       break;
     }
   }
}

function onMonthWhichChange(form)
{
// alert("value33=");
//alert("value11=" + form.cateid.value);
//form.cateid.selectedIndex = 3
//alert("value22=" + form.cateid.value);

  onYearWhichChange(form);
}

function onYearWhichChange(form)
{
  if (form.year_which.selectedIndex>0)
  {
    form.week_last.selectedIndex = 0;
    form.month_last.selectedIndex = 0;
    form.year_last.selectedIndex = 0;
    var sDateRange;
    if (form.month_which.selectedIndex==0)
    {//. It is full year
      sDateRange = form.year_which.options[form.year_which.selectedIndex].value +"-01-01|" +
                   form.year_which.options[form.year_which.selectedIndex].value +"-12-31";
    }
    else
    {
      sDateRange = form.year_which.options[form.year_which.selectedIndex].value + "-" + form.month_which.options[form.month_which.selectedIndex].value + "-01|" +
                   form.year_which.options[form.year_which.selectedIndex].value + "-" + form.month_which.options[form.month_which.selectedIndex].value + "-" +
                   getActualMaxDay(form.year_which.options[form.year_which.selectedIndex].value, form.month_which.options[form.month_which.selectedIndex].value);
    }

    selectDateRange(form, sDateRange);
  }
}

function getActualMaxDay(sYear, sMonth)
{
  if (sMonth=="02")
  {
    for (i=0; i<yearfebList.length; i++)
    {
      if (yearfebList[i][0] == sYear)
        return yearfebList[i][1];
    }
  }

  return "31";
}

function onWeekLastChange(form)
{
  if (form.week_last.selectedIndex>0)
  {
    var nPerunitSelected = form.perunit.selectedIndex;
    var nSelected = form.week_last.selectedIndex;
    form.reset();
    form.perunit.selectedIndex = nPerunitSelected;
    form.week_last.selectedIndex = nSelected;
    selectDateRange(form, form.week_last.options[form.week_last.selectedIndex].value);
  }
}

function onMonthLastChange(form)
{
  if (form.month_last.selectedIndex>0)
  {
    var nPerunitSelected = form.perunit.selectedIndex;
    var nSelected = form.month_last.selectedIndex;
    form.reset();
    form.perunit.selectedIndex = nPerunitSelected;
    form.month_last.selectedIndex = nSelected;
    selectDateRange(form, form.month_last.options[form.month_last.selectedIndex].value);
  }
}

function onYearLastChange(form)
{
  if (form.year_last.selectedIndex>0)
  {
    var nPerunitSelected = form.perunit.selectedIndex;
    var nSelected = form.year_last.selectedIndex;
    form.reset();
    form.perunit.selectedIndex = nPerunitSelected;
    form.year_last.selectedIndex = nSelected;

    selectDateRange(form, form.year_last.options[form.year_last.selectedIndex].value);
  }
}

function onDateRangeChange(form)
{
  form.week_last.selectedIndex = 0;
  form.month_last.selectedIndex = 0;
  form.year_last.selectedIndex = 0;
  form.month_which.selectedIndex = 0;
  form.year_which.selectedIndex = 0;
}

function validateDisplay(form)
{
//  alert("Test=" + form.year_last.options[form.year_last.selectedIndex].text);
  if (form.week_last.selectedIndex>0)
  {
     form.datedesc.value = form.week_last.options[form.week_last.selectedIndex].text;
     return true;
  }

  if (form.month_last.selectedIndex>0)
  {
     form.datedesc.value = form.month_last.options[form.month_last.selectedIndex].text;
     return true;
  }

  if (form.year_last.selectedIndex>0)
  {
     form.datedesc.value = form.year_last.options[form.year_last.selectedIndex].text;
     return true;
  }

  if (form.year_which.selectedIndex>0)
  {
    if (form.month_which.selectedIndex>0)
    {
      form.datedesc.value = form.month_which.options[form.month_which.selectedIndex].text + " of " +  form.year_which.options[form.year_which.selectedIndex].text;
    }
    else
    {
      form.datedesc.value = "Entire Year of " +  form.year_which.options[form.year_which.selectedIndex].text;
    }
  }

  return true;
}

function onSummaryChange(form)
{
  if (form.perunit.selectedIndex>0)
  {
    form.showtype.selectedIndex = 0;
    form.showtype.disabled = "true";
  }
  else
  {
    form.showtype.disabled = "";
  }

  return true;
}

var m_nIdleInterval = 10*1000;
var m_objShowArea;
var m_bOn = false;
var m_nShowBits = 1;
var m_ServerProgram;
function setShowBit(objField)
{
//alert("objField=" + objField.checked + "," + objField.value);
  var nBit = parseInt(objField.value);
  if (objField.checked)
    m_nShowBits |= nBit;
  else
    m_nShowBits &= ~nBit;
//alert("m_nShowBits=" + m_nShowBits);
  if (m_nShowBits==0)
  {
     objField.checked = true;
     m_nShowBits = nBit;
  }
}

function setRealTimeOn(objShowArea, bOn, serverProgram)
{
  m_objShowArea = objShowArea;
  m_bOn = bOn;
  m_ServerProgram = serverProgram;
  if (bOn)
    getActionInfo(2);
  else
  {
    var sRequest = m_ServerProgram + "?action=Stop ActionInfo" + "&time="+new Date().getTime();
    sendActionToServer(sRequest);
  }
}

function showRealTime(name, objShowArea)
{
   toggleShow(name);

   if (eval("document.getElementById('"+name+"').style.display")!="none")
     setRealTimeOn(objShowArea, true);
   else
     setRealTimeOn(objShowArea, false);
}

function onLeave()
{
//alert("m_bOn=" + m_bOn);
  if (m_bOn)
  {
     m_bOn = false;
     var sRequest = m_ServerProgram + "?action=Stop ActionInfo" + "&time="+new Date().getTime();
     var sResponse = getUrlContent(sRequest);
//     sendActionToServer(sRequest);
  }
}

function getActionInfo(nSeconds)
{
//  var sRequest = "../statistics/monitor.jsp?action=Get ActionInfo" + "&showbit="+m_nShowBits + "&time="+new Date().getTime();
  var sRequest = m_ServerProgram + "?action=Get ActionInfo" + "&showbit="+m_nShowBits + "&time="+new Date().getTime();
//alert("sRequest=" + sRequest);
  var sResponse = getUrlContent(sRequest);
  if (sResponse!=null&&sResponse.length>5)
  {
     if (m_objShowArea.value.length<40960)
        m_objShowArea.value += sResponse;
     else
        m_objShowArea.value = sResponse;
     m_objShowArea.doScroll("scrollbarPageDown");
  }

  if (nSeconds!=null)
     m_nIdleInterval = nSeconds*1000;
//alert("sendIdleFlag=" + nCountOfTimes+","+nSeconds);
  if (m_bOn)
     setTimeout('getActionInfo()', m_nIdleInterval);
}

function copyToClipboard(theField)
{
//  var tempval=eval("document."+theField);
  theField.focus();
  theField.select();
  if (document.all)
  {
    therange=theField.createTextRange();
    therange.execCommand("Copy");
    window.status="The Contents was copied to clipboard!";
    setTimeout("window.status=''", 5000);
  }
}

var g_Div;
var g_RetrieveInerval = 2*1000;
var g_Guide = " ";
var g_EveryMinute = 0;
function onBodyLoad(nSeconds)
{
  g_Div = document.createElement("div");
  document.body.appendChild(g_Div);
  retrieveTable(nSeconds);
}

function retrieveTable(nSeconds)
{
  if (nSeconds!=null)
     g_RetrieveInterval = nSeconds*1000;

  if (g_EveryMinute>=60*1000)
  {
//alert("g_EveryMintue=" + g_EveryMinute);
    g_Guide = " ";
    g_EveryMinute = 0;
  }
  else
    g_EveryMinute += g_RetrieveInterval;

  var sRequest = "monitor.jsp?action=Table List" + getExtraInfo();
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
