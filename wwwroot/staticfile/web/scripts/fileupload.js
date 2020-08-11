<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function loadStatusPage(form, sJsp)
{
  try {
//alert("sFilename=" + form.browserfile.value);
    if (checkFieldEmpty(form.browserfile))
    {
      alert("You have to browse a file first.");
      setFocus(form.browserfile);
      return false;
    }

    var sFilename = form.browserfile.value;
    popuphwin = dhtmlmodal.open('UploadStatus', 'IFRAME', 'ser/uploadstatus.jsp?filename='+sFilename+"&ajaxjsp="+sJsp, 'File Uploading Status', 'width=540px,height=180px,center=1,resize=0,scrolling=0');
    return false;
  } catch(ex) {}
  return false;
}

function testLoadPage(sJsp)
{
  try {
//alert("sFilename=" + form.browserfile.value);
    popuphwin = dhtmlmodal.open('UploadStatus', 'IFRAME', sJsp, 'File Uploading Status', 'width=540px,height=180px,center=1,resize=0,scrolling=0');
    return false;
  } catch(ex) {}
  return false;
}


