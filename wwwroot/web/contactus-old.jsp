<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.BasicWeb"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  BasicWeb web = new BasicWeb(session, null);
  DomainInfo dmInfo = web.getDomainInfo();
  CompanyInfo info = web.getCompanyInfo();
  ConfigInfo cfInfo = web.getConfigInfo();
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
      <font face=arial size=2><b><%=web.getLabelText(cfInfo, "sales-lab")%></b></font><br>
      <font face=arial size=2><%=web.getLabelText(cfInfo, "sales-des")%></font><br>
      <a href="mailto:sales@<%=dmInfo.EmailDomain%>">sales@<%=dmInfo.EmailDomain%></a>
      <br>
      <br>
      <font face=arial size=2><b><%=web.getLabelText(cfInfo, "service-lab")%></b></font><br>
      <font face=arial size=2><%=web.getLabelText(cfInfo, "service-des")%></font><br>
      <a href="mailto:customerservice@<%=dmInfo.EmailDomain%>">customerservice@<%=dmInfo.EmailDomain%></a>
      <br>
      <br>
      <font face=arial size=2><b><%=web.getLabelText(cfInfo, "support-lab")%></b></font><br>
      <font face=arial size=2><%=web.getLabelText(cfInfo, "support-des")%></font><br>
      <a href="mailto:support@<%=dmInfo.EmailDomain%>">support@<%=dmInfo.EmailDomain%></a>
      <br>
      <br>
      <font face=arial size=2><b><%=web.getLabelText(cfInfo, "exchange-lab")%></b></font><br>
      <font face=arial size=2><%=web.getLabelText(cfInfo, "exchange-des")%></font><br>
      <a href="mailto:rma@<%=dmInfo.EmailDomain%>">rma@<%=dmInfo.EmailDomain%></a>
    </TD>
  </TR>
</TABLE>
<% } %>