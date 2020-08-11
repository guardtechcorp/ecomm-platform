
var privateMessage = 0;
var port = (window.location.port == 0) ? '' : ':' + window.location.port;
var url = window.location.protocol + '//' + window.location.hostname + port + window.location.pathname + '?';
var iframe, editor, post, outerdoc;
var innerInterval, tbInterval, pressedInterval, initialized;
window.onresize = tb_layout;

function showHide(method,section){if (eval("document.all."+section)!=null){if (method == "open" ){eval( section + ".style.display = 'inline'" );}else if (method == "close"){eval( section + ".style.display = 'none'" );}}}

function parentCommand (cmd, value)
{
  outerdoc = document.frames.editor_iframe.document;
  iframe = outerdoc.frames.editor_iframe;
  editor = iframe.document;

//alert("editor=" + editor);
  iframe.focus();
  try {
      if (value!=null)
         editor.execCommand(cmd, false, value);
      else
         editor.execCommand(cmd);
  } catch (e) { }
  iframe.focus();
}

function onChangeFontName(selectObj)
{
  parentCommand("FontName", selectObj.options[selectObj.selectedIndex].value);
}

function onChangeFontSize(selectObj)
{
//alert("value=" +selectObj.options[selectObj.selectedIndex].value);
  parentCommand("FontSize", selectObj.options[selectObj.selectedIndex].value);
}

var g_bInit = false;
function initOuterIFrame()
{
  if (!g_bInit)
  {
//    document.frames.editor_iframe.document.write(getFileContent('../../scripts/lbi/editortoolbar.lbi'));
    innerInterval = setInterval("initInnerIFrame()", 100);
    g_bInit = true;
  }
}

function initInnerIFrame()
{
    if (document.frames.editor_iframe.document.editor_iframe)
    {
        clearInterval(innerInterval);
    }
    else
    {
        return;
    }
    outerdoc = document.frames.editor_iframe.document;
    iframe = outerdoc.frames.editor_iframe;
    editor = iframe.document;

    var initValue;
    if (privateMessage)
    {
        initValue = document.message.msg_body_html.value;
    }
    else
    {
        initValue = document.post.msg_html.value;
    }
//   editor.write(getFileContent('../../scripts/lbi/editorinit.lbi').replace("<%=initValue%>",initValue));
    iframe.setContent(initValue);

    post = editor.all.post;

    tbInterval = setInterval("toolbarInit()", 100);

    if (privateMessage) {
        document.message.onsubmit = retrieveHTML;
    }
    else {
        document.post.onsubmit = retrieveHTML;
    }
    pressedInterval = setInterval("calcPressed()", 300);
}

function press (button, image)
{ // Takes a span from the outer iframe and "presses" it.
  button.isPressed = true;
  button.className = "menu_item_mouseoverdown";
  image.className  = "icon_down";
}

function unpress (button, image)
{ // Takes one of the spans from the editor_iframe page and unpresses the button
  button.isPressed = false;
  button.className = "tb_menu_item";
  image.className  = "tb_icon";
}

function disable (button)
{ // Disables a span
  button.className  = "tb_menu_item";
  button.disabled = true;
  //button.style.filter = "progid:DXImageTransform.Microsoft.Alpha(style=0, opacity=25)";
}

function enable (button)
{ // Enables a span
  button.disabled = false;
  button.style.filter = null;
}

