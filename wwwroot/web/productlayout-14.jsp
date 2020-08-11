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
<table cellspacing=0 cellpadding=2 width="100%" height="100%" align="center" bgcolor="<%=product.getBgColor()%>">
  <tr>
    <td colspan=2 height=5></td>
  </tr>
  <tr>
    <td colspan=2><%=product.getLabelText(cfInfo, "category-lab")%> <b><%=sCateName%></b></td>
  </tr>
  <tr>
    <td colspan=2 align="right"><%=product.getListLinks(cfInfo)%>&nbsp;</td>
  </tr>
<% if (ltProduct.size()==0) { %>
  <TR>
   <td colspan=2>
   <HR algin="left" width="100%" color="#4279bd" noShade SIZE=1><br><%=product.getLabelText(cfInfo, "categorylist-des")%></td>
  </TR>
<% } else { %>
<tr>
  <td colspan=2 height=2></td>
</tr>
<tr><td colspan=2 valign="top">
<TABLE class="table-1" cellSpacing=2 cellPadding=0 width="100%" align="right">
<%
//String sDomain = "&domainname=" + product.getDomainName();
int nCol = 0;
for (int i=0; i<ltProduct.size(); i+=1) {
   ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
   if (nCol>=2)
      nCol = 0;
   nCol++;
%>
<% if (nCol==1){ %><TR> <% } %>
    <TD vAlign="top" align="center" width=84><br><%=product.getPhotoImage(cfInfo, pdInfo, 1)%></TD>
    <TD vAlign="top" width=160 align="left"><br><a href="<%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>"><%=pdInfo.Name%></a>
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
     <br>&nbsp;<%=product.getBuyButton(cfInfo, pdInfo)%>
    </TD>
<% if (nCol==2){ %></TR> <% } %>
<% } %>
<% if (nCol==1){ %>
   <TD vAlign="middle" align="center" width=100 height=120></TD>
   <TD vAlign="top" width=150 height=110></TD>
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
<% } %>