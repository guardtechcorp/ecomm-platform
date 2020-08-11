<%
   String sLinks = mcBean.getNavigationWeb(request, true);
//System.out.println("sLinks=" + sLinks);    
%>
<% if (sLinks.length()>0) { %>
<table width="100%" aling="center" cellspacing="1" cellpadding="2" style1="background-color: #bbbbbb; border: 1px solid #DFDFDF;">
<TR>
 <TD width="100%" height="26" style="border-bottom:solid 1px #E8E8E8">&nbsp;
   <img src='/staticfile/web/images/arrowstart.gif' align='absMiddle'><%=sLinks%>&nbsp;
 </TD>
</TR>
</table>
<% }%>
