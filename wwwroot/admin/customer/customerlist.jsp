<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CustomerBean"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%
  CustomerBean bean = new CustomerBean(session, 23);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CUSTOMER))
     return;

  String sAction = request.getParameter("action");
  int nTotalRecords = 0;
  if ("Customers".equalsIgnoreCase(sAction))
  {
    nTotalRecords = bean.getAll(request);
  }
  else if ("Search List".equalsIgnoreCase(sAction))
  {
//    nTotalRecords = bean.getSearchList(request);
  }
  else if ("Delete".equalsIgnoreCase(sAction))
  {
   CustomerBean.Result ret = bean.delete(request);
   if (!ret.isSuccess())
   {
     Errors errObj = (Errors)ret.getInfoObject();
//     sDisplayMessage = errObj.getError();
//     sClass = "failed";
   }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getPageList(request);

  String sHelpTag = "customerlist";
/*
  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");
  String sUrl = "customerlist.jsp";
  String sTitleLinks = "";
  if (sReturn!=null)
  {
    sUrl += "?return=" + sReturn;
    sUrl += "&display=" + sDisplay;
    sTitleLinks += "<a href=\"" + Utilities.replaceContent(sReturn, "|", "?action=", false)  +"\">" + sDisplay + "</a> > ";
  }
  sTitleLinks += "<b>Customer List</b>";
*/
  String sTitleLinks = bean.getNavigation(request, "Customer List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page give you a brief view of all customers information. From here you can easily sort them by some fields or go to other pages to do more tasks.
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="20%"><a href="customersearch.jsp?action=Search Customer&return=<%=Utilities.getUrlEncode("customerlist.jsp|Customers")%>&display=Customer List">Search Customers</a></td>
    <td width="20%"><%=bean.getExportLink()%></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'customerlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="7%" align="center" class="thCornerL"><%=bean.getSortNameLink("CustomerID", "customerlist.jsp", "ID")%></th>
    <th width="19%" align="center" class="thCornerL"><%=bean.getSortNameLink("Yourname", "customerlist.jsp", "Customer Name")%></th>
    <th width="13%" align="center" class="thCornerL"><%=bean.getSortNameLink("Phone", "customerlist.jsp")%></th>
    <th width="28%" align="center" class="thCornerL"><%=bean.getSortNameLink("EMail", "customerlist.jsp", "E-Mail")%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "customerlist.jsp", "Sign Up Date")%></th>
    <th width="15%" align="center" class="thCornerL">Actions</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=6>There is no any customer available.</td>
  </tr>
<% } else {
int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
for (int i=0; i<ltArray.size(); i++) {
  CustomerInfo ctInfo = (CustomerInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" width="7%" align="center"><a href='<%="customer.jsp?action=edit&customerid="+ctInfo.CustomerID%>' title='Edit Information'><%=ctInfo.CustomerID%></a></td>
      <td class="row1" width="19%"><a href='<%="customer.jsp?action=edit&customerid="+ctInfo.CustomerID%>' title='Edit Information'><%=ctInfo.Yourname%></a></td>
      <td class="row1" width="13%"><%=ctInfo.Phone%></td>
      <td class="row1" width="28%"><a href="../util/email.jsp?action=person&toemail=<%=ctInfo.EMail%>&name=<%=ctInfo.Yourname%>&group=recipients&return=<%=Utilities.getUrlEncode("../customer/customerlist.jsp|Customers")%>&display=Customer List" title="Email to <%=ctInfo.EMail%>"><%=ctInfo.EMail%></a></td>
      <td class="row1" width="14%" align="center"><%=Utilities.getDateValue(ctInfo.CreateDate, 16)%></td>
      <td class="row1" width="15%" align="center"><%=bean.getActions(ctInfo)%></td>
    </tr>
<%}%>
<%}%>
    <tr>
    <td colspan="6" height="9" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"></td>
          <!--td width="30%"><a href="customer.jsp?action=add&return=../customer/customerlist.jsp&display=Customer List">Add New Customer</a></td-->
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
    </tr>
</table>
<%@ include file="../share/footer.jsp"%>