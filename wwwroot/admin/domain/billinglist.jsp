<%@ include file="../share/header.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.DomainBillBean"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%
  DomainBillBean bean = new DomainBillBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_DOMAINBILL))
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
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25" valign="top"><font size="2"><b>Company Billing List</b></font></td>
  <tr>
    <td height="20" valign="top">From this page you can view all the company domain and bill each of them.</td>
  </tr>
</table>
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'billinglist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="8%" align="center" class="thCornerL">No.</th>
    <th width="50%" align="center" class="thCornerL"><%=bean.getSortNameLink("DomainName", "billinglist.jsp", "Domain Name")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("Active", "billinglist.jsp")%></th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "billinglist.jsp", "Create Date")%></th>
    <th width="16%" align="center" class="thCornerL">Actions</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="7" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     DomainInfo info = (DomainInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="8%" align="center"><%=(nStartNo+i)%></td>
    <td width="50%"><a href="http://<%=info.DomainName%>" target="_blank"><%=info.DomainName%></a></td>
    <td width="10%" align="center"><%=bean.getCheckedValue(info.Active)%></td>
    <td width="16%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="16%" align="left"><%=bean.getActions(info)%></td>
  </tr>
<%}%>
  <tr>
    <td colspan="9" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
         <td width="23%"></td>
          <td width="77%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>