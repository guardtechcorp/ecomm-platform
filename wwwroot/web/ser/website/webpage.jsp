<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.WebPageBean" %>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%@ page import="com.zyzit.weboffice.database.WebPage" %>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean" %>
<%@ include file="../include/pageheader.jsp"%>
<%
{
 //WebPageBean.dumpAllParameters(request);
    WebPageBean bean = WebPageBean.getObject(session);
    WebPageInfo info = null;
    if (sRealAction.startsWith("Edit") || sRealAction.startsWith("Load"))
    {
        info = bean.get(request);
//Utilities.dumpObject(info);
    } else if (sRealAction.startsWith("prev") || sRealAction.startsWith("next")||sRealAction.startsWith("goto")) {
        info = bean.getPrevOrNext(request, sRealAction);
    } else if (sRealAction.startsWith("Add") || sRealAction.startsWith("Update")) {
        if (!ret.isSuccess()) {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            info = (WebPageInfo) ret.getUpdateInfo();
            nDisplay = 0;
        } else {
            info = (WebPageInfo) ret.getUpdateInfo();
            if (sRealAction.startsWith("Update"))
                sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "web page");
            else {
                sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "web page");
            }
        }
    } else if (sRealAction.startsWith("Remove")) {
        if (!ret.isSuccess()) {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        } else {
            sDisplayMessage = "The uploaded file is removed successfully.";
        }
        info = (WebPageInfo) ret.getUpdateInfo();
    }
    
    if ("Yes".equalsIgnoreCase(request.getParameter("stopupload")))
    {
        sDisplayMessage = request.getParameter("error");
        nDisplay = 0;
    }

    String sNextAction;
    String sButtonValue;
    if (info == null) {
        info = WebPageInfo.getInstance(true);
        info.Type = WebPage.SOURCETYPE_INPLACE;
        info.UseFrame = 0;

        info.Place = Utilities.getByte(request.getParameter("place"), WebPage.PLACE_OTHERS);
        info.ShowWay = Utilities.getByte(request.getParameter("showway"), (byte) 0);
        info.AccessMode = Utilities.getByte(request.getParameter("accessmode"), Definition.ACCESSMODE_PUBLIC);   // No need to login to public
        info.ShowMenuLink = Utilities.getByte(request.getParameter("showmenulink"), (byte)1);
        sNextAction = "Add_WebPage";
        sButtonValue = bean.getLabel("cm-add");
    }
    else
    {
        sNextAction = "Update_WebPage";
        sButtonValue = bean.getLabel("cm-update");
    }

    int nFileMaxSize = 100*1024; //(MB) Total submit size
    int nFrontFileMaxSize = 5*1024; //(5 MB)

    MemberFileBean mfBean = MemberFileBean.getObject(session);
    String sFileStorageOption = mfBean.getFileStorageOption(info.FileStorage);
    bean.remvoeProcessStatus();
//Utilities.dumpObject(info);    
%>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/webpage.js" type="text/javascript"></SCRIPT>
<TABLE cellpadding="1" cellspacing="0" border="0" width="100%">
 <tr>
  <td>
   <%@ include file="../util/uploadprocess.jsp"%>
  </td>
 </tr>
 <tr>
  <td>
<SPAN id="WorkingSection">
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
<% if (!(sRealAction.startsWith("Load") || request.getParameter("from")!=null)) { %>
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
<TR>
   <TD>
    <table width="100%" cellpadding="0" cellspacing="1" border="0" align="center">
      <tr>
        <td>&nbsp;<%=mcBean.getLabel("cm-markedfield")%></td>
        <td align="right">
<% if (info.PageID>0) { %>
         <%=bean.getPrevNextLinks2("index.jsp?", "_WebPage", true)%>&nbsp;
<% } %>
        </td>
      </tr>
    </table>
   </TD>
  </TR>
<% } %>
  <TR>
  <TD>
 <FORM name="form_webpage" method="post" action="<%=mcBean.encodedUrl("index.jsp?maxsize="+nFileMaxSize+"&sl=1")%>" enctype="multipart/form-data" onSubmit="return validateWebPage(this, <%=nFrontFileMaxSize%>, 'content');" target1="target_upload">
 <input type="hidden" name="pageid" value="<%=info.PageID%>">
 <INPUT type="hidden" name="subdir" value="webpage">
 <input type="hidden" name="action1" value="">
 <input type="hidden" name="attributes" value="<%=Utilities.getValue(info.Attributes)%>">
