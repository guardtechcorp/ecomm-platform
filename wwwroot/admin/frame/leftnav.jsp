<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.AccessRole"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<link rel="stylesheet" href="/staticfile/admin/css/main.css" type="text/css">
<title>www.webonlinemanage.com - Left Navigation Panel</title>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/events.js"></SCRIPT>
</head>
<%
   UserInfo urInfo = (UserInfo)session.getAttribute(Definition.KEY_COMPANYUSER);
   BasicBean bean = new BasicBean(session, null);
//System.out.println("Step 3=" + bean.hasAdsRoleByDomain());
   CompanyInfo cpInfo = bean.getCompanyInfo();

/*
   <link rel="stylesheet" type="text/css" href="/staticfile/admin/css/slash-menu.css">
   <script type="text/javascript" src="/staticfile/admin/scripts/slash-menu.js"></script>
   <tr>
     <td height="25">
   <p align="left"><a href="javascript:slash_expandall()">Expand</a>/
   <a href="javascript:slash_contractall()">Contract</a></p>

       <div class="sdmenu">
         <span class="title" id="top"><img src="/staticfile/admin/css/media/slash-expanded.gif" class="arrow" alt="-" />Online Tools</span>
         <div class="submenu">
           <a href="http://tools.dynamicdrive.com/imageoptimizer/">Image Optimizer</a>
           <a href="http://tools.dynamicdrive.com/favicon/">FavIcon Generator</a>
           <a href="http://www.dynamicdrive.com/emailriddler/">Email Riddler</a>
           <a href="http://tools.dynamicdrive.com/password/">htaccess Password</a>
           <a href="http://tools.dynamicdrive.com/gradient/">Gradient Image</a>
           <a href="http://tools.dynamicdrive.com/button/">Button Maker</a>
         </div>
         <span class="title"><img src="/staticfile/admin/css/media/slash-expanded.gif" class="arrow" alt="-" />Support Us</span>
         <div class="submenu">
           <a href="http://www.dynamicdrive.com/recommendit/">Recommend Us</a>
           <a href="http://www.dynamicdrive.com/link.htm">Link to Us</a>
           <a href="http://www.dynamicdrive.com/resources/">Web Resources</a>
         </div>
         <span class="title"><img src="/staticfile/admin/css/media/slash-expanded.gif" class="arrow" alt="-" />Partners</span>
         <div class="submenu">
           <a href="http://www.javascriptkit.com">JavaScript Kit</a>
           <a href="http://www.cssdrive.com">CSS Drive</a>
           <a href="http://www.codingforums.com">CodingForums</a>
           <a href="http://www.dynamicdrive.com/style/">CSS Examples</a>
         </div>
       </div>
     </td>
   </tr>
*/
%>
<body style="margin-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; background-color: #4959A7">
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="left">
  <!--tr>
    <td align="center" valign="top">
    <a href="../signin/login.jsp?action=logout&domainname=<%=bean.getDomainName()%>" class="mainmenu" target="_parent">Log out [ <%=urInfo.Username%> ]</a>
    </td>
  <tr-->
   <tr>
    <td align="center" valign="top">
      <table width="100%" cellpadding="4" cellspacing="1" border="0" class1="forumline">
        <!--tr>
          <th height="25" class="thHead"><b>Administration</b></th>
        </tr-->
      <tr>
       <td valign="top" bgcolor="#4959A7"><div id="leftcolumn">
  <div class='headers'>Website</div>

