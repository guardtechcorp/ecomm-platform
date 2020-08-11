<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/category.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CategoryBean"%>
<%@ page import="com.zyzit.weboffice.model.CategoryInfo"%>
<%@ page import="com.zyzit.weboffice.bean.ProductBean"%>
<%
  CategoryBean bean = new CategoryBean(session, 1, 10);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_PRODUCT))
     return;
//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  boolean bSuccessful = true;
  String sDisplayMessage = null;
//  Map hmCache = bean.getCacheMap();
  List ltCategory = bean.getAll(request);
  ProductBean pdBean = new ProductBean(session);
  int nSaveCategoryID = pdBean.getCategoryID();
%>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline">
  <tr>
    <th width="10%" align="center" class="thCornerL">No.</th>
    <th width="90%" align="center" class="thCornerL">Category Name</th>
  </tr>
<% if (ltCategory==null||ltCategory.size()==0){ %>
  <tr class="normal_row">
    <td colspan="2">There is no any category available.</td>
  </tr>
<%} else {%>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltCategory.size(); i++) {
     CategoryInfo cgInfo = (CategoryInfo)ltCategory.get(i);
     List ltSub = bean.getSubList(cgInfo.CategoryID);
     String sClassName = "normal_row";
     if (cgInfo.CategoryID==nSaveCategoryID && "switch".equalsIgnoreCase(sAction))
        sClassName = "highlight_row";
%>
  <tr class="<%=sClassName%>">
    <td width="10%" align="center"><%=(nStartNo+i)%></td>
    <td width="90%"><a href="productselect.jsp?action=newcategory&categoryid=<%=cgInfo.CategoryID%>" target="productselect" onclick='highlightRow(this);' class="genmed"><%=cgInfo.Name%></a></td>
  </tr>
<% for (int j=0; ltSub!=null&&j<ltSub.size(); j++) {
  CategoryInfo subInfo = (CategoryInfo)ltSub.get(j);
  sClassName = "normal_row";
  if (subInfo.CategoryID==nSaveCategoryID&&"switch".equalsIgnoreCase(sAction))
     sClassName = "highlight_row";
%>
  <tr class="<%=sClassName%>">
    <td width="10%">&nbsp;</td>
    <td width="90%">&nbsp;<img src="/staticfile/admin/images/plus2.gif" width=30 height=17 align=CENTER>&nbsp;
      <a href="productselect.jsp?action=newcategory&categoryid=<%=subInfo.CategoryID%>" target="productselect" class="genmed" onClick='highlightRow(this);'><%=subInfo.Name%></a></td>
  </tr>
<% } %>
<%} }%>
  <tr>
    <td colspan="2" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
          <td width="1%"></td>
          <td width="99%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
