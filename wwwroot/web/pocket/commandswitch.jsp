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
<% if (sActionProp.endsWith("buycredit")) { %>
      <%@ include file="buycredit.jsp"%>
<% } else if (sActionProp.endsWith("creditlist")) { %>
      <%@ include file="creditlist.jsp"%>
<% } else if (sActionProp.endsWith("accountlogin")) { %>
      <%@ include file="accountlogin.jsp"%>
<% } else if (sActionProp.endsWith("accountinfo")) { %>
      <%@ include file="accountinfo.jsp"%>
<% } else if (sActionProp.endsWith("myaccount")) { %>
      <%@ include file="myaccount.jsp"%>
<% } else if (sActionProp.endsWith("creditcardpay")) { %>
      <%@ include file="creditcardpay.jsp"%>
<% } %>

<% } %>