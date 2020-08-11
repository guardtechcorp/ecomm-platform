<HTML>
<HEAD>
<STYLE type="text/css" media="screen">
<!--
	a.menu:link, a.menu:visited {
		font-size       : 11;
		color           : black;
		text-decoration : none;
		font-face       : Arial;
		font-weight     : 600;
	}
	a.menu:hover {
		font-size       : 11;
		color           : #256A19;
		text-decoration : underline;
		font-face       : Arial;
		font-weight:600;
	}
	.submit {
		background-color: #7a9f54;
		font-family     : Arial;
		font-size       : 10px;
		color           : white;
		font-weight     : bold;
	}
	.button {
		background-color: #c5e1a3;
		color           : black;
		font-family     : Arial;
		font-size       : 10px;
	}
	a:link {
		color           : #003366;
		text-decoration : none;
		font-face       : Arial;
	}
	a:visited {
		color           : #333366;
		text-decoration : none;
		font-face       : 'Verdana,Helvetica,Arial,sans-serif';
	}
	a:hover {
		color           : #3366cc;
		text-decoration : underline;
		font-face       : 'Verdana,Helvetica,Arial,sans-serif';
	}

	body {
		scrollbar-base-color: #404040;
		scrollbar-arrow-color: #00ff33;
	}

	.tb_icon {
		position : absolute;
		width    : 22px;
		height   : 22px;
		left     : -1px;
		top      : -1px;
	}

	.icon_down {
		position : absolute;
		left     : 0px;
		top      : 0px;
		height   : 23px;
		width    : 24px;
	}

	.icon_downpressed {
		position : absolute;
		left     : 1px;
		top      : 1px;
	}

	.tb_menu_item {
		position      : absolute;
		border-bottom : #cccccc solid 1px; // E6F5D7
		border-left   : #cccccc solid 1px; // E6F5D7
		border-right  : #cccccc solid 1px; // E6F5D7
		border-top    : #cccccc solid 1px; // E6F5D7
		top           : 1px;
		height        : 22px;
		width         : 23px;
	}

	.menu_item_mouseoverup {
		position      : absolute;
		border-bottom : buttonshadow solid 1px;
		border-left   : buttonhighlight solid 1px;
		border-right  : buttonshadow solid 1px;
		border-top    : buttonhighlight solid 1px;
		top           : 1px;
		height        : 22px;
		width         : 23px;
	}

	.menu_item_mouseoverdown {
		position      : absolute;
		border-bottom : buttonhighlight solid 1px;
		border-left   : buttonshadow solid 1px;
		border-right  : buttonhighlight solid 1px;
		border-top    : buttonshadow solid 1px;
		top           : 1px;
		height        : 22px;
		width         : 23px;
	}

	.menu_item_down {
		position         : absolute;
		background-color : gainsboro;
		border-bottom    : buttonhighlight solid 1px;
		border-left      : buttonshadow solid 1px;
		border-right     : buttonhighlight solid 1px;
		border-top       : buttonshadow solid 1px;
		top              : 1px;
		height           : 22px;
		width            : 23px;
	}

	.tb_sep {
		position     : absolute;
		border-left  : buttonshadow solid 1px;
		border-right : buttonhighlight solid 1px;
		font-size    : 0px;
		top          : 1px;
		height       : 22px;
		width        : 1px;
	}

	.tb_general {
		position         : absolute;
		background-color : #C0C0C0;
		height           : 22px;
		top              : 2px;
		font             : 8pt Verdana,Arial,sans-serif;
		border           : none;
	}

	.tb_text_mouseover {
		background-color : #C0C0C0;
		height           : 20px;
		top              : 2px;
		font-family      : "MS Sans Serif";
		font-size        : 6pt;
		border-bottom    : buttonhighlight solid 1px;
		border-left      : buttonshadow solid 1px;
		border-right     : buttonhighlight solid 1px;
		border-top       : buttonshadow solid 1px;
		height           : 17px;
	}

	.tb_handle {
		position         : absolute;
		background-color : #cccccc; //#E6F5D7;
		border-left      : buttonhighlight solid 1px;
		border-right     : buttonshadow solid 1px;
		border-top       : buttonhighlight solid 1px;
		font-size        : 1px;
		top              : 1px;
		height           : 22px;
		width            : 3px;
	}

	.toolbar {
		position         : relative;
		background-color : #cccccc; //#E6F5D7;
		border-bottom    : buttonshadow solid 1px;
		border-left      : buttonhighlight solid 1px;
		border-right     : buttonshadow solid 1px;
		border-top       : buttonhighlight solid 1px;
		height           : 25px;
		top              : 0px;
		left             : 0px;
	}
