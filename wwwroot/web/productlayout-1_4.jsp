<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ProductWeb"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  ProductWeb product = new ProductWeb(session, request, 10);
  List ltProduct = product.getAll(request);
  ConfigInfo cfInfo = product.getConfigInfo();

  String sCateName = product.getCategoryName(request);
%>
<table cellspacing=0 cellpadding=0 width="100%" height="100%" align="center" bgcolor="<%=product.getBgColor()%>"><tr><td valign="top">
<table cellspacing=0 cellpadding=0 width="99%" align="right">
  <tr>
    <td colspan=2 height=5></td>
  </tr>
  <tr>
    <td colspan=2><%=product.getLabelText(cfInfo, "category-lab")%> <b><%=sCateName%></b></td>
  </tr>
  <tr>
    <td colspan=2 align="right"><%=product.getCacheData(product.KEY_PAGELINKS)%>&nbsp;</td>
  </tr>
  <tr>
    <td colspan=2 height=2></td>
  </tr>
<% if (ltProduct.size()==0) { %>
  <TR>
   <td colspan=2 align="center">
   <HR algin="left" width="100%" color="#4279bd" noShade SIZE=1><br>
   This category temporarily does not have product available.</td>
  </TR>
<% } else { %>
<tr><td colspan=2>
<TABLE class="table-1" cellSpacing=2 width="100%" align="right">
<%
int nCol = 0;
String sDomain = "domainname=" + product.getDomainName();
for (int i=0; i<ltProduct.size(); i+=1) {
   ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
   if (nCol>=2)
      nCol = 0;
   nCol++;
%>
<% if (nCol==1){ %><TR> <% } %>
    <TD vAlign="top" align="center" width=90 height=120><br><%=product.getPhotoImage(cfInfo, pdInfo, 1)%></TD>
    <TD vAlign="top" width=160 height=110><br><A  href="index.jsp?action=productdetail&productid=<%=pdInfo.ProductID%>&<%=sDomain%>"><%=pdInfo.Name%></A>
<% if (product.getLayoutID()==4) { %>
      <BR><DEL>Original Price: <%=Utilities.getNumberFormat(product.getActualPrice(pdInfo, 1),'$',2)%></DEL>
<% if (product.getRealPrice(pdInfo)>0) { %>
      <BR><FONT color="#ff3333">Sale Price: <%=Utilities.getNumberFormat(product.getActualPrice(pdInfo, 2),'$',2)%></FONT>
<% } %>        
    <% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
       <br>By: <br><b><%=pdInfo.Author%></b>
    <% } %>

<% } else { %>
      <BR>Price: <%=Utilities.getNumberFormat(product.getRealPrice(pdInfo),'$',2)%>
 <% if (product.getLayoutID()==1) { %>
      <BR>Date added: <b><%=Utilities.getDateValue(pdInfo.CreateDate, 10)%></b>
 <% } else if (product.getLayoutID()==2) { %>
      <BR>Watching Visitors: <b><%=pdInfo.VisitTime%></b>
 <% } else { %>
      <BR>Total Sold: <b><%=pdInfo.SoldCount%></b>
 <% } %>
<% } %>
      <BR><BR>&nbsp;<%=product.getBuyButton(cfInfo, pdInfo)%>
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
    <td width="98%" align="right"><%=product.getCacheData(product.KEY_PAGELINKS)%>&nbsp;</td>
  </tr>
</table>
</td></tr>
<% } %>
</table>
</td></tr></table
<% } %>