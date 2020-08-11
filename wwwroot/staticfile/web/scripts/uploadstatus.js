var g_uf_nCountOfTimes = 0;
var g_uf_sFilename;
var g_uf_nIdleInterval = 2*1000;
var g_uf_sCheckUrl = "/uploadfile?action=status&type=object";
var g_uf_percentComplete = 0;
var g_uf_sStatusArea;
var g_uf_bStop = false;
var g_objStatus = null;
var g_popupwin = null;
var g_sPrevUrl;

function loadStatusPage(sFilename)
{
  try {
    var sUrl;
    if (window.location.href.indexOf("/ctr/")!=-1)
       sUrl = '/ctr/web/ser/util/uploadstatus.jsp?filename='+sFilename;
    else
       sUrl = '/web/ser/util/uploadstatus.jsp?filename='+sFilename;

    g_sPrevUrl = window.location.href;
//    var nIndex = window.location.href.indexOf("/web/");
//    sUrl = window.location.href.substring(0, nIndex) + '/web/ser/util/uploadstatus.jsp?filename='+sFilename;
//alert("sUrl=" + sUrl);
    g_popupwin = dhtmlmodal.open('UploadStatus', 'IFRAME', sUrl, 'File Uploading Status', 'width=540px,height=180px,center=1,resize=0,scrolling=0');
//    modalWin(sUrl, 540, 180);
    g_popupwin.onclose=function()
    {
//       var returnval=confirm("You are about to close this window. Are you sure?");
window.location.href = g_sPrevUrl;
      return true;//returnval;
    }

  } catch(ex) {
    showException(ex, "loadStatusPage()");
  }
}

function showStatusPage(sFilename, sShowArea)
{
  try {
//    showHideSpan('close','WorkingSection');  showHideSpan('open','HideUploadProcessing');
    doProcess('MaskUploadProcessing', 'MainPageTable');//'MainPageArea');

    var sUrl;
    if (window.location.href.indexOf("/ctr/")!=-1)
       sUrl = '/ctr/web/ser/util/uploadstatus.jsp?action=GetStatus&type=object&filename='+sFilename;
    else
       sUrl = '/web/ser/util/uploadstatus.jsp?action=GetStatus&type=object&filename='+sFilename;

    repeatCheck(sFilename, 1, sUrl, sShowArea);

  } catch(ex) {
    showException(ex, "showStatusPage()");
  }
}

function closeStatusWindow()
{
//alert("parent.g_popupwin=" + parent.g_popupwin);
  if (parent.g_popupwin!=null)
     parent.g_popupwin.hide();   //close();
}

function testLoadPage(sJsp)
{
    var sUrl
    if (window.location.href.indexOf("/ctr/")!=-1)
       sUrl = '/ctr/web/ser/util/uploadstatus.jsp?filename=test.html';
    else
       sUrl = '/web/ser/util/uploadstatus.jsp?filename=test.html';

  popupwin = dhtmlmodal.open('UploadStatus', 'IFRAME', sUrl, 'File Uploading Status', 'width=540px,height=180px,center=1,resize=0,scrolling=0');
  popupwin.onclose=function()
  {
   var returnval=confirm("You are about to close this window. Are you sure?");
   return returnval;
  }
}

function repeatCheck(sFilename, nSeconds, sUrl, sStatusArea)
{
  if (sFilename!=null)
  {
     if (sFilename.length==0)
     {
        alert("You have to browse a file first.");
        return false;
     }
     g_uf_sFilename = sFilename;
     g_uf_bStop = false;
     g_uf_nCountOfTimes = 0;
     g_objStatus = null;
  }
  if (nSeconds!=null)
     g_uf_nIdleInterval = nSeconds*1000;
  if (sUrl!=null)
     g_uf_sCheckUrl = sUrl;
  if (sStatusArea!=null)
     g_uf_sStatusArea = sStatusArea;

  var sRequest = g_uf_sCheckUrl + "&count="+g_uf_nCountOfTimes;
  if (g_uf_nCountOfTimes>0 && g_objStatus!=null)
  {
     sRequest += "&completed=" + g_objStatus.percentComplete;
     g_uf_percentComplete = g_objStatus.percentComplete;
  }
  else
     sRequest += "&completed=0";
  sRequest += "&time="+new Date().getTime();

  g_uf_nCountOfTimes++;
  displayStatus(sRequest);

  if ((g_objStatus==null || g_objStatus.currentStatus<3) && (g_uf_bStop==false))
     setTimeout('repeatCheck()', g_uf_nIdleInterval);

//alert("window.location=" + window.location.href);
  return true;
}

