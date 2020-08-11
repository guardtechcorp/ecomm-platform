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
  String sDomainName = product.getDomainName();

    String sCateName = product.getCategoryName(request);
//     try {
//         sCateName = new String(sCateName.getBytes("UTF-8"), "iso-8859-1");
//     } catch (Exception e) {}

%>
<table cellspacing=2 cellpadding=2 width="100%" height="100%" align="center" bgcolor="<%=product.getBgColor()%>"><tr><td align="center" valign="top">
<table cellspacing=0 cellpadding=0 width="94%" align="center">
  <tr><td colspan=2 height=5></td></tr>
  <!--tr>
    <td colspan=2><%=product.getLabelText(cfInfo, "category-lab")%> <b><%=sCateName%></b></td>
  </tr-->
  <tr>
    <td colspan=2 height=1><div class="intro"><%=product.getDescription()%></div></td>
  </tr>
  <tr>
    <td colspan=2 align="right">&nbsp;</td>
  </tr>
  <tr><td colspan=2 height=2></td></tr>
<% if (ltProduct.size()==0) { %>
  <tr>
   <td colspan=2 align="center">
   <HR align="left" width="100%" color="#4279bd" noShade SIZE=1><br><%=product.getLabelText(cfInfo, "categorylist-des")%></td>
  </tr>
<% } else { %>
<tr><td colspan=2>
<table cellspacing=0 cellpadding=0 width="100%" align="center">
  <tr>
    <td>
<%
  for (int i=0; i<ltProduct.size(); i+=1) {
     ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
%>
      <table class="table-shang" cellspacing=0 cellpadding=5 width="100%">
        <tr>
          <td valign="middle" align="center" width="25%" rowspan=2><%=product.getPhotoImage(cfInfo, pdInfo, 3)%></td>
          <td valign="middle"><br><font size=3><a class='nameheader' href="<%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>"><b><%=pdInfo.Name%></b></a></font><br><font color='#95838A' size=2><%=product.getPrices2(cfInfo, pdInfo, 4)%>
  <% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
     <br>By: <b><%=pdInfo.Author%></b>
  <% } %>
                            
<% if (i!=3||!"play.atozmate.com".equalsIgnoreCase(sDomainName)) { %>
+ Shipping </font><font color='#95838A' size=1>(Please refer to shipping chart)</font>
<% } else { %>
<b>each</b> - FREE SHIPPING with any set of mats.
<% } %>
         <br><br><%=product.getSimpleIntroduction(pdInfo, -1)%>
        </tr>
        <tr>
          <td align="right">
<% if (i!=3||!"play.atozmate.com".equalsIgnoreCase(sDomainName)) { %>
           <%=product.getBuyButton(cfInfo, pdInfo)%>
<% } else { %>
           <a href='<%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>'><img src='/staticfile/web/images/<%=cfInfo.Language%>/ordernow.gif' width=90 height=20 align='top' border=0></a>
<% } %>
         &nbsp;&nbsp;&nbsp;&nbsp;
         </td>
        </tr>
      </table>
<% } %>
    </td>
  </tr>
</table>
</td></tr>
<% } %>
<% if (!"play.atozmate.com".equalsIgnoreCase(sDomainName)) { %>
  <tr><td colspan=2 height=2><HR algin="left" width="100%" color="#4279bd" noShade SIZE=1></td></tr>
  <tr>
    <td width="2%"></td>
    <td width="95%" align="right"><%=product.getListLinks(cfInfo)%>&nbsp;</td>
  </tr>
<% } %>
  <tr><td colspan=2 height=5></td></tr>
</table>
</td></tr></table>
<% } %>