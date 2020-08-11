<%@ page import="java.io.File"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean"%>
<%
//  request.setCharacterEncoding("utf-8");
//  response.setCharacterEncoding("utf-8");

  MemberFileBean bean = MemberFileBean.getObject(session);
//  bean.setConfigInfo(sn, cfInfo);  

//bean.showAllParameters(request, out);
//MemberFileBean.dumpAllParameters(request);
//sRealAction = "FileUpload_Command_Storage";
  boolean bSelection = true;
  if (sRealAction.indexOf("_Command_")!=-1)//startsWith("Upload File"))
  {
      bSelection = false;
      if (!ret.isSuccess())
      {
        Errors errObj = (Errors)ret.getInfoObject();
        sDisplayMessage = errObj.getError();
        nDisplay = 0;
      }
      else
      {
        //The file 'Online Journal - SCCAEPA 8-08.doc' is uploaded successfully.  
        sDisplayMessage = (String)ret.getUpdateInfo();
      }
  }
/*
  else if ("View".equalsIgnoreCase(sRealAction)||"Download".equalsIgnoreCase(sRealAction))
  {
     bean.getFileContent(request, response);
     return;
  }
*/
  else if (sRealAction.startsWith("Unpack"))
  {
     ret = bean.unpackFile(request);
     if (!ret.isSuccess())
     {
       Errors errObj = (Errors)ret.getInfoObject();
       nDisplay = 0;
       sDisplayMessage = errObj.getError();
     }
     else
       sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_FILEUNPACK_SUCCESS, null).replaceAll("%s", (String)ret.getUpdateInfo());//request.getParameter("filename"));
  }
  else if (sRealAction.startsWith("Delete"))
  {
     ret = bean.deleteFile(request);
     if (!ret.isSuccess())
     {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
       nDisplay = 0;
     }
     else
       sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_FILEDELETE_SUCCESS, null).replaceAll("%s", (String)ret.getUpdateInfo());//request.getParameter("filename"));
  }
  else if (sRealAction.startsWith("Update Rows"))
  {
    bean.changeMaxRowsPerPage(request);
  }

  if ("Yes".equalsIgnoreCase(request.getParameter("stopupload")))
  {
     sDisplayMessage = request.getParameter("error");
     nDisplay = 0;
  }
        
//bean.showAllParameters(request, out);
//  List ltArray = bean.getAll(request, bean.encodedUrl("index.jsp?action=Switch Page_FileStorage"), bSelection); //"javascript:submitSwitchPage(document.filelist, rpp, page)", bSelection);
  List ltArray = bean.getAll(request, "index.jsp?action=Switch Page_FileStorage", bSelection); //"javascript:submitSwitchPage(document.filelist, rpp, page)", bSelection);
  String sUpFolder = bean.getUpFolder();
//System.out.println("sRealAction=" + sRealAction+ "," + sUpFolder + "," + ltArray.size());
//  bean.remvoeProcessStatus();
  int nFileMaxSize = 100*1024; // 50 MB
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/filestorage.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/staticfile/web/scripts/dhtmlcombo.js"></SCRIPT>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
 <tr>
  <td>
   <%@ include file="../util/uploadprocess.jsp"%>
  </td>
 </tr>
 <tr>
  <td>
<SPAN id="WorkingSection">
<TABLE border=0 cellspacing=1 cellpadding=2 width="100%">
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
 <TR>
  <TD>
<FORM name="filelist" action="filelist.jsp" method="post">
<input type="hidden" name="rpp" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="sort" value="">
<input type="hidden" name="asc" value="">
<input type="hidden" name="action" value="Switch Page">
<input type="hidden" name="filename" value="">
<table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
  <tr>
    <td width="75%"><%=mcBean.getLabel("cm-folder")%>: <b><%=bean.getCurrentFolder()%></b></td>
    <td width="25%" align="right"><%=mcBean.getLabel("cm-maxrow")%>:
    <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=bean.encodedUrl("index.jsp?action=Update Rows_FileStorage")%>');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<TABLE class="table-1" width="100%" align="right" border=0 cellspacing=1 cellpadding=1>
