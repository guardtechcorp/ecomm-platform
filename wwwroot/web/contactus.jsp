<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ContactUsBean"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.ContactUsInfo"%>
<%@ page import="com.zyzit.weboffice.model.ContactServiceInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  ContactUsBean web = new ContactUsBean(session, 10, true);
  DomainInfo dmInfo = web.getDomainInfo();
  ContactUsInfo info = web.getContactUs();
  String sMapImage = web.getImageTag(info, 580, 500);

  ConfigInfo cfInfo = web.getConfigInfo();
  List ltService = web.getServiceList();
%>
<TABLE cellspacing=4 cellpadding=4 width="100%">
  <TR>
    <TD>
      <font face=arial size=2><b><%=web.getLabelText(cfInfo, "companyaddress-lab")%></b></font><br>
      <font face=arial size=2><%=Utilities.getValue(info.CompanyName)%><br>
      <%=Utilities.getValue(info.Address)%><br>
      <%=Utilities.getValue(info.City)%>, <%=Utilities.getValue(info.State)%> <%=Utilities.getValue(info.ZipCode)%></font><br>
      <font face=arial size=2><%=web.getLabelText(cfInfo, "phone2-lab")%><%=Utilities.getValue(info.Phone)%>
      <%if (info.Fax!=null&&info.Fax.length()>0){%> <%=web.getLabelText(cfInfo, "fax-lab")%> <%=Utilities.getValue(info.Fax)%> <%}%>
      </font><br><br>
      <font face=arial size=2><b><%=Utilities.getValue(info.CompanyDesc)%></b></font><br>
      <br>
<% for (int i=0; i<ltService.size(); i++) {
  ContactServiceInfo csInfo = (ContactServiceInfo) ltService.get(i);
//  if (csInfo.Email.equalsIgnoreCase("customerservice")||csInfo.Email.equalsIgnoreCase("rma"))
  if ("www.theglobalmellc.com".equalsIgnoreCase(web.getDomainName())||"art.webonlinemanage.com".equalsIgnoreCase(web.getDomainName()))
  {
      if (csInfo.Email.equalsIgnoreCase("support")||csInfo.Email.equalsIgnoreCase("rma"))
         continue;
      if (csInfo.Email.equalsIgnoreCase("customerservice"))
         csInfo.Email = "service";
  }
%>
      <font face=arial size=2><b><%=csInfo.Name%></b></font><br>
      <font face=arial size=2><%=Utilities.getValue(csInfo.Description)%></font>
<% if (csInfo.Email!=null && csInfo.Email.trim().length()>0) {%>
      <br>E-Mail: <b><%=web.getEmailLink(csInfo)%></b>
<% } %>
<% if (csInfo.Phone!=null && csInfo.Phone.trim().length()>0) {%>
      <br>Phone: <b><%=csInfo.Phone%></b>
<% } %>
<% if (csInfo.Fax!=null && csInfo.Fax.trim().length()>0) {%>
       &nbsp;&nbsp;&nbsp;Fax: <b><%=csInfo.Phone%></b>
<% } %>
     <br><br>
<% } %>
    </TD>
  </TR>
<% if (sMapImage!=null) { %>
  <TR>
    <TD align="center"><font class='pagetitle'>Location Map</font></TD>
  </TR>
  <TR>
    <TD align="center">
    <%=sMapImage%>
    </TD>
  </TR>
<% } %>
</TABLE>
<% } %>