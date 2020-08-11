<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onProductLoad(form, colortheme)
{
    ColorSelect(form, colortheme);

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

function onDeliveryChange(objSelect, section)
{
  if (objSelect.options[objSelect.selectedIndex].value=='1')
    showHideSpan('open',section);
  else
    showHideSpan('close',section);
}

function validateProduct(form)
{
 if (checkFieldEmpty(form.name))
 {
    alert("You have to enter name of product.");
    setFocus(form.name);
    return false;
 }

 if (checkFieldEmpty(form.price))
 {
    alert("You have to enter price.");
    setFocus(form.price);
    return false;
 }

  if (!checkFileType(form.small, true))
  {
     setFocus(form.small);
     return false;
  }

  if (!checkFileType(form.medium, true))
  {
     setFocus(form.medium);
     return false;
  }

  if (!checkFileType(form.large, true))
  {
     setFocus(form.large);
     return false;
  }

  if (checkFieldEmpty(form.description))
  {
      alert("You have to input description.");
      setFocus(form.description);
      return false;
  }

    var filename = getFilenameOnly(form.small.value);
    if (filename.length>0)
       form.smallimage.value = filename;
    filename = getFilenameOnly(form.medium.value);
    if (filename.length>0)
       form.mediumimage.value = filename;
    filename = getFilenameOnly(form.large.value);
    if (filename.length>0)
       form.largeimage.value = filename;

//alert("form.smallimage.value=" + form.smallimage.value);

  showHideSpan('close','ProductInfomation');
  showHideSpan('open','Processing');

  return true;
}

function validateProduct2(form)
{
 if (checkFieldEmpty(form.name))
 {
    alert("You have to enter name of product.");
    setFocus(form.name);
    return false;
 }

// if (checkFieldEmpty(form.price))
// {
//    alert("You have to enter price.");
//    setFocus(form.price);
//    return false;
// }

  if (!checkFileType(form.small, true))
  {
     setFocus(form.small);
     return false;
  }

  if (!checkFileType(form.medium, true))
  {
     setFocus(form.medium);
     return false;
  }

  if (!checkFileType(form.large, true))
  {
     setFocus(form.large);
     return false;
  }

  if (checkFieldEmpty(form.description))
  {
      alert("You have to input description.");
      setFocus(form.description);
      return false;
  }

  var filename = getFilenameOnly(form.small.value);
  if (filename.length>0)
     form.smallimage.value = filename;
  filename = getFilenameOnly(form.medium.value);
  if (filename.length>0)
     form.mediumimage.value = filename;
  filename = getFilenameOnly(form.large.value);
  if (filename.length>0)
     form.largeimage.value = filename;
//lert("form.smallimage.value=" + form.smallimage.value + ", " + form.largeimage.value);

  showHideSpan('close','ProductInfomation');
  showHideSpan('open','Processing');

  return true;
}

function getFilenameOnly(pathfilename)
{
    var nIndex = pathfilename.lastIndexOf("/");
    if (nIndex==-1)
       nIndex = pathfilename.lastIndexOf("\\");
    if (nIndex!=-1)
       return pathfilename.substr(nIndex+1);
    else
       return pathfilename;
}

function onMemberPriceLoad(form)
{

}

function validateMemberPrice(form)
{

}
