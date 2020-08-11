<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.web.LayoutWeb"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  LayoutWeb ly = new LayoutWeb(session, request);
  ConfigInfo cfInfo = ly.getConfigInfo();
  CustomerInfo ctInfo = ly.getCustomerInfo();
  String sAction = ly.getRealAction(request);
//ly.dumpAllParameters(request);
%>
<style type="text/css">
div.sample_attach, a.sample_attach
{
  width: 120px;
  border: 1px solid black;
  background: #B64C4D;
  padding: 2px 5px;
  font-weight: 900;
  font-size: 11pt;
  color: #ffffff;
}
a.sample_attach
{
  display: block;
  border-bottom: none;
  text-decoration: none;
}
form.sample_attach
{
  position: absolute;
  visibility: hidden;
  border: 1px solid black;
  background: #FFFFEE;
  padding: 0px 5px 2px 5px;
}
</style>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/dropdown.js"  type="text/javascript"></SCRIPT>
<TABLE WIDTH=778 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR>
    <TD COLSPAN=5 ROWSPAN=2><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_01.gif" WIDTH=314 HEIGHT=51 ALT=""></TD>
    <TD COLSPAN=5 height="24" align="center" background="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_02.gif"><strong><font color="F8F8CC"><%=ly.getDomainText(cfInfo)%></font></strong></TD>
    <TD height="24" align="right" background="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_03.gif"><script language="JavaScript" type="text/javascript">writeDate('#ffffff')</script>&nbsp;</TD>
  </TR>
  <TR>
    <TD COLSPAN=6><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_04.gif" WIDTH=464 HEIGHT=27 ALT=""></TD>
  </TR>
  <TR>
    <TD COLSPAN=2><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_05.gif" WIDTH=56 HEIGHT=33 ALT=""></TD>
    <TD COLSPAN=9 align="right" valign="bottom" background="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_06.gif">
<table border="0" width="100%">
 <tr>
  <td width="60%"><td>
  <td width="39%" align="right" valign="bottom">
<% if (ctInfo==null||sAction.endsWith("logout-accountlogin")) { %>
Are you member? <a class="login" href="<%=ly.getHttpsLink("index.jsp?action=cp-accountlogin&rootlink=yes")%>"> [Sign In]</a>
<% } else { %>
Hi, <%=ctInfo.Yourname%> <a class="login" href="<%=ly.getHttpsLink("index.jsp?action=cp-logout-accountlogin&final=Logout")%>"> [Logout]</a>
<% } %>
  </td>
  <td width="1%"></td>
 </tr>
</table>
    </TD>
  </TR>
  <TR>
   <TD COLSPAN=11><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_07.gif" WIDTH=778 HEIGHT=7 ALT=""></TD>
  </TR>
  <TR>
   <TD><a href="<%=ly.getHomeLink(cfInfo)%>"><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_08.gif" WIDTH=48 HEIGHT=24 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></TD>
   <TD COLSPAN=2><a href="<%=ly.getHttpLink("index.jsp?action=showproducts&categoryid=5")%>"><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_09.gif" WIDTH=93 HEIGHT=24 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></TD>
   <TD><a href="<%=ly.getHttpsLink("index.jsp?action=pi-propertysearch&rootlink=yes")%>"><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_10.gif" WIDTH=86 HEIGHT=24 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></TD>
   <TD COLSPAN=2><a href="<%=ly.getHttpsLink("index.jsp?action=pi-reportarchive&start=yes&rootlink=yes")%>"><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_11.gif" WIDTH=116 HEIGHT=24 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></TD>
   <!--TD><a href="<%=ly.getHttpsLink("index.jsp?action=cp-view-myaccount&rootlink=yes")%>"><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_12.gif" WIDTH=85 HEIGHT=24 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></TD-->
   <TD id="menu_parent" class="sample_attach"><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_12.gif" WIDTH=85 HEIGHT=24 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></TD>
   <TD><a href="<%=ly.getHttpLink("index.jsp?action=showlinkpage&linkid=4")%>"><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_13.gif" WIDTH=48 HEIGHT=24 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></TD>
   <TD><a href="<%=ly.getHttpLink("index.jsp?action=contactus")%>"><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_14.gif" WIDTH=74 HEIGHT=24 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></TD>
   <TD COLSPAN=2><IMG SRC="/staticfile/web/images/<%=cfInfo.Language%>/webinfocenter_15.gif" WIDTH=228 HEIGHT=24 ALT=""></TD>
  </TR>
  <TR>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=48 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=8 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=85 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=86 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=87 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=29 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=85 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=48 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=74 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=59 HEIGHT=1 ALT=""></TD>
     <TD><IMG SRC="/staticfile/web/images/spacer.gif" WIDTH=169 HEIGHT=1 ALT=""></TD>
 </TR>
</TABLE>
<div id="menu_child" style="position: absolute; visibility: hidden;">
<a class="sample_attach" href='<%=ly.encodedUrl("index.jsp?action=cp-edit-accountinfo")%>'>Profile</a>
<a class="sample_attach" href="<%=ly.encodedUrl("index.jsp?action=cp-buycredit")%>">Buy Credit</a>
<a class="sample_attach" href="<%=ly.encodedUrl("index.jsp?action=cp-creditlist")%>">Credit List</a>
<a class="sample_attach" style="border-bottom: 1px solid black;" href="<%=ly.encodedUrl("index.jsp?action=ordertrack")%>">Order History</a>
</div>
<script type="text/javascript">
at_attach("menu_parent", "menu_child", "hover", "y", "pointer");
</script>
<% } %>