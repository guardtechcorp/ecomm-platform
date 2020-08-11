<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%
//BasicWeb.dumpAllParameters(request);
//System.out.println("ID=" + session.getId());
  BasicWeb.recordAction(request, null, session.getId(), BasicWeb.WEBHIT_FRONT, null);
/*
  response.reset();
//  response.setContentType("text/html");
  response.getWriter().print(1);
  response.flushBuffer();
*/
%>