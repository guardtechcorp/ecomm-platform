<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<%@ page import="com.zyzit.weboffice.util.Definition" %>
<%
{
//SiteFileWeb.dumpAllParameters(request);
    String sSrcUrl;
    SiteFileWeb sfWeb = SiteFileWeb.getObject(session);
    int nPageId = Utilities.getInt(request.getParameter("pid"), -1);
    if (nPageId>=0)
    {
       String sFilename = request.getParameter("filename");
       sSrcUrl = sfWeb.getStortageFileUrl(nPageId, sFilename);
    }
    else if (Utilities.getInt(request.getParameter("fileindex"), -1)>=0)
    { //. It is from view storage image file (action = View)
      String sAction = request.getParameter("action");
      int nFileIndex = Utilities.getInt(request.getParameter("fileindex"), -1);
      byte nType = Utilities.getByte(request.getParameter("type"), Definition.TABLETYPE_FILELIST);
      sSrcUrl = sfWeb.encodedUrl("util/loadfile.jsp?action="+sAction +"&fileindex="+nFileIndex + "&type=" + nType);
    }
    else
    {
        String sType = request.getParameter("type");
        String sValue = request.getParameter("value");
//System.out.println("value=" + sValue);
        sSrcUrl = sfWeb.encodedUrl("util/loadfile.jsp?action=Show File&type=" + sType + "&value=" + sValue);
    }
%>
<html>
<head>
<script language="javascript">
function scaleSize()
{
  var nWidth = document.getElementById("imgTag").width
  var nHeight = document.getElementById("imgTag").height;
//  alert("nWidth=" + nWidth + "x" + nHeight + "-->" + (document.body.clientWidth-4) + "x" + (document.body.clientHeight-4));
  if (nWidth>document.body.clientWidth||nHeight>document.body.clientHeight)
  {
    var nMaxWidth = document.body.clientWidth-4;
    var nMaxHeight = document.body.clientHeight-4;

    var imageRatio = nWidth / nHeight;
    var thumbRatio = nMaxWidth / nMaxHeight;
    if (imageRatio >= thumbRatio)
    {
       nWidth = nMaxWidth;
       nHeight = nMaxWidth/imageRatio;
    }
    else //if (imageRatio < thumbRatio)
    {
       nWidth = (nMaxHeight*nWidth)/nHeight;
       nHeight = nMaxHeight;
    }
    document.getElementById("imgTag").style.width = nWidth;
    document.getElementById("imgTag").style.height = nHeight;

//    alert("nWidth2=" + nWidth + "x" + nHeight + "-->" + (imageRatio) + "<>" + thumbRatio);
/*
    var thumbRatio = nMaxWidth / nMaxHeight;
    var imageRatio = nWidth / nHeight;
    if (thumbRatio < imageRatio)
    {
        nMaxWidth = (nMaxWidth / imageRatio);
    }
    else
    {
        nMaxHeight = (nMaxHeight * imageRatio);
    }
    document.getElementById("imgTag").style.width = nMaxWidth;
    document.getElementById("imgTag").style.height = nMaxHeight;
*/

//    document.getElementById("imgTag").width = nWidth;
//    document.getElementById("imgTag").height = nHeight;
  }
}
</script>
</head>
<body onload="javascript:scaleSize();">
<TABLE cellpadding="0" cellspacing="0" border="0" width="100%">
 <tr>
  <td algin="center"><img id="imgTag" src="<%=sSrcUrl%>" /></td>
</tr>
</TABLE>
</body>
</html>
<% } %>