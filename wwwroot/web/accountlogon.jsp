<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 0);
  ConfigInfo cfInfo = web.getConfigInfo();
//web.showAllParameters(request, out);
  String sAction = web.getRealAction(request);
  String sDisplayMessage = null;
  String sClass = "successful";
  CustomerInfo ctInfo = null;
  if ("Login Account".equalsIgnoreCase(sAction))
  {
//    CustomerWeb.Result ret = web.logon(request);
    BasicBean.Result ret = BasicBean.getRequestResult(session);
    if (!ret.isSuccess())
    {
      ctInfo = (CustomerInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
/*Neil00
    else
    {//. Should remove
      response.sendRedirect(web.encodedUrl("index.jsp?action=ordertracklist&type=afterlogin"));
//System.out.println ("After sendredirect.");
//      response.sendRedirect("index.jsp?action=ordertracklist&type=afterlogin");
    }
*/    
  }
  else if ("forgotpassword".equalsIgnoreCase(sAction))
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
/*Neil00
  else if ("Login".equalsIgnoreCase(sAction))
  {//. Should remove
    CustomerWeb.Result ret = web.memberLogon(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
//      sClass = "failed";
      response.sendRedirect(web.encodedUrl("index.jsp?action=memberlogin&type=failed&error=" + sDisplayMessage));
    }
    else
    {
      response.sendRedirect(web.encodedUrl("index.jsp?action=memberlogin&type=success"));
    }
  }
  else
  {//. Should remove
    if (web.getInfo(request)!=null)//. Customer has logon already
    {
        response.sendRedirect(web.encodedUrl("index.jsp?action=ordertracklist&type=afterlogin"));
        return;
    }    
  }
*/
/*
java.lang.IllegalStateException
at org.apache.coyote.tomcat5.CoyoteResponseFacade.sendRedirect(CoyoteResponseFacade.java:399)
  public void sendRedirect(String location)
        throws IOException {

        if (isCommitted())
            throw new IllegalStateException
    response.setAppCommitted(true);

    response.sendRedirect(location);
}
*/
%>
<table cellspacing=2 cellpadding=2 width="100%" height="530" align="center"><tr><td valign="top">
<FORM name="shoplogon" action="index.jsp" method="post">
  <INPUT type="hidden" name="shipmethod" value="<%=request.getParameter("shipmethod")%>">
  <INPUT type="hidden" name="action1" value="">
  &nbsp;&nbsp;<img src="/staticfile/web/images/tp06.gif" align="CENTER"><font color="#FF0000"><%=web.getLabelText(cfInfo, "logon-lab")%></font> > <%=web.getLabelText(cfInfo, "vieworder-link")%>
  <table class="table-shang" cellspacing=0 cellpadding=5 width="100%" align="right">
    <TR>
      <TD height=20></TD>
    </TR>
    <TR>
      <TD height=20 align="center"><b><font size="3" Color="#4279bd" face="Verdana, Arial, Helvetica, sans-serif"><%=web.getLabelText(cfInfo, "logon-lab")%></font></b></TD>
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
              <a onClick="return hasEmailAccount(document.shoplogon);" href="javascript:submitForgotPassword(document.shoplogon)"><%=web.getLabelText(cfInfo, "forgot-password")%></a>
            </td>
            <td width="60%">
              <input type="submit" value="<%=web.getLabelText(cfInfo, "login-account")%>" name="sumbit" onClick="return validateLogon(document.shoplogon, 'Login Account');">
            </td>
          </tr>
        </table>
        <script>createTableClose();</script>
      </TD>
    </TR>
    <TR vAlign=center>
      <TD height=6>&nbsp;</TD>
    </TR>
  </TABLE>
</FORM>
</td></tr></table>
<SCRIPT>OnLogonLoad(document.shoplogon);</SCRIPT>
<% } %>
