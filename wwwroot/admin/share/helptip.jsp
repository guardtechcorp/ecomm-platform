<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%
{
  BasicBean bean = new BasicBean(session, null);
//bean.dumpAllParameters(request);
  response.reset();
  response.setContentType("text/html");
  response.getWriter().print(bean.getHelpTipContent(request));//It is come from server side.");
  response.flushBuffer();
}
%>