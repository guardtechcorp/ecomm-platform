<%@ page import="java.io.File" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean" %>
<% {  %>
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<%
  int nStartNo = Utilities.getInt(fileWeb.getCacheData(SiteFileWeb.KEY_STARTROWNO), 1);
  for (int i=0; i<ltFile.size(); i++) {
     File file = (File)ltFile.get(i);
%>
<% if (i>0) { %>
<!--TR>
  <td colspan="2"><hr class="line"></td>  
</TR-->
<% } %>
<tr>
 <td height="17" width="3%" align="center"><b>.</b></td>
 <td width="10%" nowrap><b><%=MemberFileBean.getFileAttribute2(file, 5, mcBean).substring(0, 10)%></b></td>
 <td valign="top"><b><%=fileWeb.getStortageFileUrl(wpInfo, file, null, i+nStartNo)%></b></td>
</tr>
<% } %>
</TABLE>
<% }  %>
