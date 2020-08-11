<%@ page import="java.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.LoginBean"%>
<%
   LoginBean bean = new LoginBean(session);
   bean.setRootPath(application.getRealPath("/"));

System.out.println("It is started.");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<title>Administration Console start page.</title>
</head>
<body>
This is a start page.
</body>
</html>