<TR vAlign="middle" bgColor="#4959A7">
 <td width="2%" align="left" height="19" nowrap>
  <input type="checkbox" name="allbox" value="1" onClick='checkAll(this, document.filelist, document.filecommand);'>
 </td>
 <td width="41%" align="center" height="20"><%=bean.getSortNameLink("Name", bean.encodedUrl("index.jsp?action=Sort_FileStorage"), mcBean.getLabel("fs-filefoldername"), true)%></td>
 <td width="10%" align="center" height="20"><%=bean.getSortNameLink("Size", bean.encodedUrl("index.jsp?action=Sort_FileStorage"), mcBean.getLabel("fs-filesize"), true)%></td>
 <td width="8%" align="center" height="20"><%=bean.getSortNameLink("Type", bean.encodedUrl("index.jsp?action=Sort_FileStorage"), mcBean.getLabel("fs-type"), true)%></td>
 <td width="18%" align="center" height="20"><%=bean.getSortNameLink("Modified Date", bean.encodedUrl("index.jsp?action=Sort_FileStorage"), mcBean.getLabel("fs-moddate"), true)%></td>
 <td width="22%" align="center" height="20"><FONT color="#ffffff"><b><%=mcBean.getLabel("cm-action")%></b></font></td>
</TR>
<% if (sUpFolder!=null) { %>
<TR class="normal_row">
  <td width="2%"></td>
  <td width="50%"><%=sUpFolder%></td>
  <td width="10%" align="right"></td>
  <td width="8%" align="center"></td>
  <td width="18%" align="right"></td>
  <td width="84" align="center"></td>
</TR>
<% } %>
<%
//  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     File file = (File)ltArray.get(i);
//     String sChecked = bean.getCheckFlag(bean.getFileUnique(file));
     String sClassName = "normal_row";
//     if ("Checked".equalsIgnoreCase(sChecked))
//        sClassName = "highlight_row";
//System.out.println("Step 44=" + file);

%>
<TR class="<%=sClassName%>" onmouseup1="selrow(this, 2)" onmouseover1="selrow(this, 0)" onmouseout1="selrow(this, 1)">
  <td width="2%"><input type="checkbox" name="check_<%=i%>" value="1" onClick='clickCheckBox(this, document.filelist, document.filecommand);'></td>
  <td width="50%"><%=bean.getFileAttribute(file, 1, i)%></td>
  <td width="10%" align="right"><%=bean.getFileAttribute(file, 2, i)%></td>
  <td width="7%" align="center"><%=bean.getFileAttribute(file, 3, i)%></td>
  <td width="18%" align="center"><%=bean.getFileAttribute(file, 4, i)%></td>
  <td width="84" align="center">
  <select id="fl_<%=i%>" title="<%=mcBean.getLabel("cm-action")%>" style="display: none">
<% if (!file.isDirectory()) { %>
  <%=bean.getViewUnpackLink(file, i)%>    
  <option value="javascript:openModalWin('<%=mcBean.getLabel("fs-fileprop")%>', '<%=bean.encodedUrl("file/fileproperty.jsp?action=getProperty&index=" + i)%>',620,300)" title="<%=mcBean.getLabel("cm-edit")%>: <%=Utilities.convertFilename(file.getName(), false)%>"><%=mcBean.getLabel("cm-edit")%></option>
<% } %>
  <!--option value="#" message="showShareWin(document.form_sharefile, 'id_sharelayer', this, '<%=file.getName()%>', <%=file.isDirectory()%>)" title="Share <%=file.isDirectory()?mcBean.getLabel("cm-folder"):mcBean.getLabel("cm-file")%>: <%=file.getName()%>">Share</option-->
  <option value="javascript:openModalWin('<%=mcBean.getLabel("fs-fileshare")%>', '<%=bean.encodedUrl("file/fileshare-popup.jsp?action=loadForm&index=" + i)%>',710,500)" title="<%=mcBean.getLabel("cm-share")%> <%=file.isDirectory()?mcBean.getLabel("cm-folder"):mcBean.getLabel("cm-file")%>: <%=Utilities.convertFilename(file.getName(), false)%>"><%=mcBean.getLabel("cm-share")%></option>
  <%=bean.getDownloadLink(file, i)%>
  <%=bean.getDeleteLink(file, i)%>      
  </select>
  <script type="text/javascript">dhtmlselect("fl_<%=i%>", "80px", "85px", "top")</script>
      
  </td>
</TR>
<%}%>
<tr>
  <td colspan="6" class="normal_row2">
    <table width="100%" border="0">
      <tr>
        <td width="40%"><font color="#000000"><%=bean.getSummary()%></font><span id="totalselection"></span>
        </td>
        <td width="60%" align="right"><b><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></b>
        </td>
      </tr>
    </table>
  </td>
