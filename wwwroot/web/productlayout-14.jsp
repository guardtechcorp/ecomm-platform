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
    <div class="productThumb">
      <!-- Remove Start <a href="<%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>">
      <img src="/staticfile/web/images/product-thumb-holder.jpg"></a>Remove End -->
      <%=product.getPhotoImage(cfInfo, pdInfo, 0)%>
    </div>
    <div class="productTileInfo">
      <h3><a href="<%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>">
        <%=pdInfo.Name%>
       <% if (Utilities.getValueLength(pdInfo.Code)>0) { %>
        <font size=2>(<%=Utilities.getValue(pdInfo.Code)%>)</font>
       <% } %>
      </a></h3>

<% if (product.getLayoutID()==4) { %>
      <p class="tilePrice"><del>
        <!-- <%=product.getLabelText(cfInfo, "originalprice-lab")%> -->
      <%=Utilities.getNumberFormat(product.getActualPrice(pdInfo, 0),'$',2)%>
    </del>
      <span style="color: #ff3333;">
        <!-- <%=product.getLabelText(cfInfo, "saleprice-lab")%> -->
        <%=Utilities.getNumberFormat(product.getActualPrice(pdInfo, 2),'$',2)%> <%=product.getRetailPrice(pdInfo, 1)%>
      </span>
    </p>
<% } else { %>
    <% if (product.getRealPrice(pdInfo)>0) { %>
      <p class="tilePrice">
        <!-- <%=product.getLabelText(cfInfo, "productprice2-lab")%> -->
        <%=Utilities.getNumberFormat(product.getRealPrice(pdInfo),'$',2)%>
    <% } %>
 <% if (product.getLayoutID()==1) { %>
      <!--<%=product.getLabelText(cfInfo, "adddate-lab")%> <b><%=Utilities.getDateValue(pdInfo.CreateDate, 10)%></b>-->
 <% } else if (product.getLayoutID()==2) { %>
      <!-- <BR><%=product.getLabelText(cfInfo, "watchvisitor-lab")%> <b><%=pdInfo.VisitTime%></b> -->
 <% } else { %>
      <!-- <%=product.getLabelText(cfInfo, "totalsold-lab")%> <b><%=pdInfo.SoldCount%></b> -->
 <% } %>
 <!-- Remove Start <p class="tilePrice">$149.99</p> Remove End -->
<% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
  <!-- <%=product.getLabelText(cfInfo, "author-lab")%> <b><%=pdInfo.Author%></b> -->
<% } %>
<% } %>
       <div class="buyBtnWrap">
         <!-- Remove Start <a onfocus="this.blur()" href="#"><img src="/staticfile/web/images/iso-8859-1/mycart.gif" width="90" height="20" align="top" border="0"></a> Remove End -->
       <%=product.getBuyButton(cfInfo, pdInfo)%>
      </div>
   </div>
</div>
<% } %>
</div>
    <div class="bottomPagination"><%=product.getListLinks(cfInfo)%></div>
<% } %>
</div>
<% } %>
