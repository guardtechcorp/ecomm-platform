<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->
var g_bCreateContentEdit = false;
var g_bCreateContentEdit2 = false;
function onWebPageFormLoad(form, bCreate)
{
    var nSelected = form.type.options[form.type.selectedIndex].value;
    if (nSelected==0)
    {
       createToolbar('content', 720, 400, ",7,14,26,32,");
       g_bCreateContentEdit = true;
    }
    else if (nSelected=11||nSelected==12)
    {
       createToolbar('description', 710, 160, ",7,15,16,17,32,");
       g_bCreateContentEdit2 = true;        
    }

    if (form.showway[1].checked && form.useframe!=null)
    {
       form.useframe[0].click();
       form.useframe[1].disabled = "true";
    }

//alert("form.name.type=" + form.name.type);
    if (form.name.type!="hidden")
      setFocus(form.name);    
    else
      setFocus(form.title);
}

function onSelectTypeChange(form)
{
 try
  {
   var nSelected = form.type.options[form.type.selectedIndex].value;
   showHideSpan(nSelected==0?'open':'close','editinplace_section');
   showHideSpan(nSelected==1?'open':'close','embed_section');
   showHideSpan(nSelected==2?'open':'close','uploadfile_section');
   showHideSpan(nSelected==3?'open':'close','linkurl_section');
   showHideSpan(nSelected==4?'open':'close','filestorage_section');
   showHideSpan((nSelected==11||nSelected==12)?'open':'close','feature_section');
   showHideSpan(nSelected==13?'open':'close','onlinemessage_section');
   showHideSpan(nSelected==14?'open':'close','contactus_section');

   document.getElementById("id_showway_1").disabled = nSelected==13?true:false;
   document.getElementById("id_showway_2").disabled = nSelected==13?true:false;   
   if (nSelected)
      document.getElementById("id_showway_0").checked = true;

   if (nSelected==0)
   {
      if (!g_bCreateContentEdit)
      {
        createToolbar('content', 720, 400, ",7,14,26,32,"); //32 for abc check
        g_bCreateContentEdit = true;
      }
//      form.content.focus();
   }
   else if (nSelected==1)
    form.embedcode.focus();
   else if (nSelected==2)
    form.uploadfile.focus();
   else if (nSelected==3)
    form.linkurl.focus();
   else if (nSelected==4)
    form.filestorage.focus();
   else if (nSelected==11|| nSelected==12)
   {
       if (!g_bCreateContentEdit2)
       {
         createToolbar('description', 710, 160, ",7,15,16,17,32,");
         g_bCreateContentEdit2 = true;
       }
       if (nSelected==11)
         document.getElementById("feature_note").innerHTML = "The below content will be displaying on the top of feedback form.";
       else// if (nSelect==6)
         document.getElementById("feature_note").innerHTML = "The below content will be a default Tell-Friends' E-Mail body content.";

       form.description.focus();
   }
 }
 catch (ex)
 {
   showException(ex, "onSelectTypeChange()");
   return false;
 }
}

function onShowBrowser(form, bShowBroswer)
{
  if (bShowBroswer)
  {
    form.useframe[0].click();
    form.useframe[1].disabled = "true";
  }
  else
  {
    form.useframe[1].disabled = "";              
  }
}

function validateWebPage(form, nFrontFileMaxSize, sEditorId)
{
    try
     {
     if (checkFieldEmpty(form.name))
     {
        alert("You have to enter name of link.");
        setFocus(form.name);
        return false;
     }

     var nSelected = form.type.options[form.type.selectedIndex].value;
     if (nSelected==0)
     {
        updateTextArea(sEditorId);
        if (form.content.value.length<5)
        {
          alert("You have to input some content.");
          form.content.focus();
          return false;
        }
     }
     else if (nSelected==1)
     {
        if (form.embedcode.value.length==0)
        {
           alert("You have to input embed code.");
           form.embedcode.focus();
           return false;
        }
     }
     else if (nSelected==2)
     {
        var nFileId = parseInt(form.uploadfileid.value);
        if (nFileId==0 && form.uploadfile.value.length==0)
        {
           alert("You have to browser a file.");
           form.uploadfile.focus();
           return false;
        }
     }
     else if (nSelected==3)
     {
        if (form.linkurl.value.length==0)
        {
           alert("You have to type a Link URL.");
           form.linkurl.focus();
           return false;
        }
     }
     else if (nSelected==4)
     {
        if (form.filestorage.selectedIndex==0)
        {
           alert("You have to select one of files/folders.");
           form.filestorage.focus();
           return false;
        }

        if (nFrontFileMaxSize<form.at_maxsize.value)
        {
            alert("The max file size allowed to upload can not bigger than " + nFrontFileMaxSize);
            setFocus(form.at_maxsize);
            return false;
        }

        if (trim(form.at_backcolor.value)==0)
           form.at_backcolor.value = "#FFFFFF";

         form.attributes.value = (form.at_allowupload.checked?"1":"0") + "," + form.at_filetype.value + "," + form.at_backcolor.value+","
            + form.at_rowsperpage.value+","+form.at_sortfield.value+","+getRadioValue(form.at_sortorder) + "," + form.at_maxsize.value;
     }
     else if (nSelected==13)
     {
         form.attributes.value = form.om_postby.value + "|" + form.om_modifyby.value + "|" + (form.om_allowanswer.checked?"1":"0") + "|"
            + (form.om_autoactive.checked?"0":"1") + "|" + form.om_buttonname.value + "|" + form.om_acceptemails.value;
     }

     form.place.value = getMultipleCheckboxValue(form, "place_");

     //. Load file status progress window
     if (form.uploadfile.value.length>0)
     {
    //    loadStatusPage(" upload file");
       showStatusPage(form.uploadfile.value, 'statusarea');
     }
     else
     {
       showProcessBar();
     }

     return true;
    }
    catch (ex)
    {
       showException(ex, "validateWebPage()");
       return false;
    }
}

function viewFileListLayout(sValue)
{
//  var sUrl = "ser/util/showfile.jsp?action=Show File&type=storagelayout" + "&value=" + sValue;
  var sUrl = "ser/util/showpopupimage.jsp?action=Show File&type=storagelayout" + "&value=" + sValue;    
  showImageFile("SampleWin", "File List Layout", sUrl, 760, 370);
}
