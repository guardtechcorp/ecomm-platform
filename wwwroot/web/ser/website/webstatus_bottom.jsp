<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.model.MembershipInfo" %>
<%
{
    //String sRealActionxxx = Utilities.getValue(MemberAccountBean.getRequestAction(session));
    MemberInfo mbInfo = mcBean.getMemberInfo();
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<table class="tblBorder" border="0" cellpadding="0" cellspacing="0" align="left" width="100%">
<TR>
  <TD vAlign=top align=left width=2 height=2><DIV class="tblTopLeftCorner"></DIV></TD>
  <TD  height="2"></TD>
  <TD vAlign=top align=right width=2 height=2><DIV class="tblTopRightCorner"></DIV></TD>
</TR>

 <tr>
  <td  colspan="3" style="padding-left: 1px; padding-top: 0px; padding-bottom: 0px; padding-right: 0px;">
<div style="width:100%; height:84px; background-color:#FFFFCC; overflow:auto; BORDER:#000000 0px solid;" >
<TABLE width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#ffffff">
<% if (mbInfo==null) { %>
    <TR>
     <TD colspan=2 align="center">Visting at: <b><%=Utilities.getValue(cfInfo.SiteName)%></b></TD>
    </TR>

<% } else {
    MembershipInfo msInfo = mcBean.getSiteMembershipInfo();
%>
    <TR>
     <TD colspan=2 align="center">You are visiting site: <b><%=Utilities.getValue(cfInfo.SiteName)%></b></TD>
    </TR>
    <TR>
<% if (mbInfo.MemberID==cfInfo.MemberID) { %>
    <TR>
     <TD colspan=2 align="center">
     You are <b>OWNER</b> of this site
     </TD>
    </TR>
<% } else { %>
    <TR>
     <TD colspan=2 align="center">
<% if (mcBean.isMemberOfSite(mbInfo.MemberID)) { %>
   You are <b>MEMBER</b> of this site
<% } else {%>
   Your are not <A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rl=1&pt=Apply Membership of This Site")%>' title="Click to apply the membership of <%=cfInfo.WebTitle%>.">MEMBER</A> of this site
<% } %>
     </TD>
    </TR>
<% if (mbInfo.Type!=0) { %>
   <TR>
    <TD colspan=2 align="center">
    You can visit <A href="<%=mcBean.encodedUrl("index.jsp?action=Switch_ToMytSite&rl=1")%>">your site</a>
    </TD>
  </TR>                
<% } %>

<% } %>
<% } %>
<% if (cfInfo.ShowCounter!=0) { %>
    <TR>
     <TD colspan=2 align="center" height="5">
     </TD>
    </TR>
    <TR>
     <TD colspan=2 align="center">
      <script type="text/javascript">showVisitorCount(15, 'black', '<%=mcBean.getDomainName()%>', '<%=mcBean.getPrefixCtr()%>')</script>
     </TD>
   </TR>
<% } %>
</TABLE>
</div>
  </td>
 </tr>

<TR>
  <TD vAlign=bottom align=left width=2 height=2><DIV class="tblBotLeftCorner"></DIV></TD>
  <TD width="518" height="2"></TD>
  <TD vAlign=bottom align=right width=2 height=2><DIV class="tblBotRightCorner"></DIV></TD>
</TR>
</table>
<% } %>