var pressLoopInit = false;
var pressButtons = {};
var pressLoop = [];
function calcPressed ()
{
    var sel = editor.selection.createRange();

    if (!pressLoopInit) {
        pressLoop[pressLoop.length] = 'Bold';
        pressButtons['Bold'] = [outerdoc.all.bold, outerdoc.all.boldImage];

        pressLoop[pressLoop.length] = 'Italic';
        pressButtons['Italic'] = [outerdoc.all.italic, outerdoc.all.italicImage];

        pressLoop[pressLoop.length] = 'Underline';
        pressButtons['Underline'] = [outerdoc.all.underline, outerdoc.all.underlineImage];

        pressLoop[pressLoop.length] = 'JustifyLeft';
        pressButtons['JustifyLeft'] = [outerdoc.all.jleft, outerdoc.all.jleftImage];

        pressLoop[pressLoop.length] = 'JustifyCenter';
        pressButtons['JustifyCenter'] = [outerdoc.all.jcenter, outerdoc.all.jcenterImage];

        pressLoop[pressLoop.length] = 'JustifyRight';
        pressButtons['JustifyRight'] = [outerdoc.all.jright, outerdoc.all.jrightImage];

        pressLoop[pressLoop.length] = 'InsertOrderedList';
        pressButtons['InsertOrderedList'] = [outerdoc.all.ol, outerdoc.all.olImage];

        pressLoop[pressLoop.length] = 'InsertUnorderedList';
        pressButtons['InsertUnorderedList'] = [outerdoc.all.ul, outerdoc.all.ulImage];

        pressLoopInit = true;
    }

    for (var i = 0; i < pressLoop.length; i++) {
        var pressed = sel.queryCommandValue(pressLoop[i]);
        var span  = pressButtons[pressLoop[i]][0];
        var image = pressButtons[pressLoop[i]][1];

        if      (pressed && !span.isPressed)   press(span, image);
        else if (!pressed && span.isPressed) unpress(span, image);
        else if (span.isPressed == null) span.isPressed = false;
    }

    var cutable  = false;
    var copyable = false;
    var pastable = false;
    try {
        cutable  = sel.queryCommandEnabled('Cut');
        copyable = sel.queryCommandEnabled('Copy');
        pastable = sel.queryCommandEnabled('Paste');
    } catch (e) { }
    var linkable = (sel.htmlText != '' && sel.htmlText != '\n<P>&nbsp;</P>');

    if      ( cutable  &&  outerdoc.all.cut.disabled  ) enable (outerdoc.all.cut  );
    else if (!cutable  && !outerdoc.all.cut.disabled  ) disable(outerdoc.all.cut  );
    if      ( copyable &&  outerdoc.all.copy.disabled ) enable (outerdoc.all.copy );
    else if (!copyable && !outerdoc.all.copy.disabled ) disable(outerdoc.all.copy );
    if      ( pastable &&  outerdoc.all.paste.disabled) enable (outerdoc.all.paste);
    else if (!pastable && !outerdoc.all.paste.disabled) disable(outerdoc.all.paste);
    if      ( linkable &&  outerdoc.all.link.disabled ) enable (outerdoc.all.link );
    else if (!linkable && !outerdoc.all.link.disabled ) disable(outerdoc.all.link );
}

function retrieveHTML ()
{
  if (privateMessage) {
          document.message.msg_body.value = post.innerHTML;
  }
  else {
          document.post.msg.value = post.innerHTML;
  }
}

function command (cmd) {
	iframe.focus();
	try {
		editor.execCommand(cmd);
	} catch (e) { }
	iframe.focus();
}

function addTag (face) {
	iframe.focus();
	editor.selection.createRange().pasteHTML('<img src="' + Faces[face] + '">');
	iframe.focus();
}

function updateTab (selected_val) {
	var col = document.getElementsByName("post_icon");
	for (i = 0; i < col.length; i++) {
		if (selected_val == col[i].value)
			col[i].tabIndex = 5;
		else
			col[i].tabIndex = 0;
	}
}

// This is called for things like [quote]...[/quote] - they should surround the selected text.
function surroundTag (start, end) {
	iframe.focus();
	var selection = editor.selection.createRange();
	selection.pasteHTML(start + selection.htmlText + end);
	iframe.focus();
}

// This is called for tags like [smile] - it replaces any selected text
function insertTag (tag) {
	iframe.focus();
	var selection = editor.selection.createRange();
	selection.pasteHTML(tag);
	iframe.focus();
}



