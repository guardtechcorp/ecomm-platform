<html>
<head>
<title>Category with Product Selection Page</title>
<meta http-equiv="Content-Type" content="text/html;">
</head>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%
  BasicBean bean = new BasicBean(session, null);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_PRODUCT))
     return;

  String sFolder = request.getParameter("folder");
  String sTop = request.getParameter("top");
  String sLeft = request.getParameter("left");
  String sRight = request.getParameter("right");
%>
<frameset rows="86,*" frameborder="NO" border="0" framespacing="0">
  <frame name="<%=sTop%>" src="../<%=sFolder%>/<%=sTop%>.jsp" scrolling="NO" noresize >
  <frameset cols="400,*" frameborder="no" border="1" framespacing="0" rows="*">
    <frame name="<%=sLeft%>" src="../<%=sFolder%>/<%=sLeft%>.jsp" scrolling="atuo" noresize >
    <frame name="<%=sRight%>" src="../<%=sFolder%>/<%=sRight%>.jsp"  marginwidth="10" marginheight="10" scrolling="auto">
  </frameset>
</frameset>
<noframes>
 <body bgcolor="#FFFFFF" text="#000000">
   <p>Sorry, your browser doesn't seem to support frames</p>
 </body>
</noframes>
</html>