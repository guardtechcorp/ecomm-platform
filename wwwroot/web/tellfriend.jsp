<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/tellfriend.js" type="text/javascript"></SCRIPT>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 10);
  ConfigInfo cfInfo = web.getConfigInfo();

  String sAction = web.getRealAction(request);
  String sDisplayMessage = null;
  String sClass = "failed";
  int nErrorNo = 0;
  if ("Send Now".equalsIgnoreCase(sAction))
  {
/*
     CustomerWeb.Result ret = web.tellfriends(request);
     if (ret.isSuccess())
     {
//       response.sendRedirect("../admin/response/tellfriend.jsp");
       sDisplayMessage = (String) ret.getInfoObject();
       sClass = "successful";
     }
     else
     {
       Errors errObj = (Errors)ret.getInfoObject();
       nErrorNo = errObj.getErrorNo();
       sDisplayMessage = errObj.getError();
     }
*/
  }
%>
<table cellspacing=4 cellpadding=4 width="100%" align="center" height="100%">
  <TR vAlign="middle" >
    <TD height=10></TD>
  </TR>
  <TR vAlign="middle" >
    <TD height=20 align="center"><b><font size="3" Color="#4279bd" face="Verdana, Arial, Helvetica, sans-serif"><%=web.getLabelText(cfInfo, "tellfrend-lab")%></font></b></TD>
  </TR>
  <TR vAlign="middle">
    <TD height=5 align="center"></TD>
  </TR>
  <TR valign="top">
   <TD align="center">
<!--script>createTableOpen();</script-->
    <form name="tellfriend" method="post" action="index.jsp" onsubmit="return validateTellFriend(this);">
    <input type="hidden" name="action1" value="">
    <table cellpadding=0 cellspacing=0 border=0 width="96%" align="center" bgcolor1="#EEF3DF">
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td colspan="2" align="center"><span class="<%=sClass%>"><font size="2" face="arial"><%=sDisplayMessage%></font></span></td>
    </tr>
<% } %>
  <TR vAlign="middle">
    <TD height=10 align="center"></TD>
  </TR>
      <tr>
        <td width="49%" align="right"><font size="2"><%=web.getLabelText(cfInfo, "firstemail-lab")%>*</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td width="51%"><input type="text" name="friendemail1" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail1"))%>"></td>
      </tr>
      <tr>
        <td width="49%" align="right"><font size="2"><%=web.getLabelText(cfInfo, "secondemail-lab")%></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td width="51%"><input type="text" name="friendemail2" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail2"))%>"></td>
      </tr>
      <tr>
        <td width="49%" align="right"><font size="2"><%=web.getLabelText(cfInfo, "thirdemail-lab")%></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td width="51%"><input type=text name="friendemail3" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail3"))%>"></td>
      </tr>
      <tr>
        <td width="49%" align="right"><font size="2"><%=web.getLabelText(cfInfo, "forthemail-lab")%></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td width="51%"><input type=text name="friendemail4" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail4"))%>"></td>
      </tr>
      <tr>
        <td width="49%" align="right"><font size="2"><%=web.getLabelText(cfInfo, "fifthemail-lab")%></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td width="51%"><input type=text name="friendemail5" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail5"))%>"></td>
      </tr>
      <tr>
        <td width="49%" align="right"><font size="2"><%=web.getLabelText(cfInfo, "youremail-lab")%>*</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td width="51%"><input type="text" name="email" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("email"))%>"></td>
      </tr>
      <tr>
        <td width="49%" align="right" valign="top"><font size="2"><%=web.getLabelText(cfInfo, "codeshown-lab")%>*</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <br>(<%=web.getLabelText(cfInfo, "codeshown-des")%>)&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
        <td width="51%"><input maxlength=20 size=20 name="input">&nbsp;<a href="javascript:ChildWin=window.open('/staticfile/web/imagecode-help.html','imagecode_help','resizable=yes,scrollbars=no,width=460,height=450');ChildWin.focus()">More Info</a>
        <br><img src="../admin/util/captcha.jsp?action=getimage" align="top" alt="Enter the characters appearing in this image" border="1"/>
        </td>
      </tr>
    </table>
  <table cellpadding=0 cellspacing=0 border=0 width=80% bgcolor1="#EEF3DF">
    <tr>
      <td colspan=2 height="20"></td>
    </tr>
    <tr>
      <td colspan=2><font size="2"><%=web.getLabelText(cfInfo, "subject-lab")%>*</font>
      <input type="text" name="subject" maxlength=256 value="Check out this website" size=76 style="width: 470px"></td>
    </tr>
    <tr>
      <td colspan=2 height="10"></td>
    </tr>
    <tr>
      <td colspan=2><font size="2" face="arial"><%=web.getLabelText(cfInfo, "emailcontent-lab")%></font></td>
    </tr>
    <tr>
      <td colspan=2>
        <!--textarea name="content" rows=15 cols=85 wrap="soft" style="width: 540px">Utilities.getValue(web.getContent(-1, "TellFriendID"))</textarea-->
        <textarea name="content" rows=15 cols=85 wrap="soft" style="width: 540px"><%=Utilities.getValue(web.getTellFriendContent())%></textarea>
      </td>
    </tr>
    <tr>
      <td colspan=2>&nbsp;</td>
    </tr>
    <tr>
      <td colspan=2 align="center"><input type="submit" name="sendnow" value="<%=web.getLabelText(cfInfo, "sendnow-but")%>" onClick="setAction(document.tellfriend, 'Send Now');"></td>
    </tr>
  </table>
  </form>
<!--script>createTableClose();</script-->
  </TD>
 <TR>
</table>
<SCRIPT>onTellFriendLoad(document.tellfriend, <%=nErrorNo%>)</SCRIPT>
<% } %>