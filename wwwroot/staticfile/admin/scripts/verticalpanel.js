<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onPanelFormLoad(form)
{
  setFocus(form.title);
}

function validatePanelForm(form)
{
  if (checkFieldEmpty(form.title))
  {
    alert("You have to enter a title of panel.")
    setFocus(form.title);
    return false;
  }

  return true;
}

function viewSampleMenu(form, type)
{
  var url = "../util/displayimage.jsp?type=" + type + "&value=" + form.layout.value;
//  popUpBrowser(url, 100, 300)
  var newWin = window.open(url,"imagewin",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=385,height=365');
}
