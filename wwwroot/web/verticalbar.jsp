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
<table width="100%" cellspacing=0 cellpadding=0 border="0">
<% if (cfInfo.CategoryShow!=0) {%>
  <tr>
    <td valign="top">
      <table height=140 cellspacing=0 cellpadding=0 width=178 align="left" border=0>
        <tr>
          <td valign="middle" bgcolor="#4279bd" height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
          <b><font color="#ffffff">&nbsp;<%=web.getLabelText(cfInfo, "category-til")%></font></b></td>
        </tr>
        <tr><td height="2"></td></tr>  
        <tr>
          <td valign="top" nowrap>
            <%@ include file="category.jsp"%>
          </td>
        </tr>
        <tr>
          <td height=5></td>
        </tr>
      </table>
    </td>
  </tr>
<% } %>
<% if (cfInfo.Membership==1) { %>
<%
  String sAction = web.getRealAction(request);
  String sType = request.getParameter("type");
  String sError = request.getParameter("error");
%>
  <tr>
    <td valign="top" height="93">
      <table height=69 cellspacing=0 cellpadding=0 width=178 align="left" border=0>
        <form name="memberlogin" action="index.jsp" method="post" onsubmit="return validateMemberLogon(this, 'Login');">
        <INPUT type="hidden" name="action1" value="">
        <tr>
          <td colSpan=2 valign="middle" bgcolor="#959CA8" height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
          <b><font color="#ffffff">&nbsp;<%=cfInfo.MemberAreaName%></font></b></td>
        </tr>
        <tr bgColor="#F1F1FD">
          <td colSpan=2 height=5></td>
        </tr>
<% if ("memberlogin".equalsIgnoreCase(sAction)&&"failed".equalsIgnoreCase(sType)) { %>
    <TR bgColor="#F1F1FD">
      <TD colSpan=2 height=20 align="center"><b><span class="failed"><%=sError%></span></b></TD>
    </TR>
<% } %>
         <tr bgColor="#F1F1FD">
          <td colSpan=2 height=5></td>
         </tr>
<% if (web.isCustomerLogin()) { %>
         <TR bgColor="#F1F1FD" height=40>
          <TD width="10%"></TD>
          <td width="90%">Hi, <%=web.getCustomerName()%> <a href="<%=web.getHttpLink("index.jsp?action=signout")%>">[Sign Out]</a>
           <br><br><%=web.getLabelText(cfInfo, "welcome-shop")%>
         </td>
         </TR>
<% } else { %>
         <TR bgColor="#F1F1FD">
            <TD vAlign="middle" align="right" width="73"><%=web.getLabelText(cfInfo, "email0-lab")%>&nbsp;</TD>
            <TD vAlign="middle" width=105><INPUT style="WIDTH: 100px" maxLength=50 name="email"></TD>
         </TR>
         <TR bgColor="#F1F1FD">
            <TD vAlign="middle" align="right" width="73"><%=web.getLabelText(cfInfo, "password-lab")%>&nbsp;</TD>
            <TD vAlign="middle" width=105><INPUT style="WIDTH: 100px" type="password" maxLength=20 name="password"></TD>
         </TR>
         <!--TR>
            <TD vAlign="middle" align="right" width=76><INPUT type=checkbox value=ON name=remember></TD>
            <TD style="CURSOR: default" onclick=this.parentNode.firstChild.firstChild.click(); vAlign=center align=left width="117"><B>Remember User</B></TD>
         </TR-->
         <TR bgColor="#F1F1FD">
            <TD align="center" vAlign="middle" colspan=2 height="25"><a onClick="return hasEmailAccount(document.memberlogin);" href="javascript:submitForgotPassword(document.memberlogin)"><%=web.getLabelText(cfInfo, "forgot-password")%></a>
            </TD>
         </TR>
        <tr bgColor="#F1F1FD">
          <td colSpan=2 height=5></td>
        </tr>
         <TR vAlign="middle" align="center" bgColor="#F1F1FD">
          <TD colSpan=2><INPUT type="submit" value="<%=web.getLabelText(cfInfo, "login-but")%>" name="Login"></TD>
        </tr>
<% } %>
        <tr bgColor="#F1F1FD">
          <td colSpan=2 height=10></td>
        </tr>
       </form>
      </table>
    </td>
  </tr>
  <tr bgColor="#fff8e1">
    <td height=5></td>
  </tr>
<% } %>
<% if (cfInfo.NewsArea==1001) { %>
  <tr>
    <td valign="top" height="93">
      <table height=69 cellspacing=0 cellpadding=0 width=178 align="left" border=0>
        <tr>
          <td valign="middle" bgcolor="#959CA8" height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
          <b><font color="#ffffff">&nbsp;Product Search</font></b></td>
        </tr>
        <tr>
         <form name="searchform" action="index.jsp" method="post" onsubmit="return validateSearch(document.searchform);">
         <input type="hidden" name="categoryid" value="-13">
            <td class="table-345" bgcolor="#F6FFEC">
             &nbsp;&nbsp;Product Name:<br>
             &nbsp;&nbsp;<input maxlength=30 name="productname" size="18"><input type="submit" value="Go" name="action"><br>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <a href="index.jsp?action=advancesearch">Advanced Search</a>
            </td>
        </form>
        </tr>
        <tr>
          <td height=10></td>
        </tr>
      </table>
    </td>
  </tr>
<% } %>
<% if (cfInfo.NewsArea==1) { %>
  <tr>
    <td>
      <table height=20 cellspacing=2 cellpadding=2 width=178 align="left" border=0>
        <tr>
          <td valign="middle" bgcolor="#2F4571" height=22>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
           <b><font color="#ffffff">&nbsp;<%=Utilities.getValue(cfInfo.NewsTitle)%></font></b></td>
        </tr>
        <tr>
          <td class="table-345" valign="middle" height=120 bgcolor="#E1E6EC">
          <% if (cfInfo.NewsAreaScroll>0) { %>
            <marquee onMouseOver=this.stop() onMouseOut=this.start() scrollamount=1 scrolldelay=50 direction=up height=100>
            <%=web.getContent(cfInfo.NewsAreaID, "NewsAreaID")%>
            </marquee>
          <% } else { %>
            <%=web.getContent(cfInfo.NewsAreaID, "NewsAreaID")%>
          <% } %>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td height=5></td>
  </tr>
<% } %>
<% if (cfInfo.NewsLetter==1) { %>
  <tr>
    <td>
      <table height=69 cellspacing=2 cellpadding=2 width=178 align="left" border=0>
       <form name="newsletter" action="#" method="post">
        <input type="hidden" name="domainname" value="<%=web.getDomainName()%>">
        <INPUT type="hidden" name="action1" value="">
        <tr>
          <td valign="middle" bgcolor="#c6d6e7" height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
          <b><font color="#000000">&nbsp;<%=web.getLabelText(cfInfo, "newsletter-til")%></font></b></td>
        </tr>
        <tr>
        <tr bgColor="#fff8e1">
          <td align="center"><%=web.getLabelText(cfInfo, "subscribe-des")%></td>
        <tr>
        <tr bgColor="#fff8e1">
          <td align="right" nowrap><%=web.getLabelText(cfInfo, "name-lab")%><input maxlength=20 name="yourname" size="15">&nbsp;&nbsp;</td>
        <tr>
        <tr bgColor="#fff8e1">
          <td align="right" nowrap><%=web.getLabelText(cfInfo, "email0-lab")%><input maxlength=50 name="email" size="15">&nbsp;&nbsp;</td>
        <tr>
        <tr bgColor="#fff8e1">
        <td align="center">
            <INPUT type="radio" CHECKED value="1" name="what"><%=web.getLabelText(cfInfo, "subscribe-lab")%>
            <INPUT type="radio" value="0" name="what"><%=web.getLabelText(cfInfo, "unsubscribe-lab")%>
        </td>
        <tr>
        <tr bgColor="#fff8e1">
           <td id=response height=5 align="center"></td>
        </tr>
        <tr align="center" bgColor="#fff8e1">
          <td><INPUT type="button" value=" <%=web.getLabelText(cfInfo, "submit-but")%> " name="submit" onclick="setAction(document.newsletter, 'Submit');submitNewsletter(document.newsletter, '<%=web.getHttpLink2("newsletter.jsp?action=subscriber")%>');"></td>
        </tr>
        <tr bgColor="#fff8e1">
          <td height=5></td>
        </tr>
       </form>
      </table>
    </td>
  </tr>
  <tr bgColor="#ffffff">
    <td height=5></td>
  </tr>
<% } %>
<% if (cfInfo.LinkPage==10000) { %>
   <%@ include file="linkwebpage.jsp"%>
<% } %>
<% if (cfInfo.GoogleAdSenseID!=null && cfInfo.GoogleAdSenseID.trim().length()>0) {%>
 <TR>
  <TD align="center" style="border-top:dotted 1px #D6D6D6">
<SCRIPT type="text/javascript">
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
</SCRIPT>
    <SCRIPT type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></SCRIPT>
 </TD>
 </TR>
<% } %>

<% } %>
</table>