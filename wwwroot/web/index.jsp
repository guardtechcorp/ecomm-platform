<%@ page import="com.zyzit.weboffice.web.SessionWeb"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
try {
//System.setProperty("client.encoding.override", "iso-8859-1");
//Field charset = Charset.class.getDeclaredField("defaultCharset");
//charset.setAccessible(true);
//charset.set(null,null);
//. http://localhost:8080/web/index.jsp?domainname=test.hongfaamerica.com
//. http://localhost:8080/web/index.jsp?domainname=www.hepahealth.com

    SessionWeb web1 = new SessionWeb(session, request);
//web1.showAllParameters(request, out);
//web1.showSessionInfo(request, application, session, out);
  if (!web1.setDomainName(request, response, application.getRealPath("/")))
     return;

  String sDomainName1 = web1.getDomainName();

  String sIndexAction = web1.getRealAction(request);
  ConfigInfo cfInfo1 = web1.getConfigInfo();
  if ("signout".equalsIgnoreCase(sIndexAction))
  {
    int nRet = web1.customerSignOut(request);
    response.sendRedirect(web1.encodedUrl("index.jsp"));
    return;
  }
  String sBackground = "";
  if (cfInfo1.BackImage!=null&&cfInfo1.BackImage.length()>0)
     sBackground = "background='/productimages/" + web1.getImageFileName(cfInfo1.BackImage) + "'";

  String sScreenWidth = cfInfo1.Width>0?("" + (cfInfo1.Width-22)):"100%";


%>
<!--
//this commented out span with hidden closing bracket is just there to properly visually colorcode the html in the editor. The try{ Java above has no closing bracket above, the closing bracket for it is toward the bottom of the file so the color coding gets medssesd up and this is a way around it
 <span style="display:none">}</span>
 -->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%=web1.getHtmlTitleMeta(request, false)%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name='generator' content='Web Online Management from KZ Company'>
<meta name="distribution" content="GLOBAL">
<meta name="copyright" content="Copyright 1998-2007 webonlinemanage.com - Redistribution in part or in whole strictly prohibited.">
<meta name="description" content="A custom ecommerce solution">
<meta name="robots" content="index, follow">
<meta name="raiting" content="general">
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<link href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet">
<link href="/staticfile/web/css/tabs.css" type="text/css" rel="stylesheet">
<link href="/staticfile/web/css/lightslider.css" type="text/css" rel="stylesheet" />
<link href="/staticfile/web/css/magnific-popup.css" type="text/css" rel="stylesheet" />
<link href="/staticfile/web/css/styles.css" type="text/css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;0,800;1,300;1,400;1,600;1,700;1,800&display=swap" rel="stylesheet">
<script Language="JavaScript" src="/staticfile/web/scripts/languages/<%=cfInfo1.Language%>.js"  type="text/javascript"></script>
<script Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></script>
<script Language="JavaScript" src="/staticfile/web/scripts/windows.js" type="text/javascript"></script>
<script Language="JavaScript" src="/staticfile/web/scripts/customer.js" type="text/javascript"></script>
<script Language="JavaScript" src="/staticfile/web/scripts/session.js" type="text/javascript"></script>
<script Language="JavaScript" src="/staticfile/web/scripts/newsletter.js"  type="text/javascript"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script Language="JavaScript" src="/staticfile/web/scripts/lightslider.js"></script>
<script Language="JavaScript" src="/staticfile/web/scripts/jquery.magnific-popup.js"></script>
<script src="https://use.fontawesome.com/1967144032.js"></script>
<style type="text/css">
</style>
</head>

<%@ include file="actioncheck.jsp"%>
<body onLoad2="initjsDOMenu();" onUnload="onBrowserClose('logout.jsp');" LEFTMARGIN=1 TOPMARGIN=1 <%=sBackground%>>
<script language="JavaScript" type="text/javascript">
function createjsDOMenu()
{
}
</script>
<div class="pageWrap">
<% if (!"test.hongfaamerica.com".equalsIgnoreCase(sDomainName1)) { %>
<%@ include file="floatingnews.jsp"%>
<%@ include file="titlebar.jsp"%>
<%@ include file="advertise.jsp"%>
<% } else {
    LayoutWeb web = new LayoutWeb(session, request);
    ConfigInfo cfInfo = web.getConfigInfo();
%>
<% } %>
<div class="mainContent">


<% if (cfInfo1.VerticalBarSide==0) { %>
   <div class="contentWithSidebar">
     <%@ include file="verticalbar.jsp"%>
   </div>
<% } %>

