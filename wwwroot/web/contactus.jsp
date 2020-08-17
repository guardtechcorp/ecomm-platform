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
<div class="contactWrap">

<h3>Contact Info</h3>
<div class="phoneWrap">
<strong><%=web.getLabelText(cfInfo, "phone2-lab")%></strong> <%=Utilities.getValue(info.Phone)%><br>
<%if (info.Fax!=null&&info.Fax.length()>0){%><strong><%=web.getLabelText(cfInfo, "fax-lab")%></strong> <%=Utilities.getValue(info.Fax)%> <%}%><br>
</div>
<br>
<div class="companyDescWrap">
<%=Utilities.getValue(info.CompanyDesc)%>
</div>
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
      <h4><%=csInfo.Name%></h4>
<%=Utilities.getValue(csInfo.Description)%>
<% if (csInfo.Email!=null && csInfo.Email.trim().length()>0) {%>
      <br>Email: <b><%=web.getEmailLink(csInfo)%></b>
<% } %>
<% if (csInfo.Phone!=null && csInfo.Phone.trim().length()>0) {%>
      <br>Phone: <b><%=csInfo.Phone%></b>
<% } %>
<% if (csInfo.Fax!=null && csInfo.Fax.trim().length()>0) {%>
       &nbsp;&nbsp;&nbsp;Fax: <b><%=csInfo.Phone%></b>
<% } %>
     <br><br>
<% } %>

<div class="addressInfoWrap">

<h6><%=web.getLabelText(cfInfo, "companyaddress-lab")%></h6>
<%=Utilities.getValue(info.Address)%><br>
<%=Utilities.getValue(info.City)%>, <%=Utilities.getValue(info.State)%> <%=Utilities.getValue(info.ZipCode)%><br>

</div>

<% if (sMapImage!=null) { %>

    <div class="mapWrap">
    <%=sMapImage%>
</div>
<% } %>

</div>
<% } %>
