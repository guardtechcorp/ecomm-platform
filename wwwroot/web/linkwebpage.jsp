<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.AccessRole"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>

<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.bean.LinkPageBean"%>
<%@ page import="com.zyzit.weboffice.model.LinkPageInfo"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%
{
  LinkPageBean bean = new LinkPageBean(session, 100, true);
  List ltLink = bean.getActiveList();
//web.showAllParameters(request, out);
// if (web.hasFuture(AccessRole.ROLE_LIVECHAT_SETTING) && cfInfo.LiveChat==1)
  BasicWeb web2 = new BasicWeb(session, null);
  ConfigInfo cfInfo2 = bean.getConfigInfo();

%>
<tr  bgColor="#528AE7">
 <td>
<table height="100%" cellspacing=0 cellpadding=0 width=178 align="left" border=0 bgColor="#528AE7">
  <tr>
    <td valign="middle" bgcolor="#F09C53" height=20>&nbsp;<img src="/staticfile/web/images/tp05.gif" width=10 height=10>
    <b><font color="#000000">&nbsp;<%=Utilities.getValue(cfInfo2.LinkPageTitle)%></font></b></td>
  </tr>
  <tr bgColor="#528AE7">
    <td height=2></td>
  </tr>
 <tr bgColor="#528AE7">
  <td>
  <ul class="glossymenu">
  <%=web2.getSpecialFunctions(request)%>
<%
  for (int i=0; i<ltLink.size(); i++) {
     LinkPageInfo info = (LinkPageInfo)ltLink.get(i);
//System.out.println("Link Attribute=" + info.Attribute + "->" + info.LinkUrl);
%>
<% if ("FeedBack".equalsIgnoreCase(info.Name)) { %>
  <li><a href="<%=web2.getHttpLink("index.jsp?action=feedback")%>"><%=web2.getLabelText(cfInfo2, "feedback-link")%></a></li>
<% } else if ("Tell-Friends".equalsIgnoreCase(info.Name)) { %>
  <li><a href="<%=web2.getHttpLink("index.jsp?action=tellfriend")%>"><%=web2.getLabelText(cfInfo2, "tellfriend-link")%></a></li>
<% } else if ("Live-Chat".equalsIgnoreCase(info.Name)) { %>
  <li><a href="javascript:newWindow('<%=web2.encodedUrl("form-livechat.jsp?domainname="+web2.getDomainName())%>','_blank',630,300,'no','center')"><%=web2.getLabelText(cfInfo2, "livechat-link")%></a></li>
  <!--li><a href="javascript:newWindow('<%="form-livechat.jsp?domainname="+web2.getDomainName()%>','_blank',630,300,'no','center')"><%=web2.getLabelText(cfInfo2, "livechat-link")%></a></li-->
<% } else { %>
  <li>
<% if (info.Attribute!=0) {%>
<% if (info.LinkUrl!=null && info.LinkUrl.startsWith("index.jsp")) { %>
     <a href="<%=web2.getHttpsLink(info.LinkUrl)%>"><%=Utilities.getValue(info.Title)%></a>
<% } else { %>
     <a href="<%=web2.getHttpLink("index.jsp?action=showlinkpage&linkid="+info.LinkID)%>"><%=Utilities.getValue(info.Title)%></a>
<% } %>
<% } else { %>
     <!--a href="javascript:newWindow('<%=web2.encodedUrl("linkpagedisplay.jsp?domainname="+web2.getDomainName()+"&linkid="+info.LinkID)%>','_blank',800,600,'yes','center')"><%=Utilities.getValue(info.Title)%></a-->
     <a href="<%=web2.getHttpLink("linkpagedisplay.jsp?domainname="+web2.getDomainName()+"&linkid="+info.LinkID)%>" target="_blank"><%=Utilities.getValue(info.Title)%></a>
<% } %>
  </li>
<% } %>
<% } %>
  </ul>
  </td>
 </tr>
  <tr bgColor="#528AE7">
    <td height="20"></td>
  </tr>
</table></td></tr>
<% } %>