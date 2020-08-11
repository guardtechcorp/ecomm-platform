<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.RSPropertyWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.model.PropertyArchiveInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  RSPropertyWeb web = new RSPropertyWeb(session, 20);
  String sAction = web.getRealAction(request);

  CustomerInfo ctInfo =  web.getCustomerInfo();
  if (ctInfo==null)
  {//. It is not login and we need to forece it to login first
    TransferWeb.sendRedirectContent(response, "index.jsp?action=cp-accountlogin&nextaction=pi-reportarchive");
    return;
  }

  int nTotalRecords = web.beginArchiveSearch(request);
//System.out.println("nTotalRecords=" + nTotalRecords);
  List ltArchive = web.getPageList(request, "index.jsp?action=pi-reportarchive");
%>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
 <tr>
  <td height="20"><%=web.getNavigationWeb(request, "Archived Reports")%></td>
 </tr>
 <TR>
  <TD height="3" valign="top"></TD>
 </TR>
 <TR>
  <TD align="center"><font class='pagetitle'>Archived Reports</font></TD>
 </TR>
 <!--TR>
  <TD align="right"><a href="<%=web.getHttpLink("index.jsp?action=cp-transactionlist")%>">Transaction History</a>&nbsp;</TD>
 </TR-->
 <TR>
  <TD height="5" valign="bottom"></TD>
 </TR>
 <TR>
  <TD>
  <TABLE width=100% align="center" border=0 cellpadding="0" cellspacing="1" class="table-4borders">
  <TR vAlign="middle" bgColor="#4959A7">
<% if (ltArchive==null || ltArchive.size()==0) { %>
    <!--td width="6%"><input type="checkbox" name="allbox" value="1" onClick='alert("you click it.");'>&nbsp;<FONT color="#ffffff"><b>No.</b></FONT></td-->
    <td width="7%" align="center"><FONT color="#ffffff"><b>No.</b></FONT></td>
    <td width="17%" align="center" height=20><FONT color="#ffffff"><b>Report No</b></FONT></td>
    <td width="29%" align="center" height=20><FONT color="#ffffff"><b>Address</b></FONT></td>
    <td width="27%" align="center" height=20><FONT color="#ffffff"><b>City/State/Zip</b></FONT></td>
    <td width="20%" align="center" height=20><FONT color="#ffffff"><b>Process Date</b></FONT></td>
   </TR>
   <TR>
    <td colspan="5">There is no any archived report available.<td>
<% } else {
   String sSortLink = web.encodedUrl("index.jsp?action=pi-reportarchive");
%>
    <td width="7%" align="center"><FONT color="#ffffff"><b>No.</b></FONT></td>
    <td width="17%" align="center" height=20><%=web.getSortNameLink("OrderNo", sSortLink, "Report No", true)%></td>
    <td width="29%" align="center" height=20><%=web.getSortNameLink("StreetName", sSortLink, "Address", true)%></td>
    <td width="27%" align="center" height=20><%=web.getSortNameLink("City", sSortLink, "City/State/Zip", true)%></td>
    <td width="20%" align="center" height=20><%=web.getSortNameLink("CreateDate", sSortLink, "Process Date", true)%></td>
<% } %>
  </TR>
<%
  String sColor;
  int nStartNo = Utilities.getInt(web.getCacheData(web.KEY_STARTROWNO), 1);
  for (int i=0; ltArchive!=null && i<ltArchive.size(); i++) {
    PropertyArchiveInfo info = (PropertyArchiveInfo)ltArchive.get(i);
    if (i%2==0)
       sColor = "#f7f7f7";
    else
       sColor = "#ffffff";
%>
  <tr bgColor="<%=sColor%>">
    <td height="18" width="7%" align="center"><a href='<%=web.encodedUrl("index.jsp?action=pi-archive-propertyreports&recno="+(nStartNo+i-1))%>' title="View Report"><%=(nStartNo+i)%></a></td>
    <td height="18" width="17%"><a href='<%=web.encodedUrl("index.jsp?action=pi-archive-propertyreports&recno="+(nStartNo+i-1))%>' title="View Report"><%=Utilities.getValue(info.OrderNo)%></a></td>
    <td height="18" width="29%"><a href='<%=web.encodedUrl("index.jsp?action=pi-archive-propertyreports&recno="+(nStartNo+i-1))%>' title="View Report"><%=web.getFieldDate(info, "C_ADDRESS80")%></a></td>
    <td height="18" width="27%"><a href='<%=web.encodedUrl("index.jsp?action=pi-archive-propertyreports&recno="+(nStartNo+i-1))%>' title="View Report"><%=web.getFieldDate(info, "C_CITYSTATEZIP")%></a></td>
    <td height="18" width="20%"><a href='<%=web.encodedUrl("index.jsp?action=pi-archive-propertyreports&recno="+(nStartNo+i-1))%>' title="View Report"><%=Utilities.getDateValue(info.CreateDate, 16)%></a></td>
  </tr>
<% } %>
   <tr>
    <td colspan="5" align="right" height="20" class="row-footer"><%=web.encodedHrefLink(web.getCacheData(web.KEY_PAGELINKS))%></td>
   </tr>
   </TABLE>
   </TD>
 </TR>
</table>
<% } %>