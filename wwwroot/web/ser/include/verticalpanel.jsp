<% {
   MemberInfo mbInfo = mcBean.getMemberInfo();
%>
<TABLE width="100%" bgColor="#ffffff" algin="center" cellSpacing=0 cellPadding=0 style="padding:1 1 1 1px;">
<TR>
<TD align="center" valign="top">
<TABLE height=20 cellSpacing=0 cellPadding=0 width="100%" border=0>
<% if (mbInfo!=null) { %>
<tr>
  <td valign="top">
   <%@ include file="adminarea.jsp" %>
  </td>
</tr>
<% } %>
<% if (cfInfo.Membership==1) {%>
  <%@ include file="signin_quick.jsp"%>
<% } %>
<% if (cfInfo.CategoryShow!=0) {%>
  <%@ include file="category.jsp"%>
<% } %>
<% if (cfInfo.LinkPage!=0) { %>
<%@ include file="linkpage.jsp"%>
<% } %>
<% if (cfInfo.NewsArea!=0) { %>
<%@ include file="sitenews.jsp"%>
<% } %>
<% if (cfInfo.Security!=0) { %>
<%@ include file="calendar.jsp"%>
<% } %>
<tr>
 <td height="10" algin="center">
 </td>
</tr>
<!--%@ include file="test-menus.jsp" %-->
</TABLE>
</TD>
</TR>
<% if ((cfInfo.AdvertiseBar&2)==(byte)2) { %>
 <TR>
  <TD align="center" style1="border-top:dotted 1px #D6D6D6">
  <%@ include file="../ads/verticalads.jsp"%>
  </TD>
 </TR>
<% } %>        
</TABLE>
<% } %>