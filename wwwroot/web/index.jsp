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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<HEAD>
<%=web1.getHtmlTitleMeta(request, false)%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<META name="DISTRIBUTION" content="GLOBAL">
<META name="COPYRIGHT" content="Copyright 1998-2007 webonlinemanage.com - Redistribution in part or in whole strictly prohibited.">
<META name="DESCRIPTION" content="A place for your cyber life">
<META name="ROBOTS" content="INDEX, FOLLOW">
<META name="REVISIT-AFTER" content="1 DAYS">
<META name="RATING" content="GENERAL">    
<LINK href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet">
<LINK href="/staticfile/web/css/tabs.css" type="text/css" rel="stylesheet">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/languages/<%=cfInfo1.Language%>.js"  type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/windows.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/customer.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/session.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/newsletter.js"  type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/jquery_pack.js"  type="text/javascript"></SCRIPT>
<style type="text/css">
</style>
</HEAD>
<%@ include file="actioncheck.jsp"%>
<BODY onLoad2="initjsDOMenu();" onUnload="onBrowserClose('logout.jsp');" LEFTMARGIN=1 TOPMARGIN=1 <%=sBackground%>>
<SCRIPT language="JavaScript" type="text/javascript">
function createjsDOMenu()
{
}
</SCRIPT>
<% if (!"test.hongfaamerica.com".equalsIgnoreCase(sDomainName1)) { %>
<%@ include file="floatingnews.jsp"%>
<%@ include file="titlebar.jsp"%>
<%@ include file="advertise.jsp"%>
<% } else {
    LayoutWeb web = new LayoutWeb(session, request);
    ConfigInfo cfInfo = web.getConfigInfo();
%>
<table width=778 border=0 cellpadding=0 cellspacing=0 align="center" style="border: 1px solid #cccccc">
<form name="searchform" action="<%=web.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateGoSearch(this);">
    <input type="hidden" name="action1" value="Quick Search">
    <input type="hidden" name="categoryid" value="-13">
    <tr>
        <td height="45"></td>
        <td>
           <div align="right"><%=web.getProductSearch(cfInfo)%></div>
        </td>
    </tr>
</form>
</table>
<br>
<% } %>
<DIV>
<TABLE width="<%=sScreenWidth%>" align="center" cellSpacing=0 cellPadding=0 border=0 bgcolor="<%=cfInfo1.BackColor%>">
  <TR>
<% if (cfInfo1.VerticalBarSide==0) { %>
   <TD class="table-3" vAlign="top" width="180">
     <%@ include file="verticalbar.jsp"%>
   </TD>
<% } %>

<% if (cfInfo1.VerticalBarSide!=2) { %>
    <TD vAlign="top" width="598">
<% } else { %>
    <TD vAlign="top">
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
 <jsp:include page="productswitch.jsp" />
<% } %>
<% } %>
   </TD>
<% if (cfInfo1.VerticalBarSide==1) { %>
   <TD class="table-3" vAlign="top" width="180">
     <%@ include file="verticalbar.jsp"%>
   </TD>
<% } %>
  </TR>
</TABLE>
</DIV>
<% if (!"test.hongfaamerica.com".equalsIgnoreCase(sDomainName1)) { %>
<%@ include file="bottom.jsp"%>
<% } %>
</BODY>
</HTML>
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

