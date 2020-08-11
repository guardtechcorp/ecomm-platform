<HTML>
<HEAD>
<Title>Feedback</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<LINK href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/windows.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/tellfriend.js" type="text/javascript"></SCRIPT>
</HEAD>
<body onLoad="OnTellFriendLoad(document.tellfriend);">
<%@ page import="com.zyzit.weboffice.web.TellFriendsWeb"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%
  TellFriendsWeb web = new TellFriendsWeb();
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "failed";
  if ("Send Now".equalsIgnoreCase(sAction))
  {
/*
     TellFriendsWeb.Result ret = web.submit(request);
     if (ret.isSuccess())
     {
       sDisplayMessage = (String) ret.getInfoObject();
       sClass = "successful";
     }
     else
     {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
     }

     String sReturnURL = request.getParameter("return_url");
     if (sReturnURL!=null)
     {
        response.sendRedirect(sReturnURL);
        return;
     }
*/
  }
%>
<form name="tellfriend" method="post" action="form-tellfriend.jsp" onsubmit="return validateTellFriend(this);">
<input type="hidden" name="domainname" value="<%=Utilities.getValue(web.getDomainNameFromUrl(request))%>">
<table cellspacing=0 cellpadding=0 width="98%" align="center" height="100%">
  <TR>
    <TD height="5"></TD>
  </TR>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td align="center"><span class="<%=sClass%>"><font size="2" face="arial"><%=sDisplayMessage%></font></span></td>
    </tr>
<% } %>
  <TR>
    <TD height="5"></TD>
  </TR>
  <TR valign="top">
   <TD align="center">
   <script>createTableOpen();</script>
    <table cellpadding=0 cellspacing=0 border=0 width="100%" align="center">
  <TR vAlign="middle">
    <TD height=10 align="center"></TD>
  </TR>
      <tr>
        <td width="40%" align="right">Your 1st friend's E-Mail address:*&nbsp;&nbsp;&nbsp;</td>
        <td width="60%"><input type="text" name="friendemail1" size="34" maxlength="60"></td>
      </tr>
      <tr>
        <td width="40%" align="right">Your 2nd friend's E-Mail address:&nbsp;&nbsp;&nbsp;</td>
        <td width="60%"><input type="text" name="friendemail2" size="34" maxlength="60"> (Optional)</td>
      </tr>
      <tr>
        <td width="40%" align="right">Your 3rd friend's E-Mail address:&nbsp;&nbsp;&nbsp;</td>
        <td width="60%"><input type=text name="friendemail3" size="34" maxlength="60"> (Optional)</td>
      </tr>
      <tr>
        <td width="40%" align="right">Your 4th friend's E-Mail address:&nbsp;&nbsp;&nbsp;</td>
        <td width="60%"><input type=text name="friendemail4" size="34" maxlength="60"> (Optional)</td>
      </tr>
      <tr>
        <td width="40%" align="right">Your 5th friend's E-Mail address:&nbsp;&nbsp;&nbsp;</td>
        <td width="60%"><input type=text name="friendemail5" size="34" maxlength="60"> (Optional)</td>
      </tr>
      <tr>
        <td width="40%" align="right">Your E-Mail address:*&nbsp;&nbsp;&nbsp;</td>
        <td width="60%"><input type="text" name="email" size=40 maxlength=60></td>
      </tr>
    </table>
  <table cellpadding=0 cellspacing=0 border=0 width=100%>
    <tr>
      <td colspan=2 height="20"></td>
    </tr>
    <tr>
      <td width="18%" align="right">Subject:&nbsp;&nbsp;&nbsp;</td>
      <td width="82%"><input type="text" name="subject" maxlength="256" value="Check out this website" size="72"></td>
    </tr>
    <tr>
      <td colspan=2 height="25">E-Mail Content:</td>
    </tr>
    <tr>
      <td colspan=2>
        <textarea name="content" rows="13" cols="68" wrap="soft"><%=web.getDefaultContent(request)%></textarea>
      </td>
    </tr>
    <tr>
      <td colspan=2>&nbsp;</td>
    </tr>
    <tr>
      <td colspan=2 align="center"><input type="submit" name="action" value="Send Now"></td>
    </tr>
  </table>
  <script>createTableClose();</script>
  </TD>
 <TR>
</table>
</form>
</body>
</html>