<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.InvoiceBean"%>
<%@ page import="com.zyzit.weboffice.model.InvoiceInfo"%>
<%
  InvoiceBean bean = new InvoiceBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_DOMAINBILL|AccessRole.ROLE_INFOMATION))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request);

  String sHelpTag = "Payment Invoice List";
  String sTitleLinks = "<b>User List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all the invoices of your company, which paid to <%=bean.getConfigValue("company", "KZ Company")%> for online service
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'invoicelist.jsp?<%=bean.getDomainCGI(request)%>');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("InvoiceNo", "invoicelist.jsp?"+bean.getDomainCGI(request), "Invoice")%></th>
    <th width="41%" align="center" class="thCornerL"><%=bean.getSortNameLink("Description", "invoicelist.jsp?"+bean.getDomainCGI(request))%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreditType", "invoicelist.jsp?"+bean.getDomainCGI(request), "Pay Method")%></th>
    <th width="9%" align="center" class="thCornerL"><%=bean.getSortNameLink("Amount", "invoicelist.jsp?"+bean.getDomainCGI(request))%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "invoicelist.jsp?"+bean.getDomainCGI(request), "Date")%></th>
    <th width="6%" align="center" class="thCornerL">Action</th>
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
    <td width="41%"><%=Utilities.getValue(info.Description)%></td>
    <td width="14%"><%=info.CreditType%></td>
    <td width="9%" align="right"><%=Utilities.getNumberFormat(info.Amount, '$', 2)%></td>
    <td width="14%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="6%" align="center"><%=bean.getActionLink(request, info.InvoiceID)%></td>
  </tr>
<%}%>
  <tr>
    <td colspan="7" class="catBottom">
      <table width="100%" border="0">
        <tr>
<% if (ltArray==null||ltArray.size()==0){ %>
         <td width="35%">There is no any record available.</td>
<% }else{ %>
         <td width="35%"></td>
<% } %>
          <td width="63%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>