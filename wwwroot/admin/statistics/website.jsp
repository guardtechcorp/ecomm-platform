<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<link rel="stylesheet" href="/staticfile/admin/css/main.css" type="text/css">
<title>Administrator - </title>
</head>
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/sarissa.js"--></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<body onUnload="onLeave();">
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/liveclock.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.zyzit.weboffice.bean.StatisticsBean"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ include file="../share/titlelink.jsp"%>
<%
  StatisticsBean bean = new StatisticsBean(session, 10);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_STATISTICS))
     return;

  String sAction = request.getParameter("action");
  bean.getDateFrame(request);
  DomainInfo dmInfo = bean.getDomainInfo();
  String sDisplayMessage = null;
  String sClass = "failed";
  if ("Show Statistics Report".equalsIgnoreCase(sAction))
  {
    int nTotalRecords = bean.getTotalRecords(request);
    if (nTotalRecords>0)
       response.sendRedirect("websitelist.jsp?action=Display Report");
    else
       sDisplayMessage = "No any records.";
  }
  String sHelpTag = "statisticssearch";
  String sTitleLinks = "<b>Website Statistics Search</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page will allow you to define a date range to get a overview of the various statistics of your website.
<p>
<!--table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="20" valign="top"><font size="2"><b>Website Statistics Search</b></font></td>
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
    <td height="20" valign="top" colspan="2">This page will allow you to define a date range to get a overview of the various statistics of your website.</td>
  </tr>
</table-->
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="50%" height="25">Web Site Started since: <b><%=Utilities.getDateValue(dmInfo.CreateDate, 10)%></b></td>
    <td width="50%" height="25" align="right">Current Date and Time: <b><span id="clock"></span></b>&nbsp;

    </td>
  </tr>
</table>
<%@ include file="../share/waitprocess.jsp"%>
<SPAN id="TimeFrame" style="display:inline-block">
<table border="0" cellpadding="3" cellspacing="1" width="99%" class="forumline" align="center">
  <form name="statistics" action="website.jsp"  method="post" onSubmit="validateDisplay(this);showHideSpan('open','Processing');showHideSpan('close','TimeFrame');">
   <input type="hidden" name="datedesc" value="">
    <tr>
      <th class="thHead" colspan="5" height="25" valign="middle" align="center">Select Date Range and Properties</th>
    </tr>