function stopUpload(objButton)
{
  objButton.disabled = "true";

  document.getElementById("uf_errormessage").innerHTML = "<font color='red' size='2'>You just canceled the uploading process.</font>";

  g_uf_bStop = true;
  var sRequest = g_uf_sCheckUrl + "&count="+g_uf_nCountOfTimes + "&completed=" + g_uf_percentComplete + "&stop=yes&time="+new Date().getTime();
  displayStatus(sRequest);

  var sUrl = new String(window.location);
 //alert("window.location=" + sUrl + "&stopupload=yes");
  window.location.href = sUrl + "&stopupload=yes&error=You just canceled the uploading process.";
}

function displayStatus(sRequest)
{
  var sResponse = getUploadContent(sRequest);
//alert("sResponse=" + sResponse);
  if (sResponse!=null&&sResponse!="false")
  {
     try {
     g_objStatus = eval('('+sResponse+')');
     showStatus2(g_objStatus);
    }
    catch(ex)
    {
//alert("sResponse=" + sResponse + "!" + sResponse.length);
      showException(ex, "displayStatus()");
    }
  }
}

function showStatus(objStatus)
{
  var sDesc = "<table width=100%>";
  if (objStatus.currentStatus<3)
  {
      sDesc += "<tr class='prog-text'>";
      sDesc += "<td height='30' colspan=2 valign='top'>Uploading: ";
      sDesc += "<font color='blue'><b>" + g_uf_sFilename + "</b></font>";
      sDesc += "</td></tr>";
      sDesc += "<tr><td colspan=2>";
      sDesc += "<div class=\"prog-border\"><div class=\"prog-bar\" style=\"width: " + objStatus.percentComplete + "%;\"><div align='center'>"+objStatus.percentComplete+"%</div></div></div>";
      sDesc += "</td></tr>";

      sDesc += "<tr class='prog-text'>";
      sDesc += "<td >Received: <b>" + Math.round(objStatus.bytesProcessed/1024) + "</b> K</td>";
      sDesc += "<td align=right>Total Bytes: <b>" + Math.round(objStatus.sizeTotal/1024) + "</b> K</td>";
      sDesc += "</tr>";

      sDesc += "<tr class='prog-text'>";
      sDesc += "<td>Transmission Rate: <b>" + Math.round(objStatus.uploadRate/1024) + "</b> Kbs</td>";
      sDesc += "<td align=right>Estmated Time: <b>" + formatTime(objStatus.estimatedRuntime) + "</b></td>";
      sDesc += "</tr>";

      sDesc += "<tr class='prog-text'>";
      sDesc += "<td>Elapsed Time: <b>" + formatTime(objStatus.timeInSeconds)+ "</b></td>";
      sDesc += "<td align=right>Time Remaining: <b>" + formatTime(objStatus.remainingTime)+ "</b></td>";
      sDesc += "</tr>";

//      if (g_uf_bStop==false)
      {
        sDesc += "<tr class='prog-text'>";
        sDesc += "<td colspan=2 align='center' height='10'></td>";
        sDesc += "</tr>";
        sDesc += "<tr class='prog-text'>";
        sDesc += "<td colspan=2 align='center'><input type='button' id='bt_cancel' name='bt_cancel' value='Cancel' onClick='javascript:stopUpload()' style='WIDTH:80px'></td>";
        sDesc += "</tr>";
      }
   }
   else if (objStatus.currentStatus==3)
   {
      sDesc += "<tr class='prog-text'><td colspan=2>";
      sDesc += "Uploading file is completed: " + "<b>" + g_uf_sFilename + "</b>";
      sDesc += "</td></tr>";

      sDesc += "<tr class='prog-text'>";
      sDesc += "<td>Total bytes was transferred: <b>" + objStatus.sizeTotal + ' (' + Math.round(objStatus.sizeTotal/1024) + " K)</b></td>";
      sDesc += "<td>Total time was spent: <b>" + formatTime(objStatus.timeInSeconds)+ "</b></td>";
      sDesc += "</tr>";

      g_uf_bStop = true;
      document.getElementById("bt_cancel").disabled = true;


      sDesc += "<tr class='prog-text'>";
      sDesc += "<td colspan=2 align='center' height='40'></td>";
      sDesc += "</tr>";
      sDesc += "<tr class='prog-text'>";
      sDesc += "<td colspan=2 align='center'><input type='button' name='Button' value='Close' onClick='javascript:closeStatusWindow()' style='WIDTH:80px'></td>";
      sDesc += "</tr>";
//closeStatusWindow();

   }
   else// if (objStatus.currentStatus==4)
   {
      sDesc += "<tr class='prog-text'><td>";
      sDesc += "Uploading file was failed: " + "<b>" + g_uf_sFilename + "</b>";
      sDesc += "</td></tr>";

      sDesc += "<tr class='prog-text'>";
      sDesc += "<td>Reason: <b><font color='red'>" + objStatus.currentError + "</font></b></td>";
	  sDesc += "</tr>";
   }
   sDesc += "</table>";

   showStatusText(sDesc);
}

