<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.OneTimeWeb"%>
<%
  OneTimeWeb oneWeb = new OneTimeWeb(session);
  if (!oneWeb.beginAccess(session, request, application.getRealPath("/")))
     return;  // No domain name was found or other reason

  OneTimeWeb.Result ret = null;
  String sFilename = request.getParameter("filename");
  if (Utilities.getValueLength(sFilename)==0)
     ret = oneWeb.downloadFile(request, response);
  else
     ret = oneWeb.downloadFile(sFilename, sFilename, response);
         
  if (ret.isSuccess())
    return;

  Errors errObj = (Errors)ret.getInfoObject();
  String sDisplayMessage = errObj.getError();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--%=shopcart.getHtmlTitleMeta(request, false)%-->
</head>
<body leftmargin="3" topmargin="3">
<%=sDisplayMessage%>
<br>
<br>
<form name="downloadfile" method="post" action="">
<div align="center"><input type="submit" name="Submit" value="Close Window" OnClick="javascript:window.close();"></div>
</form>
</body>
</html>
<%
  oneWeb.finishAccess(request);
%>
