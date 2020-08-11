<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BookItemBean"%>
<%@ page import="com.zyzit.weboffice.model.BookItemInfo"%>
<%
  BookItemBean bean = new BookItemBean(session, 16);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_QUICKBOOK))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    BookItemBean.Result ret = bean.delete(request);
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
  String sTitleLinks = "<a href=\"booklist.jsp?action=Books\">Books</a> > <b>Book Item List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page you can view all the items in you quick book.
<p>
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td width="20%"><%=bean.getExportLink(bean.getBookID())%></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'bookitemlist.jsp?bookid=<%=bean.getBookID()%>');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="7%" align="center" class="thCornerL">No.</th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "bookitemlist.jsp", "Item Name")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("CateID", "bookitemlist.jsp", "Category")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("Amount", "bookitemlist.jsp")%></th>
    <th width="7%" align="center" class="thCornerL"><%=bean.getSortNameLink("Type", "bookitemlist.jsp")%></th>
    <!--th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Who", "bookitemlist.jsp", "To/From")%></th-->
    <th width="12%" align="center" class="thCornerL"><%=bean.getSortNameLink("OccurDate", "bookitemlist.jsp", "Occur Date")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "bookitemlist.jsp", "Create Date")%></th>
    <th width="6%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="8" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=9>There is no any book item available.</td>
  </tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     BookItemInfo info = (BookItemInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="7%" align="center"><font color="<%=bean.getForeColor(info.CateID)%>"><%=(nStartNo+i)%></font></td>
    <td width="20%"><font color="<%=bean.getForeColor(info.CateID)%>"><a href="bookitem.jsp?action=edit&itemid=<%=info.ItemID%>" title="Edit this item"><%=info.Name%></a></font></td>
    <td width="18%"><font color="<%=bean.getForeColor(info.CateID)%>"><%=bean.getCategoryName(info.CateID)%></font></td>
    <td width="10%" align="right"><font color="<%=bean.getForeColor(info.CateID)%>"><%=Utilities.getNumberFormat(info.Amount, '$', 2)%></font></td>
    <td width="7%" align="center"><font color="<%=bean.getForeColor(info.CateID)%>"><%=bean.getAmountType(info.Type)%></font></td>
    <!--td width="20%" align="left"><font color="<%=bean.getForeColor(info.CateID)%>"><%=Utilities.getValue(info.Who)%></font></td-->
    <td width="12%" align="center"><font color="<%=bean.getForeColor(info.CateID)%>"><%=Utilities.getDateValue(info.OccurDate, 10)%></font></td>
    <td width="20%" align="center"><font color="<%=bean.getForeColor(info.CateID)%>"><%=Utilities.getDateValue(info.CreateDate, 16)%></font></td>
    <td width="6%" align="center"><font color="<%=bean.getForeColor(info.CateID)%>"><a href="bookitemlist.jsp?action=delete&itemid=<%=info.ItemID%>&bookid=<%=info.BookID%>" onClick="return confirm('Are you sure you want to delete this item.');">Delete</a></font></td>
  </tr>
<%}}%>
  <tr>
    <td colspan="8" class="catBottom">
      <table width="100%" border="0">
        <tr>
         <td width="20%"><a href="bookitem.jsp?action=add">Add a new book item</a></td>
         <td align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>