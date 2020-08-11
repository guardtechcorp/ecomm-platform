<%@ page import="com.zyzit.weboffice.web.SessionWeb"%>
<%
{
  SessionWeb web = new SessionWeb(session, request);
  int nRet = web.browserClose(request);
  response.reset();
  response.setContentType("text/html");
  response.getWriter().print(nRet);
  response.flushBuffer();
}
%>