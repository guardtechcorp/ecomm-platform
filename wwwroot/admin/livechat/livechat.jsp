<%
  LiveChatBean bean = new LiveChatBean(session, 20);
  String sAction = request.getParameter("action");
//System.out.println("sAction=" + sAction);
  if (sAction==null)
     return;

  if (sAction.startsWith("Begin") || sAction.startsWith("Send") || sAction.startsWith("Retrieve") || sAction.startsWith("Stop") || sAction.startsWith("Leave"))
  {//. Chat Process
//bean.dumpAllParameters(request);
    response.reset();
    response.setContentType("text/html");
    if (sAction.startsWith("Begin"))
       response.getWriter().print(bean.beginChat(request));
    else if (sAction.startsWith("Send"))
       response.getWriter().print(bean.sendAnswer(request));
    else if (sAction.startsWith("Retrieve"))
       response.getWriter().print(bean.getQuestion(request));
    else if (sAction.startsWith("Stop"))
       response.getWriter().print(bean.stopChat(request));
    else if (sAction.startsWith("Leave"))
       response.getWriter().print(bean.leaveChat(request));

    response.flushBuffer();
    return;
  }

  LiveChatInfo info = bean.get(request);
  LiveSettingInfo lsInfo = bean.getLiveChatSettings();
%>
<%@ page import="com.zyzit.weboffice.bean.LiveChatBean"%>
<%@ page import="com.zyzit.weboffice.model.LiveChatInfo"%>
<%@ page import="com.zyzit.weboffice.model.LiveSettingInfo"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<html>
<head>
<title>Live Chart Server Side </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<style type="text/css">
a.menu:link               {color: blue; font: 10px Arial; text-decoration: none}
a.menu:visited            {color: blue; font: 10px Arial; text-decoration: none}
a.menu:active             {color: blue; font: 10px Arial; text-decoration: none}
a.menu:hover              {color: #FF9933; font: 10px Arial; text-decoration: underline}
</style>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/session.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/windows.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/livechat.js"></SCRIPT>
</HEAD>
<body leftmargin="10" topmargin="5" marginwidth="0" marginheight="0" bgcolor="<%=lsInfo.BackColor%>" onLoad="retrieveMessage(document.livechat, 2);" onbeforeunload="confirmClose();" onUnload="leaveChat(document.livechat);">
<form name="livechat" method="post" action="livechat.jsp" onSubmit="return false;">
<input type="hidden" name="domainname" value="<%=bean.getDomainName()%>">
<input type="hidden" name="caseno" value="<%=info.CaseNo%>">
<input type="hidden" name="talker" value="<%=bean.getTalkerName()%>">
<input type="hidden" name="sid" value="<%=bean.getSessionID()%>">
<table width="<%=lsInfo.ShowLeftArea!=0?660:500%>" border="0" height="540" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td colspan="<%=lsInfo.ShowLeftArea!=0?2:1%>" align="center"><%=bean.getTitle(lsInfo)%></td>
  </tr>
  <tr>
<% if (lsInfo.ShowLeftArea!=0) {%>
   <td width="160" height="480">
     <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
         <td valign="top"><%=bean.getLogo(lsInfo)%></td>
        </tr>
        <tr>
         <td><%=bean.getDescription(lsInfo)%></td>
        </tr>
      </table>
    </td>
<% } %>
    <td width="500" height="470" valign="top">
      <table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0">
       <tr>
        <td>
         <table width="500" cellpadding="0" cellspacing="0" border="0">
          <tr>
           <td width="35%"><font size=2>&nbsp;Case No: <b><%=info.CaseNo%></b></font></td>
           <td width="65%"><font size=2>Customer Name: <b><%=info.FirstName%> <%=info.LastName%></b></font></td>
          </tr>
          <tr>
           <td width="35%" valign="bottom" ><font size=2>
<% if (lsInfo.ShowTime!=0) {%>
           Chat Time: <b><span id="chattime">00:00:00</span></b>
<% } %>
           </font></td>
           <td width="65%" valign="bottom" align="right"><font size=1><a class="menu" href="javascript:selectAllChat();">Select All</a> | <a class="menu" href="javascript:copyChat();">Copy</a> | <a class="menu" href="javascript:printChat();">Print</a>&nbsp;</font></td>
          </tr>
        </table>
       </td>
      </tr>
      <tr>
        <td width="500" height="450"valign="top">
          <iframe src="../../web/form-chatcontent.jsp" name="vFrame" id="vFrame" width="500" height="450" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
        </td>
      </tr>
      </table>
    </td>
  </tr>
  <tr>
<% if (lsInfo.ShowLeftArea!=0) {%>
    <td width="160" align="right">Type Here:&nbsp;&nbsp;</td>
<% } %>
    <td width="500">
     <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="390">
          <input type="text" name="talkinput" style="width: 390px">
        </td>
        <td width="110" align="right">
          <input type="button" name="sendmessage" value="Send" style="width: 40px" onClick="sendMessage(document.livechat);">
          <input type="button" name="endchat" value="End Chat" style="width: 62px" onClick="stopChat(document.livechat);">
          <!--input type="button" name="printchat" value="Print" style="width: 40px" onClick="printChat(document.livechat);"-->
        </td>
      </tr>
     </table>
    </td>
  </tr>
</table>
<Script>centerWindow(<%=lsInfo.ShowLeftArea!=0?690:540%>, 600);</Script>
</form>
</body>
</html>