<ul class='categorylinks'>
<% if (bean.getHttpsUrl()!=null) { %>
  <li><a href='http://<%=bean.getDomainName()%>' target='_blank' class='genmed'>Site Preview</a></li>
<% } else { %>
  <li><a href='../../../web/index.jsp' target='_preview' class='genmed'>Site Preview</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_CONFIG)) {%>
  <li><a href='../config/wizard1.jsp?action=Setup Wizard&rootlink=yes' target='main'>Setup Wizard</a></li>
  <li><a href='../config/config.jsp?action=Site Settings&rootlink=yes' target='main'>Site Settings</a></li>
  <!--li><a href='../config/verticalpanellist.jsp?action=Get List' target='main'>Vertical Panel</a></li-->
  <!--li><a href='../config/linkpagelist.jsp?action=Get List' target='main'>Link Page</a></li-->
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_STATISTICS)) {%>
  <li><a href='../statistics/website.jsp?action=Site Statistics&rootlink=yes' target='main'>Site Statistics</a></li>
  <li><a href='../statistics/monitor.jsp?action=Realtime Monitor&rootlink=yes' target='main'>Realtime Monitor</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_DOMAINMONITOR)) {%>
  <li><a href='../statistics/watchlog.jsp?action=Realtime Monitor&rootlink=yes' target='main'>Watch All Logs</a></li>
<% } %>
</ul>
<% if (bean.hasAccessRole(AccessRole.ROLE_PRODUCT)) {%>
  <div class='headers'>Product Online</div>
  <ul class='categorylinks'>
  <li><a href='../product/productlist.jsp?action=Products&rootlink=yes' target='main'>Products</a>
  <li><a href='../product/categorylist.jsp?action=Categories&rootlink=yes' target='main'>Categories</a>
  <!--li><a href='../frame/listselection.jsp?action=Select Products&folder=product&top=top&left=categoryleft&right=productselect' target='main'>Select Products</a-->
  </li></ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_ORDER|AccessRole.ROLE_SHIPMENT|AccessRole.ROLE_SALEREPORT)) {%>
  <div class='headers'>Order & Shipment</div>
  <ul class='categorylinks'>
<% if (bean.hasAccessRole(AccessRole.ROLE_ORDER)) {%>
  <li><a href='../order/orderlist.jsp?action=Orders&rootlink=yes' target='main'>Orders</a>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_SHIPMENT)) {%>
  <li><a href='../order/shiporderlist.jsp?action=Unshipped Orders&rootlink=yes' target='main'>Shipment</a>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_SALEREPORT)) {%>
  <li><a href='../statistics/salereport.jsp?action=Sales Report&rootlink=yes' target='main'>Sales Report</a>
<% } %>
  </li></ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_CHANGERATE)) {%>
  <div class='headers'>Payment, Ship & Tax </div>
  <ul class='categorylinks'>
  <li><a href='../shiptax/payment.jsp?action=Payments&rootlink=yes' target='main'>Payments</a>
  <!--li><a href='../shiptax/shiplist.jsp?action=Ship Methods' target='main'>Ship Methods</a-->
  <li><a href='../shiptax/shipoption.jsp?action=Ship Option&rootlink=yes' target='main'>Ship Options</a>
  <li><a href='../shiptax/taxlist.jsp?action=County Taxes&rootlink=yes' target='main'>County Taxes</a>
  </li></ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_INCENTIVEPLAN)) {%>
  <div class='headers'>Incentive Plan</div>
  <ul class='categorylinks'>
  <li><a href='../incentiveplan/discountrule.jsp?action=Incentive Rules&rootlink=yes' target='main'>Incentive Rules</a>
  <li><a href='../incentiveplan/grouplist.jsp?action=Manage Coupons&rootlink=yes' target='main'>Manage Coupons</a>
  </li></ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_CUSTOMER|AccessRole.ROLE_NEWSLETTER|AccessRole.ROLE_EMAILCAMPAIGN)) {%>
  <div class='headers'>Customer Care</div>
  <ul class='categorylinks'>
<% if (bean.hasAccessRole(AccessRole.ROLE_CUSTOMER)) {%>
  <li><a href='../customer/customerlist.jsp?action=Customers&rootlink=yes' target='main'>Customers</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_NEWSLETTER)) {%>
  <li><a href='../feedback/newsletterlist.jsp?action=Subscribers&rootlink=yes'  target='main'>Subscribers</a></li>
  <li><a href='../feedback/feedbacklist.jsp?action=Feedback'  target='main'>Feedback</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_EMAILCAMPAIGN)) {%>
  <li><a href='../util/email.jsp?action=Mass E-Mail&group=recipients&rootlink=yes' target='main'>Mass E-Mail</a></li>
  <li><a href='../autoresponse/responselist.jsp?action=Response List&rootlink=yes' target='main'>Autoresponder</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_COMMUNITY)) {%>
  <!--li><a href='../feedback/newsletterlist.jsp?action=Subscribers&rootlink=yes'  target='main'>Mail List</a></li-->
  <li><a href='../feedback/newslettergrouplist.jsp?action=Load&rootlink=yes' target='main'>Mail List Group</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_SEARCHPAGE)) { %>
  <li><a href='../link/searchpagelist.jsp?action=Load&rootlink=yes' target='main'>Search Page List</a></li>
<% } %>
 </ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_COMMUNITY)) {%>
  <div class='headers'>Community</div>
  <ul class='categorylinks'>
  <li><a href='../community/userlist.jsp?action=Member List&range=all&rootlink=yes' target='main'>Members</a></li>
  <li><a href='../community/subdomainlist.jsp?action=Domain List&range=all&rootlink=yes' target='main'>Sub-Domains</a></li>
  <li><a href='../community/storagelist.jsp?action=Storage List&range=all&rootlink=yes' target='main'>Storage</a></li>
  <li><a href='../community/paypallist.jsp?action=Shop List&range=all&rootlink=yes' target='main'>Shop List</a></li>
  <li><a href='../community/optoutlist.jsp?action=Email List&range=all&rootlink=yes' target='main'>Opt-Out List</a></li>
  <li><a href='../community/proxyserverlist.jsp?action=Server List&range=all&rootlink=yes' target='main'>Proxy Servers</a></li>
  <li><a href='../community/sitesetting.jsp?action=Edit&rootlink=yes' target='main'>Site Setting</a></li>
  <li><a href='../community/websitelist.jsp?action=Edit&rootlink=yes' target='main'>Websites</a></li>
  <li><a href='../community/subsitelist.jsp?action=Edit&rootlink=yes' target='main'>Subsites Mapping</a></li>
  </ul>
<% } %>

