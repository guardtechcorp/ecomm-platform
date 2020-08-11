<%@ page import="com.zyzit.weboffice.bean.SearchPageBean" %>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%
  if (request.getParameter("keyword")==null || request.getParameter("keyword").endsWith(".gif"))
  {
     return;
  }

  SearchPageBean bean = new SearchPageBean(session, 20);
  String sContent = bean.getSearchResultByKeyword(request.getParameter("keyword"));
///System.out.println("---------------------Keyword=" + request.getParameter("keyword"));
%>
<%=sContent%>