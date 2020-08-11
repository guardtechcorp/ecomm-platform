<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%
{
    String sRealAction = Utilities.getValue(MemberAccountBean.getRequestAction(session));
    MemberInfo mbInfo = mcBean.getMemberInfo();
    MemberInfo onInfo = mcBean.getSiteOwnerInfo();
//cfInfo.DomainColor
//Utilities.dumpObject(ownerInfo);
    String sLoginUrl = mcBean.getHttpsLink("index.jsp");      
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<table border="0" cellpadding="0" cellspacing="0" align="left" width="100%">
 <tr>
  <td  style="padding-left: 1px; padding-top: 0px; padding-bottom: 0px; padding-right: 0px;">
<div style="width:100%; height:90px; background-color:#FFFFCC; overflow:auto; BORDER:#000000 1px solid;" >
<TABLE width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:<%=mbInfo!=null?mbInfo.SloganBkColor:onInfo.SloganBkColor%>">
<% if (cfInfo.Membership==2) { %>
<% if (mbInfo==null) { %>
<form method="post" name="signin_quick" action="<%=sLoginUrl%>" onsubmit="return validateSignIn(this);">
<input type="hidden" name="domain_email" value="<%=mcBean.getDomainName()+"_email"%>">
<input type="hidden" name="action1" value="Submit_SignIn">
<TR>
  <TD colspan="2" height="8"></TD>
</TR>
<TR>
 <TD width="66" height="26" align="right"><SPAN style='font-size:10px;'>Email:</SPAN></TD>
 <TD width="137" height="26"><input type="text" name="email" maxlength=50 value="<%=Utilities.getValue(request.getParameter("email"))%>" style="width:155px; height:21px"></TD>
</TR>
<TR>
 <TD width="66" height="26" align="right">Password:</TD>
 <TD width="137" height="26"><input type="password" name="password" maxlength=20 value="<%=Utilities.getValue(request.getParameter("password"))%>" style="width:155px; height:21px"></TD>
</TR>
<TR>
<TD width="66" align="center"></TD>
<TD width="137" align="left">&nbsp;&nbsp;<input type="submit" value="Sign In" name="submit" style="width:80px; height:22px"></TD>
</TR>
</form>
<SCRIPT>onSignInLoad(document.signin_quick, <%=("Sign In".equalsIgnoreCase(sRealAction))%>);</SCRIPT>
<% } else { %>
<TR>
 <TD colspan="2" height="1"></TD>
</TR>
<tr>
 <td colspan="2" align="center" valign="top">
  <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
   <tr>
    <td width="1"></td>
    <td><%=Utilities.getValue(mcBean.getPhotoImageHtml(mbInfo, 110, 85))%></td>
    <td width="2"></td>
    <td >
      <table cellspacing=0 cellpadding=0 width="100%" border=0>
       <tr>
         <td algin="right" valign="top"><b>Hi, <%=mbInfo.FirstName%></b>&nbsp;&nbsp;&nbsp;&nbsp;<A href='<%=mcBean.encodedUrl("index.jsp?action=Sign Out_SignIn")%>'>[Sign Out]</A></td>
       </tr>
       <tr>
         <td height=78><%=mcBean.getText(mbInfo.Slogan, mbInfo.SloganSize, mbInfo.SloganFont, mbInfo.SloganColor, (mbInfo.SloganStyle&10)!=0, (mbInfo.SloganStyle&12)!=0)%></td>
       </tr>
      </table>
     </td>
    </tr>
   </table>
  </td>
</tr>
<% } %>
<% } else { %>
<TR>
 <TD colspan=2 height=1></TD>
</TR>
<% if (mbInfo==null) { %>
<TR>
 <TD colspan=2 align="center"><b><%=mcBean.getLabel("lg-join")%></b></TD>
</TR>
<TR>
 <TD colspan=2 align="center">
 <script>createLeftButton();</script>
  <%=mcBean.getAdminMenuLink(-102)%>
 <script>createRightButton();</script>
 </TD>
</TR>
<TR>
 <TD colspan=2 align="center" valign1="bottom">&nbsp;&nbsp;<b><%=mcBean.getLabel("lg-usermember")%>: </b>
 <%=mcBean.getAdminMenuLink(-101)%>
 </TD>
</TR>
<% } else { %>
<TR>
 <TD colspan=2 align="center">
 <table cellspacing=0 cellpadding=0 width="100%" height="100%" align="center" border=0 bgColor="<%=mbInfo.SloganBkColor%>">
  <tr>
  <td width="77" valign="top"><%=Utilities.getValue(mcBean.getPhotoImageHtml(mbInfo, 75, 85))%></td>
  <td>
   <table width="100%">
    <tr>
    <td valign="top" style="border-bottom: 1px solid #DFDFDF;">&nbsp;<font color="#FFEFD5"><b><%=mcBean.getLabel("lg-hi")%>, <%=mbInfo.getPersonalName()%></b></font>
     <!--A class="button" href='<%=mcBean.encodedUrl("index.jsp?action=Sign Out_SignIn")%>'>[Sign Out]</A-->
    </td>
    </tr>
    <tr>
     <td align1="center" height="62">
      <%=mcBean.getText(mbInfo.Slogan, mbInfo.SloganSize, mbInfo.SloganFont, mbInfo.SloganColor, (mbInfo.SloganStyle&10)!=0, (mbInfo.SloganStyle&12)!=0)%>
     </td>
    </tr>
   </table>
  </td>
  </tr>
 </table>

 </TD>
</TR>
    
<% } %>

<% } %>
</TABLE>
</div>
  </td>
 </tr>
</table>    
<% } %>