<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onCategoryLoad(form)
{
  form.name.focus();
  form.name.select();
}

function ColorSelect(form, colortheme)
{
   for(i=0; i<form.colortheme.length; i++)
   {
      if (form.colortheme.options[i].value==colortheme)
      {
         form.colortheme.selectedIndex = i;
         break;
      }
   }
}

function onChangeSelectColor(form)
{
  form.backcolor.value = form.selbackcolor.options[form.selbackcolor.selectedIndex].value;
}

function viewSampleImage(form, type)
{
  var url = "../util/displayimage.jsp?type=" + type + "&value=" + form.layoutid.value;
//alert("url = " + url);
  popUp(url);
}

function popUp(url)
{
  var newWin = window.open(url,"imagewin",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=630,height=610');
}

function validateCategory(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter name of category.");
    setFocus(form.name);
    return false;
  }

  return true;
}