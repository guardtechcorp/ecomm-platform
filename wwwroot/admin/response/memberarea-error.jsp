<%@ page import="com.zyzit.weboffice.bean.DomainBean"%>
<%
   String sDomainName = request.getParameter("domainname");
   String sReason = request.getParameter("reason");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<title>Access Error Page of <%=sDomainName%> - </title>
</head>
<body>
<h2>Error 404 and Reason code = <%=sReason%></h2>
<h2>Sorry, You can to access this page for some reason!</h2>
<DL>
  <DD>The requested URL was on this server, but you have no right to access it. </DD>
</DL>
<DL>
  <DD>If you want to access this page, please call the administrator at <%=sDomainName%> to grant you to access it.</DD>
</DL>
</body>
</html>