<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/domain.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.DomainBean"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%
  DomainBean bean = new DomainBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_DOMAIN))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  DomainInfo info = null;
  CompanyInfo cpInfo = null;

  if ("Add Company Domain".equalsIgnoreCase(sAction))
  {
    DomainBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (DomainInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Company Domain");
      //. Change to update of adding its sub-category
//      cgInfo = (CategoryInfo)ret.getUpdateInfo();
    }
  }
  else if ("Setup Company Domain".equalsIgnoreCase(sAction))
  {
    DomainBean.Result ret = bean.setup(request);
    info = (DomainInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      info = (DomainInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Company Domain");
    }
  }
  else if ("Update Company Domain".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    DomainBean.Result ret = bean.update(request, false);
    info = (DomainInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Company Domain");
    }
  }
  else if ("edit".equalsIgnoreCase(sAction))
  {
      info =  bean.get(request);
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
  }

  if (info==null)
  {
    info = DomainInfo.getInstance(true);
    sAction = "Add Company Domain";
  }
  else
  {
    if (info.Setup!=0)
       sAction = "Update Company Domain";
    else
       sAction = "Setup Company Domain";
  }
%>
<% if ("Add Company Domain".equalsIgnoreCase(sAction)) { %>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25" valign="top"><font size="2"><a href="domainlist.jsp?action=list">Company Domain List</a> > <b>Setup a new company domain</b></font></td>
  <tr>
    <td height="20" valign="top">The form below will allow you to create a new company domain.</td>
  </tr>
</table>
<% } else { %>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25"><font size="2"><a href="domainlist.jsp?action=list">Company Domain List</a> > <b>Edit the Company Domain</b></font></td>
  <tr>
    <td height="20" valign="top">The form below will allow you to edit and update the company domain settings.</td>
  </tr>
</table>
<table width="90%" cellpadding="4" cellspacing="1" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("domain.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="90%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center">
   <form name="domain" action="domain.jsp" method="post" onsubmit="return validateDomain(this);">
   <input type="hidden" name="domainid" value="<%=info.DomainID%>">
    <tr>
      <th class="thHead" colspan="3">Domain Settings</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row2" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="21%" height="12" align="right">Domain Name:</td>
      <td class="row1" width="41%" height="12">
        <input type="text" name="domainname" value="<%=Utilities.getValue(info.DomainName)%>" maxlength="80" size="45">
      </td>
      <td class="row1" height="12"  width="38%">The domain name of hosting company.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="12" align="right">Email Domain Name:</td>
      <td class="row1" width="41%" height="12">
        <input type="text" name="emaildomain" value="<%=Utilities.getValue(info.EmailDomain)%>" maxlength="60" size="45">
      </td>
      <td class="row1" height="12"  width="38%">The Email domain name of hosting company.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="12" align="right">Website Path:</td>
      <td class="row1" width="41%" height="12">
        <input type="text" name="websitepath" value="<%=Utilities.getValue(info.WebsitePath)%>" maxlength="255" size="45">
      </td>
      <td class="row1" height="12"  width="38%">The Website absolute path.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="12" align="right">Monthly Charge:</td>
      <td class="row1" width="41%" height="12">
        <input type="text" name="monthcharge" value="<%=info.MonthCharge%>" maxlength="40" size="40">
      </td>
      <td class="row1" height="12"  width="38%">Setup Fee was <%=Utilities.getNumberFormat(info.SetupFee, '$', 2)%></td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Domain Name Account:</td>
      <td class="row1" width="41%" colspan=2><%=bean.getDomainNameAccount(info)%></td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="12" align="right">Website Test:</td>
      <td class="row1" width="41%" height="12">
        <select name="testflag">
          <option value=1 <%=bean.getSelected(1, info.TestFlag)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.TestFlag)%>>No</option>
        </select> Expired in: <input type="text" name="expireddate" value="<%=Utilities.getValue(info.ExpiredDate)%>" maxlength="10" size="20">
     </td>
     <td class="row1" height="12"  width="38%">The Website is in test mode or not.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="12" align="right">Website Active:</td>
      <td class="row1" width="41%" height="12">
        <select name="active">
          <option value=1 <%=bean.getSelected(1, info.Active)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Active)%>>No</option>
        </select>
     </td>
     <td class="row1" height="12"  width="38%">The Website is active or not. If it is not active, the site stop all the services.</td>
    </tr>
    <tr>
      <td colspan="3" height="25" align="center">
        <table cellpadding="1" cellspacing="1" border=0 width="100%" lass="forumline" align="center">
          <tr bgcolor="#9AAEDA">
            <td width="26%" height="25"><font color="#ffffff">&nbsp;<b>Role Name</b></font></td>
            <td align="center" width="9%" height="20"><font color="#ffffff"><b>Privilege</b></font></td>
            <td align="center" width="60%" height="20"><font color="#ffffff"><b>Description</b></font></td>
          </tr>
<%
  List ltRole = bean.getAllRoles();
  for (int i=0; i<ltRole.size(); i++) {
      AccessRole.Role rl = (AccessRole.Role)ltRole.get(i);
%>
          <tr>
            <td class="row1" width="25%">&nbsp;<%=rl.sName%></td>
            <td class="row1" align="center" width="9%"><input type="checkbox" value=1 name="cb_<%=rl.sName.toLowerCase()%>" <%=bean.getCheckFlag(rl.nFlag, info.RoleFlags)%>></td>
            <td class="row1" width="60%"><a href="#">help</a></td>
          </tr>
<% } %>
        </table>
      </td>
    </tr>

    <tr>
      <td class="row1" width="21%" height="15" align="right">&nbsp;</td>
      <td class="row1" width="41%" height="15">&nbsp;</td>
      <td class="row1" height="15" width="38%">&nbsp; </td>
    </tr>
    <tr>
      <td colspan="3" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center" height="22"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
  </form>
</table>
<SCRIPT>onDomainLoad(document.domain, "<%=sAction%>");</SCRIPT>
<%@ include file="../share/footer.jsp"%>