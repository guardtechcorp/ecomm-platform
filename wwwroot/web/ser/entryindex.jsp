<%@ page import="com.zyzit.weboffice.web.SessionWeb"%>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%
    SessionWeb web = new SessionWeb(session, request);
    String sContent = web.getLandingPage(request, response, application.getRealPath("/"));
    Utilities.writeHtmlOutput(response, sContent);

//cfInfo = com.zyzit.weboffice.model.ConfigInfo@1f8f8c8
//Member ID = 2,www.free2s.com    
//Member ID = 1,
//    web.showAllParameters(request, out);
//    web.showSessionInfo(request, application, session, out);
%>
