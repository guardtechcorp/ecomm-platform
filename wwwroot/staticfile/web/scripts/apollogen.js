function showSubmitSearch(form)
{
    $('#id_searchcode').toggle();
    var isV = $('#id_searchcode').is(':visible');
    if (isV)
    {
        setFocus(form.requestcode);
    }
    return false;
}
function onSubmitSearch(form)
{
    if (checkFieldEmpty(form.requestcode))
    {
        alert("You have to enter a requested code.");
        setFocus(form.requestcode);

        return false;
    }

    if (trim(form.requestcode.value).length!=10)
    {
        alert("The requested code you entered is invalid");
        setFocus(form.requestcode);

        return false;
    }

    return true;
}
function onTransferOrder(code)
{
    if (!confirm("It is a patient ordering. Do you really want to transfer it into your ordering case?"))
    {
        return false;
    }

    var form = document.searchform;
    var include = 2;
    form.what.value = "Tranfer";
    form.id.value = code;
    var sRequest = getFormQuery(form) + "&include=" + include;
    var sUrl = form.action;

    postAjaxRequest(sUrl, sRequest, true, 'id_mainarea');

    return false;
}

function toggleShow(idhtml)
{
   $('#' + idhtml).toggle();

   return false;
}

function onShowByCheckBox(chkObj, flag, idhtml)
{
   if (chkObj.checked)
   {
      if (flag)
         $('#' + idhtml).show();
      else
         $('#' + idhtml).hide();
   }
   else
   {
       if (!flag)
          $('#' + idhtml).show();
       else
          $('#' + idhtml).hide();
   }
   return false;
}

var emailfilter=/^\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)$/i;
var emailfilter2=/^(.*?)<\w+[\+\.\w-]*@([\w-]+\.)*\w+[\w-]*\.([a-z]{2,4}|\d+)>$/i;
function checkEmails(emails)
{
    var arEmail = emails.split(/[\s+,;\s+]/);
    for (var i=0; i<arEmail.length; i++)
    {
        var sEmail = trim(arEmail[i]);
        if (sEmail.length>0 && !(emailfilter.test(sEmail)||emailfilter2.test(sEmail)))
        {
           alert("'" + sEmail + "' you entered is an invalid email address.");
           return false;
        }
    }

    return true;
}

function postAjaxRequest(sUrl, sRequest, bAsync, idhtml)
{
    $.ajax({
        url: sUrl,
        type: 'post',
        data: sRequest,
        async: bAsync,
        success: function (content) {
            $('#id_waiting').html("");
            $('#id_buttonmessage').html("");
            if (idhtml!=null)
            {
               $('#' + idhtml).html(content);
            }
            else
            {
               var json = eval("("+content+")");
               $('#id_buttonmessage').html(json.message);
            }
        }
    });
}

function postAjaxFormAction(form)
{
   var sRequest = getFormQuery(form) + "&include=2&te="+new Date().getTime();
   postAjaxRequest(form.action, sRequest, true, 'id_mainarea');
}

function submitAjaxPage(form, nPage)
{
   form.wt.value = "Page";
   form.page.value = nPage;

   postAjaxFormAction(form, true);
}

function submitAjaxMaxRow(form)
{
   form.wt.value = "updaterows";
   postAjaxFormAction(form, true);
}

function submitAjaxSort(form, sSort, sOrder)
{
   if (typeof sSort!="undefined" && sSort.length>0)
   {
       form.sort.value = sSort;
       form.asc.value = sOrder;
       form.wt.value = "Sort" ;
   }

   postAjaxFormAction(form, true);
}

function submitAjaxGroup(form, sGroup)
{
   form.gp.value = sGroup;
   postAjaxFormAction(form, true);
}

function submitAjaxAction(form, what, id)
{
   if (what=="Remove"||what=="Delete")
   {
      if (!confirm("Are you sure you really wante to delete it?"))
         return false;
   }

   form.wt.value = what;
   form.id.value   = id;

   postAjaxFormAction(form, true);

   return false;
}

function submitAjaxDelete(form, what, id)
{
   return submitAjaxAction(form, what, id);
}

function openSignPad(person)
{
//    modalWin('/staticfile/sign/signature.html?person=' + person, 500, 270);
    var url = '/staticfile/sign/signature-2.html?person=' + person
    modalWin(url, 500, 270);

    return false;
}

function modalWin(sUrl, nWidth, nHeight)
{
    var nScreenWidth=screen.width;
    var nScreenHeight=screen.height;
    var nLeft=(nScreenWidth-nWidth)/2;
    var nTop=(nScreenHeight-nHeight)/2;
    window.open(sUrl, "Dialog Box", "dependent,innerHeight="+nHeight+",innerWidth="+nWidth+",height="+nHeight+",width="+nWidth+",location=0,resizable=no,menubar=no,location=no,personalbar=no,status=no,scrollbars=yes,toolbar=no,screenX="+nLeft+",screenY="+nTop);
}

function getVectorLines(person)
{
    if (person=="Physician")
        return document.testform.phy_sign.value;
    else if (person=="Patient")
        return document.testform.patientsign.value;
    else if (person=="Patient2")
        return document.testform.patientsign2.value;
}

function setVectorLines(v, person)
{
    var id_signarea;
    if (person=="Physician")
    {
        document.testform.phy_sign.value = v;
        id_signarea = "physignarea";
    }
    else if (person=="Patient")
    {
        id_signarea = "patsignarea";
        document.testform.patientsign.value = v;
    }
    else if (person=="Patient2")
    {
        id_signarea = "patsignarea2";
        document.testform.patientsign2.value = v;
    }

    updateSign("/Clinician", person, v);

    if (v.length>3)
    {
        var imageUrl = g_imageUrl + "&type=Vector&data=" + person + "&te=" + new Date().getTime();
        if (v.indexOf("{\"lines\":")<0)
           imageUrl = g_imageUrl + "&card=physciansign" + "&te=" + new Date().getTime();
        var imageTag = "<img src='" + imageUrl + "' height='44'>";

        $('#' + id_signarea).html(imageTag);
    }
    else
    {
        $('#' + id_signarea).html("");
    }
}

