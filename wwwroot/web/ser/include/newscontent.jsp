<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<% if (cfInfo.NewsAreaScroll!=0) { %>
  <MARQUEE onmouseover=this.stop() onmouseout=this.start() scrollAmount=1 scrollDelay=50 direction=up height=200>
<% } %>
   <%=Utilities.getValue((String)mcBean.getWebContentByPageId(cfInfo.MemberID, cfInfo.NewsAreaID, null).getUpdateInfo())%>
<% if (cfInfo.NewsAreaScroll!=0) { %>
  </MARQUEE>
<% } %>
