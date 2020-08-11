<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 0);
  ConfigInfo cfInfo = web.getConfigInfo();
//web.showAllParameters(request, out);
  String sAction = web.getRealAction(request);
  String sDisplayMessage = null;
  String sClass = "successful";
  CustomerInfo ctInfo = null;
  if (sAction.endsWith("submit-accountlogin"))
  {
    CustomerWeb.Result ret = web.logon(request);
    if (!ret.isSuccess())
    {
      ctInfo = (CustomerInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Remove the link of its navigation
      web.removeNavigation("Account Login");
      String sNextAction = request.getParameter("nextaction");
      if (sNextAction==null||sNextAction.length()==0)
         sNextAction = "cp-edit-accountinfo";//"cp-view-myaccount";
//System.out.println("After Login=" + "index.jsp?action=" + sNextAction + "&type=afterlogin");

      TransferWeb.sendRedirectContent(response, "index.jsp?action=" + sNextAction + "&type=afterlogin");
//      response.sendRedirect(web.encodedUrl("index.jsp?action=" + sNextAction + "&type=afterlogin"));
      return;
    }
  }
/*
  else if (sAction.endsWith("logout-accountlogin"))
  {
      web.sessionFinish(request);
  }
*/
  else if (sAction.endsWith("passwordget-accountlogin"))
  {
     CustomerWeb.Result ret = web.forgotPassword(request);
     if (!ret.isSuccess())
     {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
       sClass = "failed";
     }
     else
     {
       sDisplayMessage = (String)ret.getInfoObject();
     }
  }
  else if (sAction.endsWith("logout-accountlogin"))
  {
//    if (web.getInfo(request)!=null)//. Customer has logon already
//       response.sendRedirect(web.encodedUrl("index.jsp?action=ordertracklist&type=afterlogin"));
  }

  String sTitleLinks = web.getNavigationWeb(request, "Account Login");
%>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
<tr>
<td height=20><%=sTitleLinks%></td>
</tr>
<TR>
<TD height=1 valign="top"></TD>
</TR>
<TR>
 <TD>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/moneypocket.js" type="text/javascript"></SCRIPT>
<table cellspacing=2 cellpadding=2 width="100%" align="center">
  <FORM name="memberlogin" action="<%=web.encodedUrl("index.jsp")%>" method="post">
  <INPUT type="hidden" name="action1" value="">
  <INPUT type="hidden" name="nextaction" value="<%=Utilities.getValue(request.getParameter("nextaction"))%>">
    <TR>
      <TD height=10></TD>
    </TR>
    <TR>
      <TD height=20 align="center"><font class='pagetitle'size="3" Color="#4279bd"><%=web.getLabelText(cfInfo, "logon-lab")%></font></TD>
    </TR>
<% if (sDisplayMessage!=null) { %>
    <TR>
      <TD height=20 align="center"><b><span class="<%=sClass%>"><%=sDisplayMessage%></span></b></TD>
    </TR>
<% } %>
    <TR>
      <TD>
        <script>createTableOpen();</script>
        <table width="400" height="150" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=cfInfo.BackColor%>">
          <tr>
            <td width="40%" align="right"><%=web.getLabelText(cfInfo, "email-lab")%></td>
            <td width="60%">
              <input type="text" maxlength=50 size=36 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>">
            </td>
          </tr>
          <tr>
            <td width="40%" align="right"><%=web.getLabelText(cfInfo, "password-lab")%></td>
            <td width="60%">
              <input type="password" maxlength=20 size=36 name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>">
            </td>
          </tr>
          <tr>
            <td width="40%" align="right">
              <a onClick="return hasEmailAccount(document.memberlogin);" href="javascript:submitFormByAction(document.memberlogin, 'cp-passwordget-accountlogin')"><%=web.getLabelText(cfInfo, "forgot-password")%></a>
            </td>
            <td width="60%">
              <input type="submit" value="<%=web.getLabelText(cfInfo, "login-account")%>" name="sumbit" onClick="return validateLogon(document.memberlogin, 'cp-submit-accountlogin');">
            </td>
          </tr>
        </table>
        <script>createTableClose();</script>
      </TD>
    </TR>
    <TR>
      <TD height=6>&nbsp;</TD>
    </TR>
</FORM>
<SCRIPT>OnLogonLoad(document.memberlogin);</SCRIPT>
    <TR>
      <TD height=6 align="center"><hr width="90%"></TD>
    </TR>
    <TR>
    <td align="center"><font class='pagetitle'size="3" Color="#4279bd">Setup a new Account</font></td>
    </TR>
    <TR>
     <TD>
    <script>createTableOpen();</script>
    <table width="400" height="150" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=cfInfo.BackColor%>">
      <tr>
        <td>If you do not have an account in our online system, we recommand you create an account to securely save your information for future purchase and tracking.
        With the account you don't have to enter the informaton each time you buy reports. And also you can manage your credit, track your transaction history
        and get any archived reports that generated before in any time for free.
        </td>
      </tr>
      <tr>
        <td align="center" height=1></td>
      </tr>
      <tr>
        <!--td align="center">
         <script>createLeftButton();</script>
         <a class="button" href="<%=web.getHttpsLink("index.jsp?action=cp-create-accountinfo")%>">Setup Account</a>
         <script>createRightButton();</script>
        </td-->
      <td align="center">
        <input type="button" value="Setup Account" name="setup" onClick="goToLinkPage('<%=web.getHttpsLink("index.jsp?action=cp-create-accountinfo")%>');">
      </td>
     </tr>
    </table>
    <script>createTableClose();</script>
   </TD>
  </TR>
 </table>
 </td>
 </tr>
</table>
<% } %>