<% if (bean.hasAdsRoleByDomain()) { %>
  <div class='headers'>Advertisement</div>
  <ul class='categorylinks'>
<% if (bean.hasAccessRole(AccessRole.ROLE_ADS_UPDATE)) {%>
  <li><a href='../ads/adslist.jsp?action=Adslist&range=all&rootlink=yes' target='main'>Ads List</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_ADS_PUBLISH)) {%>
  <li><a href='../ads/setting.jsp?action=Config' target='main'>Ads Campaign</a></li>
<% } %>
 <% if (bean.hasAccessRole(AccessRole.ROLE_ADS_STATISTICS)) {%>
  <li><a href='../ads/historylist.jsp?action=Records' target='main'>History Record</a></li>
  <li><a href='../ads/statistics.jsp?action=Summery' target='main'>Summary Report</a></li>
 <% } %>
<% if (bean.haveGrantRole()) { %>
  <li></li>
  <li><a href='../ads/userlist.jsp?action=Users&range=all&rootlink=yes' target='main'>Manage Users</a></li>
<% } %>
  </ul>
<% } %>

<% if (bean.hasAccessRole(AccessRole.ROLE_MEMBERAREA|AccessRole.ROLE_MEMBERS|AccessRole.ROLE_EXAM)) {%>
  <div class='headers'>Membership</div>
  <ul class='categorylinks'>
<% if (bean.hasAccessRole(AccessRole.ROLE_MEMBERAREA)) {%>
  <li><a href='../membership/setting.jsp?action=Setting&rootlink=yes' target='main'>Setting</a></li>
  <li><a href='../membership/planlist.jsp?action=Define Plan&rootlink=yes' target='main'>Define Plan</a></li>
  <li><a href='../membership/arealist.jsp?action=Setup Area&rootlink=yes' target='main'>Setup Area</a></li>
  <li><a href='../membership/onlinelist.jsp?action=Who are Online&rootlink=yes' target='main'>Who are Online</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_MEMBERS)) {%>
  <li>
<% if ("www.sccaepa.org".equalsIgnoreCase(bean.getDomainName())) {%>
     <a href='../membership/member2list.jsp?action=Members&rootlink=yes' target='main'>Members</a>
<% } else { %>
     <a href='../membership/memberlist.jsp?action=Members&rootlink=yes' target='main'>Members</a>
<% } %>
  </li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_EXAM)) {%>
  <li><a href='../exam/sectionlist.jsp?action=Section List&rootlink=yes' target='main'>Exam Section</a></li>
<% } %>
  </ul>
