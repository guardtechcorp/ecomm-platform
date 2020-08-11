<% if (sSubjectNote!=null) { %>
<script>createTableOpen();</script>
<table width="700" align="center" border="0" cellpadding="5" cellspacing="3"  style="border: 1px solid #DFDFDF; background-color:#e8eefa" EFF7FE>
 <tr>
  <td>
  <table>
   <tr>
    <td width=18 valign="top"><img src="/staticfile/web/images/info.gif" height=14 width=14></td>
    <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif"><span style="font-size:16px;"><strong><%=sSubjectNote%></strong></span></font></td>
   </tr>
   <tr>
    <td width=18></td>
    <td align="left"><font face="Verdana, Arial, Helvetica, sans-serif"><%=sContentNote%></font></td>
   </tr>
  </table>
 </td>
 </tr>
</table>
<script>createTableClose();</script>
<% } %>