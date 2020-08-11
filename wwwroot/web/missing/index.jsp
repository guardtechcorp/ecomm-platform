<HTML>
<HEAD>
<TITLE>Admin Index Page.</TITLE>
<META http-equiv='Content-Type' content='text/html; charset=utf-8'>
</HEAD>
<BODY bgcolor='#FFFFFF'>
<%@ page import="java.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.controller.Manager"%>
<%
   BasicBean bean = new BasicBean(session, null);
//   bean.showSessionInfo(request, application, session, out);
//   x-forwarded-for = 75.15.100.174
//   x-forwarded-host = qa.omniserve.com
//   x-forwarded-server = QA.omniserve.com
   String sDomain = request.getHeader("x-forwarded-host");
   if (sDomain==null)
      sDomain = request.getHeader("x-forwarded-server");
   if (sDomain==null)
      sDomain = "";
%>
<% if (sDomain.endsWith("omniserve.com")) { %>
<TABLE width="720" border="0" align="center" cellpadding="0" cellspacing="0">
  <TR>
    <TD width="200"><A href="http://www.omniserve.com"><IMG src="http://www.omniserve.com/images/logo.gif" width=200 height=60 border=0></A></TD>
    <TD width="520">&nbsp;</TD>
  </TR>
</TABLE>
<TABLE width="720" height="400" border="0" align="center" cellpadding="0" cellspacing="0" style="border-top:1px solid #D6D6D6">
  <TR>
    <TD valign="top"><DIV align="justify">
      <DIV class="style1"> </DIV>
      <DIV>&nbsp;</DIV>
      <DIV><B>This user account does not exist or the file does not exist in our online system. </B></DIV>
      <DIV>&nbsp;</DIV>
    </TD>
  </TR>
</TABLE>
<TABLE width="720" border="0" align="center" cellpadding="0" cellspacing="0" style="border-top:1px solid #D6D6D6">
  <TR>
    <TD align="center">
   <DIV class="content" style="font:11px; padding:5px" align="center"> <A class="footer" href="http://www.omniserve.com/aboutus.html">About Us</A> | <A class="footer" href="mailto:info-desk@omniserve.com">Contact Us</A> | <A class="footer" href="http://www.omniserve.com/faq.html">FAQ</A> | <A class="footer" href="http://www.omniserve.com/termsofservice.html">Terms of Service</A> | <A class="footer" href="http://www.omniserve.com/privacy.html">Privacy Policy</A> . <BR/>
  Copyright &copy; 1998-2006 omniserve.com. All rights reserved. </DIV>
   </TD>
  </TR>
</TABLE>
<% } else {%>
The file does not exist in our online system.
<% } %>
</BODY>
</HTML>
