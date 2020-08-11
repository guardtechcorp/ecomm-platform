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
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ADS_UPDATE| AccessRole.ROLE_GRANT))
     return;

//bean.dumpAllParameters(request);

  String sAction = request.getParameter("action");
  UserInfo urInfo2 = bean.getLoggedUserInfo();
  AdsConfigInfo info;
  String sDisplayMessage = null;
  String sClass = "successful";
  int nUserId = Utilities.getInt(request.getParameter("userid"), -1);

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
    if (nUserId<=0)
    {
       nUserId = urInfo2.UserID;
    }

    info = bean.get(nUserId);
  }

  String sHelpTag = "AdsConfiginfo";
  String sTitleLinks = "<a href=\"userlist.jsp?action=list\">User List</a> > <b>View the Ads Setting</b>";
  if (request.getParameter("userid")==null)
     sTitleLinks = "<b>View the Ads Setting</b>";

  UserInfo urInfo = bean.getUserInfo(nUserId);
  String sTitle = "Setting Information";
  
  if (urInfo!=null)
  {
     sTitle += " for '" + urInfo.Username + "'";
  }

  String sDisable1 = "";
  String sDisable2 = "";
  if (info.UserID!=urInfo2.UserID)
  {
     sDisable1 = "disabled";
  }
  else
  {
     sDisable2 = "disabled";
  }

%>
<script type="text/javascript">
$(document).ready(function() {
    var dates = $( "#datefrom, #dateto" ).datetimepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 1,
        dateFormat: "yy-mm-dd",
        constrainInput: true,
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

function validateDateRange(fromDate, toDate)
{
   if (fromDate.length>0)
   {
      if (fromDate.length<10)
         return 1;
   }

   if (toDate.length>0)
   {
       if (toDate.length<10)
          return 2;
   }

   if (fromDate.length>=10 && toDate.length>=10)
   {
       var fromDT = getDateTime(fromDate);
       var toDT = getDateTime(toDate);

       if (fromDT.getTime()>toDT.getTime())
          return 3;
   }

   return 0;
}    
</script>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can edit and update ads compaign setting information.
<p>
<form name="AdsConfig" action="setting.jsp" method="post" onSubmit="return validateAdsConfig(this);">
  <input type="hidden" name="configid" value="<%=info.ConfigID%>">
  <input type="hidden" name="userid" value="<%=info.UserID%>">
  <table cellspacing="1" cellpadding="4" border="0" align="center" class="forumline" width="98%">
    <tr>
      <th class="thHead" colspan="3" align="center"><%=sTitle%></th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="3" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
      <tr>
        <td class="row1" align="right" width="18%">Rotate Way: </td>
        <td class="row1" width="42%">
          <select name="rotate" <%=sDisable1%>>
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
        <td class="row1"><input type="text" name="startdate" id="datefrom" value="<%=Utilities.getMaxLengthValue(info.StartDate, 16)%>" class="post" maxlength="255" style="width:200px" <%=sDisable1%>>
        </td>
        <td class="row1">Ads start date and time.</td>
      </tr>
      <tr>
        <td class="row1" align="right">End Date: </td>
        <td class="row1"><input type="text" name="enddate" id="dateto" value="<%=Utilities.getMaxLengthValue(info.EndDate, 16)%>" class="post" maxlength="255" style="width:200px" <%=sDisable1%>>
        </td>
        <td class="row1">Ads end date and time.</td>
      </tr>
      <tr>
        <td class="row1" align="right">Budget Type: </td>
        <td class="row1">
          <select name="budgettype" <%=sDisable1%>>
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
        <td class="row1"><input type="text" name="budgetmax" value="<%=Utilities.getValue2(info.BudgetMax)%>" class="post" maxlength="255" style="width:200px" <%=sDisable1%>>
        </td>
        <td class="row1">In the each date range, max points will be spent.</td>
      </tr>
      <tr>
        <td class="row1" align="right">Enable:</td>
        <td class="row1">
          <select name="enable" <%=sDisable1%>>
            <option value=1 <%=bean.getSelected(1, info.Enable)%>>Yes</option>
            <option value=0 <%=bean.getSelected(0, info.Enable)%>>No</option>
          </select>
        </td>
        <td class="row1">If selects 'No', all of the ads will stop to deliver.</td>
      </tr>
    <% if (info.Enable>0) {%>
        <tr>
          <td class="row1" align="right">Access Url: </td>
          <td class="row1"><b><%=AdsConfigBean.getUserAdsAccessUrl(bean.getDomainName(), request, info.UserID)%></b></td>
          <td>You can use this Url to get all of your active and meet certain conditions Ads.</td>
        </tr>
    <% } %>

      <tr>
        <td class="row1" colspan="3">
        <fieldset style="border: #cccccc 1px solid">
            <legend>
                <font size2="3" color="#777777">Only Office Administor can modify the below field</font>
            </legend>
              <TABLE width="100%" border="0" cellspacing="2" cellpadding="2">
                  <tr>
                    <td class="row1" align="right"  width="18%">Total Points: </td>
                    <td class="row1"  width="42%"><input type="text" name="totalpoints" value="<%=Utilities.getValue2(info.TotalPoints)%>" class="post" maxlength="255" style="width:200px" <%=sDisable2%>>
                    </td>
                    <td class="row1">Total points you have.</td>
                  </tr>
                  <tr>
                    <td class="row1" align="right">Points/Per Ads: </td>
                    <td class="row1"><input type="text" name="pointsperads" value="<%=Utilities.getValue2(info.PointsPerAds)%>" class="post" maxlength="255"  style="width:200px" <%=sDisable2%>>
                    </td>
                    <td class="row1">The points for each ads.</td>
                  </tr>
              </TABLE>
        </fieldset>
        </td>
     </tr>
              
    <tr>
      <td class="catBottom" colspan="3" align="center"><input type="submit" value="Update" name="action"></td>
    </tr>
  </table>
</form>
<SCRIPT>onAdsConfigLoad(document.AdsConfig,'Update');</SCRIPT>
<%@ include file="../share/footer.jsp"%>