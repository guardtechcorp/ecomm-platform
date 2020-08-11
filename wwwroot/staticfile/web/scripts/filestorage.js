<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onFileFormLoad(form, form2)
{
  showSelection(form, form2);
}

function showSelection(form, form2)
{
  var nTotalSelected = 0;
  form2.selections.value = "";
  for (var i=0;i<form.elements.length;i++)
  {
    var e = form.elements[i];
    if ((e.name!= "allbox") && (e.type=='checkbox'))
    {
       if (e.checked)
       {
         nTotalSelected++;
         if (form2.selections.value.length>0)
            form2.selections.value += ',';
         form2.selections.value += e.name;
       }
    }
  }

//alert("nTotalSelected=" + nTotalSelected);    
  if (nTotalSelected==0)
    document.getElementById('totalselection').innerHTML = ".";
  else if (nTotalSelected==1)
    document.getElementById('totalselection').innerHTML = "&nbsp;with <font color='#000000'><b>"+ nTotalSelected + "</b></font> is selected.";
  else
    document.getElementById('totalselection').innerHTML = "&nbsp;with <font color='#000000'><b>"+ nTotalSelected + "</b></font> are selected.";

   form2.downloadselection.disabled=(nTotalSelected>0?"":"true");
   form2.deleteselection.disabled=(nTotalSelected>0?"":"true");
   form2.renamefile.disabled = (nTotalSelected==1?"":"true");
   form2.movefiles.disabled = (nTotalSelected>0?"":"true");
   form2.uploadfile.disabled = (form2.browserfile.value.length>0?"":"true");
 }

function clickCheckBox(objCheckBox, form, form2)
{
  highlightCheckedRow(objCheckBox);
  showSelection(form, form2);
}

function checkAll(obj, form, form2)
{
  for (var i=0; i<form.elements.length; i++)
  {
    var e = form.elements[i];
    if ((e.name !=  obj.name) && (e.type=='checkbox'))
    {
       if (e.checked != obj.checked)
         e.click();

       highlightCheckedRow(e);
    }
  }

  showSelection(form, form2);
}

function validateDownloadZip(form2, sAction)
{
try {
  if (form2.selections.value.length=0)
  {
    alert("You have to at least select one file or one folder.");
    return false;
  }

  setAction(form2, 'DownloadZip_Command_FileStorage');
//  showProcessBar();

//alert("form2.selections.value=" + form2.selections.value);
   return true;
 }
 catch (ex)
 {
   showException(ex, "validateDonwloadZip()");
   return false;
 }
}

function validateDeleteFiles(form2, sAction)
{
try {
   if (form2.selections.value.length=0)
   {
      alert("You have to at least select one file or one folder.");
      return false;
   }

   if (!confirm('Do you really want to delete all of selected files or folders?'))
      return false;

   form2.target = null; 

   setAction(form2, 'DeleteFiles_Command_FileStorage');
   showProcessBar();

   return true;
}
catch (ex)
{
  showException(ex, "validateDeleteFiles()");
  return false;
}
}

function onBrowserFileDone(form2, sFilename)
{
//alert("sFilename=" + sFilename);
  try {
  var sTargetName = sFilename.replace(/\\/g, "/");
  var nIndex = sTargetName.lastIndexOf("/");
  sTargetName = sTargetName.substring(nIndex+1)
  form2.filefolder.value = sTargetName;
  form2.uploadfile.disabled = "";
  form2.createfile.disabled = "true";
//  document.getElementById("filename_label").innerHTML = "Target File Name:";
  }
  catch (ex)
  {
    showException(ex, "onBrowserFileDone()");
    return false;
  }
}

function validateUploadFile(form2, sAction, sAjaxUrl)
{
  try {
//alert("sFilename=" + sFilename);
    setAction(form2, 'UploadFile_Command_FileStorage');
    if (checkFieldEmpty(form2.browserfile))
    {
      alert("You have to browse a file first.");
      setFocus(form2.browserfile);
      return false;
    }

//testLoadPage(null);
//    loadStatusPage(form2.browserfile.value);
    var sFilename;
    if (form2.filefolder.value.length==0)
       sFilename = form2.browserfile.value;
    else
       sFilename = form2.filefolder.value;

//    var sRet = getUrlContent(sAjaxUrl+"&filename=" + sFilename);
    var sRet = postUrlContent(sAjaxUrl, "filename=" + sFilename);

    if (sRet=="1")
    {
       if (!confirm("The folder already contains a file named '" + sFilename + "'. \n\nWould you like to replace the existing file?\n\n  "))
          return false;
    }

    showStatusPage(form2.browserfile.value, 'statusarea');

    return true;
  }
  catch (ex)
  {
    showException(ex, "validateUploadFile()");
    return false;
  }
}

