<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ProductWeb"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  int nProductID = Utilities.getInt(request.getParameter("productid"), 0);
  ProductWeb product = new ProductWeb(session, request, 100);
  CategoryWeb category = new CategoryWeb(session, request, 100);

  ConfigInfo cfInfo = product.getConfigInfo();
  ProductInfo pdInfo = product.getProduct(nProductID);
  int nSize = 2;
  String sCategoryName = product.getCategoryName(request);
  int nCategoryId = product.getCategoryId();
%>
<table cellspacing=2 cellpadding=2 width="100%" height="100%" align="center" bgcolor="<%=product.getBgColor()%>"><tr><td valign="top">
  <tr>
    <td height="24" valign="top" style="border-bottom: 1px solid #4279bd">
<% if (nCategoryId>0) { %>
        <%=product.getLabelText(cfInfo, "category-lab")%> <%=category.getProductLink(nCategoryId, sCategoryName)%> >
<% } %>
       <b><%=pdInfo.Name.replaceAll("\\<br\\>", " ")%></b>
    </td>
  </tr>
  <tr>
    <td>
     <TABLE cellSpacing=0 cellPadding=1 width="100%">
       <TR>
         <TD valign="top" align="center" width="204"><%=product.getPhotoImage(cfInfo, pdInfo, 2)%></TD>
         <TD width="4"></TD>
         <TD vAlign="top">
           <table width="100%" cellpadding="0" cellspacing="2">
            <tr>
             <td>
                <font color='#000000' size='<%=nSize%>'><!-- product.getLabelText(cfInfo, "productname-lab") --><b><%=Utilities.getValue(pdInfo.Name)%></b>
                <BR>
<% if (Utilities.getValueLength(pdInfo.Code)>0) { %>
                 <%=product.getLabelText(cfInfo, "productno-lab")%> <b><%=Utilities.getValue(pdInfo.Code)%></b> (<%=pdInfo.ProductID%>)
<% } %>
                 <!--
                 <BR><%=product.getLabelText(cfInfo, "visitor-lab")%> <b><%=pdInfo.VisitTime%></b>
                 <BR><%=product.getLabelText(cfInfo, "adddate-lab")%> <b><%=Utilities.getDateValue(pdInfo.CreateDate, 16)%></b>
                 -->
                 <%=product.getPrices(cfInfo, pdInfo, 2)%> <%=product.getRetailPrice(pdInfo, 2)%></font>
                 <% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
                    <p><font size="2"><%=product.getLabelText(cfInfo, "author-lab")%> <b><%=pdInfo.Author%></b></font>
                 <% } %>
                 <p>&nbsp;<%=product.getBuyButton(cfInfo, pdInfo)%>
             </td>
            </tr>
<%
  String[] arMoreFile = product.getMoreFileList(pdInfo, ProductWeb.MOREFILE_MEDIUM);
  StringBuffer sbFile = new StringBuffer();
  if (arMoreFile!=null && arMoreFile.length>0)
  {
     for (int i=1; i<arMoreFile.length; i++)
     {
        String sPhotoLink =  product.getPhotoImageLink(pdInfo.ProductID, i, product.getImageTag(arMoreFile[i], 80, 1));
        sbFile.append(" " + sPhotoLink);
     }
  }

  if (sbFile.length()>0) {
%>
              <tr><td height="2"></td></tr>
               <tr>
                 <td align="right" valign="bottom"><%=sbFile.toString()%></td>
               </tr>
              <% } %>
           </table>
         </TD>
        </TR>
    </TABLE>
    <TABLE width="100%">
    <tr>
      <td width="204" align="center" height="24">
<% if (Utilities.getValueLength(pdInfo.LargeImage)>0) { %>
      <a href='<%=product.encodedUrl("index.jsp?action=productphoto&productid="+pdInfo.ProductID)%>'><%=product.getLabelText(cfInfo, "detailedpic-link")%></a>
<% } %>
      </td>
      <td align="right" valign="bottom"><a href="#" onclick="return showSendEmail(document.sendemail, 'id_emailarea')"> <%=product.getLabelText(cfInfo, "cu-emailto")%></a></td>
    </tr>
   <tr>
     <td colspan="2">
