<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BuyCreditWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.model.MoneyPocketInfo"%>
<%@ page import="com.zyzit.weboffice.model.Temp6Info"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  BuyCreditWeb web = new BuyCreditWeb(session, 10);
  String sAction = web.getRealAction(request);
  CustomerInfo ctInfo =  web.getCustomerInfo();
  if (ctInfo==null)
  {//. It is not login and we need to forece it to login first
//    response.sendRedirect(web.encodedUrl("index.jsp?action=cp-memberlogin&nextaction=cp-transactionlist"));
    TransferWeb.sendRedirectContent(response, "index.jsp?action=cp-accountlogin&nextaction=cp-transactionlist");
    return;
  }

  String sType = request.getParameter("type");
//  if ("afterlogin".equalsIgnoreCase(sType))
  {
     int nTotalRecords = web.getTotalRecords(request);
//System.out.println("nTotalRecords=" + nTotalRecords);
  }

//  ConfigInfo cfInfo = web.getConfigInfo();
  List ltTransaction = web.getPageList(request, "index.jsp?action=cp-transactionlist");

  String sTitleLinks = web.getNavigationWeb(request, "Transaction History");
%>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
 <tr>
  <td height=20><%=sTitleLinks%></td>
 </tr>
 <TR>
  <TD height="5" valign="top"></TD>
 </TR>
 <TR>
  <TD align="center"><font class='pagetitle'>Buy Credit List</font></TD>
 </TR>
 <TR>
  <TD height="5" valign="bottom"></TD>
 </TR>
 <TR>
  <TD>
  <TABLE width="99%" align="center" border=0 cellpadding="0" cellspacing="1" class="table-4borders">
  <TR vAlign="middle" bgColor="#4959A7">
<% if (ltTransaction==null || ltTransaction.size()==0) { %>
    <!--td width="6%"><input type="checkbox" name="allbox" value="1" onClick='alert("you click it.");'>&nbsp;<FONT color="#ffffff"><b>No.</b></FONT></td-->
    <td width="5%" align="center"><FONT color="#ffffff"><b>No.</b></FONT></td>
    <td width="24%" align="center" height=20><FONT color="#ffffff"><b>Invoice/Report No.</b></FONT></td>
    <td width="15%" align="center" height=20><FONT color="#ffffff"><b>Buy or Pay</b></FONT></td>
    <td width="22%" align="center" height=20><FONT color="#ffffff"><b>Through Way</b></FONT></td>
    <td width="15%" align="center" height=20><FONT color="#ffffff"><b>Action</b></FONT></td>
    <td width="19%" align="center" height=20><FONT color="#ffffff"><b>Date and Time</b></FONT></td>
  </TR>
  <TR>
    <td colspan="6">There is no any trasaction available.<td>
<% } else { %>
    <td width="5%" align="center"><FONT color="#ffffff"><b>No.</b></FONT></td>
    <td width="24%" align="center" height=20><%=web.getSortNameLink("ReferenceNo", web.encodedUrl("index.jsp?action=cp-transactionlist"), "Invoice/Report No.", true)%></td>
    <td width="15%" align="center" height=20><%=web.getSortNameLink("Money", web.encodedUrl("index.jsp?action=cp-transactionlist"), "Buy or Pay", true)%></td>
    <td width="22%" align="center" height=20><%=web.getSortNameLink("Type", web.encodedUrl("index.jsp?action=cp-transactionlist"), "Through Way", true)%></td>
    <td width="15%" align="center" height=20><%=web.getSortNameLink("Category", web.encodedUrl("index.jsp?action=cp-transactionlist"), "Action", true)%></td>
    <td width="19%" align="center" height=20><%=web.getSortNameLink("CreateDate", web.encodedUrl("index.jsp?action=cp-transactionlist"), "Date and Time", true)%></td>
<% } %>
  </TR>
<%
  String sColor;
  int nStartNo = Utilities.getInt(web.getCacheData(web.KEY_STARTROWNO), 1);
  for (int i=0; ltTransaction!=null && i<ltTransaction.size(); i++) {
    MoneyPocketInfo info = (MoneyPocketInfo)ltTransaction.get(i);

    if (i%2==0)
       sColor = "#f7f7f7";
    else
       sColor = "#ffffff";
%>
  <tr bgColor="<%=sColor%>">
    <td width="5%" height="18" align="center">&nbsp;<%=(nStartNo+i)%></td>
    <td width="24%" height="18" align="center"><%=Utilities.getValue(info.ReferenceNo)%></td>
    <td width="15%" height="18" align="right"><%=Utilities.getNumberFormat(info.Money,'$',2)%>&nbsp;&nbsp;&nbsp;</td>
    <td width="22%" height="18" align="center"><%=web.getThroughWay(info)%></td>
    <td width="15%" height="18" align="center"><%=web.getAction(info)%></td>
    <td width="19%" height="20" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
  </tr>
<% } %>
<% if (ltTransaction!=null && ltTransaction.size()>0) { %>
   <tr>
    <td colspan="6" align="right" height="20" class="row-footer"><%=web.encodedHrefLink(web.getCacheData(web.KEY_PAGELINKS))%></td>
   </tr>
<% } %>
   </TABLE>
   </TD>
 </TR>
 <TR>
  <TD height="5" align="center"></TD>
 </TR>
 <TR>
  <TD align="center"><font class='pagetitle'>Summary of Usage<font></TD>
 </TR>
 <TR>
  <TD height="2" align="center"></TD>
 </TR>
 <TR>
  <TD>
<%
   Temp6Info t6Info = web.getTranactionSummary(request, ctInfo);
%>
   <table align="center" border="0" cellpadding="1" cellspacing="0" width="98%" class="highinfo">
    <tr>
     <td height="20" width="35%" align="right">Date Range:&nbsp;&nbsp;<td>
     <td colspan="3"><b><%=Utilities.getDateValue(t6Info.DateFrom, 10)%> -- <%=Utilities.getDateValue(t6Info.DateTo, 10)%></b><td>
    </tr>
    <tr>
     <td height="20" align="right" width="35%">Total times to run reports:&nbsp;&nbsp;<td>
     <td width="15%"><font color="#DD6900"><b><%=t6Info.ReportTimes%></b></font><td>
     <td align="right" width="35%">Total pay to get reports:&nbsp;&nbsp;<td>
     <td><font color="red"><b><%=Utilities.getNumberFormat(t6Info.TotalPay, '$', 2)%></b><font><td>
    </tr>
    <tr>
     <td height="25" align="right" width="35%">Total credit to buy:&nbsp;&nbsp;<td>
     <td width="15%"><font color="green"><b><%=Utilities.getNumberFormat(t6Info.TotalBuy, '$', 2)%></b></font><td>
     <td align="right" width="35%">The current balance of credit:&nbsp;&nbsp;<td>
     <td><font color="green"><b><%=Utilities.getNumberFormat(t6Info.Balance, '$', 2)%></b></font><td>
    </tr>
   </table>
  </TD>
 </TR>
</table>
<% } %>