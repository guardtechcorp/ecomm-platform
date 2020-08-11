<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%@ page import="java.util.List" %>
<!-- %@ include file="../include/pageheader.jsp" %-->
<%
{
    SiteFileWeb fileWeb = SiteFileWeb.getObject(session);
    WebPageInfo wpInfo = fileWeb.getWebPage();
    List ltFile = fileWeb.getPageList(request, fileWeb.encodedUrl("index.jsp?action=Switch Page_WebFiles&accessby=" +wpInfo.AccessMode));
// SiteFileWeb.dumpAllParameters(request);
    String[] arAt = Utilities.getValue(wpInfo.Attributes).split(",");
    boolean bAllowUpload = false;
    if (arAt.length > 0)
        bAllowUpload = "1".equalsIgnoreCase(arAt[0]);
%>
<% if (wpInfo.CategoryID==5) { %>
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0 style="background: <%=fileWeb.getBackColor()%>;">
<tr>
 <td style="padding:0 0 0 0px">
  <%@ include file="filelayout-5.jsp" %>
 </td>
</tr>
</TABLE>
<% } else { %>
<table cellspacing=2 cellpadding=2 width="100%" align="center" border=0 style="background: <%=fileWeb.getBackColor()%>; border: 1px solid #DFDFDF; padding: 1px;">
<tr>
<td style="border-bottom: #cccccc solid 1px">
 <table width="100%" border="0">
  <tr>
    <td width="3%"></td>
    <td align="right"><b><%=fileWeb.getCacheData(SiteFileWeb.KEY_PAGELINKS)%></b>
    </td>
  </tr>
 </table>
</td>
</tr>
<tr>
 <td style="padding:5 0 5 0px">
<% if (wpInfo.CategoryID==1) { %>
   <%@ include file="filelayout-1.jsp" %>
<% } else if (wpInfo.CategoryID==2) { %>
   <%@ include file="filelayout-2.jsp" %>      
<% } else if (wpInfo.CategoryID==3) { %>
   <%@ include file="filelayout-3.jsp" %>
<% } else if (wpInfo.CategoryID==4) { %>
   <%@ include file="filelayout-4.jsp" %>
<% } else if (wpInfo.CategoryID==5) { %>
   <%@ include file="filelayout-5.jsp" %>
<% } else { %>
   <%@ include file="filelayout-6.jsp" %>     
<% } %>
 </td>
 </tr>
<tr>
<!--tr>
<td colspan=2 valign="top"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
</tr-->    
<td style="border-top: #cccccc solid 1px" width="100%">
<table width="100%" border="0">
  <tr>
   <td width="100%" align="right">
<!--div class="pagination">
<ul>
<li><a href="javascript:;" class="prevnext disablelink"> « </a></li>
<li><a href="#">1</a></li>
<li><a href="#">2</a></li>
<li><a href="#">3</a></li>
<li><a href="#">4</a></li>
<li><a href="#">5</a></li>
<li><a href="#" class="currentpage">6</a></li>
<li><a href="#">7</a></li>
<li><a href="#">8</a></li>
<li><a href="#">9</a> ...</li>
<li><a href="#">15</a></li>
<li><a href="#">16</a></li>
<li><a href="#" class="prevnext"> » </a></li>
</ul>
</div-->
      <b><%=fileWeb.getCacheData(SiteFileWeb.KEY_PAGELINKS)%></b>
    </td>
  </tr>
</table>
</td>
</tr>
</table>
<% } %>
<% if (bAllowUpload) { %>
<p>
<table cellspacing=2 cellpadding=2 width="100%" align="center" border=0 style="background: <%=fileWeb.getBackColor()%>; border: 1px solid #DFDFDF; padding: 1px;">
<tr>
 <td height="1">
<!--hr class="line" width="99%"-->
  <%@ include file="fileupload.jsp"%>
</td>
</tr>
</table>
<% } %>
<% } %>
