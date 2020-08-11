<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/shiptax.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.TaxRateBean"%>
<%@ page import="com.zyzit.weboffice.model.TaxRateInfo"%>
<%
  TaxRateBean bean = new TaxRateBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CHANGERATE))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  TaxRateInfo info = null;
  if ("statechange".equalsIgnoreCase(sAction))
  {
    info = bean.getInfoByCountyCode(request);
  }
  else if ("countychange".equalsIgnoreCase(sAction))
  {
    info = bean.getInfoByCountyCode(request);
  }
  else if ("Add Tax Rate".equalsIgnoreCase(sAction))
  {
    TaxRateBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (TaxRateInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "tax rate");
      //. Change to update of adding its sub-category
//      info = (TaxRateInfo)ret.getUpdateInfo();
    }
  }
  else if ("Update Tax Rate".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    TaxRateBean.Result ret = bean.update(request, false);
    info = (TaxRateInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "tax rate");
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
//  else
//    info = bean.getInfoByCountyCode(request);

  if (info==null)
  {
    info = TaxRateInfo.getInstance(true);
    info.State = "AL";
    info.CountyCode = "AL000";
  }

  if (info.RateID==-1)
    sAction = "Add Tax Rate";
  else
    sAction = "Update Tax Rate";

  String sHelpTag = "fax";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Tax Rate".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<a href=\"taxlist.jsp?action=list\">County/State Tax Rate List</a> > <b>Create a Tax Rate</b>";
     sDescription = "The form below will allow you to create a new tax rate.";
  }
  else
  {
     sTitleLinks += "<a href=\"taxlist.jsp?action=list\">County/State Tax Rate List</a> > <b>Edit the Tax Rate</b>";
     sDescription = "The form below will allow you to edit and update the tax rate.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<p>
<% if (!"Add Tax Rate".equalsIgnoreCase(sAction)) { %>
<table width="85%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("tax.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="85%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center">
  <form name="taxrate" action="tax.jsp" method="post" onsubmit="return validateTaxRate(this);">
  <input type="hidden" name="taxid" value="<%=info.RateID%>">
  <input type="hidden" name="county" value="<%=info.County%>">
  <input type="hidden" name="country" value="<%=info.Country%>">
    <tr>
      <th class="thHead" colspan="3">Tax Rate Settings</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="21%" height="12" align="right">State:</td>
      <td class="row1" width="41%" height="12">
        <select name="state" size="1" onChange="OnStateChange(document.taxrate)">
          <option value="AL" selected>Alabama</option>
          <option value="AK">Alaska</option>
          <option value="AB">Alberta</option>
          <option value="AZ">Arizona</option>
          <option value="AR">Arkansas</option>
          <option value="CA">California</option>
          <option value="CO">Colorado</option>
          <option value="CT">Connecticut</option>
          <option value="DE">Delaware</option>
          <option value="DC">District of Columbia</option>
          <option value="FL">Florida</option>
          <option value="GA">Georgia</option>
          <option value="HI">Hawaii</option>
          <option value="ID">Idaho</option>
          <option value="IL">Illinois</option>
          <option value="IN">Indiana</option>
          <option value="IA">Iowa</option>
          <option value="KS">Kansas</option>
          <option value="KY">Kentucky</option>
          <option value="LA">Louisiana</option>
          <option value="ME">Maine</option>
          <option value="MB">Manitoba</option>
          <option value="MD">Maryland</option>
          <option value="MA">Massachusetts</option>
          <option value="MI">Michigan</option>
          <option value="MN">Minnesota</option>
          <option value="MS">Mississippi</option>
          <option value="MO">Missouri</option>
          <option value="MT">Montana</option>
          <option value="NE">Nebraska</option>
          <option value="NV">Nevada</option>
          <option value="NB">New Brunswick</option>
          <option value="NF">Newfoundland</option>
          <option value="NH">New Hampshire</option>
          <option value="NJ">New Jersey</option>
          <option value="NM">New Mexico</option>
          <option value="NY">New York</option>
          <option value="NC">North Carolina</option>
          <option value="ND">North Dakota</option>
          <option value="NT">Northwest Territories</option>
          <option value="NS">Nova Scotia</option>
          <option value="OH">Ohio</option>
          <option value="OK">Oklahoma</option>
          <option value="ON">Ontario</option>
          <option value="OR">Oregon</option>
          <option value="PA">Pennsylvania</option>
          <option value="PE">Prince Edward Island</option>
          <option value="PR">Puerto Rico</option>
          <option value="QC">Quebec</option>
          <option value="RI">Rhode Island</option>
          <option value="SK">Saskatchewan</option>
          <option value="SC">South Carolina</option>
          <option value="SD">South Dakota</option>
          <option value="TN">Tennessee</option>
          <option value="TX">Texas</option>
          <option value="UT">Utah</option>
          <option value="VT">Vermont</option>
          <option value="VA">Virginia</option>
          <option value="WA">Washington</option>
          <option value="WV">West Virginia</option>
          <option value="WI">Wisconsin</option>
          <option value="WY">Wyoming</option>
          <option value="YK">Yukon Territory</option>
        </select>
      </td>
      <td class="row1" height="12"  width="38%">The state name.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="37" align="right">County:</td>
      <td class="row1" width="41%" height="37">
        <select name="countycode" onChange="OnCountyChange(document.taxrate)">
          <%=bean.getCounties(info.CountyCode)%>
        </select>
      </td>
      <td class="row1" height="37" width="38%">The county name.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="15" align="right">Rate:</td>
      <td class="row1" width="41%" height="15">
        <input type="text" name="rate" value="<%=Utilities.getValue(info.Rate)%>" maxlength="16" size="8" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
        % </td>
      <td class="row1" height="15" width="38%">The tax rate of county or statewide.</td>
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
<SCRIPT>onTaxRateLoad(document.taxrate, '<%=info.CountyCode%>');</SCRIPT>
<%@ include file="../share/footer.jsp"%>