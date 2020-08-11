<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/selection.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.SelectionBean"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%
  SelectionBean bean = new SelectionBean(session, 15);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CUSTOMER))
     return;

//bean.dumpAllParameters(request);
  String sAction = request.getParameter("action");
  int nTotalRecords = 0;
  if ("customers".equalsIgnoreCase(sAction))
  {
    nTotalRecords = bean.getAll(request);
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }
  else if ("Clear All Selection".equalsIgnoreCase(sAction))
  {
    bean.clearAllSelection(request);
  }
  else if ("Finish Selection".equalsIgnoreCase(sAction))
  {
    nTotalRecords = bean.finishSelect(request);
  }

//bean.dumpAllParameters(request);
  List ltArray = bean.getPageList(request, "javascript:submitSwitchPage2(document.selectlist, rpp, page)");

  String sHelpTag = "customer";
  String sTitleLinks = "<a class=button href=\"customerlist.jsp\">Customer List</a>";
%>
<% if ("Finish Selection".equalsIgnoreCase(sAction)) { %>
<SCRIPT>
//. Update openner's selection records
self.opener.displaySelection(<%=nTotalRecords%>);
//. Close window
window.close();
</SCRIPT>
<% } else { %>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page give you a brief view of all customers information. You can select one or more items or switch to other pages to continue selecting. After finishing selection, press 'Finish Selection' button.
<FORM name="selectlist" action="selectlist.jsp" method="post">
<input type="hidden" name="rpp" value="">
<input type="hidden" name="page" value="-1">
<input type="hidden" name="sort" value="">
<input type="hidden" name="asc" value="">
<input type="hidden" name="checkboxes" value="">
<input type="hidden" name="action" value="Switch Page">
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right" valign="top">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'selectlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="1" cellspacing="0" border="0" class="forumline" align="center">
  <tr>
    <th width="9%" align="center" class="thCornerL"><input type="checkbox" name="allbox" value="1" onClick='checkAll(document.selectlist, this);'></th>
    <th width="30%" align="center" class="thCornerL"><%=bean.getSortNameLink("EMail", "selectlist.jsp", "E-Mail")%></th>
    <th width="27%" align="center" class="thCornerL"><%=bean.getSortNameLink("Yourname", "selectlist.jsp", "Customer Name")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("Phone", "selectlist.jsp")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "selectlist.jsp", "Sign Up Date")%></th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=5>There is no any customer available.</td>
  </tr>
<% } else {
int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
for (int i=0; i<ltArray.size(); i++) {
  CustomerInfo ctInfo = (CustomerInfo)ltArray.get(i);
  String sChecked = bean.getCheckFlag("check_" + ctInfo.CustomerID);
%>
    <tr>
      <td class="row1" width="9%" align="left">
       <input type="checkbox" name="check_<%=ctInfo.CustomerID%>" value="1" <%=sChecked%> onClick='clickCheckBox(this, document.selectlist);'>
       <%=(nStartNo+i)%>
      </td>
      <td class="row1" width="30%"><%=ctInfo.EMail%></td>
      <td class="row1" width="27%"><%=ctInfo.Yourname%></td>
      <td class="row1" width="15%"><%=ctInfo.Phone%></td>
      <td class="row1" width="15%" align="center"><%=Utilities.getDateValue(ctInfo.CreateDate, 16)%></td>
    </tr>
<%}%>
<%}%>
    <tr>
    <td colspan="5" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><span id="totalselection"></span></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
        <tr>
          <td width="30%" align="right"><input type="submit" value="Clear All Selection" name="action1"  onClick="onSubmitAction(document.selectlist, 'Clear All Selection')"></td>
          <td width="70%" align="center"><input type="submit" value="Finish Selection" name="action1" onClick="onSubmitAction(document.selectlist, 'Finish Selection')"></td>
        </tr>
      </table>
    </td>
    </tr>
</table>
</form>
<SCRIPT>onFormLoad(document.selectlist, <%=bean.getTotalSelection()%>);</SCRIPT>
<% } %>
<%@ include file="../share/footer.jsp"%>