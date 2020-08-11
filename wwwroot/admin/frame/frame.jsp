<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%
  BasicBean bean = new BasicBean(session, null);
  if (!bean.canAccessPage(request, response, 0xffffffff))
     return;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%=bean.getHtmlTitleMeta(request, true)%>
<meta http-equiv="Content-Type" content="text/html;">
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/session.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js"></SCRIPT>
</head>
<frameset rows="51,*" frameborder="NO" border="0" framespacing="0" onLoad="sendIdleFlag(<%=(bean.getTimoutSeconds()-60)%>, '../share/idle.jsp');" onUnload="onBrowserClose('../share/idle.jsp');">
    <frame name="topFrame" scrolling="NO" noresize src="<%=bean.encodedAdminUrl("../frame/topbar.jsp")%>">
    <frameset cols="153,*" rows="*" border="0" framespacing="0" frameborder="yes">
     <frame src="<%=bean.encodedAdminUrl("../frame/leftnav.jsp")%>" name="nav" marginwidth="0" marginheight="0" scrolling="auto">
     <frame src="<%=bean.encodedAdminUrl("../util/welcome.jsp")%>" name="main" marginwidth="10" marginheight="10" scrolling="auto">
    </frameset>
</frameset>
<noframes>
<body bgcolor="#FFFFFF" text="#000000">
<p>Sorry, your browser doesn't seem to support frames</p>
</body>
</noframes>
</html>