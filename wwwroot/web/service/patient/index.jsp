<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%@ page import="com.zyzit.weboffice.bean.Apollogen.RequisitionWeb" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%
  try {      
//MemberAccountBean.dumpAllParameters(request);
//MemberAccountBean.showAllParameters(request, out);
//MemberAccountBean.showSessionInfo(request, application, session, out);
      
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
 System.out.println("PayPal = " + request.getQueryString());
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
    else if ("FillTestForm-Status".equalsIgnoreCase(sActionProp))
    {
       String sWhat = request.getParameter("wt");
       if ("LeaveMessage".equalsIgnoreCase(sWhat))
       {
           web.leaveMessage(request, response, "patient");
           return;
//           StringBuffer sbContent = new StringBuffer("{");
//           RequisitionInfo existInfo = web.getRequistionInfo(request);
//           if (existInfo!=null && existInfo.glInfo!=null)
//           {
//               boolean bRet = web.leaveMessage(existInfo.glInfo, "Patient", request);
//               sbContent.append("\"ret\":" + bRet + ",\n");
//               if (bRet)
//                  sbContent.append("\"message\":\"" + "<font color='green'>Your message is successfully submitted. Thank you!</font>" + "\"");
//               else
//                  sbContent.append("\"message\":\"" + "<font color='red'>Trying to submit your message is failed. Please try it later.</font>" + "\"");
//           }
//           else
//           {
//               sbContent.append("\"ret\":" + false + ",\n");
//               sbContent.append("\"message\":\"" + "Not found requisition form!" + "\"");
//           }
//
//           sbContent.append("}");
//           RequisitionWeb.outputAjaxContent(sbContent.toString(), response);
//           return;

       }
    }

    web.setCookieJID(request, response);

    int nInclude = Utilities.getInt(request.getParameter("include"), 0);
    String sThirdParty = Utilities.getValue(request.getParameter("thirdparty"), "No");
%>
<style type="text/css">
 A:hover {
    COLOR: #ff3333; text-decoration: underline; CURSOR: hand    
}    
</style>
<%@ include file="../../util/function.jsp"%>
<% if (sActionProp.equalsIgnoreCase("PrintSummary")||sActionProp.equalsIgnoreCase("GetSummary")) { %>
<jsp:include page="/web/service/patient/printsummary.jsp" />
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