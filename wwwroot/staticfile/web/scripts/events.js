<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

//. Disable Right-Click Mouse
function clickIE4()
{
  if (event.button==2)
  { //alert(message);
    return false;
  }
}

function clickNS4(e)
{
    if (document.layers||document.getElementById&&!document.all)
    {
      if (e.which==2||e.which==3)
      {
            //alert(message);
            return false;
      }
    }
}

if (document.layers)
{
    document.captureEvents(Event.MOUSEDOWN);
    document.onmousedown=clickNS4;
}
else if (document.all&&!document.getElementById){
    document.onmousedown=clickIE4;
}
document.oncontextmenu= new Function("return false");

function showDown(evt)
{
/*
  evt = (evt) ? evt : ((event) ? event : null);
  if (evt)
  {
    if (evt.keyCode==8 && (evt.srcElement.type!="text" && evt.srcElement.type!="textarea" && evt.srcElement.type!="password"))
    {  // When backspace is pressed but not in form element
      cancelKey(evt);
    }
    else if (evt.keyCode==116)
    {// When F5 is pressed
      cancelKey(evt);
    }
    else if (evt.ctrlKey && (evt.keyCode==78||evt.keyCode==82))
    {// When ctrl is pressed with R or N
      cancelKey(evt);
    }
  }
*/
}

function cancelKey(evt)
{
  if (evt.preventDefault)
  {
     evt.preventDefault();
     return false;
  }
  else
  {
     evt.keyCode = 0;
     evt.returnValue = false;
  }
}

// Additional code for NS
if (navigator.appName=="Netscape")
{
  document.addEventListener("keypress",showDown,true);
}
document.onkeydown  = showDown;

/*
function mouseDown(e) {
 if (parseInt(navigator.appVersion)>3) {
  var clickType=1;
  if (navigator.appName=="Netscape") clickType=e.which;
  else clickType=event.button;
  if (clickType==1) self.status='Left button!';
  if (clickType!=1) self.status='Right button!';
 }
 return true;
}
function mouseDown2(e) {
 var ctrlPressed=0;
 var altPressed=0;
 var shiftPressed=0;
 if (parseInt(navigator.appVersion)>3) {
  if (navigator.appName=="Netscape") {
   var mString =(e.modifiers+32).toString(2).substring(3,6);
   shiftPressed=(mString.charAt(0)=="1");
   ctrlPressed =(mString.charAt(1)=="1");
   altPressed  =(mString.charAt(2)=="1");
   self.status="modifiers="+e.modifiers+" ("+mString+")"
  }
  else {
   shiftPressed=event.shiftKey;
   altPressed  =event.altKey;
   ctrlPressed =event.ctrlKey;
   self.status=""
    +  "shiftKey="+event.shiftKey
    +", altKey="  +event.altKey
    +", ctrlKey=" +event.ctrlKey
  }
  if (shiftPressed || altPressed || ctrlPressed)
   alert ("Mouse clicked with the following keys:\n"
    + (shiftPressed ? "Shift ":"")
    + (altPressed   ? "Alt "  :"")
    + (ctrlPressed  ? "Ctrl " :"")
   )
 }
 return true;
}

if (parseInt(navigator.appVersion)>3) {
 document.onmousedown = mouseDown;
 if (navigator.appName=="Netscape")
  document.captureEvents(Event.MOUSEDOWN);
}


ns4=(navigator.appName=="Netscape" && parseInt(navigator.appVersion)>3) ? true:false;
ie4=(navigator.appName!="Netscape" && parseInt(navigator.appVersion)>3) ? true:false;
serialN=0;

function handlerFoo(e) {
 if (parseInt(navigator.appVersion)>3) {
  evt = ns4 ? e:event;
  var str=''; for (var k in evt) {str+='event.'+k+'='+evt[k]+'\n'}

  if (''+evt.type==''+self.document.f1.s1.options[self.document.f1.s1.selectedIndex].value) self.document.f1.t1.value=str;
  if (''+evt.type==''+self.document.f2.s2.options[self.document.f2.s2.selectedIndex].value) self.document.f2.t2.value=str;

  self.status='Number of events handled: '+serialN;
  serialN++;
 }
 return true;
}

if (parseInt(navigator.appVersion)>3) {
 document.onmousedown=handlerFoo;
 document.onmouseup=handlerFoo;
 document.onmouseover=handlerFoo;
 document.onmouseout=handlerFoo;
 document.onmousemove=handlerFoo;
 document.onclick=handlerFoo;
 if (navigator.appName=="Netscape") {
  document.captureEvents(
   Event.MOUSEDOWN |
   Event.MOUSEUP |
   Event.MOUSEMOVE |
   Event.MOUSEOVER |
   Event.MOUSEOUT |
   Event.CLICK
  )
 }
}

if (navigator.appName=="Netscape") {
 document.write (
   'To bookmark this site, click '
  +'<b>Bookmarks | Add bookmark</b> '
  +'or press <b>Ctrl+D</b>.'
 )
}
else if (parseInt(navigator.appVersion)>3) {
 document.write (''
  +'<a onMouseOver="self.status=\'Bookmark this site\'" '
  +' onMouseOut="self.status=\'\'" '
  +' href="javascript:window.external.AddFavorite'
  +'(\'http://www.JavaScripter.net/faq/\','
  +'\'JavaScripter.net FAQ\')">'
  +'Click here to bookmark this site</a>.'
 )
}

<script type="text/javascript">

function handleEnter (field, event) {
                var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
                if (keyCode == 13) {
                        var i;
                        for (i = 0; i < field.form.elements.length; i++)
                                if (field == field.form.elements[i])
                                        break;
                        i = (i + 1) % field.form.elements.length;
                        field.form.elements[i].focus();
                        return false;
                }
                else
                return true;
        }

</script>
<form>
<input type="text" onkeypress="return handleEnter(this, event)"><br>
<input type="text" onkeypress="return handleEnter(this, event)"><br>
<textarea>Some text</textarea>
</form>

// Short Cut Key
var RQ_SHIFT_KEYCODE = 16; var RQ_CTRL_KEYCODE = 17; var RQ_ALT_KEYCODE = 18;
var RQ_SHIFT = "shift"; var RQ_CTRL = "ctrl"; var RQ_ALT = "alt"; rq_keyevt.count=0;
function rq_keyevt(elm) {
        this.id = "keyevt"+rq_keyevt.count++; eval(this.id + "=this");
        this.keys = new Array(); this.shift=0; this.ctrl=0; this.alt=0;
        this.addKey         = rq_addKey;
        this.keyevent       = rq_keyevent;
        this.checkModKeys   = rq_checkModKeys;
}
function rq_addKey(cdom,cns4,a,m) {this.keys[cdom] = [a,m];}
var RQ_COUNT=0;
function rq_keyevent(evt) {
        evt=event; var k = evt.keyCode;
        this.checkModKeys(evt,k);
        if (this.keys[k]==null) return false;
        var m = this.keys[k][1];
        if ((this.shift && (m.indexOf(RQ_SHIFT) != -1) || !this.shift && (m.indexOf(RQ_SHIFT) == -1)) && (this.ctrl && (m.indexOf(RQ_CTRL) != -1) || !this.ctrl && (m.indexOf(RQ_CTRL) == -1)) && (this.alt && (m.indexOf("alt") != -1) || !this.alt && (m.indexOf("alt") == -1))) {
                var a = this.keys[k][0]; a = eval(a);
                if(typeof a == "function") a();
        }
}
function rq_checkModKeys(e,k){this.shift = e.shiftKey;this.ctrl = e.ctrlKey;this.alt = e.altKey;}
function initKey(){document.onkeydown = function(evt) { oKey.keyevent(evt);}}
var oKey = new rq_keyevt();
*/

