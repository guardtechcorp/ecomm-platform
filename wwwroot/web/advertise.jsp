<%@ page import="com.zyzit.weboffice.web.LayoutWeb"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  LayoutWeb ly = new LayoutWeb(session, request);
  ConfigInfo info = ly.getConfigInfo();
//ly.showAllParameters(request);
//System.out.println("referer=" + request.getHeader("referer"));
%>
<% if (info.AdvertiseBar!=0) { %>
<TABLE  width="778" align="center" height="5" cellSpacing=0 cellPadding=0 border=0>
  <TR>
    <TD align="center" height="1"></TD>
  </TR>
  <TR>
    <TD align="center">
     <%=ly.getAdvertiseHtml(request, info)%>
    </TD>
  </TR>
  <TR>
    <TD align="center" height="2"></TD>
  </TR>
</TABLE>
<% } } %>