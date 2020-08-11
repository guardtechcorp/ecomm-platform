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
<div class="eg-bar"><span id="admin-title" class="iconspan"><img src="/staticfile/web/images/minus.gif" /></span><img src="/staticfile/web/images/tp05.gif" width=10 height=10>&nbsp;&nbsp;<b><%=mcBean.getLabel("mt-adminfunction")%></b></div>
<div id="admin" class="icongroup1" align="left">
<table cellspacing=0 cellpadding=3 border=0>
 <tr>
  <td height="5"></td>
</tr>    
 <tr>
  <td>&nbsp;&nbsp;<font size='2' color='#964635'><b><%=mcBean.getLabel("mt-profile")%></b></font></td>
 </tr>
 <tr>
  <td>
   <ul class='adminlinks'>
    <li><%=mcBean.getAdminMenuLink(-105)%></li>
    <li><%=mcBean.getAdminMenuLink(-106)%></li>
<% if (mbInfo.Type==0) { %>
    <li><%=mcBean.getAdminMenuLink(-107)%></li>
<% } %>
    <li><%=mcBean.getAdminMenuLink(-108)%></li>
    <li><%=mcBean.getAdminMenuLink(-109)%></li>
   </ul>
  </td>
 </tr>
<% if (mbInfo.Type==0) { %>
 <tr>
  <td>&nbsp;&nbsp;<font size='2' color='#964635'><b><%=mcBean.getLabel("mt-membership")%></b></font></td>
 </tr>
 <tr>
  <td>
   <ul class='adminlinks'>
  <% if (msInfo.JoinType!=Membership.JOINTYPE_NOMEMBERSHIP && !mcBean.isMemberOfSite(mbInfo.MemberID)) { %>
   <li><%=mcBean.getAdminMenuLink(-110)%></li>
   <% } else { %>
   <li><%=mcBean.getAdminMenuLink(-111)%></li>
   <% } %>
   </ul>
  </td>
 </tr>
<% } else { %>
 <% if (onInfo==null || mbInfo.MemberID!=onInfo.MemberID) { %>
   <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b><%=mcBean.getLabel("mt-sitemembership")%></b></font></td>
   </tr>
   <tr>
    <td>
     <ul class='adminlinks'>
   <% if (!mcBean.isMemberOfSite(mbInfo.MemberID)) { %>
     <li><%=mcBean.getAdminMenuLink(-110)%></li>
   <% } else { %>
     <li><%=mcBean.getAdminMenuLink(-111)%></li>
   <% } %>
     </ul>
    </td>
   </tr>
 <% } else { %>
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b><%=mcBean.getLabel("mt-filestorage")%></b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
       <li><%=mcBean.getAdminMenuLink(-113)%></li>
       <li><%=mcBean.getAdminMenuLink(-114)%></li>
      </ul>
     </td>
    </tr>            
    <!--A class="topbutton" href="#" onClick="return clickreturnvalue()" onMouseover="dropdownmenu(this, event, product_menu, '110px')" onMouseout="delayhidemenu()">Product</A-->
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b><%=mcBean.getLabel("mt-website")%></b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
      <li><%=mcBean.getAdminMenuLink(-115)%></li>
      <li><%=mcBean.getAdminMenuLink(-116)%></li>
      <li><%=mcBean.getAdminMenuLink(-118)%></li>
      <li><%=mcBean.getAdminMenuLink(-117)%></li>
      </ul>
     </td>
    </tr>
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b><%=mcBean.getLabel("mt-member")%></b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
       <li><%=mcBean.getAdminMenuLink(-119)%></li>
<% if (msInfo.JoinType!=Membership.JOINTYPE_NOMEMBERSHIP) { %>
       <li><%=mcBean.getAdminMenuLink(-120)%></li>
<% } %>
       <li><%=mcBean.getAdminMenuLink(-121)%></li>          
      </ul>
     </td>
    </tr>
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b><%=mcBean.getLabel("mt-advservice")%></b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
      <li><%=mcBean.getAdminMenuLink(-122)%></li>
      <li><%=mcBean.getAdminMenuLink(-123)%></li>
     </ul>
     </td>
    </tr>
 <% } %>
<% } %>
    <tr>
     <td>&nbsp;&nbsp;<font size='2' color='#964635'><b><%=mcBean.getLabel("mt-siteexit")%></b></font></td>
    </tr>
    <tr>
     <td>
      <ul class='adminlinks'>
 <% if (onInfo==null || mbInfo.MemberID!=onInfo.MemberID) { %>
       <li><%=mcBean.getAdminMenuLink(-112)%></li>
<% } %>
       <li><%=mcBean.getAdminMenuLink(-104)%></li>
       <li><%=mcBean.getAdminMenuLink(-103)%></li>
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