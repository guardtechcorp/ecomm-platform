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
    <td colspan=10> <img src="images/titlebar5_01.gif" width=778 height=3 alt=""></td>
    <td><img src="/staticfile/web/images/<%=cfInfo.Language%>/spacer.gif" width=1 height=3 alt=""></td>
  </tr>
  <tr>
    <td><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_02.gif" width=5 height=1 alt=""></td>
    <td rowspan=3 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_03.gif"><%=ly.getLogo(cfInfo, 329, 63)%></td>
    <td colspan=5 rowspan=2 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_04.gif"><%=ly.getDomainText(cfInfo)%></td>
    <td rowspan=2><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_05.gif" width=68 height=29 alt=""></td>
    <td rowspan=2 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_06.gif">
      <div align="center"><font color="#FF0000"><span id="totalshopitems"><%=shopcart.getTotalItems(request, response)%></span></font>
      </div>
    </td>
    <td rowspan=4> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_07.gif" width=5 height=94 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=1 alt=""></td>
  </tr>
  <tr>
    <td rowspan=3> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_08.gif" width=5 height=93 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=28 alt=""></td>
  </tr>
  <tr>
    <form name="searchform" action="<%=shopcart.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateGoSearch(this);">
    <input type="hidden" name="action1" value="Quick Search">
    <input type="hidden" name="categoryid" value="-13">
    <td colspan=7 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_09.gif" align="right"><%=ly.getProductSearch(cfInfo)%></td>
    <td><img src="/staticfile/web/images/spacer.gif" width=1 height=34 alt=""></td>
    </form>
  </tr>
  <tr>
    <td background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_10.gif">&nbsp;&nbsp;<%=ly.getNavigationLinks(cfInfo, "gen")%>
    </td>
    <td> <a href="<%=ly.getHomeLink(cfInfo)%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_11.gif" width=50 height=31 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <a href="<%=ly.getHttpLink("index.jsp?action=contactus")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_12.gif" width=88 height=31 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <a href="<%=ly.getHttpLink("index.jsp?action=shopcart")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_13.gif" width=109 height=31 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <a href="<%=ly.getHttpsLink("index.jsp?action=checkout")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_14.gif" width=85 height=31 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td colspan=3> <a href="<%=ly.getHttpsLink("index.jsp?action=ordertrack")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar5_15.gif" width=107 height=31 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=31 alt=""></td>
  </tr>
  <tr>
    <td> <img src="/staticfile/web/images/spacer.gif" width=5 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=329 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=50 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=88 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=109 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=85 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=5 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=68 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=34 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=5 height=1 alt=""></td>
    <td></td>
  </tr>
</table>
<% } %>