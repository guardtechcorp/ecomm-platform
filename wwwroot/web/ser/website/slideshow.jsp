<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.graphimage.Thumbnail" %>
<%
    SiteFileWeb fileWeb = SiteFileWeb.getObject(session);
    WebPageInfo wpInfo = fileWeb.getWebPage();
    List ltFile = fileWeb.getPageList(request, fileWeb.encodedUrl("index.jsp?action=Switch Page_WebFiles&accessby=" + wpInfo.AccessMode));

    String sImageList = fileWeb.getThumbNailList(fileWeb.getDomainName(), ltFile, 106, 80, Thumbnail.FIT_HEIGHT);
    int nMaxWidth = 700, nMaxHeight = 525;
    fileWeb.makeImageCacheFiles(fileWeb.getDomainName(), ltFile, nMaxWidth, nMaxHeight);
    String sImageUrl = fileWeb.getStortageFileUrl(0, null) + "?action=file&width=" + nMaxWidth + "&height=" + nMaxHeight + "&pageno=";
    int nStartNo = Utilities.getInt(fileWeb.getCacheData(SiteFileWeb.KEY_STARTROWNO), 1) - 1;
//System.out.println(sImageList);   
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>AJAX Photo Gallery</title>
<link rel="stylesheet" type="text/css" href="/staticfile/web/css/slideshow.css" />
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
<%=sImageList%>
     </ul>
    </div>
   </div>
   <div id="slide_status" class="controls">
    <TABLE width="100%">
     <tr>
      <td align="left" width="20%">
      <a href="javascript:slideShow.mvend(-1)" id="slidefirstid" class="slide_navlink"><< First</a>
      <a href="javascript:slideShow.mvpage(-1, 1)" id="slideprevid" class="slide_navlink">< Previous</a>
      </td>
      <td align="center">
       <span id='slidderangeid' class='slide_text'>1-5</span><span class='slide_text'> of </span><span id='slidetotalid' class='slide_text'>30</span>
      </td>
      <td align="right" width="20%"><font size=2>
      <a href="javascript:slideShow.mvpage(1, 1)" id="slidenextid" class="slide_navlink">Next ></a>
      <a href="javascript:slideShow.mvend(1)" id="slidelastid" class="slide_navlink">Last >></a>
      </font>
      </td>
      <td width="28%" align="right"><span class='slide_text'>Picture No: </span><span id='slideimageid' class='slide_text'>0</span>&nbsp;&nbsp;
      <a href="javascript:slideShow.tgplay()" id="slideplayid" class="slide_navlink">Auto Play</a>
      </td>
     </tr>
    </TABLE>
   </div>
</div>
 </td>
</tr>
</table>
<script type="text/javascript">
var slideimgid = 'slide_image';
var slidethumbid = 'slide_thumbs';
var slideauto = false;
var slideautodelay = 5;
var slideimgheight = 525;
function getImageById(id)
{  
//   return '/staticfile/web/css/media/slideshow/fullsize/'+id+ '.jpg';
   return '<%=sImageUrl%>' + (<%=nStartNo%>+parseInt(id)) + '&cache=1';
}
function onClickImage(id)
{
  var sImageUrl = '<%=sImageUrl%>' + (<%=nStartNo%>+parseInt(id));
  var childWin =window.open(sImageUrl,'PictureView','resizable=yes,scrollbars=auto,width=800,height=600');
  childWin.focus();
//  alert("You just clicked image=" + i);
}    
</script>
<script type="text/javascript" src="/staticfile/web/scripts/slideshow.js"></script>
</body>
</html>