<%
     String sTtile = product.getLabelText(cfInfo, "cu-subcontent").replaceFirst("\\{0\\}", Utilities.replaceContent(pdInfo.Name, "<br>", " ", false));
     String sLink = "<a href='http://" + product.getDomainName() + "/'>" + pdInfo.Name + "</a>";
     String sComment = product.getLabelText(cfInfo, "cu-commcontent").replaceFirst("\\{0\\}", Utilities.replaceContent(pdInfo.Name, "<br>", " ", false));
                       //.replaceFirst("\\{1\\}", sLink);
%>
     <div id="id_emailarea" style="display: none">
      <form style="margin: 0px; padding: 0px" name="sendemail" action="">
      <input type="hidden" name="domainname" value="<%=product.getDomainName()%>">
      <input type="hidden" name="productid" value="<%=pdInfo.ProductID%>">
      <table width="100%" style="border: 1px solid #cccccc">
      <tr>
       <td colspan="3" align="center" height="30"><font size="3"><%=product.getLabelText(cfInfo, "cu-emailtitle")%></font></td>
      </tr>
      <tr>
       <td colspan="3" align="center"><font size="2"><span id="id_processmessage"></span></font></td>
      </tr>
      <tr>
        <td align="right" width="12%"><%=product.getLabelText(cfInfo, "cu-email")%>: </td>
        <td width="87%"><input type="text" name="emailto" id="id_emailto" value="" style="width:100%" maxlength="60"></td>
        <td></td>
      </tr>
      <tr>
       <td align="right"><%=product.getLabelText(cfInfo, "cu-subject")%>: </td>
       <td align="left"><INPUT type="text" name="emailsubject" value="<%=sTtile%>" maxlength="1023" style="width:100%"></td>
       <td ></td>
      <tr>
       <td align="right" valign="top"><%=product.getLabelText(cfInfo, "cu-comment")%>:</td>
       <td align="left"><textarea rows="6" style="width:100%" wrap="virtual" name="emailcomment"><%=sComment%></textarea></td>
       <td ></td>          
      </tr>
      <tr>
       <td align="center" colspan="3" height="30"><INPUT type="button" name="senditembutton" value="<%=product.getLabelText(cfInfo, "cu-send")%>" style="width:110px" onclick="return submitSendEmail(document.sendemail, '<%=request.getHeader("x-forwarded-host")!=null?"/ctr":""%>', 'id_processmessage')"></td>
      </tr>
      </table>
      </form>
     </div>
     </td>
   </tr>
    </TABLE>
    <TABLE cellSpacing=0 cellPadding=2 width="100%">
      <TR>
        <TD>
         <HR algin="left" width="100%" color="#cccccc" noShade SIZE=2><font size="3"><b><%=product.getLabelText(cfInfo, "product-des")%></b></font>
         <BR><BR><font size="2"><%=product.getIntroduction(pdInfo, -1)%></font></TD>
      </TR>
<%  if (Utilities.getValueLength(pdInfo.Options)>0) {
    CustomerWeb web = new CustomerWeb(session, request, 0);
    if (web.getInfo(request)!=null) { %>
    <TR>
      <TD height="24"><hr></TD>
    </TR>
    <TR>
      <TD><font size="2"><%=product.getOptions(pdInfo, -1)%></font></TD>
    </TR>
<% } %>
<% } %>
<% if (false && pdInfo.ExternalUrl!=null && pdInfo.ExternalUrl.trim().length()>0) {%>
      <TR>
        <TD><br>
          <a href="<%=pdInfo.ExternalUrl%>" target="_blank"><%=product.getLabelText(cfInfo, "seedetail-link")%></a>
        </TD>
      </TR>
<% } %>
    </TABLE>
    </td>
  </tr>
</table>
<% } %>