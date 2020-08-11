<%@ page import="java.io.File" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean" %>
<% {  %>
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<%
  int nStartNo = Utilities.getInt(fileWeb.getCacheData(SiteFileWeb.KEY_STARTROWNO), 1);
  for (int i=0; i<ltFile.size(); i+=2) {     
%>
<tr>
<% { File file1 = (File)ltFile.get(i); %>
 <td height="17" width="2%" align="center"><b>.</b></td>
 <td width="48%"><b><%=fileWeb.getStortageFileUrl(wpInfo, file1, null, i+nStartNo)%></b></td>
<% } %>
<% if ((i+1)<ltFile.size()) {
    File file2 = (File)ltFile.get(i+1);
%>
 <td height="17" width="2%" align="center"><b>.</b></td>
 <td width="48%"><b><%=fileWeb.getStortageFileUrl(wpInfo, file2, null, i+1+ nStartNo)%></b></td>
<% } else { %>
 <td height="17" width="2%" align="center"></td>
 <td width="48%"></td>
<% } %>
</tr>
<% } %>
</TABLE>
<% } %>
