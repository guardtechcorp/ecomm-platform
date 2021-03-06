<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  ProductWeb product = new ProductWeb(session, request, 3);
  ConfigInfo cfInfo = product.getConfigInfo();
  List ltProduct = product.getAll(request);

    String sCateName = product.getCategoryName(request);
//     try {
//         sCateName = new String(sCateName.getBytes("UTF-8"), "iso-8859-1");
//     } catch (Exception e) {}

%>
<table cellspacing=2 cellpadding=2 width="100%" height="100%" align="center" bgcolor="<%=product.getBgColor()%>"><tr><td valign="top">
<table cellspacing=0 cellpadding=0 width="99%" align="right">
  <tr><td colspan=2 height=5></td></tr>
  <tr>
    <td colspan=2><%=product.getLabelText(cfInfo, "category-lab")%> <b><%=sCateName%></b></td>
  </tr>
  <tr>
    <td colspan=2 height=1><%=product.getDescription()%></td>
  </tr>
  <tr>
    <td colspan=2 align="right"><%=product.getListLinks(cfInfo)%>&nbsp;</td>
  </tr>
  <tr><td colspan=2 height=2></td></tr>
<% if (ltProduct.size()==0) { %>
  <tr>
   <td colspan=2 align="center">
   <HR align="left" width="100%" color="#4279bd" noShade SIZE=1><br><%=product.getLabelText(cfInfo, "categorylist-des")%></td>
  </tr>
<% } else { %>
<tr><td colspan=2>
<table cellspacing=0 cellpadding=0 width="100%" align="right">
  <tr>
    <td>
<%
  for (int i=0; i<ltProduct.size(); i+=1) {
     ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
%>
      <table class="table-shang" cellspacing=0 cellpadding=5 width="100%">
        <tr>
          <td valign="middle" align="center" width=110 height=100><%=product.getPhotoImage(cfInfo, pdInfo, 1)%></td>
          <td valign="top"><%=product.getLabelText(cfInfo, "productname-lab")%> <a href="<%=product.encodedUrl("index.jsp?action=productdetail&productid=" + pdInfo.ProductID)%>"> <%=pdInfo.Name%></a><br>
           <%=product.getLabelText(cfInfo, "productno-lab")%> <%=Utilities.getValue(pdInfo.Code)%>            
            <br><%=product.getPrices(cfInfo, pdInfo, 1)%> <%=product.getRetailPrice(pdInfo, 1)%>
          <% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
             <br>By: <b><%=pdInfo.Author%></b>
          <% } %>
           <br><%=product.getLabelText(cfInfo, "product-des")%> <%=product.getIntroduction(pdInfo, 100)%><br>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <%=product.getBuyButton(cfInfo, pdInfo)%>
        </tr>
      </table>
<% } %>
    </td>
  </tr>
</table>
</td></tr>
<% } %>
  <tr><td colspan=2 height=2><HR algin="left" width="100%" color="#4279bd" noShade SIZE=1></td></tr>
  <tr>
    <td width="2%"></td>
    <td width="95%" align="right"><%=product.getListLinks(cfInfo)%>&nbsp;</td>
  </tr>
  <tr><td colspan=2 height=5></td></tr>
</table>
</td></tr></table>
<% } %>