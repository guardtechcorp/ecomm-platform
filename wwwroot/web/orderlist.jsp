<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%
{
  BasicWeb web = new BasicWeb(session, null);
  ContentInfo ctInfo = web.getContentInfo(request);
%>
<table cellspacing=0 cellpadding=0 width="100%">
  <!--TR vAlign="middle" bgColor="#4279bd">
    <TD height=20 align="center"><font face=Verdana,Helvetica,Arial,sans-serif color=#ffffff size=4><%=ctInfo.Title%></font>
    </TD>
  </TR-->
   <TR>
    <TD colspan=2 height=5></TD>
   </TR>
   <TR>
    <TD width="5%">&nbsp;</TD>
    <TD width="95%" vAlign="top"><%=ctInfo.Text%> </TD>
   </TR>
</table>
<% } %>