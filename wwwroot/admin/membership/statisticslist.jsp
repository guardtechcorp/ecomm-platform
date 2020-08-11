<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/liveclock.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.zyzit.weboffice.bean.MemberSummaryBean"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.UsageSummaryInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%
  MemberSummaryBean bean = new MemberSummaryBean(session, 20);
//bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERAREA))
     return;

  String sAction = request.getParameter("action");
  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  DomainInfo dmInfo = bean.getDomainInfo();
  String sDisplayMessage = null;
  String sClass = "successful";
  List ltArray = bean.getAll(request);
%>
<%@ include file="../share/waitprocess.jsp"%>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25" valign="top"><font size="2"><a href="statistics.jsp?action=Reselect">Member Statistics Report Search</a> > <b>Statistics Report</b></font></td>
  </tr>
  <tr>
    <td height="25" valign="top">This page will give you a summary overview in selected date frame with specific member(s).</td>
  </tr>
</table>
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="70%" height="25">&nbsp;Date Time Frame: <b><%=bean.getDisplayDateRange()%></b></td>
    <td width="30%" height="25" align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'statisticslist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
   </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="20%" class="thCornerL" height="30">Lonin Counts</th>
    <th width="20%" class="thCornerR" height="30">Data Input Bytes</th>
    <th width="20%" class="thTop" height="30">Data Output Bytes</th>
    <th width="20%" class="thTop" height="30">Duration Times</th>
    <th width="20%" class="thCornerR" height="30">Date Range</th>
  </tr>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     UsageSummaryInfo info = (UsageSummaryInfo)ltArray.get(i);
%>
  <tr>
    <td width="20%" align="center" class="row1"><%=Utilities.getNumberFormat2(info.TotalCounts,'n',0)%></td>
    <td width="20%" align="center" align="right" class="row1"><%=Utilities.convertFileSize(info.TotalInputBytes)%></td>
    <td width="20%" align="center" align="right" class="row1"><%=Utilities.convertFileSize(info.TotalOutputBytes)%></td>
    <td width="20%" align="center" align="right" class="row1"><%=Utilities.getDuration(info.TotalSeconds)%></td>
    <td width="20%" align="center" class="row1"><%=info.DateFrom%> - <%=info.DateTo%></td>
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
<script>showHideSpan('close','Processing');</script>
<%@ include file="../share/footer.jsp"%>