-->
</STYLE>
</HEAD>
<BODY leftmargin="0" topmargin="0" bgcolor="#cccccc">

<DIV class="toolbar" id="File" title="File" onselectstart="return parent.cancel_event();">
	<SPAN title="Handle" class=tb_handle></SPAN>
	<SPAN id="cut" title="Cut Div" onclick="parentCommand('Cut')" class="tb_menu_item">
		<IMG title="Cut" class="tb_icon" src="/staticfile/admin/images/cut.gif" alt="Bold">
	</SPAN>
	<SPAN id="copy" title="Copy Div" onclick="parentCommand('Copy')" class="tb_menu_item">
		<IMG title="Copy" class="tb_icon" src="/staticfile/admin/images/copy.gif" alt="Copy">
	</SPAN>
	<SPAN id="paste" title="Paste Div" onclick="parentCommand('Paste')" class="tb_menu_item">
		<IMG title="Paste" class="tb_icon" src="/staticfile/admin/images/paste.gif" alt="Paste">
	</SPAN>
	<!--SPAN title="Seperator" class="tb_sep"></SPAN-->
	<!--SPAN id="undo" title="Undo Div" onclick="parentCommand('Undo')" class="tb_menu_item">
		<IMG title="Undo" class="tb_icon" src="/staticfile/admin/images/undo.gif" alt="Undo">
	</SPAN-->
	<!--SPAN id="redo" title="Redo Div" onclick="parentCommand('Redo')" class="tb_menu_item">
		<IMG title="Redo" class="tb_icon" src="/staticfile/admin/images/redo.gif" alt="Redo">
	</SPAN-->
</DIV>
<DIV class="toolbar" id="Font" title="Font" onselectstart="return parent.cancel_event ();">
	<SPAN title="Handle" class=tb_handle></SPAN>
	<SPAN title="Font Name" TEXT_MODE='no'  class="tb_menu_item">
	<SELECT name="fontsize" onchange="parent.onChangeFontName(this);">
	  <option value="Arial, Helvetica, san" selected>Arial, Helvetica, San</option>
	  <option value="Times New Roman, Times, serif">Times New Roman</option>
	  <option value="Courier New, Courier, mono">Courier New, mono</option>
	  <option value="Georgia, Times New Roman, Times, serif">Georgia, Times New Roman</option>
	  <option value="Verdana, Arial, Helvetica, sans-serif">Verdana, Arial, Helvetica</option>
	  <option value="Geneva, Arial, Helvetica, san-serif">Geneva, Arial, Helvetica</option>
	</SELECT>
	</SPAN>
	<SPAN title="Font Size" TEXT_MODE='no'  class="tb_menu_item">
	<SELECT name="fontsize" onchange="parent.onChangeFontSize(this);">
	  <option value=1>1</option>
	  <option value=2>2</option>
	  <option value=3>3</option>
	  <option value=4 selected>4</option>
	  <option value=5>5</option>
	  <option value=6>6</option>
	  <option value=7>7</option>
	</SELECT>
	</SPAN>
	<SPAN title="Font Div" TEXT_MODE='no' onclick="colorDialog(1)" class="tb_menu_item">
		<IMG title="Font Color" class="tb_icon" src="/staticfile/admin/images/fontcolor.gif" alt="Font Color">
	</SPAN>
	<SPAN title="Back Div" TEXT_MODE='no' onclick="colorDialog(2)" class="tb_menu_item">
		<IMG title="Background Color" class="tb_icon" src="/staticfile/admin/images/backcolor.gif" alt="Background Color">
	</SPAN>