function updateSign(url, person, data)
{
    var formdata = "&action1=UpdateSign&person=" + person + "&vd=" + encodeURIComponent(data) + "&customerid=" + g_customerId;
    $.ajax({
        url: url,
        method: 'post',
        data: formdata,
        //dataType: 'json',
        async: false,
        success: function (resdata) {
        }
    });
}

function submitNavigate(action, idhtml)
{
  var form = document.navigateform;
  form.action1.value = action;

  if (action=="Logout")
  {
     if (!confirm("Do you really want to logout?"))
     {
        return false;
     }

     form.clicklogout.value = 1;
  }
        
  if (typeof idhtml=="undefined")
  {
     form.submit();

     return (action!="print"?true:false);
  }
  else
  {
     var sRequest = getFormQuery(form) + "&include=2&te="+new Date().getTime();
     var sUrl = form.action;
     form.id.value = "";

     postAjaxRequest(sUrl, sRequest, true, idhtml);

     return false;
  }
}

function forceLogout(ajax)
{
    var form = document.navigateform;
    form.action1.value = "Logout";
    if (ajax)
    {
        form.clicklogout.value = 20;
        var sRequest = getFormQuery(form) + "&include=2&te="+new Date().getTime();
        var sUrl = form.action;
        $.ajax({
            url: sUrl,
            type: 'post',
            data: sRequest,
            async: true,
            success: function (content) {
            }
        });
//        postAjaxRequest(sUrl, sRequest, true);
    }

    form.clicklogout.value = 1;
    form.submit();

    return false;
}

function loadTestForm(id, what)
{
    var form = document.navigateform;
    form.id.value = id;
    form.what.value = what;
    if (what=="print")
       return submitNavigate('PrintSummary');
    else if (what=="view")
       return submitNavigate('ViewPage', 'id_mainarea');
    else
       return submitNavigate('FillTestForm-' + what, 'id_mainarea');
}

function navigatePage(what)
{
    var form = document.navigateform;
    form.what.value = what;

    return submitNavigate('ViewPage', 'id_mainarea');
}

function switchTab(what, id)
{
    var form = document.navigateform;
    form.what.value = what;
    form.id.value = id;

    var sRequest = getFormQuery(form) + "&include=2&te="+new Date().getTime();
    var sUrl = form.action;
    postAjaxRequest(sUrl, sRequest, true, 'id_mainarea');

    return false;
}

function submitValidateForm(func, form, idhtml, more)
{
    if (typeof more=="undefined")
    {
        if (!func(form))
           return false;
    }
    else
    {
        if (!func(form, more))
           return false;
    }

    if (typeof idhtml=="undefined")
    {
       form.submit();

       return true;
    }
    else
    {
       $('#id_waiting').html("<p align='center'><img src='/staticfile/web/images/loading.gif' width='32' height='32' alt=''></p>");
       $('#id_buttonmessage').html("<img src='/staticfile/web/images/loading.gif' width='32' height='32' alt=''>");

       var include = 2;
       if (typeof more!="undefined")
          form.action1.value = form.action1.value + "-" + more;
       var sRequest = getFormQuery(form) + "&include=" + include + "&te="+new Date().getTime();
       var sUrl = form.action;

       postAjaxRequest(sUrl, sRequest, true, idhtml);

       return false;
    }
}

//. http://hayageek.com/docs/jquery-upload-file.php
function initUploadImageFile(idUpload, card, idhtml, uploadUrl, imageUrl)
{
    var uploadedfile = "";
    var uploadObj =  $("#" + idUpload).uploadFile({
	url:uploadUrl + "&card=" + card,
	fileName:"CardFilename",
    multiple:true,
    dragDrop:false,
    cache: false,
    acceptFiles:"image/*",
    maxFileCount:2,
    maxFileSize:10*1024*1024,
    dataType: 'json',
    uploadStr:"Select " + card + " Card File",
    autoSubmit: true,

        onSuccess:function(files,data,xhr,pd)
        {
          var json = eval("("+data+")")
    //      alert("ret=" + json.filenames);
          uploadedfile = json.filenames;
        },

        afterUploadAll:function(obj)
        {
           uploadObj.reset();
           updateImagePhoto(uploadedfile, card, idhtml, imageUrl);
        }

        //        dynamicFormData: function()
        //        {
        //           var data ={"ID":g_generalID,"existfiles":g_uploadedfile1};
        //           return data;
        //        },

        //        onSelect:function(files)
        //        {
        ////           document.testform.uploadfile1.disabled = false;
        //            g_uploadObj1.startUpload();
        //
        //        },
        //
        //        onCancel: function(files,pd)
        //        {
        ////            document.testform.uploadfile1.disabled = true;
        //        },
        //
        //        onSubmit:function(files)
        //        {
        //    //      alert("files=" + files);
        //        },
   });
}

function initUploadAnyFile(idUpload, card, idhtml, uploadUrl, fileUrl)
{
    var updatefile = "";
    var uploadObj =  $("#" + idUpload).uploadFile({
	url:uploadUrl + "&card=" + card,
	fileName:"CardFilename",
    multiple:true,
    dragDrop:false,
    cache: false,

    maxFileCount:5,
    maxFileSize:100*1024*1024,
    dataType: 'json',
    uploadStr:"Select File(s)",
    autoSubmit: true,

        onSuccess:function(files,data,xhr,pd)
        {
          var json = eval("("+data+")")
    //      alert("ret=" + json.filenames);
          uploadedfile = json.filenames;
        },

        afterUploadAll:function(obj)
        {
           uploadObj.reset();
           updateFiles(uploadedfile, card, idhtml, fileUrl);
        }

   });
}

function updateImagePhoto(files, card, idhtml, imageUrl)
{
    if (card=="medicare")
       document.testform.medicarecard.value = files;
    else// if (card=="insurance")
       document.testform.insurancecard.value = files;

    var sb = "";
    if (files!=null && files.length>0)
    {
        var rootUrl = imageUrl + "&card=" + card + "&te=" + new Date().getTime();
        var arFile = files.split(",");

        for (var i=0; i<arFile.length; i++)
        {
           if (i>0)
             sb += "&nbsp;&nbsp;";
           var imageUrl =  rootUrl + "&index=" + (i+1);
           var start = arFile[i].indexOf("-");
           sb += "<a href='" + imageUrl + "' target='_ImageWin' title='View Image'><img src='" + imageUrl + "' width='100' alt='View Image'>";
           sb += " <a onClick=\"return removeCardFile(" + (i+1) + ",'"  + arFile[i].substr(start+1) + "','" + card + "','";
           sb += idhtml + "','" + imageUrl + "')\" href='#' title='Remove it'>Remove</a>";
        }
    }

    $('#' + idhtml).html(sb);
}