/*
document.onmousemove = mouseMove;
document.onmouseup   = mouseUp;

var dragObject  = null;
var mouseOffset = null;

function getMouseOffset(target, ev){
        ev = ev || window.event;

        var docPos    = getPosition(target);
        var mousePos  = mouseCoords(ev);
        return {x:mousePos.x - docPos.x, y:mousePos.y - docPos.y};
}

function getPosition(e){
        var left = 0;
        var top  = 0;

        while (e.offsetParent){
                left += e.offsetLeft;
                top  += e.offsetTop;
                e     = e.offsetParent;
        }

        left += e.offsetLeft;
        top  += e.offsetTop;

        return {x:left, y:top};
}

function mouseMove(ev){
        ev           = ev || window.event;
        var mousePos = mouseCoords(ev);

        if(dragObject){
                dragObject.style.position = 'absolute';
                dragObject.style.top      = mousePos.y - mouseOffset.y;
                dragObject.style.left     = mousePos.x - mouseOffset.x;

                return false;
        }
}
function mouseUp(){
        dragObject = null;
}

function makeDraggable(item){
        if(!item) return;
        item.onmousedown = function(ev){
                dragObject  = this;
                mouseOffset = getMouseOffset(this, ev);
                return false;
        }
}
*/
/*
function getXMLHttpObj(){
        if(typeof(XMLHttpRequest)!='undefined')
                return new XMLHttpRequest();

        var axO=['Msxml2.XMLHTTP.6.0', 'Msxml2.XMLHTTP.4.0',
                'Msxml2.XMLHTTP.3.0', 'Msxml2.XMLHTTP', 'Microsoft.XMLHTTP'], i;
        for(i=0;i<axO.length;i++)
                try{
                        return new ActiveXObject(axO[i]);
                }catch(e){}
        return null;
}
*/
