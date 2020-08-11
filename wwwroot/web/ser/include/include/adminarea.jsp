<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.model.MembershipInfo"%>
<%@ page import="com.zyzit.weboffice.database.Membership"%>
<%
{
    MemberInfo onInfo = mcBean.getSiteOwnerInfo();
    MembershipInfo msInfo = mcBean.getSiteMembershipInfo();
 
%>
<!--div class="eg-bar"><span id="photo-title" class="iconspan"><img src="/staticfile/web/images/minus.gif" /></span>
<font color="#FFEFD5">Hi, <%=mbInfo.getPersonalName()%></font>&nbsp;&nbsp;
<A class="button" href='<%=mcBean.encodedUrl("index.jsp?action=Sign Out_SignIn")%>'>[Sign Out]</A>
</div>
<div id="photo" class="icongroup1">
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
  <tr>
   <td align="left" valign="top" bkColor="#eeeeee">
    <table cellspacing=0 cellpadding=1 width="100%" height="100%" align="center" border=0 bgColor="<%=mbInfo.SloganBkColor%>">
     <tr>
     <td><%=Utilities.getValue(mcBean.getPhotoImageHtml(mbInfo, 80, 90))%></td>
     <td align="center">
      <%=mcBean.getText(mbInfo.Slogan, mbInfo.SloganSize, mbInfo.SloganFont, mbInfo.SloganColor, (mbInfo.SloganStyle&10)!=0, (mbInfo.SloganStyle&12)!=0)%>
     </td>
     </tr>
    </table>
   </td>
  </tr>
</table>
</div-->
<div class="eg-bar"><span id="admin-title" class="iconspan"><img src="/staticfile/web/images/minus.gif" /></span><img src="/staticfile/web/images/tp05.gif" width=10 height=10>&nbsp;&nbsp;<b>Admin Functions</b></div>
<div id="admin" class="icongroup1" align="left">
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td height="5"></td>
</tr>    
 <tr>
  <td>&nbsp;&nbsp;<font size='2' color='#964635'><b>Profile</b></font></td>
 </tr>
 <tr>
  <td>
   <ul class='adminlinks'>
    <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_Profile&rootlink=yes&pagetitle=Account Information")%>">My Account</a></li>
    <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_Photo&rootlink=yes&pagetitle=My Photo")%>">My Photo</a>
<% if (mbInfo.Type==0) { %>
    <li><A href="<%=mcBean.encodedUrl("index.jsp?action=Load_UpgradeAccount&rootlink=yes&pagetitle=Upgrade Account")%>">Upgrade Account</A></li>
<% } %>
    <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_Password&rootlink=yes&pagetitle=Change Password")%>">Change Password</a>
    <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Load_CloseAccount&rootlink=yes&pagetitle=Close Account")%>">Close Account</a>
   </ul>
  </td>
 </tr>
<% if (mbInfo.Type==0) { %>
 <tr>
  <td>&nbsp;&nbsp;<font size='2' color='#964635'><b>Membership</b></font></td>
 </tr>
 <tr>
  <td>
   <ul class='adminlinks'>
  <% if (msInfo.JoinType!=Membership.JOINTYPE_NOMEMBERSHIP && !mcBean.isMemberOfSite(mbInfo.MemberID)) { %>
   <li><A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rootlink=yes&pagetitle=Apply Membership of This Site")%>' title="Click to apply the membership of <%=cfInfo.WebTitle%>.">Apply Membership</A></li>
   <% } else { %>
     <li><A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Quit_SiteMember&rootlink=yes&pagetitle=Leave Membership of This Site")%>' title="Click to quit the membership of <%=cfInfo.WebTitle%>.">Quit Membership</A></li>
   <% } %>
   </ul>
  </td>
 </tr>
<% } else { %>
 <% if (onInfo==null || mbInfo.MemberID!=onInfo.MemberID) { %>
   <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b>Site & Membership</b></font></td>
   </tr>
   <tr>
    <td>
     <ul class='adminlinks'>
     <li><A href="<%=mcBean.encodedUrl("index.jsp?action=Switch_ToMytSite&rootlink=yes")%>">To My Website</a></li>
   <% if (!mcBean.isMemberOfSite(mbInfo.MemberID)) { %>
     <li><A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rootlink=yes&pagetitle=Apply Membership of This Site")%>' title="Click to apply the membership of <%=cfInfo.WebTitle%>.">Apply Membership</A></li>
   <% } else { %>
     <li><A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Quit_SiteMember&rootlink=yes&pagetitle=Quit Membership of This Site")%>' title="Click to quit the membership of <%=cfInfo.WebTitle%>.">Quit Membership</A></li>                  
   <% } %>
     </ul>
    </td>
   </tr>
 <% } else { %>
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b>File Storage</b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
       <li><a href="<%=mcBean.encodedUrl("index.jsp?action=List_FileStorage&rootlink=yes&workarea=1&pagetitle=Public Storage")%>">Public Area</a></li>
       <li><a href="<%=mcBean.encodedUrl("index.jsp?action=List_FileStorage&rootlink=yes&workarea=8&pagetitle=Private Storage")%>">Private Area</a></li>
      </ul>
     </td>
    </tr>            
    <!--A class="topbutton" href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, product_menu, '110px')" onMouseout="delayhidemenu()">Product</A-->
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b>Web Site</b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
       <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_SiteSetting&rootlink=yes&pagetitle=Site Settings")%>">Site Settings</a></li>
       <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Load_WebPageList&rootlink=yes&pagetitle=Web Page List")%>">Web Pages</a></li>
       <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Load_Company&rootlink=yes&pagetitle=Organization Information")%>">Organization Information</a></li>
       <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Goto_MenuLink&rootlink=yes&pagetitle=Change the Links Positions")%>">Change Memu Position</a></li>
<!--li><A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rootlink=yes&pagetitle=Apply Membership of This Site")%>' title="Click to apply the membership of <%=cfInfo.WebTitle%>.">Apply Membership</A></li-->
      </ul>
     </td>
    </tr>
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b>Members</b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
       <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Load_Membership&rootlink=yes&pagetitle=Membership")%>">Membership</a></li>
<% if (msInfo.JoinType!=Membership.JOINTYPE_NOMEMBERSHIP) { %>
       <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Load_MemberList&rootlink=yes&pagetitle=Member List")%>">Member List</a></li>
<% } %>
      </ul>
     </td>
    </tr>
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b>Advanced Services</b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
      <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Load_PaidService&rootlink=yes&pagetitle=My Advanced Services")%>">My Services</a></li>
      <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Load_FeedbackList&rootlink=yes&pagetitle=Visitor Feedback")%>">Visitor Feedback</a></li>
     </ul>
     </td>
    </tr>
 <% } %>
<% } %>
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b>Exit</b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
       <li><a href="<%=mcBean.encodedUrl("index.jsp?action=Sign Out_SignIn")%>">Sign Out</a></li>
      </ul>
     </td>
    </tr>
</table>
</div>
<!--a href="javascript:faq.sweepToggle('contract/expand')">Contract All/Expand All</a-->
<script type="text/javascript">
var adminarea=new switchicon("icongroup1", "div"); //Limit scanning of switch contents to just "div" elements
adminarea.setHeader('<img src="/staticfile/web/images/minus.gif" />', '<img src="/staticfile/web/images/plus.gif" />');
adminarea.collapsePrevious(false);//true) //Allow only 1 content open at any time
adminarea.setPersist(true);//false); //No persistence enabled
adminarea.defaultExpanded(0); //Set 1st content to be expanded by default
adminarea.init();
</script>
<% } %>