function updateFiles(files, card, idhtml, fileUrl)
{
    document.testform.docfiles.value = files;
    var sb = "";
    if (files!=null && files.length>0)
    {
        var sGetFileUrl = "<%=sGetFileUrl%>";
        var arFile = files.split(",");
        sb += "<table width='100%'>";
        for (var i=0; i<arFile.length; i++)
        {
           var start = arFile[i].indexOf("-");
           sb += "<tr style='border-bottom: 1px solid #cccccc'><td width='80%' height='28'>" + (i+1) + ". <a href='" + sGetFileUrl + i + "' title='Click to download it'>";
           sb += arFile[i].substring(start+1) + "</a></td>";
           sb += "<td align='center'><a onClick=\"return removeCardFile(" + (i+1) + ",'"  + arFile[i].substr(start+1) + "','" + card + "','";
           sb += idhtml + "','" + fileUrl + "')\" href='#' title='Remove it'>Remove</a></td>";
           sb += "</tr>";
        }
        sb += "</table>";
    }

    $('#' + idhtml).html(sb);
}

function removeCardFile(index, filename, card, idhtml, imageUrl)
{
  if (!confirm("Are you sure you want to remove '" + filename + "'"))
  {
     return false;
  }

  var form = document.testform;
  var temp = form.action1.value;
  form.action1.value = "FillTestForm-RemoveFile";
  var formdata = getFormQuery(form) + "&card=" + card + "&index=" + index + "&te="+new Date().getTime();
  form.action1.value = temp;

  $.ajax({
      url: form.action,
      method: 'post',
      data: formdata,
      dataType: 'json',
      async: true,
      success: function (json) {
//alert("json=" + json.message);
         if (json.ret)
         {
            if (card=="docfile")
               updateFiles(json.message, card, idhtml, imageUrl);
            else
               updateImagePhoto(json.message, card, idhtml, imageUrl);
         }
         else
         {
            alert(json.message);
         }
     }
  });

  return false;
}

function submitSendEmail(form, idhtml)
{
  if (checkFieldEmpty(form.emailto))
  {
     alert("You have to enter at least one Email Address.");
     setFocus(form.emailto);
     return false;
  }

  if (!checkEmails(form.emailto.value))
  {
     setFocus(form.emailto);
     return false;
  }

  if (checkFieldEmpty(form.subject))
  {
     alert("You have to enter a Subject.");
     setFocus(form.subject);
     return false;
  }

  $('#' + idhtml).html("<p align='center'><img src='/staticfile/web/images/loading.gif' width='16' height='16' alt=''><font size=3 color='orange'> Please wait...</font> </p>");
  form.sendbutton.disabled = true;

  form.wt.value = "SendEmail";  
  var sRequest = getFormQuery(form) + "&te="+new Date().getTime();
//alert("sRequest=" + sRequest);
  form.wt.value = "";

  $.ajax({
        url: form.action,
        type: 'post',
        data: sRequest,
        async: true,
        success: function (data) {
            var json = eval("("+data+")");
            $('#' + idhtml).html(json.message);

            form.sendbutton.disabled = true;
        }
  });

  return false;
}

function submitPatientGeneralInfo(form)
{
   if (checkFieldEmpty(form.firstname))
   {
       alert("You have to enter your First Name.");
       setFocus(form.firstname);

       return false;
   }

  if (checkFieldEmpty(form.lastname))
  {
       alert("You have to enter your Last Name.");
       setFocus(form.lastname);

       return false;
  }

    if (form.bmonth.selectedIndex==0)
    {
          alert("You have to select Birth Month");
          form.bmonth.focus();
          return false;
    }

    if (form.bday.selectedIndex==0)
    {
        alert("You have to select Birth Day");
        form.bday.focus();
        return false;
    }

    if (form.byear.selectedIndex==0)
    {
        alert("You have to select Birth Year");
        form.byear.focus();
        return false;
    }
    form.birthday.value = form.bmonth.value + "/" + form.bday.value + "/" + form.byear.value;

  var sex = getRadioValue(form.gender);
  if (sex=="" || sex=="0")
  {
     alert("You have to set Sex of you.");
//       setFocus(form.gender);
     return false;
  }

    var ethn = getRadioValue(form.ethnicity);
    if ((ethn<1 || ethn=="")&&checkFieldEmpty(form.ethnicother))
    {
         alert("You have to set one of Ethnic Background OR enter Other Enthicity.");
         return false;
    }

    if (checkFieldEmpty(form.address))
    {
       alert("You have to enter Address.");
       setFocus(form.address);

       return false;
    }

    if (checkFieldEmpty(form.city))
    {
       alert("You have to enter City.");
       setFocus(form.city);

       return false;
    }

    if (checkFieldEmpty(form.state))
    {
       alert("You have to enter State.");
       setFocus(form.state);

       return false;
    }

    if (checkFieldEmpty(form.zip))
    {
       alert("You have to enter Zip.");
       setFocus(form.zip);

       return false;
    }

    if (checkFieldEmpty(form.phone))
    {
       alert("You have to enter your Phone number.");
       setFocus(form.phone);

       return false;
    }

    if (checkFieldEmpty(form.email))
    {
       alert("You have to enter your E-Mail.");
       setFocus(form.email);

       return false;
    }

  if (!form.providernpi.checked)
  {
      if (checkFieldEmpty(form.phy_name))
      {
         alert("You have to enter Physician Name.");
         setFocus(form.phy_name);

         return false;
      }

      if (checkFieldEmpty(form.institution))
      {
         alert("You have to enter Institution Name.");
         setFocus(form.institution);

         return false;
      }
  }

  var stype = getRadioValue(form.sampletype);
  if (stype<0 || stype=="")
  {
     alert("You have to select one of Type of Sample Kit.");
     return false;
  }

   return true;
}

