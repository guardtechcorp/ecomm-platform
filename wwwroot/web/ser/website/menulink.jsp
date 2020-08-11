<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%@ page import="java.util.List" %>
<%
{
    StringBuffer sbMessage = new StringBuffer();

    sbMessage.append("<h2 align='center'>" + mcBean.getLabel("ws-designmode") +  "</h2>");
    sbMessage.append("<font size=3 color='green'><UL><LI>" + mcBean.getLabel("ws-dragdrop") +  "</LI><br>");
    sbMessage.append("<LI>" + mcBean.getLabel("ws-removeit") + "</LI><br>");
    sbMessage.append("<LI>" + mcBean.getLabel("ws-tonormal") + "</LI></UL></font>");
%>
<table cellspacing=2 cellpadding=2 width="100%" align="center" border=0>
<tr>
<td height="20"></td>
</tr>
<tr>
<td>
<script>createTableOpen();</script>
 <table width="660" height="100" border="0" cellspacing="1" cellpadding="0" style="border: 1px solid #DFDFDF; background-color:#EFF7FE">
  <tr>
   <td height="5"></td>
  </tr>
  <tr style="padding:5 0 5 0px">
   <td><%=sbMessage.toString()%></td>
  </tr>
 </table>
<script>createTableClose();</script>

</td>
</tr>
</table>
<% } %>
