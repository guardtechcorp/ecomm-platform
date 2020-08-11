<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberCategoryBean"%>
<%@ page import="com.zyzit.weboffice.model.CategoryInfo"%>
<%
{
    MemberCategoryBean bean = new MemberCategoryBean(session, 16);

    if (sRealAction.startsWith("Update Rows"))
    {
        bean.changeMaxRowsPerPage(request);
    }
    else if (sRealAction.startsWith("Delete"))
    {
        ret = bean.delete(request);
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
    }

    List ltArray = bean.getAll(request, bean.encodedUrl("index.jsp?action=Switch Page_CategoryList"), mbInfo.MemberID);

//bean.showAllParameters(request, out);
//Utilities.dumpObject(info);
//    sPageTitle = "Product List";
%>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
 <TR>
  <TD>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
 <TR>
<% if (ltArray!=null && ltArray.size()>16) { %>
  <TD width="20%">
   &nbsp;<a href='<%=bean.encodedUrl("index.jsp?action=New_Category&pt=Add New Category")%>'>Add New Category</a>
  </TD>
<% } %>
  <TD align="right">Max Rows Per Page:
  <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=bean.encodedUrl("index.jsp?action=Update Rows_CategoryList")%>');">
  <%=bean.getRowsPerPageList(-1)%>
  </select>
  </TD>
 </TR>
</TABLE>
</TD>
</TR>

   <TR>
   <TD>
    <TABLE class="table-1" width="100%" align="right" border=0 cellspacing=1 cellpadding=1>
    <TR vAlign="middle" bgColor="#4959A7">
        <td width="6%" align="center" height="22"><FONT color="#ffffff">No.</FONT></td>
        <td width="30%" align="center"><%=bean.getSortNameLink("Name", bean.encodedUrl("index.jsp?action=Sort_CategoryList"), "Category Name", true)%></td>
        <td width="18%" align="center"><%=bean.getSortNameLink("LayoutID", bean.encodedUrl("index.jsp?action=Sort_CategoryList"), "Layout", true)%></td>
        <td width="10%" align="center"><%=bean.getSortNameLink("BackColor", bean.encodedUrl("index.jsp?action=Sort_CategoryList"), "BG Color", true)%></td>
        <td width="10%" align="center"><%=bean.getSortNameLink("RowsPerPage", bean.encodedUrl("index.jsp?action=Sort_CategoryList"), "Max Row", true)%></td>
        <td width="15%" align="center"><%=bean.getSortNameLink("Active", bean.encodedUrl("index.jsp?action=Sort_CategoryList"), "AccessBy", true)%></td>
        <td width="11%" align="center"><FONT color="#ffffff">Actions</FONT></td>
    </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
      <tr class="normal_row">
        <td colspan=9>There is no any category available.</td>
      </tr>
<% } else {%>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     CategoryInfo info = (CategoryInfo)ltArray.get(i);
%>
 <tr class="normal_row" onmouseup="selrow(this, 2)" onmouseover="selrow(this, 0)" onmouseout="selrow(this, 1)">
    <td width="6%" align="center" height="20"><%=(nStartNo+i)%></td>
    <td width="30%"><b><%=info.Name%></b></td>
    <td width="18%"><%=bean.getLayoutName(info.LayoutID)%></td>
    <td width="10%" algin="center"><font color="<%=info.BackColor%>"><%=info.BackColor%></font></td>
    <td width="10%" align="center"><%=info.RowsPerPage%></td>
    <td width="15%" align="center"><%=bean.getAccessName(info.Active)%></td>
    <td width="11%" align="center">
      <a href='<%=bean.encodedUrl("index.jsp?action=Edit_Category&categoryid="+info.CategoryID + "&pt=Category Information")%>'>Edit</a> |
      <a href='<%=bean.encodedUrl("index.jsp?action=Delete_CategoryList&categoryid="+info.CategoryID)%>' onClick="return confirm('Are you sure you want to delete this category?');">Delete</a>
    </td>
  </tr>
<%}%>
<%}%>
  <tr class="normal_row2">      
    <td colspan=7>
     <table width="100%">
      <tr>
        <td width="20%">&nbsp;<a href='<%=bean.encodedUrl("index.jsp?action=New_Category&pt=Add New Category")%>'>Add New Category</a></td>
        <td width="80%" align="right"><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></td>
      </tr>
     </table>
    </td>
  </tr>
 </table>
 </TD>
</TR>
</TABLE>        
<% } %>