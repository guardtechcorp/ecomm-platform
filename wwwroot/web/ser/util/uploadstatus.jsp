<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.bean.FileUploadBean"%>
<%
   String sAction = FileUploadBean.getRealAction(request);
//FileUploadBean.dumpAllParameters(request);
   if ("GetStatus".equalsIgnoreCase(sAction))
   {
      FileUploadBean bean = new FileUploadBean(session);
      bean.updateAccessHit(request, FileUploadBean.WEBHIT_FRONT, null);
      bean.updateStatus(request, response);
      return;
   }

   String sFilename = Utilities.replaceContent(request.getParameter("filename"), "\\", "\\\\");
   String sJsp = request.getParameter("ajaxjsp");
   if (sJsp==null)
   {
//   URI=/web/ser/uploadstatus.jsp
     sJsp = request.getRequestURI();
     int nIndex = sJsp.lastIndexOf("/");
     sJsp = sJsp.substring(nIndex+1);
//System.out.println("URI of Neil="+request.getRequestURI()+","+sJsp);
   }

   String sShowArea = "statusarea";
%>
<html>
<head>
<title>Upload File Popup Window</title>
<link rel="stylesheet" href="/staticfile/web/css/common.css" type="text/css">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/uploadstatus.js"></SCRIPT>
</head>
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