function onSubmitPreAuth(form)
{
    var value = getRadioValue(form.preauth);
    if (value<=0)
    {
        alert("You have to select one of pre-authorization.");

        return false;
    }

    if (value==2 && checkFieldEmpty(form.preauthemail))
    {
       alert("You have to enter your email.");
       setFocus(form.preauthemail);

       return false;
    }

    form.wt.value = "UpdatePreAuth";
    var formdata = getFormQuery(form) + "&te="+new Date().getTime();
    form.wt.value = "";

    $('#id_submitmessage').html("<p><br><p align='center'><img src='/staticfile/web/images/loading.gif' width='16' height='16' alt=''><font size=3 color='orange'> Please wait...</font> </p>");
    form.submitpreauth.disabled = true;

    $.ajax({
        url: form.action,
        method: 'post',
        data: formdata,
        dataType: 'json',
        async: true,
        success: function (json) {
  //alert("json=" + json.message);
          $('#id_submitmessage').html("<p><br>" + json.message);

          form.submitpreauth.disabled = false;            
       }
    });

    return false;
}

function onSubmitMessage(form)
{
    if (checkFieldEmpty(form.message))
    {
        alert("You have to enter some message.");
        setFocus(form.message);

        return false;
    }

    $('#id_leavemessage').html("<p><br><p align='center'><img src='/staticfile/web/images/loading.gif' width='16' height='16' alt=''><font size=3 color='orange'> Please wait...</font> </p>");

    var temp = form.wt.value;
    form.wt.value = "LeaveMessage";

    var formdata = getFormQuery(form) + "&te="+new Date().getTime();

    form.wt.value = temp;

    $.ajax({
        url: form.action,
        method: 'post',
        data: formdata,
        dataType: 'json',
        async: true,
        success: function (json) {
            // alert("json=" + json);
            form.message.value = "";
            $('#id_leavemessage').html("<p><br>" + json.message);
        }
    });

    return false;
}

function tryToGetPassword(form)
{
  if (checkFieldEmpty(form.email))
  {
     alert(getAlertMsg(6));
     setFocus(form.email);
     return false;
  }

  if (!validateEmail(form.email))
     return false;

  var temp = form.action1.value;
  form.action1.value = "Forgot-Password";
  var formdata = getFormQuery(form) + "&te="+new Date().getTime();
//alert("form data=" + formdata);
  form.action1.value = temp;

  $.ajax({
      url: "/Clinician",
      method: 'post',
      data: formdata,
      dataType: 'json',
      async: true,
      success: function (json) {
//alert("json=" + json.message);
       $('#id_message').html(json.message)
     }
  });

  return false;
}

function onPaymentMethodChange(objSelect)
{
   for (var i=0; i<7; i++)
   {
      $('#bt_'+ Math.pow(2, i)).hide();
   }

   if (objSelect.selectedIndex>0)
   {
      $('#bt_'+objSelect.value).show();
   }

   if (objSelect.selectedIndex==2||objSelect.selectedIndex==3)
      $('#id_patientack').show();
   else
      $('#id_patientack').hide();
}

function onClickPersionHistory(value, idhtml)
{
    if (value!=1)
       $('#' + idhtml).hide();
    else
       $('#' + idhtml).show();
}

function onCancerChange(objCheck, idhtml)
{
    if (objCheck.checked)
    {
       $('#id_' + idhtml).show();
    }
    else
    {
       $('#id_' + idhtml).hide();
    }
}

//. General 
function fillBirthDay(form, birthday)
{
    if (birthday.length!=10)
       return;

    selectDropdownMenu(form.bmonth, birthday.substr(0,2));
    selectDropdownMenu(form.bday, birthday.substr(3,2));
    selectDropdownMenu(form.byear, birthday.substr(6));
}

