<tr>
 <td >
<table cellspacing="0" class="box-table" style="width:256px;">
<tr>
<td colspan="2" rowspan="2" class="box-blue" style="width:252px;">
  <div class="box-div">
  <div class="header">Javascript Tricks, Code Samples and Snippets </div>

  </div>
</td>
<td class="box-tr"></td>
</tr>
<tr>
<td class="box-r" style="height:52px;"></td>
</tr>
<tr>
<td class="box-bl"></td>
<td class="box-b" style="width:248px;"></td>
<td class="box-br"></td>
</tr>
<tr>
<td colspan=2 height=20>
<FORM id=cse-search-box action=http://www.hscripts.com/search.php>
<INPUT name=q size=30><INPUT type=submit value=Search name=sa>
</FORM>
<!--SCRIPT src="scripts/google-searchbox.js" type=text/javascript></SCRIPT-->

  <PRE class=js title=code>
      <#include file="test.cpp" />
      &lt;div id="floatdiv" style="
    position:absolute;
    width:200px;height:50px;left:0px;top:0px;
    padding:16px;background:#FFFFFF;
    border:2px solid #2266AA"&gt;
    This is a floating javascript menu.&lt;/div&gt;</PRE>

<UL><LI>Insert the following code after this <SPAN class=tagname>DIV</SPAN>:</LI></UL>
<PRE class=js title=code>
    var floatingMenuId = 'floatdiv';
var floatingMenu =
{
    targetX: -250,
    targetY: 10,

    hasInner: typeof(window.innerWidth) == 'number',
    hasElement: document.documentElement
        &amp;&amp; document.documentElement.clientWidth,

    menu:
        document.getElementById
        ? document.getElementById(floatingMenuId)
        : document.all
          ? document.all[floatingMenuId]
          : document.layers[floatingMenuId]
};

    
</PRE>
<SCRIPT src="/staticfile/web/scripts/showcode.js" type=text/javascript></SCRIPT>
    </td>
</tr>
</table> 

<script type="text/javascript" src="/staticfile/web/scripts/dtree.js"></script>
<div class="dtree">

	<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>

	<script type="text/javascript">
		<!--

		d = new dTree('d');

		d.add(0,-1,'My example tree');
		d.add(1,0,'Node 1','example01.html');
		d.add(2,0,'Node 2','example01.html');
		d.add(3,1,'Node 1.1','example01.html');
		d.add(4,0,'Node 3','example01.html');
		d.add(5,3,'Node 1.1.1','example01.html');
		d.add(6,5,'Node 1.1.1.1','example01.html');
		d.add(7,0,'Node 4','example01.html');
		d.add(8,1,'Node 1.2','example01.html');
		d.add(9,0,'My Pictures','example01.html','Pictures I\'ve taken over the years','','','css/media/dtree/imgfolder.gif');
		d.add(10,9,'The trip to Iceland','example01.html','Pictures of Gullfoss and Geysir');
		d.add(11,9,'Mom\'s birthday','example01.html');
		d.add(12,0,'Recycle Bin','example01.html','','','/staticfile/web/css/media/dtree/trash.gif');

		document.write(d);

		//-->
	</script>

</div>


<script type="text/javascript">
 //Contents for menu 1
var menu1=new Array()
menu1[0]='<a href="http://www.javascriptkit.com">JavaScript Kit</a>'
menu1[1]='<a href="http://www.freewarejava.com">Freewarejava.com</a>'
menu1[2]='<a href="http://codingforums.com">Coding Forums</a>'
menu1[3]='<a href="http://www.cssdrive.com">CSS Drive</a>'
menu1[4]='<a href="http://tools.dynamicdrive.com/imageoptimizer/">Image Optimizer</a>'

