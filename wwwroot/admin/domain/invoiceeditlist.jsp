<%@ include file="../share/header.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.InvoiceBean"%>
<%@ page import="com.zyzit.weboffice.model.InvoiceInfo"%>
<%
  InvoiceBean bean = new InvoiceBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_DOMAINBILL))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    InvoiceBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getAll(request);
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25" valign="top"><font size="2"> <a href="billinglist.jsp?action=Billing List">Company Billing List</a> > <b>Invoice List</b></font>
    </td>
  </tr>
  <tr>
    <td height="20" valign="top">From this page you can view all the invoices of <b><%=request.getParameter("dn")%></b>.</td>
  </tr>
</table>
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'invoiceeditlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("InvoiceNo", "invoiceeditlist.jsp?"+bean.getDomainCGI(request), "Invoice")%></th>
    <th width="36%" align="center" class="thCornerL"><%=bean.getSortNameLink("Description", "invoiceeditlist.jsp?"+bean.getDomainCGI(request))%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("PayMehtod", "invoiceeditlist.jsp?"+bean.getDomainCGI(request), "Pay Method")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("Amount", "invoiceeditlist.jsp?"+bean.getDomainCGI(request))%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "invoiceeditlist.jsp?"+bean.getDomainCGI(request), "Date")%></th>
    <th width="12%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="7" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     InvoiceInfo info = (InvoiceInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="6%" align="center"><%=(nStartNo+i)%></td>
    <td width="10%"><%=info.InvoiceNo%></td>
    <td width="36%"><%=Utilities.getValue(info.Description)%></td>
    <td width="14%"><%=Utilities.getValue(info.CreditType)%></td>
    <td width="10%" align="right"><%=Utilities.getNumberFormat(info.Amount, '$', 2)%></td>
    <td width="14%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="12%" align="center"><%=bean.getActionLink(request, info.InvoiceID)%></td>
  </tr>
<%}%>
  <tr>
    <td colspan="7" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="23%"><a href="invoiceedit.jsp?action=Generate Invoice&<%=bean.getDomainCGI(request)%>&dn=<%=request.getParameter("dn")%>">Create a New Invoice</a></td>
          <td width="77%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>