<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onSiteSettingFormLoad(form)
{
//    setFocus(form.response);
}

function validateSiteSetting(form)
{
 try {
  if (checkFieldEmpty(form.sitename))
  {
    alert("You have to enter a site name or domain name.");
    setFocus(form.sitename);
    return false;
  }

    //. Load file status progress window
  if (form.topbar.options[form.topbar.selectedIndex].value>1)
  {
    if (checkFieldEmpty(form.topbarcode))
    {
      alert("You have to enter html code.");
      setFocus(form.topbarcode);
      return false;
    }
  }

  if (form.googleadsenseid!=null)
  {
      var nValue = form.adsbarfly.options[form.adsbarfly.selectedIndex].value;
      form.advertisebar.value = nValue;
      if (nValue>0 && nValue<64)
      {
        if (checkFieldEmpty(form.googleadsenseid))
        {
          alert("You have to enter a Google AdSense ID.");
          setFocus(form.googleadsenseid);
          return false;
        }

        var nCheckValue = getMultipleCheckboxValue(form, "googleads_");
        if (nCheckValue==0)
        {
            alert("You have to select one place to show google ad.");
            form.googleads_1.focus();
            return false;
        }

        form.advertisebar.value = nCheckValue;
      }
      else if (nValue>64)
      {
        if (checkFieldEmpty(form.advertisecode))
        {
          alert("You have to enter advertise html code.");
          setFocus(form.advertisecode);
          return false;
        }
      }
  }
     
//  if(form.bkimage.value.length>0 ||form.lgimage.value.length>0)
//    loadStatusPage(" site setting files");
//  else
    showProcessBar();

  return true;
 }
 catch (ex)
 {
   showException(ex, "validateSiteSetting()");
   return false;
 }

}

function validatePublish(form)
{
  if (!confirm('Do you want to publish the changes? All the current settings of the website will be replaced with new settings.'))
     return false;
  else
  {
    showProcessBar();
    return true;
  }
}

function onSelectFlagChange(form, objSelect, secName0, secName1, secName2)
{
  var nValue = objSelect.options[objSelect.selectedIndex].value;

  if (nValue==0)
  {
    showHideSpan('open', secName0);
    showHideSpan('close', secName1);
    showHideSpan('close', secName2);
  }
  else if (nValue==1)
  {
    showHideSpan('close', secName0);
    showHideSpan('open', secName1);
    showHideSpan('close', secName2);

    setFocus(form.lgimage);
  }
  else //if (nValue==1)
  {
    showHideSpan('close', secName0);
    showHideSpan('close', secName1);
    showHideSpan('open', secName2);

    setFocus(form.topbarcode);
  }
}

function onSelectFlagChange2(form, objSelect, secName0, secName1, secName2)
{
  var nValue = objSelect.options[objSelect.selectedIndex].value;
//alert("nValue=" + nValue);
  if (nValue==0)
  {
    showHideSpan('open', secName0);
    showHideSpan('close', secName1);
    showHideSpan('close', secName2);
  }
  else if (nValue>0 && nValue<64)
  {
    showHideSpan('close', secName0);
    showHideSpan('open', secName1);
    showHideSpan('close', secName2);

    form.googleadsenseid.focus();
  }
  else //if (nValue==1)
  {
    showHideSpan('close', secName0);
    showHideSpan('close', secName1);
    showHideSpan('open', secName2);

   form.advertisecode.focus();
  }
}

function viewMenuLayout(sValue, sUrl1)
{
  if (sValue==0)
  {
     alert("You have to select one of menu layout.")
     return;
  }

//  var sUrl = "ser/util/showfile.jsp?action=Show File&type=verticalmenu" + "&value=" + sValue;
  var sUrl = "ser/util/showpopupimage.jsp?action=Show File&type=verticalmenu" + "&value=" + sValue;
  showImageFile("SampleWin", "Vertical Menu Layout", sUrl, 240, 300);
}