//Contents for menu 2, and so on
var menu2=new Array()
menu2[0]='<a href="http://www.javascriptkit.com/cutpastejava.shtml">Free JavaScripts</a>'
menu2[1]='<a href="http://www.javascriptkit.com/javaindex.shtml">JavaScript tutorials</a>'
menu2[2]='<a href="http://news.bbc.co.uk">JavaScript Reference</a>'
menu2[4]='<a href="http://www.javascriptkit.com/java/">Java Applets</a>'
menu2[3]='<a href="http://www.javascriptkit.com/dhtmltutors/">DHTML & CSS</a>'
menu2[4]='<a href="http://www.javascriptkit.com/howto/">Design Tutorials</a>'
</script>

 <table width="100%" cellspacing=0 cellpadding=2 align="left" border=0 bgcolor="#FFEFD5">
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
  <tr>
   <td width="98%">
<div id="ddsidemenubar" class="markermenu">
<ul>
<li><a href="http://www.dynamicdrive.com/">Dynamic Drive</a></li>
<li><a href="http://www.dynamicdrive.com/style/" rel="ddsubmenuside1">CSS Library</a></li>
<li><a href="http://www.javascriptkit.com/jsref/" rel="ddsubmenuside2">JavaScript Reference</a></li>
<li><a href="http://www.javascriptkit.com/domref/">DOM  Reference</a></li>
<li><a href="http://www.cssdrive.com" rel="ddsubmenuside3">CSS Drive</a></li>
<li><a href="http://www.codingforums.com/" style="border-bottom-width: 0">Coding Forums</a></li>		
</ul>
</div>
<script type="text/javascript" src="/staticfile/web/scripts/ddlevelsmenu.js"></script>
<script type="text/javascript">ddlevelsmenu.setup("ddsidemenubar", "sidebar")</script>
       <!--Top Drop Down Menu 2 HTML-->

       <ul id="ddsubmenu2" class="ddsubmenustyle blackwhite">
       <li><a href="#">Item 1b</a></li>
       <li><a href="#">Item 2b</a></li>
       <li><a href="#">Item Folder 3b</a>
         <ul>
         <li><a href="#">Sub Item 3.1b</a></li>
         <li><a href="#">Sub Item 3.2b</a></li>
         <li><a href="#">Sub Item 3.3b</a></li>
         <li><a href="#">Sub Item 3.4b</a></li>
         </ul>
       </li>
       <li><a href="#">Item 4b</a></li>
       <li><a href="#">Item Folder 5b</a>
         <ul>
         <li><a href="#">Sub Item 5.1b</a></li>
         <li><a href="#">Item Folder 5.2b</a>
           <ul>
           <li><a href="#">Sub Item 5.2.1b</a></li>
           <li><a href="#">Sub Item 5.2.2b</a></li>
           <li><a href="#">Sub Item 5.2.3b</a></li>
           </ul>
         </li>
           </ul>
       </li>
       <li><a href="#">Item 6b</a></li>
       </ul>

       <!--Top Drop Down Menu 3 HTML-->

       <ul id="ddsubmenu3" class="ddsubmenustyle">
       <li><a href="http://tools.dynamicdrive.com/imageoptimizer/">Image Optimizer</a></li>
       <li><a href="http://tools.dynamicdrive.com/favicon/">FavIcon Generator</a></li>
       <li><a href="http://www.dynamicdrive.com/emailriddler/">Email Riddler</a></li>
       <li><a href="http://tools.dynamicdrive.com/password/">htaccess Password</a></li>
       <li><a href="http://tools.dynamicdrive.com/userban/">htaccess Banning</a></li>
       </ul>

       <!--Side Drop Down Menu 1 HTML-->
       <ul id="ddsubmenuside1" class="ddsubmenustyle blackwhite1">
       <li><a href="#">Item 1a</a></li>
       <li><a href="#">Item 2a</a></li>
       <li><a href="#">Item Folder 3a</a>
         <ul>
         <li><a href="#">Sub Item 3.1a</a></li>
         <li><a href="#">Sub Item 3.2a</a></li>
         <li><a href="#">Sub Item 3.3a</a></li>
         <li><a href="#">Sub Item 3.4a</a></li>
         </ul>
       </li>
       <li><a href="#">Item 4a</a></li>
       <li><a href="#">Item Folder 5a</a>
         <ul>
         <li><a href="#">Sub Item 5.1a</a></li>
         <li><a href="#">Item Folder 5.2a</a>
           <ul>
           <li><a href="#">Sub Item 5.2.1a</a></li>
           <li><a href="#">Sub Item 5.2.2a</a></li>
           <li><a href="#">Sub Item 5.2.3a</a></li>
           <li><a href="#">Sub Item 5.2.4a</a></li>
           </ul>
         </li>
           </ul>
       </li>
       <li><a href="#">Item 6a</a></li>
       </ul>

       <!--Side Drop Down Menu 2 HTML-->
       <ul id="ddsubmenuside2" class="ddsubmenustyle blackwhite">
       <li><a href="#">Item 1b</a></li>
       <li><a href="#">Item 2b</a></li>
       <li><a href="#">Item Folder 3b</a>
         <ul>
         <li><a href="#">Sub Item 3.1b</a></li>
         <li><a href="#">Sub Item 3.2b</a></li>
         <li><a href="#">Sub Item 3.3b</a></li>
         <li><a href="#">Sub Item 3.4b</a></li>
         </ul>
       </li>
       <li><a href="#">Item 4b</a></li>
       <li><a href="#">Item Folder 5b</a>
         <ul>
         <li><a href="#">Sub Item 5.1b</a></li>
         <li><a href="#">Item Folder 5.2b</a>
           <ul>
           <li><a href="#">Sub Item 5.2.1b</a></li>
           <li><a href="#">Sub Item 5.2.2b</a></li>
           <li><a href="#">Sub Item 5.2.3b</a></li>
           </ul>
         </li>
           </ul>
       </li>
       <li><a href="#">Item 6b</a></li>
       </ul>
       <!--Side Drop Down Menu 3 HTML-->
       <ul id="ddsubmenuside3" class="ddsubmenustyle blackwhite">
       <li><a href="http://tools.dynamicdrive.com/imageoptimizer/">Image Optimizer</a></li>
       <li><a href="http://tools.dynamicdrive.com/favicon/">FavIcon Generator</a></li>
       <li><a href="http://www.dynamicdrive.com/emailriddler/">Email Riddler</a></li>
       <li><a href="http://tools.dynamicdrive.com/password/">htaccess Password</a></li>
       <li><a href="http://tools.dynamicdrive.com/userban/">htaccess Banning</a></li>
       </ul>