function submitGeneralInfo(form)
{
   if (checkFieldEmpty(form.firstname))
   {
       alert("You have to enter First Name of patient.");
       setFocus(form.firstname);

       return false;
   }

  if (checkFieldEmpty(form.lastname))
  {
       alert("You have to enter Last Name of patient.");
       setFocus(form.lastname);

       return false;
  }

  if (form.bmonth.selectedIndex==0)
  {
        alert("You have to select Birth Month");
        form.bmonth.focus();
        return false;
  }

  if (form.bday.selectedIndex==0)
  {
      alert("You have to select Birth Day");
      form.bday.focus();
      return false;
  }

  if (form.byear.selectedIndex==0)
  {
      alert("You have to select Birth Year");
      form.byear.focus();
      return false;
  }
  form.birthday.value = form.bmonth.value + "/" + form.bday.value + "/" + form.byear.value;

  var sex = getRadioValue(form.gender);
  if (sex<1 || sex=="")
  {
     alert("You have to set Sex of patient.");
//       setFocus(form.gender);
     return false;
  }

  var ethn = getRadioValue(form.ethnicity);
  if ((ethn<1 || ethn=="")&&checkFieldEmpty(form.ethnicother))
  {
       alert("You have to set one of Ethnic Background OR enter Other Enthicity.");
       return false;
  }

  if (checkFieldEmpty(form.phy_name))
  {
     alert("You have to enter Physician Name.");
     setFocus(form.phy_name);

     return false;
  }

  if (checkFieldEmpty(form.institution))
  {
     alert("You have to enter Institution Name.");
     setFocus(form.institution);

     return false;
  }

  if (form.reportmethod.selectedIndex>0)
  {
     if (form.reportmethod.value==1)
     {
         if (checkFieldEmpty(form.phy_address))
         {
            alert("You have to enter Address.");
            setFocus(form.phy_address);

            return false;
         }

         if (checkFieldEmpty(form.phy_city))
         {
            alert("You have to enter City.");
            setFocus(form.phy_city);

            return false;
         }

         if (checkFieldEmpty(form.phy_state))
         {
            alert("You have to enter State.");
            setFocus(form.phy_state);

            return false;
         }

         if (checkFieldEmpty(form.phy_zip))
         {
            alert("You have to enter Zip.");
            setFocus(form.phy_city);

            return false;
         }
     }
     else if (form.reportmethod.value==2)
     {
          if (checkFieldEmpty(form.phy_email))
          {
             alert("You have to enter E-Mail.");
             setFocus(form.phy_email);

             return false;
          }
     }
     else if (form.reportmethod.value==3)
     {
          if (checkFieldEmpty(form.phy_fax))
          {
             alert("You have to enter Fax.");
             setFocus(form.phy_fax);

             return false;
          }
     }
     else if (form.reportmethod.value==4)
     {
          if (checkFieldEmpty(form.phy_phone))
          {
             alert("You have to enter Phone.");
             setFocus(form.phy_phone);

             return false;
          }
     }
  }

  if (form.billtype.selectedIndex<=0)
  {
      alert("You have to select one of payment methods.");
      form.billtype.focus();

      return false;
  }
  else if (form.billtype.value==1)
  {
       if (checkFieldEmpty(form.insname))
       {
          alert("You have to enter Institution Name.");
          setFocus(form.insname);

          return false;
       }

       if (checkFieldEmpty(form.inscontact))
       {
          alert("You have to enter Contact Number");
          setFocus(form.inscontact);

          return false;
       }
  }
  else if (form.billtype.value==2)
  {
       if (checkFieldEmpty(form.medicareno))
       {
          alert("You have to enter Medicare No.");
          setFocus(form.medicareno);

          return false;
       }

       if (checkFieldEmpty(form.medicarestate))
       {
          alert("You have to enter Medicare State");
          setFocus(form.medicarestate);

          return false;
       }
  }
  else if (form.billtype.value==4)
  {
       if (checkFieldEmpty(form.policyname))
       {
          alert("You have to enter Policyholder Name.");
          setFocus(form.policyname);

          return false;
       }

       if (checkFieldEmpty(form.holderdob))
       {
          alert("You have to enter DOB");
          setFocus(form.holderdob);

          return false;
       }

      if (checkFieldEmpty(form.holderphone))
      {
         alert("You have to enter Phone Number.");
         setFocus(form.holderphone);

         return false;
      }

      if (checkFieldEmpty(form.insureanceco))
      {
         alert("You have to enter Insureance Co");
         setFocus(form.insureanceco);

         return false;
      }
      if (checkFieldEmpty(form.memberid))
      {
         alert("You have to enter Member ID.");
         setFocus(form.memberid);

         return false;
      }

      if (checkFieldEmpty(form.groupno))
      {
         alert("You have to enter Group No");
         setFocus(form.groupno);

         return false;
      }
  }
  else if (form.billtype.value==32)
  {
      if (checkFieldEmpty(form.creditname))
      {
        alert(getAlertMsg(20));
        setFocus(form.creditname);
        return false;
      }

      if (checkFieldEmpty(form.creditno))
      {
        alert(getAlertMsg(21));
        setFocus(form.creditno);
        return false;
      }

      if (form.creditno.value.length<15)
      {
        alert(getAlertMsg(22));
        setFocus(form.creditno);
        return false;
      }

      if (form.expiremonth.selectedIndex==0)
      {
        alert(getAlertMsg(23));
        form.expiremonth.focus();
        return false;
      }
      if (form.expireyear.selectedIndex==0)
      {
        alert(getAlertMsg(24));
        form.expireyear.focus();
        return false;
      }

      if (checkFieldEmpty(form.csid))
      {
         alert(getAlertMsg(25));
         setFocus(form.csid);
         return false;
      }
  }

  if (form.billtype.value==2||form.billtype.value==4)
  {
      if (checkFieldEmpty(form.patientsign) || form.patientsign.value.length<15)
      {
         alert("The patient has to sign.");
//         setFocus(form.patientsign);

         return false;
      }
    
      if (checkFieldEmpty(form.signdate))
      {
         alert("The patient has to enter sign date.");
         setFocus(form.signdate);

         return false;
      }
  }

  if (checkFieldEmpty(form.phy_sign)||form.phy_sign.value.length<15)
  {
     alert("The physician has to sign.");
//     setFocus(form.phy_sign);

     return false;
  }

  if (checkFieldEmpty(form.phy_signdate))
  {
     alert("The physician has to enter sign date.");
     setFocus(form.phy_signdate);

     return false;
  }

  form.sampletype.value = getMultipleCheckboxValue(form, 'st_');
  if (form.sampletype.value==0)
  {
     alert("You have to at least select one of Sample Type.");
     setFocus(form.st_Blood);
     return false;
  }

 //$( "#datepicker1" ).datepicker("destroy");

  return true;
}
//. Ordering
function onClickTestCategory(chkObj)
{
   var blockname = "id_" + chkObj.name.substr(3);
   if (chkObj.checked)
     $('#' + blockname).show();
   else
     $('#' + blockname).hide();

   var form = document.testform;
   var value = getMultipleCheckboxValue(form, 'to_');
   if (value==0)
     $('#id_notest').show();
   else
     $('#id_notest').hide();
}

function submitOrdering(form, next)
{
  form.testtype.value = getMultipleCheckboxValue(form, 'to_');

  if (next=="next"||next=="save")
  {
     if (form.testtype.value==0)
     {
         alert("You have at least select one of Test Ordering Categories.")
         return false;
     }
  }

  var ttype = 0;
  form.comprehensive.value = getMultipleCheckboxValue(form, 'cc_');
  form.specialty.value = getMultipleCheckboxValue(form, 'sp_');
  if ((form.comprehensive.value+form.specialty.value)>0)
     ttype = 1;

  form.cardiovascular.value = getMultipleCheckboxValue(form, 'cd_');
  form.cardiomyopathy.value = getMultipleCheckboxValue(form, 'cm_');
  form.arrhythmia.value = getMultipleCheckboxValue(form, 'at_');
  form.aortopathy.value = getMultipleCheckboxValue(form, 'ap_');
  form.otheroption.value = getMultipleCheckboxValue(form, 'op_');
  if ((form.cardiovascular.value+form.cardiomyopathy.value
      + form.arrhythmia.value+form.aortopathy.value+form.otheroption.value)>0)
      ttype += 2;

  form.pharmacogenomics.value = getMultipleCheckboxValue(form, 'pg_');
  if (form.pharmacogenomics.value>0)
     ttype += 8;

  form.ophthalmology.value = getMultipleCheckboxValue(form, 'oh_');
  if (form.ophthalmology.value>0)
     ttype += 4;

  form.other.value = getMultipleCheckboxValue(form, 'ot_');
  if (form.other.value>0)
     ttype += 16;

  form.testtype.value = ttype;

  return true;
}

