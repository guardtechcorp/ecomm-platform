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
    <td rowspan=5> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_01.gif" width=1 height=89 alt=""></td>
    <td rowspan=5> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_02.gif" width=8 height=89 alt=""></td>
    <td rowspan=3 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_03.gif"><%=ly.getNavigationLinks(cfInfo, "button")%>
    </td>
    <td colspan=2 rowspan=2> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_04.gif" width=110 height=33 alt=""></td>
    <td colspan=7> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_05.gif" width=346 height=12 alt=""></td>
    <td> <img src="/staticfile/web/images/<%=cfInfo.Language%>/spacer.gif" width=1 height=12 alt=""></td>
  </tr>
  <tr>
    <td> <a href="<%=ly.getHomeLink(cfInfo)%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_06.gif" width=39 height=21 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td> <a href="<%=ly.getHttpLink("index.jsp?action=contactus")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_07.gif" width=70 height=21 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td> <a href="<%=ly.getHttpLink("index.jsp?action=shopcart")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_08.gif" width=86 height=21 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td colspan=2> <a href="<%=ly.getHttpsLink("index.jsp?action=checkout")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_09.gif" width=67 height=21 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td colspan=2> <a href="<%=ly.getHttpsLink("index.jsp?action=ordertrack")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_10.gif" width=84 height=21 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td> <img src="/staticfile/web/images/<%=cfInfo.Language%>/spacer.gif" width=1 height=21 alt=""></td>
  </tr>
  <tr>
    <form name="searchform" action="<%=shopcart.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateGoSearch(this);">
    <input type="hidden" name="action1" value="Quick Search">
    <input type="hidden" name="categoryid" value="-13">
    <td rowspan=2> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_11.gif" width=31 height=32 alt=""></td>
    <td colspan=8 rowspan=2 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_12.gif">
      <div align="right"><%=ly.getProductSearch(cfInfo)%></div>
    </td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=1 alt=""></td>
   </form>
  </tr>
  <tr>
    <td rowspan=2 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_13.gif"><%=ly.getLogo(cfInfo, 313, 55)%></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=31 alt=""></td>
  </tr>
  <tr>
    <td colspan=6 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_14.gif">
      <div align="center"><strong><font color="F8F8CC"><%=ly.getDomainText(cfInfo)%></font></strong>
      </div>
    </td>
    <td colspan=2> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_15.gif" width=72 height=24 alt=""></td>
    <td background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar2_16.gif">
      <div align="center"><font color="#00FF00"><span id="totalshopitems"><%=shopcart.getTotalItems(request, response)%></span></font></div>
    </td>
    <td> <img src="/staticfile/web/images/<%=cfInfo.Language%>/spacer.gif" width=1 height=24 alt=""></td>
  </tr>
  <tr>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=8 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=313 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=31 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=79 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=39 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=70 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=86 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=45 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=22 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=50 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=34 height=1 alt=""></td>
    <td></td>
  </tr>
</table>
<% } %>