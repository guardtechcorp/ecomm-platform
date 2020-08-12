<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ProductWeb"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  ProductWeb product = new ProductWeb(session, request, 10);
  ConfigInfo cfInfo = product.getConfigInfo();
  List ltProduct = product.getAll(request);

  String sCateName = product.getCategoryName(request);
%>
<div class="productList">
    <div class="pageCategory"><%=product.getLabelText(cfInfo, "category-lab")%><%=sCateName%></div>

    <div class="topPagination"><%=product.getListLinks(cfInfo)%></div>
<% if (ltProduct.size()==0) { %>
  <div class="catDes"><%=product.getLabelText(cfInfo, "categorylist-des")%></div>
<% } else { %>

<div class="productGrid">
<%
//String sDomain = "&domainname=" + product.getDomainName();
int nCol = 0;
for (int i=0; i<ltProduct.size(); i+=1) {
   ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
   if (nCol>=2)
      nCol = 0;
   nCol++;
%>
<div class="productWrap">
    <div class="productThumb"><%=product.getPhotoImage(cfInfo, pdInfo, 2)%></div>
    <div class="productTileInfo"><a href="<%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>"><%=pdInfo.Name%></a>
     <% if (Utilities.getValueLength(pdInfo.Code)>0) { %> <br>(<%=Utilities.getValue(pdInfo.Code)%>) <% } %>
<% if (product.getLayoutID()==4) { %>
      <p><DEL><%=product.getLabelText(cfInfo, "originalprice-lab")%> <%=Utilities.getNumberFormat(product.getActualPrice(pdInfo, 1),'$',2)%></DEL>
      <BR><FONT color="#ff3333"><%=product.getLabelText(cfInfo, "saleprice-lab")%> <%=Utilities.getNumberFormat(product.getActualPrice(pdInfo, 2),'$',2)%> <%=product.getRetailPrice(pdInfo, 1)%></FONT>
<% } else { %>
    <% if (product.getRealPrice(pdInfo)>0) { %>
      <p><%=product.getLabelText(cfInfo, "productprice2-lab")%> <%=Utilities.getNumberFormat(product.getRealPrice(pdInfo),'$',2)%>
    <% } %>
 <% if (product.getLayoutID()==1) { %>
      <BR><!--<%=product.getLabelText(cfInfo, "adddate-lab")%> <b><%=Utilities.getDateValue(pdInfo.CreateDate, 10)%></b>-->
 <% } else if (product.getLayoutID()==2) { %>
      <BR><%=product.getLabelText(cfInfo, "watchvisitor-lab")%> <b><%=pdInfo.VisitTime%></b>
 <% } else { %>
      <BR><%=product.getLabelText(cfInfo, "totalsold-lab")%> <b><%=pdInfo.SoldCount%></b>
 <% } %>
<% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
   <br><%=product.getLabelText(cfInfo, "author-lab")%> <b><%=pdInfo.Author%></b>
<% } %>
<% } %>
     <br>
       <%=product.getBuyButton(cfInfo, pdInfo)%>
   </div>
</div>
<% } %>
</div>
    <div class="bottomPagination"><%=product.getListLinks(cfInfo)%></div>
<% } %>
</div>
<% } %>
