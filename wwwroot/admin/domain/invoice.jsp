<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/domain.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.InvoiceBean"%>
<%@ page import="com.zyzit.weboffice.model.InvoiceInfo"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.model.InvoiceItemInfo"%>
<%
  InvoiceBean bean = new InvoiceBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_INFOMATION))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  if ("Export".equalsIgnoreCase(sAction))
  {
    bean.outputInvoce(request, response);
    return;
  }

  String sDisplayMessage = null;
  String sClass = "successful";
  InvoiceInfo info = null;
  List ltItemArray = null;
  if ("view".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    ltItemArray = bean.getItemList(request);
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
    info =  bean.getPrevOrNext(sAction);
    ltItemArray = bean.getItemList(info.InvoiceID);
  }

//System.out.println("action="+sAction+","+info.InvoiceID);
  CompanyInfo cpInfo = bean.getCompany(request);
  bean.saveInvoiceInfo(info, ltItemArray, cpInfo);
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25"><font size="2"><a href="invoicelist.jsp?action=view&<%=bean.getDomainCGI(request)%>">Payment Invoice List</a> > <b>Invoice</b></font></td>
  <tr>
    <td height="20" valign="top" colspan="2">From this form, you can view the invoice detail and print or export it.</td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="50%">
     <a class="hightlight" href="javascript:window.print();">Print</a> |
     <a class="hightlight" href="invoice.jsp?action=Export&filetype=pdf">Export to PDF File</a> |
     <a class="hightlight" href="invoice.jsp?action=Export&filetype=rtf">Export to Word File</a>
    </td>
    <td align="right"><%=bean.getPrevNextLinks("invoice.jsp?"+bean.getDomainCGI(request)+"&invoiceid="+info.InvoiceID+'&')%></td>
  </tr>
</table>
<table cellpadding=2 border=0 cellspacing=1 align="center" width=95% bgcolor="#666666">
  <tr bgcolor="#ffffff">
    <td class="ten">Invoice Number: <b><%=Utilities.getValue(info.InvoiceNo)%></b></td>
    <td class="ten">Date and Time: <b><%=Utilities.getDateValue(info.CreateDate, 16)%></b></td>
  </tr>
  <tr bgcolor="#4279bd">
    <td class="WB10" align="center" width=50%><b>Company Information</b></td>
    <td class="WB10" align="center" width=50%><b>Billing Information</b></td>
  </tr>
  <tr bgcolor="#ffffff">
    <td class="ten" valign="top"><b><%=cpInfo.CompanyName%><br>
      <%=cpInfo.Address%><br>
      <%=cpInfo.City%>, <%=cpInfo.State%> <%=cpInfo.ZipCode%></b><br><br>
      Email: <b><%=cpInfo.EMail%></b><br>
      Phone: <b><%=cpInfo.Phone%></b>&nbsp;&nbsp;&nbsp;Fax: <b><%=cpInfo.Fax%></b><br>
    </td>
    <td class="ten" valign="top"><br>The Name on the Card: <b><%=Utilities.getValue(cpInfo.NameOnCard)%></b><br>
     Credit Card Type: <b><%=cpInfo.CreditType%></b><br>
     Credit Card No.: <b><%=bean.getCreditNo(cpInfo.CreditNo, false)%></b><br>
     Expiration Date: <b><%=cpInfo.ExpiredMonth%>/<%=cpInfo.ExpiredYear%></b><br>
    </td>
  </tr>
</table>
<br>
<table cellspacing=1 border=0 cellpadding=1 width=95% align="center" bgcolor="#666666">
  <tr bgcolor="#4279bd">
    <td class="WB10" width=13% align="center" bgcolor="#9999cc">No.</td>
    <td class="WB10" width=50% align="center" bgcolor="#9999cc">Description</td>
    <td class="WB10" width=8% align="center" bgcolor="#9999cc">Quantity</td>
    <td class="WB10" width=14% align="center" bgcolor="#9999cc">Unit Price</td>
    <td class="WB10" width=15% align="center" bgcolor="#9999cc">Total Price</td>
  </tr>
<%
//  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltItemArray!=null&&i<ltItemArray.size(); i++) {
     InvoiceItemInfo iiInfo = (InvoiceItemInfo)ltItemArray.get(i);
%>
  <tr bgcolor="#eeeeee">
    <td class="ten" align="center" width="13%"><%=(i+1)%></td>
    <td class="ten" align="left" width="50%"><%=iiInfo.Name%></td>
    <td class="ten" align="center" width="8%"><%=1%></td>
    <td class="ten" align="right" width="14%"><%=Utilities.getNumberFormat(iiInfo.Amount,'$',2)%></td>
    <td class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(iiInfo.Amount*1,'$',2)%></td>
  </tr>
<% } %>
  <tr bgcolor="#ffffff">
   <td class="ten" colspan=3 rowspan=3>
    <table width="100%" border="0">
      <tr>
        <td colspan=2></td>
      </tr>
    </table>
   </td>
   <td bgcolor="#ffffff" class="ten" align="right">Subtotal:</td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(bean.getTotalAmount(ltItemArray),'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor="#ffffff" class="ten" align="right">Tax:</td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><%=Utilities.getNumberFormat(0,'$',2)%></td>
  </tr>
  <tr>
   <td bgcolor="#ffffff" class="ten" align="right">Total:</td>
   <td bgcolor="#ffffff" class="ten" align="right" width="15%"><b><%=Utilities.getNumberFormat(bean.getTotalAmount(ltItemArray),'$',2)%></b></td>
  </tr>
</table>
<p>&nbsp;
<p>&nbsp;
<p>&nbsp;
<p>&nbsp;
<p>&nbsp;
<div align="center"><span class="copyright"><%=bean.getCopyRight()%>&nbsp;&nbsp;<%=bean.getPowerBy()%></span></div>
<%@ include file="../share/footer.jsp"%>