<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology. -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function showNewMessageForm(form, id_message, sTitle, sSubmitValue)
{
  try {
    showMask();
    var obj = document.getElementById(id_message);
    document.getElementById("action_title").innerHTML = "<h3>" + sTitle + "</h3>";  

    showMessageBox('id_onlinemessagespan', obj);
    form.messageid.value = '-1';
    var sAction = form.action1.value;
    form.action1.value = 'Add' + sAction;
    form.title.value = "";
    form.url.value   = "";
    form.tags.value  = "";
    form.senderweburl.value   = "";
    setTextArea('content', '');
    form.submit.value = sSubmitValue;//"Add";
    document.getElementById('id_existfiles').innerHTML = '';
    cleanAllAttaches();

    form.title.focus();
  }
  catch (ex)
  {
     showException(ex, "showNewMessageForm()");
  }
}

function showEditMessageForm(form, id_message, url, mid, sTitle, sSubmitValue)
{
  try {
    showMask();

    var obj = document.getElementById(id_message);
    showMessageBox('id_onlinemessagespan', obj);

    document.getElementById("action_title").innerHTML = "<h3>" + sTitle + "</h3>";
    //document.getElementById("id_description").innerHTML = "Description:";
    var jsonInfo = getUrlContent(url);
    var objInfo = eval('('+jsonInfo+')');
    form.messageid.value = mid;//getUrlFieldValue(url, 'messageid');
    var sAction = form.action1.value;
    form.action1.value = 'Update' + sAction;      
    form.title.value = objInfo.Title;
    form.title.disabled = false;
    form.url.value   = objInfo.Url;
    form.url.disabled = false;
    form.tags.value  = objInfo.m_Tags;
    form.tags.disabled = false;
    if (objInfo.Active=="0")
       form.active.selectedIndex = 1;
//alert("objInfo.Active=" + objInfo.Active + ", " + form.active.selectedIndex);
    setTextArea('content', objInfo.Content);
    form.authorname.value = objInfo.AuthorName;
    form.email.value = objInfo.EMail;
    form.senderweburl.value = objInfo.SenderWebUrl;
    form.submit.value = sSubmitValue;//"Update";

    addExistFiles(objInfo);
    cleanAllAttaches();
    form.title.focus();


    var objEdit = document.getElementById('id_onlinemessagespan');
    if (objEdit!=null && objEdit.scrollIntoView)
    {
//       objEdit.scrollIntoView();
    }
  }
  catch (ex)
  {
     showException(ex, "showEditMessageForm()");
  }
}

function showCommentMessageForm(form, id_message, url, mid, action, yourname, email)
{
  try {

    showMask();

    var obj = document.getElementById(id_message);
    showMessageBox('id_onlinemessagespan', obj);

    document.getElementById("action_title").innerHTML = "<h3>Make your " + action + " on the Message</h3>";
    document.getElementById("id_description").innerHTML = "Your " + action + ":";      

    var jsonInfo = getUrlContent(url);
    var objInfo = eval('('+jsonInfo+')');
    form.messageid.value = mid;//getUrlFieldValue(url, 'messageid');
    form.title.value = objInfo.Title;
    form.title.disabled = true;
    form.url.value   = objInfo.Url;
    form.url.disabled = true;
    form.tags.value  = objInfo.m_Tags;
    form.tags.disabled = true;  
    setTextArea('content', '');

    form.authorname.value = yourname;
    form.email.value = email;
    form.submit.value = action;
    form.senderweburl.value = "";

    document.getElementById('id_existfiles').innerHTML = '';
    cleanAllAttaches();
    form.content.focus();
  }
  catch (ex)
  {
     showException(ex, "showCommentMessageForm()");
  }
}

function addExistFiles(objInfo)
{
  document.getElementById('id_existfiles').innerHTML = '';
  if (objInfo.m_AttachedIds==null || objInfo.m_AttachedIds.length==0)
  {
     document.getElementById('id_existtitle').innerHTML = '';      
     return;
  }

  var sFileListTable = '<table width="100%" cellpadding=1 cellspacing=0 border=0>';
/*
      + '<tr>' +
      '<td width="5%" align="center" style="border-bottom:1px solid #DFDFDF"><b>No</b></td>' +
      '<td width="86%" style="border-bottom:1px solid #DFDFDF"><b>File Name</b></td>' +
      '<td align="center" style="border-bottom:1px solid #DFDFDF"><b>Delete</b></td>' +
      '</tr>';
*/
  var arFileId = objInfo.m_AttachedIds.split(",");
  var arFileName = objInfo.m_AttachedFiles.split(",");
  for (var i=0; i<arFileId.length; i++)
  {

     sFileListTable += (
      '<tr>' +
      '<td width="5%" align="center" style="border-bottom:1px dot #DFDFDF">' + (i+1) + '.</td>' +
      '<td width="86%" style="border-bottom:1px dot #DFDFDF">' + trim(arFileName[i]) + '</td>' +
      '<td align="center" style="border-bottom:1px dot #DFDFDF"><input type="checkbox" name="cdfile_' + trim(arFileId[i]) + '" value="1" /> </td>' +
      '</tr>');      
  }

  sFileListTable += '</table>';
  document.getElementById('id_existfiles').innerHTML = sFileListTable;
}

