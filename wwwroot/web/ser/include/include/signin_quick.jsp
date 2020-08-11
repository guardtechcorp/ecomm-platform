<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<% if (mbInfo==null) { 
    String sRealAction = Utilities.getValue(MemberAccountBean.getRequestAction(session));
%>
<% if (!"Submit_SignIn".equals(sRealAction) && !"Load_SignIn".equals(sRealAction)) { %>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<tr>
   <td valign="middle" class="eg-bar"><img src="/staticfile/web/images/tp05.gif" width=10 height=10>
   <b><font color="#ffffff">&nbsp;<%=Utilities.getValue(cfInfo.MemberAreaName)%></font></b></td>
</tr>
<tr>
 <td valign="top">
<TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:<%=cfInfo.DomainColor%>">
<form method="post" name="signin_quick" action="<%=mcBean.encodedUrl("index.jsp")%>" onsubmit="return validateSignIn(this);">
<input type="hidden" name="domain_email" value="<%=mcBean.getDomainName()+"_email"%>">
<input type="hidden" name="action1" value="Submit_SignIn">
<TR>
  <TD colspan="2" height="4"></TD>
</TR>
<TR>
 <TD width="4"></TD>
 <TD height="38">Email:<br><input type="text" name="email" maxlength=50 value="<%=Utilities.getValue(request.getParameter("email"))%>" style="width:190px; height:20px"></TD>
</TR>
<TR>
 <TD width="4"></TD>
 <TD height="38">Password:<br><input type="password" name="password" maxlength=20 value="<%=Utilities.getValue(request.getParameter("password"))%>" style="width:190px; height:20px"></TD>
</TR>
<TR>
 <TD width="4"></TD>
 <TD height="26"><input type="checkbox" name="remember" value="1">Remember Email</TD>
</TR>
<TR>
 <TD colspan="2" height="4"></TD>
</TR>
<TR>
<TD colspan="2" align="center"><input type="submit" value="Sign In" name="submit" style="width:80px; height:22px"></TD>
</TR>
<TR>
 <TD colspan="2" height="4"></TD>
</TR>
</form>
<SCRIPT>onSignInLoad(document.signin_quick, <%=("Sign In".equalsIgnoreCase(sRealAction))%>);</SCRIPT>
<TR>
 <TD colspan=2 height=5></TD>
</TR>
</TABLE>
 </td>
</tr>
<% } %>
<% } %>