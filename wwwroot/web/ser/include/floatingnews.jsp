<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%
{
    BasicWeb web = new BasicWeb(session, null);
//    ConfigInfo cfInfo = web.getConfigInfo();
//System.out.println("cfInfo=" + cfInfo.NewsArea);

%>
<script type="text/javascript">
var ns4=document.layers
var ie4=document.all
var ns6=document.getElementById&&!document.all
//drag drop function for NS 4////
/////////////////////////////////
var dragswitch=0
var nsx
var nsy
var nstemp
document.onmouseup=new Function("dragapproved=false")
function initializedrag(e)
{
	crossobj=ns6? document.getElementById("showimage") : document.all.showimage
	var firedobj=ns6? e.target : event.srcElement
	var topelement=ns6? "html" : document.compatMode && document.compatMode!="BackCompat"? "documentElement" : "body"
	while (firedobj.tagName!=topelement.toUpperCase() && firedobj.id!="dragbar"){
	firedobj=ns6? firedobj.parentNode : firedobj.parentElement
	}

	if (firedobj.id=="dragbar"){
	offsetx=ie4? event.clientX : e.clientX
	offsety=ie4? event.clientY : e.clientY

	tempx=parseInt(crossobj.style.left)
	tempy=parseInt(crossobj.style.top)

	dragapproved=true
	document.onmousemove=drag_drop
	}
}

function drag_dropns(name)
{
	if (!ns4)
	  return
	temp=eval(name)
	temp.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP)
	temp.onmousedown=gons
	temp.onmousemove=dragns
	temp.onmouseup=stopns
}

function gons(e)
{
	temp.captureEvents(Event.MOUSEMOVE)
	nsx=e.x
	nsy=e.y
}

function dragns(e)
{
	if (dragswitch==1){
	temp.moveBy(e.x-nsx,e.y-nsy)
	return false
	}
}

function stopns()
{
	temp.releaseEvents(Event.MOUSEMOVE)
}

//drag drop function for ie4+ and NS6////
/////////////////////////////////
function drag_drop(e)
{
	if (ie4&&dragapproved){
	crossobj.style.left=tempx+event.clientX-offsetx
	crossobj.style.top=tempy+event.clientY-offsety
	return false
	}
	else if (ns6&&dragapproved)
	{
	crossobj.style.left=tempx+e.clientX-offsetx+"px"
	crossobj.style.top=tempy+e.clientY-offsety+"px"
	return false
	}
}
////drag drop functions end here//////
function hidebox()
{
	crossobj=ns6? document.getElementById("showimage") : document.all.showimage
	if (ie4||ns6)
	crossobj.style.visibility="hidden"
	else if (ns4)
	document.showimage.visibility="hide"
}
</script>
<div id="showimage" style="position:absolute;width:400px;left:400px;top:120px">
<table border="0" width="360" bgcolor="#000080" cellspacing="0" cellpadding="2">
<tr>
<td width="100%">
 <table border="0" width="100%" cellspacing="0" cellpadding="0">
  <tr>
   <td id="dragbar" style="cursor:hand; cursor:pointer" width="100%" height="22" onMousedown="initializedrag(event);" align="center">
    <ilayer width="100%" onSelectStart="return false"><layer width="100%" onMouseover="dragswitch=1;if (ns4) drag_dropns(showimage)"
    onMouseout="dragswitch=0"><font face="Verdana" color="#FFFFFF" size="3"><strong><%=mcBean.getWebPageTitleByPageId(cfInfo.MemberID, cfInfo.NewsAreaID)%></strong></font></layer></ilayer>
   </td>
   <td style="cursor:hand"><a href="#" onClick="hidebox();return false"><img src="/staticfile/web/images/close.gif" width="16px" height="14px" border=0></a></td>
  </tr>
  <tr>
	<td width="100%" bgcolor="#FFFFFF" style="padding:4px" colspan="2" valign="top">
   <%@ include file="newscontent.jsp"%>
    </td>
   </tr>
  </table>
 </td>
</tr>
</table>
</div>
<% } %>
