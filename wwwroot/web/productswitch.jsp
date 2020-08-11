<%@ page import="com.zyzit.weboffice.web.CategoryWeb" %>
<%
   CategoryWeb web2 = new CategoryWeb(session, request, 100);
   web2.transferDomainName(request);
   int nLayoutID = web2.getLayoutID(request);
%>
<% if (nLayoutID<=4) { %>
 <%@ include file="productlayout-14.jsp"%>
<% } else if (nLayoutID==5) { %>
 <%@ include file="productlayout-5.jsp"%>
<% } else if (nLayoutID==11) { %>
 <%@ include file="productlayout-11.jsp"%>
 <!--%@ include file="plugin/property/productlayout-webinfo.jsp"%-->
<% } else if (nLayoutID==12) { %>
 <%@ include file="productlayout-12.jsp"%>
<% } else if (nLayoutID==13) { %>
 <%@ include file="productlayout-13.jsp"%>
<% } else if (nLayoutID==15) { %>
 <%@ include file="productlayout-15.jsp"%>
<% } %>