function insertCode () {
	var sel = editor.selection.createRange();
	surroundTag('<span contenteditable=\"false\"><table border=0 cellpadding=0 cellspacing=0 width=\"100%\"><!--code--><tr><td width=\"2%\"><hr width=\"100%\" noshade size=\"1\" color=\"#A1A576\"><\/td><td width=\"5%\" align=center><font size=1 face=\"Verdana,Arial,Helvetica\">Code<\/font><\/td><td width=\"93%\"><hr width=\"100%\" noshade color=\"#A1A576\" size=1><\/td><\/tr><\/table><\/span><div style=\"margin-left: 30px\"><pre><big>'  + ((sel.htmlText == '' || sel.htmlText == '\n<P>&nbsp;</P>') ? '<br>' : ''), '<\/big><\/pre><\/div><span contenteditable=\"false\"><table border=0 cellpadding=0 cellspacing=0 width=\"100%\"><!--\/code--><tr><td><hr width=\"100%\" noshade size=1 color=\"#A1A576\"><\/td><\/tr><\/table><\/span>' );
}
function insertReply () {
	var sel = editor.selection.createRange();
	surroundTag('<span contenteditable=\"false\"><table border=0 cellpadding=0 cellspacing=0 width=\"100%\"><!--reply--><tr><td width=\"2%\"><hr width=\"100%\" noshade size=\"1\" color=\"#A1A576\"><\/td><td width=\"10%\" align=center><font size=1 face=\"Verdana,Arial,Helvetica\">In&nbsp;Reply&nbsp;To<\/font><\/td><td width=\"87%\"><hr width=\"100%\" noshade color=\"#A1A576\" size=1><\/td><\/tr><\/table><\/span><div style=\"margin-left: 30px\">' + ((sel.htmlText == '' || sel.htmlText == '\n<P>&nbsp;</P>') ? '<br>' : ''), '<\/div><span contenteditable=\"false\"><table border=0 cellpadding=0 cellspacing=0 width=\"100%\"><!--\/reply--><tr><td><hr width=\"100%\" noshade size=1 color=\"#A1A576\"><\/td><\/tr><\/table><\/span>');
}
function insertQuote () {
	var sel = editor.selection.createRange();
	surroundTag('<span contenteditable=\"false\"><table border=0 cellpadding=0 cellspacing=0 width=\"100%\"><!--quote--><tr><td width=\"2%\"><hr width=\"100%\" noshade size=\"1\" color=\"#A1A576\"><\/td><td width=\"6%\" align=center><font size=1 face=\"Verdana,Arial,Helvetica\">Quote<\/font><\/td><td width=\"92%\"><hr width=\"100%\" noshade color=\"#A1A576\" size=1><\/td><\/tr><\/table><\/span><div style=\"margin-left: 30px\">' + ((sel.htmlText == '' || sel.htmlText == '\n<P>&nbsp;</P>') ? '<br>' : ''), '<\/div><span contenteditable=\"false\"><table border=0 cellpadding=0 cellspacing=0 width=\"100%\"><!--\/quote--><tr><td><hr width=\"100%\" noshade size=1 color=\"#A1A576\"><\/td><\/tr><\/table><\/span>');
}

function imageDialog () {
    var imageSrc = showModalDialog(url + ';do=editor_image', null, "dialogHeight: 135px; dialogWidth: 435px; scroll: no; help: no; status: no");
    if (imageSrc) {
        iframe.focus();
        editor.execCommand('InsertImage', false, imageSrc);
    }
    iframe.focus();
}

function linkDialog () {
    var sel = editor.selection.createRange();
    if (sel.htmlText == '' || sel.htmlText == '\n<P>&nbsp;</P>') return;

    iframe.focus();
    setTimeout("editor.execCommand('CreateLink', true); iframe.focus();", 100);
}

