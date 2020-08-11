<%@ include file="../share/uparea.jsp"%>
<%@ include file="../share/waitprocess.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.bean.StatisticsBean"%>
<%@ page import="com.zyzit.weboffice.model.PageHitInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%
  StatisticsBean bean = new StatisticsBean(session, 10);
//bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
     return;

  String sDateRange = request.getParameter("daterange");
  String[] arDate = sDateRange.split("!");
  List ltArray = bean.getPageHitsList(request);

  String sHelpTag = "websitestatisticlist";
  String sTitleLinks = "<a href=\"website.jsp?action=Reselect\">Website Statistics Search</a> > <a href=\"javascript:history.go(-1);\">Website Statistics Report</a> > <b>Website Page Hits List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page gives you a detail of page hits in selected date frame.
<p>
<table width="80%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25">Date Range: <b><%=arDate[0] + " - " + arDate[1]%></b></td>
  </tr>
</table>
<table width="80%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="10%" class="thCornerL" height="30">No.</th>
    <th width="70%" class="thCornerR" height="30">Page Name</th>
    <th width="20%" class="thTop" height="30">Total Hits</th>
  </tr>
<%
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     PageHitInfo info = (PageHitInfo)ltArray.get(i);
%>
  <tr>
    <td width="10%" align="center" class="row1"><%=(i+1)%></td>
    <td width="70%" class="row1">  <%=info.Name%></td>
    <td width="20%" align="center" class="row1"><%=Utilities.getNumberFormat(info.m_Total,'n',0)%></td>
  </tr>
<% } %>
<script>showHideSpan('close','Processing');</script>
<%@ include file="../share/footer.jsp"%>