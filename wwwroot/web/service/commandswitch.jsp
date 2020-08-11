<%@ page import="java.lang.Exception"%>
<%@ page import="com.zyzit.weboffice.web.SessionWeb"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="java.util.*" %>
<%
  CustomerInfo loginInfo = null;
  String sErrorMessage = null;
  String sErrorClass = "successful";

  boolean bJustLogin = false;
  if (sActionProp.endsWith("SignUp-Submit"))
  {
      boolean valid = VerifyUtils.verify(request, null);
      if (valid)
      {
          CustomerWeb.Result ret = webCustomer.update(request, true);
          if (!ret.isSuccess())
          {
            Errors errObj = (Errors)ret.getInfoObject();
            sErrorMessage = errObj.getError();
            if (sErrorMessage==null)
               sErrorMessage = "This account has been existing in our system, please try to use another one.";
            sErrorClass = "failed";
            sActionProp = "SignUp";
          }
          else
          {
            loginInfo = (CustomerInfo)ret.getUpdateInfo();
            sActionProp = "Dashboard";
            bJustLogin = true;
          }
      }
      else
      {
          sErrorMessage = "Captcha invalid! You have to click \"I'm not a robot\"";
          sErrorClass = "failed";
          sActionProp = "SignUp";
      }
  }
  else if (sActionProp.endsWith("SignIn-Submit"))
  {
      CustomerWeb.Result ret = webCustomer.logon(request);
      if (!ret.isSuccess())
      {
        Errors errObj = (Errors)ret.getInfoObject();
        sErrorMessage = "The E-Mail and Password you entered are not matched.";
        sErrorClass = "failed";
      }
      else
      {
        loginInfo = webCustomer.getCustomerInfo();
        sActionProp = "Dashboard";
        if (Utilities.getValueLength(request.getParameter("nextaction"))>0)
        {
           sActionProp = request.getParameter("nextaction");            
        }

        bJustLogin = true;
      }
  }
  else if (sActionProp.equals("Logout"))
  {
      webCustomer.customerSignOut(request);
      sActionProp = "SignIn";
      if ("20".equalsIgnoreCase(request.getParameter("clicklogout")))
      {
         out.clear();
         out = pageContext.pushBody();
         response.reset();
         return;
      }
  }
  else
  {
      loginInfo = webCustomer.getCustomerInfo();
  }

  NavigationInfo.Navigation currentPage = NavigationInfo.Navigation.SignIn;
%>
<% if (nInclude==0) { %>
 <div id="id_mainarea">
<% } %>
<%@ include file="topbar.jsp"%>
<% if (loginInfo!=null && (Utilities.getValueLength(sActionProp)==0||sActionProp.startsWith("FillTestForm")||sActionProp.startsWith("Dashboard")||sActionProp.startsWith("PaypalPay")||sActionProp.startsWith("GetRequisition"))) { %>
      <%@ include file="filltestform.jsp"%>
 <% } else { %>
     <jsp:include page="/web/service/navigation.jsp">
        <jsp:param name="actionprop" value="<%=Utilities.getValue(sActionProp)%>"/>
        <jsp:param name="errormessage" value="<%=Utilities.getValue(sErrorMessage)%>"/>
        <jsp:param name="errorclass" value="<%=Utilities.getValue(sErrorClass)%>"/>
    </jsp:include>
<% } %>

 <script type="text/javascript">
var g_currentPage = <%=currentPage.GetValue()%>;
</script>
<% if (nInclude==0) { %>
</div>
<FORM name="navigateform" action="/Clinician" method="post" target2="printWin">
<INPUT name="action1" type="hidden" value="">
<INPUT type="hidden" name="thirdparty" value="<%=Utilities.getValue(request.getParameter("thirdparty"), "No")%>">
<INPUT name="what" type="hidden" value="">
<INPUT name="id" type="hidden" value="">
<INPUT name="clicklogout" type="hidden" value=0>
<INPUT name="params" type="hidden" value="<%=java.util.Calendar.getInstance().getTime().getTime()%>">
</FORM>
<% }  %>
<% if (bJustLogin) {%>
<script>
$(document).idle({
    onIdle: function(){
     alert('There is no activity about 20 minutes, the system will automatically logout your session. You can login it again to continue our work.');
     forceLogout(false);
    },
    idle: 20*60*1000
})
$(document).ready(function()
{
    $(window).bind("beforeunload", function() {
        if (document.navigateform.clicklogout.value==0)
        {
            forceLogout(true);
            return "Do you really want to close?";
        }
    });
});
</script>
<% } %>