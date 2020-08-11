<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%
{
    CustomerWeb web = new CustomerWeb(session, request, 10);
//    ConfigInfo cfInfo = web.getConfigInfo();
    int nErrorNo = 0;
    if (sRealAction.startsWith("Send"))
    {
       ret = web.tellfriends(request);
       if (ret.isSuccess())
       {
//       response.sendRedirect("../admin/response/tellfriend.jsp");
         sDisplayMessage = (String) ret.getInfoObject();
         nDisplay = 1;
       }
       else
       {
         Errors errObj = (Errors)ret.getInfoObject();
         nErrorNo = errObj.getErrorNo();
         sDisplayMessage = errObj.getError();
         nDisplay = 0;
       }
    }


    sPageTitle = "Tell Your Friends";

//Utilities.dumpObject(info);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<form name="form_tellfriend" method="post" action="index.jsp" onsubmit="return validateTellFriend(this);">
<input type="hidden" name="action1" value="">
 <TABLE style="background-color:#ffffff;border:#C3D9FF 1px solid;" border="0" cellpadding="5" cellspacing="3" width="100%" height="300">
  <TR>
   <TD style="text-align: center;" bgcolor="#e8eefa" align="center" valign="top" width="100%">
<!--script>createTableOpen();</script-->
  <table cellpadding=0 cellspacing=0 border=0 align="center" width="100%">
  <tr vAlign="middle">
    <td colspan="2" height=22 align="left" valign="top"><font size=1>Fields marked with an asterisk * are required</font></td>
  </tr>
   <tr>
    <td width="49%" align="right" height="22">* Your first friend's E-Mail:&nbsp;&nbsp;</td>
    <td width="51%"><input type="text" name="friendemail1" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail1"))%>"></td>
  </tr>
  <tr>
    <td width="49%" align="right" height="22">Your second friend's E-Mail:&nbsp;&nbsp;</td>
    <td width="51%"><input type="text" name="friendemail2" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail2"))%>"></td>
  </tr>
  <tr>
    <td width="49%" align="right" height="22">Your third friend's E-Mail:&nbsp;&nbsp;</td>
    <td width="51%"><input type=text name="friendemail3" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail3"))%>"></td>
  </tr>
  <tr>
    <td width="49%" align="right" height="22">Your forth friend's E-Mail:&nbsp;&nbsp;</td>
    <td width="51%"><input type=text name="friendemail4" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail4"))%>"></td>
  </tr>
  <tr>
    <td width="49%" align="right" height="22">Your fifth friend's E-Mail:&nbsp;&nbsp;</td>
    <td width="51%"><input type=text name="friendemail5" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail5"))%>"></td>
  </tr>
  <tr>
    <td width="49%" align="right" height="22">* Your E-Mail:&nbsp;&nbsp;</td>
    <td width="51%"><input type="text" name="email" size="34" maxlength="60" value="<%=Utilities.getValue(request.getParameter("email"))%>"></td>
  </tr>
  <tr>
    <td width="49%" align="right" valign="top">* Enter the code shown below:&nbsp;&nbsp;
    <br>(This will prevent automated emails)&nbsp;&nbsp;
    </td>
    <td width="51%"><input maxlength=20 size=20 name="input">&nbsp;<a href="javascript:ChildWin=window.open('/staticfile/web/imagecode-help.html','imagecode_help','resizable=yes,scrollbars=no,width=460,height=450');ChildWin.focus()">More Info</a>
    <br><img src="../../admin/util/captcha.jsp?action=getimage" align="top" alt="Enter the characters appearing in this image" border="1"/>
    </td>
  </tr>
  <tr>
   <td colspan="2" width="100%">
   <table cellpadding=0 cellspacing=0 border=0>
    <tr>
      <td colspan=2 height="10"></td>
    </tr>
    <tr>
      <td width="12%" align="right">* Subject:&nbsp;&nbsp;</td>
      <td><input type="text" name="subject" maxlength=256 value="Check out this website" size=76 style="width: 600px">
      </td>
    </tr>
    <tr>
      <td width="12%" align="right" valign="top">* Content:&nbsp;&nbsp;</td>
      <td>
        <textarea name="content" rows=8 cols=85 style="width: 600px"><%=Utilities.getValue(web.getTellFriendContent())%></textarea>
      </td>
    </tr>
    <tr>
      <td colspan=2 height="5"></td>
    </tr>
    <tr>
      <td colspan=2 align="center"><input type="submit" name="submit" value="Send Now" onClick="setAction(document.form_tellfriend, 'Send_TellFriend');"></td>
    </tr>
   </table>
  </td>
 </tr>
</table>
<!--script>createTableClose();</script-->
  </TD>
 <TR>
</table>
</FORM>
<!--SCRIPT>onTellFriendLoad(document.form_tellfriend, "")</SCRIPT-->
<% } %>