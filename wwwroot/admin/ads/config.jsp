<%@ include file="../share/uparea.jsp"%>
<link rel="stylesheet" type="text/css" href="/staticfile/admin/css/jquery-ui.css">
<script language=JavaScript type="text/javascript" src="/staticfile/admin/scripts/jquery_pack.js"></script>
<script language=JavaScript type="text/javascript" src="/staticfile/admin/scripts/jquery-ui-min.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/ads.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.AdsConfigBean"%>
<%@ page import="com.zyzit.weboffice.model.AdsConfigInfo"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo" %>
<%
  AdsConfigBean bean = new AdsConfigBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ADS_UPDATE))
     return;

bean.dumpAllParameters(request);

  String sAction = request.getParameter("action");
  AdsConfigInfo info;
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Update".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    AdsConfigBean.Result ret = bean.update(request);
    info = (AdsConfigInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Config information");
    }
  }
  else
  {
    int nUserId = Utilities.getInt(request.getParameter("userid"), -1);
    if (nUserId<=0)
    {
       UserInfo urInfo = bean.getLoggedUserInfo();
       nUserId = urInfo.UserID;
    }

    info = bean.get(nUserId);
  }

  String sHelpTag = "AdsConfiginfo";
  String sTitleLinks = "<b>Edit the AdsConfig Information</b>";
%>
<script type="text/javascript">
$(document).ready(function() {
    var dates = $( "#datefrom, #dateto" ).datetimepicker({
        defaultDate: "+1w",
//        changeMonth: true,
        numberOfMonths: 1,
        dateFormat: "yy-mm-dd",
//        constrainInput: true,
//        showSecond: true,
        timeFormat: 'hh:mm'

//        onSelect: function( selectedDate ) {
//            var option = this.id == "datefrom" ? "minDate" : "maxDate",
//                instance = $( this ).data( "datepicker" ),
//                date = $.datepicker.parseDate(
//                    instance.settings.dateFormat ||
//                    $.datepicker._defaults.dateFormat,
//                    selectedDate, instance.settings );
//            dates.not( this ).datepicker( "option", option, date );
//        }
    });
});
</script>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can edit and update ads config information.
<p>
<form name="AdsConfig" action="config.jsp" method="post" onSubmit="return validateAdsConfig(this);">
  <input type="hidden" name="configid" value="<%=info.ConfigID%>">
  <table cellspacing="1" cellpadding="4" border="0" align="center" class="forumline" width="98%">
    <tr>
      <th class="thHead" colspan="3" align="center">Config Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
      <tr>
        <td class="row1" align="right">Rotate Way: </td>
        <td class="row1">
          <select name="rotate">
  <%
      int nTotalOption = AdsConfigInfo.ERotate.GetTotal();
      for (int i=0; i<nTotalOption; i++) {
          byte value = AdsConfigInfo.ERotate.GetValueByIndex(i);
  %>
          <option value="<%=value%>" <%=value==info.Rotate?"selected":""%>><%=AdsConfigInfo.ERotate.GetNameByIndex(i)%></option>
  <%
      }
  %>
          </select>
         </td>
        <td class="row1">How to rotate each ads.</td>
      </tr>
      <tr>
        <td class="row1" align="right">Start Date: </td>
        <td class="row1"><input type="text" name="startdate" id="datefrom" value="<%=Utilities.getMaxLengthValue(info.StartDate, 16)%>" class="post" maxlength="255"  style="width:200px">
        </td>
        <td class="row1">Ads start date and time.</td>
      </tr>
      <tr>
        <td class="row1" align="right">End Date: </td>
        <td class="row1"><input type="text" name="enddate" id="dateto" value="<%=Utilities.getMaxLengthValue(info.EndDate, 16)%>" class="post" maxlength="255"  style="width:200px">
        </td>
        <td class="row1">Ads end date and time.</td>
      </tr>
      <tr>
        <td class="row1" align="right">Budget Type: </td>
        <td class="row1">
          <select name="budgettype">
  <%
      int nTotalType = AdsConfigInfo.EBudget.GetTotal();
      for (int i=0; i<nTotalType; i++) {
          byte value = AdsConfigInfo.EBudget.GetValueByIndex(i);
  %>
          <option value="<%=value%>" <%=value==info.BudgetType?"selected":""%>><%=AdsConfigInfo.EBudget.GetNameByIndex(i)%></option>
  <%
      }
  %>
          </select>
         </td>
        <td class="row1">Budget type to limit max spent in each unit.</td>
      </tr>
      <tr>
        <td class="row1" align="right">Max Points: </td>
        <td class="row1"><input type="text" name="budgetmax" value="<%=Utilities.getValue2(info.BudgetMax)%>" class="post" maxlength="255"  style="width:200px">
        </td>
        <td class="row1">In the each date range, max points will be spent.</td>
      </tr>

      <tr>
        <td class="row1" align="right">Total Points: </td>
        <td class="row1"><input type="text" name="totalpoints" value="<%=Utilities.getValue2(info.TotalPoints)%>" class="post" maxlength="255"  style="width:200px">
        </td>
        <td class="row1">Total points you have.</td>
      </tr>
      <tr>
        <td class="row1" align="right">Points/Per Ads: </td>
        <td class="row1"><input type="text" name="pointsperads" value="<%=Utilities.getValue2(info.PointsPerAds)%>" class="post" maxlength="255"  style="width:200px">
        </td>
        <td class="row1">The points for each ads.</td>
      </tr>      
      <tr>
        <td class="row1" align="right">Enable:</td>
        <td class="row1">
          <select name="active">
            <option value=1 <%=bean.getSelected(1, info.Enable)%>>Yes</option>
            <option value=0 <%=bean.getSelected(0, info.Enable)%>>No</option>
          </select>
        </td>
        <td class="row1">If selects 'No', all of the ads will stop to deliver.</td>
      </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center"><input type="submit" value="Update" name="action"></td>
    </tr>
  </table>
</form>
<SCRIPT>onAdsConfigLoad(document.AdsConfig,'Update');</SCRIPT>
<%@ include file="../share/footer.jsp"%>