<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/liveclock.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.AdsReportBean" %>
<%@ page import="com.zyzit.weboffice.model.AdsSummaryInfo" %>
<%
  AdsReportBean bean = new AdsReportBean(session, 10);
//bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ADS_STATISTICS))
     return;

  String sAction = request.getParameter("action");
  if ("getgraphchart".equalsIgnoreCase(sAction))
  {
     boolean bRet = bean.getGraphChart(request, response);
     return;
  }
  else  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request);
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="20" valign="top"><font size="2"><a href="statistics.jsp?action=Reselect">Satistics Search</a> > <b>Summary Report</b></font></td>
  </tr>
  <tr>
    <td height="20" valign="top">This page gives you a summary overview of report in selected date frame. </td>
  </tr>
</table>
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="70%" height="25">&nbsp;Date Time Frame: <b><%=bean.getDisplayDateRange()%></b></td>
    <td width="30%" height="25" align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'reportlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
   </td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="15%" class="thCornerL" height="30">Total Ads</th>
    <th width="13%" class="thCornerR" height="30">Success</th>
    <th width="11%" class="thTop" height="30">Failed</th>
    <th width="20%" class="thCornerR" height="30">Date Range</th>
  </tr>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     AdsSummaryInfo osInfo = (AdsSummaryInfo)ltArray.get(i);
%>
  <tr>
    <td align="center" class="row1"><%=Utilities.getNumberFormat(osInfo.Total,'n',0)%></td>
    <td align="center" class="row1"><%=Utilities.getNumberFormat(osInfo.Success,'n',0)%></td>
    <td align="center" class="row1"><%=Utilities.getNumberFormat(osInfo.Failed,'n',0)%></td>
    <td align="center" class="row1"><%=osInfo.DateFrom%> - <%=osInfo.DateTo%></td>
  </tr>
<% } %>

<% if ("Bar".equalsIgnoreCase(bean.getChartType())||"Trend".equalsIgnoreCase(bean.getChartType())) {%>
  <tr>
    <td colspan="7" height="25" align="center" class="row1" valign="bottom"><font size=2><b>Statistics Trend Chart</b></font></td>
  </tr>
  <tr>
    <td colspan="7" align="center" class="row1">
       <IMG src='reportlist.jsp?action=getgraphchart'>
    </td>
  </tr>
<% } %>
  <tr>
    <td colspan="7" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
         <td width="30%"></td>
         <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>