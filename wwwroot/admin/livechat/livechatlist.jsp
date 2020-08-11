<%
  LiveChatBean bean = new LiveChatBean(session, 20);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_LIVECHAT_USER))
//     return;
//bean.dumpAllParameters(request);
  String sAction = request.getParameter("action");
//System.out.println("sAction=" + sAction);
  if (sAction.startsWith("Table"))//Session List"))
  {//. Background process
    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(bean.getSessionTable(request));
    response.flushBuffer();
    return;
  }

  String sHelpTag = "livechatlist";
  String sTitleLinks = "<b>Active Live Chat Session List</b>";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<link rel="stylesheet" href="/staticfile/admin/css/main.css" type="text/css">
<link rel="stylesheet" href="/staticfile/admin/css/tooltip.css" type="text/css">
<title>Administration Console - </title>
</head>
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/sarissa.js"></SCRIPT-->
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/session.js"></SCRIPT-->
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/livechatlist.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/tooltip.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/session.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/windows.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js"></SCRIPT>
<body>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.LiveChatBean"%>
<%@ page import="com.zyzit.weboffice.model.LiveChatInfo"%>
<%@ include file="../share/titlelink.jsp"%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can see all the live chat customers who are waiting for chatting with you. You can pick up any of them to chat.
<br><br>

<Script>onBodyLoad(3);</Script>
<%@ include file="../share/footer.jsp"%>