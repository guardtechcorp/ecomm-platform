<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  BasicWeb web = new BasicWeb(session, null);
  ContentInfo ctInfo = web.getContentInfo(request);
  ConfigInfo cfInfo = web.getConfigInfo();
%>
<table cellspacing=2 cellpadding=2 width="100%"  bgcolor="<%=cfInfo.BackColor%>">
  <!--TR vAlign="middle" bgColor="#4279bd">
    <TD height=20 align="center"><font face=Verdana,Helvetica,Arial,sans-serif color=#ffffff size=4><%=ctInfo.Title%></font>
    </TD>
  </TR-->
   <TR>
    <TD height=5></TD>
   </TR>
   <TR>
    <TD vAlign="top"><%=ctInfo.Text%> </TD>
   </TR>
</table>
<% } %>