<% if (sRealAction.startsWith("Load") || request.getParameter("return")!=null) { %>
 <INPUT type="hidden" name="name" value="<%=info.Name%>">
 <input type="hidden" name="place" value="<%=info.Place%>">
 <input type="hidden" name="showway" value="<%=info.ShowWay%>">
 <input type="hidden" name="accessmode" value="<%=info.AccessMode%>">
 <input type="hidden" name="showmenulink" value="<%=info.ShowMenuLink%>">
 <input type="hidden" name="return" value="<%=Utilities.getValue(request.getParameter("return"))%>">
<% } %>
<% if (info.Type<0) { %>
 <INPUT type="hidden" name="type" value="<%=info.Type%>"> 
<% } %>
 <table class="table-outline" width="100%" align="center">
<% if (!(sRealAction.startsWith("Load") || request.getParameter("from")!=null)) { %>
 <tr>
  <td width="12%" height="22" align="right">* <%=mcBean.getLabel("wp-linkname")%>:</td>
  <td><input maxlength=40 name="name" value="<%=Utilities.getValue(info.Name)%>" size="40">
    <%=mcBean.getLabel("wp-linknamedes")%>
  </td>
</tr>
<% } %>
 <tr>
  <td width="12%" height="22" align="right"><%=mcBean.getLabel("cm-title")%>:</td>
  <td><input maxlength=50 name="title" value="<%=Utilities.getValue(info.Title)%>" size="70">
  <%=mcBean.getLabel("wp-titledes")%>
  </td>
</tr>
<tr>
  <td colspan="2"><HR align="center" width="100%" color="#D6D6D6" noShade SIZE=1></td>
