<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ProductWeb"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<
%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
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

  String[] arMediumFile = product.getMoreFileList(pdInfo, ProductWeb.MOREFILE_MEDIUM);
  String[] arLargeFile = product.getMoreFileList(pdInfo, ProductWeb.MOREFILE_LARGE);
%>
<div class="detailCategory">
<% if (nCategoryId>0) { %>
        <%=product.getLabelText(cfInfo, "category-lab")%> <%=category.getProductLink(nCategoryId, sCategoryName)%> >
<% } %>
       <strong><%=pdInfo.Name.replaceAll("\\<br\\>", " ")%></strong>
     </div>
  <div class="productDetailWrap">
    <div class="productImageInfo">
    <div class="productImageWrap">
      <ul id="lightslider" class="productSlider">
<%
    for (int i=0; i<arMediumFile.length; i++)
    {
%>
       <li data-thumb="/productimages/<%=arMediumFile[i]%>">
          <a href="/productimages/<%=arMediumFile[i]%>" class="imageLightbox">
              <img src="/productimages/<%=arLargeFile[i]%>" />
          </a>
      </li>
<% } %>
<!--
  <li data-thumb="/staticfile/web/images/product-thumb-holder.jpg">
    <a href="/staticfile/web/images/product-thumb-holder.jpg" class="imageLightbox">
      <img src="/staticfile/web/images/product-thumb-holder.jpg" />
    </a>
  </li>
  <li data-thumb="/staticfile/web/images/product-thumb-holder2.jpg">
    <a href="/staticfile/web/images/product-thumb-holder2.jpg" class="imageLightbox">
      <img src="/staticfile/web/images/product-thumb-holder2.jpg" />
    </a>
   </li>
  <li data-thumb="/staticfile/web/images/product-thumb-holder3.jpg">
    <a href="/staticfile/web/images/product-thumb-holder3.jpg" class="imageLightbox">
      <img src="/staticfile/web/images/product-thumb-holder3.jpg" />
    </a>
  </li>
  <li data-thumb="/staticfile/web/images/product-thumb-holder4.jpg">
    <a href="/staticfile/web/images/product-thumb-holder4.jpg" class="imageLightbox">
      <img src="/staticfile/web/images/product-thumb-holder4.jpg" />
    </a>
  </li>
-->
  </ul>
</div>
<div class="productInfoWrap">

    <h2 class="productName">
     <a href='<%=product.encodedUrl("index.jsp?action=productphoto&productid="+pdInfo.ProductID)%>'><%=Utilities.getValue(pdInfo.Name)%></a>
    </h2>

<% if (Utilities.getValueLength(pdInfo.Code)>0) { %>
    <div class="productSKU"> <!-- <%=product.getLabelText(cfInfo, "productno-lab")%> -->
      <%=Utilities.getValue(pdInfo.Code)%> <!--span>(<%=pdInfo.ProductID%>)</span-->
    </div>
<% } %>

     <BR><%=product.getLabelText(cfInfo, "visitor-lab")%> <b><%=pdInfo.VisitTime%></b>
     <BR><%=product.getLabelText(cfInfo, "adddate-lab")%> <b><%=Utilities.getDateValue(pdInfo.CreateDate, 16)%></b>

     <p class="tilePrice">
     <%=product.getPrices(cfInfo, pdInfo, 2)%> <%=product.getRetailPrice(pdInfo, 2)%>
    </p>
     <% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
       <p class="author"><%=product.getLabelText(cfInfo, "author-lab")%> <span><b><%=pdInfo.Author%></b></span></p>
     <% } %>

     <div class="productDesWrap">
      <h5><%=product.getLabelText(cfInfo, "product-des")%></h5>
     <p><%=product.getIntroduction(pdInfo, -1)%></p>
     </div>

     <%  if (Utilities.getValueLength(pdInfo.Options)>0) {
         CustomerWeb web = new CustomerWeb(session, request, 0);
         if (web.getInfo(request)!=null) { %>
           <div class="productOptions"><%=product.getOptions(pdInfo, -1)%></div>
     <% } %>
     <% } %>

     <div class="buyBtnWrap">
       <%=product.getBuyButton(cfInfo, pdInfo)%>
     </div>
  </div>
</div>

<a class="emailFriend" href="#" onclick="return showSendEmail(document.sendemail, 'id_emailarea')"><font size=4><%=product.getLabelText(cfInfo, "cu-emailto")%></font></a>

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
      </tr>
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

</div>
<% } %>
