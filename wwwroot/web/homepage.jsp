<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%
{
  BasicWeb web = new BasicWeb(session, null);
  ContentInfo ctInfo = web.getContentInfo(request);
%>
<table cellspacing=1 cellpadding=6 width="100%">
   <TR>
    <TD vAlign="top"><%=ctInfo.Text%></TD>
   </TR>
</table>
<% } %>
