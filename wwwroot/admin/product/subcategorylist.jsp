<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CategoryBean"%>
<%@ page import="com.zyzit.weboffice.model.CategoryInfo"%>
<%
  //. Get Main Category Info
  CategoryBean mainbean = new CategoryBean(session, 20);
  if (!mainbean.canAccessPage(request, response, AccessRole.ROLE_PRODUCT))
     return;
  Map hmCache = mainbean.getCacheMap();
  CategoryInfo mainInfo = (CategoryInfo)hmCache.get(CategoryBean.KEY_LASTINFO);
  CategoryBean bean = new CategoryBean(session, true);


//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  boolean bSuccessful = true;
  String sDisplayMessage = null;
  if ("delete".equalsIgnoreCase(sAction))
  {
    CategoryBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
       Errors errObj = (Errors)ret.getInfoObject();
       bSuccessful = false;
       sDisplayMessage = errObj.getError();
    }
  }
  else if ("moveup".equalsIgnoreCase(sAction)||"movedown".equalsIgnoreCase(sAction))
  {
     boolean bMoveUp = true;
     if ("movedown".equalsIgnoreCase(sAction))
        bMoveUp = false;
     CategoryBean.Result ret = bean.changeOrder(request, bMoveUp);
     if (!ret.isSuccess())
     {
        Errors errObj = (Errors)ret.getInfoObject();
        bSuccessful = false;
        sDisplayMessage = errObj.getError();
     }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltCategory = bean.getAll(request);

  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  String sHelpTag = "subcategorylist";
  String sTitleLinks = "<a href=\"categorylist.jsp?action=Gategory List\">Category List</a> > <a href=\"category.jsp?action=editcategory&categoryid=" + bean.getCacheData(bean.KEY_LASTMAINID)+"&return=" + sReturn +"&display=" + sDisplay + "\">Edit the Categeory</a> > <b>Sub-Category List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can get a quick view of all sub-categories and you can re-order the displaying position of them. And you can also delete any of them or enter to a category page to add or edit one of them.
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'subcategorylist.jsp?return=<%=sReturn%>&display=<%=sDisplay%>');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="8%" align="center" class="thCornerL">No.</th>
    <th width="48%" align="center" class="thCornerL">Sub-Category Name</th>
    <th width="7%" align="center" class="thCornerL">Active</th>
    <th width="6%" align="center" class="thCornerL">Edit</th>
    <th width="8%" align="center" class="thCornerL">Delete</th>
    <th width="10%" align="center" class="thCornerL">Move Up</th>
    <th width="13%" align="center" class="thCornerL">Move Down</th>
  </tr>
<% if (ltCategory==null||ltCategory.size()==0){ %>
  <tr class="normal_row">
    <td colspan=7>There is no any sub-category available.</td>
  </tr>
<%} else {%>
<% if (!bSuccessful) { %>
  <tr>
    <td class="row2" colspan="7" align="center"><span class="failed"><%=sDisplayMessage%></span></td>
  </tr>
  <% } %>
  <%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  int nTotalRows = Utilities.getInt(bean.getCacheData(bean.KEY_TOTALROWS), 0);
  for (int i=0; ltCategory!=null&&i<ltCategory.size(); i++) {
  CategoryInfo cgInfo = (CategoryInfo)ltCategory.get(i);
%>
  <tr class="normal_row" onmouseup="selrow(this, 2)" onmouseover="selrow(this, 0)" onmouseout="selrow(this, 1)">
    <td width="8%"><%=(nStartNo+i)%></td>
    <td width="48%"><b><%=cgInfo.Name%></b></td>
    <td width="7%" align="center"><%=bean.getCheckedValue(cgInfo.Active)%></td>
    <td width="8%" align="center" ><a href="subcategory.jsp?action=editcategory&categoryid=<%=cgInfo.CategoryID%>&return=<%=sReturn%>&display=<%=sDisplay%>">Edit</a></td>
    <td width="8%" align="center" ><a href="subcategorylist.jsp?action=delete&categoryid=<%=cgInfo.CategoryID%>" onClick="return confirm('Are you sure you want to delete this sub-category.');">Delete</a></td>
    <td width="10%" align="center"><%=bean.getMoveUpDown("subcategorylist.jsp?categoryid="+cgInfo.CategoryID, nStartNo+i-1, nTotalRows, true)%></td>
    <td width="13%" align="center"><%=bean.getMoveUpDown("subcategorylist.jsp?categoryid="+cgInfo.CategoryID, nStartNo+i-1, nTotalRows, false)%></td>
  </tr>
<%}%>
<%}%>
  <tr>
    <td colspan="7" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
          <td width="30%" height="2"><a href="subcategory.jsp?action=newcategory&maincategoryid=<%=mainInfo.CategoryID%>&return=<%=sReturn%>&display=<%=sDisplay%>">Add New Sub-Category</a></td>
          <td width="70%" height="2" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>