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
<!-- <font color="#FF0000"><%=web.getLabelText(cfInfo, "logon-lab")%></font> <%=web.getLabelText(cfInfo, "vieworder-link")%>
-->
<div class="acctLogOuter">
<div class="acctLoginWrap">
<form name="shoplogon" action="index.jsp" method="post">
  <input type="hidden" name="shipmethod" value="<%=request.getParameter("shipmethod")%>">
  <input type="hidden" name="action1" value="">

      <h5>Account Login<!-- <%=web.getLabelText(cfInfo, "logon-lab")%> --></h5>
<% if (sDisplayMessage!=null) { %>
<span class="<%=sClass%>"><%=sDisplayMessage%></span>
<% } %>


      <label>Email <!-- <%=web.getLabelText(cfInfo, "email-lab")%> --></label>
      <input type="text" maxlength=50 size=36 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>">
      <label>Password<!-- <%=web.getLabelText(cfInfo, "password-lab")%> --></label>
      <input type="password" maxlength=20 size=36 name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>">
      <input type="submit" value="<%=web.getLabelText(cfInfo, "login-account")%>" name="sumbit" onClick="return validateLogon(document.shoplogon, 'Login Account');">
      <a class="forgotPW" onClick="return hasEmailAccount(document.shoplogon);" href="javascript:submitForgotPassword(document.shoplogon)"><%=web.getLabelText(cfInfo, "forgot-password")%></a>


</form>
</div>
</div>
<script>OnLogonLoad(document.shoplogon);</script>
<% } %>
