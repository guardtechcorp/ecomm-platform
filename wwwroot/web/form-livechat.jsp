<%
  String sDomainName = request.getParameter("domainname");
  String sSid = request.getParameter("sid");
  HttpSession parentSession = session;
  if (sDomainName!=null && sSid!=null)
     parentSession = LiveChatBean.getHttpSession(session, sDomainName, sSid);
//System.out.println("chat Info=" + parentSession + "," + sDomainName + "-" + sSid);
  LiveChatBean bean = new LiveChatBean(parentSession, 20);
  ConfigInfo cfInfo = bean.getConfigInfo(sDomainName);
//<a href="http://www.google.com" onclick="NewWindow(this.href,'mywin','400','200','no','center');return false" onfocus="this.blur()">YourLinkText</a>
  String sAction = bean.getRealAction(request);
//System.out.println("sAction00=" + sAction);
  String sDisplayMessage = null;
  LiveChatInfo info = null;
  if (sAction!=null)
  {
    if ("Submit".equalsIgnoreCase(sAction))
    {
      LiveChatBean.Result ret = bean.submit(request);
      if (ret.isSuccess())
      {
        info = (LiveChatInfo)ret.getInfoObject();
      }
      else
      {
        Errors errObj = (Errors)ret.getInfoObject();
        sDisplayMessage = errObj.getError();
      }
    }

    if (sAction.startsWith("Start") || sAction.startsWith("Send") || sAction.startsWith("Get") || sAction.startsWith("End"))
    {
      response.reset();
      response.setContentType("text/html");
      if (sAction.startsWith("Start"))
         response.getWriter().print(bean.startChat(request));
      else if (sAction.startsWith("Send"))
         response.getWriter().print(bean.sendQuestion(request));
      else if (sAction.startsWith("Get"))
         response.getWriter().print(bean.getAnswer(request));
      else if (sAction.startsWith("End"))
         response.getWriter().print(bean.endChat(request));
      response.flushBuffer();
      return;
    }
  }

  bean.updateAccessHit(request, LiveChatBean.WEBHIT_FRONT, null);
  LiveSettingInfo lsInfo = bean.getLiveChatSettings(request.getParameter("domainname"));
