/**************************************************
 * dom-drag.js
 * 09.25.2001
 * www.youngpup.net
 * Script featured on Dynamic Drive (http://www.dynamicdrive.com) 12.08.2005
 **************************************************
 * 10.28.2001 - fixed minor bug where events
 * sometimes fired off the handle, not the root.
 **************************************************/

var Drag = {

	obj : null,

	init : function(o, minX, maxX, minY, maxY, rootId, sUrl, bSwapHorzRef, bSwapVertRef, fXMapper, fYMapper)
	{
		o.onmousedown	= Drag.start;

		o.hmode			= bSwapHorzRef ? false : true;
		o.vmode			= bSwapVertRef ? false : true;

        o.root = o;//oRoot && oRoot != null ? oRoot : o ;
//        o.objAction = objAction && objAction != null ? objAction : o
        o.rootId = rootId;
        o.sUrl = sUrl;
        o.moveway = 0;
        if (minY==0 && maxY==0)
           o.moveway = 1;
        else if (minX==0 && maxX==0)
           o.moveway = 2;

        if (o.hmode  && isNaN(parseInt(o.root.style.left  ))) o.root.style.left   = "0px";
		if (o.vmode  && isNaN(parseInt(o.root.style.top   ))) o.root.style.top    = "0px";
		if (!o.hmode && isNaN(parseInt(o.root.style.right ))) o.root.style.right  = "0px";
		if (!o.vmode && isNaN(parseInt(o.root.style.bottom))) o.root.style.bottom = "0px";

		o.minX	= typeof minX != 'undefined' ? minX : null;
		o.minY	= typeof minY != 'undefined' ? minY : null;
		o.maxX	= typeof maxX != 'undefined' ? maxX : null;
		o.maxY	= typeof maxY != 'undefined' ? maxY : null;

		o.xMapper = fXMapper ? fXMapper : null;
		o.yMapper = fYMapper ? fYMapper : null;
	},

	start : function(e)
	{
		var o = Drag.obj = this;
		e = Drag.fixE(e);
		var y = parseInt(o.vmode ? o.root.style.top  : o.root.style.bottom);
		var x = parseInt(o.hmode ? o.root.style.left : o.root.style.right );

//		o.objAction.onDragStart(o, x, y);
   		Drag.onDragStart(o, x, y);

		o.lastMouseX	= e.clientX;
		o.lastMouseY	= e.clientY;

		if (o.hmode) {
			if (o.minX != null)	o.minMouseX	= e.clientX - x + o.minX;
			if (o.maxX != null)	o.maxMouseX	= o.minMouseX + o.maxX - o.minX;
		} else {
			if (o.minX != null) o.maxMouseX = -o.minX + e.clientX + x;
			if (o.maxX != null) o.minMouseX = -o.maxX + e.clientX + x;
		}

		if (o.vmode) {
			if (o.minY != null)	o.minMouseY	= e.clientY - y + o.minY;
			if (o.maxY != null)	o.maxMouseY	= o.minMouseY + o.maxY - o.minY;
		} else {
			if (o.minY != null) o.maxMouseY = -o.minY + e.clientY + y;
			if (o.maxY != null) o.minMouseY = -o.maxY + e.clientY + y;
		}

		document.onmousemove	= Drag.drag;
		document.onmouseup		= Drag.end;

		return false;
	},

	drag : function(e)
	{
		e = Drag.fixE(e);
		var o = Drag.obj;

		var ey	= e.clientY;
		var ex	= e.clientX;
		var y = parseInt(o.vmode ? o.root.style.top  : o.root.style.bottom);
		var x = parseInt(o.hmode ? o.root.style.left : o.root.style.right );
		var nx, ny;

		if (o.minX != null) ex = o.hmode ? Math.max(ex, o.minMouseX) : Math.min(ex, o.maxMouseX);
		if (o.maxX != null) ex = o.hmode ? Math.min(ex, o.maxMouseX) : Math.max(ex, o.minMouseX);
		if (o.minY != null) ey = o.vmode ? Math.max(ey, o.minMouseY) : Math.min(ey, o.maxMouseY);
		if (o.maxY != null) ey = o.vmode ? Math.min(ey, o.maxMouseY) : Math.max(ey, o.minMouseY);

		nx = x + ((ex - o.lastMouseX) * (o.hmode ? 1 : -1));
		ny = y + ((ey - o.lastMouseY) * (o.vmode ? 1 : -1));

		if (o.xMapper)		nx = o.xMapper(y)
		else if (o.yMapper)	ny = o.yMapper(x)

		Drag.obj.root.style[o.hmode ? "left" : "right"] = nx + "px";
		Drag.obj.root.style[o.vmode ? "top" : "bottom"] = ny + "px";
		Drag.obj.lastMouseX	= ex;
		Drag.obj.lastMouseY	= ey;

//		Drag.obj.objAction.onDrag(o, nx, ny);
		Drag.onDrag(o, nx, ny);

		return false;
	},

	end : function()
	{
		document.onmousemove = null;
		document.onmouseup   = null;
//		Drag.obj.objAction.onDragEnd(Drag.obj, parseInt(Drag.obj.root.style[Drag.obj.hmode ? "left" : "right"]),
		Drag.onDragEnd(Drag.obj, parseInt(Drag.obj.root.style[Drag.obj.hmode ? "left" : "right"]), parseInt(Drag.obj.root.style[Drag.obj.vmode ? "top" : "bottom"]));
		Drag.obj = null;

        return false;
    },

	fixE : function(e)
	{
		if (typeof e == 'undefined') e = window.event;
		if (typeof e.layerX == 'undefined') e.layerX = e.offsetX;
		if (typeof e.layerY == 'undefined') e.layerY = e.offsetY;
		return e;
	} ,

    onDragStart : function(obj, x, y)
    {
      obj.style.cursor = "move";
    },

    onDrag : function(obj, x, y)
    {
       obj.style.cursor = "move";
    },

    onDragEnd : function(obj, x, y)
    {
       obj.style.cursor = "move";
       var refId;
       if (obj.moveway==1)
          refId = getHortPostion(obj, x, y);
       else
       {
          refId = getVertPostion(obj, x, y);
          x = y;
       }
        
//alert("refId=" + refId + ", x=" + x);
    //  obj.style.left = "0px";
       var nIndex = obj.id.indexOf("_");
       var sRefId = "";
       if (refId==null)
       {
         obj.style.left = "0px";
         if (obj.moveway==2 && (x>-2 && x<2) && (y>-2&&y<2))
         {
            if (!confirm("Do you want to remove it?"))
               return;
         }
         else
           return;

         x = 0;
//alert("objid=" + obj.id + "->" + obj.rootId);
       }
       else
         sRefId = refId.substring(nIndex+1);

       var sRequest = obj.sUrl + '&move='+x + '&refid=' + sRefId + '&moveid=' + obj.id.substring(nIndex+1) + "&time="+new Date().getTime();
//alert("sRequest-111=" + sRequest);
       var sContent = getUrlContent(sRequest);

       document.getElementById(obj.rootId).innerHTML = sContent;

       if (obj.moveway==1)
         initHortDrags(obj.rootId, obj.id.substring(0, nIndex+1), obj.sUrl, 1);
       else
         initVertDrags(obj.rootId, obj.id.substring(0, nIndex+1), obj.sUrl, 1);
     }
};

