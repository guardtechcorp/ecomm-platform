<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CategoryWeb"%>
<%@ page import="com.zyzit.weboffice.model.CategoryInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
  CategoryWeb category = new CategoryWeb(session, request, 100);
  ConfigInfo cfInfo_cat = category.getConfigInfo();
  List ltCategory = category.getAll(request);
%>
<% if (cfInfo_cat.CategoryMenuID==1) {%>
<%
//System.out.println("ltCategory size=" + ltCategory.size());
  for (int i=0; ltCategory!=null&&i<ltCategory.size(); i++) {
    CategoryInfo cgInfo = (CategoryInfo)ltCategory.get(i);
%>
<%=category.getDisplay1(cgInfo)%>
<%}%>
<SCRIPT language="JavaScript" type="text/javascript">
//onload = initIt;
</SCRIPT>
<% } else if (cfInfo_cat.CategoryMenuID==2) { %>
<DIV id="CategoryMenu"></DIV>
<SCRIPT>
function createjsDOMenu()
{
  MainMenu = new jsDOMenu(179, "static", "CategoryMenu", true);
  with (MainMenu) {
<%
//System.out.println("ltCategory size=" + ltCategory.size());
  for (int i=0; ltCategory!=null&&i<ltCategory.size(); i++) {
     CategoryInfo cgInfo = (CategoryInfo)ltCategory.get(i);
%>
<%=category.getDisplay2(cgInfo)%>
<% } %>
    show();
  }
}
</SCRIPT>
<% } else { %>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/chrome.js" type="text/javascript"></SCRIPT>
<div id="chromemenu">
<table width="100%" border="0">
<%
//System.out.println("ltCategory size=" + ltCategory.size());
  for (int i=0; ltCategory!=null&&i<ltCategory.size(); i++) {
     CategoryInfo cgInfo = (CategoryInfo)ltCategory.get(i);
%>
 <tr>
  <td width="1%"></td>
  <td><%=category.getDisplay3(cgInfo)%></td>
 </tr>
<%}%>
</table>
</div>
<% } %>