<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%
    {
/*
  SessionWeb web = new SessionWeb(session, request);
  web.dumpAllParameters(request);
  web.showAllParameters(request, out);
  web.showSessionInfo(request, application, session, out);
*/
    try {
        out.println("<BLOCKQUOTE>");
        out.println("<P><U><B>CGI Information:</B></U></P>");
        Enumeration names = request.getParameterNames();
        while (names.hasMoreElements()) {
            String sName = (String) names.nextElement();
            String[] arValue = request.getParameterValues(sName);
            if (arValue != null) {
                String sValues = sName + " =";
                for (int i = 0; i < arValue.length; i++) {
                    if (i > 0)
                        sValues += "|";
                    sValues += arValue[i];
                }
                out.println(sValues + "<BR>");
            } else
                out.println(sName + " = " + request.getParameter(sName) + "<BR>");
        }

        out.println("<BR>");
        out.println("</BLOCKQUOTE>");

        out.println("<BLOCKQUOTE>");
        out.println("<P><U><B>Server Information:</B></U></P>");

        out.println("Root Path = " + application.getRealPath("/") + "<BR>");
        out.println("Request method = " + request.getMethod() + "<BR>");
        out.println("Request URI = " + request.getRequestURI() + "<BR>");
        out.println("Request protocol = " + request.getProtocol() + "<BR>");
        out.println("Servlet path = " + request.getServletPath() + "<BR>");
        out.println("Path info = " + request.getPathInfo() + "<BR>");
        out.println("Path translated = " + request.getPathTranslated() + "<BR>");
        out.println("Query string = " + request.getQueryString() + "<BR>");
        out.println("Content length = " + request.getContentLength() + "<BR>");
        out.println("Content type = " + request.getContentType() + "<BR>");
        out.println("Server name = " + request.getServerName() + "<BR>");
        out.println("Server port = " + request.getServerPort() + "<BR>");
        out.println("Remote user = " + request.getRemoteUser() + "<BR>");
        out.println("Remote address = " + request.getRemoteAddr() + "<BR>");
        out.println("Remote host = " + request.getRemoteHost() + "<BR>");
        out.println("Scheme = " + request.getScheme() + "<BR>");
        out.println("Authorization scheme = " + request.getAuthType() + "<BR>");
        out.println("Request scheme = " + request.getScheme() + "<BR>");
        out.println("Request Locale = " + request.getLocale() + "<BR><BR>");

        out.println("<P><U><B>Header Information:</B></U></P>");
        List headerList = new ArrayList();
        Enumeration headers = request.getHeaderNames();
        while (headers.hasMoreElements()) {
            headerList.add((String) headers.nextElement());
        }
        String[] arrayHeaders = new String[headerList.size()];
        headerList.toArray(arrayHeaders);
        Arrays.sort(arrayHeaders);
        for (int i = 0; i < arrayHeaders.length; i++) {
            out.println(arrayHeaders[i] + " = " + request.getHeader(arrayHeaders[i]) + "<BR>");
        }


        out.println("<P><U><B>Application Information:</B></U></P>");
        List paramList = new ArrayList();
        Enumeration params = application.getAttributeNames();
        while (params.hasMoreElements()) {
            paramList.add((String) params.nextElement());
        }
        String[] arrayParams = new String[paramList.size()];
        paramList.toArray(arrayParams);
        Arrays.sort(arrayParams);
        for (int i = 0; i < arrayParams.length; i++) {
            out.println(arrayParams[i] + "<BR>");
        }

        out.println("<P><U><B>Cookie Information:</B></U></P>");
        Cookie[] reqck = request.getCookies();
        Cookie ck;
        for (int i = 0; reqck != null && i < reqck.length; i++) {
            ck = reqck[i];
            out.println(ck.getName() + "=" + ck.getValue() + "<BR>");
        }

        out.println("</BLOCKQUOTE>");

    }
    catch (java.io.IOException e) {
        e.printStackTrace();
    }

}
%>