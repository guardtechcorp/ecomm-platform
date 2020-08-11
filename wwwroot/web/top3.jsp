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
    <td rowspan=4> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_01.gif" width=12 height=91 alt=""></td>
    <td colspan=4 rowspan=3 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_02.gif"><%=ly.getLogo(cfInfo, 300, 60)%></td>
    <td rowspan=4> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_03.gif" width=18 height=91 alt=""></td>
    <td colspan=3 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_04.gif"><strong><font color="F8F8CC"><%=ly.getDomainText(cfInfo)%></font></strong>
    </td>
    <td colspan=3 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_05.gif">
      <div align="right">
        <script language="JavaScript" type="text/javascript">writeDate('#ffffff')</script>
        &nbsp;</div>
    </td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=24 alt=""></td>
  </tr>
  <tr>
    <form name="searchform" action="<%=shopcart.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateGoSearch(this);">
    <input type="hidden" name="action1" value="Quick Search">
    <input type="hidden" name="categoryid" value="-13">
    <td colspan=5 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_06.gif">
      <div align="right"><%=ly.getProductSearch(cfInfo)%></div>
    </td>
    <td rowspan=3> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_07.gif" width=1 height=67 alt=""></td>
    <td><img src="/staticfile/web/images/spacer.gif" width=1 height=35 alt=""></td>
    </form>
  </tr>
  <tr>
    <td colspan=5 rowspan=2 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_08.gif">
      <div align="right"><b><%=ly.getNavigationLinks(cfInfo, "hightlight")%></b></div>
    </td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=1 alt=""></td>
  </tr>
  <tr>
    <td colspan=4> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_09.gif" width=300 height=31 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=31 alt=""></td>
  </tr>
  <tr>
    <td colspan=2><a href="<%=ly.getHomeLink(cfInfo)%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_10.gif" width=59 height=24 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td><a href="<%=ly.getHttpLink("index.jsp?action=contactus")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_11.gif" width=86 height=24 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td><a href="<%=ly.getHttpLink("index.jsp?action=shopcart")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_12.gif" width=108 height=24 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td colspan=3><a href="<%=ly.getHttpsLink("index.jsp?action=checkout")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_13.gif" width=84 height=24 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td><a href="<%=ly.getHttpsLink("index.jsp?action=ordertrack")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_14.gif" width=105 height=24 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td colspan=2><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_15.gif" width=303 height=24 alt=""></td>
    <td colspan=2 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar3_16.gif">
      <div align="center"><font color="#00FF00"><span id="totalshopitems"><%=shopcart.getTotalItems(request, response)%></span></font></div>
    </td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=24 alt=""></td>
  </tr>
  <tr>
    <td> <img src="/staticfile/web/images/spacer.gif" width=12 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=47 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=86 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=108 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=59 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=18 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=7 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=105 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=167 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=136 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=32 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=1 alt=""></td>
    <td></td>
  </tr>
</table>
<% } %>