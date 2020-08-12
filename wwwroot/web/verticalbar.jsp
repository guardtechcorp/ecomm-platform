<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.AccessRole"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  BasicWeb web = new BasicWeb(session, null);
  ConfigInfo cfInfo = web.getConfigInfo();
//web.showAllParameters(request, out);
%>
<div class="sideBarContent">
<% if (cfInfo.CategoryShow!=0) {%>
<h3><%=web.getLabelText(cfInfo, "category-til")%></h3>
            <%@ include file="category.jsp"%>

<% } %>
<% if (cfInfo.Membership==1) { %>
<%
  String sAction = web.getRealAction(request);
  String sType = request.getParameter("type");
  String sError = request.getParameter("error");
%>

<div class="memberLoginWrap">
<form name="memberlogin" action="index.jsp" method="post" onsubmit="return validateMemberLogon(this, 'Login');">
        <input type="hidden" name="action1" value="">
        <h6><%=cfInfo.MemberAreaName%></h6>

<% if ("memberlogin".equalsIgnoreCase(sAction)&&"failed".equalsIgnoreCase(sType)) { %>
<span class="failed"><%=sError%></span></b></TD>
<% } %>

<% if (web.isCustomerLogin()) { %>
        Hi, <%=web.getCustomerName()%> <a href="<%=web.getHttpLink("index.jsp?action=signout")%>">Logout</a>
           <br><%=web.getLabelText(cfInfo, "welcome-shop")%>
<% } else { %>
          <label><%=web.getLabelText(cfInfo, "email0-lab")%></label>
              <input maxLength=50 name="email">
            <label><%=web.getLabelText(cfInfo, "password-lab")%></label>
            <input type="password" maxLength=20 name="password">
         <!--<input type=checkbox value=ON name=remember>
            <div style="CURSOR: default" onclick=this.parentNode.firstChild.firstChild.click(); vAlign=center align=left width="117">Remember User</div> -->
         <a onClick="return hasEmailAccount(document.memberlogin);" href="javascript:submitForgotPassword(document.memberlogin)"><%=web.getLabelText(cfInfo, "forgot-password")%></a>
            <input type="submit" value="<%=web.getLabelText(cfInfo, "login-but")%>" name="Login">
<% } %>
       </form>
<% } %>
</div>

<div class="newsArea"><% if (cfInfo.NewsArea==1001) { %>

<% } %>
<% if (cfInfo.NewsArea==1) { %>
  <h3><%=Utilities.getValue(cfInfo.NewsTitle)%></h3>
        <div class="newscroll">
          <% if (cfInfo.NewsAreaScroll>0) { %>
            <marquee onMouseOver=this.stop() onMouseOut=this.start() scrollamount=1 scrolldelay=50 direction=up height=100>
            <%=web.getContent(cfInfo.NewsAreaID, "NewsAreaID")%>
            </marquee>
          <% } else { %>
            <%=web.getContent(cfInfo.NewsAreaID, "NewsAreaID")%>
          <% } %>
        </div>
    </div>

<% } %>
<% if (cfInfo.NewsLetter==1) { %>
       <form name="newsletter" action="#" method="post">
        <input type="hidden" name="domainname" value="<%=web.getDomainName()%>">
        <input type="hidden" name="action1" value="">
          <h3><%=web.getLabelText(cfInfo, "newsletter-til")%></h3>
              <%=web.getLabelText(cfInfo, "subscribe-des")%>
              <%=web.getLabelText(cfInfo, "name-lab")%>
              <input maxlength=20 name="yourname" size="15">
              <%=web.getLabelText(cfInfo, "email0-lab")%>
              <input maxlength=50 name="email" size="15">

            <input type="radio" checked value="1" name="what"><%=web.getLabelText(cfInfo, "subscribe-lab")%>
            <input type="radio" value="0" name="what"><%=web.getLabelText(cfInfo, "unsubscribe-lab")%>

           <div id=response></div>

          <input type="button" value="<%=web.getLabelText(cfInfo, "submit-but")%> " name="submit" onclick="setAction(document.newsletter, 'Submit');submitNewsletter(document.newsletter, '<%=web.getHttpLink2("newsletter.jsp?action=subscriber")%>');">
       </form>
<% } %>
<% if (cfInfo.LinkPage==10000) { %>
   <%@ include file="linkwebpage.jsp"%>
<% } %>
<% if (cfInfo.GoogleAdSenseID!=null && cfInfo.GoogleAdSenseID.trim().length()>0) {%>
<script type="text/javascript">
<!--
google_ad_client = "<%=cfInfo.GoogleAdSenseID%>";
google_ad_width = 160;
google_ad_height = 600;
google_ad_format = "160x600_as";
google_ad_type = "text_image";
google_ad_channel = "";
google_color_border = "FFFFFF";
google_color_bg = "";
google_color_link = "3366CC";
google_color_text = "000000";
google_color_url = "808080";
//-->
</script>
    <script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
<% } %>

<% } %>
</div>
