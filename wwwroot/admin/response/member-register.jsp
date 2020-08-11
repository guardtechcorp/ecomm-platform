<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%
  HttpSession parentSession = MemberBean.getHttpSession(request.getParameter("domainname"), request.getParameter("sid"));
  MemberBean bean = new MemberBean(session, 0);
  MemberInfo info = (MemberInfo)bean.getLastInfo();
%>
Hi, <%=info.Name%>

<%=Utilities.getValue(bean.getSettingInfo("thankemail").Content)%>

Your membership address(URL) is: http://<%=bean.getDomainName()%>/membership/login.jsp
Your username is: <%=info.EMail%>
Your password is: <%=info.Password%>