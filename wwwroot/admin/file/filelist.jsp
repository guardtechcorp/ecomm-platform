<%@ page import="java.io.File"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.FileBean"%>
<%
//  request.setCharacterEncoding("utf-8");
//  response.setCharacterEncoding("utf-8");
        
  FileBean bean = new FileBean(session, 12);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_PUBLICAREA|AccessRole.ROLE_PRIVATEAREA))
     return;

//bean.showAllParameters(request, out);
  String sDisplayMessage = null;
  String sClass = "successful";
  String sAction = request.getParameter("action");
  boolean bSelection = true;
  if ("View".equalsIgnoreCase(sAction)||"Download".equalsIgnoreCase(sAction))
  {
     bean.getFileContent(request, response);
     return;
  }
  else if ("Unpack".equalsIgnoreCase(sAction))
  {
     FileBean.Result ret = bean.unpackFile(request);
     if (!ret.isSuccess())
     {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
       sClass = "failed";
     }
     else
       sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_FILEUNPACK_SUCCESS, null).replaceAll("%s", request.getParameter("filename"));
  }
  else if ("Delete File".equalsIgnoreCase(sAction))
  {
     FileBean.Result ret = bean.deleteFile(request);
     if (!ret.isSuccess())
     {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
       sClass = "failed";
     }
     else
       sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_FILEDELETE_SUCCESS, null).replaceAll("%s", request.getParameter("filename"));
  }
  else if ("GetStatus".equalsIgnoreCase(sAction))
  {
     bean.updateStatus(request, response);
     return;
  }
  else if (sAction!=null && sAction.startsWith("Command-"))//"finishcommand".equalsIgnoreCase(sAction))
  {
    bSelection = false;
    FileBean.Result ret = (FileBean.Result)session.getAttribute(FileBean.KEY_COMMANDRESULT);
    sAction = ret.m_sAction;
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
       if (ret.m_sAction.startsWith("Download"))
          return;

      sDisplayMessage = (String)ret.getUpdateInfo();
    }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

//bean.showAllParameters(request, out);
  List ltArray = bean.getAll(request, "javascript:submitSwitchPage(document.filelist, rpp, page)", bSelection);
  String sUpFolder = bean.getUpFolder();
  String sTitle = bean.getWorkAreaTitle();

  String sHelpTag, sTitleLinks, sDescription;
  String sPara1 = "", sPara2 = "";
  if ("Public".equalsIgnoreCase(sTitle))
  {
     sHelpTag = "websitearea";
//     sTitleLinks = "<b>Website Area</b>";
     sTitleLinks = bean.getNavigation(request, "Website Area");
     sDescription = "From this page, you can view and access to all files in your website.";
     sPara1 = bean.getDomainName();
  }
  else if ("Private".equalsIgnoreCase(sTitle))
  {
    sHelpTag = "privatearea";
//    sTitleLinks = "<a href=\"../file/privatearea.jsp?action=User Private Area\">Private Area</a> > <b>Special Folder</b>";
    sTitleLinks = bean.getNavigation(request, "Special Folder");
    sDescription = "From this page, you can view and access to all files in this private area.";
  }
  else// if ("Member".equalsIgnoreCase(sTitle))
  {
    sHelpTag = "memberarea";
//    sTitleLinks = "<a href=\"../membership/arealist.jsp\">Member Area List</a> > <b>Member Area</b>";
    sTitleLinks = bean.getNavigation(request, "Member Area");
    sDescription = "From this page, you can view and access to all files in this member area.";
    sPara1 = bean.getDomainName();
    sPara2 = bean.getWorkAreaContent();
  }
%>
<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>', '<%=sPara1%>', '<%=sPara2%>');</SCRIPT>
<%=sDescription%>
<!--%@ include file="../share/waitprocess.jsp"%-->
<SCRIPT Language="JavaScript" src="/staticfile/web/modalwindow/dhtmlwindow.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/modalwindow/modal.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/file.js"></SCRIPT>
<SPAN id="listcommand1">
<FORM name="filelist" action="filelist.jsp" method="post">
<input type="hidden" name="rpp" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="sort" value="">
<input type="hidden" name="asc" value="">
<input type="hidden" name="action" value="Switch Page">
<input type="hidden" name="filename" value="">
<table width="99%" border="0" cellspacing="1" cellpadding="1" align="center">
  <tr>
    <td width="75%">The current folder: <b><%=bean.getCurrentFolder()%></b></td>
    <td width="25%" align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'filelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
