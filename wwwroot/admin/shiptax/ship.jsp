<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/shiptax.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ShipMethodBean"%>
<%@ page import="com.zyzit.weboffice.model.ShipMethodInfo"%>
<%
  ShipMethodBean bean = new ShipMethodBean(session, 20);
//  bean.showAllParameters(request, out);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CHANGERATE))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  ShipMethodInfo info = null;
  if ("Add Ship Method".equalsIgnoreCase(sAction))
  {
    ShipMethodBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (ShipMethodInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "ship method");
      //. Change to update of adding its sub-category
//      cgInfo = (CategoryInfo)ret.getUpdateInfo();
    }
  }
  else if ("Update Ship Method".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    ShipMethodBean.Result ret = bean.update(request, false);
    info = (ShipMethodInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Ship Method");
    }
  }
  else if ("edit".equalsIgnoreCase(sAction))
  {
      info =  bean.get(request);
//System.out.println("cgInfo = "+ cgInfo);
      sAction = "Update Ship Method";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Ship Method";
  }

  if (info==null)
  {
    info = ShipMethodInfo.getInstance(true);
    sAction = "Add Ship Method";
  }

  String sHelpTag = "shipmethod";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Ship Method".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<a href=\"shipoption.jsp?action=Ship Option\">Ship Option</a> > <a href=\"shiplist.jsp?action=list\">Ship Method List</a> > <b>Create a New Ship Method</b>";
     sDescription = "The form below will allow you to create a new ship method.";
  }
  else
  {
     sTitleLinks += "<a href=\"shipoption.jsp?action=Ship Option\">Ship Option</a> > <a href=\"shiplist.jsp?action=list\">Ship Method List</a> ><b>Edit the Ship Method</b>";
     sDescription = "The form below will allow you to edit and update the ship method.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="shipment" action="ship.jsp" method="post" onsubmit="return validateShipment(this);">
<input type="hidden" name="shipid" value="<%=info.ShipID%>">
<% if (!"Add Ship Method".equalsIgnoreCase(sAction)) { %>
<table width="90%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("ship.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="90%" cellpadding="4" cellspacing="1" border="0" class="forumline" align="center" height="125">
    <tr>
      <th class="thHead" colspan="3">Ship Method Settings</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row2" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="21%" height="12" align="right">Name:*</td>
      <td class="row1" width="41%" height="12">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="50" size="30">
      </td>
      <td class="row1" height="12"  width="38%">The name of the ship method.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="12" align="right">Vendor:</td>
      <td class="row1" width="41%" height="12">
      <select name="vendor">
       <%=bean.getVendorList(info.Vendor)%>
      </select>
      </td>
      <td class="row1" height="12"  width="38%">The name of the ship vendor.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="49" align="right" valign="top">Description:</td>
      <td class="row1" width="41%" height="49">
        <textarea rows="3" cols="40" wrap="virtual" name="description"><%=Utilities.getValue(info.Description)%></textarea>
      </td>
      <td class="row1" height="49" width="38%">The description of the ship method.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" height="15" align="right">Charge:*</td>
      <td class="row1" width="41%" height="15">
        <input type="text" name="charge" value="<%=Utilities.getValue(info.Charge)%>" maxlength="16" size="8" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
      </td>
      <td class="row1" height="15" width="38%">The charge fee of shipping and handling.</td>
    </tr>
    <tr>
      <td colspan="3" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center" height="22"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
</table>
</form>
<SCRIPT>onShipmentLoad(document.shipment, '<%=info.Vendor%>');</SCRIPT>
<%@ include file="../share/footer.jsp"%>