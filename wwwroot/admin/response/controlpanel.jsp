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
<% if (bean.hasAccessRole(AccessRole.ROLE_CONFIG)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-setup.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Website Settings</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
    <li><a href='../statistics/website.jsp?action=Site Statistcs'>Site Statistics</a></li>
    <li><a href='../config/wizardtop.jsp?action=Setup Wizard'>Setup Wizard</a></li>
    <li><a href='../config/config.jsp?action=Site Settings'>Site Settings</a></li>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_PRODUCT)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-product.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Product</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
    <li><a href='../product/productlist.jsp?action=Products' target='main'>Products</a></li>
    <li><a href='../product/categorylist.jsp?action=Categories' target='main'>Categories</a></li>
    <li><a href='../frame/listselection.jsp?action=Select Products&folder=product&top=top&left=categoryleft&right=productselect' target='main'>Select Products</a></li>
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
    <ul class='categorylinks diffpointer'>
<% if (bean.hasAccessRole(AccessRole.ROLE_ORDER)) {%>
    <li><a href='../order/orderlist.jsp?action=Orders' target='main'>Orders</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_ORDER)) {%>
    <li><a href='../order/shiporderlist.jsp?action=Shipment' target='main'>Shipment</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_SALEREPORT)) {%>
    <li><a href='../statistics/salereport.jsp?action=Sales Report' target='main'>Sales Report</a></li>
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
  <img width=32 height=32 src='/staticfile/admin/images/icon-rate.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Payment, Ship & Tax Rate</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
    <li><a href='../shiptax/payment.jsp?action=Payments' target='main'>Payments</a></li>
    <li><a href='../shiptax/shiplist.jsp?action=Ship Methods' target='main'>Ship Methods</a></li>
    <li><a href='../shiptax/taxlist.jsp?action=County Taxes' target='main'>County Taxes</a></li>
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
  <img width=32 height=32 src='/staticfile/admin/images/icon-incentive.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Incentive Plan</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
    <li><a href='../incentiveplan/discountrule.jsp?action=Incentive Rules' target='main'>Incentive Rules</a></li>
    <li><a href='../incentiveplan/grouplist.jsp?action=Manage Coupons' target='main'>Manage Coupons</a></li>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_CUSTOMER|AccessRole.ROLE_EXPORT|AccessRole.ROLE_NEWSLETTER)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-customer.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Customer</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
<% if (bean.hasAccessRole(AccessRole.ROLE_CUSTOMER)) {%>
    <li><a href='../customer/customerlist.jsp?action=Customers' target='main'>Customers</a></li>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_NEWSLETTER)) {%>
    <li><a href='../feedback/newsletterlist.jsp?action=Subscribers'  target='main'>Subscribers</a></li>
    <li><a href='../feedback/feedbacklist.jsp?action=Feedback' target='main'>Feedback</a></li>
    <li><a href='../util/email.jsp?action=Mass E-Mail&group=customers' target='main'>Mass E-Mail</a></li>
<% } %>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_MEMBERAREA)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-membership.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Membership</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
    <li><a href='../membership/setting.jsp?action=Setting' target='main'>Setting</a></li>
    <li><a href='../membership/arealist.jsp?action=Setup Area' target='main'>Setup Area</a></li>
    <li><a href='../membership/planlist.jsp?action=Define Plan' target='main'>Define Plan</a></li>
    <li><a href='../membership/memberlist.jsp?action=Members' target='main'>Members</a></li>
    <li><a href='../membership/onlinelist.jsp?action=Who are Online' target='main'>Who are Online</a></li>
    <li><a href='../membership/statistics.jsp?action=Statistics' target='main'>Statistics</a></li>
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
  <img width=32 height=32 src='/staticfile/admin/images/icon-quickbook.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Quick Book</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
    <li><a href='../quickbook/booklist.jsp?action=Books' target='main'>Books</a></li>
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
  <img width=32 height=32 src='/staticfile/admin/images/icon-filemanage.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>File Management</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
<% if (bean.hasAccessRole(AccessRole.ROLE_PUBLICAREA)) {%>
    <li><a href='../file/filelist.jsp?action=WebSite Area&workarea=Public' target='main'>Website Area</a>
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_PRIVATEAREA)) {%>
    <li><a href='../file/filelist.jsp?action=Private Area&workarea=Private' target='main'>Private Area</a>
<% } %>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% } %>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-user.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>User</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
<% if (bean.hasAccessRole(AccessRole.ROLE_USER)) {%>
    <li><a href='../user/userlist.jsp?action=Users&range=all' target='main'>Users</a></li>
<% } %>
    <li><a href='../user/password.jsp?action=Change Password' target='main'>Change Password</a></li>
<% if (bean.hasAccessRole(AccessRole.ROLE_EMAILBOX)) {%>
    <li><a href='../signin/login.jsp?action=Emailbox' target='mailbox'>My E-Mail Box</a></li>
<% } %>
   </ul>
  </td>
 </tr>
</table>
<!!>
<% if (bean.hasAccessRole(AccessRole.ROLE_INFOMATION)) {%>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-website.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Information</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
    <li><a href='../config/company.jsp?action=Profile' target='main'>Profile</a></li>
    <li><a href='../config/billing.jsp?action=Billing Info' target='main'>Billing Info</a></li>
    <li><a href='../domain/invoicelist.jsp?action=Billing History&domainid=<%=cpInfo.CompanyID%>' target='main'>Billing History</a></li>
   </ul>
  </td>
 </tr>
</table>
<% } %>
<!!>
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td valign=top width=15% rowspan=2>
  <img width=32 height=32 src='/staticfile/admin/images/icon-logout.jpg' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
  </td>
  <td><font size='2' color='#964635'><b>Logout</b></font></td>
 </tr>
 <tr>
  <td>
    <ul class='categorylinks diffpointer'>
    <li><a href='../signin/login.jsp?action=logout&domainname=<%=bean.getDomainName()%>' target='_parent'>Exit Now</a></li>
   </ul>
  </td>
 </tr>
</table>
