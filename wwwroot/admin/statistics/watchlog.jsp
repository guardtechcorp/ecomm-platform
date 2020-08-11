<%
  StatisticsBean bean = new StatisticsBean(session, 10);
//bean.dumpAllParameters(request);
  String sAction = request.getParameter("action");
  if ("Get ActionInfo".equalsIgnoreCase(sAction))
  {
    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(bean.getAllActionInfo(request));
    response.flushBuffer();
    return;
  }
  else if ("Stop ActionInfo".equalsIgnoreCase(sAction))
  {
    bean.stopAllActionInfo(request);
    return;
  }
  if ("Get UsedMemory".equalsIgnoreCase(sAction))
  {
    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(bean.getUsedMemory(request));
    response.flushBuffer();
    return;
  }
%>
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
<SCRIPT type="text/javascript" src="/staticfile/admin/scripts/wz_jsgraphics.js"></SCRIPT>
<SCRIPT type="text/javascript" src="/staticfile/admin/scripts/proccess.js"></SCRIPT>
<body onUnload="onLeave();">
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
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_DOMAINMONITOR))
     return;

  bean.getDateFrame(request);
  DomainInfo dmInfo = bean.getDomainInfo();
  String sHelpTag = "website";
  String sTitleLinks = "<b>Realtime Monitor the Activities of all the Website</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
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
  <th>DomainName, Action and Message Information</th>
</tr>
<tr>
  <td align="left" colspan="5">
   <textarea name="logcontent" rows="14" cols="102" wrap="virtual" style="background-color: #000000; color: #daa520"></textarea>
  </td>
</tr>
</table>
    </td>
  </tr>
</table>
<table cellspacing=1 cellpadding=1 width="100%" align="center" border=0 class="forumline">
<tr>
  <td align="left">
   <div id="proccessCanvas" style="overflow: auto; position:relative; width:837px; height:200px;"></div>
  </td>
</tr>
</table>
</form>
<script>setRealTimeOn(document.realtime.logcontent, true, 'watchlog.jsp');</script>
<script type="text/javascript">startProcess(837, 200, <%=bean.getTotalMemory()%>, 2);</script>
<%@ include file="../share/footer.jsp"%>