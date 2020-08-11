<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean" %>
<%@ page import="com.zyzit.weboffice.model.ShareAccessInfo" %>
<%@ page import="com.zyzit.weboffice.model.MemberInfo" %>
<%@ page import="edu.stanford.ejalbert.BrowserLauncher" %>
<%
{
    MemberFileBean bean = MemberFileBean.getObject(session);
//MemberAccountBean.dumpAllParameters(request);
//System.out.println("ShareFile Action=" + sRealAction);
    ShareAccessInfo info = null;
    boolean bCanDownload = false;
    if (sRealAction.startsWith("Load"))
    {
        ret = bean.getShareInfo(request);
        info = (ShareAccessInfo) ret.getUpdateInfo();
        if (!ret.isSuccess()) {
            nDisplay = 0;
            sDisplayMessage = (String) ret.getInfoObject();
        }
/*
        else
        {
            if (info.AccessMode==Definition.ACCESSMODE_PUBLIC)
                bCanDownload = true;
            else if (info.AccessMode==Definition.ACCESSMODE_MYSITEMEMBER)
            {
               if (bean.getMemberInfo()!=null)
                  bCanDownload = true;
            }
        }
*/
    }

    StringBuffer sbMessage = new StringBuffer();
    String sSubjectNote = null, sContentNote = null;

    if (ret.isSuccess() && info!=null)
    {
        if (info.AccessMode == Definition.ACCESSMODE_PUBLIC) {
            sSubjectNote = "Download a shared file/folder now.";
            sbMessage.append("<UL><LI>You just need to click 'download' button to start to download process.</LI><p>");
            sbMessage.append("<LI>After the process is finished, just to close the download window.</LI></UL>");
        } else if (info.AccessMode == Definition.ACCESSMODE_LOGINUSER) {
            sSubjectNote = "Only a signed-in user can download this file/folder.";
            sbMessage.append("<UL><LI>If you are not a user in <b>WebCetner</b> network, please <A class='focuslink' style='font-weight1:bold' href='" + mcBean.encodedUrl("index.jsp?action=Load_SignUp&rl=1&pt=Sign Up Informaton") + "'>Sign Up</A> now</LI><p>");
            sbMessage.append("<LI>If you are a user in <b>WebCetner</b> network already, just sign in now.</LI></UL>");
        } else if (info.AccessMode == Definition.ACCESSLEVEL_NEEDMEMBERLOGIN) {
            sSubjectNote = "Only a member of this site can download this file/folder.";
            sbMessage.append("<UL><LI>If you are not a user in <b>WebCetner</b> network, please <A class='focuslink' style='font-weight1:bold' href='" + mcBean.encodedUrl("index.jsp?action=Load_SignUp&rl=1&pt=Sign Up Informaton&apply=1") + "'>Sign Up</A> ");
            sbMessage.append("with 'Apply to be a member of the site' is checked.</LI><p>");
            sbMessage.append("<LI>If you are a user in <b>WebCetner</b> network already, please sign in first, and then apply its membership.</LI><p>");
            sbMessage.append("<LI>If you are a member of this site already, just sign in now.</LI></UL>");
        } else {
            sSubjectNote = "To download this file or folder, you need to enter the unlock code.";
            sbMessage.append("<UL><LI>You need to enter the unlock code that emailed with this link</LI></UL>");
        }
    }
    else
    {
        if (sDisplayMessage==null)
        {
           sDisplayMessage = "It is not a valid sharing file/folder. Please check it and try it again.";
           nDisplay = 0;
        }
    }

    sContentNote = sbMessage.toString();

/*
 if (bCanDownload) {
//   BrowserLauncher browserLauncher = new BrowserLauncher(null);
//   browserLauncher.openURLinBrowser("http://www.yahoo.com");
       String sHref = bean.encodedUrl("index.jsp?action=DownloadShare_FileStorage&accessby=127&shareid=" + info.ShareID);
       StringBuffer sbScript = new StringBuffer();
       sbScript.append("<SCRIPT>");
       sbScript.append("showDownloadFile('DownloadWin','Download is processing and Close it when the process ends','");
       sbScript.append(sHref + "');");
       sbScript.append("</SCRIPT>");

<TABLE width="100%" align="right" border=0>
<TR>
<TD height=15 align="center"></TD>
</TR>
<TR>
<TD height=15 align="center"><h1>The download process is starting now. Thank you.</h1>
<=sbScript.toString()>
</TD>
</TR>
</TABLE>
*/

%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="form_sharefile" action="#" method="post">
<INPUT type="hidden" name="rt" value="1">
<INPUT type="hidden" name="action1" value="">
<INPUT type="hidden" name="shareid" value="<%=info.ShareID%>">
<input type="hidden" name="remember" value="0">
<TABLE width="100%" align="right" border=0>
<TR>
  <TD height="10"></TD>
</TR>
<% if (!ret.isSuccess()||info==null) { %>
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
<% } else { %>
<TR>
  <TD height="1" align="center">
   <%@ include file="../include/promotenote.jsp"%>
  </TD>
</TR>
<TR>
 <TD height="1" id="id_message"></td>
</TR>
<TR>
  <TD height="10"></TD>
</TR>
<TR>
<TD>
<script>createTableOpen();</script>
<table width="540" height="180" border="0" cellspacing="1" cellpadding="0" bgcolor="#e8eefa">
  <tr>
   <td colspan="2" height="20"></td>
  </tr>
<% if (info.AccessMode==Definition.ACCESSMODE_PUBLIC) { %>
  <tr>
   <td colspan="2" align="center"><input type="button" value="Download" name="submit" id="download_submit1" onClick="return startDownload(document.form_sharefile, '<%=bean.encodedUrl("ajax/response.jsp")%>');" style="width:90px; height:22px"></td>
  </tr>
<% } else if (info.AccessMode==Definition.ACCESSMODE_MYSITEMEMBER||info.AccessMode==Definition.ACCESSMODE_LOGINUSER) { %>
  <tr>
   <td width="30%" align="right"><%=mcBean.getLabel("cm-email")%>:</td>
   <td><input type="text" maxlength=50 size=40 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>"></td>
  </tr>
  <tr>
    <td width="30%" align="right"><%=mcBean.getLabel("cm-password")%>:</td>
    <td><input type="password" maxlength=20 size=40 name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>"></td>
  </tr>
  <!--TR>
    <TD width="30%" align="right"><input type="checkbox" name="remember" value="1"></TD>
    <TD>Remember Email &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onClick="return hasEmailAccount(document.form_signin);" href="javascript:forgotPassword(document.form_signin, 'Forgot Password_SignIn')">Forgot your password?</a>
    </TD>
  </TR-->
  <TR>
   <TD colspan="2" align="right" height="10"></TD>
  </TR>
  <tr>
    <td width="30%" align="right"></td>
    <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" value="Sign In" name="sumbit" id="download_submit2" onClick="return signInDownload(document.form_sharefile, '<%=bean.encodedUrl("ajax/response.jsp")%>');" style="width:90px; height:22px">
    </td>
  </tr>
  <tr>
   <td colspan="2" height="5" align="right"></td>
  </tr>
  <SCRIPT>onSignInLoad(document.form_sharefile, true);</SCRIPT>
<% } else { %>
  <tr>
   <td colspan="2" align="center"><font size=2><b><%=mcBean.getLabel("fs-entercode")%>:</b></font></td>
  </tr>
  <tr>
   <td width="30%" align="right"><%=mcBean.getLabel("cm-unlock")%>:</td>
   <td>
      <input type="text" maxlength=50 size=40 name="unlockcode" value="<%=Utilities.getValue(request.getParameter("unlockcode"))%>">
    </td>
  </tr>
<%
%>
  <tr>
   <td colspan="2" align="center"><input type="button" value="<%=mcBean.getLabel("cm-submit")%>" name="sumbit" id="download_submit3" onClick="return unLockDownload(document.form_sharefile, '<%=bean.encodedUrl("ajax/response.jsp")%>');" style="width:90px; height:22px"></td>
  </tr>
 <SCRIPT>setFocus(document.form_sharefile.unlockcode);</SCRIPT>
<% } %>
  <tr>
   <td colspan="2" height="10" align="right"></td>
  </tr>
</table>
<script>createTableClose();</script>
</TD>
</TR>
<% } %>
<TR>
<TD height=10>&nbsp;</TD>
</TR>
</TABLE>
</FORM>
<% } %>

