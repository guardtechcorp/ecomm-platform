<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ExamPassageBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamPassageInfo"%>
<%
  ExamPassageBean bean = new ExamPassageBean(session, 24);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EXAM))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    ExamPassageBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getAll(request, "passagelist.jsp?");

  String sHelpTag = "exampassage";
  String sTitleLinks = "<a href=\"sectionlist.jsp?action=Section List\">Section List</a> > <b>Passage List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view a brief information of all passage under this section (<b><%=(String)bean.getAttribute(ExamPassageBean.KEY_SECTIONNAME)%></b>) and you can sort them too.
You can also create a new passage or go to a passage page to edit its information.
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td><b><%=(String)bean.getAttribute(ExamPassageBean.KEY_SECTIONNAME)%>:</b></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'passagelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="60%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "passagelist.jsp", "Passage Name")%></th>
    <!--th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Cols", "passagelist.jsp", "Column")%></th-->
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "passagelist.jsp", "Created Date")%></th>
    <th width="16%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="5" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=6>There is no any records available.</td></tr>
<% } else {
int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
for (int i=0; i<ltArray.size(); i++) {
  ExamPassageInfo info = (ExamPassageInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" width="6%" align="left"><%=(nStartNo+i)%></td>
      <td class="row1" width="60%"><%=info.Name%></td>
      <!--td class="row1" width="8%" align="center"><%=info.Cols%></td-->
      <td class="row1" width="20%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
      <td class="row1" width="16%" align="center"><a href="passage.jsp?action=Edit&passageid=<%=info.PassageID%>">Edit</a>
       | <a onClick="return confirm('Are you sure you want to delete it?');" href="passagelist.jsp?action=delete&passageid=<%=info.PassageID%>">Delete</a>
      </td>
    </tr>
<%}}%>
    <tr>
    <td colspan="5" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="passage.jsp?action=Add">Add Passage</a></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
    </tr>
</table>
<%@ include file="../share/footer.jsp"%>