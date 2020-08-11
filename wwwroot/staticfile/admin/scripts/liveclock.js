/*
Live Date Script-
© Dynamic Drive (www.dynamicdrive.com)
For full source code, installation instructions, 100's more DHTML scripts, and Terms Of Use,
visit http://www.dynamicdrive.com
*/
var dayarray=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
var montharray=new Array("January","February","March","April","May","June","July","August","September","October","November","December")
var g_bTimeOnly = false;
var g_nTargetMiliseconds;
function getthedate()
{
  var mydate=new Date()
  var year=mydate.getYear()
  if (year < 1000)
    year+=1900
  var day=mydate.getDay()
  var month=mydate.getMonth()
  var daym=mydate.getDate()
  if (daym<10)
     daym="0"+daym
  var hours=mydate.getHours()
  var minutes=mydate.getMinutes()
  var seconds=mydate.getSeconds()
  var dn="AM"
  if (hours>=12)
    dn="PM"
  if (hours>12)
    hours=hours-12
  if (hours==0)
     hours=12
  if (minutes<=9)
     minutes="0"+minutes
  if (seconds<=9)
     seconds="0"+seconds
//change font size here
//    var cdate="<font color='000000' face='Arial'><b>"+dayarray[day]+", "+montharray[month]+" "+daym+", "+year+" "+hours+":"+minutes+":"+seconds+" "+dn +"</b></font>"
   var cdate = dayarray[day]+", "+montharray[month]+" "+daym+", "+year+" "+hours+":"+minutes+":"+seconds+" "+dn
   if (g_bTimeOnly)
     cdate = "" + hours+":"+minutes+":"+seconds+" "+dn
   if (document.all)
      document.all.clock.innerHTML=cdate
   else if (document.getElementById)
      document.getElementById("clock").innerHTML=cdate
   else
      document.write(cdate)

   if (g_nTargetMiliseconds!=null)
      countdown();
}
if (!document.all&&!document.getElementById)
   getthedate()

function goforit(bTimeOnly)
{
  if (bTimeOnly!=null)
     g_bTimeOnly = bTimeOnly;

  if (document.all||document.getElementById)
    setInterval("getthedate()",1000)
}

/*
<span id="clock"></span>
<body onLoad="goforit()">
*/
function startCountdown(nSeconds)
{
  if (nSeconds>0 && g_nTargetMiliseconds==null)
  {
    Today = new Date();
    Todays_Year = Today.getFullYear() - 2000;
    Todays_Month = Today.getMonth() + 1;
    //Convert both today's date and the target date into miliseconds.
    var nTodayMiliseconds = (new Date(Todays_Year, Todays_Month, Today.getDate(), Today.getHours(), Today.getMinutes(), Today.getSeconds())).getTime();
    g_nTargetMiliseconds = nTodayMiliseconds + 1000*nSeconds;
//  countdown();
  }
}

function countdown()
{
  Today = new Date();
  Todays_Year = Today.getFullYear() - 2000;
  Todays_Month = Today.getMonth() + 1;
  //Convert both today's date and the target date into miliseconds.
  var nTodayMiliseconds = (new Date(Todays_Year, Todays_Month, Today.getDate(), Today.getHours(), Today.getMinutes(), Today.getSeconds())).getTime();
  //Find their difference, and convert that into seconds.
  var nTime_Left = Math.round((g_nTargetMiliseconds - nTodayMiliseconds) / 1000);
  var hours = Math.floor(nTime_Left / (60 * 60));
  nTime_Left %= (60 * 60);
  var minutes = Math.floor(nTime_Left / 60);
  nTime_Left %= 60;
  var seconds = nTime_Left;
  if (minutes<=9)
     minutes="0"+minutes;
  if (seconds<=9)
     seconds="0"+seconds;
  var cTime = "&nbsp;&nbsp;Time Left: <b>" + hours+":"+minutes+":"+seconds + "<b>";

  if (document.all)
     document.all.countdown.innerHTML=cTime
  else if (document.getElementById)
     document.getElementById("countdown").innerHTML=cTime
  else
     document.write(cTime);

   //Recursive call, keeps the clock ticking.
//   setTimeout('countdown();', 1000);
}

/*
function countdown_clock(year, month, day, hour, minute, format)
{
 //I chose a div as the container for the timer, but
 //it can be an input tag inside a form, or anything
 //who's displayed content can be changed through
 //client-side scripting.
  html_code = '<div id="countdown"></div>';

  document.write(html_code);

  countdown(year, month, day, hour, minute, format);
}

function countdown(year, month, day, hour, minute, format)
{
   Today = new Date();
   Todays_Year = Today.getFullYear() - 2000;
   Todays_Month = Today.getMonth() + 1;

   //Convert both today's date and the target date into miliseconds.
   Todays_Date = (new Date(Todays_Year, Todays_Month, Today.getDate(),
                           Today.getHours(), Today.getMinutes(), Today.getSeconds())).getTime();
   Target_Date = (new Date(year, month, day, hour, minute, 00)).getTime();

   //Find their difference, and convert that into seconds.
   Time_Left = Math.round((Target_Date - Todays_Date) / 1000);

   if(Time_Left < 0)
      Time_Left = 0;

   switch(format)
   {
   case 0:
        //The simplest way to display the time left.
        document.all.countdown.innerHTML = Time_Left + ' seconds';
        break;
   case 1:
        //More datailed.
        days = Math.floor(Time_Left / (60 * 60 * 24));
        Time_Left %= (60 * 60 * 24);
        hours = Math.floor(Time_Left / (60 * 60));
        Time_Left %= (60 * 60);
        minutes = Math.floor(Time_Left / 60);
        Time_Left %= 60;
        seconds = Time_Left;

        dps = 's'; hps = 's'; mps = 's'; sps = 's';
        //ps is short for plural suffix.
        if(days == 1) dps ='';
        if(hours == 1) hps ='';
        if(minutes == 1) mps ='';
        if(seconds == 1) sps ='';

        document.all.countdown.innerHTML = days + ' day' + dps + ' ';
        document.all.countdown.innerHTML += hours + ' hour' + hps + ' ';
        document.all.countdown.innerHTML += minutes + ' minute' + mps + ' and ';
        document.all.countdown.innerHTML += seconds + ' second' + sps;
        break;
   default:
        document.all.countdown.innerHTML = Time_Left + ' seconds';
   }

   //Recursive call, keeps the clock ticking.
   setTimeout('countdown(' + year + ',' + month + ',' + day + ',' + hour + ',' + minute + ',' + format + ');', 1000);
}
*/
