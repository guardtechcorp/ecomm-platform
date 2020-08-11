<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.web.LayoutWeb"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  LayoutWeb web = new LayoutWeb(session, request);
  ConfigInfo cfInfo = web.getConfigInfo();
  ShopCartWeb shopcart = new ShopCartWeb(session, request, 100);
%>
<LINK media=screen href="/staticfile/web/css/atozmate/atozmate.css" type=text/css rel=stylesheet>
<DIV id=shapes></DIV>
<DIV id=header><br>
<TABLE WIDTH=740 BORDER=0 CELLPADDING=0 CELLSPACING=0>
  <TR>
    <TD COLSPAN=8 height=8><!--IMG SRC="images/atozmate/atozmate-header_01.gif" WIDTH=740 HEIGHT=21 ALT=""--></TD>
  </TR>
  <TR>
    <TD COLSPAN=8>
      <IMG SRC="/staticfile/web/images/atozmate/atozmate-header_02.gif" WIDTH=740 HEIGHT=85 ALT="">
    </TD>
  </TR>
  <TR>
    <TD>
      <IMG SRC="/staticfile/web/images/atozmate/atozmate-header_03.gif" WIDTH=23 HEIGHT=27 ALT=""></TD>
    <TD><a href="<%=web.getHttpLink("index.jsp?action=filecontent&filename=/link-files/homepage.html")%>">
      <IMG SRC="/staticfile/web/images/atozmate/atozmate-header_04.gif" WIDTH=85 HEIGHT=27 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a>
    </TD>
    <TD><a href="<%=web.getHttpLink("index.jsp?action=filecontent&filename=/link-files/aboutus.html")%>">
      <IMG SRC="/staticfile/web/images/atozmate/atozmate-header_05.gif" WIDTH=111 HEIGHT=27 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a>
    </TD>
    <TD><a href="<%=web.getHttpLink("index.jsp")%>">
      <IMG SRC="/staticfile/web/images/atozmate/atozmate-header_06.gif" WIDTH=111 HEIGHT=27 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a>
     </TD>
    <TD>
      <a href="<%=web.getHttpLink("index.jsp?action=filecontent&filename=/link-files/contactus.html")%>">
      <IMG SRC="/staticfile/web/images/atozmate/atozmate-header_07.gif" WIDTH=129 HEIGHT=27 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a>
    </TD>
    <TD><a href="<%=web.getHttpLink("index.jsp?action=filecontent&filename=/link-files/shippinginfo.html")%>">
       <IMG SRC="/staticfile/web/images/atozmate/atozmate-header_08.gif" WIDTH=134 HEIGHT=27 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"><a>
     </TD>
    <TD><a href="<%=web.getHttpLink("index.jsp?action=shopcart")%>">
       <IMG SRC="/staticfile/web/images/atozmate/atozmate-header_09.gif" WIDTH=127 HEIGHT=27 ALT="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"><a>
     </TD>

    <TD><IMG SRC="/staticfile/web/images/atozmate/atozmate-header_10.gif" WIDTH=20 HEIGHT=27 ALT=""></TD>
  </TR>
  <!--TR>
     <TD COLSPAN=7><IMG SRC="/staticfile/web/images/atozmate/atozmate-header_10.gif" WIDTH=740 HEIGHT=25 ALT=""></TD>
  </TR-->
</TABLE>
</DIV>
<DIV class=floatfix id=container>
<table width="96%" height="400" align="center" cellSpacing=0 cellPadding=0 border=0>
  <TR>
    <TD vAlign="top">
<% } %>