<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 0);
  DomainInfo dmInfo = web.getDomainInfo();
  ConfigInfo cfInfo = web.getConfigInfo();

//web.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  if (sAction==null)
     sAction = request.getParameter("action1");
  String sDisplayMessage = null;
  String sClass = "successful";
  CustomerInfo ctInfo = null;
  if ("Login My Account".equalsIgnoreCase(sAction))
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
    { //. Should remove
      response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm&shipmethod="+request.getParameter("shipmethod")));
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
  else if ("Check Out".equalsIgnoreCase(sAction))
  {
//. Should remove
    ShopCartWeb shopcart = new ShopCartWeb(session, request, 100);
    List ltShopCart = shopcart.getShopCartList(request, response);
//System.out.println("Go to Check out = " + web.getHttpsLink("index.jsp?action=checkout"));
    response.sendRedirect(web.getHttpsLink("index.jsp?action=checkout"));
  }

  else
  {//. Should remvoe
     if (web.getInfo(request)!=null)//. Customer has logon already
     {
        response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm&shipmethod="+request.getParameter("shipmethod")));
        return;
     }    
  }
*/
%>
<table cellspacing=2 cellpadding=2 width="100%" height="530" align="center"><tr><td valign="top">
&nbsp;&nbsp;<img src="/staticfile/web/images/tp06.gif" align="CENTER"><a href="<%=web.getContinueShop()%>"><%=web.getLabelText(cfInfo, "shopping-link")%></a> > <a href="<%=web.encodedUrl("index.jsp?action=shopcart")%>"><%=web.getLabelText(cfInfo, "cart-link")%></a> >
<font color="#FF0000"><%=web.getLabelText(cfInfo, "logon-link")%></font> > <%=web.getLabelText(cfInfo, "confirm-link")%> > <%=web.getLabelText(cfInfo, "finish-link")%>
<TABLE class="table-shang" cellspacing=0 cellpadding=5 width="100%" align="right">
  <TR>
    <TD height=20>
     <table align="center" border="0" cellpadding="10" cellspacing="0" width="100%" class="infobox">
      <tr>
       <td><img src="/staticfile/web/images/info.gif" height=14 width=14>
       <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font color="#FF6633"><%=web.getLabelText(cfInfo, "info-lab")%></font>
       <%=web.getLabelText(cfInfo, "info-des")%></font>
       </td>
      </tr>
     </table>
   </TD>
  </TR>
<% if (sDisplayMessage!=null) { %>
  <TR>
    <TD height=20 align="center"><b><span class="<%=sClass%>"><%=sDisplayMessage%></span></b></TD>
  </TR>
<% } %>
  <TR>
    <TD>
     <FORM name="shoplogon" action="index.jsp" method="post">
     <INPUT type="hidden" name="shipmethod" value="<%=request.getParameter("shipmethod")%>">
     <INPUT type="hidden" name="action1" value="">
      <script>createTableOpen();</script>
      <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=cfInfo.BackColor%>">
        <tr>
          <td colspan="2">
            <div align="center"><b><%=web.getLabelText(cfInfo, "exist-lab")%></b></div>
          </td>
          <td width="49%">
            <div align="center"><b><%=web.getLabelText(cfInfo, "newcust-lab")%></b></div>
          </td>
        </tr>
        <tr>
          <td colspan="2"><%=web.getLabelText(cfInfo, "exist-des")%></td>
          <td width="49%"><%=web.getLabelText(cfInfo, "newcust-des")%></td>
        </tr>
        <tr>
          <td width="23%" align="right"><%=web.getLabelText(cfInfo, "email-lab")%></td>
          <td width="28%"><input type="text" maxlength=50 size=24 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>"></td>
          <td width="49%">&nbsp;</td>
        </tr>
        <tr>
          <td width="23%" align="right"><%=web.getLabelText(cfInfo, "password-lab")%></td>
          <td width="28%"><input type="password" maxlength=20 size=24 name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>"></td>
          <td width="49%">&nbsp;</td>
        </tr>
        <tr>
          <td width="23%" align="center"><a onClick="return hasEmailAccount(document.shoplogon);" href="javascript:submitForgotPassword(document.shoplogon)"><%=web.getLabelText(cfInfo, "forgot-password")%></a></td>
          <td width="28%"><input type="submit" value="<%=web.getLabelText(cfInfo, "login-account")%>" name="loginaccount" onClick="return validateLogon(document.shoplogon, 'Login My Account');"></td>
          <td width="49%" align="center"><input type="submit" value="<%=web.getLabelText(cfInfo, "newcust-lab")%>" name="newcustomer" onClick="setAction(document.shoplogon, 'New Customer');"></td>
        </tr>
      </table>
      <script>createTableClose();</script>
      </FORM>
      <SCRIPT>OnLogonLoad(document.shoplogon);</SCRIPT>
    </TD>
  </TR>
  <TR>
    <TD align="center"><%=web.getTestInfo(dmInfo, cfInfo)%></TD>
  </TR>
</TABLE>
</td></tr></table>
<% } %>