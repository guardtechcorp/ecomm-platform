<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ControlPanelBean"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%
  HttpSession parentSession = ControlPanelBean.getHttpSession(request.getParameter("domainname"), request.getParameter("sid"));
  ControlPanelBean bean = new ControlPanelBean(parentSession);
  UserInfo urInfo = (UserInfo)session.getAttribute(Definition.KEY_COMPANYUSER);
  CompanyInfo cpInfo = bean.getCompanyInfo();
//bean.showAllParameters(request, out);
//bean.showSessionInfo(request, application, session, out);
%>

<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-setup.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Website</b></font></td>
  <!--td><div id="leftcolumn"><div class='headers'>Website</div></div></td-->
 </tr>
 <tr>
  <td>
  <ul class='categorylinks1'>
  <li><a href='http://<%=bean.getDomainName()%>' target='_preview' class='genmed'>Site Preview</a></li>
<% if (bean.hasAccessRole(AccessRole.ROLE_CONFIG)) {%>
  <li><a href='../config/wizard1.jsp?action=Setup Wizard&rootlink=yes' target='main'>Setup Wizard</a></li>
  <li><a href='../config/config.jsp?action=Site Settings&rootlink=yes' target='main'>Site Settings</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_STATISTICS)) {%>
  <li><a href='../statistics/website.jsp?action=Site Statistics&rootlink=yes' target='main'>Site Statistics</a></li>
  <li><a href='../statistics/monitor.jsp?action=Realtime Monitor&rootlink=yes' target='main'>Realtime Monitor</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_DOMAINMONITOR)) {%>
  <li><a href='../statistics/watchlog.jsp?action=Realtime Monitor&rootlink=yes' target='main'>Watch All Logs</a></li>
<% } %>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% if (bean.hasAccessRole(AccessRole.ROLE_PRODUCT)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-product.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Product Online</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
    <li><a href='../product/productlist.jsp?action=Products&rootlink=yes' target='main'>Products</a></li>
    <li><a href='../product/categorylist.jsp?action=Categories&rootlink=yes' target='main'>Categories</a></li>
    <!--li><a href='../frame/listselection.jsp?action=Select Products&folder=product&top=top&left=categoryleft&right=productselect' target='main'>Select Products</a></li-->
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_ORDER|AccessRole.ROLE_SHIPMENT|AccessRole.ROLE_SALEREPORT)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-order.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Order & Shipment</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
<% if (bean.hasAccessRole(AccessRole.ROLE_ORDER)) {%>
  <li><a href='../order/orderlist.jsp?action=Orders&rootlink=yes' target='main'>Orders</a>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_SHIPMENT)) {%>
  <li><a href='../order/shiporderlist.jsp?action=Unshipped Orders&rootlink=yes' target='main'>Shipment</a>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_SALEREPORT)) {%>
    <li><a href='../statistics/salereport.jsp?action=Sales Report&rootlink=yes' target='main'>Sales Report</a></li>
<% } %>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_CHANGERATE)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-rate.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Payment, Ship & Tax</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
    <li><a href='../shiptax/payment.jsp?action=Payments&rootlink=yes' target='main'>Payments</a></li>
    <li><a href='../shiptax/shiplist.jsp?action=Ship Methods&rootlink=yes' target='main'>Ship Methods</a></li>
    <li><a href='../shiptax/taxlist.jsp?action=County Taxes&rootlink=yes' target='main'>County Taxes</a></li>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_INCENTIVEPLAN)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-incentive.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Incentive Plan</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
    <li><a href='../incentiveplan/discountrule.jsp?action=Incentive Rules&rootlink=yes' target='main'>Incentive Rules</a></li>
    <li><a href='../incentiveplan/grouplist.jsp?action=Manage Coupons&rootlink=yes' target='main'>Manage Coupons</a></li>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_CUSTOMER|AccessRole.ROLE_NEWSLETTER|AccessRole.ROLE_EMAILCAMPAIGN)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-customer.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Customer Care</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
<% if (bean.hasAccessRole(AccessRole.ROLE_CUSTOMER)) {%>
    <li><a href='../customer/customerlist.jsp?action=Customers&rootlink=yes' target='main'>Customers</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_NEWSLETTER)) {%>
    <li><a href='../feedback/newsletterlist.jsp?action=Subscribers&rootlink=yes'  target='main'>Subscribers</a></li>
    <li><a href='../feedback/feedbacklist.jsp?action=Feedback&rootlink=yes' target='main'>Feedback</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_EMAILCAMPAIGN)) {%>
   <li><a href='../util/email.jsp?action=Mass E-Mail&group=recipients&rootlink=yes' target='main'>Mass E-Mail</a></li>
   <li><a href='../autoresponse/responselist.jsp?action=Response List&rootlink=yes' target='main'>Autoresponder</a></li>
<% } %>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>

