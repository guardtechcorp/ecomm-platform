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
<div class="footerInsideWrap">
  <div class="footerLinksWrap">
<% if (!"www.webcenter123.com".equalsIgnoreCase(web.getDomainName())) { %>
     <%=web.getNavigationLinks(cfInfo, "button")%>
     <a class="footLink" href="<%=web.getHomeLink(cfInfo)%>"><%=web.getLabelText(cfInfo, "home-page")%></a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=contactus")%>"><%=web.getLabelText(cfInfo, "contact-us")%></a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=shopcart")%>"><%=web.getLabelText(cfInfo, "shop-cart")%></a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=checkout")%>"><%=web.getLabelText(cfInfo, "check-out")%></a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=ordertrack")%>"><%=web.getLabelText(cfInfo, "order-track")%></a>
     <!--a class="footLink" href="#top">TOP</a-->
<% } else { %>
     <a class="footLink" href="<%=web.getHomeLink(cfInfo)%>"><%=web.getLabelText(cfInfo, "home-page")%></a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=showproducts&categoryid=5")%>">View Reports</a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=pi-propertysearch&rootlink=yes")%>">Get Reports</a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=pi-reportarchive&start=yes&rootlink=yes")%>">Archived Report</a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=cp-view-myaccount&rootlink=yes")%>">My Account</a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=showlinkpage&linkid=4")%>">F A Q</a>
     <a class="footLink" href="<%=web.getHttpLink("index.jsp?action=contactus")%>">Contact Us</a>
<% } %>
</div>
<% if (bShowCounter) { %>
      <!--
     <script type="text/javascript">showVisitorCount(15, 'black', '<%=web.getDomainName()%>', '<%=web.getPrefixCtr()%>')</script> -->
<% } %>
    <div class="rightFootLinks">
      <div class="footerSocial">
        <a href"" target="_blank"><i class="fa fa-facebook-official" aria-hidden="true"></i></a>
        <a href"" target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i></a>
        <a href"" target="_blank"><i class="fa fa-instagram" aria-hidden="true"></i></a>
        <a href"" target="_blank"><i class="fa fa-youtube-play" aria-hidden="true"></i></a>
      </div>
      <div class="legalLinks">
<% if (cfInfo.Security==1){ %>
        <a href="<%=web.getHttpLink("index.jsp?action=showcontent&name=SecurityID&contentid="+cfInfo.SecurityID)%>"><%=web.getLabelText(cfInfo, "security-link")%></a>
<% } %>
<% if (cfInfo.Privacy==1){ %>
        <a href="<%=web.getHttpLink("index.jsp?action=showcontent&name=PrivacyID&contentid="+cfInfo.PrivacyID)%>"><%=web.getLabelText(cfInfo, "privacy-link")%></a>
<% } %>
<% if (cfInfo.Legal==1){ %>
        <a href="<%=web.getHttpLink("index.jsp?action=showcontent&name=LegalID&contentid="+cfInfo.LegalID)%>"><%=web.getLabelText(cfInfo, "legal-link")%></a>
<% } %>
      </div>
  </div>
        <div class="copyTxt"><%=web.getCopyRight(cfInfo)%></div>
</div>
<% } else if (cfInfo.BottomBar==2) { %>
<div class="bottomTxt">
     <%=web.getBottomHtml(request, cfInfo)%>
<div>
<% } %>
<% } %>