function onDelete(sName, sId)
{
   if (!confirm("Do you want to remove '"  + sName + "'?"))
     return;

   var objLink = document.getElementById(sId);
   var nIndex = objLink.id.indexOf("_");

//alert("obj_id=" + sId + "->" + objLink.rootId + "|" + objLink.sUrl);

   var sRequest = objLink.sUrl + '&move='+ 0 + '&refid=' + '' + '&moveid=' + objLink.id.substring(nIndex+1) + "&time="+new Date().getTime();
 //alert("sRequest-111=" + sRequest);
   var sContent = getUrlContent(sRequest);
   document.getElementById(objLink.rootId).innerHTML = sContent;

   if (objLink.moveway==1)
      initHortDrags(objLink.rootId, objLink.id.substring(0, nIndex+1), objLink.sUrl, 1);
   else
      initVertDrags(objLink.rootId, objLink.id.substring(0, nIndex+1), objLink.sUrl, 1);
}

function getTopLeft(what, offsettype)
{
    var totaloffset=(offsettype=="left")? what.offsetLeft : what.offsetTop;
    var parentEl=what.offsetParent;
    while (parentEl!=null)
    {
        totaloffset=(offsettype=="left")? totaloffset+parentEl.offsetLeft : totaloffset+parentEl.offsetTop;
        parentEl=parentEl.offsetParent;
    }
    return totaloffset;
}

function getBottomRight(what, offsettype)
{
   var offset = getTopLeft(what, offsettype=="right"?"left":"top");
   return (offsettype=="right")?(offset+what.offsetWidth) : (offset+what.offsetHeight);
}

function getWidthOrHeight(what, offsettype)
{
   return (offsettype=="right")?(what.offsetWidth) : (what.offsetHeight);
}

function initHortDrags(rootId, prefix, sUrl)
{
  var nMinLimit = 10000;
  var nMaxLimit = 0;
  var nCount = 0;
  for (var i=0; ;i++)
  {
    if (document.getElementById(prefix + i)==null)
       break;

    var nLeft = getTopLeft(document.getElementById(prefix + i), 'left');
    var nRight = getBottomRight(document.getElementById(prefix + i), 'right');

//alert("Left and Right=" + nLeft+"," + nRight);
    if (nMinLimit>nLeft)
       nMinLimit = nLeft;
    if (nMaxLimit<nRight)
       nMaxLimit = nRight;

    nCount++;
  }

//alert("" + nMinLimit + ", " + nMaxLimit);
//  objRoot = new Object();
  for (var i=0; ;i++)
  {
    if (document.getElementById(prefix+i)==null)
       break;

    var nLeft = getTopLeft(document.getElementById(prefix+i), 'left');
    var nLeftMove = (nMinLimit-nLeft);
    var nRightMove = (nMaxLimit-nLeft);
    if (i>0)
       nLeftMove -= getWidthOrHeight(document.getElementById(prefix+i), 'right')+10;
    if (i==nCount-1)
       nRightMove -= getWidthOrHeight(document.getElementById(prefix+i), 'right');
    else
       nRightMove += 10;

//alert("Can move from " + nLeft + " to " + nLeftMove + "," + nRightMove);
//    Drag.init(document.getElementById(prefix+i), null, nLeftMove, nRightMove, 0, 0, objRoot, sUrl);
    Drag.init(document.getElementById(prefix+i), nLeftMove, nRightMove, 0, 0, rootId, sUrl);
  }
}

