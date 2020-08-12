<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
    BasicWeb web2 = new BasicWeb(session, null);
    ConfigInfo info = web2.getConfigInfo();
    String sDomainName = web2.getDomainName();
%>
<% if (info.TopBar!=0) { %>
<% if (info.LayoutID==1) { %>
<%@ include file="top1.jsp"%>
<% } else if (info.LayoutID==2){ %>
<%@ include file="top2.jsp"%>
<% } else if (info.LayoutID==3){ %>
<% if (!"www.webcenter123.com".equalsIgnoreCase(sDomainName)) { %>
<%@ include file="top3.jsp"%>
<% } else { %>
<%@ include file="plugin/property/top3-webinfo.jsp"%>
<% } %>
<% } else if (info.LayoutID==4){ %>
<%@ include file="top4.jsp"%>
<% } else if (info.LayoutID==5){ %>
<%@ include file="top5.jsp"%>
<% } else if (info.LayoutID==6){ %>
<%@ include file="top6.jsp"%>
<% } else if (info.LayoutID==7){ %>
<%@ include file="top7.jsp"%>
<% } else { %>
<% if (!"play.atozmate.com".equalsIgnoreCase(sDomainName)) { %>
<%@ include file="top8.jsp"%>
<% } else { %>
<%@ include file="top8-atozmate.jsp"%>
<% } %>
<% } %>
<% } %>
<% } %>
