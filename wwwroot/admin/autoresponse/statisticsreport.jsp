<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/liveclock.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.zyzit.weboffice.bean.AutoResponseStatisticsBean"%>
<%@ page import="com.zyzit.weboffice.model.AutoResponseSummaryInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%
  AutoResponseStatisticsBean bean = new AutoResponseStatisticsBean(session);
//bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EMAILCAMPAIGN))
     return;

  String sAction = request.getParameter("action");
  if ("getgraphchart".equalsIgnoreCase(sAction))
  {
     boolean bRet = bean.getGraphChart(request, response);
     return;
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request);

  String sHelpTag = "autoresponderstatisticreport";
//  String sTitleLinks = "<a href=\"responselist.jsp?action=Response List\">Autoresponder Group List</a> > <a href=\"statistics.jsp?action=Reselect\">AutoResponder Statistics Search</a> > <b>AutoResponder Statistics Report</b>";
  String sTitleLinks = bean.getNavigation(request, "AutoResponder Statistics Report");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page gives you a statistics summary of this email campaign in selected date frame.
<p>
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="70%" height="25">&nbsp;Date Time Frame: <b><%=bean.getDisplayDateRange()%></b></td>
    <td width="30%" height="25" align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'statisticsreport.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
   </td>
  </tr>
</table>
<table width="98%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" class="thCornerL" height="30">No.</th>
    <th width="15%" class="thCornerR" height="30">Sent Successfully</th>
    <th width="12%" class="thTop" height="30">Sent failed</th>
    <th width="12%" class="thTop" height="30">Refused</th>
    <th width="12%" class="thTop" height="30">Email Read</th>
    <th width="12%" class="thTop" height="30">Member joined</th>
    <th width="12%" class="thTop" height="30">Links clicked</th>
    <th width="20%" class="thCornerR" height="30">Date Range</th>
  </tr>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     AutoResponseSummaryInfo info = (AutoResponseSummaryInfo)ltArray.get(i);
%>
  <tr>
    <td width="5%" align="center" class="row1"><a href='responsestatuslist.jsp?action=Load&autoid=<%=request.getParameter("autoid")%>&dateframe=<%=info.DateFrom%>|<%=info.DateTo%>'><%=(nStartNo+i)%></a></td>
    <td width="15%" align="center" class="row1"><%=Utilities.getNumberFormat(info.Successful,'n',0)%></td>
    <td width="12%" align="center" class="row1"><%=Utilities.getNumberFormat(info.Failure,'n',0)%></td>
    <td width="12%" align="center" class="row1"><%=Utilities.getNumberFormat(info.UpOut,'n',0)%></td>
    <td width="12%" align="center" class="row1"><%=Utilities.getNumberFormat(info.ReadCount,'n',0)%></td>
    <td width="12%" align="center" class="row1"><%=Utilities.getNumberFormat(info.JoinIn,'n',0)%></td>
    <td width="12%" align="center" class="row1"><%=Utilities.getNumberFormat(info.ClickTotal,'n',0)%></td>
    <td width="20%" align="center" class="row1"><%=info.DateFrom%> - <%=info.DateTo%></td>
  </tr>
<% } %>
<% if ("Bar".equalsIgnoreCase(bean.getChartType())||"Trend".equalsIgnoreCase(bean.getChartType())) {%>
  <tr>
    <td colspan="8" height="25" align="center" class="row1" valign="bottom"><font size=2><b>Statistics Trend Chart</b></font></td>
  </tr>
  <tr>
    <td colspan="8" align="center" class="row1">
       <IMG src='statisticsreport.jsp?action=getgraphchart'>
    </td>
  </tr>
<% } %>
  <tr>
    <td colspan="8" class="catBottom" height="2">
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