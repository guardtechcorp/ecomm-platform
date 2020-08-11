<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onConfigLoad(form)
{
    form.logoname.focus();
    form.logoname.select();
}

function selectColor(textfield)
{
  var color = document.all.htmleditor.ChooseColorDlg();
  var hexColor = color.toString(16);
  if (hexColor.length < 6)
     hexColor = "000000".substring(0, 6 - hexColor.length) + hexColor;
  textfield.vlaue = hexColor;
//  eval(form + "." + textfield + ".value") = hexColor;
//  return hexColor;
}

function viewSampleTitle(form, type)
{
  var url = "../util/displayimage.jsp?type=" + type + "&value=" + form.layoutid.value;
//  popUp(url);
  var newWin = window.open(url,"imagewin",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=810,height=175');
}

function viewSampleMenu(form, type)
{
  var url = "../util/displayimage.jsp?type=" + type + "&value=" + form.categorymenuid.value;
//  popUpBrowser(url, 100, 300)
  var newWin = window.open(url,"imagewin",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=385,height=365');
}

function popUpBrowser(url, nWidth, nHeight)
{
  var newWin = window.open(url,"imagewin",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,'+
                           + 'width='+nWidth+',height='+nHeight);
}

function popUp(url)
{
  var newWin = window.open(url,"imagewin",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=810,height=175');
}

function OnSelectNewProducts(form)
{
    if (form.newarrivals.selectedIndex==0)
    {
       setFocus(form.newname);
    }
}

function OnSelectHotProducts(form)
{
    if (form.hotproducts.selectedIndex==0)
    {
       setFocus(form.hotname);
    }
}

function OnSelectBestProducts(form)
{
    if (form.bestsellers.selectedIndex==0)
    {
       setFocus(form.bestname);
    }
}


function OnSelectNewsArea(form)
{
    if (form.newsarea.selectedIndex==0)
    {
       setFocus(form.newscontent);
    }
}

function OnSelectTellFriend(form)
{
  if (form.tellfriend.selectedIndex==0)
  {
    setFocus(form.emailcontent);
  }
}

function onSelectFlagChange(objSelect, secName)
{
  if (objSelect.selectedIndex<objSelect.length-1)
    showHideSpan('open', secName);
  else
    showHideSpan('close', secName);
}

function onSelectFlagChange2(objSelect, secName1, secName2)
{
  if (objSelect.selectedIndex==0)
  {
//    showHideSpan('open', secName2);
    showHideSpan('close', secName1);
  }
  else if (objSelect.selectedIndex==1)
  {
    showHideSpan('open', secName1);
//    showHideSpan('close', secName2);
  }
  else// if (objSelect.selectedIndex=2)
  {
    showHideSpan('close', secName1);
//    showHideSpan('close', secName2);
  }
}

function validateConfig(form)
{
  if (!validateStep1(form))
     return false;
  if (!validateStep2(form))
     return false;
  if (!validateStep3(form))
     return false;
  if (!validateStep4(form))
     return false;
  if (!validateStep5(form))
     return false;
  if (!validateStep6(form))
     return false;
  if (!validateStep7(form))
     return false;

  return true;
}

function validateStep1(form)
{
  return true;
}
function validateStep2(form)
{
  if (form.newarrivals.selectedIndex==0)
  {
     if (checkFieldEmpty(form.newname))
     {
       alert("You have to enter an name for new products.");
       setFocus(form.newname);
       return false;
     }
  }

  if (form.hotproducts.selectedIndex==0)
  {
     if (checkFieldEmpty(form.hotname))
     {
       alert("You have to enter an name for hot products.");
       setFocus(form.hotname);
       return false;
     }
  }

  if (form.bestsellers.selectedIndex==0)
  {
     if (checkFieldEmpty(form.bestname))
     {
       alert("You have to enter an name for best sale products.");
       setFocus(form.bestname);
       return false;
     }
  }

  return true;
}

function validateStep3(form)
{
  if (form.advertisebar.selectedIndex==0)
  {
     if (checkFieldEmpty(form.advertise)&&checkFieldEmpty(form.advertiseimage)&&checkFieldEmpty(form.advertisecode))
     {
       alert("You have to upload a image file or input some html code on Html Code field.");
       setFocus(form.advertisecode);
       return false;
     }
  }

  return true;
}

function validateStep4(form)
{
  return true;
}

function validateStep5(form)
{
  if (form.membership.selectedIndex==0)
  {
     if (checkFieldEmpty(form.memberareaname))
     {
       alert("You have to enter an name for membership title.");
       setFocus(form.memberareaname);
       return false;
     }
  }

  return true;
}

function validateStep6(form)
{
  if (form.bottombar.selectedIndex==1)
  {
     if (checkFieldEmpty(form.bottom)&&checkFieldEmpty(form.bottombarimage)&&checkFieldEmpty(form.bottomcode))
     {
       alert("You have to upload a image file or input some html code on Html Code field.");
       setFocus(form.bottomcode);
       return false;
     }
  }

  return true;
}

function validateStep7(form)
{
  return true;
}