<div id="ddtopmenubar" class="mattblackmenu">
<ul>
<li><a href="http://www.dynamicdrive.com">Home</a></li>
<li><a href="http://www.dynamicdrive.com/new.htm" rel="ddsubmenu1">DHTML</a></li>
<li><a href="http://www.dynamicdrive.com/style/" rel="ddsubmenu2">CSS</a></li>
<li><a href="http://www.dynamicdrive.com/forums/">Forums</a></li>
<li><a href="http://tools.dynamicdrive.com/" rel="ddsubmenu3">Web Tools</a></li>
</ul>
</div>
<script type="text/javascript">ddlevelsmenu.setup("ddtopmenubar", "topbar")</script>
<ul id="ddsubmenu1" class="ddsubmenustyle">
<li><a href="#">Item 1a</a></li>
<li><a href="#">Item 2a</a></li>
<li><a href="#">Item Folder 3a</a>
  <ul>
  <li><a href="#">Sub Item 3.1a</a></li>
  <li><a href="#">Sub Item 3.2a</a></li>
  <li><a href="#">Sub Item 3.3a</a></li>
  <li><a href="#">Sub Item 3.4a</a></li>
  </ul>
</li>
<li><a href="#">Item 4a</a></li>
<li><a href="#">Item Folder 5a</a>
  <ul>
  <li><a href="#">Sub Item 5.1a</a></li>
  <li><a href="#">Item Folder 5.2a</a>
    <ul>
    <li><a href="#">Sub Item 5.2.1a</a></li>
    <li><a href="#">Sub Item 5.2.2a</a>
      <ul>
       <li><a href="#">Sub Item 6.1.1a</a></li>
       <li><a href="#">Sub Item 6.1.2a</a>
	  </ul>
	</li>
    <li><a href="#">Sub Item 5.2.3a</a></li>
    <li><a href="#">Sub Item 5.2.4a</a></li>
    </ul>
  </li>
	</ul>
