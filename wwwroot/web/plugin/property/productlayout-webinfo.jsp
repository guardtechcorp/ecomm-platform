<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ProductWeb"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  ProductWeb product = new ProductWeb(session, request, 3);
  ConfigInfo cfInfo = product.getConfigInfo();
  List ltProduct = product.getAll(request);
%>
<table cellspacing=2 cellpadding=2 width="100%" height="100%" align="center" bgcolor="<%=product.getBgColor()%>"><tr><td valign="top">
<table cellspacing=0 cellpadding=0 width="99%" align="right">
  <tr><td colspan=2 height=5></td></tr>
  <tr>
    <td colspan=2><%=product.getLabelText(cfInfo, "category-lab")%> <b><%=product.getCategoryName(request)%></b></td>
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
         <td width="50%"><font size=3><b>
<% if (Utilities.getValue(pdInfo.LargeImage).length()>0) { %>
         <a href="<%="/productimages/"+pdInfo.LargeImage%>" target="_blank"><%=pdInfo.Name%></a>
<% } else { %>
         <font color="#4279bd"><%=pdInfo.Name%></font>
<% } %>
          </b></font>
         </td>
         <td align="right"><%=product.getMemberPriceDesc(pdInfo, 1)%>&nbsp;</td>
        </tr>
        <tr>
         <td colspan="2" height="40"><%=product.getIntroduction(pdInfo, 300)%></td>
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