function onCancerChange(objCheck, idhtml)
{
    if (objCheck.checked)
    {
       $('#id_' + idhtml).show();

       $("#cc_"+idhtml).ultraselect({selectAll: false});
    }
    else
    {
       $('#id_' + idhtml).hide();
    }
}

function addMoreHistoryRow()
{
   var rowIndex = "" + ($("#id_familyhistory tr").length - 3);
//alert("rowIndex=" + rowIndex);
   var row = $('#id_addinghistoryrow').html();
   var start = row.indexOf("<tr");
   var end = row.lastIndexOf("</tr>");
   var data = row.substr(start, end+5).replace(/XXX/g, rowIndex);

   $('#id_familyhistory').append(data);

   return false;
}

function addMoreResultRow()
{
   var rowIndex = "" + $("#id_testresult tr").length;
//alert("rowIndex=" + rowIndex);
   var row = $('#id_addingtestrow').html();
   var start = row.indexOf("<tr");
   var end = row.lastIndexOf("</tr>");
   var data = row.substr(start, end+5).replace(/XXX/g, rowIndex);

   $('#id_testresult').append(data);

   return false;
}

function renameRowName()
{
    $('#id_familyhistory tr').each(function (i, row) {
        if (i>2)
        {
            // reference all the stuff you need first
            var $row = $(row),
                $init = $row.find('input[name*="initial"]'),
                $relat = $row.find('select[name*="relationship"]'),
                $pside = $row.find('select[name*="parentside"]'),
                $ctype = $row.find('select[name*="cancertype"]');
            $other = $row.find('input[name*="othertype"]'),
                $diagnos = $row.find('input[name*="diagnosisage"]'),

                //alert(". " + i + ": " + $relat.attr('name') + "=" + $relat.val() + ", " + $diagnos.attr('name') + "=" + $diagnos.val());

                $init.attr('name', "initial" + (i-3));
            $relat.attr('name', "relationship" + (i-3));
            $pside.attr('name', "parentside" + (i-3));
            $ctype.attr('name', "cancertype" + (i-3));
            $other.attr('name', "othertype" + (i-3));
            $diagnos.attr('name', "diagnosisage" + (i-3));
        }
    });

    $('#id_testresult tr').each(function (i, row) {
            // reference all the stuff you need first
            var $row = $(row),
                $title = $row.find('input[name*="title"]'),
                $desc = $row.find('input[name*="description"]');

            $title.attr('name', "title" + i);
            $desc.attr('name', "description" + i);
    });
}

function addMoreFindingRow()
{
   var rowIndex = $("#id_specialfinding tr").length;
//alert("rowIndex=" + rowIndex);
   var row = $('#id_findingtestrow').html();
   var start = row.indexOf("<tr");
   var end = row.lastIndexOf("</tr>");
   var data = row.substr(start, end+5).replace(/XXX/g, (rowIndex+200));

   $('#id_specialfinding').append(data);

   return false;
}

function onChangeCancerType(objSelect, objInput)
{
    var index = objSelect.name.substr(10);//
    var objOther = eval("document.testform.othertype" + index);
    objOther.disabled = objSelect.selectedIndex<(objSelect.length-1);
//
//   if (objInput!=null && typeof objInput.disabled != "undefined" && objInput.disabled!=null)
//      objInput.disabled = objSelect.selectedIndex<(objSelect.length-1);
}

function validateCancers(form, value)
{
    var oneMoreChecked = false;
    if (form.breastcheck.checked)
    {
        if (checkFieldEmpty(form.breastage))
        {
           alert("You have to enter a age of Breast Cancer.");
           form.breastage.focus();
           return false;
        }

        form.breastcode.value = $("#cc_0").val();
        if (checkFieldEmpty(form.breastcode))
        {
            alert("You have to at least select one of ICD-10 codes for Breast Cancer.");
            return false;
        }

        oneMoreChecked = true;
    }

    if (form.colorectcheck.checked)
    {
         if (checkFieldEmpty(form.colorectage))
         {
             alert("You have to enter a age of Colorectal Cancer.");
             return false;
         }

        form.colorectcode.value = $("#cc_1").val();
        if (checkFieldEmpty(form.colorectcode))
        {
            alert("You have to at least select one of ICD-10 codes for Colorectal Cancer.");
            return false;
        }

        oneMoreChecked = true;
     }

      if (form.endometcheck.checked)
      {
           if (checkFieldEmpty(form.endometage))
           {
               alert("You have to enter a age of Endometrial Cancer.");
               form.endometage.focus();
               return false;
           }

          form.endometcode.value = $("#cc_2").val();
          if (checkFieldEmpty(form.endometcode))
          {
              alert("You have to at least select one of ICD-10 codes for Endometrial Cancer.");
              return false;
          }

          oneMoreChecked = true;
      }

      if (form.ovariancheck.checked)
      {
           if (checkFieldEmpty(form.ovarianage))
           {
               alert("You have to enter a age of Ovarian Cancer.");
               form.ovarianage.focus();
               return false;
           }

          form.ovariancode.value = $("#cc_3").val();
          if (checkFieldEmpty(form.ovariancode))
          {
              alert("You have to at least select one of ICD-10 codes for Ovarian Cancer.");
              return false;
          }

          oneMoreChecked = true;
      }

      if (form.pancreatcheck.checked)
      {
           if (checkFieldEmpty(form.pancreatage))
           {
               alert("You have to enter a age of Pancreatic Cancer.");
               form.pancreatage.focus();
               return false;
           }

          form.pancreatcode.value = $("#cc_4").val();
          if (checkFieldEmpty(form.pancreatcode))
          {
              alert("You have to at least select one of ICD-10 codes for Pancreatic Cancer.");
              return false;
          }

          oneMoreChecked = true;
      }

      if (form.prostatecheck.checked)
      {
           if (checkFieldEmpty(form.prostateage))
           {
               alert("You have to enter a age of Prostate Cancer.");
               form.prostateage.focus();
               return false;
           }

          form.prostatecode.value = $("#cc_5").val();
          if (checkFieldEmpty(form.prostatecode))
          {
              alert("You have to at least select one of ICD-10 codes for prostate Cancer.");
              return false;
          }

          oneMoreChecked = true;
      }

      if (form.othercheck.checked)
      {
           if (checkFieldEmpty(form.otherage))
           {
               alert("You have to enter a age of Other Cancers.");
               form.otherage.focus();
               return false;
           }

          form.othercode.value = $("#cc_6").val();
          if (checkFieldEmpty(form.othercode))
          {
              alert("You have to at least select one of ICD-10 codes for Other Cancer.");
              return false;
          }

          oneMoreChecked = true;
      }

      if (value==1 && oneMoreChecked==false)
      {
         alert("You have to at least select one or more cancers of personal history.");
         return false;
      }

     var totalRow = $("#id_familyhistory tr").length - 3;
     for (var i=0; i<totalRow; i++)
     {
        var init = eval("form.initial" + i);
        var ship = eval("form.relationship" + i);
        var side = eval("form.parentside" + i);
        var type = eval("form.cancertype" + i);
        var otype = eval("form.othertype" + i);
        var age = eval("form.diagnosisage" + i);
        if (!(checkFieldEmpty(init)
            && checkFieldEmpty(ship)
            && checkFieldEmpty(side)
            && (checkFieldEmpty(type)&&checkFieldEmpty(otype))
            && checkFieldEmpty(age))
            )
        {
            if (checkFieldEmpty(init))
            {
               alert("You have to enter Affected Relative's Initial.");
               init.focus();
               return false;
            }

            if (checkFieldEmpty(ship))
            {
               alert("You have to enter Relationship.");
               ship.focus();
               return false;
            }

            if (checkFieldEmpty(side))
            {
               alert("You have to enter Side of Parents.");
               side.focus();
               return false;
            }

            if (checkFieldEmpty(type)&&checkFieldEmpty(otype))
            {
               alert("You have to select one Type of Cancer OR enter Other Cancer.");
               type.focus();
               return false;
            }

            if (checkFieldEmpty(age))
            {
               alert("You have to enter Age of Diagnosis/Onset.");
               age.focus();
               return false;
            }
        }
     }

     return true;
}