</TR>
</TABLE>
</FORM>
</TD>
</TR>
<%  if (bean.isInPublicArea()) { %>
  <tr>
    <td align="left"><%=bean.getLabel("fs-url")%>: <b><%=bean.getFileWebUrl(cfInfo.SiteName)%></b></td>
  </tr>
<% } %>
<TR>
  <TD height="10"></TD>
</TR>
 <TR>
  <TD>
<form name="filecommand" action="<%=mcBean.encodedUrl("index.jsp?maxsize="+nFileMaxSize)%>" method="post" enctype="multipart/form-data" target11="target_upload">
<input type="hidden" name="subdir" value="file">
<input type="hidden" name="selections" value="">
<input type="hidden" name="action1" value="">
<fieldset style="margin:0px"><legend><b><%=mcBean.getLabel("fs-cmdpanel")%></b></legend>
<TABLE class1="table-1" width="100%" align="right" border=0 cellspacing=1 cellpadding=1>
<!--TR vAlign="middle" bgColor="#4959A7">
 <td align="center" colspan="2" bgColor="#4959A7" height="20"><FONT color="#ffffff"><b>Command Panel</b></font></td>
</tr-->
  <tr>
   <td colspan="2" height="5"></td>   
  </tr>
  <tr>
    <td class="row1" width="68%" align="right">
       <input title="<%=mcBean.getLabel("fs-resetfields")%>" type="reset" value="<%=mcBean.getLabel("cm-reset")%>" name="reset" style="WIDTH:110px">
       <input title="<%=mcBean.getLabel("fs-downloadzipdes")%>" type="submit" value="<%=mcBean.getLabel("fs-downloadzip")%>" name="downloadselection" onClick="return validateDownloadZip(document.filecommand, this.value);" style="WIDTH:350px">
    </td>
    <td class="row1">
      <input title="<%=mcBean.getLabel("fs-deletefiledes")%>" type="submit" value="<%=mcBean.getLabel("fs-deletefile")%>" name="deleteselection" onClick="return validateDeleteFiles(document.filecommand, this.value);" style="WIDTH:225px">
    </td>
  </tr>
  <tr>
    <td class="row1" width="68%" align="right"><%=mcBean.getLabel("cm-filename")%>: <input type="file" name="browserfile" size="50" onChange="onBrowserFileDone(document.filecommand, this.value)"></td>
    <td class="row1">
    <input title="<%=mcBean.getLabel("fs-uploadfiledesc")%>" type="submit" value="<%=mcBean.getLabel("fs-uploadfile")%>" name="uploadfile" onClick="return validateUploadFile(document.filecommand, this.value, '<%=bean.encodedUrl("ajax/response.jsp?action=CheckFileExist_UploadFile")%>');" style="WIDTH:225px">
    </td>
  </tr>
  <tr>
    <td class="row1" width="68%" align="right"><span id="filename_label"><%=mcBean.getLabel("fs-filefoldername")%>:</span> <input name="filefolder" onKeyUp="onTypeName(document.filecommand, this.value)" value="<%=Utilities.getValue(request.getParameter("filefolder"))%>" style="WIDTH:273px">
      <input title="<%=mcBean.getLabel("fs-createfolderdes")%>" type="submit" value="<%=mcBean.getLabel("fs-createfolder")%>" name="createfile" onClick="return validateCreateFolder(document.filecommand, this.value);" style="WIDTH:100px" disabled>
    </td>
    <td class="row1">
      <input title="<%=mcBean.getLabel("fs-renamefiledes")%>" type="submit" value="<%=mcBean.getLabel("fs-renamefile")%>" name="renamefile" onClick="return validateRenameFile(document.filecommand, this.value);" style="WIDTH:139px">
      <input title="<%=mcBean.getLabel("fs-movefiledes")%>" type="submit" value="<%=mcBean.getLabel("fs-movefile")%>" name="movefiles" onClick="return validateMoveFiles(document.filecommand, this.value);" style="WIDTH:82px">
    </td>
  </tr>
</table>
</fieldset>
</form>
<!--iframe id='target_upload' name='target_upload' src='' style='display: none'></iframe-->
<SCRIPT>onFileFormLoad(document.filelist, document.filecommand);</SCRIPT>
</TD>
</TR>
<TR>
 <TD>
  <%@ include file="fileshare-layer.jsp"%>     
 </TD>
</TR>
</TABLE>
 </SPAN>
 </td>
</tr>
</TABLE>