function fontDialog () {
    var sel = editor.selection.createRange();
    var font = sel.queryCommandValue('FontName');
    var size = sel.queryCommandValue('FontSize');
    var color = sel.queryCommandValue('ForeColor');
    var bold = sel.queryCommandValue('Bold');
    var italic = sel.queryCommandValue('Italic');
    var underline = sel.queryCommandValue('Underline');
    var args = [font, size, color, bold, italic, underline];

    // ret is an array, just like args: [font, size, color, b, i, u]
    var ret = showModalDialog(url + ';do=editor_font', args, "dialogHeight: 332px; dialogWidth: 442px; scroll: no; help: no; status: no");

    if (ret) {
        var applyTo;
        if (sel.htmlText.length == 0 || sel.htmlText == '\n<P>&nbsp;</P>')
            applyTo = editor;
        else
            applyTo = sel;
        if (ret[0]) applyTo.execCommand('FontName', false, ret[0]);
        if (ret[1]) applyTo.execCommand('FontSize', false, ret[1]);
        if (ret[2]) applyTo.execCommand('ForeColor', false, ret[2]);
        if (ret[3] != null && ((ret[3] && !bold) || (!ret[3] && bold))) // Toggle bold if bold was on and is now off or if bold was off and is now on
            applyTo.execCommand('Bold');
        if (ret[4] != null && ((ret[4] && !italic) || (!ret[4] && italic))) // Toggle italics if it was on and is now off or if it was off and is now on
            applyTo.execCommand('Italic');
        if (ret[5] != null && ((ret[5] && !underline) || (!ret[5] && underline))) // Toggle underline if it was on and is now off or if it was off and is now on
            applyTo.execCommand('Underline');
    }
    //iframe.focus();
}

function colorDialog (type) {

	if (type==1)
       setTimeout("IE6Color('ForeColor'); iframe.focus()");
	else
	   setTimeout("IE6Color('BackColor'); iframe.focus()");
}

function IE6Color (fontColor) {
    var color = document.all.dlg.ChooseColorDlg();

    var hexColor = color.toString(16);
    if (hexColor.length < 6) hexColor = "000000".substring(0, 6 - hexColor.length) + hexColor;

    editor.execCommand(fontColor, true, hexColor);
}


/* -- Toolbar initialization is below -- */


var initInterval, toolbars, tb;
// Keep track of number of images loaded.
//var imagesLoaded = 0;

function toolbarInit () {
/* ---------------------------------------------------------
 * Should be called after the outerdoc has loaded.
 * Initializes the Toolbar for display.
 */
    // 'toolbars' contains all the div tags
	var tbs = outerdoc.body.all.tags("DIV");

    // There are 3 <div>'s. If another is ever added, this number should be incremented.
    if (tbs.length < 3)
        return;
    else
        clearInterval(tbInterval);

    initialized = true;

    tb = {};
    toolbars = [];
    document.all.editor_iframe.style.visibility = 'visible';
// Go through the outerdoc and get the toolbar classes
	for (var i = 0; i < tbs.length; i++) {
		var toolbar = tbs[i];

		tb[toolbar.title] = toolbar;
		toolbars[toolbars.length] = toolbar;

		toolbar.TB_INDEX  = toolbars.length;

// Initialize the toolbar
        tb_init(toolbar);
	}

	tb_layout();

// If the window is resized we need to re-layout the
// toolbar.
	toolbar_init = true;
}

function tb_init (toolbar) {
/* ---------------------------------------------------------
 * Called for each toolbar DIV. Populates the toolbar and
 * sets the width.
 */
	toolbar.TBWidth = 0;
	tb_populate(toolbar);
	toolbar.style.posWidth = toolbar.TBWidth;
	return true;
}

function tb_populate (toolbar) {
/* ---------------------------------------------------------
 * Moves all of toolbar 'toolbar's icons to the proper location on
 * the screen and sets the correct size for the toolbars.
 */

	var elements = toolbar.children;
	if (!elements) return;

// Loop through all the toolbars children.
	for (var i = 0; i < elements.length; i++) {
		var element = elements[i];
		if (element.tagName == "SCRIPT" || element.tagName == "!") continue;

// Switch to see what element we are workin with.
		switch (element.className) {
			case "tb_menu_item": // A button
				if (element.INITIALIZED == null)
                    tb_init_button(element)
				element.style.posLeft = toolbar.TBWidth;
				toolbar.TBWidth += element.offsetWidth + 1;
				break;

			case "tb_general": // Not a button - most likely a form field

			case "tb_menu_text":
				element.style.posLeft = toolbar.TBWidth;
				toolbar.TBWidth += element.offsetWidth + 5;
				break;

			case "tb_sep": // Seperator
				element.style.posLeft = toolbar.TBWidth + 2;
				toolbar.TBWidth += 5;
				break;

			case "tb_handle": // Toolbar handle
				element.style.posLeft = 2;
				toolbar.TBWidth += element.offsetWidth + 7;
				break;

			default: // Should never get here unless the html is messed
		}
	}

	toolbar.TBWidth++; // Add 1 in case the width is zero
	return true;
}

