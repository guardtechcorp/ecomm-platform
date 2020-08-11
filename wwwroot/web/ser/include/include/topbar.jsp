<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.bean.WebPageBean"%>
<%@ page import="com.zyzit.weboffice.database.WebPage"%>
<%
{
    String sRealAction = Utilities.getValue(WebPageBean.getRequestAction(session));
    MemberInfo mbInfo = mcBean.getMemberInfo();
/*
<A href='=mcBean.encodedUrl("index.jsp?action=Show_Home&rootlink=yes&pagetitle=Home Page")' class='Tlink'>Home</A>&nbsp;
  <A href='=mcBean.encodedUrl("index.jsp?action=Load_Search&rootlink=yes&pagetitle=Find Products")' class='Tlink'>Find Products</A>&nbsp;|
  <A href='=mcBean.encodedUrl("index.jsp?action=Load_PostMessage&accessby=1&rootlink=yes&pagetitle=Post To Buy")' class='Tlink'>Post to Buy</A>&nbsp;|
  <A href='=mcBean.encodedUrl("index.jsp?action=Load_BuyLeadSearch&rootlink=yes&pagetitle=Find Buying Lead")' class='Tlink'>Find Buying Leads</A>&nbsp;|
<A href='=mcBean.encodedUrl("index.jsp?action=ShowFile_Content&rootlink=yes&title=Online Help&filename=sharing/public/helptip.html&pagetitle=Online Help")' class='Tlink'>Help</A>&nbsp;
    <!--table width="100%" border="0" cellpadding="1" cellspacing="0">
    <tr>
    <td align="right">
    <SCRIPT Language="JavaScript" src="/staticfile/web/scripts/productsearch.js" type="text/javascript"></SCRIPT>
     <form name="form_productsearch" action="mcBean.encodedUrl("index.jsp")" method="post" onSubmit="return validateQuickSearch(this);">
     <input type="hidden" name="action1" value="Quick Search_Search">
     <input type="hidden" name="rootlink" value="yes">
     <input type="hidden" name="pagetitle" value="Search Results">
     <input type="hidden" name="cid" value="5">
     <A href='mcBean.encodedUrl("index.jsp?action=Load_Search&rootlink=yes&pagetitle=Advanced Search")' class='Tlink'>Advanced Search</A>
     &nbsp;<input name='keyword' value='Utilities.getValue(request.getParameter("keyword"))' size='36' maxlength='128'>&nbsp;<input type='submit' value='Go' name='submit' title='Go to search'>&nbsp;
     </form>
    </td>
    <td widht="120" align="right" valign="top"><script language="JavaScript" type="text/javascript">writeDate('#FF6633')</script></td>
    </tr>
    </table-->
*/
%>
<TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:<%=cfInfo.DomainColor%>">
<TR>
<TD>
  <a href='<%=mcBean.getSiteUrl(cfInfo)%>'><%=mcBean.getLogoImage(cfInfo, 212, 60)%></a>
</TD>
<TD valign="top">
  <TABLE width="100%">
  <TR>
   <TD width="2" height="26"></TD>
<% if (cfInfo.AdvertiseBar==0) { %>
   <TD width="150" align="left" valign="top" id="signinupid">
<% if (mbInfo==null) { %>
  <A class='content' style='font-weight:bold'  href='<%=mcBean.encodedUrl("index.jsp?action=Load_SignIn&type=direct")%>'>Sign In</A>
<br><b>New User? </b><A class='content' style='font-weight:bold'  href='<%=mcBean.encodedUrl("index.jsp?action=Load_SignUp&rootlink=yes&pagetitle=Sign Up Informaton")%>'>Sign Up</A>
<% } else { %>
<% if (cfInfo.Membership==0) { %>    
<b><font color="#000000">Hi, <%=mbInfo.getPersonalName()%></font></b>
&nbsp;&nbsp;<A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Sign Out_SignIn")%>'>[Sign Out]</A>
<% } %>
<% } %>
   </TD>
<% } %>      
   <TD align="right" id="topmenuid">
<%
    String sPrefix = "dragtop_";
    WebPageBean wpBean = WebPageBean.getObject(session);
    String sLinks = wpBean.getMenuLinks(cfInfo.MemberID, WebPage.PLACE_TOPBAR, sPrefix, sRealAction.indexOf("_MenuLink")!=-1);
    String sCallbackUrl = mcBean.encodedUrl("ajax/response.jsp?action=Swap_MenuOrder&place="+WebPage.PLACE_TOPBAR+"&prifix="+sPrefix);
%>
<%=sLinks%>&nbsp;&nbsp;
<script language="javascript">
initHortDrags('topmenuid', '<%=sPrefix%>', '<%=sCallbackUrl%>');
</script>
   </TD>
  </TR>
  <TR>
   <TD colspan="3" align="right">
     <%=mcBean.getText(cfInfo.Slogan, cfInfo.SloganSize, cfInfo.SloganFont, cfInfo.SloganColor, false, false)%>&nbsp;&nbsp;
   </TD>
  </TR>
 </TABLE>
</TD>
</TR>
</TABLE>
<% } %>