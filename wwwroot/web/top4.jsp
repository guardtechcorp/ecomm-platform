<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.web.LayoutWeb"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  LayoutWeb ly = new LayoutWeb(session, request);
  ConfigInfo cfInfo = ly.getConfigInfo();
  ShopCartWeb shopcart = new ShopCartWeb(session, request, 100);
%>
<table width=778 border=0 cellpadding=0 cellspacing=0 align="center">
  <tr>
    <td rowspan=4><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_01.gif" width=6 height=82 alt=""></td>
    <td rowspan=4 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_02.gif"><%=ly.getLogo(cfInfo, 325, 82)%></td>
    <td colspan=4 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_03.gif" align="center"><%=ly.getDomainText(cfInfo)%></td>
    <td colspan=2> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_04.gif" width=80 height=31 alt=""></td>
    <td background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_05.gif">
      <div align="center"><font color="#FF0000"><span id="totalshopitems"><%=shopcart.getTotalItems(request, response)%></span></font>
      </div>
    </td>
    <td rowspan=5> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_06.gif" width=5 height=108 alt=""></td>
  </tr>
  <tr>
    <td colspan=7> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_07.gif" width=442 height=14 alt=""></td>
  </tr>
  <tr>
    <form name="searchform" action="<%=shopcart.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateGoSearch(this);">
    <input type="hidden" name="action1" value="Quick Search">
    <input type="hidden" name="categoryid" value="-13">
    <td colspan=7 width=442 height=30 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_08.gif" align="right"><%=ly.getProductSearch(cfInfo)%></td>
    </form>
  </tr>
  <tr>
    <td colspan=7> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_09.gif" width=442 height=7 alt=""></td>
  </tr>
  <tr>
    <td> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_10.gif" width=6 height=26 alt=""></td>
    <td background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_11.gif">&nbsp;&nbsp;<%=ly.getNavigationLinks(cfInfo, "gen")%></td>
    <td> <a href="<%=ly.getHomeLink(cfInfo)%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_12.gif" width=49 height=26 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <a href="<%=ly.getHttpLink("index.jsp?action=contactus")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_13.gif" width=89 height=26 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <a href="<%=ly.getHttpLink("index.jsp?action=shopcart")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_14.gif" width=109 height=26 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td colspan=2> <a href="<%=ly.getHttpsLink("index.jsp?action=checkout")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_15.gif" width=85 height=26 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td colspan=2> <a href="<%=ly.getHttpsLink("index.jsp?action=ordertrack")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar4_16.gif" width=110 height=26 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
  </tr>
  <tr>
    <td> <img src="/staticfile/web/images/spacer.gif" width=6 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=325 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=49 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=89 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=109 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=81 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=4 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=76 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=34 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=5 height=1 alt=""></td>
  </tr>
</table>
<% } %>