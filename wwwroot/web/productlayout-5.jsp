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
//  } catch (Exception e) {}
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
   <tr>
    <td colspan=2 height="108">
      <TABLE class="table-111" cellSpacing=0 cellPadding=0 width="100%" align="right">
      <tr>
        <td colspan=4 align="center">&nbsp; </td>
      </tr>
<%
int nStartNo = Utilities.getInt(product.getCacheData(product.KEY_STARTROWNO), 1);
for (int i=0; i<ltProduct.size(); i+=1) {
   ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
%>
      <tr>
        <td width="3%" valign="top"><font size="2"> <%=(nStartNo+i)%>.</font> &nbsp; </td>
        <td width="10%" valign="top" nowrap></font> <%=product.getPhotoImage(cfInfo, pdInfo, 1)%></td>
        <td width="5"></td>
        <td valign='top'>
        <font size="2"><b><a href="<%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>"><%=pdInfo.Name%>  (<%=Utilities.getValue(pdInfo.Code)%>)</a></b></font><br>
        <%=product.getIntroduction(pdInfo, 160)%><br>
<% if (product.getRealPrice(pdInfo)>0) { %>
        <%=product.getPrices(cfInfo, pdInfo, 1)%><%=product.getRetailPrice(pdInfo, 1)%>
<% } %>
            
    <% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
       <br>By: <b><%=pdInfo.Author%></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <% } %>
        <%=product.getLabelText(cfInfo, "adddate-lab")%> <b><%=Utilities.getDateValue(pdInfo.CreateDate, 10)%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=product.getBuyButton(cfInfo, pdInfo)%>
        </td>
      </tr>
      <tr><td colspan="4" height=10><hr class="line"></td></tr>
<% } %>
    </TABLE>
   </td>
</tr>
<% } %>
  <tr><td colspan=2 height=2><HR align="left" width="100%" color="#4279bd" noShade SIZE=1></td></tr>
  <tr>
    <td width="2%"></td>
    <td width="95%" align="right"><%=product.getListLinks(cfInfo)%>&nbsp;</td>
  </tr>
  <tr><td colspan=2 height=5></td></tr>
</table>
</td></tr></table>
<% } %>