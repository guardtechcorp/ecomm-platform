<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.web.ProductWeb" %>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo" %>
<%@ page import="com.zyzit.weboffice.model.ProductInfo" %>
<%@ page import="com.zyzit.weboffice.util.Definition" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<%
//    http://localhost:8080/email/unreadmessage.jsp?domainname=www.cybeye.com&actid=64952&email=nzhao@cybeye.com&username=%E5%BF%97%E5%8B%87+Zhao&ecount=20
    String sDomainName = request.getParameter("domainname");
    session.setAttribute(Definition.KEY_DOMAINNAME, sDomainName);
    String sComment = request.getParameter("comment");//Utilities.replaceContent(request.getParameter("comment"), "\n", "<br>");
    int nProductID = Utilities.getInt(request.getParameter("productid"), 0);
    ProductWeb product = new ProductWeb(session, request, 100);
    ConfigInfo cfInfo = product.getConfigInfo();
    ProductInfo pdInfo = product.getProduct(nProductID);
    String sImageFolder = product.getProductImagePath();
    String sBaseImageUrl = "http://" + sDomainName + ProductWeb.PRODUCTIMAGEPATH + "/";
%>
<HTML>
<HEAD>
<TITLE></TITLE>
</HEAD>
<BODY>
<TABLE border=0 cellSpacing=2 cellPadding=2 width="800">
<% if (Utilities.getValueLength(sComment)>0) {%>
<tr>
 <td><%=Utilities.getUnicode(Utilities.convertHtml(sComment, true))%></td>
</tr>
<% } %>
<tr>
 <td height="20"></td>
</tr>
<tr>
  <td><!--filepath:<%=sImageFolder%>-->
   <TABLE cellSpacing=0 cellPadding=1 width="100%">
    <TR>
     <TD valign="top" align="center" width="204">
<% if (Utilities.getValueLength(pdInfo.MediumImage)>0) { %>
      <a href="<%=sBaseImageUrl%><%=pdInfo.LargeImage%>"><img src='cid:<%=pdInfo.MediumImage%>' width="200"></a>
<% } %>
     </TD>
     <TD width="4"></TD>
     <TD vAlign="top">
     <table width="100%" cellpadding="0" cellspacing="2">
      <tr>
       <td>
        <font color='#000000' size='4'><%=product.getLabelText(cfInfo, "productname-lab")%>
            <a href="http://<%=sDomainName%><%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>">
             <b><%=Utilities.getValue(pdInfo.Name)%></b>
            </a>
           </font>
        <BR>
<% if (Utilities.getValueLength(pdInfo.Code)>0) { %>
        <font color='#000000' size='3'><%=product.getLabelText(cfInfo, "productno-lab")%> <b><%=Utilities.getValue(pdInfo.Code)%></b></font>
<% } %>
        <font color='#000000' size='2'><%=product.getPrices(cfInfo, pdInfo, 2)%> <%=product.getRetailPrice(pdInfo, 2)%></font>
<% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
  <p><font size='2'><%=Utilities.getUnicode(product.getLabelText(cfInfo, "author-lab"))%> <b><%=pdInfo.Author%></b></font>
<% } %>
       </td>
      </tr>
<%
String[] arMoreFile = product.getMoreFileList(pdInfo, ProductWeb.MOREFILE_MEDIUM);
String[] arLargeFile = product.getMoreFileList(pdInfo, ProductWeb.MOREFILE_LARGE);
StringBuffer sbFile = new StringBuffer();
if (arMoreFile!=null && arMoreFile.length>0)
{
   for (int i=1; i<arMoreFile.length; i++)
   {
      String sDownloadLink = sBaseImageUrl + arLargeFile[i];
      String sPhotoLink = "<a href='" + sDownloadLink + "'><img src='cid:" + arMoreFile[i] + "' width='80'></a>";
      sbFile.append("&nbsp;" + sPhotoLink);
   }
}
if (sbFile.length()>0) {
%>
      <tr><td height="2"></td></tr>
      <tr><td align="right" valign="bottom"><%=sbFile.toString()%></td></tr>
<% } %>
     </table>
    </TD>
   </TR>
  </TABLE>
  <TABLE cellSpacing=0 cellPadding=2 width="100%">
    <TR>
      <TD>
       <HR algin="left" width="100%" color="#cccccc" noShade SIZE=2>
       <font size="3"><b><%=Utilities.getUnicode(product.getLabelText(cfInfo, "product-des"))%></b></font>
       <BR><BR><font size="2"><%=product.getIntroduction(pdInfo, -1)%></font>
      </TD>
    </TR>
  </TABLE>
 </td>
</tr>
<tr><td><HR algin="left" width="100%" color="#cccccc" noShade SIZE=2></td></tr>
<tr><td align="center"><a href="http://<%=sDomainName%><%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>"><%=Utilities.getUnicode(product.getLabelText(cfInfo, "cu-seemore"))%></a></td></tr>
<tr><td height="40"></td></tr>
<tr>
 <td><a href="http://<%=sDomainName%>"><font size="2"><%=Utilities.getUnicode(product.getLabelText(cfInfo, "cu-team").replaceAll("\\{0\\}", sDomainName))%></font></a></td>
</tr>
<tr><td height="10"></td></tr>
</TABLE>
</BODY>
</HTML>