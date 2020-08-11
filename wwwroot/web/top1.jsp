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
  <tr>
    <td rowspan=3> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_01.gif" width=13 height=83 alt=""></td>
    <td rowspan=3 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_02.gif"><%=web.getLogo(cfInfo, 304, 83)%></td>
    <td colspan=4> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_03.gif" width=218 height=23 alt=""></td>
    <td colspan=4 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_04.gif">
      <div align="right"><script language="JavaScript" type="text/javascript">writeDate('#ffffff')</script>&nbsp;&nbsp;</div>
    </td>
  </tr>
<form name="searchform" action="<%=web.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateGoSearch(this);">
<input type="hidden" name="action1" value="Quick Search">
<input type="hidden" name="categoryid" value="-13">
  <tr>
    <td><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_05.gif" width=24 height=38 alt=""></td>
    <td colspan=7 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_06.gif">
      <div align="right"><%=web.getProductSearch(cfInfo)%></div>
    </td>
  </tr>
</form>
  <tr>
    <td colspan=6 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_07.gif">
      <div align="center"><strong><font color="F8F8CC"><%=web.getDomainText(cfInfo)%></font></strong></div>
    </td>
    <td> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_08.gif" width=71 height=22 alt=""></td>
    <td background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_09.gif">
      <div align="center"><font color="#00FF00"><span id="totalshopitems"><%=shopcart.getTotalItems(request, response)%></span></font></div>
    </td>
  </tr>
  <tr>
    <td> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_10.gif" width=13 height=24 alt=""></td>
    <td background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_11.gif"><%=web.getNavigationLinks(cfInfo, "button")%>
    </td>
    <td colspan=2> <a href="<%=web.getHomeLink(cfInfo)%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_12.gif" width=77 height=24 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td> <a href="<%=web.getHttpLink("index.jsp?action=contactus")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_13.gif" width=90 height=24 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td colspan=2> <a href="<%=web.getHttpLink("index.jsp?action=shopcart")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_14.gif" width=111 height=24 alt="" border="0" style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td> <a href="<%=web.getHttpsLink("index.jsp?action=checkout")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_15.gif" width=80 height=24 alt="" border="0"  style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
    <td colspan=2> <a href="<%=web.getHttpsLink("index.jsp?action=ordertrack")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar1_16.gif" width=103 height=24 alt="" border="0"  style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseover="makevisible(this,1)" onMouseout="makevisible(this,0)"></a></td>
  </tr>
  <tr>
    <td> <img src="/staticfile/web/images/spacer.gif" width=13 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=304 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=24 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=53 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=90 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=51 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=60 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=80 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=71 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=32 height=1 alt=""></td>
  </tr>
</table>
<% } %>