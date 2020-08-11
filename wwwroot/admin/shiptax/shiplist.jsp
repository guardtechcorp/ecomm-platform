<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ShipMethodBean"%>
<%@ page import="com.zyzit.weboffice.model.ShipMethodInfo"%>
<%
  ShipMethodBean bean = new ShipMethodBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CHANGERATE))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("delete".equalsIgnoreCase(sAction))
  {
    ShipMethodBean.Result ret = bean.delete(request);
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

  String sHelpTag = "shipmethodlist";
  String sTitleLinks = "<a href=\"shipoption.jsp?action=Ship Option\">Ship Option</a> > <b>Shipping Method List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all the shipping methods and easily sort them. You can delete any of them.
<p>
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'shiplist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="22%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "shiplist.jsp")%></th>
    <th width="50%" align="center" class="thCornerL"><%=bean.getSortNameLink("Description", "shiplist.jsp")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("Charge", "shiplist.jsp", "Charge")%></th>
    <th width="6%" align="center" class="thCornerL">Edit</th>
    <th width="6%" align="center" class="thCornerL">Delete</th>
  </tr>
  <% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="7" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
  <% } %>
  <%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  int nTotalRows = Utilities.getInt(bean.getCacheData(bean.KEY_TOTALROWS), 0);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     ShipMethodInfo info = (ShipMethodInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="6%"><%=(nStartNo+i)%></td>
    <td width="22%"><%=info.Name%></td>
    <td width="50%"><%=Utilities.getValue(info.Description)%></td>
    <td width="10%" align="right"><%=Utilities.getNumberFormat(info.Charge, '$', 2)%></td>
    <td width="6%" align="center"><a href="ship.jsp?action=edit&shipid=<%=info.ShipID%>">Edit</a></td>
    <td width="6%" align="center" nowrap><a href="shiplist.jsp?action=delete&shipid=<%=info.ShipID%>" onClick="return confirm('Are you sure you want to delete this ship method.');">Delete</a></td>
  </tr>
  <%}%>
  <tr>
    <td colspan="7" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
          <td width="23%" height="2"><a href="ship.jsp?action=add">Add New Ship Method</a></td>
          <td width="77%" height="2" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>

