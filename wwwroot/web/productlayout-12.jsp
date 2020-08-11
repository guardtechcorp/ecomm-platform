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
//     try {
//         sCateName = new String(sCateName.getBytes("UTF-8"), "iso-8859-1");
//     } catch (Exception e) {}
%>
<table cellspacing=2 cellpadding=2 width="100%" height="100%" align="center" bgcolor="<%=product.getBgColor()%>"><tr><td valign="top">
<table cellspacing=0 cellpadding=0 width="99%" align="right">
  <tr>
    <td colspan=2 height=5></td>
  </tr>
  <tr>
    <td colspan=2><%=product.getLabelText(cfInfo, "category-lab")%> <b><%=sCateName%></b></td>
  </tr>
  <tr>
    <td colspan=2 height=1><%=product.getDescription()%></td>
  </tr>
  <tr>
    <td colspan=2 align="right"><%=product.getListLinks(cfInfo)%>&nbsp;</td>
  </tr>
  <tr>
    <td colspan=2 height=2></td>
  </tr>
<% if (ltProduct.size()==0) { %>
  <TR>
   <td colspan=2 align="center">
   <HR algin="left" width="100%" color="#4279bd" noShade SIZE=1><br><%=product.getLabelText(cfInfo, "categorylist-des")%></td>
  </TR>
<% } else { %>
<tr><td colspan=2>
<TABLE class="table-1" cellSpacing=0 cellPadding=0 width="100%" align="right">
<%
int nCol = 0;
for (int i=0; i<ltProduct.size(); i+=1) {
   ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
   if (nCol>=2)
      nCol = 0;
   nCol++;
%>
<% if (nCol==1){ %><TR> <% } %>
    <TD vAlign="top" align="center" width=90 height=80><br><%=product.getPhotoImage(cfInfo, pdInfo, 1)%></TD>
    <TD vAlign="top" width=160 height=75><br><A  href="<%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>"><%=pdInfo.Name%></A>
      <!--
      <%=product.getPrices(cfInfo, pdInfo, 2)%>
      <%=product.getRetailPrice(pdInfo, 1)%>
      -->
      <%=product.getMemberPriceDesc(pdInfo, 2)%>        
     <!--
      <BR><%=product.getLabelText(cfInfo, "adddate-lab")%> <b><%=Utilities.getDateValue(pdInfo.CreateDate, 10)%></b>
      <BR><%=product.getLabelText(cfInfo, "visitor-lab")%> <b><%=pdInfo.VisitTime%></b>
     -->
    <% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
       <br>By: <b><%=pdInfo.Author%></b>
    <% } %>
     <BR><BR>&nbsp;<%=product.getBuyButton(cfInfo, pdInfo)%>
    </TD>
<% if (nCol==2){ %></TR> <% } %>
<% } %>
<% if (nCol==1){ %>
   <TD vAlign="middle" align="center" width=100 height=80></TD>
   <TD vAlign="top" width=150 height=75></TD>
   </TR>
<% } %>
  <tr>
    <td colspan=4 height=5></td>
  </tr>
</TABLE>
</td></tr>
<tr><td colspan=2>
<table cellspacing=0 cellpadding=0 width="100%" align="center">
  <tr>
    <td colspan=2 height=5></td>
  </tr>
  <tr>
    <td width="2%"></td>
    <td width="98%" align="right"><%=product.getListLinks(cfInfo)%>&nbsp;</td>
  </tr>
</table>
</td></tr>
<% } %>
</table>
</td></tr></table
<% } %>