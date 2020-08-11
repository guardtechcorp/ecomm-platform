<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%
{
/*
  RequestDispatcher dispatcher = request.getRequestDispatcher("/web/plugin/property/propertyswitch.jsp");
  if (dispatcher != null)
     dispatcher.include(request, response);
*/
  TransferWeb webprop = new TransferWeb(session, request);
  TransferWeb.ResponseResult ret = webprop.forwardToJsp(request, "/web/plugin/property/commandswitch.jsp");
  if (ret.bRedirect)
  {
//System.out.println("redirect=" + ret.sContent);
    response.sendRedirect(webprop.encodedUrl(ret.sContent));
    return;
  }
%>
<%=ret.sContent%>
<% } %>