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
    <td rowspan=10> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_01.gif" width=11 height=117 alt=""></td>
    <td> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_02.gif" width=1 height=9 alt=""></td>
    <td colspan=7> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_03.gif" width=766 height=9 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=9 alt=""></td>
  </tr>
  <tr>
    <td colspan=2 rowspan=7 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_04.gif"><%=ly.getLogo(cfInfo, 273, 82)%></td>
    <td rowspan=3 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_05.gif" align="center"><b><a href="index.jsp?action=advancesearch" class="gen" title="Product Advanced Search">Advanced Search</a></b></td>
    <td rowspan=9> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_06.gif" width=16 height=108 alt=""></td>
    <td> <a href="<%=ly.getHomeLink(cfInfo)%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_07.gif" width=128 height=21 alt="" border="0"  style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td rowspan=9> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_08.gif" width=25 height=108 alt=""></td>
    <td colspan=2 rowspan=2 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_09.gif" valign="top" align="right"><script language="JavaScript" type="text/javascript">writeDate('#000000')</script>&nbsp;&nbsp;</td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=21 alt=""></td>
  </tr>
  <tr>
    <td rowspan=2> <a href="<%=ly.getHttpLink("index.jsp?action=contactus")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_10.gif" width=128 height=21 alt="" border="0"  style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=14 alt=""></td>
  </tr>
  <tr>
    <td colspan=2 rowspan=3> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_11.gif" width=158 height=41 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=7 alt=""></td>
  </tr>
  <tr>
    <td rowspan=4 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_12.gif"><b><br>Product Search:</b></td>
    <td> <a href="<%=ly.getHttpLink("index.jsp?action=shopcart")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_13.gif" width=128 height=23 alt="" border="0"  style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=23 alt=""></td>
  </tr>
  <tr>
    <td rowspan=4> <a href="<%=ly.getHttpsLink("index.jsp?action=checkout")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_14.gif" width=128 height=22 alt="" border="0"  style="filter:alpha(opacity=100);-moz-opacity:1.0" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=11 alt=""></td>
  </tr>
  <tr>
    <td> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_15.gif" width=92 height=1 alt=""></td>
    <td rowspan=4 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_16.gif" valign="middle">&nbsp;
      <div align="center"><font color="#FF0000"><span id="totalshopitems"><%=shopcart.getTotalItems(request, response)%></span></font>
      </div>
    </td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=1 alt=""></td>
  </tr>
  <tr>
    <td rowspan=3> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_17.gif" width=92 height=31 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=5 alt=""></td>
  </tr>
  <tr>
    <form name="searchform" action="<%=shopcart.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateGoSearch(this);">
    <input type="hidden" name="action1" value="Quick Search">
    <input type="hidden" name="categoryid" value="-13">
    <td colspan=2 rowspan=2 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_18.gif" valign="bottom"><%=ly.getNavigationLinks(cfInfo, "gen")%></td>
    <td rowspan=2 background="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_19.gif">
    <input name="productname" size="20" maxlength="30">&nbsp;<input type='submit' value='<%=ly.getLabelText(cfInfo, "go-but")%>' name='submit' title='<%=ly.getLabelText(cfInfo, "dosearch-tip")%>'>
    </td>
    <td><img src="/staticfile/web/images/spacer.gif" width=1 height=5 alt=""></td>
    </form>
  </tr>
  <tr>
    <td> <a href="<%=ly.getHttpsLink("index.jsp?action=ordertrack")%>"><img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_20.gif" width=128 height=21 alt="" border="0"  style="filter:alpha(opacity=100);-moz-opacity:0.2" onMouseOver="makevisible(this,1)" onMouseOut="makevisible(this,0)"></a></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=21 alt=""></td>
  </tr>
  <tr>
    <td colspan=9> <img src="/staticfile/web/images/<%=cfInfo.Language%>/titlebar6_21.gif" width=778 height=15 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=15 alt=""></td>
  </tr>
  <tr>
    <td> <img src="/staticfile/web/images/spacer.gif" width=11 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=1 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=272 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=167 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=16 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=128 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=25 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=92 height=1 alt=""></td>
    <td> <img src="/staticfile/web/images/spacer.gif" width=66 height=1 alt=""></td>
    <td></td>
  </tr>
</table>
<% } %>