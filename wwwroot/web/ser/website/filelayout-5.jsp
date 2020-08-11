<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<%
    String sUrl;
    if (fileWeb.getHttpsUrl()!=null)
       sUrl = "/ctr/web/ser/website/slideshow.jsp";
    else
       sUrl = "/web/ser/website/slideshow.jsp";
%>
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<tr>
 <td align="center">
   <iframe src='<%=sUrl%>' name='imageframe' id='imageframe' width='100%' height='690' marginwidth='0' marginheight='0' frameborder='0' scrolling='no'></iframe>
 </td>
</tr>
</table>
<table width="100%" border="0" style="border-top: #cccccc solid 1px">
 <tr>
   <td width="3%"></td>
   <td align="right"><b><%=fileWeb.getCacheData(SiteFileWeb.KEY_PAGELINKS)%></b>
   </td>
 </tr>
</table>

