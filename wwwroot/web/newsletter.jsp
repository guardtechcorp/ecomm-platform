<%@ page import="com.zyzit.weboffice.web.NewsletterWeb"%>
<%
{
  NewsletterWeb web = new NewsletterWeb(session, request);
  web.setDomainName(request, response, application.getRealPath("/"));

//web.dumpAllParameters(request);
  int nRet = web.submit(request);
  response.reset();
  response.setContentType("text/html");
  response.getWriter().print(nRet);
  response.flushBuffer();
}
%>