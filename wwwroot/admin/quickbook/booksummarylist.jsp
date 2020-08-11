<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/liveclock.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="com.zyzit.weboffice.bean.BookSummaryBean"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.BookSummaryInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%
  BookSummaryBean bean = new BookSummaryBean(session, 20);
//bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_QUICKBOOK))
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

  String sHelpTag = "booksummary";
  String sTitleLinks = "<a href=\"booklist.jsp?action=Books\">Books</a> > <a href=\"booksummary.jsp?action=Reselect\">Statistics Report Search</a> > <b>Summary Report</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page will give you a summary overview of quick book report in selected date frame with specific category(s).
<p>
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="70%" height="25">&nbsp;Date Time Frame: <b><%=bean.getDisplayDateRange()%></b></td>
    <td width="30%" height="25" align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'booksummarylist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
   </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="25%" class="thCornerL">Category Name</th>
    <th width="11%" class="thCornerL">Total Items</th>
    <th width="15%" class="thCornerR">Total Income</th>
    <th width="15%" class="thTop">Total Expense</th>
    <th width="14%" class="thTop">Balance</th>
    <th width="20%" class="thCornerR">Date Range</th>
  </tr>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     BookSummaryInfo bsInfo = (BookSummaryInfo)ltArray.get(i);
%>
  <tr>
    <td width="25%" align="left" class="row1">&nbsp;<%=bean.getCategoryName(i+nStartNo-1)%></td>
    <td width="10%" align="right" class="row1"><%=Utilities.getNumberFormat2(bsInfo.TotalItems,'n',0)%>&nbsp;&nbsp;</td>
    <td width="11%" align="right" class="row1"><%=Utilities.getNumberFormat2(bsInfo.TotalIncome,'$',2)%>&nbsp;&nbsp;</td>
    <td width="15%" align="right" class="row1"><%=Utilities.getNumberFormat2(bsInfo.TotalExpense,'$',2)%>&nbsp;&nbsp;</td>
    <td width="14%" align="right" class="row1"><%=bean.getTotalBalance(bsInfo.TotalBalance)%>&nbsp;&nbsp;</td>
    <td width="20%" align="center" class="row1"><%=bsInfo.DateFrom%> - <%=bsInfo.DateTo%></td>
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