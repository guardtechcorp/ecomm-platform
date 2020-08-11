<%@ page import="java.io.File" %>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<table cellspacing=1 cellpadding=1 width="100%" align="center" border=0>
<%
  int nStartNo = Utilities.getInt(fileWeb.getCacheData(SiteFileWeb.KEY_STARTROWNO), 1);
  for (int i=0; i<ltFile.size(); i+=2) {
     File file1 = (File)ltFile.get(i);
%>
<% if (i>0) { %>
<TR>
  <td colspan="2"><hr class="line"></td>  
</TR>
<% } %>
<TR>
 <td width="50%">
  <table>
   <tr>
    <td width="110" valign="top">
     <%=fileWeb.getStortageFileUrl(wpInfo, file1, fileWeb.getImageThumbNail(fileWeb.getDomainName(), file1, 100, 80), i+nStartNo)%>
    </td>
    <td>
    No: <b><%=(i+nStartNo)%></b><br>
    Name:<b><%=fileWeb.getStortageFileUrl(wpInfo, file1, null, i+nStartNo)%></b><br>
    From: <b><%=fileWeb.getSenderName()%></b><br>
    File Size:  <b><%=MemberFileBean.getFileAttribute2(file1, 2, mcBean)%></b>&nbsp;&nbsp;<br>
    Added Date: <b><%=MemberFileBean.getFileAttribute2(file1, 4, mcBean)%></b>
    </td>
   </tr>
  </table>
 </td>
 <td>
<%
  if ((i+1)<ltFile.size()) {
      File file2 = (File)ltFile.get(i+1);
%>
   <table>
      <tr>
       <td width="110" valign="top">
       <%=fileWeb.getStortageFileUrl(wpInfo, file2, fileWeb.getImageThumbNail(fileWeb.getDomainName(), file2, 100, 80), (i+1+nStartNo))%>
       </td>
       <td>
       No: <b><%=(i+1+nStartNo)%></b><br>
       Name: <b><%=fileWeb.getStortageFileUrl(wpInfo, file2, null, i+nStartNo)%></b><br>
       From: <b><%=fileWeb.getSenderName()%></b><br>
       File Size:  <b><%=MemberFileBean.getFileAttribute2(file2, 2, mcBean)%></b>&nbsp;&nbsp;<br>
       Added Date: <b><%=MemberFileBean.getFileAttribute2(file2, 4, mcBean)%></b>
       </td>
      </tr>
   </table>
<% } %>
 </td>
</TR>
<% } %>
</TABLE>
