<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function validateFileType(form)
{
  return checkFileType(form.filename, false);
}

function checkFileType(objFile, allEmpty)
{
    var sFile = objFile.value;
    if (sFile.length>0)
    {
      if (sFile.toLowerCase().indexOf(".gif")!=-1||sFile.toLowerCase().indexOf(".jpg")!=-1||sFile.toLowerCase().indexOf(".jpeg")!=-1||sFile.toLowerCase().indexOf(".jpe")||sFile.toLowerCase().indexOf(".png"))
         return true
      else
      {
         alert("The selected file is invalid.");
         return false;
      }
    }
    else
    {
      return allEmpty;
    }
}