function tb_init_button (element) {
/* ---------------------------------------------------------
 * Sets op all the defaults for a button DIV. Saves any
 * onclick and detaches the event. OnClick events are called
 * onMouseDown.
 */
	if (element.className == "tb_general") return true;

// Set events
	element.onmouseover   = tb_mouseover;
	element.onmouseout    = tb_mouseout;
	element.onmousedown   = tb_mousedown;
	element.onmouseup     = tb_mouseup;

// Disable events
	element.ondragstart   = cancel_event;
	element.onselectstart = cancel_event;
	element.onselect      = cancel_event;

// Save onClick event for onMouseDown
	element.YUSERONCLICK  = element.onclick;
	element.onclick       = cancel_event;

// So we don't re-initialize
	element.INITIALIZED  = true;

	return true;
}

function tb_layout () {
/* ---------------------------------------------------------
 * Layouts the toolbar on the screen based on the screen
 * width and the widths built in tb_populate().
 */

    if (!initialized)
        toolbarInit();

	var num_tb = toolbars.length;

// No toolbars
	if (num_tb == 0) return;
	var i;

// Get the screen width minus the width of the scrollbar
	var sbar = outerdoc.body.offsetWidth - outerdoc.body.clientWidth;
	var ScrWid = (outerdoc.body.offsetWidth  - sbar);
	var ScrHit = (outerdoc.body.offsetHeight - sbar);

// Go through the toolbars and find the width of the widest
// one.
	var TotalLen = ScrWid;
	var tb = [];
	var e = 0;
	for (i = 0; i < num_tb; i++) {
		tb[e] = toolbars[i];
		if (tb[e].TBWidth > TotalLen) TotalLen = tb[e].TBWidth;
		e++;
	}
	e--;
	if (!tb.length) { return; }
	var PrevTB;
	var LastStart = 0;
	var RelTop = 0;
	var LastWid, CurrWid;

// Position the top toolbar to the top of the screen
	var TB           = tb[0];
	TB.style.posTop  = 0;
	TB.style.posLeft = 0;
	var rows         = 1;

// Go through the toolbars and update there width
// and position.
	var Start = TB.TBWidth;
	for (i = 1; i < tb.length; i++) {
		PrevTB = TB;
		TB = tb[i];
		CurrWid = TB.TBWidth;

// Reached the end of the screen, reset to the start
		if ((Start + CurrWid) > ScrWid) {
			Start = 0;
			rows++;
			LastWid = TotalLen - LastStart;
		}
		else {
			LastWid = PrevTB.TBWidth;
			RelTop -= TB.offsetHeight;
		}

		TB.style.posTop = RelTop;
		TB.style.posLeft = Start;
		PrevTB.style.width = LastWid;

		LastStart = Start;
		Start    += CurrWid;

	}
	outerdoc.all.editor_iframe.style.posTop     = rows * 25;
	outerdoc.all.editor_iframe.style.posHeight  = ScrHit - (rows * 25);
	outerdoc.all.editor_iframe.style.posWidth   = ScrWid;
	outerdoc.all.editor_iframe.style.visibility = 'visible';

// Set the total width
	TB.style.width = TotalLen - LastStart;

// Move the rest of the toolbars down
	TB = tb[--i];
	var TBInd = TB.sourceIndex;
	var A = TB.document.all;
	for (var i in A) {
		var item = A.item(i);
		if (item && item.style && item.sourceIndex > TBInd && tb[item.title])
		    item.style.posTop = RelTop;
	}
}

