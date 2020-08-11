<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/product.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ProductBean"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.bean.CategoryBean"%>
<%@ page import="com.zyzit.weboffice.model.CategoryInfo"%>
<%
  ProductBean bean = new ProductBean(session, 9);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_PRODUCT))
//     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  boolean bSuccessful = true;
  String sDisplayMessage = null;

  CategoryInfo cgInfo = null;
  if ("Apply".equalsIgnoreCase(sAction))
  {
    ProductBean.Result ret = bean.applySelection(request);
    if (!ret.isSuccess())
    {
       Errors errObj = (Errors)ret.getInfoObject();
       bSuccessful = false;
       sDisplayMessage = errObj.getError();
    }

    CategoryBean cgBean = new CategoryBean(session, 15);
    cgInfo = cgBean.get(request);
  }

  List ltArray = bean.getAll(request, "javascript:submitSwitchPage(document.productselect, rpp, page)");
  if ("newcategory".equalsIgnoreCase(sAction))
  {
     cgInfo = bean.getSelection(request);
  }

  String sCategoryName;// = "No category/sub-category is selected";
  if (cgInfo!=null)
     sCategoryName = cgInfo.Name;
  else
     sCategoryName = request.getParameter("categoryname");
  if (sCategoryName==null)
     sCategoryName = "No category/sub-category is selected";
%>
<form name="productselect" action="productavailable.jsp" method="post">
<input type="hidden" name="categoryid" value="<%=Utilities.getInt(request.getParameter("categoryid"), 0)%>">
<input type="hidden" name="rpp" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="categoryname" value="<%=Utilities.getValue(sCategoryName)%>">
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
 <tr>
  <th width="6%" class="thCornerL"><input type="checkbox" name="allbox" value="1" onClick='selectAll(document.productselect, this);'></th>
  <th width="10%" align="center" class="thCornerL">No</th>
  <th width="74%" align="center" class="thCornerL">Proucts is not in this category</th>
 </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=3>There is no any product available.</td>
  </tr>
<%} else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     ProductInfo info = (ProductInfo)ltArray.get(i);
%>
    <tr class="normal_row">
      <td width="6%" ><input type="checkbox" name="check_<%=info.ProductID%>" value="1" <%=bean.getItemChecked(info.ProductID)%> onclick='highlightCheckedRow(this);'></td>
      <td width="10%" align="center"><%=nStartNo+i%></td>
      <td width="74%"><b><%=info.Name%></b></td>
    </tr>
 <%}%>
<%}%>
    <tr>
      <td colspan="3" class="catBottom">
        <table width="100%" border="0">
          <tr>
            <td colspan= 2 align="right" height="25"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%@ include file="../share/footer.jsp"%>