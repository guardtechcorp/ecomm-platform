<%
   boolean bSuccessful = "0".equalsIgnoreCase(request.getParameter("errorno"));
   String sDisplayMessage = request.getParameter("message");
%>
<table  width="100%" align="center" border="0" cellpadding="2" cellspacing="1">
<tr>
 <td>
 <table width="100%" align="center" border="0" cellpadding="2" cellspacing="1" style="border: 1px solid #DFDFDF; background-color:#EFF7FE">
 <tr>
  <td height="2"></td>
 </tr>
 <tr>
   <td align="center"><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color='<%=bSuccessful?"green":"#FF6633"%>'>
    <b><%=sDisplayMessage%></b></font>
   </td>
 </tr>
 <tr>
  <td height="5"></td>
 </tr>
 </table>
 </td>
</tr>
<tr>
  <td height="5"></td>
</tr>
</table>