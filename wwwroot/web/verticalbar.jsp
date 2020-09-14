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
<div class="mobileSidebarTrig">
  <i class="fa fa-list" aria-hidden="true"></i>
</div>
<div class="sideBarContent">
<% if (cfInfo.CategoryShow!=0) {%>
<h3><%=web.getLabelText(cfInfo, "category-til")%></h3>
      <div class="categoryWrap">
            <%@ include file="category.jsp"%>
      </div>

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
        <h5>Hi, <%=web.getCustomerName()%></h5>
          <p class="welcomeTxt"><%=web.getLabelText(cfInfo, "welcome-shop")%></p>
           <a class="logoutBtn" href="<%=web.getHttpLink("index.jsp?action=signout")%>">Logout</a>
<% } else { %>
          <label>Email<!-- <%=web.getLabelText(cfInfo, "email0-lab")%> --></label>
              <input maxLength=50 name="email">
            <label>Password<!-- <%=web.getLabelText(cfInfo, "password-lab")%> --></label>
            <input type="password" maxLength=20 name="password">
         <!--<input type=checkbox value=ON name=remember>
            <div style="CURSOR: default" onclick=this.parentNode.firstChild.firstChild.click(); vAlign=center align=left width="117">Remember User</div> -->
            <input type="submit" value="<%=web.getLabelText(cfInfo, "login-but")%>" name="Login">
             <a class="forgotPW" onClick="return hasEmailAccount(document.memberlogin);" href="javascript:submitForgotPassword(document.memberlogin)"><%=web.getLabelText(cfInfo, "forgot-password")%></a>

<% } %>
       </form>
<% } %>
</div>

<div class="newsArea"><% if (cfInfo.NewsArea==1001) { %>

<% } %>
<% if (cfInfo.NewsArea==1) { %>
  <!-- <h3><%=Utilities.getValue(cfInfo.NewsTitle)%></h3> -->
        <div class="newsInnerWrap">
          <% if (cfInfo.NewsAreaScroll>0) { %>
            <!-- <marquee onMouseOver=this.stop() onMouseOut=this.start() scrollamount=1 scrolldelay=50 direction=up height=100>
            <%=web.getContent(cfInfo.NewsAreaID, "NewsAreaID")%>
          </marquee> -->
          <div class="newsTxt"><%=web.getContent(cfInfo.NewsAreaID, "NewsAreaID")%></div>
          <% } else { %>
            <%=web.getContent(cfInfo.NewsAreaID, "NewsAreaID")%>
          <% } %>
        </div>
    </div>

<% } %>
<% if (cfInfo.NewsLetter==1) { %>
  <div class="newsLetterWrap">
       <form name="newsletter" action="#" method="post">
        <input type="hidden" name="domainname" value="<%=web.getDomainName()%>">
        <input type="hidden" name="action1" value="">
          <h3><%=web.getLabelText(cfInfo, "newsletter-til")%></h3>
              <p><%=web.getLabelText(cfInfo, "subscribe-des")%></p>
              <!-- <%=web.getLabelText(cfInfo, "name-lab")%> -->
              <input style='position: absolute; visibility: none; opacity: 0; height: 0; width: 0;' maxlength=20 name="yourname" size="15" value="Email Signup">
              <!-- <%=web.getLabelText(cfInfo, "email0-lab")%> -->
              <input class="newsEmail" name="email" placeholder="Enter email">

            <span style='position: absolute; visibility: none; opacity: 0; height: 0; width: 0;'><input type="radio" checked value="1" name="what"><%=web.getLabelText(cfInfo, "subscribe-lab")%></span>
            <!-- <input type="radio" value="0" name="what"><%=web.getLabelText(cfInfo, "unsubscribe-lab")%> -->

           <div id=response></div>

          <input type="button" value="<%=web.getLabelText(cfInfo, "submit-but")%> " name="submit" onclick="setAction(document.newsletter, 'Submit');submitNewsletter(document.newsletter, '<%=web.getHttpLink2("newsletter.jsp?action=subscriber")%>');">
       </form>
     </div>
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
