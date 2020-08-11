<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/shiptax.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ShipMethodBean"%>
<%@ page import="com.zyzit.weboffice.model.ShipOptionInfo"%>
<%
  ShipMethodBean bean = new ShipMethodBean(session, 20);
 if (!bean.canAccessPage(request, response, AccessRole.ROLE_CHANGERATE))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  String sGatewayName = null;
  if ("Update Now".equalsIgnoreCase(sAction))
  {
    ShipMethodBean.Result ret = bean.updateOption(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "shipping option setting");
    }
  }

  ShipOptionInfo info = bean.getShipOptionInfo(request);

  String sHelpTag = "shipoption";
  String sTitleLinks = "<b>Ship Calculation Options</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below will allow you select ship calculation option or go to either of ship option list page.
<form name="shipoption" action="shipoption.jsp" method="post">
<table width="98%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th class="thHead" colspan="3">Ship Calculation Options</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="3" align="center" height="20"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } else { %>
  <tr>
    <td class="spaceRow" colspan="3" height="10">&nbsp;</td>
  </tr>
<% } %>
  <tr>
    <td width="15%" align="right" class="row1">
      <input type="radio" name="shipoption" value="1" <%=info.OptionFlag==1?"checked":""%>>
    </td>
    <td width="38%" class="row1">
      <a href="shiplist.jsp?action=Ship Methods">Standard Ship Method</a>
    </td>
    <td width="47%" class="row1">Using the same price shipping when go to a different area.</td>
  </tr>
  <tr>
    <td class="spaceRow" colspan="3" height="10">&nbsp;</td>
  </tr>
  <tr>
    <td class="row1" width="15%" align="right">
      <input type="radio" name="shipoption" value="2" <%=info.OptionFlag==2?"checked":""%>>
    </td>
    <td class="row1" width="38%" height="12"><a href="shipzonelist.jsp?action=Ship Zones">Ship Calculation by Zone</a></td>
    <td class="row1" width="47%" height="12">Shipping fee varies according to the shipping zone/location.</td>
  </tr>
  <tr>
    <td class="row1" width="15%" align="right">Default Charge:</td>
    <td class="row1" width="38%" height="12">
      <input type="text" name="defaultcharge" value="<%=Utilities.getValue(info.DefaultCharge)%>" maxlength="16" size="8" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
    </td>
    <td class="row1" width="47%" height="12">If the zip code could not meet any zone condition, this value will be used for ship charge.</td>
  </tr>
  <tr>
    <td class="spaceRow" colspan="3" height="10">&nbsp;</td>
  </tr>
  <tr>
    <td class="catBottom" colspan="3" align="center"><input type="submit" name="action" value="Update Now"></td>
  </tr>
</table>
</form>
<%@ include file="../share/footer.jsp"%>