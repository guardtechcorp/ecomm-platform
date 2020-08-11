<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<html>
<head>
<title>Upload File Popup Window</title>
<link rel="stylesheet" href="/staticfile/admin/css/main.css" type="text/css">
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/uploadfile.js"></SCRIPT>
</head>
<%
  String sFilename = Utilities.replaceContent(request.getParameter("filename"), "\\", "\\\\");
  String sJsp = request.getParameter("ajaxjsp");
  if (sJsp==null)
     sJsp = "filelist.jsp";
  String sShowArea = "statusarea";
%>
<body onLoad="repeatCheck('<%=sFilename%>', 1, '<%=sJsp%>?action=GetStatus&type=object', '<%=sShowArea%>');">
<p>
<table width="500">
  <tr>
    <td height=20></td>
  </tr>
  <tr>
    <td><span id="<%=sShowArea%>"></span></td>
  </tr>
</table>
</body>
</html>