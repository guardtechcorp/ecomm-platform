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
     try {
         sCateName = new String(sCateName.getBytes("UTF-8"), "iso-8859-1");
     } catch (Exception e) {}

%>
<table cellspacing=2 cellpadding=2 width="100%" height="100%" align="center" bgcolor="<%=product.getBgColor()%>"><tr><td valign="top">
<table cellspacing=0 cellpadding=0 width="99%" align="right">
  <tr><td colspan=2 height=5></td></tr>
  <tr>
    <td colspan=2><%=product.getLabelText(cfInfo, "category-lab")%> <b><%=sCateName%></b></td>
  </tr>
  <tr>
    <td colspan=2 align="right"><%=product.getListLinks(cfInfo)%>&nbsp;</td>
  </tr>
  <tr><td colspan=2 height=2><HR align="left" width="100%" color="#4279bd" noShade SIZE=1></td></tr>
<% if (ltProduct.size()==0) { %>
  <tr>
   <td colspan=2 align="center">
   <HR align="left" width="100%" color="#4279bd" noShade SIZE=1><br><%=product.getLabelText(cfInfo, "categorylist-des")%></td>
  </tr>
<% } else { %>
<tr><td colspan=2>
<TABLE class="table-111" cellSpacing=0 cellPadding=0 width="100%" align="right">
<tr>
<td width=15%>&nbsp;</td>
<td width=34%><font size=2 face=arial><b><%=product.getLabelText(cfInfo, "itemname-col")%></b></font></td>
<td width=16% align="center"><font size=2 face=arial><b><%=product.getLabelText(cfInfo, "price-col")%></b></font></td>
<td width=2% align="center"><font size=2 face=arial><b><%=product.getLabelText(cfInfo, "qty-col")%></b></font></td>
<td width=3%>&nbsp;</td>
</tr>
<tr>
 <td colspan=5 align="center"><HR algin="left" width="100%" color="#4279bd" noShade SIZE=3></td>
</tr>
<%
for (int i=0; i<ltProduct.size(); i+=1) {
   ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
%>
  <tr>
    <td width=90 height=90><%=product.getPhotoImage(cfInfo, pdInfo, 1)%></td>
    <td><A href="<%=product.encodedUrl("index.jsp?action=productdetail&productid=" + pdInfo.ProductID)%>"><%=pdInfo.Name%></A><br>
      <%=product.getIntroduction(pdInfo, 100)%><br>
    </td>
    <td align="center">
<% if (product.getRealPrice(pdInfo)>0) { %>
      <b><%=Utilities.getNumberFormat(product.getRealPrice(pdInfo),'$',2)%></b><br><%=product.getRetailPrice(pdInfo, 2)%>
<% } %>
    <% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
       <br>By: <br><b><%=pdInfo.Author%></b>
    <% } %>
    </td>
<form method="post" action="<%=product.encodedUrl("index.jsp")%>">
<input type="hidden" name="action" value="addcart">
<input type="hidden" name="productid" value="<%=pdInfo.ProductID%>">
<input type="hidden" name="name" value="<%=pdInfo.Name%>">
    <td><input type="text" name="quantity" size=1 maxlength=6 value="1" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'></td>
    <td>&nbsp;&nbsp;&nbsp;<input type="image" src="/staticfile/web/images/<%=cfInfo.Language%>/mycart-2.gif" width=71 height=20 align="absmiddle" border=0></td>
</form>
  </tr>
<% } %>
</TABLE>
</td></tr>
<% } %>
  <tr><td colspan=2 height=2><HR align="left" width="100%" color="#4279bd" noShade SIZE=1></td></tr>
  <tr>
    <td width="2%"></td>
    <td width="98%" align="right"><%=product.getListLinks(cfInfo)%>&nbsp;</td>
  </tr>
  <tr><td colspan=2 height=5></td></tr>
</table>
</td></tr></table>
<% } %>