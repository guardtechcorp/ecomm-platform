<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="../scripts/product.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ProductBean"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<!-- %@ page language="java" contentType="text/html;charset=utf-8" %-->
<%
  ProductBean bean = new ProductBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_PRODUCT))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  boolean bSuccessful = true;
  String sDisplayMessage = null;

  if ("delete".equalsIgnoreCase(sAction))
  {
    ProductBean.Result ret = bean.delete(request);
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
     ProductBean.Result ret = bean.changeOrder(request, bMoveUp);
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

  List ltArray = bean.getAll(request, "productlist.jsp?");

  String sHelpTag = "productlist";
  String sTitleLinks = "<b>Product List</b>";

  String sDomainName = bean.getDomainName();
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can get a quick view of all products and you can re-order the displaying position of them. And you can also delete any of products or add a new product or go to the product page edit one of them.
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'productlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
<tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
<% if (!"art.webonlinemanage.com".equalsIgnoreCase(sDomainName)) { %>
    <th width="22%" align="center" class="thCornerL">Prouct Name</th>
<% } else { %>
    <th width="22%" align="center" class="thCornerL">Art Name</th>
    <th width="9%" align="center" class="thCornerL">Author Name</th>
<% } %>
    <th width="12%" align="center" class="thCornerL">Code</th>
    <th width="8%" align="center" class="thCornerL">Price</th>
    <th width="8%" align="center" class="thCornerL">Sale Price</th>
<% if (!"art.webonlinemanage.com".equalsIgnoreCase(sDomainName)) { %>
    <th width="9%" align="center" class="thCornerL">Member Price</th>
<% } %>
    <th width="5%" align="center" class="thCornerL">Visit Count</th>
    <th width="5%" align="center" class="thCornerL">Sold Count</th>
    <th width="4%" align="center" class="thCornerL">Edit</th>
    <th width="5%" align="center" class="thCornerL">Delete</th>
    <th width="8%" align="center" class="thCornerL">Move Up</th>
    <th width="8%" align="center" class="thCornerL">Move Down</th>
</tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=12>There is no any product available.</td>
  </tr>
<% } else {%>
<% if (!bSuccessful) { %>
  <tr>
    <td class="row1" colspan="9" align="center"><span class="failed"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  int nTotalRows = Utilities.getInt(bean.getCacheData(bean.KEY_TOTALROWS), 0);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     ProductInfo info = (ProductInfo)ltArray.get(i);
%>
  <tr class="normal_row" onmouseup="selrow(this, 2)" onmouseover="selrow(this, 0)" onmouseout="selrow(this, 1)">
    <td width="6%"><%=(nStartNo+i)%></td>
    <td width="22%"><a href="product.jsp?action=Edit Product&productid=<%=info.ProductID%>"><b><%=info.Name%></b> (<%=info.ProductID%>)</a></td>
<% if ("art.webonlinemanage.com".equalsIgnoreCase(sDomainName)) { %>
   <td width="9%"><a href="product.jsp?action=Edit Product&productid=<%=info.ProductID%>"><b><%=Utilities.getValue(info.Author)%></b></a></td>
<% } %>      
    <td width="12%" align="center"><a href="product.jsp?action=Edit Product&productid=<%=info.ProductID%>"><%=info.Code%></a></td>
    <td width="8%" align="right"><%=Utilities.getNumberFormat(info.Price,'$',2)%></td>
    <td width="8%" align="right"><%=Utilities.getNumberFormat(info.SalePrice,'$',2)%></td>
<% if (!"art.webonlinemanage.com".equalsIgnoreCase(sDomainName)) { %>
    <td width="9%" align="right"><%=Utilities.getNumberFormat(info.MemberPrice,'$',2)%></td>
<% } %>
    <td width="5%" align="right"><%=Utilities.getNumberFormat(info.VisitTime,'n',0)%></td>
    <td width="5%" align="right"><%=Utilities.getNumberFormat(info.SoldCount,'n',0)%></td>

    <td width="4%" align="center"><a href="product.jsp?action=Edit Product&productid=<%=info.ProductID%>">Edit</a></td>
    <td width="5%" align="center"><a href="productlist.jsp?action=delete&productid=<%=info.ProductID%>" onClick="return confirm('Are you sure you want to delete this product?');">Delete</a></td>
    <td width="8%" align="center" nowrap><%=bean.getMoveUpDown("productlist.jsp?productid="+info.ProductID, nStartNo+i-1, nTotalRows, true)%></td>
    <td width="8%" align="center" nowrap><%=bean.getMoveUpDown("productlist.jsp?productid="+info.ProductID, nStartNo+i-1, nTotalRows, false)%></td>
  </tr>
<%}%>
<%}%>
  <tr>
    <td colspan="12" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
          <td width="30%" height="2"><a href="product.jsp?action=add">Add New Product</a></td>
          <td width="70%" height="2" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>