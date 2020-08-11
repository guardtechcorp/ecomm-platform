<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MoneyPocketBean"%>
<%@ page import="com.zyzit.weboffice.model.MoneyPocketInfo"%>
<%@ page import="com.zyzit.weboffice.model.Temp6Info"%>
<%
  MoneyPocketBean bean = new MoneyPocketBean(session, 16);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CUSTOMER))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";

  if ("Get List".equalsIgnoreCase(sAction))
  {
    int nTotalRecords = bean.getAll(request);
  }
  else  if ("Delete".equalsIgnoreCase(sAction))
  {
    MoneyPocketBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getPageList(request, "moneypocketlist.jsp?");

  String sHelpTag = "moneypocketlist";
  String sTitleLinks = bean.getNavigation(request, "Credit List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all the credit list of <b><%=bean.getCustomerName()%></b> and sort them. You can delete some of them or enter the credit page to edit it.
<p>
<table width="90%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'moneypocketlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="90%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="8%" class="thCornerL">No.</th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("Money", "moneypocketlist.jsp", "Money Total")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Type", "moneypocketlist.jsp", "How To Get")%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("ExpiredDate", "moneypocketlist.jsp", "Expired Date")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "moneypocketlist.jsp", "Date and Time")%></th>
    <th width="20%" align="center" class="thCornerL">Actions</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=7>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt((String)session.getAttribute(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
      MoneyPocketInfo info = (MoneyPocketInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="8%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="18%" align="right"><%=Utilities.getNumberFormat(info.Money, '$', 2)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td class="row1" width="20%"><%=bean.getCreditType(info)%></td>
    <td class="row1" width="14%" align="center"><%=Utilities.getValue(info.ExpiredDate)%></td>
    <td class="row1" width="20%" align="center"><%=Utilities.getDateValue(info.CreateDate, 19)%></td>
    <td class="row1" width="20%"><%=bean.getActions(info)%></td>
  </tr>
<%}}%>
  <tr>
    <td colspan="6" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="moneypocket.jsp?action=addcredit&customerid=<%=request.getParameter("customerid")%>">Add Credit</a></td>
          <td width="80%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br>
<%
   Temp6Info t6Info = bean.getTranactionSummary(request, bean.getCustomerId());
%>
<TABLE border=0 width="90%" align="center">
 <TR>
  <TD align="center"><font class='pagetitle'>Summary of Usage</font></TD>
 </TR>
 <TR>
  <TD height="2" align="center"></TD>
 </TR>
 <TR>
  <TD>

<table align="center" border="0" cellpadding="1" cellspacing="0" width="100%" class="highinfo">
<!--tr>
 <td height="20" width="35%" align="right">Date Range:&nbsp;&nbsp;<td>
 <td colspan="3"><b><%=Utilities.getDateValue(t6Info.DateFrom, 10)%> -- <%=Utilities.getDateValue(t6Info.DateTo, 10)%></b><td>
</tr-->
<tr>
 <td height="20" align="right" width="35%">Total times to use credit:&nbsp;&nbsp;<td>
 <td width="15%"><font color="#DD6900"><b><%=t6Info.UseTimes%></b></font><td>
 <td align="right" width="35%">Total spent from credit:&nbsp;&nbsp;<td>
 <td><font color="red"><b><%=Utilities.getNumberFormat(t6Info.TotalPay, '$', 2)%></b><font><td>
</tr>
<tr>
 <td height="25" align="right" width="35%">Total credit to have:&nbsp;&nbsp;<td>
 <td width="15%"><font color="green"><b><%=Utilities.getNumberFormat(t6Info.TotalBuy, '$', 2)%></b></font><td>
 <td align="right" width="35%">The current balance of credit:&nbsp;&nbsp;<td>
 <td><font color="green"><b><%=Utilities.getNumberFormat(t6Info.Balance, '$', 2)%></b></font><td>
</tr>
</table>
 </TD>
</TR>
</TABLE>
<%@ include file="../share/footer.jsp"%>
