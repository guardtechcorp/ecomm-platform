<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BookCategoryBean"%>
<%@ page import="com.zyzit.weboffice.model.BookCategoryInfo"%>
<%
  BookCategoryBean bean = new BookCategoryBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_QUICKBOOK))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    BookCategoryBean.Result ret = bean.delete(request);
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

  int nTotalRecords = bean.getAll(request);
  List ltArray = bean.getPageList(request);

  String sHelpTag = "bookcategorylist";
  String sTitleLinks = "<a href=\"booklist.jsp?action=Books\">Books</a> > <b>Book Category List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page you can view all the categories in you quick book.
<p>
<table width="80%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'bookcategorylist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="80%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="10%" align="center" class="thCornerL">No.</th>
    <th width="60%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "bookcategorylist.jsp", "Category Name")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "bookcategorylist.jsp", "Add Date")%></th>
    <th width="10%" align="center">Delete</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="4" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=4>There is no any book category available.</td>
  </tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     BookCategoryInfo info = (BookCategoryInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="10%"><%=(nStartNo+i)%></td>
    <td width="60%"><a href="bookcategory.jsp?action=edit&cateid=<%=info.CateID%>" title="Edit this catgory"><%=info.Name%></a></td>
    <td width="20%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="10%" align="center"><a href="bookcategorylist.jsp?action=delete&cateid=<%=info.CateID%>&bookid=<%=info.BookID%>" onClick="return confirm('Are you sure you want to delete this category.');">Delete</a></td>
  </tr>
<%}}%>
  <tr>
    <td colspan="4" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
         <td width="30%"><a href="bookcategory.jsp?action=add">Add a new category</a></td>
         <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>