function tb_mouseover () {
/* ---------------------------------------------------------
 * OnMouseOver event handler function for toolbar buttons.
 */
 // Source must be an image
    var event = document.frames.editor_iframe.event;
	if (event.srcElement.tagName != "IMG") return cancel_event(event);
	var image   = event.srcElement;
	var element = image.parentElement;

// If we are in text mode and the button is disables for
// text mode. cancel the mouseover.
	if (element.disabled) return cancel_event(event);

// If the image in normal state put it in mouseover state
	if (image.className == "tb_icon") {
		element.className = "menu_item_mouseoverup";
	}
// else if it is in down state put it in mouseover
// for down states.
	else if (image.className == "icon_down") {
		element.className = "menu_item_mouseoverdown";
	}

	return cancel_event(event);
}

function tb_mouseout () {
/* ---------------------------------------------------------
 * MouseOut event handler function for toolbar buttons
 */
 // The source tag must be an image.
    var event = document.frames.editor_iframe.event;
	if (event.srcElement.tagName != "IMG") return cancel_event(event);
	var image   = event.srcElement;
	var element = image.parentElement;

	if (element.disabled) return cancel_event(event);

// If the button is a toggle update it's state.
    if (element.isPressed) {
		element.className = "menu_item_mouseoverdown"
		image.className   = 'icon_down';
	}
// else put the image back to it's normal state.
	else {
	    element.className  = "tb_menu_item";
	    image.className    = "tb_icon";
	}

    return cancel_event(event);
}

function tb_mousedown () {
/* ---------------------------------------------------------
 * MouseDown event handler for toolbar buttons.
 */

 // The source tag must be an image.
    var evnt = document.frames.editor_iframe.event;
	if (evnt.srcElement.tagName != "IMG") return cancel_event(evnt);
	var image   = evnt.srcElement;
	var element = image.parentElement;

// If we are in "text mode" and the button is not supported in
// "text mode" cancel the event and return false.
	if (element.disabled) return cancel_event(evnt);

    if (element.isPressed != null && !element.isPressed)
        press(element, image);
	element.className = "menu_item_mouseoverdown";
	image.className   = "icon_down";

// We disabled the click function and saved it in this.
// Eval it here and run it.

	if (element.YUSERONCLICK) eval(element.YUSERONCLICK + "anonymous()");
	return cancel_event(evnt);
}

function tb_mouseup () {
/* ---------------------------------------------------------
 * MouseUp event handler function for toolbar buttons.
 */
 // The source element must be an image type.
    var event = document.frames.editor_iframe.event;
    if (event.srcElement.tagName != "IMG") return cancel_event(event);
    var image   = event.srcElement;
    var element = image.parentElement;

// If we are in "text mode" and the field is disabled in that
// mode return and cancel the event.
    if (element.disabled) return cancel_event(event);

// It the icons to the mouseUp state.
    element.className = "menu_item_mouseoverup";
    image.className   = "tb_icon";

// Refocus the compose window here.
    iframe.focus();

    return cancel_event(event);
}

function cancel_event (evnt) {
/* ---------------------------------------------------------
 * General function to cancel an event.
 */
    if (!evnt) evnt = event;
    if (!evnt) return false;
    evnt.returnValue  = false;
    evnt.cancelBubble = true;
    if (event) {
        event.returnValue  = false;
        event.cancelBubble = true;
    }
    return false;
}
function getFileContent(filename)
{
  objHttp = new ActiveXObject("Microsoft.XMLHTTP");
  objHttp.open("GET", filename, false);
  objHttp.send();
  strDoc = objHttp.responseText;
  return strDoc;
}
function resize(option)
{
  if (option=="increase")
    document.all.editor_iframe.height = parseInt(document.all.editor_iframe.height)+12;
  else if (option=="decrease" && document.all.editor_iframe.height>=100)
    document.all.editor_iframe.height = parseInt(document.all.editor_iframe.height)-12;

  toolbarInit ();
  tb_layout();
}

