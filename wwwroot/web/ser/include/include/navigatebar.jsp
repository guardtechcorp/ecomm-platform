<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.model.MembershipInfo"%>
<%@ page import="com.zyzit.weboffice.database.Membership"%>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%
{
    MemberInfo mbInfo = mcBean.getMemberInfo();
    MemberInfo onInfo = mcBean.getSiteOwnerInfo();
    MembershipInfo msInfo = mcBean.getSiteMembershipInfo();
%>
<% if (cfInfo.DomainSize>0) { %>
<div id1="ddtoptabsline" style="width: 100%;height: <%=cfInfo.DomainSize%>px;background: <%=cfInfo.DomainFont%>;border-bottom: 1px solid #fff;margin-top: 2px;margin-bottom: 0px;"><img src="/staticfile/web/images/spacer.gif"></div>
<% } %>

<% if (mbInfo!=null && cfInfo.VerticalBarSide==0) { %>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/dropmenu.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" type="text/javascript">
var account_menu=new Array();
account_menu[0]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_Profile&rootlink=yes&pagetitle=Account Information")%>">&nbsp;My Account</a>';
account_menu[1]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_Photo&rootlink=yes&pagetitle=My Photo")%>">&nbsp;My Photo</a>';
account_menu[2]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_Password&rootlink=yes&pagetitle=Change Password")%>">&nbsp;Change Password</a>';
account_menu[3]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_CancelAccount&rootlink=yes&pagetitle=Close Account")%>">&nbsp;Close Account</a>';
//account_menu[5]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_Company&rootlink=yes&pagetitle=Business Information")%>">Business Information</a>';
var upgrade_menu=new Array();
upgrade_menu[0]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_UpgradeAccount&rootlink=yes&pagetitle=Upgrade Account")%>">&nbsp;Upgrade Account</a>';
var member_menu=new Array();
member_menu[0]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_Membership&rootlink=yes&pagetitle=Membership")%>">&nbsp;Membership</a>';
<% if (msInfo.JoinType!=Membership.JOINTYPE_NOMEMBERSHIP) { %>
member_menu[1]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_MemberList&rootlink=yes&pagetitle=Member List")%>">&nbsp;Member List</a>';
<% } %>
var message_menu=new Array();
message_menu[0]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_MsgInboxList&rootlink=yes&pagetitle=Inbox Message")%>">&nbsp;Inbox Message</a>';
message_menu[1]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_MsgSentList&rootlink=yes&pagetitle=Send Message")%>">&nbsp;Sent Message</a>';
var filestorage_menu=new Array();
filestorage_menu[0]='<a href="<%=mcBean.encodedUrl("index.jsp?action=List_FileStorage&rootlink=yes&pagetitle=File Storage List")%>">&nbsp;File List</a>';
//filestorage_menu[1]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_CategoryList&rootlink=yes&pagetitle=Category List")%>">Categories</a>';
var product_menu=new Array();
product_menu[0]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_CategoryList&rootlink=yes&pagetitle=Category List")%>">&nbsp;Categories</a>';
product_menu[1]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_ProductList&rootlink=yes&pagetitle=Product List")%>">&nbsp;Products</a>';
var website_menu=new Array();
website_menu[0]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_SiteSetting&rootlink=yes&pagetitle=Site Settings")%>">&nbsp;Site Settings</a>';
website_menu[1]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Load_WebPageList&rootlink=yes&pagetitle=Web Page List")%>">&nbsp;Web Pages</a>';
website_menu[2]='<a href="<%=mcBean.encodedUrl("index.jsp?action=Goto_MenuLink&rootlink=yes&pagetitle=Change the Links Positions")%>">&nbsp;Memu Link Changes</a>';
var exit_menu=new Array();
exit_menu[0]='<A href="<%=mcBean.encodedUrl("index.jsp?action=Sign Out_SignIn")%>">&nbsp;Sign Out</A>';
</SCRIPT>
<TABLE id="titlebarnav1" border="0" cellspacing="0" cellpadding="0" width="100%" height="25" style="background-color: #7392D4; border: 1px solid #DFDFDF;">
<TR>
 <TD width="100%" id="underlinetd">
    <!--A href='<%=mcBean.encodedUrl("index.jsp?action=Visit_MyHome&rootlink=yes&pagetitle=My Home")%>'>My Home</A-->
    <!--A class="topbutton" href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, message_menu, '110px')" onMouseout="delayhidemenu()">Message</A-->
   <A class1="topbutton" href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, account_menu, '150px')" onMouseout="delayhidemenu()">Profile</A>
<% if (mbInfo.Type==0) { %>
    <A href="<%=mcBean.encodedUrl("index.jsp?action=Load_UpgradeAccount&rootlink=yes&pagetitle=Upgrade Account")%>">&nbsp;Upgrade Account</A>
<% if (!mcBean.isMemberOfSite(mbInfo.MemberID)) { %>
    <A class1="content" href='<%=mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rootlink=yes&pagetitle=Apply Membership of This Site")%>' title="Click to apply the membership of <%=cfInfo.WebTitle%>.">Apply Membership</A>
<% } %>
<% } else { %>
<% if (onInfo==null || mbInfo.MemberID!=onInfo.MemberID) { %>
   <A href="<%=mcBean.encodedUrl("index.jsp?action=Switch_ToMytSite&rootlink=yes")%>">To My Website</a>
<% if (msInfo.JoinType!=Membership.JOINTYPE_NOMEMBERSHIP && !mcBean.isMemberOfSite(mbInfo.MemberID)) { %>
   <A class1="content" href='<%=mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rootlink=yes&pagetitle=Apply Membership of This Site")%>' title="Click to apply the membership of <%=cfInfo.WebTitle%>.">Apply Membership</A>
<% } %>
<% } else { %>
   <A href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, filestorage_menu, '110px')" onMouseout="delayhidemenu()">File Storage</A>
    <!--A class="topbutton" href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, product_menu, '110px')" onMouseout="delayhidemenu()">Product</A-->
   <A href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, website_menu, '130px')" onMouseout="delayhidemenu()">Web Site</A>
   <A href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, member_menu, '110px')" onMouseout="delayhidemenu()">Members</A>
<% } %>
<% } %>
   <A href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, exit_menu, '110px')" onMouseout="delayhidemenu()">Exit</A>&nbsp;
 </TD>
</TR>
</TABLE>
<% } %>

<% } %>