<% if (sDisplayMessage!=null) {%>
    <tr>
      <td class="row1" colspan="5" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="14%" align="right" height="19">&nbsp;</td>
      <td class="row1" width="25%" height="19">Weeks:
        <select name="week_last" onChange="onWeekLastChange(document.statistics)">
          <option value="0" selected>Select Weeks</option>
          <%=bean.getLasts(Calendar.WEEK_OF_YEAR, 20)%>
        </select>
      </td>
      <td class="row1" width="32%" height="19">Months:
        <select name="month_last" onChange="onMonthLastChange(document.statistics)">
          <option value="0" selected>Select Months</option>
          <%=bean.getLasts(Calendar.MONTH, 12)%>
        </select>
      </td>
      <td class="row1" colspan="2" height="19" width="29%">Years:
        <select name="year_last" onChange="onYearLastChange(document.statistics)">
          <option value="0" selected>Select Years</option>
          <%=bean.getLasts(Calendar.YEAR, 10)%>
        </select>
      </td>
    </tr>
    <tr>
      <td class="row1" colspan="2" align="right" height="19">Month of Year /Entire Year:</td>
      <td class="row1" colspan="3" height="19">
          <select name="month_which" onChange="onMonthWhichChange(document.statistics)">
            <option value="0" selected>Month</option>
            <option value="01">January</option>
            <option value="02">February</option>
            <option value="03">March</option>
            <option value="04">April</option>
            <option value="05">May</option>
            <option value="06">June</option>
            <option value="07">July</option>
            <option value="08">August</option>
            <option value="09">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>
          </select>
          of
          <select name="year_which" onChange="onYearWhichChange(document.statistics)">
            <option value="0" selected>Year</option>
            <%=bean.getYears(null)%>
          </select>
      </td>
    </tr>
    <tr>
      <td class="row1" colspan="5" align="right" height="2"><hr class="dotted"></td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Days Range: </td>
      <td class="row1" width="25%" valign="bottom">&nbsp;Month&nbsp;&nbsp;&nbsp;&nbsp;Day&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year</td>
      <td class="row1" width="32%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month&nbsp;&nbsp;&nbsp;&nbsp;Day&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year</td>
      <td class="row1" colspan="2" width="29%">Summary:
        <select name="perunit">
          <option value="all" selected>All Together</option>
          <option value="day">Each Day</option>
          <option value="week">Each Week</option>
          <option value="month">Each Month</option>
          <option value="year">Each Year</option>
        </select>
     </td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">From:</td>
      <td class="row1" width="25%">
        <select name="month_from" onChange="onDateRangeChange(document.statistics)">
          <option value="01">01</option>
          <option value="02">02</option>
          <option value="03">03</option>
          <option value="04">04</option>
          <option value="05">05</option>
          <option value="06">06</option>
          <option value="07">07</option>
          <option value="08">08</option>
          <option value="09">09</option>
          <option value="10">10</option>
          <option value="11">11</option>
          <option value="12">12</option>
        </select>
        /
        <select name="day_from" onChange="onDateRangeChange(document.statistics)">
          <option value="01">01</option>
          <option value="02">02</option>
          <option value="03">03</option>
          <option value="04">04</option>
          <option value="05">05</option>
          <option value="06">06</option>
          <option value="07">07</option>
          <option value="08">08</option>
          <option value="09">09</option>
          <option value="10">10</option>
          <option value="11">11</option>
          <option value="12">12</option>
          <option value="13">13</option>
          <option value="14">14</option>
          <option value="15">15</option>
          <option value="16">16</option>
          <option value="17">17</option>
          <option value="18">18</option>
          <option value="19">19</option>
          <option value="20">20</option>
          <option value="21">21</option>
          <option value="22">22</option>
          <option value="23">23</option>
          <option value="24">24</option>
          <option value="25">25</option>
          <option value="26">26</option>
          <option value="27">27</option>
          <option value="28">28</option>
          <option value="29">29</option>
          <option value="30">30</option>
          <option value="31">31</option>
        </select>
        /
        <select name="year_from" onChange="onDateRangeChange(document.statistics)">
          <%=bean.getYears(null)%>
        </select>
      </td>
      <td class="row1" width="32%" align="left">To:
          <select name="month_to" onChange="onDateRangeChange(document.statistics)">
            <option value="01">01</option>
            <option value="02">02</option>
            <option value="03">03</option>
            <option value="04">04</option>
            <option value="05">05</option>
            <option value="06">06</option>
            <option value="07">07</option>
            <option value="08">08</option>
            <option value="09">09</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
          </select>
          /
          <select name="day_to" onChange="onDateRangeChange(document.statistics)">
            <option value="01">01</option>
            <option value="02">02</option>
            <option value="03">03</option>
            <option value="04">04</option>
            <option value="05">05</option>
            <option value="06">06</option>
            <option value="07">07</option>
            <option value="08">08</option>
            <option value="09">09</option>
            <option value="10">10</option>
            <option value="11">11</option>
            <option value="12">12</option>
            <option value="13">13</option>
            <option value="14">14</option>
            <option value="15">15</option>
            <option value="16">16</option>
            <option value="17">17</option>
            <option value="18">18</option>
            <option value="19">19</option>
            <option value="20">20</option>
            <option value="21">21</option>
            <option value="22">22</option>
            <option value="23">23</option>
            <option value="24">24</option>
            <option value="25">25</option>
            <option value="26">26</option>
            <option value="27">27</option>
            <option value="28">28</option>
            <option value="29">29</option>
            <option value="30">30</option>
            <option value="31">31</option>
          </select>
          /
          <select name="year_to" onChange="onDateRangeChange(document.statistics)">
            <%=bean.getYears(null)%>
          </select>
      </td>
      <td class="row1" colspan="2" width="29%">Include Graph:
        <select name="graphchart">
          <option value="None" selected>None</option>
          <option value="Trend">Trend Chart</option>
          <option value="Bar">Bar Chart</option>
        </select>
      </td>
    </tr>
    <tr>
      <td class="row1" colspan="5" height="10">
     </td>
    </tr>
    <tr>
      <td class="catBottom" colspan="5" align="center">
        <input type="submit" name="action" value="Show Statistics Report">
      </td>
    </tr>
  </form>
</table>
<br>
</SPAN>
<!--form name="realtime" action="#"  method="post">
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="50%" height="25"><b>Monitor the website activities in realtime:</b></td>
    <td width="50%" height="25">
   <DIV id="on_realtime"><A href="javascript:;" onClick="openAndClose('off_realtime', 'on_realtime');showRealTime('RT_ACTIVATION', document.realtime.logcontent);"><IMG src="/staticfile/admin/images/arrow.gif" align=CENTER border=0>Open RealTime Window</A></DIV>
   <DIV id="off_realtime" style="display: none"><A href="javascript:;" onClick="openAndClose('on_realtime', 'off_realtime');showRealTime('RT_ACTIVATION', document.realtime.logcontent);"><IMG src="/staticfile/admin/images/arrowdown.gif" align=CENTER border=0>Close RealTime Window</A></DIV>
   </td>
  </tr>
  <tr>
    <td colspan="2">
<DIV id="RT_ACTIVATION" style="display: none">
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<tr>
<td width="10%" align="center"><b>Date</b></td>
<td width="11%" align="center"><b>Time</b></td>
<td width="10%" align="center"><b>Session ID</b></td>
<td width="59%">&nbsp;&nbsp;&nbsp;&nbsp;<b>Action or Message Information</b></td>
<td width="10%" align="right" valign="top"><a href="javascript:copyToClipboard(document.realtime.logcontent)">Copy</a>&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
  <td align="left" colspan="5">
   <textarea name="logcontent" rows="10" cols="100" wrap="virtual" style="background-color: #000000; color: #daa520"></textarea>
  </td>
 </td>
</tr>
</table>
</DIV>
    </td>
  </tr>
</table>
</form-->
<script>goforit();</script>
<SCRIPT>onStatisticsLoad(document.statistics, "<%=bean.getDateRange()%>", "<%=Utilities.getValue(bean.getInitFieldValue(request))%>");</SCRIPT>
<script>makeDefaultSelect(document.statistics.perunit, "<%=bean.getPerUnit(request)%>");</script>
<script>makeDefaultSelect(document.statistics.graphchart, "<%=bean.getGraphChart(request)%>");</script>
<%@ include file="../share/footer.jsp"%>