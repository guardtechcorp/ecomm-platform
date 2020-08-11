<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BookBean"%>
<%@ page import="com.zyzit.weboffice.model.BookInfo"%>
<%
  BookBean bean = new BookBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_QUICKBOOK))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    BookBean.Result ret = bean.delete(request);
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

//  int nTotalRecords = bean.getAll(request);
//  List ltArray = bean.getPageList(request);
  List ltArray = bean.getAccessBookList();

  String sHelpTag = "quickbooklist";
  String sTitleLinks = "<b>Quick Book List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page you can see all of quick books which you can access.
<p>
<table width="90%" cellpadding="0" cellspacing="0" border="0" align="center">
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<%
  for (int i=0; i<ltArray.size(); i+=3) {
     BookInfo info = (BookInfo)ltArray.get(i);
%>
<tr><td>
<table cellspacing=0 cellpadding=2 width="100%" border=0 align="center">
  <tr>
    <td valign="top" width="33%">
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign="top" width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/admin/images/book-icon.gif" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks1">
             <li><a href="bookcategorylist.jsp?action=Book Category&bookid=<%=info.BookID%>">Categories</a></li>
             <li><a href="bookitemlist.jsp?action=Book Item&bookid=<%=info.BookID%>">Items List</a></li>
             <li><a href="booksummary.jsp?action=Book Summary&bookid=<%=info.BookID%>">Summary Report</a></li>
             <br>
             <li><a href="book.jsp?action=edit&bookid=<%=info.BookID%>">Edit Book</a></li>
             <!--li><a href="booklist.jsp?action=delete&bookid=<%=info.BookID%>" onClick="return confirm('Are you sure you want to delete this book.');">Delete</a></li-->
           </ul>
          </td>
        </tr>
      </table>
    </td>
    <td valign="top" width="34%">
<% if (i+1<ltArray.size()) {
  info = (BookInfo)ltArray.get(i+1);
%>
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign=top width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/admin/images/book-icon.gif" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks1">
             <li><a href="bookcategorylist.jsp?action=Book Category&bookid=<%=info.BookID%>">Categories</a></li>
             <li><a href="bookitemlist.jsp?action=Book Item&bookid=<%=info.BookID%>">Items List</a></li>
             <li><a href="booksummary.jsp?action=Book Summary&bookid=<%=info.BookID%>">Summary Report</a></li>
             <br>
             <li><a href="book.jsp?action=edit&bookid=<%=info.BookID%>">Edit Book</a></li>
             <!--li><a href="booklist.jsp?action=delete&bookid=<%=info.BookID%>" onClick="return confirm('Are you sure you want to delete this book.');">Delete</a></li-->
           </ul>
          </td>
        </tr>
      </table>
<% } %>
    </td>
    <td valign="top" width="33%">
<% if (i+2<ltArray.size()) {
  info = (BookInfo)ltArray.get(i+2);
%>
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign="top" width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/admin/images/book-icon.gif" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks1">
             <li><a href="bookcategorylist.jsp?action=Book Category&bookid=<%=info.BookID%>">Categories</a></li>
             <li><a href="bookitemlist.jsp?action=Book Item&bookid=<%=info.BookID%>">Items List</a></li>
             <li><a href="booksummary.jsp?action=Book Summary&bookid=<%=info.BookID%>">Summary Report</a></li>
             <br>
             <li><a href="book.jsp?action=edit&bookid=<%=info.BookID%>">Edit Book</a></li>
             <!--li><a href="booklist.jsp?action=delete&bookid=<%=info.BookID%>" onClick="return confirm('Are you sure you want to delete this book.');">Delete</a></li-->
           </ul>
          </td>
        </tr>
      </table>
<% } %>
    </td>
  </tr>
</table>
</td></tr>
<% } %>
<tr>
<td><br><a href="book.jsp?action=Create">Create a new Book</a></td>
</tr>
</table>
<%@ include file="../share/footer.jsp"%>