<% } %>
<% if ("www.sccaepa.org".equalsIgnoreCase(bean.getDomainName())||"www.test101.wlmg.net".equalsIgnoreCase(bean.getDomainName())) {%>
  <div class='headers'>Event, News and Newsletter</div>
  <ul class='categorylinks'>
  <li><a href='../link/pagelist.jsp?action=Page List&title=specialevent&rootlink=yes' target='main'>Special Events</a></li>
  <li><a href='../link/pagelist.jsp?action=Page List&title=eventcalendar&rootlink=yes' target='main'>Events</a></li>
  <li><a href='../link/pagelist.jsp?action=Page List&title=newsannouncement&rootlink=yes' target='main'>News</a></li>
  <li><a href='../link/pagelist.jsp?action=Page List&title=newsletter&rootlink=yes' target='main'>Newsletter</a></li>
  <li><a href='../link/pagelist.jsp?action=Page List&title=englishpapers&rootlink=yes' target='main'>Papers(Engish)</a></li>
  <li><a href='../link/pagelist.jsp?action=Page List&title=chinesepapers&rootlink=yes' target='main'>Pagers(Chinese)</a></li>

  <li><a href='../link/pagelist.jsp?action=Page List&title=jobopportunity&rootlink=yes' target='main'>Job Opportunity</a></li>
  </ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_FORUM_SETTING|AccessRole.ROLE_FORUM_USER)) {%>
  <div class='headers'>Forum</div>
  <ul class='categorylinks'>
<% if (bean.hasAccessRole(AccessRole.ROLE_FORUM_USER)) {%>
  <li><a href='../forum/registerlist.jsp?action=Register List&rootlink=yes' target='main'>Register List</a></li>
<% } %>
  </ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_LIVECHAT_SETTING|AccessRole.ROLE_LIVECHAT_USER)) {%>
  <div class='headers'>Live Chat</div>
  <ul class='categorylinks'>
<% if (bean.hasAccessRole(AccessRole.ROLE_LIVECHAT_USER)) {%>
  <li><a href='../livechat/livechatlist.jsp?action=Session List&rootlink=yes' target='main'>Active Sessions</a></li>
  <li><a href='../livechat/livechathistorylist.jsp?action=History List&rootlink=yes' target='main'>History List</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_LIVECHAT_SETTING)) {%>
  <li><a href='../livechat/livechatsetting.jsp?action=Live Chat Setting&rootlink=yes' target='main'>Settings</a></li>
<% } %>
  </ul>
<% } %>
<%if (bean.hasAccessRole(AccessRole.ROLE_QUICKBOOK)) {%>
  <div class='headers'>Quick Book</div>
  <ul class='categorylinks'>
  <li><a href='../quickbook/booklist.jsp?action=Books&rootlink=yes' target='main'>Books</a></li>
  </ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_PUBLICAREA|AccessRole.ROLE_PRIVATEAREA)) {%>
  <div class='headers'>File Management</div>
  <ul class='categorylinks'>
<% if (bean.hasAccessRole(AccessRole.ROLE_PUBLICAREA)) {%>
  <li><a href='../file/filelist.jsp?action=Website Area&workarea=Public&rootlink=yes' target='main'>Website Area</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_PRIVATEAREA)) {%>
  <li><a href='../file/privatearea.jsp?action=User Private Area&rootlink=yes' target='main'>Private Area</a></li>
<% } %>
  </ul>
<% } %>

<% if (bean.hasAccessRole(AccessRole.ROLE_USER)) {%>
  <div class='headers'>User Admin</div>
  <ul class='categorylinks'>
  <li><a href='../user/userlist.jsp?action=Users&range=all&rootlink=yes' target='main'>Users</a></li>
  <!--li><a href='../user/emailboxlist.jsp?action=Email Boxes&rootlink=yes' target='main'>E-Mail Boxes</a></li-->
  </ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_INFOMATION)) {%>
  <div class='headers'>Information</div>
  <ul class='categorylinks'>
  <li><a href='../config/company.jsp?action=Profile&rootlink=yes' target='main'>Profile</a>
  <li><a href='../config/billing.jsp?action=Billing Info&rootlink=yes' target='main'>Billing Info</a>
  <li><a href='../domain/invoicelist.jsp?action=Billing History&domainid=<%=cpInfo.CompanyID%>&rootlink=yes' target='main'>Payment History</a>
  </li></ul>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_DATABASE|AccessRole.ROLE_DOMAIN|AccessRole.ROLE_DOMAINBILL)) {%>
  <div class='headers'>Domain Manage</div>
  <ul class='categorylinks'>
<% if (bean.hasAccessRole(AccessRole.ROLE_DOMAIN)) {%>
  <li><a href='../domain/domainlist.jsp?action=Company Domain&rootlink=yes' target='main'>Company Domain</a>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_DOMAINBILL)) {%>
  <li><a href='../domain/billinglist.jsp?action=Billing List&rootlink=yes' target='main'>Company Billing</a>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_DATABASE)) {%>
  <li><a href='javascript:;'>Backup</a>
  <li><a href='javascript:;'>Restore</a>
<% } %>
  </li></ul>
<% } %>
        </div>

        </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<!--hr-->
<!--div align='center'><span class='copyright'><%=bean.getCopyRight()%><br>
 <%=bean.getPowerBy()%></span>
</div-->
</body>
</html>