<%@ page import="com.zyzit.weboffice.web.LayoutWeb"%>
<%
  LayoutWeb web = new LayoutWeb(session, request);
  web.getFileContent(request, response);
%>
