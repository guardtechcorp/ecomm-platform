<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%@ page import="com.zyzit.weboffice.web.LayoutWeb"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  LayoutWeb web = new LayoutWeb(session, request);
  ConfigInfo  cfInfo = web.getConfigInfo();
  boolean bShowCounter = false;
  if (cfInfo.ShowCounter!=0 && request.getParameter("action")==null)
     bShowCounter = true;
%>
<% if (cfInfo.BottomBar==1) { %>
<table width="778" align="center" border="0" cellspacing="0" cellpadding="0" bgcolor="<%=cfInfo.BackColor%>">
  <tr>
    <td height="3" colspan="2"></td>
  </tr>
  <tr>
    <td bgcolor="#4279bd" height="20" align="center" class="standard" colspan="2">
<% if (!"www.webcenter123.com".equalsIgnoreCase(web.getDomainName())) { %>
     <%=web.getNavigationLinks(cfInfo, "button")%>
     <A class="button" href="<%=web.getHomeLink(cfInfo)%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> <%=web.getLabelText(cfInfo, "home-page")%></A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpLink("index.jsp?action=contactus")%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> <%=web.getLabelText(cfInfo, "contact-us")%></A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpLink("index.jsp?action=shopcart")%>"><IMG height=12 src="/staticfile/web/images/gouwu-2.gif" width=19 border=0> <%=web.getLabelText(cfInfo, "shop-cart")%></A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpsLink("index.jsp?action=checkout")%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> <%=web.getLabelText(cfInfo, "check-out")%></A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpsLink("index.jsp?action=ordertrack")%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> <%=web.getLabelText(cfInfo, "order-track")%></A>&nbsp;&nbsp;&nbsp;
     <!--A class="button" href="#top">TOP</A-->
<% } else { %>
     <A class="button" href="<%=web.getHomeLink(cfInfo)%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> <%=web.getLabelText(cfInfo, "home-page")%></A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpsLink("index.jsp?action=showproducts&categoryid=5")%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> View Reports</A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpsLink("index.jsp?action=pi-propertysearch&rootlink=yes")%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> Get Reports</A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpsLink("index.jsp?action=pi-reportarchive&start=yes&rootlink=yes")%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> Archived Report</A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpsLink("index.jsp?action=cp-view-myaccount&rootlink=yes")%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> My Account</A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpLink("index.jsp?action=showlinkpage&linkid=4")%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> F A Q</A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="<%=web.getHttpLink("index.jsp?action=contactus")%>"><IMG src="/staticfile/web/images/tp01-2.gif" border=0> Contact Us</A>&nbsp;&nbsp;&nbsp;
<% } %>
    </td>
  </tr>
  <tr>
    <td width="<%=bShowCounter?145:1%>" align="center">
<% if (bShowCounter) { %>
      <!--table border="1" cellspacing=0 cellpadding=1 align="left"><tr><td>
         <span class='lcdstyle'><sup>Total</sup> web.getTotalVisitor(request)<sup>Visitors</sup></span>
       </td></tr></table-->
     <script type="text/javascript">showVisitorCount(15, 'black', '<%=web.getDomainName()%>', '<%=web.getPrefixCtr()%>')</script>
<% } %>
    </td>
    <td align="center" valign="bottom">
<% if (cfInfo.Security==1){ %>
        <a href="<%=web.getHttpLink("index.jsp?action=showcontent&name=SecurityID&contentid="+cfInfo.SecurityID)%>"><%=web.getLabelText(cfInfo, "security-link")%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<% } %>
<% if (cfInfo.Privacy==1){ %>
        <a href="<%=web.getHttpLink("index.jsp?action=showcontent&name=PrivacyID&contentid="+cfInfo.PrivacyID)%>"><%=web.getLabelText(cfInfo, "privacy-link")%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<% } %>
<% if (cfInfo.Legal==1){ %>
        <a href="<%=web.getHttpLink("index.jsp?action=showcontent&name=LegalID&contentid="+cfInfo.LegalID)%>"><%=web.getLabelText(cfInfo, "legal-link")%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<% } %>
        <hr><%=web.getCopyRight(cfInfo)%>&nbsp;&nbsp;<!--web.getPowerBy(cfInfo) -->
    </td>
  </tr>
  <tr>
    <td height="5" colspan="2"></td>
  </tr>
</table>
<% } else if (cfInfo.BottomBar==2) { %>
<TABLE  width="778" align="center" height="5" cellSpacing=0 cellPadding=0 border=0>
 <TR>
    <TD align="center">
     <%=web.getBottomHtml(request, cfInfo)%>
    </TD>
  </TR>
</TABLE>
<% } %>
<% } %>