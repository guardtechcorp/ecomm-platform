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
<div class="detailCategory">
<% if (nCategoryId>0) { %>
        <%=product.getLabelText(cfInfo, "category-lab")%> <%=category.getProductLink(nCategoryId, sCategoryName)%> >
<% } %>
       <strong><%=pdInfo.Name.replaceAll("\\<br\\>", " ")%></strong>
     </div>
  <div class="productDetailWrap">
    <div class="productImageInfo">
<div class="productImageWrap">
  <!-- <div class="mainImg"><%=product.getPhotoImage(cfInfo, pdInfo, 2)%></div> -->

          <ul id="lightslider" class="productSlider">
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
          </ul>


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

<!--  <div class="smallThumbs"><%=sbFile.toString()%></div> -->

<% } %>

</div>
<div class="productInfoWrap">

                <h2 class="productName">
                  <!-- product.getLabelText(cfInfo, "productname-lab") -->
                  <%=Utilities.getValue(pdInfo.Name)%>
                </h2>

<% if (Utilities.getValueLength(pdInfo.Code)>0) { %>
                <div class="productSKU"> <!-- <%=product.getLabelText(cfInfo, "productno-lab")%> -->
                  <%=Utilities.getValue(pdInfo.Code)%>
                  <span>(<%=pdInfo.ProductID%>)</span>
                </div>
<% } %>
                 <!--
                 <BR><%=product.getLabelText(cfInfo, "visitor-lab")%> <b><%=pdInfo.VisitTime%></b>
                 <BR><%=product.getLabelText(cfInfo, "adddate-lab")%> <b><%=Utilities.getDateValue(pdInfo.CreateDate, 16)%></b>
                 -->
                 <p class="tilePrice">
                   <!-- Remove Start $149.99 Remove End -->
                 <%=product.getPrices(cfInfo, pdInfo, 2)%> <%=product.getRetailPrice(pdInfo, 2)%>
                </p>
                 <% if (Utilities.getValueLength(pdInfo.Author)>0) { %>
                    <!-- <p class="author"><%=product.getLabelText(cfInfo, "author-lab")%> <span><%=pdInfo.Author%></span></p> -->
                 <% } %>

                 <div class="productDesWrap">
                  <h6><%=product.getLabelText(cfInfo, "product-des")%></h6>
                 <p><%=product.getIntroduction(pdInfo, -1)%></p>
                 </div>

                 <%  if (Utilities.getValueLength(pdInfo.Options)>0) {
                     CustomerWeb web = new CustomerWeb(session, request, 0);
                     if (web.getInfo(request)!=null) { %>


                       <div class="productOptions"><%=product.getOptions(pdInfo, -1)%></div>

                 <% } %>
                 <% } %>
                 <% if (false && pdInfo.ExternalUrl!=null && pdInfo.ExternalUrl.trim().length()>0) {%>

                           <a class="esternalURL" href="<%=pdInfo.ExternalUrl%>" target="_blank"><%=product.getLabelText(cfInfo, "seedetail-link")%></a>
                 <% } %>


                 <div class="buyBtnWrap">
                <!-- Remove Start <a onfocus="this.blur()" href="#"><img src="/staticfile/web/images/iso-8859-1/mycart.gif" width="90" height="20" align="top" border="0"></a> Remove End -->
                   <%=product.getBuyButton(cfInfo, pdInfo)%>
                 </div>

        </div>
</div>


<% if (Utilities.getValueLength(pdInfo.LargeImage)>0) { %>
      <!-- <a href='<%=product.encodedUrl("index.jsp?action=productphoto&productid="+pdInfo.ProductID)%>'><%=product.getLabelText(cfInfo, "detailedpic-link")%></a> -->
<% } %>
<a class="emailFriend" href="#" onclick="return showSendEmail(document.sendemail, 'id_emailarea')"> <%=product.getLabelText(cfInfo, "cu-emailto")%></a>

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
