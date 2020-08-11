<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.RSPropertyWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.plugin.model.*"%>
<%@ page import="com.zyzit.weboffice.plugin.PropertyResult"%>
<%@ page import="com.zyzit.weboffice.plugin.ReportType"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.database.Product"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%
{
  RSPropertyWeb web = new RSPropertyWeb(session, 20);
  String sAction = web.getRealAction(request);
//System.out.println("sAction Property Search=" + sAction);
  PropertyResult result = result = web.getResult();
  int nRecNo;
  if (request.getParameter("recno")==null)
     nRecNo = result.getRecordNo();
  else
     nRecNo = Integer.parseInt(request.getParameter("recno"));
  if (sAction.endsWith("selectreportoptions"))
  { //. Try to generate reports
    String sReports = web.selectReportOptions(request);
//    response.sendRedirect(web.encodedUrl("index.jsp?action=propertybillinfo&recno="+nRecNo));
    TransferWeb.sendRedirectContent(response, "index.jsp?action=pi-propertybillinfo&recno="+nRecNo);
    return;
  }

//System.out.println("Record No=" + sRecNo);
  result.moveRecord(nRecNo);
  List ltReports = web.getMemberPriceList();//ReportType.getReports();
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/propertysearch.js" type="text/javascript"></SCRIPT>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
 <TR>
  <TD colspan="2"><%=web.getNavigationWeb(request, "Report Options")%></TD>
 </TR>
 <TR>
  <TD height=5></TD>
 </TR>
 <TR>
  <TD align="center"><font class='pagetitle'>Report Options</font></TD>
 </TR>
 <TR>
  <TD height=10></TD>
 </TR>
 <TR>
  <TD>
   <table align="center" border="0" cellpadding="1" cellspacing="0" width="572" class="highinfo">
    <tr>
     <td align="right" width="30%">Address:&nbsp;&nbsp;<td>
     <td><b><%=result.getFieldData("C_ADDRESS")%></b><td>
    </tr>
    <tr>
     <td align="right" width="30%">Onwer:&nbsp;&nbsp;<td>
     <td><b><%=result.getFieldData("C_OWNERS")%></b><td>
    </tr>
    <tr>
     <td align="right" width="30%">APN:&nbsp;&nbsp;<td>
     <td><b><%=result.getFieldData("APN")%></b><td>
    </tr>
   </table>
  </TD>
 </TR>
 <TR>
  <TD height=5></TD>
 </TR>
 <TR>
  <TD>
<%@ include file="../../waitprocess.jsp"%>
<SPAN id="Summary_Form">
<FORM name="reportoptions" action="index.jsp" method="post" onSubmit="return validateReports(this, <%=ltReports.size()%>);">
<INPUT type="hidden" name="recno" value="<%=nRecNo%>">
<INPUT type="hidden" name="action1" value="selectreportoptions">
<TABLE cellSpacing=0 cellPadding=0 border=0 align="center">
   <TR>
    <TD height=10 valign="bottom">&nbsp;&nbsp;&nbsp;To generate reports, please select one or more report options below.</TD>
   </TR>
   <TR>
    <TD height=10></TD>
   </TR>

  <TR>
    <TD>
      <script>createTableOpen();</script>
      <table width="560" border="0" cellspacing="1" cellpadding="1" bgcolor="#fffff">
        <tr bgColor="#4959A7">
          <td width="6%"><input type="checkbox" name="allbox" value="1" onClick='selectAll(document.reportoptions, this);'></td>
          <td width="29%" align="center"><FONT color="#ffffff"><b>Report Name</b></FONT></td>
          <td width="15%" align="center" ><FONT color="#ffffff"><b>Unit Price</b></FONT></td>
          <td width="6%"></td>
          <td width="29%" align="center"><FONT color="#ffffff"><b>Report Name</b></FONT></td>
          <td width="15%" align="center" ><FONT color="#ffffff"><b>Unit Price</b></FONT></td>
        </tr>
<%
   String sEachPrice = "";
   for (int i=0; i<ltReports.size(); i+=2) {
      ProductInfo pdInfo = (ProductInfo)ltReports.get(i);
      if (sEachPrice.length()>0)
         sEachPrice += ",";
      sEachPrice += web.getMemberPrice(pdInfo);
%>
        <tr>
          <td width="6%"><input type="checkbox" name="check_<%=i%>" value="<%=pdInfo.Code%>" onClick="onCheckReport(document.reportoptions);"></td>
          <td width="29%"><%=pdInfo.Name%></td>
          <td width="15%" align="right"><b><%=Utilities.getNumberFormat(web.getMemberPrice(pdInfo), '$', 2)%></b>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<% if ((i+1)<ltReports.size()) {
      pdInfo = (ProductInfo)ltReports.get(i+1);
      if (sEachPrice.length()>0)
         sEachPrice += ",";
      sEachPrice += web.getMemberPrice(pdInfo);
%>
          <td width="6%"><input type="checkbox" name="check_<%=(i+1)%>" value="<%=pdInfo.Code%>" onClick="onCheckReport(document.reportoptions);"></td>
          <td width="29%"><%=pdInfo.Name%></td>
          <td width="15%" align="right"><b><%=Utilities.getNumberFormat(web.getMemberPrice(pdInfo), '$', 2)%></b>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<% } else { %>
          <td width="6%"></td>
          <td width="29%"></td>
          <td width="15%" align="right"></td>
<% } %>
        </tr>
<% } %>
        <tr>
          <td colspan="6"><hr></td>
        </tr>
        <tr>
          <td width="6%"><input type="hidden" name="eachprice" value="<%=sEachPrice%>"></td>
          <td width="27%"></td>
          <td width="17%" align="right"></td>
          <td colspan="2" align="right"><font size="2">Total Charge:</font></td>
          <td align="right"><font size="2" color="#FF6633"><b><span id="totalcharge"></span></b></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td colspan="6" height=10></td>
        </tr>
        <tr>
          <td colspan="6">*Note: Total charge may be less if not all selected reports available for this property.</td>
        </tr>
      </table>
      <script>createTableClose();</script>
    </TD>
   </TR>
   <TR>
    <TD height=5></TD>
   </TR>
   <TR>
    <TD align="center"><input type="submit" value="Next Step" name="nextstep" onClick="setAction(document.reportoptions, 'pi-selectreportoptions');"></TD>
   </TR>
 </TABLE>
 </FORM>

 </SPAN>
 </TD>
 </TR>
</table>
<SCRIPT>initReportOption(document.reportoptions, <%=ltReports.size()%>);</SCRIPT>
<% } %>