</DIV>
<DIV class="toolbar" id="Format" title="Format" onselectstart="return parent.cancel_event ();">
	<SPAN title="Handle" class=tb_handle></SPAN>
	<SPAN id="bold" title="Bold Item" onclick="parentCommand('Bold');" class="tb_menu_item">
		<IMG id="boldImage" title="Bold" class="tb_icon" src="/staticfile/admin/images/bold.gif" alt="Bold">
	</SPAN>
	<SPAN id="italic" title="Italic Item" onclick="parentCommand('Italic');" class="tb_menu_item">
		<IMG id="italicImage" title="Italic" class="tb_icon" src="/staticfile/admin/images/italic.gif" alt="Italic">
	</SPAN>
	<SPAN id="underline" title="Underline Item" onclick="parentCommand('Underline');" class="tb_menu_item">
		<IMG id="underlineImage" title="Underline" class="tb_icon" src="/staticfile/admin/images/under.gif" alt="Underline">
	</SPAN>
	<SPAN id="underline" title="Strike Through" onclick="parentCommand('StrikeThrough');" class="tb_menu_item">
		<IMG id="underlineImage" title="Underline" class="tb_icon" src="/staticfile/admin/images/strike.gif" alt="Strike Through">
	</SPAN>
	<SPAN title="Seperator" class="tb_sep"></SPAN>
	<SPAN id="super" title="Super Div" TEXT_MODE='no' onclick="parentCommand('SuperScript');" class="tb_menu_item">
		<IMG id="superImage" title="SuperScript" class="tb_icon" src="/staticfile/admin/images/superscript.gif" alt="SuperScript">
	</SPAN>
	<SPAN id="sub" title="Sub Div" TEXT_MODE='no' onclick="parentCommand('SubScript');" class="tb_menu_item">
		<IMG id="subImage" title="SubScript" class="tb_icon" src="/staticfile/admin/images/subscript.gif" alt="SubScript">
	</SPAN>
</DIV>
<DIV class="toolbar" id="layout" title="layout" onselectstart="return parent.cancel_event ();">
	<SPAN title="Handle" class=tb_handle></SPAN>
	<SPAN id="jleft" title="Left Div" TEXT_MODE='no' onclick="parentCommand('JustifyLeft');" class="tb_menu_item">
		<IMG id="jleftImage" title="Justify Left" class="tb_icon" src="/staticfile/admin/images/left.gif" alt="Justify Left">
	</SPAN>
	<SPAN id="jcenter" title="Center Div" TEXT_MODE='no' onclick="parentCommand('JustifyCenter');" class="tb_menu_item">
		<IMG id="jcenterImage" title="Justify Center" class="tb_icon" src="/staticfile/admin/images/center.gif" alt="Justify Center">
	</SPAN>
	<SPAN id="jright" title="Right Div" TEXT_MODE='no' onclick="parentCommand('JustifyRight');" class="tb_menu_item">
		<IMG id="jrightImage" title="Justify Right" class="tb_icon" src="/staticfile/admin/images/right.gif" alt="Justify Right">
	</SPAN>
	<SPAN title="Seperator" class="tb_sep"></SPAN>
	<SPAN id="ol" title="OL Div" TEXT_MODE='no' onclick="parentCommand('InsertOrderedList');" class="tb_menu_item">
		<IMG id="olImage" title="Ordered List" class="tb_icon" src="/staticfile/admin/images/numlist.gif" alt="Ordered List">
	</SPAN>
	<SPAN id="ul" title="UL Div" TEXT_MODE='no' onclick="parentCommand('InsertUnorderedList');" class="tb_menu_item">
		<IMG id="ulImage" title="Unordered List" class="tb_icon" src="/staticfile/admin/images/bullist.gif" alt="Unordered List">
	</SPAN>
	<SPAN title="Outdent Div" onclick="parentCommand('Outdent')" TEXT_MODE='no' class="tb_menu_item">
		<IMG title="Outdent" class="tb_icon" src="/staticfile/admin/images/outdent.gif" alt="Outdent">
	</SPAN>
	<SPAN title="Indent Div" onclick="parentCommand('Indent')" TEXT_MODE='no' class="tb_menu_item">
		<IMG title="Indent" class="tb_icon" src="/staticfile/admin/images/indent.gif" alt="Indent">
	</SPAN>
</DIV>
<DIV class="toolbar" id="Misc" title="Misc" onselectstart="return parent.cancel_event();">
	<SPAN title="Handle" class=tb_handle></SPAN>
	<SPAN title="Horizontal Rule Div" onclick="parentCommand('InsertHorizontalRule')" class="tb_menu_item">
		<IMG title="Horizontal Rule" class="tb_icon" src="/staticfile/admin/images/hr.gif" alt="Horizontal Rule">
	</SPAN>
	<SPAN title="Seperator" class="tb_sep"></SPAN>
	<SPAN id="link" title="Link Div" onclick="linkDialog()" class="tb_menu_item">
	     <IMG id="linkImage" title="Link" class="tb_icon" src="/staticfile/admin/images/link.gif" alt="Create Link">
	</SPAN>
</DIV>
<IFRAME width="100%" height="100" name="editor_iframe" id="editor_iframe" style="position: absolute" src="editor-body.jsp"></IFRAME>
</BODY>
</HTML>
