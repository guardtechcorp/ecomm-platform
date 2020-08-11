<%@ page import="java.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%
   BasicBean bean = new BasicBean(session, null);
   String sAction = request.getParameter("action");
   if ("idle".equalsIgnoreCase(sAction))
   {//. Send idle and tell the server I am still alive
     bean.checkIdle(request);
   }
   else if ("Logout".equalsIgnoreCase(sAction))
   {//. A broswer is closed
     boolean bRet = bean.logout(request);
   }
   else if ("Get Visitors".equalsIgnoreCase(sAction))
   {
     int nTotal = bean.getTotalVisitor(request);
     response.reset();
     response.setContentType("text/html");
     response.getWriter().print(nTotal);
     response.flushBuffer();
   }
   else
   { //. Log and record page load information
     bean.updateAccessHit(request, BasicBean.WEBHIT_FRONT, null);
   }
%>