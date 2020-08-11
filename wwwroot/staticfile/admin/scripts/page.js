<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onPageLoad(form)
{
  setFocus(form.name);
}

function validatePage(form)
{
  if (checkFieldEmpty(form.name))
  {
     alert("You have to enter page name.");
     setFocus(form.name);
     return false;
  }

  if (form.type.selectedIndex==0)
  {
    updateTextArea('text');
    if (checkFieldEmpty(form.text))
    {
       alert("You have to input some content.");
       setEditorFocus('text');
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
  window.location.href = "page.jsp?action=Change Type&type=" + objSelect.options[objSelect.selectedIndex].value+"&curaction=" + sPreAction;
}