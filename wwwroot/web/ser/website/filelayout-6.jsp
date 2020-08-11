<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.graphimage.Thumbnail" %>
<%
{
    String sImageList = fileWeb.getThumbNailList(fileWeb.getDomainName(), ltFile, 106, 80, Thumbnail.FIT_BEST);
    int nMaxWidth = 700, nMaxHeight = 525;
    String sImageUrl = fileWeb.getStortageFileUrl(0, null) + "?action=file&width=" + nMaxWidth + "&height=" + nMaxHeight + "&pageno=";
    int nStartNo = Utilities.getInt(fileWeb.getCacheData(SiteFileWeb.KEY_STARTROWNO), 1) - 1;
/*
<h1 class="hovertitle">Hoverbox Image Gallery</h1>
  <li>
 <a href="#"><img src="/staticfile/web/css/media/slideshow/thumbs/photo01.jpg" alt="description" /><img src="image/photo01.jpg" alt="description" class="preview" /></a>
 </li>
*/
%>
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<tr>
<td width="5%"></td>
<td>
 <ul class="hoverbox" id="image_thumbs">
<%=sImageList%>
 </ul>
 </td>
</tr>
</table>
<script type="text/javascript">
function onClickThumbImage(id)
{
  var sImageUrl = '<%=sImageUrl%>' + (<%=nStartNo%>+parseInt(id));
  var childWin =window.open(sImageUrl,'PictureView','resizable=yes,scrollbars=auto,width=800,height=600');
  childWin.focus();
}

function initImageList(slidethumbid)
{
  var ta = document.getElementById(slidethumbid);
  var t = ta.getElementsByTagName('li');
  var len =t.length;
  for (var i=0; i<len; i++) {
     var id=t[i].value;
     t[i].onclick = new Function("onClickThumbImage('"+id+"')");

     var timg = t[i].getElementsByTagName('img');
     if (timg[0].attributes["width"].value!='106')
        timg[0].style.width = timg[0].attributes["width"].value + "px";
  }
}
initImageList('image_thumbs');        
 </script>

<% } %>
