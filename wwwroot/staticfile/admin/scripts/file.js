<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

var m_nTotalSelection = 0;
function onFileFormLoad(form, nTotal)
{
  m_nTotalSelection = nTotal;
  showSelection(form);
}

function showSelection(form)
{
//   if (eval("document.all.totalselection")!=null)
   if (m_nTotalSelection>0)
     document.getElementById('totalselection').innerHTML = "&nbsp;with <font color='#ffff00'><b>"+ m_nTotalSelection + "</b></font> is selected.";
   else
     document.getElementById('totalselection').innerHTML = ".";
/*
   if (m_nTotalSelection==1)
     form.rename.disabled="";
   else
     form.rename.disabled="true";
*/
}

function clickCheckBox(objCheckBox, form2)
{
  highlightCheckedRow(objCheckBox)
  if (objCheckBox.checked)
     m_nTotalSelection++;
  else
     m_nTotalSelection--;

  showSelection(form2);
}

function checkAll(form, obj, form2)
{
  var nBefore = 0;
  for (var i=0;i<form.elements.length;i++)
  {
      var e = form.elements[i];
      if ((e.name!= obj.name) && (e.type=='checkbox'))
      {
         if (e.checked)
            nBefore++;
      }
  }

  selectAll(form, obj);

  var nAfter = 0;
  for (var i=0;i<form.elements.length;i++)
  {
      var e = form.elements[i];
      if ((e.name !=  obj.name) && (e.type=='checkbox'))
      {
         if (e.checked)
            nAfter++;
      }
   }

   m_nTotalSelect += (nAfter - nBefore);
   showSelection(form2);
}

function validateDownloadZip(form)
{
  if (m_nTotalSelection>0)
     return true;
  else
  {
    alert("You have to at least select one file or folder.");
    return false;
  }
}

function validateDeleteFiles(form)
{
  if (m_nTotalSelection>0)
     return confirm('Do you really want to delete all of selected files or folders?');
  else
  {
    alert("You have to at least select one file or folder.");
    return false;
  }
}

function validateDeleteFiles(form)
{
  if (m_nTotalSelection>0)
     return confirm('Do you really want to delete all of selected files or folders?');
  else
  {
    alert("You have to at least select one file or folder.");
    return false;
  }
}

function validateUpload(form)
{
  if (checkFieldEmpty(form.browserfile))
  {
    alert("You have to browse a file first.");
    setFocus(form.browserfile);
    return false;
  }

  showHideSpan('close','listcommand');
  showHideSpan('open','Processing');

  return true;
}


function validateCreateFolder(form)
{
  if (checkFieldEmpty(form.filefolder))
  {
    alert("You have to enter a folder name.");
    setFocus(form.filefolder);
    return false;
  }

  showHideSpan('close','listcommand');
  showHideSpan('open','Processing');

  return true;
}

function validateRenameFile(form)
{
  if (m_nTotalSelection<=0)
  {
    alert("You have to select only one file or folder to rename.");
    return false;
  }

  if (checkFieldEmpty(form.filefolder))
  {
    alert("You have to enter a file or folder name.");
    setFocus(form.filefolder);
    return false;
  }

  showHideSpan('close','listcommand');
  showHideSpan('open','Processing');

  return true;
}

function validateMoveFiles(form)
{
  if (m_nTotalSelection<=0)
  {
    alert("You have to at least select one file or folder.");
    return false;
  }

  if (checkFieldEmpty(form.filefolder))
  {
    alert("You have to enter a folder name.");
    setFocus(form.filefolder);
    return false;
  }

  showHideSpan('close','listcommand');
  showHideSpan('open','Processing');

  return true;
}

function validateUnpack()
{
  showHideSpan('close','listcommand');
  showHideSpan('open','Processing');

  return true;
}

function validatevalidateSelection(form1, form2)
{
   var sSelect = "";
   for (var i=0;i<form2.elements.length;i++)
   {
      var e = form2.elements[i];
      if ((e.name !=  "allbox") && (e.type=='checkbox'))
      {
       if (e.checked)
       {
         if (sSelect.length>0)
         {
           sSelect += ",";
         }
         sSelect += e.name;
       }
      }
   }

   form1.lastselection.value = sSelect;
//alert("Last selection =" + sSelect);
   return true;
}

function submitGoto(form, action, name)
{
   form.action.value = action;
   form.filename.value = name;
   form.submit();
}

function OnSelectWorkAreaChange(form)
{
   form.action.value = "workarea";
   form.submit();
}

function loadStatusPage(form, sJsp){
  try {
//alert("sFilename=" + sFilename);
    if (checkFieldEmpty(form.browserfile))
    {
      alert("You have to browse a file first.");
      setFocus(form.browserfile);
      return false;
    }

    var sFilename = form.browserfile.value;
    popuphwin = dhtmlmodal.open('UploadStatus', 'IFRAME', '../file/uploadstatus.jsp?filename='+sFilename+"&ajaxjsp="+sJsp, 'File Uploading Status', 'width=540px,height=180px,center=1,resize=0,scrolling=0');
    return true;
  } catch(ex) {}
  return false;
}