<% if (cfInfo1.VerticalBarSide!=2) { %>
    <div class="largeContentArea">
<% } else { %>
    <div class="largeContentArea">
<% } %>

<% if ("productdetail".equalsIgnoreCase(sIndexAction)) { %>
    <%@ include file="productdetail.jsp"%>
<% } else if ("productphoto".equalsIgnoreCase(sIndexAction)) { %>
  <%@ include file="productphoto.jsp"%>
<% } else if ("contactus".equalsIgnoreCase(sIndexAction)) { %>
    <%@ include file="contactus.jsp"%>
<% } else if ("addcart".equalsIgnoreCase(sIndexAction)
              ||"shopcart".equalsIgnoreCase(sIndexAction)
              ||"Clear Cart".equalsIgnoreCase(sIndexAction)
              ||"Update Cart".equalsIgnoreCase(sIndexAction)) { %>
    <%@ include file="shopcart.jsp"%>
<% } else if ("Check Out".equalsIgnoreCase(sIndexAction)||"CheckOut".equalsIgnoreCase(sIndexAction)||"Login My Account".equalsIgnoreCase(sIndexAction)||"forgotpassword".equalsIgnoreCase(sIndexAction)||"Cancel".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="shoplogon.jsp"%>
<% } else if ("orderconfirm".equalsIgnoreCase(sIndexAction)||"Cancel Update".equalsIgnoreCase(sIndexAction)||"Order By Check".equalsIgnoreCase(sIndexAction)||"Monthly Charge".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="orderconfirm.jsp"%>
<% } else if ("New Customer".equalsIgnoreCase(sIndexAction)||"EditAccount".equalsIgnoreCase(sIndexAction)||
              "Submit Information".equalsIgnoreCase(sIndexAction)||"Submit Update".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="customer.jsp"%>
<% } else if ("Update Billing Information".equalsIgnoreCase(sIndexAction)||"EditBillingInfo".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="customerbilling.jsp"%>
<% } else if ("Order By Credit Card".equalsIgnoreCase(sIndexAction)||"Place Order".equalsIgnoreCase(sIndexAction)||"Callback".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="billinginfo.jsp"%>
<% } else if ("ordertrack".equalsIgnoreCase(sIndexAction)||"Login Account".equalsIgnoreCase(sIndexAction)||"Login".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="accountlogon.jsp"%>
<% } else if ("ordertracklist".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="ordertrack.jsp"%>
<% } else if ("advancesearch".equalsIgnoreCase(sIndexAction)||"Quick Search".equalsIgnoreCase(sIndexAction)||"Advance Search".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="advancesearch.jsp"%>
<% } else if ("showcontent".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="showcontent.jsp"%>
<% } else if ("filecontent".equalsIgnoreCase(sIndexAction)) { %>
    <%@ include file="filecontent.jsp"%>
<% } else if ("feedback".equalsIgnoreCase(sIndexAction)||"Submit Now".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="feedback.jsp"%>
<% } else if ("tellfriend".equalsIgnoreCase(sIndexAction)||"Send Now".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="tellfriend.jsp"%>
<% } else if ("showlinkpage".equalsIgnoreCase(sIndexAction)) { %>
      <%@ include file="linkpagedisplay.jsp"%>
<% } else {// if ("showproducts, Go".equalsIgnoreCase(sIndexAction) || sIndexAction==null) {
  if (!("showproducts".equalsIgnoreCase(sIndexAction))&&cfInfo1.HomeCategoryID<=0) {
%>
  <%@ include file="homepage.jsp"%>
<% } else { %>
<%@ include file="hero.jsp"%>
 <jsp:include page="productswitch.jsp" />
<% } %>
<% } %>
</div>
<% if (cfInfo1.VerticalBarSide==1) { %>
   <div class="contentWithSidebar">
     <%@ include file="verticalbar.jsp"%>
   </div>
<% } %>
</div>
</div>
</div>
<% if (!"test.hongfaamerica.com".equalsIgnoreCase(sDomainName1)) { %>
<div class="footerWrap">
<%@ include file="bottom.jsp"%>
</div>
<% } %>

<script src="/staticfile/web/scripts/scripts.js" type="text/javascript"></script>
</body>
</html>
<%  if ("Logout".equalsIgnoreCase(request.getParameter("final"))) {
    SessionWeb web = new SessionWeb(session, request);
    int nRet = web.sessionFinish(request);}
%>
<% }
   catch (Exception e)
   {
     e.printStackTrace();
   }
%>
