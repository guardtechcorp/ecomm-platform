<%@ page import="java.io.File" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean" %>
<%

//   String sImageList = fileWeb.getThumbNailList(fileWeb.getDomainName(), ltFile, 150, 100);
//   String sImageUrl   =  fileWeb.getStortageFileUrl(0, null) + "?action=file&pageno=";
/*
        <li value="1"><img src="/staticfile/web/css/media/slideshow/thumbs/1.jpg" width="179" height="100" alt="" /></li>
        <li value="2"><img src="/staticfile/web/css/media/slideshow/thumbs/2.jpg" width="179" height="100" alt="" /></li>
        <li value="3"><img src="/staticfile/web/css/media/slideshow/thumbs/3.jpg" width="179" height="100" alt="" /></li>
        <li value="4"><img src="/staticfile/web/css/media/slideshow/thumbs/4.jpg" width="179" height="100" alt="" /></li>
        <li value="5"><img src="/staticfile/web/css/media/slideshow/thumbs/5.jpg" width="179" height="100" alt="" /></li>
     <sImageList>
*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>AJAX Photo Gallery</title>
<link rel="stylesheet" type="text/css" href="/staticfile/web/css/slidetest.css" />
</head>
<body>

<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<tr>
 <td>
  <div id="slide_gallery">
  <div idnone="imagearea">
    <div id="slide_image">
      <a href="javascript:slideShow.nav(-1)" class="slide_imgnav" id="slide_previmg"></a>
      <a href="javascript:slideShow.nav(1)" class="slide_imgnav" id="slide_nextimg"></a>
    </div>
  </div>
  <div id="slide_thumbwrapper">
   <div id="slide_thumbarea">
     <ul id="slide_thumbs">
         <li value="1"><img src="/staticfile/web/css/media/slideshow/thumbs/1.jpg" width="179" height="100" alt="" /></li>
         <li value="2"><img src="/staticfile/web/css/media/slideshow/thumbs/2.jpg" width="179" height="100" alt="" /></li>
         <li value="3"><img src="/staticfile/web/css/media/slideshow/thumbs/3.jpg" width="179" height="100" alt="" /></li>
         <li value="4"><img src="/staticfile/web/css/media/slideshow/thumbs/4.jpg" width="179" height="100" alt="" /></li>
         <li value="5"><img src="/staticfile/web/css/media/slideshow/thumbs/5.jpg" width="179" height="100" alt="" /></li>
     </ul>
    </div>
   </div>
 </div>
 </td>
</tr>
</table>
<script type="text/javascript">
var slideimgid = 'slide_image';
var slidethumbid = 'slide_thumbs';
var slideauto = false;//true;
var slideautodelay = 5;
var slideheight = 525;
function getImageById(id)
{  
   return '/staticfile/web/css/media/slideshow/fullsize/'+id+ '.jpg';
//   return 'sImageUrl' + id;
}
</script>
<script type="text/javascript" src="/staticfile/web/scripts/slidetest.js"></script>
</body>
</html>