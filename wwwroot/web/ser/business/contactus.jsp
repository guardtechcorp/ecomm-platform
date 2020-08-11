<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ContactUsBean"%>
<%@ page import="com.zyzit.weboffice.model.ContactUsInfo"%>
<%@ page import="com.zyzit.weboffice.model.ContactServiceInfo"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo" %>
<% {
//BasicWeb.showAllParameters(request, out);
  CompanyInfo cpInfo = mcBean.getCompany(cfInfo.MemberID);
%>
 <TABLE cellspacing=4 cellpadding=4 width="100%" valgin="top">
   <TR>
     <TD>
       <font face=arial size=3>Company Address:</font><br><b>
       <font face=arial size=2><%=Utilities.getValue(cpInfo.CompanyName)%><br>
       <%=Utilities.getValue(cpInfo.Address)%><br>
       <%=Utilities.getValue(cpInfo.City)%>, <%=Utilities.getValue(cpInfo.State)%> <%=Utilities.getValue(cpInfo.ZipCode)%></font></b>
       <br><br><font face=arial size=2>E-Mail: <b><%=Utilities.getValue(cpInfo.EMail)%></b></font>
       <br><font face=arial size=2>Phone: <b><%=Utilities.getValue(cpInfo.Phone)%></b></font>
       <%if (cpInfo.Fax!=null&&cpInfo.Fax.length()>0){%> Fax: <b><%=Utilities.getValue(cpInfo.Fax)%></b> <%}%>
       <br><br>
       <font face=arial size=2><b><%=Utilities.getValue(cpInfo.CompanyDesc)%></b></font>
       <br> 
     </TD>
   </TR>
<% if (Utilities.getValue(cpInfo.ContactUsPage).length()>4) { %>
   <TR>
     <TD><%=cpInfo.ContactUsPage%></TD>
   </TR>
<% } %>
<% if (cpInfo.PhotoImageID>0) { %>
   <tr>
    <td><HR align="center" width="100%" color="#D6D6D6" noShade SIZE=1></td>
   </tr>
   <TR>
     <TD align="center"><font class='pagetitle'>Location Map</font></TD>
   </TR>
   <TR>
     <TD align="center">
     <%=mcBean.getImageFileHtml(cpInfo.PhotoImageID, 700, 600)%>
     </TD>
   </TR>
 <% } %>
 </TABLE>
<% } %>