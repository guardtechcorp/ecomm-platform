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
<div class="header">
  <div class="announcement"></div>
  <div class="logoWrap">
    <div id="logo">
      <a href="<%=web.getHomeLink(cfInfo)%>"><%=web.getLogo(cfInfo, 304, 83)%></a>
    </div>
  </div>
  <div class="topUtil"><%=web.getDomainText(cfInfo)%></div>
  <div class="topNav">
    <%=web.getNavigationLinks(cfInfo, "button")%>
    <ul class="nav">
      <li><a href="<%=web.getHomeLink(cfInfo)%>">Home</a></li>
      <li><a href="<%=web.getHttpLink("index.jsp?action=contactus")%>">Contact Us</a></li>
      <li><a href="<%=web.getHttpLink("index.jsp?action=checkout")%>">Check Out</a></li>
      <li><a href="<%=web.getHttpLink("index.jsp?action=ordertrack")%>">Track Order</a></li>
      <li class="loginNav"><i class="fa fa-user-circle-o" aria-hidden="true"></i>
        <div class="navLoginWrap">

        </div>
      </li>
      <li class="cartNav"><a href="<%=web.getHttpLink("index.jsp?action=shopcart")%>"> <div class="cart"><i class="fa fa-shopping-cart" aria-hidden="true"></i><span id="totalshopitems"><%=shopcart.getTotalItems(request, response)%></span></div></a></li>
      <li class="searchNav"><i class="fa fa-search" aria-hidden="true"></i>
        <div class="searchWrap">
          <form name="searchform" action="<%=web.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateGoSearch(this);">
          <input type="hidden" name="action1" value="Quick Search">
            <input type="hidden" name="categoryid" value="-13">
              <label>Product Search</label>
              <div class="searchBar">
                <%=web.getProductSearch(cfInfo)%>
              </div>
              <a class="advancedSearchLink" href="<%=web.getHttpLink("index.jsp?action=advancesearch")%>">Advanced Search</a>
            </form>
          </div>
      </li>
    </ul>
  </div>
</div>
<% } %>