<% if (bean.hasAdsRoleByDomain()) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-website.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Ads Management</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
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
  </td>
 </tr>
</table>
<!!>
<% } %>

<% if (bean.hasAccessRole(AccessRole.ROLE_MEMBERAREA|AccessRole.ROLE_MEMBERS|AccessRole.ROLE_EXAM)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-membership.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Membership</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
<% if (bean.hasAccessRole(AccessRole.ROLE_MEMBERAREA)) {%>
    <li><a href='../membership/setting.jsp?action=Setting&rootlink=yes' target='main'>Setting</a></li>
<% if (!"www.sccaepa.org".equalsIgnoreCase(bean.getDomainName())) {%>
    <li><a href='../membership/planlist.jsp?action=Define Plan&rootlink=yes' target='main'>Define Plan</a></li>
    <li><a href='../membership/arealist.jsp?action=Setup Area&rootlink=yes' target='main'>Setup Area</a></li>
    <li><a href='../membership/onlinelist.jsp?action=Who are Online&rootlink=yes' target='main'>Who are Online</a></li>
<% } %>
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
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if ("www.sccaepa.org".equalsIgnoreCase(bean.getDomainName())) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-forum.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Event, News and Newsletter</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
     <li><a href='../link/pagelist.jsp?action=Page List&title=eventcalendar&rootlink=yes' target='main'>Events</a></li>
     <li><a href='../link/pagelist.jsp?action=Page List&title=newsannouncement&rootlink=yes' target='main'>News</a></li>
     <li><a href='../link/pagelist.jsp?action=Page List&title=newsletter&rootlink=yes' target='main'>Newsletter</a></li>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_FORUM_SETTING|AccessRole.ROLE_FORUM_USER)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-forum.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Forums</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
<% if (bean.hasAccessRole(AccessRole.ROLE_FORUM_USER)) {%>
    <li><a href='../forum/registerlist.jsp?action=Register List&rootlink=yes' target='main'>Register List</a></li>
<% } %>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_LIVECHAT_SETTING|AccessRole.ROLE_LIVECHAT_USER)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-livechat.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Live Chat</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
<% if (bean.hasAccessRole(AccessRole.ROLE_LIVECHAT_USER)) {%>
  <li><a href='../livechat/livechatlist.jsp?action=Session List&rootlink=yes' target='main'>Active Sessions</a></li>
  <li><a href='../livechat/livechathistorylist.jsp?action=History List&rootlink=yes' target='main'>History Records</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_LIVECHAT_SETTING)) {%>
  <li><a href='../livechat/livechatsetting.jsp?action=Live Chat Setting&rootlink=yes' target='main'>Settings</a></li>
<% } %>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<%if (bean.hasAccessRole(AccessRole.ROLE_QUICKBOOK)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-quickbook.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Quick Book</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
    <li><a href='../quickbook/booklist.jsp?action=Books&rootlink=yes' target='main'>Books</a></li>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_PUBLICAREA|AccessRole.ROLE_PRIVATEAREA)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-filemanage.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>File Management</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
<% if (bean.hasAccessRole(AccessRole.ROLE_PUBLICAREA)) {%>
    <li><a href='../file/filelist.jsp?action=WebSite Area&workarea=Public&rootlink=yes' target='main'>Website Area</a>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_PRIVATEAREA)) {%>
    <!--li><a href='../file/filelist.jsp?action=Private Area&workarea=Private' target='main'>Private Area</a-->
    <li><a href='../file/privatearea.jsp?action=User Private Area&rootlink=yes' target='main'>Private Area</a></li>
<% } %>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_USER)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-user.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>User Admin</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
    <li><a href='../user/userlist.jsp?action=Users&range=all&rootlink=yes' target='main'>Users</a></li>
    <li><a href='../user/emailboxlist.jsp?action=Email Boxes&rootlink=yes' target='main'>E-Mail Boxes</a></li>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_INFOMATION)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-website.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Information</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
    <li><a href='../config/company.jsp?action=Profile&rootlink=yes' target='main'>Profile</a></li>
    <li><a href='../config/billing.jsp?action=Billing Info&rootlink=yes' target='main'>Billing Info</a></li>
    <li><a href='../domain/invoicelist.jsp?action=Billing History&domainid=<%=cpInfo.CompanyID%>&rootlink=yes' target='main'>Billing History</a></li>
   </ul>
  </td>
 </tr>
</table>
<% } %>
<!!>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-logout.gif' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Logout</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks1'>
    <li><a href='../signin/login.jsp?action=logout&domainname=<%=bean.getDomainName()%>&rootlink=yes' target='_parent'>Exit Now</a></li>
   </ul>
  </td>
 </tr>
</table>
