<html>
<head>
<title>Chat Content</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<script LANGUAGE="JavaScript">
var g_Div;
function onBodyLoad()
{
  g_Div = document.createElement("div");
  document.body.appendChild(g_Div);
}

function appendContent(sContent)
{
//	alert("sContent=" + sContent);
   var sText = sContent
   var arLines = sText.split("<br>");
   for (var i=0; i<arLines.length; i++)
   {
     if (arLines[i].length>0)
        showLine(arLines[i]);
   }
}

function showContent(sContent)
{
   g_Div.innerHTML = sContent;
}

function showLine(sLineContent)
{
//alert("|" + sLineContent + "|");
   g_Div.innerHTML += sLineContent;
   //. Next Line
   var br = document.createElement("!--");//br");
   g_Div.appendChild(br);
   //. Move view to the last line
   br.scrollIntoView(true);
}

function selectAll()
{
  document.execCommand("SelectAll");
}

function copy()
{
  document.execCommand("Copy");
/*
  function HighlightAll(theField) {
  var tempval=eval("document."+theField)
  tempval.focus()
  tempval.select()
  if (document.all&&copytoclip==1){
  therange=tempval.createTextRange()
  therange.execCommand("Copy")
  window.status="Contents highlighted and copied to clipboard!"
  setTimeout("window.status=''",1800)
  }
*/
}

function printContent()
{
  window.print();
}
</script>
<%
/*
   g_Div.innerHTML += sText;
    //. Name
//	var bold = document.createElement("b");
//	bold.appendChild(document.createTextNode("Neil Zhao:"));
//	g_Div.appendChild(bold);
        //. Content
//	g_Div.appendChild(document.createTextNode(sContent));
        //. Next Line
        var br = document.createElement("br");
        g_Div.appendChild(br);
    //. Move view to
        br.scrollIntoView(true);
*/
  LiveChatBean bean = new LiveChatBean(session, 20);
  LiveSettingInfo lsInfo = bean.getLiveChatSettings();
%>
<%@ page import="com.zyzit.weboffice.bean.LiveChatBean"%>
<%@ page import="com.zyzit.weboffice.model.LiveSettingInfo"%>
<body leftmargin="4" topmargin="2" marginwidth="2" marginheight="2" bgcolor="<%=lsInfo.BackColor%>" text="#000000" onLoad="onBodyLoad()">
</body>
</html>
