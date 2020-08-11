<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="java.util.List" %>
<%@ page import="com.zyzit.weboffice.model.ProductInfo" %>
<%
{
    List ltProduct = mpWeb.getPageList(request, "index.jsp?action=Switch Page_CatProductList");

//System.out.println("ltProduct=" + ltProduct);
%>
<table cellspacing=0 cellpadding=2 width="98%" align="center" bgcolor="<%=cgInfo.BackColor%>">
<% if (ltProduct.size()>10) { %>
  <tr>
   <td width="20%"></td>
   <td align="right"><%=mpWeb.encodedHrefLink(mpWeb.getCacheData(mpWeb.KEY_PAGELINKS))%>&nbsp;</td>
  </tr>
  <!--tr>
   <td colspan=2 height=2><HR align="left" width="100%" color="#4279bd" noShade SIZE=1></td>
  </tr-->
<% } %>
  <tr>
   <td colspan=2>
    <TABLE class="table-outline" cellSpacing=0 cellPadding=0 width="100%" align="right">
<%
int nStartNo = Utilities.getInt(mpWeb.getCacheData(mpWeb.KEY_STARTROWNO), 1);
for (int i=0; i<ltProduct.size(); i+=1) {
   ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
   String sLink = mpWeb.encodedUrl(mpWeb.getProductLink(pdInfo));
%>
     <tr>
      <td width="2%" valign="top"><font size="2"><b><%=(nStartNo+i)%>.&nbsp;</b></font></td>
      <td valign="top"><font size="3"><a href="<%=sLink%>"><%=pdInfo.Name%>  <%=Utilities.getValue(pdInfo.Code)%></a></font><br>
      <%=Utilities.getDateValue(pdInfo.Description, 160)%><br><%=mpWeb.getPriceAddDate(pdInfo)%>
      </td>
      <td width="100"><a href="<%=sLink%>"><%=mpWeb.getProductPicture(pdInfo, 1, 80, 80)%></a></td>
     </tr>
     <tr>
      <td colspan=2 align="center" height="8"></td>
     </tr>
<% } %>
    </TABLE>
   </td>
  </tr>
  <!--tr>
    <td colspan=2><HR align="left" width="100%" color="#4279bd" noShade SIZE=1></td>
  </tr-->
  <tr>
    <td width="20%"></td>
    <td align="right"><%=mpWeb.encodedHrefLink(mpWeb.getCacheData(mpWeb.KEY_PAGELINKS))%>&nbsp;</td>
  </tr>
</table>
<% } %>