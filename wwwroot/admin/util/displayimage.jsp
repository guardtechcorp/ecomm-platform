<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%
  BasicBean bean = new BasicBean(session, null);
//bean.showAllParameters(request, out);
//bean.dumpAllParameters(request);

  String sFilename = request.getParameter("filename");
//System.out.println("sFilename = " + sFilename);
  if (sFilename!=null && bean.getImageFile(request, response))
     return;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<%=bean.getHtmlTitleMeta(request, false)%>
</head>
<body leftmargin="3" topmargin="3">
<% if (sFilename!=null) {%>
<img src="<%=bean.getWebsiteUploadUrl(request)+request.getParameter("filename")%>">
<% } else { %>
<img src="<%=bean.getSampleImage(request)%>">
<% } %>
<br>
<form name="dsiplayimage" method="post" action="">
<div align="center"><input type="submit" name="Submit" value="Close Window" OnClick="javascript:window.close();"></div>
</form>
<%@ include file="../share/footer.jsp"%>
