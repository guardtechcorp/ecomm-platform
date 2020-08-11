<%@ page import="com.zyzit.weboffice.web.MemberProductWeb" %>
<%@ page import="com.zyzit.weboffice.model.CategoryInfo" %>
<%
   MemberProductWeb mpWeb = MemberProductWeb.getObject(session);
   CategoryInfo cgInfo = mpWeb.getCategoryInfo(request);
//CategoryWeb.dumpAllParameters(request);
System.out.println("nLayout=" + cgInfo.LayoutID);
%>
<% if (cgInfo.LayoutID!=100) { %>
 <%@ include file="categorylayout-5.jsp"%>
<% } %>
