<HTML>
<HEAD>
<TITLE>Admin Index Page.</TITLE>
<%@ page import="java.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.controller.Manager"%>
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
/*
   Server Information:
   Root Path = /var/www/websites/wwwroot/
   Request method = GET
   Request URI = /ctr/admin/admin/index.jsp
   Request protocol = HTTP/1.1
   Servlet path = /admin/admin/index.jsp
   Path info = null
   Path translated = null
   Query string = null
   Content length = 0
   Content type = null
   Server name = www.test101.wlmg.net
   Server port = 80
   Remote user = null
   Remote address = 75.15.100.169
   Remote host = 75.15.100.169
   Scheme = http
   Authorization scheme = null
   Request scheme = http
   Request Locale = en_US
   Header Information:
   accept =
   accept-encoding = gzip, deflate
   accept-language = en-us
   connection = Keep-Alive
   content-length = 0
   cookie = JSESSIONID=2B7FD5C4222C000EB1AB1C3C62E238F9
   host = www.test101.wlmg.net
   user-agent = Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)

   Application Information:
   javax.servlet.context.tempdir
   org.apache.catalina.WELCOME_FILES
   org.apache.catalina.jsp_classpath
   org.apache.catalina.resources
   Cookie Information:
*/
%>
<META http-equiv='Refresh' content='20; URL=<%=sRedir%>'>
<META http-equiv='Content-Type' content='text/html; charset=utf-8'>
</HEAD>
<BODY bgcolor='#FFFFFF'>
</BODY>
</HTML>
