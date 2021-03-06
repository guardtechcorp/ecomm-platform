<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ShipZoneBean"%>
<%@ page import="com.zyzit.weboffice.model.ShipZoneInfo"%>
<%
  ShipZoneBean bean = new ShipZoneBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CHANGERATE))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("delete".equalsIgnoreCase(sAction))
  {
    ShipZoneBean.Result ret = bean.delete(request);
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

  String sHelpTag = "shipzonelist";
  String sTitleLinks = "<a href=\"shipoption.jsp?action=Ship Option\">Ship Option</a> > <b>Shipping Zone List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all the shipping zone and sort them by one of fields. You can delete any of them.
<p>
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'shipzonelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL">No.</th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "shipzonelist.jsp")%></th>
    <th width="50%" align="center" class="thCornerL"><%=bean.getSortNameLink("CoverZips", "shipzonelist.jsp", "Cover Zips")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Fees", "shipzonelist.jsp", "Charges")%></th>
    <th width="10%" align="center" class="thCornerL">Actions</th>
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
     ShipZoneInfo info = (ShipZoneInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="5%"><%=(nStartNo+i)%></td>
    <td width="15%"><%=info.Name%></td>
    <td width="50%"><%=Utilities.getDateValue(info.CoverZips, -1)%></td>
    <td width="20%"><%=info.Fees%></td>
    <td width="10%" align="center"><a href="shipzone.jsp?action=Edit&zoneid=<%=info.ZoneID%>">Edit</a> |
    <a href="shipzonelist.jsp?action=Delete&zoneid=<%=info.ZoneID%>" onClick="return confirm('Are you sure you want to delete this ship zone.');">Delete</a>
    </td>
  </tr>
  <%}%>
  <tr>
    <td colspan="7" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="23%"><a href="shipzone.jsp?action=Add">Add New Ship Zone</a></td>
          <td width="77%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
