<html>
<head>
<title>Chat Content</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<%@ page import="com.zyzit.weboffice.bean.LiveChatHistoryBean"%>
<%@ page import="com.zyzit.weboffice.model.LiveChatInfo"%>
<%@ page import="com.zyzit.weboffice.model.LiveSettingInfo"%>
<script LANGUAGE="JavaScript">
function printContent()
{
  window.print();
}
</script>
<%
  LiveChatHistoryBean bean = new LiveChatHistoryBean(session, 20);
  LiveChatInfo info = (LiveChatInfo)bean.getLastInfo();

  LiveSettingInfo lsInfo = bean.getLiveChatSettings();
%>
<body leftmargin="4" topmargin="2" marginwidth="2" marginheight="2" bgcolor="<%=lsInfo.BackColor%>" text="#000000">
<%=info.Content%>
</body>
</html>