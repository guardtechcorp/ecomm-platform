<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/statistics.js"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/liveclock.js"></script>
<!--%@ page import="java.util.List"%-->
<%@ page import="java.util.Calendar"%>
<%@ page import="com.zyzit.weboffice.bean.SaleReportBean"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%
  SaleReportBean bean = new SaleReportBean(session, 10);
//bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_SALEREPORT))
     return;

  bean.getDateFrame(request);

  DomainInfo dmInfo = bean.getDomainInfo();
  String sDisplayMessage = null;
  String sClass = "failed";
  String sAction = request.getParameter("action");
  if ("Show Sales Report".equalsIgnoreCase(sAction))
  {
    int nTotalRecords = bean.getTotalRecords(request);
    if (nTotalRecords>0)
    {
       bean.saveSelection(request);
       response.sendRedirect("salereportlist.jsp?action=Show Report");
    }
    else
    {
       sDisplayMessage = "No any records.";
    }
  }

  String sHelpTag = "salereport";
  String sTitleLinks = "<b>Sales Report Search</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page will allow you to define a date range to get a overview of the various sales report summary.
<p>
<%@ include file="../share/waitprocess.jsp"%>
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="50%" height="25">Web Site Started since: <b><%=Utilities.getDateValue(dmInfo.CreateDate, 16)%></b></td>
    <td width="50%" height="25" align="right">Current Time: <b><span id="clock"></span></b>&nbsp;</td>
  </tr>
</table>
<table border="0" cellpadding="3" cellspacing="1" width="95%" class="forumline" align="center">
  <form name="salereport" action="salereport.jsp"  method="post" onSubmit="validateDisplay(this);showHideSpan('open','Processing');">
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
        <select name="week_last" onChange="onWeekLastChange(document.salereport)">
          <option value="0" selected>Select Weeks</option>
          <%=bean.getLasts(Calendar.WEEK_OF_YEAR, 20)%>
        </select>
      </td>
      <td class="row1" width="32%" height="19">Months:
        <select name="month_last" onChange="onMonthLastChange(document.salereport)">
          <option value="0" selected>Select Months</option>
          <%=bean.getLasts(Calendar.MONTH, 12)%>
        </select>
      </td>
      <td class="row1" colspan="2" height="19" width="29%">Years:
        <select name="year_last" onChange="onYearLastChange(document.salereport)">
          <option value="0" selected>Select Years</option>
          <%=bean.getLasts(Calendar.YEAR, 10)%>
        </select>
      </td>
    </tr>
    <tr>
      <td class="row1" colspan="2" align="right" height="19">Month of Year /Entire Year:</td>
      <td class="row1" colspan="3" height="19">
          <select name="month_which" onChange="onMonthWhichChange(document.salereport)">
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
          <select name="year_which" onChange="onYearWhichChange(document.salereport)">
            <option value="0" selected>Year</option>
            <%=bean.getYears(null)%>
          </select>
      </td>
    </tr>
    <tr>
      <td class="row1" colspan="5" align="right" height="2"><hr class="dotted"></td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right" height="23">Days Range: </td>
      <td class="row1" width="25%" height="23" valign="bottom">&nbsp;Month&nbsp;&nbsp;&nbsp;&nbsp;Day&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year</td>
      <td class="row1" width="32%" height="23">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month&nbsp;&nbsp;&nbsp;&nbsp;Day&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year</td>
      <td class="row1" colspan="2" height="23" width="29%">Summary:
       <select name="perunit" onChange="onSummaryChange(document.salereport)">
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
        <select name="month_from" onChange="onDateRangeChange(document.salereport)">
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
        <select name="day_from" onChange="onDateRangeChange(document.salereport)">
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
        <select name="year_from" onChange="onDateRangeChange(document.salereport)">
          <%=bean.getYears(null)%>
        </select>
      </td>
      <td class="row1" width="32%" align="left">To:
          <select name="month_to" onChange="onDateRangeChange(document.salereport)">
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
          <select name="day_to" onChange="onDateRangeChange(document.salereport)">
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
          <select name="year_to" onChange="onDateRangeChange(document.salereport)">
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
      <td class="row1" colspan="5" align="right" height="10"></td>
    </tr>
    <tr>
      <td class="row1" align="right" valign="top">Products:</td>
      <td class="row1" height="19">
      <select name="productid" size="6" multiple>
        <%=bean.getProductList()%>
      </select>
      </td>
      <td class="row1" colspan="2" valign="top">Hold down the Shift or Ctrl key and click on the items you want to select or deselected. <br>If no selection, it means all products.</td>
      <td class="row1" width="29%" valign="top">Show:
        <select name="showtype">
          <option value="all">All Together</option>
          <option value="each" selected>Each Products</option>
        </select>
      </td>
    </tr>
    <tr>
      <td class="row1" colspan="5" align="right" height="10"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="5" align="center">
        <input type="submit" name="action" value="Show Sales Report">
      </td>
    </tr>
  </form>
</table>
<script>goforit();</script>
<SCRIPT>onStatisticsLoad(document.salereport, "<%=bean.getDateRange()%>", "<%=Utilities.getValue(bean.getInitFieldValue(request))%>");</SCRIPT>
<script>makeDefaultSelect(document.salereport.perunit, "<%=bean.getPerUnit(request)%>");</script>
<script>makeDefaultSelect(document.salereport.graphchart, "<%=bean.getGraphChart(request)%>");</script>
<script>selectMultpleOptions(document.salereport.productid, "<%=bean.getSelection()%>", ",");</script>
<%@ include file="../share/footer.jsp"%>
