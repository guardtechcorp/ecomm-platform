<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="../../scripts/fileupload.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.FileUploadBean"%>
<%
  FileUploadBean bean = new FileUploadBean(session);
//bean.showAllParameters(request, out);
  boolean bSuccessful = true;
  String sDisplayMessage = null;
  if (bean.isMultiPartForm(request))
  {
    FileUploadBean.Result ret = bean.fileUpload(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      bSuccessful = false;
    }
    else
    {
      Map hmParameter = (Map)ret.getUpdateInfo();

      String sUrl = "product.jsp?action=uploadimage" + "&imagesize="+hmParameter.get("imagesize")+"&filename="+hmParameter.get("filename-0");
      response.sendRedirect(sUrl);
    }
  }
%>
<a href="product.jsp?action=cancelupload">Product</a> > <b>Image Upload</b>
<p>The form below will allow you to upload image file from your disk to your website.</p>
<form name="fileupload" action="fileupload.jsp" method=post enctype=multipart/form-data onsubmit="return validateFileType(this);">
  <input type="hidden" name="imagesize" value="<%=request.getParameter("imagesize")%>">
  <table width="55%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center" height="372">
    <tr>
      <th class="thHead" colspan="3" height="2">File Upload</th>
    </tr>
    <tr>
      <td width="0%" class="row1" height="119">&nbsp;</td>
      <td width="97%" class="row1" height="119">
        <p><b>1.</b> Click on Browse to choose a file from your disk.<br>
          <br>
          <input type="file" size=30 name="filename">
          <br>
          <br>
          <b>2.</b> After selecting a file, click on Upload File to upload it.<br>
        </p>
        <p>
          <input type="submit" name="action" value="Upload File">
      </td>
      <td width="3%" height="119" class="row1">&nbsp;</td>
    </tr>
    <tr>
      <td width="0%" height="2" class="row1">&nbsp;</td>
      <td width="97%" height="2" class="row1"><br>If you don't
        see a Browse button, then your browser doesn't support file uploads, and
        you should click on Cancel instead.
        <p>Uploading multiple images requires specific image types and image names. Read the multiple image upload
          requirements.<br>
          <br>
          <strong>Note</strong>: Image files have the following limitations:
        </p>
        <ul>
          <li>2MB file size
          <li>2000 pixels in height or width
          <li>2 million pixels total ></li>
        </ul>
        We strongly recommend use of GIF and JPG/JPEG
        file formats for cross-platform compatibility. </td>
      <td width="3%" height="2" class="row1">&nbsp;</td>
    </tr>
  </table>
</form>
<%@ include file="../share/footer.jsp"%>
