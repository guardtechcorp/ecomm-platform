<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean" %>
<%@ page import="com.zyzit.weboffice.model.FileStorageInfo" %>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo" %>
<%
    MemberFileBean bean = MemberFileBean.getObject(session);
    int nIndex = Utilities.getInt(request.getParameter("index"), 0);

    String sRealAction = MemberFileBean.getRealAction(request);
    String sDisplayMessage = null;
    int nDisplay = 1;
    FileStorageInfo fsInfo;
    boolean bClose = false;
    if ("Submit_EditFile".equalsIgnoreCase(sRealAction)) {
//MemberFileBean.dumpAllParameters(request);
        BasicBean.Result ret = bean.update(request);
        if (ret.isSuccess()) {
            sDisplayMessage = "The property information is updated successfully.";
            bClose = "checked".equalsIgnoreCase(bean.getCloseFlag());
            System.out.println("bClose=" + bean.getCloseFlag() + "," + bClose + "," + "checked".equalsIgnoreCase(bean.getCloseFlag()));
        } else {
            sDisplayMessage = (String) ret.getInfoObject();
            nDisplay = 0;
        }

        fsInfo = (FileStorageInfo) ret.getUpdateInfo();
    } else //if ("getProperty".equalsIgnoreCase(sRealAction))
    {
        fsInfo = bean.getFileProperty(request);
        if (fsInfo == null)
            fsInfo = FileStorageInfo.getInstance(true);
    }

    String sFilename = bean.getFilenameByIndex(nIndex);
    int nPos = sFilename.lastIndexOf("/");
    ConfigInfo cfInfo = bean.getSiteConfig(session);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<META name="DISTRIBUTION" content="GLOBAL">
<META name="COPYRIGHT" content="Copyright 1998-2007 webonlinemanage.com - Redistribution in part or in whole strictly prohibited.">
<META name="DESCRIPTION" content="A place for your cyber life">
<META name="ROBOTS" content="INDEX, FOLLOW">
<META name="REVISIT-AFTER" content="1 DAYS">
<META name="RATING" content="GENERAL">
<LINK href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet">
<LINK href="/staticfile/web/css/office_xp.css" type="text/css" rel="stylesheet">
<LINK href="/staticfile/web/css/tabs.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="/staticfile/web/css/tabletag4.css" type="text/css">
<link rel="stylesheet" href="/staticfile/web/css/verticalmenu.css" type="text/css">
<link rel="stylesheet" href="/staticfile/web/modalwindow/dhtmlwindow.css" type="text/css">
<link rel="stylesheet" href="/staticfile/web/modalwindow/modal.css" type="text/css">
<!--link rel="shortcut icon" href="favicon.ico"-->
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/jsdomenu.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/windows.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/customer.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/session.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/newsletter.js"  type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/modalwindow/dhtmlwindow.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/modalwindow/modal.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/dom-drag.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/uploadstatus.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/filestorage.js"></SCRIPT>
</HEAD>
<BODY onLoad="initModalWin();">
<br>
<TABLE align="center" width="600" border=0 cellspacing=1 cellpadding=0 bgColor="#ffffff" style="border: 1px solid #DFDFDF; padding: 4px;">
<form name="form_editfile" action="<%=bean.encodedUrl("file/fileproperty.jsp")%>" method="post" onSubmit="return onValidateEditFile(this);">
<INPUT type="hidden" name="action1" value="Submit_EditFile">
<INPUT type="hidden" name="fileid" value=<%=fsInfo.FileID%>>
<INPUT type="hidden" name="index" value=<%=nIndex%>>
<INPUT type="hidden" name="currentdir" value="<%=bean.getCurrentDir()%>">
<INPUT type="hidden" name="filename" value="<%=sFilename%>">
<input type="hidden" name="subdir" value="file">
<tr>
<td colspan=2 height="10"></td>
</tr>
<TR>
 <TD colspan="2" height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
<tr>
 <td align="right" width="14%" height="20"><%=mcBean.getLabel("cm-filename")%>:&nbsp;</td>
 <td><b><%=sFilename.substring(nPos+1)%></b></td>
</tr>
<%  if (bean.isInPublicArea()) { %>
<tr>
  <td align="right" width="14%" height="20"><%=mcBean.getLabel("cm-weburl")%>:&nbsp;</td>
  <td><b><%=bean.getFileWebUrl(cfInfo.SiteName)%>/<%=sFilename%></b></td>
</tr>
<% } %>
<tr>
 <td align="right" width="14%"><%=mcBean.getLabel("cm-title")%>:&nbsp;</td>
 <td><input style="width:490px;" value="<%=Utilities.getValue(fsInfo.Title)%>" name="title"></td>
</tr>
<tr>
 <td align="right" width="14%" valign="top"><%=mcBean.getLabel("cm-desc")%>:&nbsp;</td>
 <td> <textarea rows="3" style="width:490px;" wrap="virtual" name="description"><%=Utilities.getValue(fsInfo.Description)%></textarea></td>
</tr>
<!--tr>
<td colspan=2 valign="top"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
</tr-->
<tr>
 <td align="right" width="14%"><input type="checkbox" value="yes" name="autoclose" <%=bean.getCloseFlag()%>></td>
 <td><%=mcBean.getLabel("fs-closeafter")%></td>
</tr>
<tr>
<td colspan=2 height="5"></td>
</tr>
<tr>
 <td colspan=2>
  <table border="0" width="100%">
   <tr>
    <td align="center">
     <input type="submit" name="submit" style='width:120px' value="<%=mcBean.getLabel("cm-submit")%>">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <input type="button" name="close" style='width:120px' value="<%=mcBean.getLabel("cm-close")%>" onClick="javascript:closeModalWin();">
    </td>
   </tr>
 </table>
</td>
</tr>
<tr>
<td colspan=2 height="5"></td>
</tr>
</form>
<SCRIPT>onEditFileFormLoad(document.form_editfile, <%=bClose%>);</SCRIPT>
</TABLE>
</BODY>
</HTML>