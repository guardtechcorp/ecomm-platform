<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/fileupload.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.FileUploadBean"%>
<%
  FileUploadBean bean = new FileUploadBean(session);

//bean.dumpAllParameters(request);
  String sDisplayMessage = null;
  String sRelativeUrl = null;
  if (bean.isMultiPartForm(request))
  {
    FileUploadBean.Result ret = bean.fileUploadFile(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
    }
    else
    {
      Map hmParameter = (Map)ret.getUpdateInfo();
      sRelativeUrl = "http://" + bean.getDomainName() + (String)hmParameter.get("filename-0");
//System.out.println("sRelativeUrl=" + sRelativeUrl);
    }
  }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>File Upload</title>
</head>
<script language="JavaScript" type="text/javascript">
function validateFile(form)
{
  if (form.filename.value.length==0)
  {
    alert("You have to browse file first.");
    return false;
  }

  showHideSpan('close','uploaddialog');
  showHideSpan('open','Processing');
  return true;
}

function updateFile(sUrl)
{
//alert("window=" + window);
//alert("window.dial=" + window.dialogArguments);
  if (typeof (window.dialogArguments) != "undefined")
  {
    var oMyObject = window.dialogArguments;
    var parentWin = oMyObject.parentWin;
    parentWin.updateUrl(sUrl);
  }
  else
    window.opener.updateUrl(sUrl);
  window.close();
}
</script>
<body bgcolor="#EEEEEE" marginwidth="2" marginheight="2" topmargin="1" leftmargin="2">
<% if (sRelativeUrl!=null) { %>
<script language="JavaScript" type="text/javascript">
  updateFile('<%=sRelativeUrl%>');
</script>
<% } else { %>
<%@ include file="../share/waitprocess.jsp"%>
<DIV id="uploaddialog">
<form name="fileupload" action="fileupload.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateFile(this);">
  <input type="hidden" name="subdir" value="<%=Utilities.getValue(request.getParameter("subdir"))%>">
  <table width="390" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <td colspan="3" height="35" align="center"><strong>File Upload</strong></td>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td colspan="3" align="center"><font color="red"><%=sDisplayMessage%></font></td>
    </tr>
<% } %>
    <tr>
      <td width="0%" >&nbsp;</td>
      <td width="97%"><font size=2>
         <p><b>1.</b> Click on Browse to choose a file from your disk.
         <p><input type="file" size="40" name="filename">
         <p><b>2.</b> After selecting a file, click on Upload File to upload it.
         <p><input type="submit" name="action" value="Upload File">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" value="Cancel" onClick="window.close();"></font>
      </td>
      <td width="3%">&nbsp;</td>
    </tr>
    <tr>
      <td width="0%">&nbsp;</td>
      <td width="97%"><font size=2><br><strong>Note:</strong> If you don't see a Browse button, then your browser
        doesn't support file uploads, and you should click on Cancel instead. The file size can not exceed 50 MB.</font>
      </td>
      <td width="3%"></td>
    </tr>
  </table>
</form>
</DIV>
<% } %>
</body>
</html>