function onTypeName(form2, sName)
{
   if (!checkFieldEmpty(form2.browserfile))// || sName.length==0)
      return;
   
   form2.createfile.disabled = sName.length==0?"true":"";
}

function validateCreateFolder(form2, sAction)
{
try {
  if (checkFieldEmpty(form2.filefolder))
  {
    alert("You have to enter a folder name.");
    setFocus(form2.filefolder);
    return false;
  }

  form2.target = null;

  setAction(form2, 'CreateFolder_Command_FileStorage');
  showProcessBar();
  return true;
 }
 catch (ex)
 {
  showException(ex, "validateCreateFiles()");
  return false;
 }
}

function validateRenameFile(form2, sAction)
{
  try {
   if (form2.selections.value.length=0)
   {
      alert("You have to at least select one file or one folder.");
      return false;
   }

  if (checkFieldEmpty(form2.filefolder))
  {
    alert("You have to enter a file or folder name.");
    setFocus(form2.filefolder);
    return false;
  }

  form2.target = null;

  setAction(form2, 'RenameFile_Command_FileStorage');
  showProcessBar();

   return true;
 }
 catch (ex)
 {
    showException(ex, "validateRenameFile()");
    return false;
 }
}

function validateMoveFiles(form2, sAction)
{
 try {
   if (form2.selections.value.length=0)
   {
     alert("You have to at least select one file or one folder.");
     return false;
   }

   if (checkFieldEmpty(form2.filefolder))
   {
    alert("You have to enter a folder name.");
    setFocus(form2.filefolder);
    return false;
   }

   form2.target = null;

   setAction(form2, 'MoveFiles_Command_FileStorage');
   showProcessBar();

   return true;
 }
 catch (ex)
 {
    showException(ex, "validateMoveFiles()");
    return false;
 }
}

function validateUnpack()
{
  showProcessBar();

  return true;
}

function showShareWin(form, layerId, obj, sFilename, bFolder)
{
//alert("sFilename=" + sFilename);
  var floatwin = document.getElementById(layerId);
//alert("left =" + obj+","+obj.offsetLeft+","+obj.offsetTop);//getposOffset1(obj, "left"));
  floatwin.style.display = 'block';
  floatwin.style.left    = getLinkOffset(obj, "left")- 500;
  floatwin.style.top     = getLinkOffset(obj, "top")+18;

  if (bFolder)
     document.getElementById('share_title').innerHTML = "<B><FONT size=3 color='#000000'>Share the folder '<font color='#4959A7'>"+ sFilename + "</font>' to your friend(s)</FONT></B>";
  else
     document.getElementById('share_title').innerHTML = "<B><FONT size=3 color='#000000'>Share the file '<font color='#4959A7'>" + sFilename + "</font>' to your friend(s)</FONT></B>";

  if (form.subject.value.length==0)
  {
     if (bFolder)
        form.subject.value = "Share a folder with you. And you can download it as a zipped file."
     else
        form.subject.value = "Share a file with you. And you can download it now."
  }
  if (form.content.value.length==0)
  {
//     form.content.value = "Hi, \n\nHere is the file(s) you want. Please click the link below and download it as soon as possible. \n\nBye."
//     form.content.value += "\n\n" +form.yourname.value; 
  }

  document.getElementById('id_message').innerHTML = "";
  form.submit.disabled = "";

  form.filename.value = sFilename;
    
  setFocus(form.emails);
}

function hideShareWin(layerId)
{
  var floatwin = document.getElementById(layerId);
  floatwin.style.display = 'none';
}

/*
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
*/

function onAccessModeChange(form)
{
   form.unlockcode.disabled = form.accessmode.selectedIndex<2?"true":"";
   if (form.accessmode.selectedIndex==2)
      setFocus(form.unlockcode);    
}