</li>
<li><a href="#">Item 6a</a></li>
</ul>



<div class="arrowlistmenu">
<h2 class="menuheader expandable">+ CSS Library</h2>
<ul class="categoryitems">
<li><a href="javascript:;">Horizontal CSS Menus</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C2/"  onMouseover="dropdownmenuxx(this, event, menu2, '165px')" onMouseout="delayhidemenu()">Vertical CSS Menus</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C4/">Image CSS</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C6/">Form CSS</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C5/">DIVs and containers</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C7/">Links & Buttons</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C8/">Other</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/all/">Browse All</a></li>
</ul>
</div>   


<ul class="slidedoormenu">
<li><a href="http://www.dynamicdrive.com/" onMouseover="dropdownmenuxx(this, event, menu1, '165px')" onMouseout="delayhidemenuxx()">»  Dynamic Drive 2</a></li>
<li><a href="http://www.dynamicdrive.com/style/" onMouseover="dropdownmenuxx(this, event, menu2, '165px')" onMouseout="delayhidemenuxx()">»  CSS Examples</a></li>
<li><a href="http://www.javascriptkit.com/jsref/">»  JavaScript Reference</a></li>
<li><a href="http://www.javascriptkit.com/domref/">»  DOM Reference</a></li>
<li><a href="http://www.cssdrive.com">»  CSS Drive</a></li>
<li class="lastitem"><a href="http://www.codingforums.com/">»  Coding Forums</a></li>
</ul>
<p>
<ul class="glossymenu">
<li><a href="http://www.dynamicdrive.com/" onMouseover="dropdownmenuxx(this, event, menu2, '165px')" onMouseout="delayhidemenu()">Dynamic Drive 3</a></li>
<li><a href="http://www.dynamicdrive.com/style/" >CSS Examples</a></li>
<li><a href="http://www.javascriptkit.com/jsref/">JavaScript Reference</a></li>
<li><a href="http://www.javascriptkit.com/domref/">DOM Reference</a></li>
<li><a href="http://www.cssdrive.com">CSS Drive</a></li>
<li><a href="http://www.codingforums.com/" style="border-bottom-width: 0">Coding Forums</a></li>
</ul>
<p>
<ul class="markermenu">
<li><a href="http://www.dynamicdrive.com/" >Dynamic Drive 4</a></li>
<li><a href="http://www.dynamicdrive.com/style/" >CSS Library</a></li>
<li><a href="http://www.javascriptkit.com/jsref/">JavaScript Reference</a></li>
<li><a href="http://www.javascriptkit.com/domref/">DOM  Reference</a></li>
<li><a href="http://www.cssdrive.com">CSS Drive</a></li>
<li><a href="http://www.codingforums.com/" style="border-bottom-width: 0">Coding Forums</a></li>
</ul>
<p>
<div id="ddblueblockmenu">
<ul>
<li><a href="http://www.dynamicdrive.com">Home 5</a></li>
<li><a href="http://www.dynamicdrive.com/new.htm">What's New</a></li>
<li><a href="http://www.dynamicdrive.com/revised.htm">What's Revised</a></li>
<li><a href="http://www.dynamicdrive.com/forums/">Help Forums</a></li>
</ul>
<div class="menutitle">CSS Library</div>
<ul>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C1/">Horizontal CSS Menus</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C2/">Vertical CSS Menus</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C4/">Image Effects</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C6/">Form Effects</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C5/">Boxes & containers</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C7/" style="border-bottom-color: black">Links & Buttons</a></li>
</ul>
</div>
<p>
<div class="wireframemenu">
<ul>
<li><a href="http://www.dynamicdrive.com/">Dynamic Drive 6</a></li>
<li><a href="http://www.dynamicdrive.com/style/">CSS Library</a></li>
<li><a href="http://www.dynamicdrive.com/forums/">Forums</a></li>
<li><a href="http://tools.dynamicdrive.com/imageoptimizer/">Gif Optimizer</a></li>
<li><a href="http://tools.dynamicdrive.com/favicon/">Favicon Creator</a></li>
<li><a href="http://tools.dynamicdrive.com/button/">Button Maker</a></li>
</ul>
</div>
<p>
<ul class="buttonmenu">
<li><a href="http://www.dynamicdrive.com/">Dynamic Drive 7</a></li>
<li><a href="http://www.dynamicdrive.com/style/">CSS Library</a></li>
<li><a href="http://www.cssdrive.com/">CSS Drive</a></li>
<li><a href="http://tools.dynamicdrive.com/imageoptimizer/">Gif Optimizer</a></li>
<li><a href="http://tools.dynamicdrive.com/favicon/">Favicon Creator</a></li>
<li><a href="http://tools.dynamicdrive.com/button/">Button Maker</a></li>
</ul>
<p>
<ul class="bevelmenu">
<li><a href="http://www.dynamicdrive.com/" >Dynamic Drive 8</a></li>
<li><a href="http://www.dynamicdrive.com/style/" >CSS Library</a></li>
<li><a href="http://www.javascriptkit.com/jsref/">JavaScript Reference</a></li>
<li><a href="http://www.javascriptkit.com/domref/">DOM  Reference</a></li>
<li><a href="http://www.cssdrive.com">CSS Drive</a></li>
<li><a href="http://www.codingforums.com/">Coding Forums</a></li>
</ul>
<p>
<ul class="leftmenu">
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C1/">Horizontal CSS Menus 9</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C2/">Vertical CSS Menus</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C4/">Image CSS</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C6/">Form CSS</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C5/">DIVs and containers</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C7/">Links & Buttons</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C8/">Other</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/all/">Browse All</a></li>
</ul>
<p>
<ul class="chromemenu">
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C1/">Horizontal CSS Menus 10</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C2/">Vertical CSS Menus</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C4/">Image CSS</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C6/">Form CSS</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C5/">DIVs and containers</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C7/">Links & Buttons</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/category/C8/">Other</a></li>
<li><a href="http://www.dynamicdrive.com/style/csslibrary/all/">Browse All</a></li>
</ul>
<p>
 <div id="coolmenu">
 <a href="http://www.cssdrive.com">CSS Drive</a>
 <a href="http://www.javascriptkit.com">JavaScript Kit</a>
 <a href="http://www.javascriptkit.com/cutpastejava.shtml">Free JavaScripts</a>
 <a href="http://www.javascriptkit.com/jsref/">JavaScript Reference</a>
