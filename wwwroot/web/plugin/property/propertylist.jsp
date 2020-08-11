<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.RSPropertyWeb"%>
<%@ page import="com.zyzit.weboffice.plugin.model.*"%>
<%@ page import="com.zyzit.weboffice.plugin.PropertyResult"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{

  RSPropertyWeb web = new RSPropertyWeb(session, 20);
  String sAction = web.getRealAction(request);
  PropertyResult result = web.getResult();
//  ConfigInfo cfInfo = web.getConfigInfo();
  int nRecNo = result.getRecordNo();
  int nStartNo = web.getPage(request, "index.jsp?action=pi-propertylist");
%>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
   <TR>
    <TD colspan="2"><%=web.getNavigationWeb(request, "Property List")%></TD>
   </TR>
   <TR>
     <TD height=5 valign="top"></TD>
   </TR>
   <TR>
    <TD align="center"><font class='pagetitle'>Property List</font></TD>
   </TR>
   <TR>
    <TD height=10></TD>
   </TR>
   <TR>
    <TD>
 <TABLE cellSpacing=0 cellPadding=0 width=100% border=1>
  <TR vAlign="middle" bgColor="#4959A7">
<% if (result.getTotalRecords()<=1) { %>
    <!--td width="6%"><input type="checkbox" name="allbox" value="1" onClick='alert("you click it.");'>&nbsp;<FONT color="#ffffff"><b>No.</b></FONT></td-->
    <td width="5%" align="center"><FONT color="#ffffff"><b>No.</b></FONT></td>
    <td width="18%" align="center" height=25><FONT color="#ffffff"><b>APN</b></FONT></td>
    <td width="29%" align="center" height=25><FONT color="#ffffff"><b>Owner Name</b></FONT></td>
    <td width="28%" align="center" height=25><FONT color="#ffffff"><b>Address</b></FONT></td>
    <td width="20%" align="center" height=25><FONT color="#ffffff"><b>City</b></FONT></td>
<% } else { %>
    <td width="5%" align="center"><FONT color="#ffffff"><b>No.</b></FONT></td>
    <td width="18%" align="center" height=25><%=web.getSortNameLink("APN", web.encodedUrl("index.jsp?action=pi-propertylist"), "APN", true)%></td>
    <td width="29%" align="center" height=25><%=web.getSortNameLink("C_OWNERS", web.encodedUrl("index.jsp?action=pi-propertylist"), "Owner Name", true)%></td>
    <td width="28%" align="center" height=25><%=web.getSortNameLink("C_ADDRESS80", web.encodedUrl("index.jsp?action=pi-propertylist"), "Address", true)%></td>
    <td width="20%" align="center" height=25><%=web.getSortNameLink("CITY", web.encodedUrl("index.jsp?action=pi-propertylist"), "City", true)%></td>
<% } %>
  </TR>
<%
//  int nStartNo = Utilities.getInt(web.getCacheData(web.KEY_STARTROWNO), 1);
  int nEndNo = web.getMaxRowsPerPage();
  if ((nEndNo+nStartNo)>result.getTotalRecords())
     nEndNo = result.getTotalRecords()-nStartNo+1;

  String sColor;
  for (int i=0; i<nEndNo; i++) {
    result.moveRecord(nStartNo+i-1);
    if (i%2==0)
       sColor = "#f7f7f7";
    else
       sColor = "#ffffff";
%>
  <tr bgColor="<%=sColor%>">
    <!--td width="5%"><input type="checkbox" name="check_<%=(nStartNo+i)%>" value="1">&nbsp;<%=(nStartNo+i)%></td-->
    <td width="5%" height=20><a href='<%=web.encodedUrl("index.jsp?action=pi-propertysummary&recno="+(nStartNo+i-1))%>'><%=(nStartNo+i)%></a></td>
    <td width="18%" height=20><a href='<%=web.encodedUrl("index.jsp?action=pi-propertysummary&recno="+(nStartNo+i-1))%>'><%=result.getFieldData("APN")%></a></td>
    <td width="29%" height=20><a href='<%=web.encodedUrl("index.jsp?action=pi-propertysummary&recno="+(nStartNo+i-1))%>'><%=result.getFieldData("C_OWNERS")%></a></td>
    <td width="28%" height=20><a href='<%=web.encodedUrl("index.jsp?action=pi-propertysummary&recno="+(nStartNo+i-1))%>'><%=result.getFieldData("C_ADDRESS80")%></a></td>
    <td width="20%" height=20><a href='<%=web.encodedUrl("index.jsp?action=pi-propertysummary&recno="+(nStartNo+i-1))%>'><%=result.getFieldData("CITY")%></a></td>
  </tr>
<%}
  result.moveRecord(nRecNo);
%>
  <!--tr><td colspan=5 height=2><HR align="left" width="100%" color="#4279bd" noShade SIZE=1></td></tr-->
  <tr bgColor="#dddddd">
    <td colspan=2 align="left" height="20"><%=" "+result.getTotalRecords()+" record" + (result.getTotalRecords()<2?"":"s")+" found."%></td>
    <td colspan=3 align="right"><%=web.encodedHrefLink(web.getCacheData(web.KEY_PAGELINKS))%></td>
  </tr>
</TABLE>
</td></tr></table>
<% } %>