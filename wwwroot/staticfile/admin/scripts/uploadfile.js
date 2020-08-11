var g_uf_nCountOfTimes = 0;
var g_uf_sFilename;
var g_uf_nIdleInterval = 2*1000;
var g_uf_sCheckUrl = "/uploadfile?action=status&type=object";
var g_uf_sStatusArea;
var g_uf_bStop = false;

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
  }
  if (nSeconds!=null)
     g_uf_nIdleInterval = nSeconds*1000;
  if (sUrl!=null)
     g_uf_sCheckUrl = sUrl;
  if (sStatusArea!=null)
     g_uf_sStatusArea = sStatusArea;

  var objStatus = null;
  var sRequest = g_uf_sCheckUrl + "&count="+g_uf_nCountOfTimes + "&time="+new Date().getTime();
  g_uf_nCountOfTimes++;

  displayStatus(sRequest);

  if ((objStatus==null || objStatus.currentStatus<3) && (g_uf_bStop==false))
     setTimeout('repeatCheck()', g_uf_nIdleInterval);

  return true;
}

function stopUpload()
{
  g_uf_bStop = true;
  var sRequest = g_uf_sCheckUrl + "&count="+g_uf_nCountOfTimes + "&stop=yes&time="+new Date().getTime();
  displayStatus(sRequest);
}

function displayStatus(sRequest)
{
  //alert(sRequest);
  var sResponse = getHttpContent(sRequest);
  if (sResponse!=null&&sResponse.length>0)
  {
//alert("sResponse=" + sResponse);
     try {
     objStatus = eval('('+sResponse+')');
     showStatus(objStatus);
    }
    catch(ex)
    {
    //alert("Error=" + sResponse + "," + ex.message)
    }
  }
}

function showStatus(objStatus)
{
  var sDesc = "<table width=100%>";
  if (objStatus.currentStatus<3)
  {
      sDesc += "<tr class='prog-text'>";
      sDesc += "<td colspan=2>Uploading: ";
      sDesc += "<b>" + g_uf_sFilename + "</b>";
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

      if (g_uf_bStop==false)
      {
        sDesc += "<tr class='prog-text'>";
        sDesc += "<td colspan=2 align='center' height='10'></td>";
        sDesc += "</tr>";
        sDesc += "<tr class='prog-text'>";
        sDesc += "<td colspan=2 align='center'><input type='button' name='Button' value='Cancel' onClick='javascript:stopUpload()' style='WIDTH:80px'></td>";
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

function getHttpContent(sUrl)
{
    var xmlhttp;
/*
    if (navigator.appName == "Microsoft Internet Explorer")
       xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    else
       xmlhttp = new XMLHttpRequest();
*/
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