</tr>
<% if (!(sRealAction.startsWith("Load") || request.getParameter("from")!=null)) { %>
<tr>
 <td width="12%" align="right" height="22">  <%=mcBean.getLabel("wp-whereput")%>:</td>
 <td >
   <input type="hidden" name="place" value="<%=info.Place%>">
   <!--div id="scroll_list" style="width:100%;height:22px;background-color:white;overflow:auto;BORDER: #4279bd 0px solid; "-->
   <table width="100%">
   <tr>
     <td width="17%"><input type="checkbox" name="place_1" value="1" <%=bean.getChecked(info.Place&1, 1)%>><%=bean.getPositionName(1)%></td>
     <td width="23%"><input type="checkbox" name="place_2" value="2" <%=bean.getChecked(info.Place&2, 2)%>><%=bean.getPositionName(2)%></td>
     <td width="19%"><input type="checkbox" name="place_4" value="4" <%=bean.getChecked(info.Place&4, 4)%>><%=bean.getPositionName(4)%></td>
     <td width="21%"><input type="checkbox" name="place_8" value="8" <%=bean.getChecked(info.Place&8, 8)%>><%=bean.getPositionName(8)%></td>
     <td><input type="checkbox" name="place_8" value="16" <%=bean.getChecked(info.Place&16, 16)%>><%=bean.getPositionName(16)%></td>
   </tr>
   </table>
   <!--/div-->
</td>
</tr>
<tr>
 <td width="12%" align="right" height="22"><%=mcBean.getLabel("wp-howshow")%>:</td>
 <td >
  <input type="radio" value="0" name="showway" <%=info.ShowWay==0?"CHECKED":""%> id="id_showway_0"><%=mcBean.getLabel("wp-samebrowser")%>  <input type="radio" value="1" name="showway" <%=info.ShowWay==1?"CHECKED":""%>  id="id_showway_1" <%=info.Type==13?"disabled":""%>><%=mcBean.getLabel("wp-anotherbrowser")%>
  <input type="radio" value="2" name="showway" <%=info.ShowWay>1?"CHECKED":""%>  id="id_showway_2" <%=info.Type==13?"disabled":""%>><%=mcBean.getLabel("wp-popupwindow")%>
 </td>
</tr>
<!--tr>
    <td width="12%" align="right" height="22">Use Frame:&nbsp;</td>
    <td >
    <input type="radio" value="0" name="useframe" <%=info.UseFrame==0?"CHECKED":""%>>Not use a frame to show content.
    <input type="radio" value="1" name="useframe" <%=info.UseFrame!=0?"CHECKED":""%>>Use a frame to show content. (ONLY apply to in the same browser)
    </td>
</tr-->
<tr>
 <td width="12%" align="right" height="22"><%=mcBean.getLabel("cm-accessby")%>:</td>
 <td>
  <select name="accessmode">
   <%=bean.getAccessOption(info.AccessMode, 0)%>
  </select> <%=mcBean.getLabel("wp-whereput")%><%=mcBean.getLabel("wp-allvisitordes")%>
</td>
</tr>
<tr>
 <td width="12%" align="right" height="22"><%=mcBean.getLabel("wp-showmenu")%>:</td>
 <td>
  <input type="checkbox" name="showmenulink" value="1" <%=info.ShowMenuLink==1?"CHECKED":""%>> <%=mcBean.getLabel("wp-alwaysdes")%>
 </td>
</tr>
<% if (info.Type>=0) { %>
<tr>
  <td colspan="2"><HR align="center" width="100%" color="#D6D6D6" noShade SIZE=1></td>
</tr>
<tr>
  <td width="12%" align="right"><%=mcBean.getLabel("wp-sourcetype")%>:</td>
  <td>
   <select name="type" onChange="onSelectTypeChange(document.form_webpage)" <%=info.PageID>0?"disabled":""%> >
     <option value=0 <%=bean.getSelected(0, info.Type)%>><%=mcBean.getLabel("wp-editplace")%></option>
     <option value=1 <%=bean.getSelected(1, info.Type)%>><%=mcBean.getLabel("wp-embedcode")%></option>
     <option value=2 <%=bean.getSelected(2, info.Type)%>><%=mcBean.getLabel("wp-uploadfile")%></option>
     <option value=3 <%=bean.getSelected(3, info.Type)%>><%=mcBean.getLabel("wp-linkurl")%></option>
<% if (sFileStorageOption!=null) { %>
     <option value=4 <%=bean.getSelected(4, info.Type)%>><%=mcBean.getLabel("mt-filestorage")%></option>
<% } %>
     <option value=11 <%=bean.getSelected(11, info.Type)%>><%=mcBean.getLabel("wp-feedback")%></option>
     <option value=12 <%=bean.getSelected(12, info.Type)%>><%=mcBean.getLabel("wp-tellfriend")%></option>
     <option value=14 <%=bean.getSelected(14, info.Type)%>><%=mcBean.getLabel("wp-contactus")%></option>
     <option value=13 <%=bean.getSelected(13, info.Type)%>><%=mcBean.getLabel("wp-onlinemsg")%></option>
   </select> <!-- %=mcBean.getLabel("wp-sourcetypedes")% -->
  </td>
 </tr>
<% } %>
 <!--tr>
  <td colspan="2"><HR align="center" class="dotline"></td>
 </tr-->
 <tr>
  <td  colspan="2">
  <SPAN id="editinplace_section" style='display:<%=(info.Type==0?"inline":"none")%>'>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style1="border: 1px dotted #DFDFDF; padding: 1px;">
  <tr>
   <td colspan="2" align="top">

     <textarea id="content" name="content"><%=Utilities.getValue(info.Content)%></textarea>
     <!--script language="javascript1.2">createToolbar('content', 680, 300, ",7,15,16,17,32,");</script-->
   </td>
  </tr>
  </table>
  </SPAN>
  <SPAN id="embed_section" style='display:<%=(info.Type==1?"inline":"none")%>'>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="border: 1px dotted #DFDFDF; padding: 1px;">
  <tr>
   <td width="12%" height="22" align="right" valign="top"><%=mcBean.getLabel("wp-embedcode")%>:&nbsp;</td>
   <td><textarea id="embedcode" name="embedcode" rows="5" cols="75"><%=Utilities.getValue(info.EmbedCode)%></textarea></td>
  </tr>
  </table>
  </SPAN>

  <SPAN id="uploadfile_section" style='display:<%=(info.Type==2?"inline":"none")%>'>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="border: 1px dotted #DFDFDF; padding: 1px;">
  <tr>
   <td width="12%" align="right"><%=mcBean.getLabel("wp-uploadfile")%>:&nbsp;</td>
   <td><input type="hidden" name="uploadfileid" value="<%=info.UploadFileID%>">
    <input type="file" name="uploadfile" size="70">
<% if (info.UploadFileID>0) { %>
     [<%=mcBean.getPreviewLink("PreviewFile", mcBean.getLabel("cm-previewfile"), info.UploadFileID, mcBean.getLabel("cm-preview"))%>, <a href='<%=mcBean.encodedUrl("index.jsp?action=Remove File_WebPage&fileid="+info.UploadFileID)%>' onClick="return confirm('<%=mcBean.getLabel("cm-confirmremove")%>');"><%=mcBean.getLabel("cm-remove")%></a>]
<% } %>
   </td>
  </tr>
  </table>
  </SPAN>

  <SPAN id="linkurl_section" style='display:<%=(info.Type==3?"inline":"none")%>'>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="border: 1px dotted #DFDFDF; padding: 1px;">
  <tr>
   <td width="12%" height="22" align="right"><%=mcBean.getLabel("wp-linkurl")%>:&nbsp;</td>
   <td><input maxlength=255 name="linkurl" value="<%=Utilities.getValue(info.LinkUrl)%>" size="100"></td>
  </tr>
  </table>
  </SPAN>

  <SPAN id="filestorage_section" style='display:<%=(info.Type==4?"inline":"none")%>'>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="border: 1px dotted #DFDFDF; padding: 1px;">
  <tr>
   <td width="12%" height="22" align="right"><%=mcBean.getLabel("mt-filestorage")%>:&nbsp;</td>
   <td>
    <select name="filestorage">
     <option value="" selected><--<%=mcBean.getLabel("wp-selectbelow")%>--></option>
     <%=Utilities.getValue(sFileStorageOption)%>     
    </select> <%=mcBean.getLabel("wp-linkurldes")%></td>
  </tr>
  <tr>
    <td width="12%" align="right" height="30"><%=mcBean.getLabel("wp-uselayout")%>:&nbsp;</td>
    <td>
     <select name="categoryid">
      <option value=0 <%=bean.getSelected(0, info.CategoryID)%>><%=mcBean.getLabel("wp-displaydirect")%></option>
      <option value=1 <%=bean.getSelected(1, info.CategoryID)%>><%=mcBean.getLabel("wp-displaylayout")%> 1</option>
      <option value=2 <%=bean.getSelected(2, info.CategoryID)%>><%=mcBean.getLabel("wp-displaylayout")%> 2</option>
      <option value=3 <%=bean.getSelected(3, info.CategoryID)%>><%=mcBean.getLabel("wp-displaylayout")%> 3</option>
      <option value=4 <%=bean.getSelected(4, info.CategoryID)%>><%=mcBean.getLabel("wp-displaylayout")%> 4</option>
      <option value=5 <%=bean.getSelected(5, info.CategoryID)%>><%=mcBean.getLabel("wp-displaylayout")%> 5</option>
      <option value=6 <%=bean.getSelected(6, info.CategoryID)%>><%=mcBean.getLabel("wp-displaylayout")%> 6</option>
     </select> <%=mcBean.getLabel("wp-displaydes")%> [ <a href="javascript:viewFileListLayout(document.form_webpage.categoryid.value)"><%=mcBean.getLabel("cm-viewlayout")%></a> ]
    </td>
  </tr>
<%
{
  String[] arAt = Utilities.getValue(info.Attributes).split(",");
  boolean bAllow = false;
  String sFileType = "*";
  String sBackColor = "#ffffff";
  int nRowsPerPage = 10;
  String sSortFieldName = "";
  int nUserInputSize = nFrontFileMaxSize;
  byte btOrder = 0;
  if (arAt.length>0)
     bAllow = "1".equalsIgnoreCase(arAt[0]);
  if (arAt.length>1)
     sFileType = arAt[1];
  if (arAt.length>2)
    sBackColor = arAt[2];
  if (arAt.length>3)
     nRowsPerPage = Utilities.getInt(arAt[3], 10);
  if (arAt.length>4)
    sSortFieldName = Utilities.getValue(arAt[4], "Name");
  if (arAt.length>5)
    btOrder = Utilities.getByte(arAt[5], (byte)0);
  if (arAt.length>6)
    nUserInputSize = Utilities.getInt(arAt[6], nFrontFileMaxSize);
%>
  <tr>
    <td width="12%" align="right" height="30"><%=mcBean.getLabel("cm-backcolor")%>:&nbsp;</td>
    <td>
    <input type="text" name="at_backcolor" value="<%=sBackColor%>" maxlength="7" size="6" style="color: <%=sBackColor%>" onClick="javascript:loadSelectColor(this, 2);">
   &nbsp;&nbsp;<%=mcBean.getLabel("cm-maxrow")%>:<input type="text" name="at_rowsperpage" value="<%=nRowsPerPage%>" maxlength="6" size="2" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
   &nbsp;&nbsp;<%=mcBean.getLabel("cm-sortby")%>:
    <select name="at_sortfield">
    <option value="Name" <%=bean.getSelected("Name", sSortFieldName)%>><%=mcBean.getLabel("cm-filename")%></option>
    <option value="Type" <%=bean.getSelected("Type", sSortFieldName)%>><%=mcBean.getLabel("cm-filetype")%></option>
    <option value="Size" <%=bean.getSelected("Size", sSortFieldName)%>><%=mcBean.getLabel("cm-filesize")%></option>
    <option value="Date" <%=bean.getSelected("Date", sSortFieldName)%>><%=mcBean.getLabel("cm-createdate")%></option>
    <!--option value="ModifyDate" <%=bean.getSelected("ModifyDate", sSortFieldName)%>>Modified Date and Time</option-->
   </select>&nbsp;&nbsp;
    <input type="radio" value="0" name="at_sortorder" <%=bean.getChecked(0, btOrder)%>><%=mcBean.getLabel("cm-ascend")%>
    <input type="radio" value="1" name="at_sortorder" <%=bean.getChecked(1, btOrder)%>><%=mcBean.getLabel("cm-descend")%>
    </td>
  </tr>
  <tr>
   <td width="12%" align="right" height="30" valign="top"><%=mcBean.getLabel("cm-fileupload")%>:&nbsp;</td>
   <td><input type="checkbox" name="at_allowupload" value="1" <%=bAllow?"checked":""%>>&nbsp;<%=mcBean.getLabel("wp-allowupload")%>
   &nbsp;&nbsp;<%=mcBean.getLabel("wp-maxfilesize")%> <input type="text" name="at_maxsize" value="<%=nUserInputSize%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");' size='3'> (<%=mcBean.getLabel("wp-maxsizeallow")%> <%=nFrontFileMaxSize%> <%=mcBean.getLabel("wp-kb")%>)
   <br><%=mcBean.getLabel("wp-fileext")%>
   <select name="at_filetype">
   <option value="*" <%=bean.getSelected("*", sFileType)%>><%=mcBean.getLabel("wp-anyfile")%></option>
   <option value="png|gif|jpe|jpg|jpeg" <%=bean.getSelected("png|gif|jpe|jpg|jpeg", sFileType)%>><%=mcBean.getLabel("wp-imagefile")%></option>
   <option value="mid|midi|mp3|ogg|ram" <%=bean.getSelected("mid|midi|mp3|ogg|ram", sFileType)%>><%=mcBean.getLabel("wp-misicfile")%></option>
   <option value="txt" <%=bean.getSelected("txt", sFileType)%>><%=mcBean.getLabel("wp-textfile")%></option>
   <option value="html|htm|shtml" <%=bean.getSelected("html|htm|shtml", sFileType)%>><%=mcBean.getLabel("wp-webfile")%></option>
   <option value="xml" <%=bean.getSelected("xml", sFileType)%>><%=mcBean.getLabel("wp-xmlfile")%></option>
   <option value="pdf" <%=bean.getSelected("pdf", sFileType)%>><%=mcBean.getLabel("wp-pdffile")%></option>
   <option value="doc|rtf" <%=bean.getSelected("doc", sFileType)%>><%=mcBean.getLabel("wp-wordfile")%></option>
   <option value="xls" <%=bean.getSelected("xls", sFileType)%>><%=mcBean.getLabel("wp-excelfile")%></option>
   <option value="ppt" <%=bean.getSelected("ppt", sFileType)%>><%=mcBean.getLabel("wp-powerpointfile")%></option>
  </select>
   </td>
  </tr>
  </table>
  </SPAN>
<% } %>

 <SPAN id="feature_section" style='display:<%=((info.Type==11||info.Type==12)?"inline":"none")%>'>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="border: 1px dotted #DFDFDF; padding: 1px;">
  <tr>
    <td width="12%" align="right" id="feature_label"><%=mcBean.getLabel("cm-note")%>:&nbsp;</td>
    <td id="feature_note"><%=mcBean.getLabel("wp-tellfrienddes")%></td>
  </tr>
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
  <tr>
   <td colspan="2" align="top">
    <textarea id="description" name="description" cols="89" rows="5"><%=Utilities.getValue(info.Content)%></textarea>
    <!--script language="javascript1.2">createToolbar('description', 710, 160, ",7,15,16,17,32,");</script-->
   </td>
  </tr>
 </table>
 </SPAN>
 <SPAN id="onlinemessage_section" style='display:<%=(info.Type==13?"inline":"none")%>'>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="border: 1px dotted #DFDFDF; padding: 1px;">
