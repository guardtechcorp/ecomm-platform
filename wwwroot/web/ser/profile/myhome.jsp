<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
//mcBean.showAllParameters(request, out);
//System.out.println("Key2=" + (String)session.getAttribute(MemberAccountBean.KEY_JUSTSIGNUP));
//Utilities.dumpObject(info);
    sPageTitle = "My Home Page";
%>
<% if ("Yes".equalsIgnoreCase((String)session.getAttribute(MemberAccountBean.KEY_JUSTSIGNUP))) { %>
<table>
  <tr>
   <td>
  <table class="table-outline" width="100%" align="center">
   <tr>
    <td>
    <table>
     <tr>
      <td align="center">
       <H2><font color="#FF6633">Hi <%=mbInfo.FirstName%>,</font> <br><br>Welcome to become a member of WebCenter online system!</H2>
       <p>
       <font size="2" face="Verdana, Arial, Helvetica, sans-serif" color='green'>
        From here, you can find a lot of good products and nice friends. You can enjoy a lot of free services. 
       </font>
       </td>
     </tr>
    </table>
   </td>
   </tr>
  </table>
 </TD>
</TR>
<% } %>
<TR>
 <TD height="50">
  My home page will list the dialy activity of the members.
 </TD>
</TR>
</TABLE>
<% } %>