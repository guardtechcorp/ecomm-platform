<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%
{
    String sType = request.getParameter("type");
    if (ret!=null)
    {
      if (ret.isSuccess())
      {
        sDisplayMessage = (String)ret.getInfoObject();
      }
      else
      {
        Errors errObj = (Errors) ret.getInfoObject();
        sDisplayMessage = errObj.getError();
        sDisplayMessage += "<br>The passwords are case sensitive. Please check your CAPS lock key.";
        nDisplay = 0;
      }

      sType = "direct";  
   }

   if (session.getAttribute(MemberAccountBean.KEY_TIMEOUTFALG)!=null)
   {
//    System.out.println("BasicBean.KEY_TIMEOUTFALGxxx =" + session.getAttribute(MemberAccountBean.KEY_TIMEOUTFALG));
       sDisplayMessage = "Your session has been timeout and you need to relogin it again.";
       nDisplay = 0;
   }

//System.out.println("getDomainSidCGI()=" + mcBean.getDomainSidCGI());
//   String sLoginUrl = mcBean.getHttpsLink("index.jsp");//Utilities.getValue(mcBean.getHttpsUrl()) + mcBean.encodedUrl("index.jsp");
   String sLoginUrl = mcBean.encodedUrl("index.jsp");
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="form_signin" action="<%=sLoginUrl%>" method="post" onsubmit="return validateSignIn(this);">
<input type="hidden" name="domain_email" value="<%=mcBean.getDomainName()+"_email"%>">
<!--input type="hidden" name="pageid" value="<%=cfInfo.HomePageID%>" -->
<INPUT type="hidden" name="action1" value="">
<TABLE class1="table-outline" width="100%" align="center">
<% if (!"direct".equalsIgnoreCase(sType)) { %>
<TR>
  <TD align="center">
   <%@ include file="accessmessage.jsp"%>
  </TD>
</TR>
<% } else {
   String sSubjectNote = null;//mcBean.getTemplateSubject("SignUp-Note");
   String sContentNote = null;//mcBean.getTemplateContent("SignUp-Note");
%>
<TR>
  <TD>
  <%@ include file="../include/promotenote.jsp"%>
  </TD>
</TR>
<% } %>
<TR>
  <TD>
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
<TR>
<TD height=10 align="center"></TD>
</TR>    
<TR>
 <TD>
 <script>createTableOpen();</script>
 <table width="540" height="180" border="0" cellspacing="1" cellpadding="0" bgcolor="#e8eefa">
  <tr>
    <td colspan="2" height="20"></td>
  </tr>
  <tr>
    <td width="30%" align="right">Email:</td>
    <td>
      <input type="text" maxlength=50 size=40 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>">
    </td>
  </tr>
  <tr>
    <td width="30%" align="right">Password:</td>
    <td>
      <input type="password" maxlength=20 size=40 name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>">
    </td>
  </tr>
  <TR>
     <TD width="30%" align="right"><input type="checkbox" name="remember" value="1"></TD>
     <TD>Remember Email &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <a onClick="return hasEmailAccount(document.form_signin);" href="javascript:forgotPassword(document.form_signin, 'Forgot Password_SignIn')">Forgot your password?</a>
     </TD>
  </TR>
  <tr>
    <td width="30%" align="right"></td>
    <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="submit" value="Sign In" name="sumbit" onClick="setAction(document.form_signin, 'Submit_SignIn');" style="width:90px; height:22px">
    </td>
  </tr>
  <tr>
   <td colspan="2" height="10" align="right"></td>
  </tr>
  <tr>
   <td colspan="2" height="20" align="right"><b>Not a user yet?</b> <A class='content' href='<%=mcBean.encodedUrl("index.jsp?action=Load_SignUp&rootlink=yes&pagetitle=New User Sign-Up")%>'>Sign Up</A>&nbsp;&nbsp;</td>
  </tr>
  <tr>
   <td colspan="2" height="10" align="right"></td>
  </tr>
 </table>
<script>createTableClose();</script>
 </TD>
 </TR>
 <TR>
 <TD height=30>&nbsp;</TD>
 </TR>
</TABLE>
</FORM>
<SCRIPT>onSignInLoad(document.form_signin, true);</SCRIPT>
<% } %>