function submitConsent(form, next)
{
  if (next=="next"||next=="save")
  {
    if (checkFieldEmpty(form.patientsign2) || form.patientsign2.value.length<15)
    {
         alert("The patient has to sign.");
//         setFocus(form.patientsign2);

         return false;
    }

    if (checkFieldEmpty(form.signdate2))
    {
         alert("The patient has to enter sign date.");
         setFocus(form.signdate2);

         return false;
    }

  }

  return true;
}

function clicicalCheck(form, value)
{
    var oneMoreChecked = false;
    if (form.breastcheck.checked)
    {
        if (checkFieldEmpty(form.breastage))
        {
            alert("You have to enter a age of Breast Cancer.");
            form.breastage.focus();
            return false;
        }

        form.breastcode.value = $("#cc_0").val();
        if (checkFieldEmpty(form.breastcode))
        {
            alert("You have to at least select one of ICD-10 codes for Breast Cancer.");
            return false;
        }

        oneMoreChecked = true;
    }

    if (form.colorectcheck.checked)
    {
        if (checkFieldEmpty(form.colorectage))
        {
            alert("You have to enter a age of Colorectal Cancer.");
            return false;
        }

        form.colorectcode.value = $("#cc_1").val();
        if (checkFieldEmpty(form.colorectcode))
        {
            alert("You have to at least select one of ICD-10 codes for Colorectal Cancer.");
            return false;
        }

        oneMoreChecked = true;
    }

    if (form.endometcheck.checked)
    {
        if (checkFieldEmpty(form.endometage))
        {
            alert("You have to enter a age of Endometrial Cancer.");
            form.endometage.focus();
            return false;
        }

        form.endometcode.value = $("#cc_2").val();
        if (checkFieldEmpty(form.endometcode))
        {
            alert("You have to at least select one of ICD-10 codes for Endometrial Cancer.");
            return false;
        }

        oneMoreChecked = true;
    }

    if (form.ovariancheck.checked)
    {
        if (checkFieldEmpty(form.ovarianage))
        {
            alert("You have to enter a age of Ovarian Cancer.");
            form.ovarianage.focus();
            return false;
        }

        form.ovariancode.value = $("#cc_3").val();
        if (checkFieldEmpty(form.ovariancode))
        {
            alert("You have to at least select one of ICD-10 codes for Ovarian Cancer.");
            return false;
        }

        oneMoreChecked = true;
    }

    if (form.pancreatcheck.checked)
    {
        if (checkFieldEmpty(form.pancreatage))
        {
            alert("You have to enter a age of Pancreatic Cancer.");
            form.pancreatage.focus();
            return false;
        }

        form.pancreatcode.value = $("#cc_4").val();
        if (checkFieldEmpty(form.pancreatcode))
        {
            alert("You have to at least select one of ICD-10 codes for Pancreatic Cancer.");
            return false;
        }

        oneMoreChecked = true;
    }

    if (form.prostatecheck.checked)
    {
        if (checkFieldEmpty(form.prostateage))
        {
            alert("You have to enter a age of Prostate Cancer.");
            form.prostateage.focus();
            return false;
        }

        form.prostatecode.value = $("#cc_5").val();
        if (checkFieldEmpty(form.prostatecode))
        {
            alert("You have to at least select one of ICD-10 codes for prostate Cancer.");
            return false;
        }

        oneMoreChecked = true;
    }

    if (form.othercheck.checked)
    {
        if (checkFieldEmpty(form.otherage))
        {
            alert("You have to enter a age of Other Cancers/Diagnosis.");
            form.otherage.focus();
            return false;
        }

        form.othercode.value = $("#cc_6").val();
        if (checkFieldEmpty(form.othercode))
        {
            alert("You have to at least select one of ICD-10 codes for Other Cancer/Diagnosis.");
            return false;
        }

        oneMoreChecked = true;
    }

    if (value==1 && oneMoreChecked==false)
    {
        alert("You have to at least select one or more cancers of personal history.");
        return false;
    }

    var totalRow = $("#id_familyhistory tr").length - 3;
    for (var i=0; i<totalRow; i++)
    {
        var init = eval("form.initial" + i);
        var ship = eval("form.relationship" + i);
        var side = eval("form.parentside" + i);
        var type = eval("form.cancertype" + i);
        var otype = eval("form.othertype" + i);
        var age = eval("form.diagnosisage" + i);
        if (!(checkFieldEmpty(init)
            && checkFieldEmpty(ship)
            && checkFieldEmpty(side)
            && (checkFieldEmpty(type)&&checkFieldEmpty(otype))
            && checkFieldEmpty(age))
            )
        {
            if (checkFieldEmpty(init))
            {
                alert("You have to enter Affected Relative's Initial.");
                init.focus();
                return false;
            }

            if (checkFieldEmpty(ship))
            {
                alert("You have to enter Relationship.");
                ship.focus();
                return false;
            }

            if (checkFieldEmpty(side))
            {
                alert("You have to enter Side of Parents.");
                side.focus();
                return false;
            }

            if (checkFieldEmpty(type)&&checkFieldEmpty(otype))
            {
                alert("You have to select one Type of Cancer OR enter Other Cancer/Diagnosis.");
                type.focus();
                return false;
            }

            if (checkFieldEmpty(age))
            {
                alert("You have to enter Age of Diagnosis/Onset.");
                age.focus();
                return false;
            }
        }
    }

    return true;
}

