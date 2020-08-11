<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

var g_nTotalSelection = 0;
function onFormLoad(form, nTotal)
{
  g_nTotalSelection = nTotal;
  showSelection();
}

function showSelection()
{
//   if (eval("document.all.totalselection")!=null)
/*
   if (g_nTotalSelection>0)
     document.getElementById('totalselection').innerHTML = "<font color='#ffff00'><b>"+ g_nTotalSelection + "</b></font> is selected";
   else
     document.getElementById('totalselection').innerHTML = "";
*/
  displaySelection(g_nTotalSelection);
}

function displaySelection(nTotalSelection)
{
//   if (eval("document.all.totalselection")!=null)
  document.getElementById('totalselection').innerHTML = "<font color='#000000'><b>"+ nTotalSelection + "</b></font> selected";
}

function clickCheckBox(objCheckBox, form)
{
  highlightCheckedRow(objCheckBox)
  if (objCheckBox.checked)
     g_nTotalSelection++;
  else
     g_nTotalSelection--;

  showSelection(form);
}

function submitSwitchPage2(form, rpp, page)
{
  form.rpp.value = ""+rpp;
   form.page.value = ""+page;
   if (form.sort!=null)
   {
      form.sort.disabled = "true";
      form.asc.disabled = "true";
   }

   form.checkboxes.value = "";
   for (var i=0;i<form.elements.length;i++)
   {
     var e = form.elements[i];
     if ((e.type=='checkbox') && (e.name!= "allbox"))
     {
       if (form.checkboxes.value.length>0)
          form.checkboxes.value += ",";
       form.checkboxes.value += e.name;
     }
   }

   form.submit();
}

function checkAll(form, obj)
{
  var nBefore = 0;
  for (var i=0;i<form.elements.length;i++)
  {
      var e = form.elements[i];
      if ((e.name!= obj.name) && (e.type=='checkbox'))
      {
         if (e.checked)
            nBefore++;
      }
  }

  selectAll(form, obj);

  var nAfter = 0;
  for (var i=0;i<form.elements.length;i++)
  {
      var e = form.elements[i];
      if ((e.name !=  obj.name) && (e.type=='checkbox'))
      {
         if (e.checked)
            nAfter++;
      }
   }

   g_nTotalSelect += (nAfter - nBefore);
   showSelection();
}

function onSubmitAction(form, value)
{
  form.action.value = value;

  form.checkboxes.value = "";
  for (var i=0;i<form.elements.length;i++)
  {
    var e = form.elements[i];
    if ((e.type=='checkbox') && (e.name!= "allbox"))
    {
      if (form.checkboxes.value.length>0)
         form.checkboxes.value += ",";
      form.checkboxes.value += e.name;
    }
  }

}
