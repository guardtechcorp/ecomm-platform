<%@ page import="com.zyzit.weboffice.web.EmailResponseWeb"%>
<%
{
  EmailResponseWeb web = new EmailResponseWeb(session, request);
  web.takeAction(request);
  String sAction = request.getParameter("action");
  if ("emailopen".equalsIgnoreCase(sAction))
     return;
  else if ("redirect".equalsIgnoreCase(sAction))
  {
     String sUrl = java.net.URLDecoder.decode(request.getParameter("url"), "UTF-8");
     response.sendRedirect(sUrl);
     return;
  }
}
%>
Thank you.
