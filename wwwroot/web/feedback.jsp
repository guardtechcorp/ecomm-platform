<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/feedback.js" type="text/javascript"></SCRIPT>
<%@ page import="com.zyzit.weboffice.web.FeedbackWeb"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%
{
  FeedbackWeb web = new FeedbackWeb(session);
  ConfigInfo cfInfo = web.getConfigInfo();
  String sAction = web.getRealAction(request);

  String sDisplayMessage = null;
  String sClass = "failed";
  if ("Submit Now".equalsIgnoreCase(sAction))
  {
     FeedbackWeb.Result ret = web.submitNow(request);
     if (ret.isSuccess())
     {
       sDisplayMessage = (String) ret.m_UpdateInfo;
       sClass = "successful";
     }
     else
     {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
     }
  }
//System.out.println("sDisplayMessage=" + sDisplayMessage);
%>
<table cellspacing=4 cellpadding=4 width="100%" align="center" height="100%">
  <TR vAlign="middle" >
    <TD height=10></TD>
  </TR>
  <TR vAlign="middle" >
    <TD height=20 align="center"><b><font size="3" Color="#4279bd" face="Verdana, Arial, Helvetica, sans-serif"><%=web.getLabelText(cfInfo, "feedback-lab")%></font></b></TD>
  </TR>
  <TR vAlign="middle">
    <TD height=5 align="center"></TD>
  </TR>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td height="12" align="center"><span class="<%=sClass%>"><font size="2" face="arial"><%=sDisplayMessage%></font></span></td>
    </tr>
<% } %>
  <TR vAlign="middle">
    <TD height=5 align="center"></TD>
  </TR>
  <TR valign="top">
   <TD align="center">
      <form name="feedback" method="post" action="index.jsp" onsubmit="return validateFeedback(this);">
      <input type="hidden" name="action1" value="">
     <!--script>createTableOpen();</script-->
        <table cellpadding=0 cellspacing=0 border=0 width=90% bgcolor1="#F1F1FD">
          <tr>
            <td width="40%" align="right"><font size="2"><%=web.getLabelText(cfInfo, "yourname-lab")%>*</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td width="60%"><input type="text" name="yourname" size="32" maxlength="60"></td>
          </tr>
          <tr>
            <td width="40%" align="right"><font size="2"><%=web.getLabelText(cfInfo, "yourphone-lab")%></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td width="60%"><input type="text" name="phone" size="32" maxlength="60">&nbsp;<%=web.getLabelText(cfInfo, "optional-des")%></td>
          </tr>
          <tr>
            <td width="40%" align="right"><font size="2"><%=web.getLabelText(cfInfo, "youremail-lab")%>*</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td width="60%"><input type="text" name="email" size="32" maxlength="60"></td>
          </tr>
          <tr>
            <td colspan=2 height="20"></td>
          </tr>
          <tr>
            <td colspan=2><font size="2"><%=web.getLabelText(cfInfo, "feedback-des")%></font></td>
          </tr>
          <tr>
            <td colspan=2>
              <textarea name="content" rows=18 cols=80 wrap="soft" style="width: 540px"></textarea>
            </td>
          </tr>
          <tr>
            <td colspan=2>&nbsp;</td>
          </tr>
          <tr>
            <td colspan=2 align="center"><input type="submit" name="submit" value="<%=web.getLabelText(cfInfo, "submitnow-but")%>" onClick="setAction(document.feedback, 'Submit Now');"></td>
          </tr>
          <tr>
            <td colspan=2>&nbsp;</td>
          </tr>
        </table>
    </form>
   <!--script>createTableClose();</script-->
  </TD>
 <TR>
</table>
<SCRIPT>onFeedbackLoad(document.feedback)</SCRIPT>
<% } %>