<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onBookLoad(form)
{
  form.name.focus();
  form.name.select();
}

function validateBook(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter name of book.");
    setFocus(form.name);
    return false;
  }

  return true;
}

function onBookItemLoad(form)
{
  setFocus(form.name);
}

function validateBookItem(form, sDateFrom, sDateTo)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter name of book item.");
    setFocus(form.name);
    return false;
  }

  var nCateID = form.cateid.options[form.cateid.selectedIndex].value;
  if ("-1"==nCateID)
  {
    alert("You have to define at least a category.");
//    setFocus(form.cateid);
    return false;
  }

  if (checkFieldEmpty(form.amount))
  {
    alert("You have to enter a value of amount.");
    setFocus(form.amount);
    return false;
  }

  if (checkFieldEmpty(form.when))
  {
    alert("You have to enter a occur date.");
    setFocus(form.when);
    return false;
  }

  if (form.when.value < sDateFrom || form.when.value > sDateTo)
  {
    alert("The occur date you entered is out of range.");
    return false;
  }

  return true;
}

function onBookCategoryLoad(form)
{
  form.name.focus();
  form.name.select();
}

function validateBookCategory(form)
{
  if (checkFieldEmpty(form.name))
  {
    alert("You have to enter name of category.");
    setFocus(form.name);
    return false;
  }

  return true;
}

function makeDefaultMultpleSelect(objField, sValue)
{
//alert("objField=" + objField);
  objField.value = sValue;
}


