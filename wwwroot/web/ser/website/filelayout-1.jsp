<%@ page import="java.io.File" %>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<table cellspacing=1 cellpadding=1 width="100%" align="center" border=0>
<%
  int nStartNo = Utilities.getInt(fileWeb.getCacheData(SiteFileWeb.KEY_STARTROWNO), 1);
  for (int i=0; i<ltFile.size(); i++) {
     File file = (File)ltFile.get(i);
%>
<% if (i>0) { %>
<TR>
  <td colspan="2"><hr class="line"></td>  
</TR>
<% } %>
<TR>
  <td width="110" valign="top"><!--b><%=(i+nStartNo)%>. </b-->
  <%=fileWeb.getStortageFileUrl(wpInfo, file, fileWeb.getImageThumbNail(fileWeb.getDomainName(), file, 106, 80), i+nStartNo)%>
  </td>
  <td>
  Title/Name: <b><%=fileWeb.getStortageFileUrl(wpInfo, file, null, i+nStartNo)%></b><br>
  Description: <b><%=fileWeb.getFileDescription(file)%></b><br>
  From: <b><%=fileWeb.getSenderName()%></b><br>
  File Size:  <b><%=MemberFileBean.getFileAttribute2(file, 2, mcBean)%></b>&nbsp;&nbsp;<br>
  Added Date: <b><%=MemberFileBean.getFileAttribute2(file, 4, mcBean)%></b>
  </td>
</TR>
<% } %>
</TABLE>