function showMessageBox(layerId, obj)
{
    var floatwin = document.getElementById(layerId);
//alert("left =" + obj+","+obj.offsetLeft+","+obj.offsetTop);//getposOffset1(obj, "left"));
    floatwin.style.display = 'block';
//  floatwin.style.width = '510px';
    floatwin.style.left    = getLinkOffset(obj, "left") - 5;
    floatwin.style.top     = getLinkOffset(obj, "top") + 20;
}

function hideMessageBox(layerId)
{
  var floatwin = document.getElementById(layerId);
  floatwin.style.display = 'none';
  hideMask();
}

function showGoToPageForm(form, id_parent, id_form)
{
  try {
    var floatwin = document.getElementById(id_form);
	if (floatwin.style.display=='block')
	{
	   floatwin.style.display = 'none';
       document.getElementById('img_downarrow').src = '/staticfile/web/images/arrowdown.gif';
	}
	else
	{
        document.getElementById('img_downarrow').src = '/staticfile/web/images/arrowright.gif';
		var obj = document.getElementById(id_parent);
		floatwin.style.display = 'block';	//  floatwin.style.width = '510px';
		floatwin.style.left    = getLinkOffset(obj, "left") - floatwin.offsetWidth + obj.offsetWidth;
		floatwin.style.top     = getLinkOffset(obj, "top") + 22;
		form.page.focus();  //    showMask();
	}
  }
  catch (ex)
  {
     showException(ex, "showGoToPageForm()");
  }
}

function validateOnlineMessage(form)
{
   if (checkFieldEmpty(form.title))
   {
      alert("You have to input a Title.");
      setFocus(form.title);                   
      return false;
   }

   if (!checkFieldEmpty(form.url))
   {
      if (!checkRegulation(18, form.url.value))
      {
         alert("You have to input a valid Url.");
         setFocus(form.url);
         return false;
      }
   }

    if (!checkFieldEmpty(form.email))
    {
       if (!checkRegulation(15, form.email.value))
       {
          alert("You have to input a valid E-Mail address.");
          setFocus(form.email);                   
          return false;
       }
    }

    hideMessageBox('id_onlinemessagespan');
    
    showStatusPage('upload process', 'statusarea');
//   showProcessBar();
    
   return true; 
}

function validateSearchMessage(form)
{
   if (checkFieldEmpty(form.keywords))
   {
      alert("You have to input some key words.");
      setFocus(form.keywords);
      return false;
   }

   showProcessBar();

   return true;
}

var g_sIdBoxName = null;
function showAdvancedSearcbBox(id_box)
{
  if (g_sIdBoxName==null || eval(g_sIdBoxName+".style.display")=='none')
  {
      showHide('open', id_box);
      g_sIdBoxName = id_box;
      var form = document.forms["form_advancemessagesearch"];
      if (form!=null)
         setFocus(form.titlewords);
  }
  else
  {
     hideAdvancedSearcbBox();
  }
  return false;
}

function hideAdvancedSearcbBox()
{
  showHide('close', g_sIdBoxName);

  return false;
}

function sortByMessageField(objSelect, sJspFile)
{
  if (g_sIdBoxName==null || eval(g_sIdBoxName+".style.display")=='none')      
     sortByField(objSelect, sJspFile);
}

function validateAdvanceMessageSearch(form, form2)
{

try {
   var bValidate = false;
   if (!checkFieldEmpty(form.titlewords))
   {
      bValidate = true;
   }

    if (!checkFieldEmpty(form.descriptionwords))
    {
       bValidate = true;
    }

    if (!checkFieldEmpty(form.tagwords))
    {
       bValidate = true;
    }

    if (!checkFieldEmpty(form.createdate_from))
    {
       bValidate = true;
    }

    if (!checkFieldEmpty(form.createdate_to))
    {
       bValidate = true;
    }

    if (bValidate)
       form.sortedby.value = form2.sortedby.value;
    else
    {
       alert("You have to enter at least one of search fields.");
       return false;
    }

// alert("form.sortedby.value=" + form.sortedby.value);
   showProcessBar();

   return true;
}
catch (ex)
{
   showException(ex, "validateAdvanceMessageSearch()");
   return false;
}

}
