<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/shiptax.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ShipZoneBean"%>
<%@ page import="com.zyzit.weboffice.model.ShipZoneInfo"%>
<%
  ShipZoneBean bean = new ShipZoneBean(session, 20);
//  bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CHANGERATE))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  ShipZoneInfo info = null;
  if ("Add Ship Zone".equalsIgnoreCase(sAction))
  {
    ShipZoneBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (ShipZoneInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "ship zone");
      //. Change to update of adding its sub-category
//      cgInfo = (CategoryInfo)ret.getUpdateInfo();
    }
  }
  else if ("Update Ship Zone".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    ShipZoneBean.Result ret = bean.update(request, false);
    info = (ShipZoneInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Ship zone");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
      info =  bean.get(request);
//System.out.println("cgInfo = "+ cgInfo);
      sAction = "Update Ship Zone";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Ship Zone";
  }

  if (info==null)
  {
    info = ShipZoneInfo.getInstance(true);
    sAction = "Add Ship Zone";
  }

  String sHelpTag = "shipzone";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Ship Zone".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<a href=\"shipoption.jsp?action=Ship Option\">Ship Option</a> > <a href=\"shipzonelist.jsp?action=Zone List\">Ship Zone List</a> > <b>Create New Ship Zone</b>";
     sDescription = "The form below will allow you to create a new ship zone.";
  }
  else
  {
     sTitleLinks += "<a href=\"shipoption.jsp?action=Ship Option\">Ship Option</a> > <a href=\"shipzonelist.jsp?action=Zone List\">Ship Zone List</a> > <b>Edit the Ship Zone</b>";
     sDescription = "The form below will allow you to edit and update the ship zone.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="shipzone" action="shipzone.jsp" method="post" onsubmit="return validateShipZone(this);">
<input type="hidden" name="zoneid" value="<%=info.ZoneID%>">
<% if (!"Add Ship Zone".equalsIgnoreCase(sAction)) { %>
<table width="90%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("shipzone.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="90%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Ship Zone Settings</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row2" colspan="3" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="21%" align="right">Zone Name:</td>
      <td class="row1" width="41%">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="50" size="40">
      </td>
      <td class="row1" width="38%">The name of the ship zone.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Covered Zip Codes:</td>
      <td class="row1" width="41%">
       <textarea rows="3" cols="31" wrap="virtual" name="coverzips"><%=Utilities.getValue(info.CoverZips)%></textarea>
      </td>
      <td class="row1" width="38%">The range of conved zip codes in this ship zone. For example, 004-005,010-089,341-349,368,...</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Charge Values:</td>
      <td class="row1" width="41%" >
        <input type="text" name="fees" value="<%=Utilities.getValue(info.Fees)%>" maxlength="255" size="40">
      </td>
      <td class="row1" width="38%">The shipping charges. For example, 11,12,14. $11 is for one set, $12 is for two sets and $14 is for three sets.</td>
    </tr>
    <!--tr>
      <td class="row1" width="21%" align="right">Base Charge:</td>
      <td class="row1" width="41%" >
        <input type="text" name="charge" value="<%=Utilities.getValue(info.Charge)%>" maxlength="16" size="8" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
      </td>
      <td class="row1" width="38%">The base charge number for auto-calculating shipping fee.</td>
    </tr-->
    <tr>
      <td class="row1" width="21%" height="15" align="right">Increased Rate:</td>
      <td class="row1" width="41%" height="15">
        <input type="text" name="incfee" value="<%=Utilities.getValue(info.IncFee)%>" maxlength="16" size="8" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
      </td>
      <td class="row1" height="15" width="38%">Increased rate for each quantity. If it is less than 1.0 it is percentage.  Or it is an increased value.</td>
    </tr>
    <!--tr>
      <td class="row1" width="21%" align="right">Increased By</td>
      <td class="row1" width="41%">
      <select name="incflag">
        <option value=0 <%=bean.getSelected(0, info.IncFlag)%>>The extra charge</option>
        <option value=1 <%=bean.getSelected(1, info.IncFlag)%>>By Weight</option>
        <option value=2 <%=bean.getSelected(2, info.IncFlag)%>>By Quantity</option>
      </select>
      </td>
      <td class="row1" height="15" width="38%">The increased methods.</td>
    </tr-->
    <!--tr>
      <td class="row1" width="21%" height="15" align="right">Based on</td>
      <td class="row1" width="41%" height="15">
        <input type="text" name="incdelta" value="<%=Utilities.getValue(info.IncDelta)%>" maxlength="16" size="8" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
      </td>
      <td class="row1" height="15" width="38%">Based on how many quantities or weight is increased to calculate a extra charge.</td>
    </tr-->
    <tr>
      <td colspan="3" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center" height="22"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
</table>
</form>
<%@ include file="../share/footer.jsp"%>