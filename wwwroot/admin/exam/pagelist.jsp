<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ExamPageBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%
  ExamPageBean bean = new ExamPageBean(session, 24);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EXAM))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    ExamPageBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getAll(request, "pagelist.jsp?");

  String sHelpTag = "exampagelist";
  String sTitleLinks = "<a href=\"sectionlist.jsp?action=Section List\">Section List</a> > <b>Page List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view a brief information of all page under this section and you can sort them too. You can also create a new page or enter to a page to edit its information.
<table width="90%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'pagelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="90%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="15%" align="center" class="thCornerL">No.</th>
    <th width="35%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "pagelist.jsp", "Page Name")%></th>
    <th width="25%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "pagelist.jsp", "Create Date and Time")%></th>
    <th width="25%" align="center" class="thCornerL">Action</th>
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
  ContentInfo info = (ContentInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" width="15%" align="center"><%=(nStartNo+i)%></td>
      <td class="row1" width="35%" align="center"><%=info.Name%></td>
      <td class="row1" width="25%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
      <td class="row1" width="25%" align="center"><a href="page.jsp?action=Edit&contentid=<%=info.ContentID%>">Edit</a>
       | <a onClick="return confirm('Are you sure you want to delete it?');" href="pagelist.jsp?action=delete&contentid=<%=info.ContentID%>">Delete</a>
      </td>
    </tr>
<%}}%>
    <tr>
    <td colspan="5" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="page.jsp?action=Add">Add Page</a></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
    </tr>
</table>
<%@ include file="../share/footer.jsp"%>