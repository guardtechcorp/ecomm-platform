<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.SearchPageBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%@ page import="com.zyzit.weboffice.model.SearchPageInfo" %>
<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<%
  SearchPageBean bean = new SearchPageBean(session, 24);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_SEARCHPAGE))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    SearchPageBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getAll(request, "searchpagelist.jsp?");

  String sHelpTag = "searchpagelist";
  String sTitleLinks = "<b>Search Page List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view a brief information of all search pages and you can sort them too. You can also create a new page or enter to a page to edit its information.
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'searchpagelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL">No.</th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("Keyword", "searchpagelist.jsp", "Keyword")%></th>
    <th width="48%" align="center" class="thCornerL"><%=bean.getSortNameLink("Title", "searchpagelist.jsp", "Title")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "searchpagelist.jsp", "Create Date and Time")%></th>
    <th align="center" class="thCornerL">Actions</th>
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
  SearchPageInfo info = (SearchPageInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" align="center"><%=(nStartNo+i)%></td>
      <td class="row1" align="center"><%=Utilities.getUnicode(info.Keyword)%></td>
      <td class="row1" align="center"><%=Utilities.getValue(Utilities.getUnicode(info.Title))%></td>
      <td class="row1" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
      <td class="row1" align="center"><a href="searchpage.jsp?action=Edit&pageid=<%=info.PageID%>">Edit</a>
       | <a onClick="return confirm('Are you sure you want to delete it?');" href="searchpagelist.jsp?action=delete&pageid=<%=info.PageID%>">Delete</a>
      </td>
    </tr>
<%}}%>
    <tr>
    <td colspan="5" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="searchpage.jsp?action=Add">Add Search Page</a></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
    </tr>
</table>
<%@ include file="../share/footer.jsp"%>