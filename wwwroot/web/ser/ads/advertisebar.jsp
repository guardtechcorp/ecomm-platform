<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%
{
    boolean bAdsCenter = false;//true;
//System.out.println("cfInfo.VerticalBarSide=" + cfInfo.VerticalBarSide);
%>
<TABLE width="100%" border="0" align="center" cellpadding="1" cellspacing="0" bgColor='<%=cfInfo.DomainColor%>'>
 <TR>
<% if (bAdsCenter) { %>
 <TD colspan="2" align="center" valign="middle">
   <TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <TR>
     <TD width="120" valign="top">
<% if (cfInfo.TopBar==0) { %>
<%
  MemberInfo urInfo = mcBean.getMemberInfo();
%>
<% if (urInfo==null) { %>
 <br>&nbsp;&nbsp;<A class='content' href='<%=mcBean.encodedUrl("index.jsp?action=Load_SignIn")%>'>Sign In</A><br>
 <br>&nbsp;&nbsp;<b>New User? </b>
 <br>&nbsp;&nbsp;<A class='content' href='<%=mcBean.encodedUrl("index.jsp?action=Load_SignUp&rl=1&pt=Sign Up Informaton")%>'>Sign Up</A>
<% } else { %>
 <br>&nbsp;&nbsp;<b><font color="#000000">Hi, <%=urInfo.getPersonalName()%></font></b>
 <br>&nbsp;&nbsp;<A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Sign Out_SignIn")%>'>[Sign Out]</A>
<% } %>
<% } %>
     </TD>
     <TD height="90" width="730" align="center">
      <%@ include file="topbarads.jsp"%>
     </TD>
     <TD width="120" valign="top">
     </TD>
    </TR>
   </TABLE>
  </TD>
<% } else { %>
<% if (cfInfo.VerticalBarSide<=1) { %>
 <TD width="232" valign1="top">
 <%@ include file="../account/signin_quick_topbar.jsp"%>
 </TD>
<% } %>
 <TD>
   <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
    <TR>
     <TD width="5"></TD>        
     <TD height="90" align='<%=cfInfo.VerticalBarSide<=1?"right":"left"%>'>
      <%@ include file="topbarads.jsp"%>
     </TD>
     <TD width="5"></TD>
    </TR>
   </TABLE>
  </TD>
<% if (cfInfo.VerticalBarSide==2) { %>
  <TD width="232" valign="top">
  <%@ include file="../account/signin_quick_topbar.jsp"%>
  </TD>
<% } %>
<% } %>
 </TR>
</TABLE>
<% } %>