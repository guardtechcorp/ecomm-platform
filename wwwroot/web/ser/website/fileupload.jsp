<%@ page import="com.zyzit.weboffice.util.*"%>
<%
{
//System.out.println("sRealAction=" + sRealAction);
    if ("Upload_WebFiles".equalsIgnoreCase(sRealAction))
    {
        if (!ret.isSuccess())
        {
            sDisplayMessage = (String)ret.getInfoObject();
            nDisplay = 0;
        }
        else
        {
            sDisplayMessage = (String)ret.getInfoObject();
        }
//System.out.println("sDisplayMessage=" + sDisplayMessage);
    }

    if ("Yes".equalsIgnoreCase(request.getParameter("stopupload")))
    {
       sDisplayMessage = request.getParameter("error");
       nDisplay = 0;
    }

    String sFileType = "*";
    if (arAt.length>1)
       sFileType = arAt[1];
    String sFileTypeMessage = "";
    if (!sFileType.equalsIgnoreCase("*"))
       sFileTypeMessage = " and file extension is only allowed <b>"+sFileType+"</b>";

    int nFileMaxSize = 5*1024; //(KB)
    if (arAt.length > 6)
       nFileMaxSize = Utilities.getInt(arAt[6], nFileMaxSize);
    String sAjaxCheckUrl = fileWeb.encodedUrl("ajax/response.jsp?action=CheckFileExist_UploadFile&subdir=file/" + wpInfo.FileStorage);
//   fileWeb.remvoeProcessStatus();
 %>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/filestorage.js"></SCRIPT>
<FORM name="form_uploadfile" method="post" action="<%=fileWeb.encodedUrl("index.jsp?action=Upload_WebFiles&maxsize="+nFileMaxSize)%>" enctype="multipart/form-data" onSubmit="return validateUploadStorageFile(this, '<%=sFileType%>', '<%=sAjaxCheckUrl%>');">
 <INPUT type="hidden" name="pid" value=<%=wpInfo.PageID%>>
 <input type="hidden" name="subdir" value="file/<%=wpInfo.FileStorage%>">
 <input type="hidden" name="senderid" value="<%=mbInfo!=null?mbInfo.MemberID:-1%>">
 <table width="100%" align="center">
 <TR>
   <TD colspan="2" height="25" align="center"><font size="3"><strong>Upload Your File</strong></font></TD>
 </TR>
 <tr>
  <td>
   <%@ include file="../util/uploadprocess.jsp"%>
  </td>
 </tr>
 <tr>
  <td>
  <SPAN id="WorkingSection">
   <TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
     <TR>
       <TD colspan="2" height="1">
       <%@ include file="../include/information.jsp"%>
      </TD>
     </TR>
     <tr>
      <td align="right" width="18%" height="25">* Upload File Name:&nbsp;</td>
      <td><input type="file" name="browserfile" size="75" onChange="onBrowserNewFile(document.form_uploadfile, this.value)"></td>
     </tr>
     <tr>
      <td align="right" width="18%" height="25">Targe File Name:&nbsp;</td>
       <td><input style="width:550px;" value="" name="file_name_0"></td>
     </tr>
     <tr>
      <td align="right" width="18%" height="25">Title:&nbsp;</td>
      <td><input style="width:550px;" value="<%=Utilities.getValue(request.getParameter("file_title_0"))%>" name="file_title_0"></td>
     </tr>
    <tr>
     <td align="right" width="18%" valign="top">Description:&nbsp;</td>
     <td><textarea rows="3" style="width:550px;" wrap="virtual" name="file_description_0"><%=Utilities.getValue(request.getParameter("file_description_0"))%></textarea></td>
    </tr>
    <tr>
     <td align="right" width="18%" height="25"></td>
     <td>(Note: Max file size is up to <b><%=nFileMaxSize%></b> KB<%=sFileTypeMessage%>.)</td>
    </tr>
    <!--tr>
    <td colspan=2 valign="top"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
    </tr-->
    <tr>
    <td colspan=2 height="10"></td>
    </tr>
    <tr>
     <td colspan=2 align="center">
       <input type="submit" name="submit" style='width:120px' value="Upload Now">
    </td>
    </tr>
    </TABLE>
  </SPAN>
  </td>
 </tr>
</table>
</form>
<SCRIPT>onUploadFileFormLoad(document.form_uploadfile);</SCRIPT>
<% } %>