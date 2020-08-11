<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.TaxRateBean"%>
<%@ page import="com.zyzit.weboffice.model.TaxRateInfo"%>
<%
  TaxRateBean bean = new TaxRateBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CHANGERATE))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("delete".equalsIgnoreCase(sAction))
  {
    TaxRateBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
    }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request);

  String sHelpTag = "taxlist";
  String sTitleLinks = "<b>County/State Tax Rate List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all tax rates of the counties or states and easily sort them. You can delete any of them.
<p>
<table width="70%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'taxlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="70%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="8%" align="center" class="thCornerL">No.</th>
    <th width="25%" align="center" class="thCornerL"><%=bean.getSortNameLink("State", "taxlist.jsp")%></th>
    <th width="35%" align="center" class="thCornerL"><%=bean.getSortNameLink("County", "taxlist.jsp")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("Rate", "taxlist.jsp", "Tax Rate")%></th>
    <th width="8%" align="center" class="thCornerL">Edit</th>
    <th width="9%" align="center" class="thCornerL">Delete</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="6" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     TaxRateInfo info = (TaxRateInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="8%" align="center"><%=(nStartNo+i)%></td>
    <td width="25%"><%=info.State%></td>
    <td width="35%"><%=info.County%></td>
    <td width="15%" align="center"><%=Utilities.getNumberFormat(info.Rate, 'n', 2)%>%</td>
    <td width="8%" align="center"><a href="tax.jsp?action=edit&rateid=<%=info.RateID%>">Edit</a></td>
    <td width="9%" align="center" nowrap><a href="taxlist.jsp?action=delete&rateid=<%=info.RateID%>" onClick="return confirm('Are you sure you want to delete the tax rate.');">Delete</a></td>
  </tr>
<%}%>
<% if (ltArray==null||ltArray.size()==0){ %>
   <tr class="normal_row">
     <td colspan=7>There is no any county tax rate available.</td>
   </tr>
<% } %>
  <tr>
    <td colspan="7" class="catBottom" height="19">
      <table width="100%" border="0">
        <tr>
          <td width="30%" height="2"><a href="tax.jsp?action=add">Add New County/State Tax</a></td>
          <td width="70%" height="2" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>