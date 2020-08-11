<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>AJAX Photo Gallery</title>
<link rel="stylesheet" type="text/css" href="/staticfile/web/css/slidetest.css" />
</head>
<body>
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
        <li value="1"><img src="/staticfile/web/css/media/slideshow/thumbs/1.jpg" width="79" height="100" alt="" /></li>
        <li value="2"><img src="/staticfile/web/css/media/slideshow/thumbs/2.jpg" width="179" height="100" alt="" /></li>
        <li value="3"><img src="/staticfile/web/css/media/slideshow/thumbs/3.jpg" width="100" height="100" alt="" /></li>
        <li value="4"><img src="/staticfile/web/css/media/slideshow/thumbs/4.jpg" width="179" height="100" alt="" /></li>
        <li value="5"><img src="/staticfile/web/css/media/slideshow/thumbs/5.jpg" width="179" height="100" alt="" /></li>
        <li value="1"><img src="/staticfile/web/css/media/slideshow/thumbs/1.jpg" width="179" height="100" alt="" /></li>
        <li value="2"><img src="/staticfile/web/css/media/slideshow/thumbs/2.jpg" width="179" height="100" alt="" /></li>
        <li value="3"><img src="/staticfile/web/css/media/slideshow/thumbs/3.jpg" width="179" height="100" alt="" /></li>
        <li value="4"><img src="/staticfile/web/css/media/slideshow/thumbs/4.jpg" width="179" height="100" alt="" /></li>
        <li value="5"><img src="/staticfile/web/css/media/slideshow/thumbs/5.jpg" width="179" height="100" alt="" /></li>
      </ul>
    </div>
      <div >
        <a href="javascript:slideShow.mvend(-1)" class="slide_imgnav" id="slide_previmg1"><< Start</a>
        <a href="javascript:slideShow.mvend(1)" class="slide_imgnav" id="slide_nextimg1">End >></a>
      </div>
  </div>
</div>
     
<script type="text/javascript">
var slideimgid = 'slide_image';
var slidethumbid = 'slide_thumbs';
var slideauto = false;//true;
var slideautodelay = 5;
var imgdir = 'fullsize';
var imgext = '.jpg';
function getImageById(id)
{
//  return imgdir+'/'+id+imgext;
  return '/staticfile/web/css/media/slideshow/fullsize/'+id+ '.jpg';
}
</script>
<script type="text/javascript" src="/staticfile/web/scripts/slidetest.js"></script>
</body>
</html>