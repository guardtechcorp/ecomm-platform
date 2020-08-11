<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean" %>
<%@ page import="com.zyzit.weboffice.model.FileStorageInfo" %>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo" %>
<%@ page import="com.zyzit.weboffice.model.MemberInfo" %>
<%@ page import="java.io.File" %>
<%
    MemberFileBean bean = MemberFileBean.getObject(session);
    MemberInfo mbInfo = bean.getMemberInfo();
    int nIndex = Utilities.getInt(request.getParameter("index"), 0);
    if (bean.getHttpsUrl()==null)
    {
      response.setContentType("text/html; charset=ISO8859_1");
      request.setCharacterEncoding("UTF8");
    }

    File file = bean.getFileByIndex(nIndex);
    String sFilename = Utilities.convertFilename(file.getName(), false);

    String sTitle;
    String sUnlockCode = request.getParameter("unlockcode");
    if (sUnlockCode==null)
       sUnlockCode = Encrypt.getUniqueId("file-sharing", 8);
    String sSubject = "Share this file with you and enjoin to download.";
    String sMessage;
    if (file.isDirectory())
    {
       sTitle = bean.getLabel("fs-sharefolder") + " '<font color='blue'>" + sFilename + "</font>' " + bean.getLabel("fs-withfriend");
       sSubject = bean.getLabel("fs-shareafolder");//"Share a folder of my storage with you. Feel free to download and try to use them.";
       sMessage = bean.getLabel("fs-hifolder") + " '" + sFilename + "'" + bean.getLabel("fs-withyou");
    }
    else
    {
       sTitle = bean.getLabel("fs-sharefile") + " '<font color='blue'>" + sFilename + "</font>' " + bean.getLabel("fs-withfriend");
       sSubject = bean.getLabel("fs-shareafile");//"Share a file of my storage with you. Feel free to download and try to use it.";
       sMessage = bean.getLabel("fs-hifile") + " '" + sFilename + "' " + bean.getLabel("fs-withyou");
    }
    boolean bPublic = bean.isInPublicArea();

    String sDisplayMessage= null;
    int nDisplay = 0;
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
<SCRIPT language="JavaScript" src="/staticfile/admin/scripts/calendardateinput.js"></SCRIPT>
</HEAD>
<BODY onLoad="initModalWin();">
<form name="form_sharefile" action="#" method="post" onSubmit="return onValidateShareFile(this, '<%=bean.encodedUrl("ajax/response.jsp")%>');">
<INPUT type="hidden" name="action1" value="Send_ShareFile">
<INPUT type="hidden" name="format" value="text/html">
<INPUT type="hidden" name="type" value="7">
<INPUT type="hidden" name="memberids" value="">
<INPUT type="hidden" name="index" value="<%=nIndex%>">
<TABLE width="680" border=0 cellspacing=1 cellpadding=0 bgColor="#ffffff">
<tr>
  <td colspan=2 height="5"></td>
</tr>
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>    
<tr>
  <td id="share_title" colspan=2 height="28" align="center" valign="bottom"><B><FONT size=3><%=sTitle%></FONT></B></td>
</tr>
<tr>
 <td colspan=2 height="1" id="id_message"></td>
</tr>
<tr>
  <td colspan=2 height=5></td>
</tr>
<!--tr>
  <td align="right" width="14%">From:</td>
  <td><input maxlength=60 size=55 value="<%=Utilities.getValue(mbInfo.FirstName)%> <<%=mbInfo.EMail%>>" name="from" disabled>
  </td>
</tr-->
<tr>
  <td align="right" width="14%" height="28"><%=bean.getLabel("fs-emails")%>:&nbsp;</td>
  <td><input style="width:540px;" value="" name="emails">
     <br>(<%=bean.getLabel("cm-mailbycomma")%>)      
  </td>
</tr>

<tr>
  <td align="right" width="14%" valign="top"><%=bean.getLabel("fs-members")%>:&nbsp;</td>
  <td>
   <div id="scroll_list" style="width:540px;height:96px;background-color:white;overflow:auto;BORDER: #4279bd 1px solid; ">
    <%=bean.getMemberCheckBoxList(mbInfo.MemberID, true)%>
   </div>
  </td>
</tr>
<tr>
 <td colspan=2 height="5"></td>
</tr>
 <tr>
   <td align="right" width="14%" height="25"><%=bean.getLabel("cm-subject")%>:&nbsp;</td>
   <td><input style="width:540px;" value="<%=sSubject%>" name="subject"></td>
 </tr>
 <tr>
   <td align="right" width="14%" valign="top"><%=bean.getLabel("cm-message")%>:&nbsp;</td>
   <td> <textarea rows="6" style="width:540px;" wrap="virtual" name="content"><%=sMessage%></textarea></td>
 </tr>
<tr>
 <td colspan=2 height="5"></td>
</tr>    
 <tr>
  <td colspan=2>
  <span id="authorrization" style="DISPLAY: <%=bPublic?"none":"inline"%>">
  <table width="100%">
  <tr>
  <td width="14%" align="right" valign="top"><%=bean.getLabel("cm-authorize")%>:</td>
  <td>
   <select name="accessmode" onChange="onAccessModeChange(document.form_sharefile);">
   <option value="127"><%=bean.getLabel("fs-protect")%></option>
   <option value="2"><%=bean.getLabel("fs-needlogin")%></option>
   <option value="64"><%=bean.getLabel("fs-unlockkey")%></option>
   </select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=bean.getLabel("cm-unlockcode")%>:&nbsp;<input maxlength=32 size=16 name="unlockcode" value="<%=sUnlockCode%>" disabled>
  </td>
 </tr>
 <tr>
  <td align="right" width="14%"><%=bean.getLabel("cm-expired")%>:</td>
  <td>
   <table border=0 cellspacing=0 cellpadding=0>
    <tr>
     <td width="40%">
      <script>DateInput('expireddate', true, 'YYYY-MM-DD', '<%=Utilities.getExpiredDateByDay(7).substring(0,10)%>');</script>
     </td>
     <td>(<%=bean.getLabel("fs-maxday")%>) &nbsp;&nbsp;<input type="checkbox" name="sendmyself" value="1"><%=bean.getLabel("cm-sendself")%></td>
    </tr>
   </table>
  </td>
 </tr>
 </table>
 </span>     
 </td>
 <tr>
  <td colspan=2 valign="top"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
 </tr>
 <tr>
   <td colspan=2>
    <table border="0" width="100%">
     <tr>
      <td align="center">
       <input type="submit" name="submit" style='width:120px' value="<%=bean.getLabel("cm-sendnow")%>">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="button" name="close" style='width:120px' value="<%=bean.getLabel("cm-close")%>" onClick="javascript:closeModalWin();">
      </td>
     </tr>
   </table>
  </td>
 </tr>
</TABLE>
</form>
</BODY>
</HTML>