<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onLinkFormLoad(form)
{
//alert("form.title=" + form.title.value);
//  setFocus(form.title);
}

function validateLinkForm(form)
{
  if (checkFieldEmpty(form.title))
  {
    alert("You have to enter a title of link.")
    setFocus(form.title);
    return false;
  }

  if (form.type.selectedIndex==null)
     return true;

  if (form.type.selectedIndex==0)
  {
    updateTextArea('content');
    if (checkFieldEmpty(form.content))
    {
       alert("You have to input some content.");
       setEditorFocus('content');
       return false;
    }
  }
  else  if (form.type.selectedIndex==1)
  {
    if (checkFieldEmpty(form.filename)&&checkFieldEmpty(form.uploadfile))
    {
      alert("You have to browser a file first.");
      setFocus(form.filename);
      return false;
    }
  }
  else
  {
    if (checkFieldEmpty(form.linkurl))
    {
      alert("You have to enter a Url.");
      setFocus(form.linkurl);
      return false;
    }
  }

  return true;
}

function onSelectTypeChange(objSelect, sPreAction)
{
//alert("linkpage.jsp?action=Change Type&type=" + objSelect.options[objSelect.selectedIndex].value+"&curaction=" + sPreAction);
  window.location.href = "linkpage.jsp?action=Change Type&type=" + objSelect.options[objSelect.selectedIndex].value+"&curaction=" + sPreAction;
}