%>
<%@ page import="com.zyzit.weboffice.bean.LiveChatBean"%>
<%@ page import="com.zyzit.weboffice.model.LiveChatInfo"%>
<%@ page import="com.zyzit.weboffice.model.LiveSettingInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<html>
<head>
<title>Live Chat Client of <%=Utilities.getValue(request.getParameter("domainname"))%> </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<style type="text/css">
a.menu:link               {color: blue; font: 10px Arial; text-decoration: none}
a.menu:visited            {color: blue; font: 10px Arial; text-decoration: none}
a.menu:active             {color: blue; font: 10px Arial; text-decoration: none}
a.menu:hover              {color: #FF9933; font: 10px Arial; text-decoration: underline}
</style>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/languages/<%=cfInfo.Language%>.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/windows.js" type="text/javascript"></SCRIPT>
<!--SCRIPT Language="JavaScript" src="/staticfile/web/scripts/sarissa.js" type="text/javascript"></SCRIPT-->
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/session.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/livechat.js" type="text/javascript"></SCRIPT>
</HEAD>
<% if (info==null) {%>
<body leftmargin="15" topmargin="5" marginwidth="10" marginheight="5" bgcolor="<%=lsInfo.BackColor%>" onLoad="onLiveChatFormLoad(document.livechat);">
<!--form name="livechat" method="post" action="https://secure.webonlinemanage.com/ctr/web/form-livechat.jsp" onSubmit="return validateLiveChat(this);"-->
<form name="livechat" method="post" action="form-livechat.jsp" onSubmit="return validateLiveChat(this);">
<input type="hidden" name="domainname" value="<%=Utilities.getValue(request.getParameter("domainname"))%>">
<input type="hidden" name="action1" value="">
<table width="600" height="300" cellpadding="0" cellspacing="0" border="0">
  <tr>
    <td colspan="2" height="5" align="center"><%=bean.getTitle(lsInfo)%></td>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td colspan="2" align="center"><span class="failed"><font size="2" face="arial"><%=sDisplayMessage%></font></span></td>
  </tr>
<% } %>
  <tr>
    <td width="160" height="270">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
         <td valign="top"><%=bean.getLogo(lsInfo)%></td>
        </tr>
        <tr>
         <td><%=bean.getDescription(lsInfo)%></td>
        </tr>
      </table>
    </td>
    <td align="center" width="440" height="270" valign="middle">
      <table cellpadding="1" cellspacing="0" border="0" width="100%">
        <tr>
          <td align="right" width="110"><font size=2><%=bean.getLabelText(cfInfo, "question-lab")%></font></td>
          <td width="270">
            <INPUT TYPE="TEXT" SIZE="35" NAME="question" style="width: 320px" MAXLENGTH="255" VALUE="<%=Utilities.getValue(request.getParameter("question"))%>">
            <!--INPUT TYPE="TEXT" SIZE="35" NAME="question" style="width: 320px" MAXLENGTH="255" VALUE="How to solve VPN problem in my PC"-->
          </td>
        </tr>
        <tr>
          <td align="right" width="110"><font size=2><%=bean.getLabelText(cfInfo, "questiontype-lab")%></font></td>
          <td width="270">
            <select name="type" style="width: 320px">
              <option value="none" selected><%=bean.getLabelText(cfInfo, "one-sel")%></option>
              <option value="Billing">Billing</option>
              <option value="Technical Support">Technical Support</option>
              <option value="Sales Information">Sales Information</option>
              <option value="Training">Training</option>
              <option value="Others">Others</option>
            </select>
          </td>
        </tr>
        <tr>
          <td align="right" width="110"><font size=2><%=bean.getLabelText(cfInfo, "firstname-lab")%></font></td>
          <td width="270">
            <INPUT TYPE="TEXT" SIZE="35" NAME="firstname" style="width: 320px" MAXLENGTH="20" VALUE="<%=Utilities.getValue(request.getParameter("firstname"))%>">
            <!--INPUT TYPE="TEXT" SIZE="35" NAME="firstname" style="width: 320px" MAXLENGTH="20" VALUE="Neil"-->
          </td>
        </tr>
        <tr>
          <td align="right" width="110"><font size=2><%=bean.getLabelText(cfInfo, "lastname-lab")%></font></td>
          <td width="270">
            <INPUT TYPE="TEXT" SIZE="35" NAME="lastname" style="width: 320px" MAXLENGTH="20" VALUE="<%=Utilities.getValue(request.getParameter("lastname"))%>">
            <!--INPUT TYPE="TEXT" SIZE="35" NAME="lastname" style="width: 320px" MAXLENGTH="20" VALUE="Zhao"-->
          </td>
        </tr>
        <tr>
          <td align="right" width="110"><font size=2><%=bean.getLabelText(cfInfo, "youremail-lab")%></font></td>
          <td width="270">
            <INPUT TYPE="TEXT" SIZE="35" NAME="email" style="width: 320px" MAXLENGTH="50" VALUE="<%=Utilities.getValue(request.getParameter("email"))%>">
            <!--INPUT TYPE="TEXT" SIZE="35" NAME="email" style="width: 320px" MAXLENGTH="50" VALUE="nzhao@molecularsoft.com"-->
          </td>
        </tr>
        <tr>
          <td align="right" width="110"><font size=2><%=bean.getLabelText(cfInfo, "account#-lab")%></font></td>
          <td width="270">
            <INPUT TYPE="TEXT" SIZE="35" NAME="account" style="width: 320px" MAXLENGTH="50" VALUE="<%=Utilities.getValue(request.getParameter("account"))%>">
            <!--INPUT TYPE="TEXT" SIZE="35" NAME="account" style="width: 320px" MAXLENGTH="50" VALUE="123456"-->
          </td>
        </tr>
        <tr>
          <td colspan="2" height="20"></td>
        </tr>
        <tr>
          <td align="right" width="110"></td>
          <td width="260">
            <input type="Submit" VALUE="<%=bean.getLabelText(cfInfo, "submit-but")%>" name="submit" onClick="setAction(document.livechat, 'Submit');">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="reset" VALUE="<%=bean.getLabelText(cfInfo, "reset-but")%>" name="reset">
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</form>
</body>
<% } else {%>
<body leftmargin="10" topmargin="5" marginwidth="0" marginheight="0" bgcolor="<%=lsInfo.BackColor%>" onLoad="retrieveMessage(document.livechat, 2);" onbeforeunload="confirmClose();" onUnload="endChat(document.livechat);">
<form name="livechat" method="post" action="form-livechat.jsp" onSubmit="return false;">
<input type="hidden" name="domainname" value="<%=Utilities.getValue(request.getParameter("domainname"))%>">
<input type="hidden" name="sid" value="<%=info.CaseNo%>">
<input type="hidden" name="caseno" value="<%=info.CaseNo%>">
<input type="hidden" name="firstname" value="<%=info.FirstName%>">
<input type="hidden" name="lastname" value="<%=info.LastName%>">
<table width="<%=lsInfo.ShowLeftArea!=0?660:500%>" border="0" height="540" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td colspan="<%=lsInfo.ShowLeftArea!=0?2:1%>" align="center"><%=bean.getTitle(lsInfo)%></td>
  </tr>
  <tr>
<% if (lsInfo.ShowLeftArea!=0) {%>
    <td width="160" height="470">
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
         <td height="5"></td>
        </tr>
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
           <td width="35%"><font size=2>&nbsp;<%=bean.getLabelText(cfInfo, "caseno-lab")%> <b><%=info.CaseNo%></b></font></td>
           <td width="65%"><font size=2><%=bean.getLabelText(cfInfo, "chatwith-lab")%> <b><span id="chatwith"></span></b></font></td>
          </tr>
          <tr>
           <td width="35%" valign="bottom">
           <font size=2>&nbsp;
<% if (lsInfo.ShowTime!=0) {%>
           Chat Time: <b><span id="chattime">00:00:00</span></b>
<% } %>
            </font>
           </td>
           <td width="65%" valign="bottom" align="right"><font size=1><a class="menu" href="javascript:selectAllChat();">Select All</a> | <a class="menu" href="javascript:copyChat();">Copy</a> | <a class="menu" href="javascript:printChat();">Print</a>&nbsp;</font></td>
          </tr>
        </table>
       </td>
      </tr>
      <tr>
        <td width="500" height="450" valign="top">
          <iframe src="form-chatcontent.jsp" name="vFrame" id="vFrame" width="500" height="450" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
        </td>
      </tr>
     </table>
    </td>
  </tr>
  <tr>
<% if (lsInfo.ShowLeftArea!=0) {%>
    <td width="160" align="right"><font size=2><%=bean.getLabelText(cfInfo, "typehere-lab")%></font>&nbsp;&nbsp;</td>
<% } %>
    <td width="500">
     <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="390">
          <input type="text" name="talkinput" style="width: 390px">
        </td>
        <td width="110" align="right">
          <input type="button" name="sendmessage" value="<%=bean.getLabelText(cfInfo, "sendchat-but")%>" style="width: 40px" onClick="sendMessage(document.livechat);">
          <input type="button" name="endchat" value="<%=bean.getLabelText(cfInfo, "endchat-lab")%>" style="width: 62px" onClick="stopChat(document.livechat);">
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
<% } %>
</html>