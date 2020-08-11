<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ProductWeb"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ include file="function.jsp" %>
<%
{ //. http://www.starplugins.com/cloudzoom/api, https://www.liveauctioneers.com
  int nProductID = Utilities.getInt(request.getParameter("productid"), 0);
  ProductWeb product = new ProductWeb(session, request, 100);
  CategoryWeb category = new CategoryWeb(session, request, 100);
  ConfigInfo cfInfo = product.getConfigInfo();
  ProductInfo pdInfo = product.getProduct(nProductID);
  String sCategoryName = product.getCategoryName(request);
  int nCategoryId = product.getCategoryId();
  int nIndex = Utilities.getInt(request.getParameter("index"), 0);
  String[] arImageFile = product.getMoreFileList(pdInfo, ProductWeb.MOREFILE_LARGE);
  String[] arMediumFile = product.getMoreFileList(pdInfo, ProductWeb.MOREFILE_MEDIUM);
  String sFilename = arImageFile[nIndex];
  String sZoomClass = "cloud-zoom";
  if (!"art.webonlinemanage.com".equalsIgnoreCase(product.getDomainName()))
     sZoomClass = "normal";

//getNavigate(arImageFile, arMediumFile)
%>
<style type="text/css">
/*img {border: 1px solid red;}*/
.pic{
    opacity: 1;
    filter: alpha(opacity=100);
}
.pic:hover
{
    opacity: 0.6;
    filter: alpha(opacity=30);
}
.demo-image{padding:15px 2px;}
.btnRotate {padding: 5px 10px;background-color: #09F;border: 0;color: #FFF;cursor: pointer;}
</style>
<script type="text/javascript">
function rotateImage(degree) {
$('.demo-image').animate({  transform: degree }, {
    step: function(now,fx) {
        $(this).css({
            '-webkit-transform':'rotate('+now+'deg)',
            '-moz-transform':'rotate('+now+'deg)',
            'transform':'rotate('+now+'deg)'
        });
    }
});
}

function switchPhoto(iname)
{
  var imageid = document.getElementById("id_ppimage");
  imageid.src = "/productimages/" + iname;

  $("a#id_cloudzoom").attr('href', "/productimages/" + iname);
  $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
//  return false;
}
</script>
<!--script src="http://code.jquery.com/jquery-2.1.1.js"></script-->
<style>
</style>
<table cellspacing=2 cellpadding=2 width="100%" height="100%" align="center" bgcolor="<%=product.getBgColor()%>">
<tr>
  <td valign="top" nowrap colspan="2" style="border-bottom: 1px solid #4279bd"><%=category.getProductLink(nCategoryId, sCategoryName)%>  > <a href="<%=product.encodedUrl("index.jsp?action=productdetail&productid="+pdInfo.ProductID)%>"><%=pdInfo.Name.replaceAll("\\<br\\>", " ")%></a> > <b>View Photo</b></td>
</tr>
<% if (arImageFile.length>1) { %>
<tr>
 <td valign="top" nowrap>
    <input type="button" class="btnRotate" value="90" onClick="rotateImage(this.value);" />
    <input type="button" class="btnRotate" value="-90" onClick="rotateImage(this.value);" />
    <input type="button" class="btnRotate" value="180" onClick="rotateImage(this.value);" />
    <input type="button" class="btnRotate" value="360" onClick="rotateImage(this.value);" />
 </td>
 <td align="right"><span class2='pagination'><%=product.getPhotoImageNavigation(arImageFile, arMediumFile)%></span></td>
</tr>
<% } %>
<tr>
 <td colspan=2 style="border-top: 1px solid #4279bd">
  <table width="100%" cellpadding="2">
   <tr>
    <td align="center">
      <a id="id_cloudzoom" href='/productimages/<%=sFilename%>' class='<%=sZoomClass%>' rel2="adjustX: 10, adjustY:-4" rel="position: 'inside'">
      <img src="/productimages/<%=sFilename%>" alt="" width="580" id="id_ppimage" class="demo-image">
      </a>
     </td>
   </tr>
  </table>
 </td>
</tr>
</table>
<% } %>