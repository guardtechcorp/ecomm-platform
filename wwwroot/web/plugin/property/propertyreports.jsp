<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.web.RSPropertyWeb"%>
<%@ page import="com.zyzit.weboffice.plugin.model.*"%>
<%@ page import="com.zyzit.weboffice.plugin.PropertyResult"%>
<%@ page import="com.zyzit.weboffice.plugin.ReportType"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{

  RSPropertyWeb web = new RSPropertyWeb(session, 20);
  String sAction = web.getRealAction(request);
//web.dumpAllParameters(request);
  if (sAction.endsWith("view-propertyreports"))
  {
     web.getReports(request, response);
     return;
  }
  else if (sAction.endsWith("archive-propertyreports"))
  {
     web.retreiveReports(request);
  }

//System.out.println("sAction Property Search=" + sAction);
  PropertyResult result = web.getResult();
  int nRecNo = result.getRecordNo();
//System.out.println("Record No=" + nRecNo);
  CustomerInfo ctInfo =  web.getCustomerInfo();
  int nMemberId = -1;
  if (ctInfo!=null)
     nMemberId = ctInfo.CustomerID;

  String sFromName = "";
  String sFromEmail = "";
  if (ctInfo!=null)
  {
     sFromName = ctInfo.Yourname;
     sFromEmail = ctInfo.EMail;
  }
/*
<SCRIPT Language="JavaScript" src="/staticfile/web/modalwindow/dhtmlwindow.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/modalwindow/modal.js"></SCRIPT>
  try {
//   coverpagewin = dhtmlmodal.open('CoverPageBox', 'IFRAME', sUrl, 'Cover Page Information', 'width=630px,height=270px,center=1,resize=1,scrolling=1');
  }catch(ex){}
*/
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/propertysearch.js" type="text/javascript"></SCRIPT>
<SCRIPT language="JavaScript" type="text/javascript">
function loadCoverPage()
{
   var sUrl = "<%=web.encodedUrl("plugin/property/coverpagedlg.jsp?action=cp-load-coverpageinfo&memberid="+nMemberId)%>";
   cpWin = newWindow(sUrl, "CoverPage",700,600,"no","center");
}
</SCRIPT>
<table cellspacing=1 cellpadding=0 width="100%" align="center">
 <TR>
  <TD><%=web.getNavigationWeb(request, "View Reports", true)%></TD>
 </TR>
 <TR>
  <TD height=5></TD>
 </TR>
 <TR>
  <TD align="center"><font class='pagetitle'>View Reports</font></TD>
 </TR>
 <TR>
  <TD height=5></TD>
 </TR>
 <TR>
  <TD>
   <table align="center" border="0" cellpadding="2" cellspacing="1" width="572" class="highinfo">
    <tr>
     <td align="right" width="30%">Report Number:&nbsp;&nbsp;</td>
     <td><b><%=result.getReportNumber(nRecNo)%></b></td>
    </tr>
    <tr>
     <td align="right" width="30%">Process Date:&nbsp;&nbsp;</td>
     <td><b><%=result.getReportDate(nRecNo)%></b></td>
    </tr>
    <tr>
     <td colspan="2"><hr width="98%"></td>
    </tr>
    <tr>
     <td align="right" width="30%">Address:&nbsp;&nbsp;</td>
     <td><b><%=web.getFieldData(nRecNo, "C_ADDRESS")%></b></td>
    </tr>
    <tr>
     <td align="right" width="30%">Onwer:&nbsp;&nbsp;</td>
     <td><b><%=web.getFieldData(nRecNo, "C_OWNERS")%></b></td>
    </tr>
    <tr>
     <td align="right" width="30%">APN:&nbsp;&nbsp;</td>
     <td><b><%=web.getFieldData(nRecNo, "APN")%></b></td>
    </tr>
   </table>
  </TD>
 </TR>
 <TR>
  <TD height=10></TD>
 </TR>
 <TR>
  <TD>
 <script>createTableOpen();</script>
  <table width="560" border="0" cellspacing="1" cellpadding="1" bgcolor="#fffff">
 <form name="viewreport_form" action="<%=web.encodedUrl("plugin/property/propertyreports.jsp")%>" method="post" target="_blank">
 <INPUT type="hidden" name="memberid" value="<%=nMemberId%>">
 <INPUT type="hidden" name="format" value="pdf">
 <INPUT type="hidden" name="action1" value="pi-view-propertyreports">
   <tr bgcolor="#4959A7">
    <td width="5%" height="20"></td>
    <td width="35%" align="center"><FONT color="#ffffff"><b>Report Name</b></font></td>
    <td align="center"><FONT color="#ffffff"><b>Status</b></font></td>
    <td align="center" width="15%"><FONT color="#ffffff"><b>Unit Price</b></font></td>
  </tr>
  <tr>
    <td width="5%"><input type="checkbox" name="coverpage" value="1" checked></td>
    <td colspan="2">Includes a cover page in the first page.</td>
    <td align="center"><!--a href="javascript:loadCoverPage()">Edit</a-->
     <a href="<%=web.encodedUrl("index.jsp?action=pi-load-coverpageinfo&memberid="+nMemberId)%>" title="Edit Cover Page">Edit</a>
    </td>
  </tr>
<%
   float fTotalCharge = 0;
   int nTotalReports = result.getTotalReports(nRecNo);
   String[] arPrice = result.getReportPrices(nRecNo).split(",");
   for (int i=0; i<nTotalReports; i++) {
     String sReportName = result.getSingleReportName(nRecNo, i);
     int nError = result.getSingleReportError(nRecNo, i);
     String sIcon;
     String sDescription;
     String sClass;
     float fUnitPrice = 0;//getUnitPrice(sReportName, ltReports);
     if (nError==0)
     {
        sIcon = "/staticfile/web/images/correct.gif";
        sDescription = "Successful";
        sClass = "success";
        fUnitPrice = Utilities.getFloat(arPrice[i], 0);// web.getUnitPrice(sReportName);
     }
     else
     {
        sIcon = "/staticfile/web/images/incorrect.gif";
//        sDescription = result.getSingleReportDesc(nRecNo, i);
        sDescription = "Report is not available.";
        sClass = "failed";
     }
     fTotalCharge += fUnitPrice;
%>
    <tr>
      <td width="5%"><img src='<%=sIcon%>' align='CENTER'></td>
      <td width="35%"><%=web.getReportTitle(sReportName)%></td>
      <td class="<%=sClass%>"><b><%=sDescription%></b></td>
      <td align="right" width="15%"><%=Utilities.getNumberFormat(fUnitPrice, '$', 2)%>&nbsp;&nbsp;&nbsp;</td>
    </tr>
<% } %>
    <tr>
      <td colspan="4"><hr width="98%"></td>
    </tr>
    <tr>
      <td width="5%"></td>
      <td width="35%"><a href="<%=web.encodedUrl("invoice.jsp?action=Get Inovice&orderno="+result.getReportNumber(nRecNo)+"&customerid="+ctInfo.CustomerID + web.getDomainSidCGI())%>" target="_blank" title="View Invoice">View Invoice</a></td>
      <td align="right"><font size="2">Total Charge:</font></td>
      <td align="center" width="15%"><font size="2" color="red"><b><%=Utilities.getNumberFormat(fTotalCharge, '$', 2)%></b></font>&nbsp;</td>
    </tr>
</form>
<SCRIPT>onViewReportFormLoad(document.viewreport_form)</SCRIPT>
    <tr>
      <td colspan="4"><hr width="98%"></td>
    </tr>
    <tr>
      <td colspan="4">
   <TABLE width="560" border="0" cellspacing="1" cellpadding="1" bgcolor="#fffff">
   <TR>
    <TD colspan=2>Thank you for purchasing the reports. Your selected reportes are generated successfully. Now you can view and print it.
    You can also email it to anyone you like.</TD>
   </TR>
   <TR>
    <TD height="10" colspan=2></TD>
   </TR>
   <TR>
    <TD align="center" width="50%">
     <SCRIPT>createLeftButton();</SCRIPT>
     <!--A class="button" href="<%=web.encodedUrl("plugin/property/propertyreports.jsp?action=pi-view-propertyreports&format=pdf")%>" target="_blank">View Reports</A-->
     <A class="button" href="javascript:submitViewReport(document.viewreport_form)">View Reports</A>
     <SCRIPT>createRightButton();</SCRIPT>
    </TD>
    <TD align="center">
     <SCRIPT>createLeftButton();</SCRIPT>
     <A class="button" onClick="showEmailSection(document.email_form, 'open', 'email_section');" href="javascript:;">Email Reports</A>
     <SCRIPT>createRightButton();</SCRIPT>
    </TD>
   </TR>
   <TR>
    <TD colspan=2 height="5"></TD>
   </TR>
   <TR>
    <TD colspan=2>
<SPAN id="email_section" style="display:none">
<form name="email_form" action="<%=web.encodedUrl("plugin/property/propertyreports.jsp")%>" method="post">
   <INPUT type="hidden" name="memberid" value="<%=nMemberId%>">
   <INPUT type="hidden" name="action1" value="pi-view-propertyreports">
   <INPUT type="hidden" name="format" value="email">
     <TABLE border=0 width="99%" align="center" class="highinfo">
      <tr>
        <td colspan=2 height="25" valign="bottom">&nbsp;&nbsp;<b>To:</b></td>
      </tr>
      <tr>
        <td align="right" width="25%">E-Mail Address*:</td>
        <td><input maxlength=255 size=64 value="" name="toemail"></td>
      </tr>
      <tr>
        <td width="25%"></td>
        <td>(Use a comma to separate multiple email addresses)</td>
      </tr>
      <tr>
        <td colspan=2>&nbsp;&nbsp;<b>From:</b></td>
      </tr>
      <tr>
        <td align="right" width="25%">Your Name:</td>
        <td><input maxlength=50 size=64 value="<%=Utilities.getValue(sFromName)%>" name="yourname"></td>
      </tr>
      <tr>
        <td align="right" width="25%">E-Mail Address*:</td>
        <td><input maxlength=50 size=64 value="<%=Utilities.getValue(sFromEmail)%>" name="fromemail"></td>
      </tr>
      <tr>
        <td align="right" width="25%"></td>
        <td><input type="checkbox" name="sendyourself" value="1">Send a copy to yourself</td>
      </tr>
      <tr>
        <td colspan=2 height="10"></td>
      </tr>
      <tr>
        <td align="right" width="25%">Subject:</td>
        <td><input maxlength=50 size=64 value="" name="subject"></td>
      </tr>
      <tr>
        <td align="right" width="25%" valign="top">Comment:</td>
        <td> <textarea rows="5" cols="42" wrap="virtual" name="comment"></textarea></td>
      </tr>
      <tr>
        <td colspan=2><hr width="96%"></td>
      </tr>
      <tr>
        <td colspan=2>
         <table border="0" width="100%">
          <tr>
           <td align="center" width="50%">
           <SCRIPT>createLeftButton();</SCRIPT>
           <!--A class="button" onClick="sendEmailNow(document.email_form, document.viewreport_form, 'plugin/property/propertyreports.jsp?action=pi-view-propertyreports&format=email');" href="javascript:;">Email Now</A-->
           <A class="button" onClick="sendEmailNow(document.email_form, document.viewreport_form, '<%=web.encodedUrl("plugin/property/propertyreports.jsp")%>');" href="javascript:;">Email Now</A>
           <SCRIPT>createRightButton();</SCRIPT>
           </td>
           <td align="center">
           <SCRIPT>createLeftButton();</SCRIPT>
           <A class="button" onClick="showEmailSection(document.email_form, 'close', 'email_section');" href="javascript:;">Close</A>
           <SCRIPT>createRightButton();</SCRIPT>
           </td>
          </tr>
        </table>
       </td>
      </tr>
     </TABLE>
  </form>
</SPAN>
<SCRIPT>onEmailFormLoad(document.email_form)</SCRIPT>
    </TD>
   </TR>
   </TABLE>
     </td>
    </tr>
  </table>
  <script>createTableClose();</script>
</td></tr></table>
<% } %>