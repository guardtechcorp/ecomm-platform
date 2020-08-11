<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MenuPageBean"%>
<%@ page import="com.zyzit.weboffice.model.MenuPageInfo"%>
<%
  MenuPageBean bean = new MenuPageBean(session, 1000);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    MenuPageBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getAll(request, "menupagelist.jsp?");

  String sHelpTag = "menupagelist";
  String sTitleLinks = "<b>Meun Page List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page gives you a brief view of all of the vertical panel items. You can create a new panel or enter to an existing vertical panel to edit its information.
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'menupagelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL">No.</th>
    <th width="25%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "menupagelist.jsp", "Type")%></th>
    <th width="30%" align="center" class="thCornerL"><%=bean.getSortNameLink("Title", "menupagelist.jsp", "Title")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("Active", "menupagelist.jsp", "Active")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "menupagelist.jsp", "Create Date")%></th>
    <th width="15%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="4" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=6>There is no any records available.</td></tr>
<% } else {
int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
for (int i=0; i<ltArray.size(); i++) {
  MenuPageInfo info = (MenuPageInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" width="5%" align="center"><%=(nStartNo+i)%></td>
      <td class="row1" width="25%" align="center"><%=info.Name%></td>
      <td class="row1" width="30%" align="center"><%=info.Title%></td>
      <td class="row1" width="10%" align="center"><%=bean.getCheckedValue(info.Active)%></td>
      <td class="row1" width="15%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
      <td class="row1" width="15%" align="center"><%=bean.getActions(info)%></td>
    </tr>
<%}}%>
    <tr>
    <td colspan="6" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="menupage.jsp?action=Add">Add a new Menu</a></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
    </tr>
</table>
<%@ include file="../share/footer.jsp"%>