function initVertDrags(rootId, prefix, sUrl)
{
  var nMinLimit = 10000;
  var nMaxLimit = 0;
  var nCount = 0;
  for (var i=0; ;i++)
  {
    if (document.getElementById(prefix + i)==null)
       break;

    var nTop = getTopLeft(document.getElementById(prefix + i), 'top');
    var nBottom = getBottomRight(document.getElementById(prefix + i), 'bottom');

//alert("Left and Right=" + nLeft+"," + nRight);
    if (nMinLimit>nTop)
       nMinLimit = nTop;
    if (nMaxLimit<nBottom)
       nMaxLimit = nBottom;

    nCount++;
  }

//alert("" + nMinLimit + ", " + nMaxLimit);
//  objRoot = new Object();
  for (i=0; ;i++)
  {
    if (document.getElementById(prefix+i)==null)
       break;

    var nTop = getTopLeft(document.getElementById(prefix+i), 'top');
    var nTopMove = (nMinLimit-nTop);
    var nBottomMove = (nMaxLimit-nTop);
    if (i>0)
       nTopMove -= getWidthOrHeight(document.getElementById(prefix+i), 'bottom');//+3;
    if (i==nCount-1)
       nBottomMove -= getWidthOrHeight(document.getElementById(prefix+i), 'bottom');
//    else
//       nBottomMove += 3;

//alert("Can move from " + nLeft + " to " + nLeftMove + "," + nRightMove);
//    Drag.init(document.getElementById(prefix+i), null, nLeftMove, nRightMove, 0, 0, objRoot, sUrl);
    Drag.init(document.getElementById(prefix+i), 0, 0, nTopMove, nBottomMove, rootId, sUrl);
  }
}

function getHortPostion(obj, x, y)
{
   var sId = obj.id;
   var nIndex = sId.indexOf("_");
   var prefix = sId.substring(0, nIndex+1);
   var nId = parseInt(sId.substring(nIndex+1));

   var nLeftMove = getTopLeft(obj, 'left');// + x;
   var nWidth = 0;//getWidthOrHeight(obj, 'right');

   var sLastId = null;
   if (x<=0)
   {
       for (i=nId-1; i>=0; i--)
       {
         if (document.getElementById(prefix+i)==null)
            break;

         var nLeft = getTopLeft(document.getElementById(prefix+i), 'left');
         if (nLeft>(nLeftMove+nWidth))
         {
            sLastId = document.getElementById(prefix+i).id;
         }
         else
           break;
       }
   }
   else
   {
        for (i=nId+1; ;i++)
        {
          if (document.getElementById(prefix+i)==null)
             break;

          var nRight = getTopLeft(document.getElementById(prefix+i), 'left') + getWidthOrHeight(document.getElementById(prefix+i), 'right');
          if (nRight<(nLeftMove+nWidth))
          {
             sLastId = document.getElementById(prefix+i).id;
          }
          else
            break;
        }
   }

   return sLastId;
}

function getVertPostion(obj, x, y)
{
   var sId = obj.id;
   var nIndex = sId.indexOf("_");
   var prefix = sId.substring(0, nIndex+1);
   var nId = parseInt(sId.substring(nIndex+1));

   var nTopMove = getTopLeft(obj, 'top');// + x;
   var nWidth = 0;//getWidthOrHeight(obj, 'right');

   var sLastId = null;
   if (x<=0)
   {
       for (i=nId-1; i>=0; i--)
       {
         if (document.getElementById(prefix+i)==null)
            break;

         var nTop = getTopLeft(document.getElementById(prefix+i), 'top');
         if (nTop>(nTopMove+nWidth))
         {
            sLastId = document.getElementById(prefix+i).id;
         }
         else
           break;
       }
   }
   else
   {
        for (i=nId+1; ;i++)
        {
          if (document.getElementById(prefix+i)==null)
             break;

          var nBottom = getTopLeft(document.getElementById(prefix+i), 'top') + getWidthOrHeight(document.getElementById(prefix+i), 'bottom');
          if (nBottom<(nTopMove+nWidth))
          {
             sLastId = document.getElementById(prefix+i).id;
          }
          else
            break;
        }
   }

   return sLastId;
}