function onChangeCancerType(objSelect, objInput)
{
    var index = objSelect.name.substr(10);//
    var objOther = eval("document.testform.othertype" + index);
    objOther.disabled = objSelect.selectedIndex<(objSelect.length-1);
}

function onCancerChange(objCheck, idhtml)
{
    if (objCheck.checked)
    {
       $('#id_' + idhtml).show();

       $("#cc_"+idhtml).ultraselect({selectAll: false});
    }
    else
    {
       $('#id_' + idhtml).hide();
    }
}

function addMoreHistoryRow()
{
   var rowIndex = "" + ($("#id_familyhistory tr").length - 3);
//alert("rowIndex=" + rowIndex);
   var row = $('#id_addinghistoryrow').html();
   var start = row.indexOf("<tr");
   var end = row.lastIndexOf("</tr>");
   var data = row.substr(start, end+5).replace(/XXX/g, rowIndex);

   $('#id_familyhistory').append(data);

   return false;
}

function addMoreResultRow()
{
   var rowIndex = "" + $("#id_testresult tr").length;
//alert("rowIndex=" + rowIndex);
   var row = $('#id_addingtestrow').html();
   var start = row.indexOf("<tr");
   var end = row.lastIndexOf("</tr>");
   var data = row.substr(start, end+5).replace(/XXX/g, rowIndex);

   $('#id_testresult').append(data);

   return false;
}

function addMoreFindingRow()
{
   var rowIndex = $("#id_specialfinding tr").length;
//alert("rowIndex=" + rowIndex);
   var row = $('#id_findingtestrow').html();
   var start = row.indexOf("<tr");
   var end = row.lastIndexOf("</tr>");
   var data = row.substr(start, end+5).replace(/XXX/g, (rowIndex+200));

   $('#id_specialfinding').append(data);

   return false;
}

function onChangeCancerType(objSelect, objInput)
{
   objInput.disabled = objSelect.selectedIndex<(objSelect.length-1);
}

function submitPaypalForm(form1, form2, idleUrl)
{
   form1.onlinepay.disabled = true;

   startIdleLoop(idleUrl, 20);
   form2.submit();

   return false;
}

var g_timerid = 0;
var g_lCount = 0;
function startIdleLoop(idleUrl, sec)
{
   g_timerid = setInterval("idleLoop('" + idleUrl + "')", sec*1000);
}

function idleLoop(idleUrl)
{
   g_lCount++;
   var sUrl = idleUrl + "&count=" + g_lCount;
//lert("sUrl=" + sUrl);
   var json = getAjaxJson(sUrl, false);
//alert("json = " + Json);
   if (json.ret)
   {
      clearInterval(g_timerid);
      g_timerid = 0;

      finishTask(json);
   }
}

function getAjaxJson(sUrl)
{
    var json = null;
    $.ajax({
        url: sUrl,
        method: 'get',
        async: false,
        success: function (content) {
           json = eval("(" + content + ")");
        }
    });

    return json;
}

//function openSignPad(form, idhtml)
//{
//    $('#sig').signature();//{guideline: true, guidelineOffset: 25, guidelineIndent: 20, guidelineColor: '#ff0000'});
//    if (form.phy_sign.value.length>8)
//    {
//        $('#sig').signature('draw', form.phy_sign.value);
//    }
//
//    $('#clear').click(function() {
//        $('#sig').signature('clear');
//        return false;
//    });
//
//    $('#json').click(function() {
//        alert($('#sig').signature('toJSON'));
//       return false;
//    });
//    $('#svg').click(function() {
//        alert($('#sig').signature('toSVG'));
//        return false;
//    });
//  $("#myModal").modal('show');
//}

//function saveSignature(form, url, idhtml)
//{
//    form.phy_sign.value = $('#sig').signature('toJSON');
//
//    if (form.phy_sign.value.length>8)
//    {
//        var imageUrl = url + "&type=Vector&data=" + encodeURIComponent(form.phy_sign.value);
//        var imageTag = "<img src='" + imageUrl + "' height='44'>";
//        $('#'+ idhtml).html(imageTag);
//    }
//    else
//    {
//        $('#'+ idhtml).html("");
//    }
//
//    return true;
//}

//<!--script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script-->
//var postApp = angular.module('postApp', []);
//postApp.controller('postController', function($scope, $http) {
//	$scope.user = {};
//	$scope.submitForm = function() {
//	$http({
//	  method  : 'POST',
//	  url     : '/Provider?act=test',
//      data    : $scope.user, //forms user object
//	  headers : {'Content-Type': 'application/x-www-form-urlencoded', 'Content-Action': 'tryGetPasswordByEmail'}
//	 })
//
//	 .then(function mySuccess(response) {
//alert("response.data.message=" + response.data.message);
//
//         $scope.postMessage = response.data.message;
//      }, function myError(response)  {
//        $scope.postMessage =  response.statusText;
//      });
//	};
//});