<a href="javascript:displayDialog('Error','You have encountered a critical error.','error',2, 'maskarea');">Error</a>
<a href="javascript:displayDialog('Warning','You must enter all required information.','warning');">Warning</a>
<a href="javascript:displayDialog('Success','Your request has been successfully received.','success');">Success</a>
<a href="javascript:displayDialog('Confirmation','Are you sure you want to delete the entry?','prompt');">Prompt</a>
 <a href="#" onClick="doProcess('processid');">Show Process....</a>
 </div>
 </td>
</tr>
 <tr>
   <td >
   <script type="text/javascript" src="/staticfile/web/scripts/expando.js"></script>
   <p>
   <img class="expando" border="0" src="/staticfile/web/css/media/slideshow/fullsize/1.jpg" width="100" height="75">
   <img class="expando vacation" border="0" src="/staticfile/web/css/media/slideshow/fullsize/2.jpg" width="100" height="66">
   <img class="expando1" border="0" src="/staticfile/web/css/media/slideshow/fullsize/3.jpg" width="100" height="75">
   <p>
   <img class="expando cat" border="0" src="/staticfile/web/css/media/slideshow/fullsize/4.jpg" width="200" height="88">              
   </td>
</tr>

<tr>
 <td >
  <script type="text/javascript" src="/staticfile/web/scripts/jquery-1.2.6.pack.js"></script>
  <script type="text/javascript" src="/staticfile/web/scripts/simplegallery.js"></script>
  <script type="text/javascript">
  var mygallery=new simpleGallery({
      wrapperid: "simplegallery", //ID of main gallery container,
      dimensions: [250, 180], //width/height of gallery in pixels. Should reflect dimensions of the images exactly
      imagearray: [
          ["http://i26.tinypic.com/11l7ls0.jpg", "http://en.wikipedia.org/wiki/Swimming_pool", "_new"],
          ["http://i29.tinypic.com/xp3hns.jpg", "http://en.wikipedia.org/wiki/Cave", ""],
          ["http://i30.tinypic.com/531q3n.jpg", "", ""],
          ["http://i31.tinypic.com/119w28m.jpg", "", ""]
      ],
      autoplay: true,
      persist: false,
      pause: 2500, //pause between slides (milliseconds)
      fadeduration: 500, //transition duration (milliseconds)
      oninit:function(){ //event that fires when gallery has initialized/ ready to run
      },
      onslide:function(curslide, i){ //event that fires after each slide is shown
          //curslide: returns DOM reference to current slide's DIV (ie: try alert(curslide.innerHTML)
          //i: integer reflecting current image within collection being shown (0=1st image, 1=2nd etc)
      }
  })
  </script>
  <p>
  <div id="simplegallery"></div>
 </td>