<%  if ("Public".equalsIgnoreCase(sTitle)) { %>
  <tr>
     <td colspan="2" align="left">Public URL Path: <b><%=bean.getPublicUrl()%></b></td>
  </tr>
<% } %>
<% if (sDisplayMessage!=null) { %>
  <tr>
     <td colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="2%" align="left" height="19" nowrap class="thCornerL">
      <input type="checkbox" name="allbox" value="1" onClick='checkAll(document.filelist, this, document.filecommand);'>
    </th>
    <th width="40%" align="center" height="19" class="thCornerL"><%=bean.getSortNameLink("Name", "filelist")%></th>
    <th width="11%" align="center" height="19" class="thCornerL"><%=bean.getSortNameLink("Size", "filelist")%></th>
    <th width="8%" align="center" height="19" class="thCornerL"><%=bean.getSortNameLink("Type", "filelist")%></th>
    <th width="19%" align="center" height="19" class="thCornerL"><%=bean.getSortNameLink("Modified Date", "filelist")%></th>
    <th width="20%" align="center" height="19" class="thCornerL">Actions</th>
  </tr>
<% if (sUpFolder!=null) { %>
    <tr class="normal_row">
      <td width="2%"></td>
      <td width="40%"><%=sUpFolder%></td>
      <td width="11%" align="right"></td>
      <td width="8%" align="center"></td>
      <td width="19%" align="right"></td>
      <td width="20%" align="center"></td>
    </tr>
<% } %>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     File file = (File)ltArray.get(i);
     String sChecked = bean.getCheckFlag(bean.getFileUnique(file));
     String sClassName = "normal_row";
     if ("Checked".equalsIgnoreCase(sChecked))
        sClassName = "highlight_row";
%>
    <tr class="<%=sClassName%>">
      <td width="2%"><input type="checkbox" name="check_<%=bean.getFileUnique(file)%>" value="1" <%=sChecked%> onClick='clickCheckBox(this, document.filecommand);'></td>
      <td width="40%"><%=bean.getFileAttribute(file, 1)%></td>
      <td width="11%" align="right"><%=bean.getFileAttribute(file, 2)%></td>
      <td width="8%" align="center"><%=bean.getFileAttribute(file, 3)%></td>
      <td width="19%" align="center"><%=bean.getFileAttribute(file, 4)%></td>
      <td width="20%" align="center">
       <table cellpadding="1" cellspacing="1" border="0"><tr>
       <td width="30%" align="center"><%=bean.getViewUnpackLink(file)%></td>
       <td width="40%" align="center"><%=bean.getDownloadLink(file)%></td>
       <td width="30%" align="center"><%=bean.getDeleteLink(file)%></td>
       </tr></table>
      </td>
    </tr>
<%}%>
    <tr>
      <td colspan="6" class="catBottom">
        <table width="100%" border="0">
          <tr>
            <td width="35%"><font color="#000000"><%=bean.getSummary()%></font><span id="totalselection"></span>
            </td>
            <td width="65%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
</table>
</FORM>
<form name="filecommand" action="filecommand.jsp"  method="post" enctype="multipart/form-data" onSubmit="validatevalidateSelection(document.filecommand, document.filelist);">
<input type="hidden" name="lastselection" value="">
<table cellspacing="1" cellpadding="2" border="0" align="center" class="forumline" width="99%">
  <tr>
    <th class="thCornerL" align="center" colspan="2">Command Panel</th>
  </tr>
  <tr>
    <td class="row1" width="60%" align="right">
       <input title="Download selected files and directories as one zip file" type="submit" value="Download Selected Files as a Zip File" name="action" onClick="return validateDownloadZip(document.filecommand);" style="WIDTH:250px">
    </td>
    <td class="row1" width="40%">
      <input title="Delete all selected files and directories." onClick="return validateDeleteFiles(document.filecommand);" type="submit" value="Delete Selected Files" name="action" style="WIDTH:225px">
    </td>
  </tr>
  <tr>
    <td class="row1" width="60%" align="right">File Name: <input type="file" name="browserfile" size="39"></td>
    <td class="row1" width="40%">
    <!--input title="Upload selected file to the current working directory" type="submit" value="Upload File" name="action" onClick="return validateUpload(document.filecommand);loadStatusPage(document.filecommand.browserfile.value);" style="WIDTH:225px"-->
    <input title="Upload selected file to the current working directory" type="submit" value="Upload File" name="action" onClick="return loadStatusPage(document.filecommand, 'filelist.jsp');" style="WIDTH:225px">
    </td>
  </tr>
  <tr>
    <td class="row1" width="60%" align="right">File or Folder Name: <input name="filefolder" value="<%=Utilities.getValue(request.getParameter("filefolder"))%>" size="34">
      <input title="Create folder under the current folder" type="submit" value="Create Folder" name="action" onClick="return validateCreateFolder(document.filecommand);" style="WIDTH:109px">
    </td>
    <td class="row1" width="40%">
      <input title="Rename file under the current folder" type="submit" value="Rename File/Folder" name="action" onClick="return validateRenameFile(document.filecommand);" style="WIDTH:135px">
      <input title="Move files to another folder" type="submit" value="Move Files" name="action" onClick="return validateMoveFiles(document.filecommand);" style="WIDTH:90px">
    </td>
  </tr>
</table>
</form>
</SPAN>
<!----iframe id='target_upload' name='target_upload' src='' style='display: none'></iframe-->
<SCRIPT>onFileFormLoad(document.filecommand, <%=bean.getTotalSelection()%>);</SCRIPT>
<%@ include file="../share/footer.jsp"%>