<%@ page import="java.lang.Exception"%>
<%@ page import="com.zyzit.weboffice.web.SessionWeb"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  SessionWeb webprop = new SessionWeb(session, request);
  String sActionProp = webprop.getRealAction(request);
//System.out.println("sActionProp=" + sActionProp+"!");
  if (sActionProp==null)
     return;
%>
<% if ("pi-propertysearch".equalsIgnoreCase(sActionProp)||"pi-submit-propertysearch".equalsIgnoreCase(sActionProp)) { %>
      <%@ include file="propertysearch.jsp"%>
<% } else if ("pi-propertylist".equalsIgnoreCase(sActionProp)) { %>
      <%@ include file="propertylist.jsp"%>
<% } else if ("pi-propertysummary".equalsIgnoreCase(sActionProp)||"pi-selectreportoptions".equalsIgnoreCase(sActionProp)) { %>
      <%@ include file="reportoptions.jsp"%>
<% } else if (sActionProp.endsWith("reportarchive")) { %>
      <%@ include file="reportarchive.jsp"%>
<% } else if (sActionProp.endsWith("propertybillinfo")||sActionProp.endsWith("generatereports")) { %>
      <%@ include file="propertybillinfo.jsp"%>
<% } else if (sActionProp.endsWith("propertyreports")) { %>
      <%@ include file="propertyreports.jsp"%>
<% } else if (sActionProp.endsWith("coverpageinfo")) { %>
      <%@ include file="coverpageinfo.jsp"%>
<% } %>

<% } %>