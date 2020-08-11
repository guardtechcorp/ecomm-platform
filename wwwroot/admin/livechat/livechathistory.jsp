<%@ include file="../share/uparea.jsp"%>
<%@ page import="com.zyzit.weboffice.bean.LiveChatHistoryBean"%>
<%@ page import="com.zyzit.weboffice.model.LiveChatInfo"%>
<%@ page import="com.zyzit.weboffice.model.LiveSettingInfo"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/livechat.js"></SCRIPT>
<%
  LiveChatHistoryBean bean = new LiveChatHistoryBean(session, 20);
  String sAction = request.getParameter("action");
  LiveChatInfo info = null;//bean.get(request);
  if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
  }
  else
     info = bean.get(request);
  LiveSettingInfo lsInfo = bean.getLiveChatSettings();

  String sHelpTag = "livechathistory";
  String sTitleLinks = "<a href=\"livechathistorylist.jsp?action=History List\">Live Chat History List</a> > <b>Live Chat Content</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The page show the details of live chat record and you can <a href="#" onClick="printChat2();">print</a> its content.
<!--table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="20" valign="top"><font size="2"><a href="livechathistorylist.jsp?action=History List">Live Chat History List</a> > <b>Live Chat Content</b></font></td>
    <td width="5%"  height="20" valign="top" onmouseover="showTipHelp('livechathistory');" onmouseout="showHideSpan('close','tiphelp');" >
     <a href="javascript:;" class="helplink"><IMG src="/staticfile/admin/images/quickhelp.gif" width=14 height=16 align="CENTER" border="0">Help</a>
    </td>
  </tr>
  <tr>
    <td height="1" valign="top" colspan="2">
     <DIV id="tiphelp" style="DISPLAY: none">
     <table width="100%" cellpadding="4" cellspacing="0" class="infobox">
      <tr>
       <td bgcolor="#FFFFCC"><DIV id="tipcontent"></DIV></td>
      </tr>
     </table>
     </DIV>
    </td>
  </tr>
  <tr>
    <td height="20" valign="top">The page show the details of live chat record and you can <a href="#" onClick="printChat2();">print</a> its content.</td>
  </tr>
</table-->
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("livechathistory.jsp?")%></td>
  </tr>
  <tr>
    <td align="right"><hr></td>
  </tr>
</table>
<!--form name="livechat" method="post" action="livechathistory.jsp" onSubmit="return false;"-->
<table width="760" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td width="260" height="480">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
       <tr>
         <td height="40"></td>
       </tr>
       <tr>
         <td valign="top"><%=bean.getDetailText(info)%></td>
       </tr>
      </table>
    </td>
    <td width="500" height="450" valign="top">
      <table width="100%" border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0">
       <tr>
        <td colspan="2" height="30">
         <table width="500" cellpadding="0" cellspacing="0" border="0">
          <tr>
           <td width="30%">Case No: <b><%=info.CaseNo%></b></td>
           <td width="70%">User Name: <b><%=info.FirstName%> <%=info.LastName%></b></td>
          </tr>
        </table>
       </td>
      </tr>
      <tr>
        <td width="500" colspan="2" valign="top">
          <iframe src="chatcontent.jsp" name="vFrame" id="vFrame" width="500" height="450" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
        </td>
      </tr>
      </table>
    </td>
  </tr>
</table>
<!--/form-->
<%@ include file="../share/footer.jsp"%>