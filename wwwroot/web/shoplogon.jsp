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
<div class="shopLogonWrap">
  <div class="breadcrumbWrap">
    <a href="<%=web.getContinueShop()%>"><%=web.getLabelText(cfInfo, "shopping-link")%></a> &gt; <a href="<%=web.encodedUrl("index.jsp?action=shopcart")%>"><%=web.getLabelText(cfInfo, "cart-link")%></a>
    &gt; <font color="#FF0000"><%=web.getLabelText(cfInfo, "logon-link")%></font> &gt; <%=web.getLabelText(cfInfo, "confirm-link")%> &gt; <%=web.getLabelText(cfInfo, "finish-link")%>
</div>
<div class="shopLogFormWrap">
     <form name="shoplogon" action="index.jsp" method="post">
     <input type="hidden" name="shipmethod" value="<%=request.getParameter("shipmethod")%>">
     <input type="hidden" name="action1" value="">

       <% if (sDisplayMessage!=null) { %>
           <div class="<%=sClass%>"><%=sDisplayMessage%></span></div>
       <% } %>

    <div class="existingForm">
            <h5><%=web.getLabelText(cfInfo, "exist-lab")%></h5>
            <p><%=web.getLabelText(cfInfo, "exist-des")%></p>

        <label>Email<!-- <%=web.getLabelText(cfInfo, "email-lab")%> --></label>
      <input type="text" maxlength=50 size=24 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>">
        <label>Password<!-- <%=web.getLabelText(cfInfo, "password-lab") %> --></label>
        <input type="password" maxlength=20 size=24 name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>">
        <input type="submit" value="<%=web.getLabelText(cfInfo, "login-account")%>" name="loginaccount" onClick="return validateLogon(document.shoplogon, 'Login My Account');">
        <a class="forgotPW" onClick="return hasEmailAccount(document.shoplogon);" href="javascript:submitForgotPassword(document.shoplogon)"><%=web.getLabelText(cfInfo, "forgot-password")%></a>

      </div>
        <div class="newcustForm">
            <h5><%=web.getLabelText(cfInfo, "newcust-lab")%></h5>
            <p><%=web.getLabelText(cfInfo, "newcust-des")%></p>
            <input type="submit" value="<%=web.getLabelText(cfInfo, "newcust-lab")%>" name="newcustomer" onClick="setAction(document.shoplogon, 'New Customer');">
        </div>


    </form>
  </div>
      <script>OnLogonLoad(document.shoplogon);</script>
    <div class="botInfoshoplog"><%=web.getTestInfo(dmInfo, cfInfo)%></div>
<div class="disclaimerBox">
  <%=web.getLabelText(cfInfo, "info-des")%>
</div>
</div>
<% } %>
