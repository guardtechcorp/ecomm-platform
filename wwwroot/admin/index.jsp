<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<HTML>
<HEAD>
<TITLE>Admin Index Page.</TITLE>
<%@ page import="java.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%
   BasicBean bean = new BasicBean(session, null);
   String sRedir;
/*
   if (request.getHeader("x-forwarded-host")!=null)
      sRedir = bean.getRedirUrl()+"?domainname=" + request.getHeader("x-forwarded-host");
   else
      sRedir = bean.getRedirUrl()+"?domainname=" + request.getHeader("host");
*/
   if (request.getHeader("x-forwarded-host")!=null)
      sRedir = bean.getRedirUrl(request.getHeader("x-forwarded-host"));
   else
      sRedir = bean.getRedirUrl(request.getHeader("host"));

//   bean.showAllParameters(request, out);
//   bean.showSessionInfo(request, application, session, out);
//   <META http-equiv='Refresh' content='0; URL=https://secure.zit.com/ctr/admin/signin/login.jsp?domainname=test101.zit.com'>
%>
<META http-equiv='Refresh' content='20; URL=<%=sRedir%>'>
<META http-equiv='Content-Type' content='text/html; charset=utf-8'>
</HEAD>
<BODY bgcolor='#FFFFFF'>
</BODY>
</HTML>
