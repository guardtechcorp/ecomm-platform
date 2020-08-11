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
<table width=778 border=0 cellpadding=0 cellspacing=0 align="center">
  <tr background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar8_01.gif">
    <td colspan=8 height="63" valign="bottom"><%=web.getLogo(cfInfo, 778, 63)%></td>
  </tr>
  <tr>
    <td ><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar8_02.gif" width=84 height=22 alt=""></td>
    <td width="57" height="22" background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar8_03.gif"><font color="#00FF00"><span id="totalshopitems"><%=shopcart.getTotalItems(request, response)%></span></font>
    </td>
    <td> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar8_04.gif" width=190 height=22 alt=""></td>
    <td> <a href="<%=web.getHomeLink(cfInfo)%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar8_05.gif" width=60 height=22 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td> <a href="<%=web.getHttpLink("index.jsp?action=contactus")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar8_06.gif" width=90 height=22 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td> <a href="<%=web.getHttpLink("index.jsp?action=shopcart")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar8_07.gif" width=109 height=22 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td> <a href="<%=web.getHttpsLink("index.jsp?action=checkout")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar8_08.gif" width=80 height=22 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td> <a href="<%=web.getHttpsLink("index.jsp?action=ordertrack")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar8_09.gif" width=108 height=22 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
  </tr>
</table>
<% } %>