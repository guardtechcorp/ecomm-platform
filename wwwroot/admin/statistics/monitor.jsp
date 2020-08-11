<%
  StatisticsBean bean = new StatisticsBean(session, 10);
//bean.dumpAllParameters(request);
  String sAction = request.getParameter("action");
  if ("Get ActionInfo".equalsIgnoreCase(sAction))
  {
    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(bean.getActionInfo(request));
    response.flushBuffer();
    return;
  }
  else if ("Stop ActionInfo".equalsIgnoreCase(sAction))
  {
    bean.stopActionInfo(request);
    return;
  }
  else if (sAction.startsWith("Table"))//Session List"))
  {//. Background process
    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(bean.getSessionTable(request));
    response.flushBuffer();
    return;
  }
%>
<!--%@ include file="../share/header.jsp"%-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<link rel="stylesheet" href="/staticfile/admin/css/main.css" type="text/css">
<title>Administrator - </title>
</head>
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/sarissa.js"></SCRIPT-->
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<body onLoad="onBodyLoad(3)" onUnload="onLeave();">
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<SCRIPT language="javascript" src="/staticfile/admin/scripts/liveclock.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.zyzit.weboffice.bean.StatisticsBean"%>
<%@ page import="com.zyzit.weboffice.session.UserSession"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ include file="../share/titlelink.jsp"%>
<%
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_STATISTICS))
     return;

  bean.getDateFrame(request);
  DomainInfo dmInfo = bean.getDomainInfo();

  String sHelpTag = "realtimemonitor";
  String sTitleLinks = "<b>Realtime Monitor the Activities of the Website</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page will allow you to monitor your website (front and/or console) in realtime.
<!--table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="20" valign="top"><font size="2"><b>Realtime Monitor the Activities of the Website</b></font></td>
    <td width="5%"  height="20" valign="top" onmouseover="showTipHelp('website');" onmouseout="showHideSpan('close','tiphelp');" >
     <a href="javascript:;" class="helplink"><IMG src="/staticfile/admin/images/quickhelp.gif" width=14 height=16 align="CENTER" border="0">Help</a>
    </td>
  </tr>
  <tr>
    <td height="1" valign="top" colspan="2">
     <DIV id="tiphelp" style="DISPLAY: none">
     <table width="100%" cellpadding="4" cellspacing="0" class="infobox">
      <tr>
       <td bgcolor="#FFFFCC"><DIV id="tipcontent"></DIV></td>
      </tr>
     </table>
     </DIV>
    </td>
  </tr>
  <tr>
    <td valign="top" colspan="2">This page will allow you to realtime monitor your website (front and console).</td>
  </tr>
</table-->
<form name="realtime" action="#"  method="post">
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="50%" height="25"><b>Monitor the website activities in realtime:</b></td>
    <td width="50%" height="25" align="right">
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
 <tr>
    <td width="20%" align="right">Only Show:</td>
    <td width="50%"><input name="website" type="checkbox" value="1" checked onClick="setShowBit(this);">Website&nbsp;&nbsp;
                    <input name="website" type="checkbox" value="2" onClick="setShowBit(this);">Console</td>
    <td align="right"><a href="javascript:copyToClipboard(document.realtime.logcontent)">Copy Content</a>&nbsp;&nbsp;</td>
 <tr>
</table>
   </td>
  </tr>
  <tr>
    <td colspan="2">
<table cellspacing=1 cellpadding=1 width="100%" align="center" border=0 class="forumline">
 <tr>
  <th width="11%">Date</th>
  <th width="8%">Time</th>
  <th width="8%" nowrap>Session</th>
  <th width="8%">Type</th>
  <th>Action and Message Information</th>
</tr>
<tr>
  <td align="left" colspan="5">
   <textarea name="logcontent" rows="16" cols="102" wrap="virtual" style="background-color: #000000; color: #daa520"></textarea>
  </td>
</tr>
</table>
    </td>
  </tr>
</table>
</form>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="50%" height="25"><b>Who is Online now</b></td>
    <td width="50%" height="25" align="right">Current Date and Time: <b><span id="clock"></span></b>&nbsp;</td>
  </tr>
</table>
<script>goforit();</script>
<script>setRealTimeOn(document.realtime.logcontent, true, 'monitor.jsp');</script>
<!--Script>onBodyLoad(3);</Script-->
<%@ include file="../share/footer.jsp"%>