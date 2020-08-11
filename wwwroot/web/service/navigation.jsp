<%@ page import="com.zyzit.weboffice.model.*" %>
<%@ page import="com.zyzit.weboffice.bean.Apollogen.RequisitionWeb" %>
<%
//web.dumpAllParameters(request);
   RequisitionWeb web = new RequisitionWeb(session, request, 10);
   CustomerWeb webCustomer = new CustomerWeb(session, request, 0);

   CustomerInfo loginInfo = webCustomer.getCustomerInfo();
   String sActionProp = request.getParameter("actionprop");//webCustomer.getRealAction(request);
   if (Utilities.getValueLength(sActionProp)==0)
      sActionProp = webCustomer.getRealAction(request);

   String sErrorMessage = request.getParameter("errormessage");
   String sErrorClass = request.getParameter("errorclass");

   NavigationInfo.Navigation currentPage = NavigationInfo.Navigation.SignIn;
%>
<%@ include file="../util/function.jsp"%>

<% if (loginInfo==null) { %>
    <% if (sActionProp.startsWith("SignUp")) {
       currentPage = NavigationInfo.Navigation.SignUp;
    %>
      <%@ include file="signup.jsp"%>
    <% } else { %>
      <%@ include file="signin.jsp"%>
    <% } %>
<% } else { %>

    <% if (sActionProp.startsWith("Profile")) {
        currentPage = NavigationInfo.Navigation.Profile;
    %>
        <%@ include file="profile.jsp"%>
    <% } else if (sActionProp.startsWith("Billing")) {
        currentPage = NavigationInfo.Navigation.CreditCard;
    %>
        <%@ include file="billing.jsp"%>
    <% } else if (sActionProp.startsWith("ListPage")) { %>
        <%@ include file="listpage.jsp"%>
    <% } else if (sActionProp.startsWith("ViewPage")) { %>
        <%@ include file="viewpage.jsp"%>
    <% } %>
<% } %>