<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/liveclock.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.zyzit.weboffice.bean.StatisticsBean"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.WebSummaryInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%
  StatisticsBean bean = new StatisticsBean(session, 10);
//bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
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

  DomainInfo dmInfo = bean.getDomainInfo();
//  String sDisplayMessage = null;
//  String sClass = "successful";
  List ltArray = bean.getAll(request);

  String sHelpTag = "websitestatisticlist";
  String sTitleLinks = "<a href=\"website.jsp?action=Reselect\">Website Statistics Search</a> > <b>Website Statistics Report</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page gives you a summary overview of your webist statistics in selected date frame. Clicking the data range in any row, you can see a summary of page hits list in this period.
<p>
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="70%" height="25">&nbsp;Date Time Frame: <b><%=bean.getDisplayDateRange()%></b></td>
    <td width="30%" height="25" align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'websitelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
   </td>
  </tr>
</table>
<table width="98%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="8%" class="thCornerL" height="30">No.</th>
    <th width="13%" class="thCornerR" height="30">Visitors</th>
    <th width="15%" class="thTop" height="30">Customers</th>
    <th width="15%" class="thTop" height="30">Users</th>
    <th width="15%" class="thTop" height="30">Orders</th>
    <th width="14%" class="thTop" height="30">Members</th>
    <th width="20%" class="thCornerR" height="30">Date Range</th>
  </tr>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     WebSummaryInfo wsInfo = (WebSummaryInfo)ltArray.get(i);
%>
  <tr>
    <td width="8%" align="center" class="row1"><%=(nStartNo+i)%></td>
    <td width="13%" align="center" class="row1"><%=Utilities.getNumberFormat(wsInfo.ShopCustomer,'n',0)%></td>
    <td width="15%" align="center" class="row1"><%=Utilities.getNumberFormat(wsInfo.LoginCustomer,'n',0)%></td>
    <td width="15%" align="center" class="row1"><%=Utilities.getNumberFormat(wsInfo.CompanyUser,'n',0)%></td>
    <td width="15%" align="center" class="row1"><%=Utilities.getNumberFormat2(wsInfo.ProductOrder,'n',0)%></td>
    <td width="14%" align="center" class="row1"></td>
    <td width="20%" align="center" class="row1"><a title="Show the detail of page hits" href="webdetails.jsp?action=Show Detail&daterange=<%=wsInfo.DateFrom+'!'+wsInfo.DateTo%>"><%=wsInfo.DateFrom%> - <%=wsInfo.DateTo%></a></td>
  </tr>
<% } %>
<% if ("Bar".equalsIgnoreCase(bean.getChartType())||"Trend".equalsIgnoreCase(bean.getChartType())) {%>
  <tr>
    <td colspan="7" height="25" align="center" class="row1" valign="bottom"><font size=2><b>Statistics Trend Chart</b></font></td>
  </tr>
  <tr>
    <td colspan="7" align="center" class="row1">
       <IMG src='websitelist.jsp?action=getgraphchart'>
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