<%
{
  String[] arAt = Utilities.getValue(info.Attributes).split("\\|");
  byte nPostBy = Definition.ACCESSMODE_MYSITEMEMBER;
  byte nModifyBy = Definition.ACCESSMODE_MYSITEMEMBER;
  byte nAllow = 0;
  byte nActive = 1;
  String sButtonName = "Comments";
  String sAcceptEmails = "";
  if (arAt.length>0)
    nPostBy = Utilities.getByte(arAt[0], (byte)0);
  if (arAt.length>1)
    nModifyBy = Utilities.getByte(arAt[1], (byte)0);
  if (arAt.length>2)
    nAllow = Utilities.getByte(arAt[2], (byte)0);
  if (arAt.length>3)
    nActive = Utilities.getByte(arAt[3], (byte)1);
  if (arAt.length>4)
    sButtonName = arAt[4];
  if (arAt.length>5)
    sAcceptEmails = arAt[5];
%>
  <!--tr>
    <td width="12%" align="right" height="30">Back Color:&nbsp;</td>
    <td>
    <input type="text" name="om_backcolor" value="sBackColor%>" maxlength="7" size="6" style="color: sBackColor%>" onClick="javascript:loadSelectColor(this, 2);">
   &nbsp;&nbsp;Max Rows/Page:<input type="text" name="om_rowsperpage" value="nRowsPerPage%>" maxlength="6" size="2" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
   &nbsp;&nbsp;Sort By:
    <select name="om_sortfield">
    <option value="CreateDate DESC" bean.getSelected("CreateDate DESC", sSortFieldName)%>>Lastest Date</option>
    <option value="CreateDate ASC" bean.getSelected("CreateDate ASC", sSortFieldName)%>>Early Date</option>
    <option value="Title ASC" <bean.getSelected("Title ASC", sSortFieldName)%>>Title (Ascending)</option>
    <option value="Title DESC" <bean.getSelected("Title DESC", sSortFieldName)%>>Title (Descending)</option>
    </select>
    </td>
  </tr-->
  <tr>
   <td width="12%" align="right" height="22"><%=mcBean.getLabel("wp-onlyallow")%>:&nbsp;</td>
   <td>
    <select name="om_postby">
     <%=bean.getAccessOption(nPostBy, 0)%>
    </select> <%=mcBean.getLabel("wp-postmsg")%>
  </td>
  </tr>
  <tr>
   <td width="12%" align="right" height="22"><%=mcBean.getLabel("wp-onlyallow")%>:&nbsp;</td>
   <td>
    <select name="om_modifyby">
     <%=bean.getAccessOption(nModifyBy, 1)%>
    </select> <%=mcBean.getLabel("wp-editmsg")%>
  </td>
  </tr>
  <tr>
   <td width="12%" align="right" height="22"></td>
   <td>
    <input type="checkbox" name="om_allowanswer" value="1" <%=nAllow==1?"CHECKED":""%>> <%=mcBean.getLabel("wp-allowcomment")%>
     <%=mcBean.getLabel("wp-linkbutton")%>: <input name="om_buttonname" value="<%=sButtonName%>" size="12">
   </td>
  </tr>
  <tr>
   <td width="12%" align="right" height="22"></td>
   <td>
    <input type="checkbox" name="om_autoactive" value="0" <%=nActive==0?"CHECKED":""%>> <%=mcBean.getLabel("wp-postedmsg")%>
   </td>
  </tr>
  <tr>
    <td width="12%" align="right" id="extra_label" height="30"><%=mcBean.getLabel("wp-acceptemail")%>:&nbsp;</td>
    <td><input name="om_acceptemails" value="<%=sAcceptEmails%>" size="100"></td>
  </tr>
 </table>
</SPAN>
<SPAN id="contactus_section" style='display:<%=((info.Type==14)?"inline":"none")%>'>
  <table cellpadding="0" cellspacing="0" border="0" width="100%" style="border: 1px dotted #DFDFDF; padding: 1px;">
   <tr>
     <td width="12%" align="right"><%=mcBean.getLabel("cm-info")%>&nbsp;</td>
     <td>
<% if (info.PageID>0) { %>
       <a href="<%=mcBean.encodedUrl("index.jsp?action=Load_Company&pt=Organization")%>"><%=mcBean.getLabel("cm-viewedit")%></a>
<% } %>
     </td>
   </tr>
   <tr>
     <td colspan="2" height="5"></td>
   </tr>
  </table>
</SPAN>
<% } %>
  </td>
 </tr>
 <tr>
   <td colspan="2"><HR align="center" width="100%" color="#D6D6D6" noShade SIZE=1></td>
 </tr>
 <% } %>
<tr>
  <td colspan="2" align="center" height="22">
  <input type="submit" name="submit" value="<%=sButtonValue%>" onClick="setAction(document.form_webpage, '<%=sNextAction%>');" style='width:120px'>
  </td>
</tr>
</table>
</form>
 <SCRIPT>onWebPageFormLoad(document.form_webpage, <%=info.Type==0%>);</SCRIPT>
 </TD>
</TR>
</TABLE>
</SPAN>
 </td>
</tr>
</table>
<!--iframe id='target_upload' name='target_upload' src='' style='display: none'></iframe-->
<% } %>