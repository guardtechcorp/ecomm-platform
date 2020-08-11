<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onProductLoad(form)
{
//alert("form.refinedregion.value="+form.refinedregion.value);
    setCheckboxes(form, "country_", form.refinedregion.value);

    form.name.focus();
    form.name.select();
}

function validateProduct(form)
{
try {
 if (checkFieldEmpty(form.name))
 {
    alert("You have to enter name of product.");
    setFocus(form.name);
    return false;
 }

 //updateTextArea('description');  
 if (checkFieldEmpty(form.description))
 {
    alert("You have to input description.");
    setFocus(form.description);
    return false;
 }

 if (!checkImageFileType(form.small, true))
 {
     setFocus(form.small);
     return false;
 }

  if (!checkImageFileType(form.medium, true))
  {
     setFocus(form.medium);
     return false;
  }

  if (!checkImageFileType(form.large, true))
  {
     setFocus(form.large);
     return false;
  }

/*  
//  var nCount = getMultipleOptionSelectCount(form.categoryoptions);
  var nCount = getMultipleCheckboxCount(form, "cat_");
  if (nCount==0)
  {
     alert("You have to at least select one of categories.");
//     form.categoryoptions.focus();
     return false;
  }
*/

//  form.category.value = getMultipleOptionIds(form.categoryoptions, ',');
  form.category.value = getMultipleCheckboxIds(form, "cat_", ',');
//alert(form.category.value);

  form.refinedregion.value = getMultipleCheckboxIds(form, "country_", ',');
  if (form.refinedregion.value.length>0)
     form.refinedregion.value += ",";
//alert("refinedregion=" + form.refinedregion.value);   

    //. Load file status progress window
  if(form.small.value.length>0
    ||form.medium.value.length>0
    ||form.large.value.length>0)
  {
    loadStatusPage(" product files");
  }
  else
  {
    showProcessBar();
  }
    
  return true;
}
catch (e)
{
  alert("An exception occurred in the functon: validateProduct()\nError name: " + e.name + "\nError message: " + e.message);
  return false;
}

}

function onCategoryFormLoad(form)
{
//alert("form.refinedregion.value="+form.refinedregion.value);
    form.name.focus();
    form.name.select();
}

function validateCategory(form)
{
 if (checkFieldEmpty(form.name))
 {
    alert("You have to enter name of category.");
    setFocus(form.name);
    return false;
 }

  showProcessBar();
  return true;
}



