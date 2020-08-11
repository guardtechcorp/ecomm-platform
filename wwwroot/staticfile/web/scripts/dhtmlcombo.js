var combozindex=100
function dhtmlselect(selectid, selectwidth, optionwidth, pos,uri)
{
    var combodropimage='/staticfile/web/css/media/arrow-down.gif'
	if (pos=="side")
	{
	   combodropimage='/staticfile/web/css/media/arrow-right.gif'
	}
    if (combodropimage!="")
	   combodropimage='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img class1="downimage" src="'+combodropimage+'" title="Select an option" />'


	var selectbox=document.getElementById(selectid)
	document.write('<div id="dhtml_'+selectid+'" class="dhtmlselect"><b>'+selectbox.title+combodropimage+'</b><div class="dropdown">')
	for (var i=0; i<selectbox.options.length; i++)
	{
        var sMore = '';
		var sOnClick = 'onClick="' + selectbox.options[i].getAttribute('message') + '"';
        if (sOnClick.length>14 && sOnClick.indexOf("null")<0)
		   sMore = ' ' + sOnClick;
        var sTitle = 'title="' + selectbox.options[i].getAttribute('title')+'"';
        if (sTitle.length>8 && sTitle.indexOf("null")<0)
		   sMore += ' ' + sTitle;

	    if (typeof uri=="undefined") uri = '';
		document.write('<a href="'+selectbox.options[i].value + uri + '"' + sMore + '>'+selectbox.options[i].text+'</a>')
	}

	document.write('</div></div>')
	selectbox.style.display="none"
	var dhtmlselectbox=document.getElementById("dhtml_"+selectid)
	dhtmlselectbox.style.zIndex=combozindex
	combozindex--

	if (typeof selectwidth!="undefined")
		dhtmlselectbox.style.width=selectwidth
	if (typeof optionwidth!="undefined")
		dhtmlselectbox.getElementsByTagName("div")[0].style.width=optionwidth

	if (pos=="side")
	{
	   dhtmlselectbox.getElementsByTagName("div")[0].style.top="-1px";
	   dhtmlselectbox.getElementsByTagName("div")[0].style.left += optionwidth;
	}
	else
	   dhtmlselectbox.getElementsByTagName("div")[0].style.top=dhtmlselectbox.offsetHeight-2+"px"

	if (combodropimage!="")
		dhtmlselectbox.getElementsByTagName("img")[0].style.left=dhtmlselectbox.offsetWidth+3+"px"


dhtmlselectbox.onmouseover=function(){
    this.getElementsByTagName("div")[0].style.display="block"
}
dhtmlselectbox.onmouseout=function(){
    this.getElementsByTagName("div")[0].style.display="none"
}
}
/*
var combodropimage='/staticfile/web/css/media/arrow-down.gif' //path to "drop down" image
var combodropoffsetY=1 //offset of drop down menu vertically from default location (in px)
var combozindex=100

if (combodropimage!="")
	combodropimage='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img class1="downimage" src="'+combodropimage+'" title="Select an option" />'

function dhtmlselect(selectid, selectwidth, optionwidth,uri){
	var selectbox=document.getElementById(selectid)
	document.write('<div id="dhtml_'+selectid+'" class="dhtmlselect"><b>'+selectbox.title+combodropimage+'</b><div class="dropdown">')
	for (var i=0; i<selectbox.options.length; i++)
	{
	    if (typeof uri!="undefined")
	    {
		  document.write('<a href="'+selectbox.options[i].value + uri + '">'+selectbox.options[i].text+'</a>')	   
		}
		else
		  document.write('<a href="'+selectbox.options[i].value+'">'+selectbox.options[i].text+'</a>')
	}


	document.write('</div></div>')
	selectbox.style.display="none"
	var dhtmlselectbox=document.getElementById("dhtml_"+selectid)
	dhtmlselectbox.style.zIndex=combozindex
	combozindex--
	if (typeof selectwidth!="undefined")
		dhtmlselectbox.style.width=selectwidth
	if (typeof optionwidth!="undefined")
		dhtmlselectbox.getElementsByTagName("div")[0].style.width=optionwidth
	dhtmlselectbox.getElementsByTagName("div")[0].style.top=dhtmlselectbox.offsetHeight-combodropoffsetY+"px"
	if (combodropimage!="")
		dhtmlselectbox.getElementsByTagName("img")[0].style.left=dhtmlselectbox.offsetWidth+3+"px"
	dhtmlselectbox.onmouseover=function(){
		this.getElementsByTagName("div")[0].style.display="block"
	}
	dhtmlselectbox.onmouseout=function(){
		this.getElementsByTagName("div")[0].style.display="none"
	}
}
*/