function onValidateShareFile(form, sUrl)
{
try
 {
  form.memberids.value = getMultipleCheckboxIds(form, "mb_", ',');
  if (form.memberids.value.length==0)
  {
      if (checkFieldEmpty(form.emails))
      {
        alert("You have to input at least one email address or select one of members.")
        setFocus(form.emails);
        return false;
      }
  }

  if (!checkFieldEmpty(form.emails))
  {
      var pattern = /\s*,\s*/;
      var arEmail = form.emails.value.split(pattern);
      for (var i=0; i<arEmail.length; i++)
      {
    //alert("sEmail=" + arEmail[i]);
        if (!validateEmailValue(arEmail[i]))
        {
           setFocus(form.emails);
           return false;
        }
      }
   }

  if (checkFieldEmpty(form.subject))
  {
     alert("You have to input subject.")
     setFocus(form.subject);
     return false;
  }

//alert("form.memberids.value=" + form.memberids.value);
  form.submit.disabled = "true";

  var sRequest = getFormQuery(form);//  + "&time="+new Date().getTime();
//alert("sRequest=" + sRequest);
  var sResponse = postUrlContent(sUrl, sRequest);

  var arReturn = sResponse.split("<!--!>");
//alert("sResponse=" + sResponse+"!");
  document.getElementById('id_message').innerHTML = arReturn[1];

  if ("0"!=arReturn[0])
     form.submit.disabled = "";

  return false;
 }
 catch (ex)
 {
//   alert("An exception occurred in the functon: onValidateShareFile()\nError name: " + e.name + "\nError message: " + e.message);
   showException(ex, "onValidateShareFile()");
   return false;
 }
}

function checkAllMember(form, obj)
{
  for (var i=0; i<form.elements.length; i++)
  {
    var e = form.elements[i];
    if ((e.name!=obj.name) && (e.type=='checkbox') && e.name.indexOf("mb_")==0)
    {
       if (e.checked != obj.checked)
         e.click();
    }
  }
}

function loadModallessWindow()
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
//      window.location.href = g_sPrevUrl;
      return true;//returnval;
    }

  } catch(ex) {
    showException(ex, "loadStatusPage()");
  }
}

function closeStatusWindow()
{
//alert("parent.g_popupwin=" + parent.g_popupwin);
 /*
    var bClose = unescape(getQueryVariable("close"));
    if ("y"==bClose){
        document.getElementById("favorite_close").value = bClose;
        parent.favoritewindow.hide();
*/
  if (parent.g_popupwin!=null)
     parent.g_popupwin.hide();   //close();
}

function onEditFileFormLoad(form, bClose)
{
  if (bClose)
  {
     closeModalWin();
  }
  else
    form.title.focus();
}

function onValidateEditFile(form)
{
    if (checkFieldEmpty(form.title))
    {
       alert("You have to input title");
       setFocus(form.title);
       return false;
    }

    return true;
}

function onUploadFileFormLoad(form)
{
  setFocus(form.browserfile);
}

function onBrowserNewFile(form, sFilename)
{
//alert("sFilename=" + sFilename);
  try {
  var sTargetName = sFilename.replace(/\\/g, "/");
  var nIndex = sTargetName.lastIndexOf("/");
  sTargetName = sTargetName.substring(nIndex+1)
  form.file_name_0.value = sTargetName;
  setFocus(form.file_title_0);    
  }
  catch (ex)
  {
    showException(ex, "onBrowserNewFile()");
    return false;
  }
}

function validateUploadStorageFile(form, sFileType, sAjaxUrl)
{
  try {
    if (checkFieldEmpty(form.browserfile))
    {
      alert("You have to browse a file first.");
      setFocus(form.browserfile);
      return false;
    }

    if (!checkUploadFileType(form.browserfile, sFileType))
    {
      setFocus(form.browserfile);
      return false;
    }

    var sFilename;
    if (form.file_name_0.value.length==0)
       sFilename = form.browserfile.value;
    else
       sFilename = form.file_name_0.value;

    var sRet = getUrlContent(sAjaxUrl+"&filename=" + sFilename);
    if (sRet=="1")
    {
       alert("It already contains a file named '" + sFilename + "'. \n\nYou can not overwrite it with the same file name.\n\nPlease try to use a different Tagert File Name.\n\n");
       setFocus(form.file_name_0);
       return false;
    }

    showStatusPage(form.browserfile.value, 'statusarea');

    return true;
  }
  catch (ex)
  {
    showException(ex, "validateUploadStorageFile()");
    return false;
  }
}

