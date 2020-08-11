<%@ page import="com.zyzit.weboffice.bean.DomainBean"%>
<%
   String sDomainName = request.getParameter("domainname");
   String sReason = request.getParameter("reason");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<title>Access Error Page of <%=sDomainName%> for member area- </title>
</head>
<body>
<h2>Error 404</h2>
<h3>Error Reason: <%=sReason%>
<br>
<DL>
  <DD>The requested URL was on this server, but you have no right to access it because of the above reason. </DD>
</DL>
<DL>
  <DD>If you want to access this area/page, please call the administrator at <%=sDomainName%> to grant you to access it.</DD>
</DL>
</body>
</html>