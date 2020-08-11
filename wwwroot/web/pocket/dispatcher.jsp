<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%
{
  TransferWeb webprop = new TransferWeb(session, request);
  TransferWeb.ResponseResult ret = webprop.forwardToJsp(request, "/web/pocket/commandswitch.jsp");
  if (ret.bRedirect)
  {
//System.out.println("redirect=" + ret.sContent);
    response.sendRedirect(webprop.encodedUrl(ret.sContent));
    return;
  }

%>
<%=ret.sContent%>
<% } %>