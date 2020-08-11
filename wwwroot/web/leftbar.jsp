<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  BasicWeb web = new BasicWeb(session, null);
  ConfigInfo cfInfo = web.getConfigInfo();
//web.showAllParameters(request, out);
%>
<table width="100%" cellspacing=0 cellpadding=0 border="0">
  <tr>
    <td valign="top">
      <table height=140 cellspacing=0 cellpadding=0 width=178 align="left" border=0>
        <tr>
          <td valign="middle" bgcolor="#4279bd" height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
          <b><font color="#ffffff" size=2>&nbsp;Product Categories</font></b></td>
        </tr>
        <tr>
          <td class="table-345" valign="top" bgColor="#ffffff">
            <%@ include file="category.jsp"%>
          </td>
        </tr>
        <tr>
          <td height=5></td>
        </tr>
      </table>
    </td>
  </tr>
<% if (cfInfo.Membership==1) { %>
<%
  String sAction = request.getParameter("action1");
  String sType = request.getParameter("type");
  String sError = request.getParameter("error");
%>
  <tr>
    <td valign="top" height="93">
      <table height=69 cellspacing=0 cellpadding=0 width=178 align="left" border=0>
        <form name="memberlogin" action="index.jsp" method="post" onsubmit="return validateMemberLogon(this);">
        <tr>
          <td colSpan=2 valign="middle" bgcolor="#959CA8" height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
          <b><font color="#ffffff" size=2>&nbsp;<%=cfInfo.MemberAreaName%></font></b></td>
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
<% if (web.isMember()) { %>
         <TR bgColor="#F1F1FD" height=40>
          <TD width="10%"></TD>
          <td width="90%">Hi, <%=web.getCustomerName()%><br><br>Welcome you to login and enjoy shopping.</td>
         </TR>
<% } else { %>
         <TR bgColor="#F1F1FD">
            <TD vAlign="middle" align="right" width=73>E-Mail:&nbsp;</TD>
            <TD vAlign="middle" width=105><INPUT style="WIDTH: 100px" maxLength=50 name="email"></TD>
         </TR>
         <TR bgColor="#F1F1FD">
            <TD vAlign="middle" align="right" width=73>Password:&nbsp;</TD>
            <TD vAlign="middle" width=105><INPUT style="WIDTH: 100px" type="password" maxLength=20 name="password"></TD>
         </TR>
         <!--TR>
            <TD vAlign="middle" align="right" width=76><INPUT type=checkbox value=ON name=remember></TD>
            <TD style="CURSOR: default" onclick=this.parentNode.firstChild.firstChild.click(); vAlign=center align=left width="117"><B>Remember User</B></TD>
         </TR-->
        <tr bgColor="#F1F1FD">
          <td colSpan=2 height=5></td>
        </tr>
         <TR vAlign="middle" align="center" bgColor="#F1F1FD">
          <TD colSpan=2><INPUT type="submit" value="Login" name="action"></TD>
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
<% if (cfInfo.NewsArea==11) { %>
  <tr>
    <td valign="top" height="93">
      <table height=69 cellspacing=0 cellpadding=0 width=178 align="left" border=0>
        <tr>
          <td valign="middle" bgcolor="#959CA8" height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
          <b><font color="#ffffff" size=2>&nbsp;Product Search</font></b></td>
        </tr>
        <tr>
         <form name="searchform" action="index.jsp" method="post" onsubmit="return validateSearch(document.searchform);">
         <input type="hidden" name="categoryid" value="-13">
            <td class="table-345" bgcolor="#F6FFEC">
             &nbsp;&nbsp;<font size="2">Product Name:</font><br>
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
          <td valign="middle" bgcolor="#2F4571" height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
           <b><font color="#ffffff" size=2>&nbsp;Site News</font></b></td>
        </tr>
        <tr>
          <td class2="table-345" valign="middle" height=120 bgcolor="#E1E6EC">
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
      <table height=69 cellspacing=0 cellpadding=0 width=178 align="left" border=0>
       <form name="newsletter" action="<%=web.getHttpLink("index.jsp")%>" method="post">
        <input type="hidden" name="domainname" value="<%=web.getDomainName()%>">
        <tr>
          <td valign="middle" bgcolor="#c6d6e7" height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
          <b><font color="#000000" size="2">&nbsp;Newsletter</font></b></td>
        </tr>
        <tr>
        <tr bgColor="#fff8e1">
          <td align="center"><font size="1">Subscribe to our promotions, coupons &amp; news</font></td>
        <tr>
        <tr bgColor="#fff8e1">
          <td align="right"><font size="1">Name: </font><input maxlength=20 name="yourname" size="16">&nbsp;&nbsp;</td>
        <tr>
        <tr bgColor="#fff8e1">
          <td align="right"><font size="1">E-Mail*: </font><input maxlength=50 name="email" size="16">&nbsp;&nbsp;</td>
        <tr>
        <tr bgColor="#fff8e1">
        <td align="center"><font size="1"><INPUT type="radio" CHECKED value="1" name="what"> Subscribe
            <INPUT type="radio" value="0" name="what"> Unsubscribe</font>
        </td>
        <tr>
        <tr bgColor="#fff8e1">
           <td id=response height=15 align="center"><FONT size="1">(A * are required)</FONT></td>
        </tr>
        <tr align="center" bgColor="#fff8e1">
          <td><INPUT type="button" value="Submit" name="action" onclick="javascript:submitNewsletter(document.newsletter);"></td>
        </tr>
        <tr bgColor="#fff8e1">
          <td height=5></td>
        </tr>
       </form>
      </table>
    </td>
  </tr>
<% } %>
<% if (cfInfo.Feedback==1) { %>
  <tr bgColor="#fff8e1">
    <td height=5></td>
  </tr>
  <tr bgColor="#fff8e1">
    <td align="center" >
    <script>createLeftButton();</script>
    <a class="button" href="<%=web.getHttpLink("index.jsp?action=feedback")%>">Feedback</a>
    <script>createRightButton();</script>
    </td>
  </tr>
  <tr bgColor="#fff8e1">
    <td height=10></td>
  </tr>
<% } %>
<% if (cfInfo.TellFriend==1) { %>
  <tr bgColor="#fff8e1">
    <td height=10></td>
  </tr>
  <tr bgColor="#fff8e1">
    <td align="center" >
    <script>createLeftButton();</script>
    <!--a class="button" href="javascript:ChildWin=window.open('telllfriends.jsp', 'TellFriend','resizable=yes,scrollbars=no,width=480,height=550');ChildWin.focus()">Tell Friends</a-->
    <a class="button" href="<%=web.getHttpLink("index.jsp?action=tellfriend")%>">Tell Friends</a>
    <script>createRightButton();</script>
    </td>
  </tr>
  <tr bgColor="#fff8e1">
    <td height=10></td>
  </tr>
<% } %>
</table>
<% } %>