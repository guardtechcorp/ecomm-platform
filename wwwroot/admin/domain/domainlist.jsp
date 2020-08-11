<%@ include file="../share/header.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.DomainBean"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>

<%
  DomainBean bean = new DomainBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_DOMAIN))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    DomainBean.Result ret = bean.delete(request, null);
    if (!ret.isSuccess())
    {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
    }
  }
  else if ("Backup".equalsIgnoreCase(sAction))
  {
    DomainBean.Result ret = bean.backup(request);
    sDisplayMessage = (String)ret.getInfoObject();
  }
  else if ("Create Free Websites".equalsIgnoreCase(sAction))
  {
    int nTotal = bean.createFreeWebsites();
    sDisplayMessage = "It is successfully to create " + nTotal + " free websites.";
  }
  else if ("Delete Free Websites".equalsIgnoreCase(sAction))
  {
    int nTotal = bean.deleteFreeWebsites();
    sDisplayMessage = "It is successfully to delete " + nTotal + " free websites.";
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request);
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25" valign="top"><font size="2"><b>Company Domain List</b></font></td>
  <tr>
    <td height="20" valign="top">From this page you can view all the company domain and edit any one of them or add a new company domain.</td>
  </tr>
</table>
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="left">
       <a href='domainlist.jsp?action=Create Free Websites' onClick="return confirm('Are you sure you want to create free websites now?');">Create Free Websits</a>
       | <a href='domainlist.jsp?action=Delete Free Websites' onClick="return confirm('Are you sure you want to delete free websites now?');">Delete Free Websits</a>
   </td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'domainlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="36%" align="center" class="thCornerL"><%=bean.getSortNameLink("DomainName", "domainlist.jsp", "Domain Name")%></th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Setup", "domainlist.jsp")%></th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Active", "domainlist.jsp")%></th>
    <th width="12%" align="center" class="thCornerL"><%=bean.getSortNameLink("TestFlag", "domainlist.jsp", "Test Mode")%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "domainlist.jsp", "Create Date")%></th>
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
    <td width="6%" align="center"><%=(nStartNo+i)%></td>
    <td width="36%"><a href="http://<%=info.DomainName%>" target="_blank"><%=info.DomainName%></a></td>
    <td width="8%" align="center"><%=bean.getCheckedValue(info.Setup)%></td>
    <td width="8%" align="center"><%=bean.getCheckedValue(info.Active)%></td>
    <td width="12%" align="center"><%=bean.getCheckedValue(info.TestFlag)%></td>
    <td width="14%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="16%" align="left"><%=bean.getActions(info)%></td>
  </tr>
<%}%>
  <tr>
    <td colspan="9" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
         <td width="23%"><a href='domainlist.jsp?action=Backup&Target=manager'>Backup Management</a></td>
          <td width="77%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>