<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.LayoutWeb"%>
<%
{
  LayoutWeb web = new LayoutWeb(session, request);
%>
<TABLE cellspacing=4 cellpadding=4 width="100%">
  <TR>
    <TD>
<!--Begin File Content-->
    <%=web.getHtmlBodyContent(request)%>
<!--End File Content-->
    </TD>
  </TR>
</TABLE>
<% } %>