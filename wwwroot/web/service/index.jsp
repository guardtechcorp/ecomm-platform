<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%
  try {
    HttpSession ss = RequisitionWeb.setPrevSession(session, request);
    RequisitionWeb web = new RequisitionWeb(ss, request, 10);
    String sActionProp = web.getRealAction(request);
    if (!web.setDomainName(request, response, application.getRealPath("/")))
        return;

      if ("PaypalPay".equalsIgnoreCase(sActionProp))
      {
         String what = request.getParameter("what");
         if (!"return".equalsIgnoreCase(what))
         {
  MemberAccountBean.dumpAllParameters(request);
             web.payPalNotify(what, request);
             return;
         }
      }
      else if ("IdleCheck".equalsIgnoreCase(sActionProp))
      {
          web.checkIdlePayment(request, response);
          return;
      }
      else if ("UpdateSign".equalsIgnoreCase(sActionProp))
      {
          web.updateSignature(request);
          return;
      }

    web.setCookieJID(request, response);  

  CustomerWeb webCustomer = new CustomerWeb(ss, request, 0);
  if (sActionProp.endsWith("Forgot-Password"))
  {
      webCustomer.sendForgotPasswordEmail(request, response);
      return;
  }
  else if (sActionProp.equalsIgnoreCase("FillTestForm-RemoveFile"))
  {
      web.RemoveCardFile(request, response);
      return;
  }
  else if (sActionProp.equalsIgnoreCase("FillTestForm-Status"))
  {
      String sWhat = request.getParameter("wt");
      if ("LeaveMessage".equalsIgnoreCase(sWhat))
      {
          web.leaveMessage(request, response, "doctor");
          return;
      }
      else
      {
          if (web.updateStatus(request, response))
             return;
      }
  }
  int nInclude = Utilities.getInt(request.getParameter("include"), 0);
  String sThirdParty = Utilities.getValue(request.getParameter("thirdparty"), "No");
%>
<%@ include file="../util/function.jsp"%>
<% if (sActionProp.equalsIgnoreCase("PrintSummary")||sActionProp.equalsIgnoreCase("GetSummary")) { %>
<jsp:include page="/web/service/printsummary.jsp" />
<% } else if (sActionProp.equalsIgnoreCase("Download")||sActionProp.equalsIgnoreCase("GetImage")||sActionProp.equalsIgnoreCase("Export")) { %>
<%@ include file="download.jsp" %>
<% } else { %>
<% if (nInclude==0) { %>
 <% if ("No".equalsIgnoreCase(sThirdParty)) { %>
   <jsp:include page="/web/service/html/apollogen-header.html"/>
 <% } else { %>
   <jsp:include page="/web/service/html/thirdparty-header.html"/>
 <% } %>
<% } %>
<%@ include file="commandswitch.jsp" %>
<% if (nInclude==0) { %>
  <% if ("No".equalsIgnoreCase(sThirdParty)) { %>
   <jsp:include page="/web/service/html/apollogen-footer.html"/>
  <% } else { %>
   <jsp:include page="/web/service/html/thirdparty-footer.html"/>
  <% } %>
<% } %>

<% } %>
<%
}
catch (Exception e)
{
    e.printStackTrace();
}
%>