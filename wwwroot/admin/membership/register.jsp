<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  MemberBean bean = new MemberBean(session, 0);
System.out.println("A new member is register=" + request.getParameter("email1") + " from " + request.getHeader("x-forwarded-for"));
bean.dumpAllParameters(request);
  String sDomainName = bean.getDomainNameFromUrl(session, request, true);
  MemberBean.Result ret = bean.register(request, sDomainName);
//System.out.println("A new member's domainname=" + sDomainName + "," + ret.m_bSuccess);
%>
<% if (ret.isSuccess()) { %>
<%=(String)ret.getUpdateInfo()%>
<% }else{ %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Thank you!</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body bgcolor="#F9FADA">
An error occures when you are registering. Please report this error to customerservice@<%=sDomainName%>
<%
  Errors errObj = (Errors)ret.getInfoObject();
  String sDisplayMessage = errObj.getError();
%>
<%=sDisplayMessage%>
</body>
</html>
<% } %>