</tr> 
<tr>
 <td>
  <script type="text/javascript" src="/staticfile/web/scripts/expandtextarea.js"></script>
   <div width="400">
     <TEXTAREA class="codecontainer" rows=10 cols=70>
     &lt;div class="indentmenu"&gt;
     .indentmenu{
     font: bold 13px Arial;
     width: 100%; /*leave this value as is in most cases*/
     overflow: hidden;
     }

     .indentmenu ul{
     margin: 0;
     padding: 0;
     float: left;
     width: 80%; /*width of menu*/
     border: 1px solid #564c66; /*dark purple border*/
     border-width: 1px 0;
     background: black url(media/indentbg.gif) center center repeat-x;
     }

     .indentmenu ul li{
     display: inline;
     }

     .indentmenu ul li a{
     float: left;
     color: white; /*text color*/
     padding: 5px 11px;
     text-decoration: none;
     border-right: 1px solid #564c66; /*dark purple divider between menu items*/
     }

     .indentmenu ul li a:visited{
     color: white;
     }

     .indentmenu ul li a:hover, .indentmenu ul li .current{
     color: white !important; /*text color of selected and active item*/
     padding-top: 6px; /*shift text down 1px for selected and active item*/
     padding-bottom: 4px; /*shift text down 1px for selected and active item*/
     background: black url(media/indentbg2.gif) center center repeat-x;
     }
     &lt;/style&gt;
     </TEXTAREA>
     <script>textareafuc.init("codecontainer", 1)</script>
    </div>
 </td>
</tr>

</table>
 </td>
</tr>
<span id="processid" style="visibility: hidden; position:absolute; width:425px; padding:10px; background:#fff; border:solid">
<p align="center"><h2>It is process... Please waiting. Thanks.</h2>
<input type="button" name="closeprocess" value="Close Process" onClick="closeProcess('processid');">
</span>

