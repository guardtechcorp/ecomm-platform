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
        sDisplayMessage += "<br>" + mcBean.getLabel("lg-loginfail");
        nDisplay = 0;
      }

      sType = "direct";  
   }

   if (session.getAttribute(MemberAccountBean.KEY_TIMEOUTFALG)!=null)
   {
//    System.out.println("BasicBean.KEY_TIMEOUTFALGxxx =" + session.getAttribute(MemberAccountBean.KEY_TIMEOUTFALG));
       sDisplayMessage = mcBean.getLabel("lg-timeout");//"Your session has been timeout and you need to relogin it again.";
       nDisplay = 0;
   }

//System.out.println("getDomainSidCGI()=" + mcBean.getDomainSidCGI());
//   String sLoginUrl = mcBean.getHttpsLink("index.jsp");//Utilities.getValue(mcBean.getHttpsUrl()) + mcBean.encodedUrl("index.jsp");
   String sLoginUrl = mcBean.encodedUrl("index.jsp");
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="form_signin" action="<%=sLoginUrl%>" method="post" onsubmit="return validateSignIn(this);">
<input type="hidden" name="domain_email" value="<%=mcBean.getDomainName()+"_email"%>">
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

// Sign up a free account, you can get immediate benefits and good services!
// <font color1="green" face="Verdana, Arial, Helvetica, sans-serif"></font><br><ul><li>You can own a website with/without a domain name mapping to it.</li><br><li>You can invite/accept/added unlimited members of your website.</li><br><li>You can have a online file storage with powerful functions.</li></ul>
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
    <td width="30%" align="right"><%=mcBean.getLabel("lg-email")%>:</td>
    <td>
      <input type="text" maxlength=50 size=40 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>">
    </td>
  </tr>
  <tr>
    <td width="30%" align="right"><%=mcBean.getLabel("lg-password")%>:</td>
    <td>
      <input type="password" maxlength=20 size=40 name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>">
    </td>
  </tr>
  <TR>
     <TD width="30%" align="right"><input type="checkbox" name="remember" value="1"></TD>
     <TD><%=mcBean.getLabel("lg-remember")%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <a onClick="return hasEmailAccount(document.form_signin);" href="javascript:forgotPassword(document.form_signin, 'Forgot Password_SignIn')"><%=mcBean.getLabel("lg-forgot")%></a>
     </TD>
  </TR>
  <tr>
    <td width="30%" align="right"></td>
    <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="submit" value="<%=mcBean.getLabel("lg-signin")%>" name="sumbit" onClick="setAction(document.form_signin, 'Submit_SignIn');" style="width:90px; height:22px">
    </td>
  </tr>
  <tr>
   <td colspan="2" height="10" align="right"></td>
  </tr>
  <tr>
   <td colspan="2" height="20" align="right"><b><%=mcBean.getLabel("lg-notuser")%></b> <A class='content' href='<%=mcBean.encodedUrl("index.jsp?action=Load_SignUp&rl=1&pt=" + mcBean.getLabel("lg-signuptitle"))%>'><%=mcBean.getLabel("lg-signup")%></A>&nbsp;&nbsp;</td>
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