function showStatus2(objStatus)
{
  document.getElementById("uf_filename").innerHTML = g_uf_sFilename;
  document.getElementById("uf_barpercent").style.width = "" +  objStatus.percentComplete + "%";  
  document.getElementById("uf_textpercent").innerHTML = "" + objStatus.percentComplete + '%';
  document.getElementById("uf_receivedbytes").innerHTML = "" + Math.round(objStatus.bytesProcessed/1024);
  document.getElementById("uf_totalbytes").innerHTML = "" + Math.round(objStatus.sizeTotal/1024);
  document.getElementById("uf_rate").innerHTML = "" + Math.round(objStatus.uploadRate/1024);
  document.getElementById("uf_estimatedtime").innerHTML = "" + formatTime(objStatus.estimatedRuntime);
  document.getElementById("uf_elapsedtime").innerHTML = "" + formatTime(objStatus.timeInSeconds);
  document.getElementById("uf_timeremain").innerHTML = "" + formatTime(objStatus.remainingTime);
//alert("objStatus.currentStatus=" + objStatus.currentStatus);
  if (objStatus.currentStatus==3)
  {
      g_uf_bStop = true;
      document.getElementById("bt_cancel").disabled = true;
  }
  else if (objStatus.currentStatus==4)
  {
     document.getElementById("uf_errormessage").innerHTML = "<font color='red'>" +  objStatus.currentError + "</font>";
     document.getElementById("bt_cancel").disabled = true;

      var sUrl = new String(window.location);
      window.location.href = sUrl + "&stopupload=yes&error=" + objStatus.currentError;
  }
}

function showStatusText(sContent)
{
//  window.status = sContent;
  document.getElementById(g_uf_sStatusArea).innerHTML = sContent
}

function formatTime(timeInSeconds)
{
  var seconds = Math.floor(timeInSeconds)%60;
  var minutes = Math.floor(timeInSeconds/60.0);
  var hours = Math.floor(minutes/60.0);
  minutes = minutes%60;

  var sTime;
  if (hours<10)
     sTime = "0"+hours + ":";
  else
     sTime = ""+hours + ":";

  if (minutes<10)
     sTime += '0' + minutes + ":";
  else
     sTime += minutes + ":";

  if (seconds<10)
     sTime += '0' + seconds;
  else
     sTime += seconds;

 return sTime;
}

function getUploadContent(sUrl)
{
//alert("sUrl=" + sUrl);
    var xmlhttp;
    if (window.XMLHttpRequest)
    { // Mozilla, Safari,...
       xmlhttp = new XMLHttpRequest();
    }
    else if (window.ActiveXObject)
    { // IE
      try { // ??? IE
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
      }
      catch (e)
      {
        try { // ??? IE
          xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {}
      }
    }

    xmlhttp.open("Get", sUrl, false);
    xmlhttp.send(null);

    strDoc = xmlhttp.responseText;

//alert("strDoc=" + strDoc);
    return strDoc;
}