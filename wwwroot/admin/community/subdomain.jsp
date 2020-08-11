<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/subdomain.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunitySubdomainBean"%>
<%@ page import="com.omniserve.dbengine.database.CommunitySubdomain"%>
<%@ page import="com.omniserve.dbengine.model.CommunitySubdomainInfo"%>
<%@ page import="com.omniserve.dbengine.util.Definition"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>

<%
  CommunitySubdomainBean bean = new CommunitySubdomainBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  CommunitySubdomainInfo info = null;
  if ("Add Sub-Domain".equalsIgnoreCase(sAction))
  {
    CommunitySubdomainBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (CommunitySubdomainInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "sub-domain");
      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Sub-Domain".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    CommunitySubdomainBean.Result ret = bean.update(request, false);
    info = (CommunitySubdomainInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "sub-domain");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Sub-Domain";
  }
  else if ("View".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "View";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Sub-Domain";
  }

  if (info==null)
  {
    info = CommunitySubdomainInfo.getInstance(true);
    info.PayStatus = Definition.PAYSTATUS_PENDING;
    info.ServicePlan = Definition.SERVICEPLACE_BASIC;
    info.TotalCharge = Utilities.getFloat(bean.getConfigValue("SubDmainFee", "79"), 79);
    info.ExpiredDate = Utilities.getExpiredDateByDays(Utilities.getInt(bean.getConfigValue("ServiceDays", "365"), 365));
    sAction = "Add Sub-Domain";
  }

/*
public int SubID = -1;//         int NOT NULL AUTO_INCREMENT,
public String Name;//            varchar(255) NULL,               -- Name of sub-domain
public String YourName;//        varchar(40) NULL,                -- Your name of person
public String EMail;//           varchar(60) NULL,                -- Email
public String AccountName;//     varchar(60) NULL,                -- Paypal or Google checkout account name
public short AccountType;//     tinyint NOT NULL DEFAULT 0,      -- Account Type 0--Paypal, 1--Checkout
public short ServicePlan;//     tinyint NOT NULL DEFAULT 0,      -- Service Plan
public short PayStatus;//       tinyint NOT NULL DEFAULT 0,      -- Payment status
public String ExpiredDate;//     DATETIME NULL,
public String CreateDate;//      DATETIME NOT NULL,
*/

  String sHelpTag = "communtiysubdomain";
  String sTitleLinks = "<a href=\"subdomainlist.jsp?action=Sub-Domain List\">Community Sub-Domain List</a> > ";
  String sDescription;
  if ("Add Sub-Domain".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a New Sub-Domain</b>";
     sDescription = "The form below will allow you to add a new sub-domain.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Sub-Domain</b>";
     sDescription = "The form below will allow you to edit & update or view the sub-domain information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="subdomain" action="subdomain.jsp" method="post" onsubmit="return validateSubdomainForm(this, 'omniserve.com');">
<input type="hidden" name="subid" value="<%=info.SubID%>">
<% if (!"Add Sub-Domain".equalsIgnoreCase(sAction)) { %>
<table width="85%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("subdomain.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="85%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Sub-Domain Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr class="normal_row">
    <td width="25%" align="right">Domain Name:</td>
    <td><input maxlength=30 size=20 name="name" value="<%=Utilities.getValue(info.Name)%>" <%=("Add Sub-Domain".equalsIgnoreCase(sAction)?"":"disabled")%>>.<%=bean.getEmailDomain()%>
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Source of CName:</td>
    <td><input maxlength=30 size=40 name="homeurl" value="<%=Utilities.getValue(info.HomeUrl)%>">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Customer Name:</td>
    <td><input maxlength=30 size=40 name="yourname" value="<%=Utilities.getValue(info.YourName)%>">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">E-Mail:</td>
    <td><input maxlength=50 size=40 name="email" value="<%=Utilities.getValue(info.EMail)%>"></td>
  </tr>
  <tr>
    <td class="row1" width="25%" align="right">Pay Status:</td>
    <td class="row1">
      <select name="paystatus">
        <option value=0 <%=bean.getSelected(0, info.PayStatus)%>>Available</option>
        <option value=1 <%=bean.getSelected(1, info.PayStatus)%>>Pending</option>
        <option value=2 <%=bean.getSelected(2, info.PayStatus)%>>Paid</option>
        <option value=3 <%=bean.getSelected(3, info.PayStatus)%>>Waiting List</option>
        <option value=4 <%=bean.getSelected(4, info.PayStatus)%>>Expired</option>
        <option value=5 <%=bean.getSelected(5, info.PayStatus)%>>Terminate</option>
        <option value=6 <%=bean.getSelected(6, info.PayStatus)%>>Reserved</option>
      </select>
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Total Charge:</td>
    <td><input type="text" name="totalcharge" value="<%=Utilities.getValue2(info.TotalCharge)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Expired Date:</td>
    <td>
    <input maxlength=10 name="expireddate" value="<%=Utilities.getValue(info.ExpiredDate)%>"
    onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'> (MM/DD/YYYY)
    </td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<SCRIPT>onSubdomainFormLoad(document.subdomain);</SCRIPT>
<%@ include file="../share/footer.jsp"%>