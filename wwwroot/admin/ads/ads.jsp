<%@ include file="../share/uparea.jsp"%>
<link rel="stylesheet" type="text/css" href="/staticfile/admin/css/jquery.timepicker.min.css">
<script language=JavaScript type="text/javascript" src="/staticfile/admin/scripts/jquery_pack.js"></script>
<script language=JavaScript type="text/javascript" src="/staticfile/admin/scripts/jquery.timepicker.min.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/ads.js"></SCRIPT>
<script type="text/javascript" src="/staticfile/pagead/show_ads.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.AdsBean"%>
<%@ page import="com.zyzit.weboffice.model.AdsInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.AdsConfigBean" %>
<%@ page import="com.zyzit.weboffice.service.AdsDelivery" %>
<%
//. Access-Control-Allow-Origin:*
  AdsBean bean = new AdsBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ADS_UPDATE))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  AdsInfo adInfo = null;
  String sClass = "successful";
//  if ("Add Ads".equalsIgnoreCase(sAction))
  if ("Update".equalsIgnoreCase(sAction))
  {
    AdsBean.Result ret = bean.update(request);
    if (!ret.isSuccess())
    {
      adInfo = (AdsInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      //sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "ads");
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "ads");
      adInfo = (AdsInfo)ret.getUpdateInfo();
    }
  }
  else if ("Update".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    AdsBean.Result ret = bean.update(request);
    adInfo = (AdsInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "user");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
      adInfo =  bean.get(request);
      sAction = "Update";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     adInfo =  bean.getPrevOrNext(sAction);
//System.out.println("cgInfo = "+ cgInfo);
     sAction = "Update";
  }

  if (adInfo==null)
  {
    adInfo = AdsInfo.getInstance(true);
    adInfo.UserID = bean.getLoggedUsrId();
    adInfo.Active = 0;
    adInfo.Width = 720;
    adInfo.Height = 90;
    adInfo.Border = 1;
    adInfo.BorderStyle = AdsInfo.ABorderStyle.SOLID.GetValue();
    adInfo.ShowWay = AdsInfo.AShowWay.ANOTHERTAB.GetValue();
    adInfo.BackColor = "#ffffff";
    adInfo.ViewCount = 0;
    adInfo.ClickCount = 0;
    sAction = "Add";
  }
  else
  {  //. Try to get view and click account
     AdsDelivery.getLatestActionInfo(bean.getDomainName(), adInfo);
  }

  if (adInfo.ViewCount<0)
     adInfo.ViewCount = 0;

  if (adInfo.ClickCount<0)
     adInfo.ClickCount = 0;
        
  String sHelpTag = "ads";
  String sTitleLinks = "";
  String sDescription;
  if ("Add".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<a href=\"adslist.jsp?action=list\">Ads List</a> > <b>Add an new Ads</b>";
     sDescription = "The form below will allow you to create an new Ads.";
  }
  else
  {
     sTitleLinks += "<a href=\"adslist.jsp?action=list\">Ads List</a> > <b>Edit the Ads</b>";
     sDescription = "The form below will allow you to edit and update the Ads information.";
  }
//Utilities.dumpObject(adInfo);
%>
<script type="text/javascript">
$(document).ready(function() {
    $('.timepicker').timepicker({
    timeFormat: 'HH:mm',
    interval: 60,
    minTime: '0am',
    maxTime: '11:59pm',
    //defaultTime: '11',
    //startTime: '10:00',
    dynamic: false,
    dropdown: true,
    scrollbar: true
   });
});
</script>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<p>
<form name="ads" action="ads.jsp?action=Update" method="post" enctype="multipart/form-data" onsubmit="return validateAds(this);">
  <input type="hidden" name="adsid" value="<%=adInfo.AdsID%>">
  <input type="hidden" name="userid" value="<%=adInfo.UserID%>">
<% if (!"Add Ads".equalsIgnoreCase(sAction)) { %>
<table width="99%" cellpadding="0" cellspacing="1" border="0" align="center">
<tr>
  <td align="right"><%=bean.getPrevNextLinks("ads.jsp?")%></td>
</tr>
</table>
<% } %>  
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3" height="30">Ads Configuration</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    
    <tr>
      <td class="row1" width="14%" align="right">Title:* </td>
      <td class="row1" width="50%">
        <input type="text" name="title" value="<%=Utilities.getValue(adInfo.Title)%>" class="post" maxlength="255"  style="width:460px">
      </td>
      <td class="row1">The title of the ads.</td>
    </tr>
    <tr>
      <td class="row1" align="right" valign="top">Description: </td>
      <td class="row1">
        <textarea rows="4" cols="50" wrap="virtual" name="description" style="width:460px"><%=Utilities.getValue(adInfo.Description)%></textarea>
      </td>
      <td class="row1" valign="top">Text for the description, which will show on the tips of Ads</td>
    </tr>
    <tr>
      <td class="row1" align="right">Category: </td>
      <td class="row1">
        <input type="text" name="category" value="<%=Utilities.getValue(adInfo.Category)%>" class="post" maxlength="127"  style="width:460px">
      </td>
      <td class="row1">The category or tag of the ads.</td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
      <td class="row1" align="right">Content Type: </td>
      <td class="row1">
        <select name="contenttype">
<%
    int nTotalType = AdsInfo.AContentType.GetTotal();
    for (int i=0; i<nTotalType; i++) {
        byte value = AdsInfo.AContentType.GetValueByIndex(i);
%>
        <option value="<%=value%>" <%=value==adInfo.ContentType?"selected":""%>><%=AdsInfo.AContentType.GetNameByIndex(i)%></option>
<%
    }
%>
        </select>
      </td>
      <td class="row1">The content type to tell how to render html code of ads.</td>
    </tr>
    <tr>
      <td class="row1" align="right" valign="top">Content: </td>
      <td class="row1">
        <textarea rows="4" cols="50" wrap="virtual" name="code" style="width:460px"><%=Utilities.getValue(adInfo.Code)%></textarea>
      </td>
      <td class="row1" valign="top">The plait test, Html or Javascript code to show on ads area.</td>
    </tr>
    <tr>
     <td class="row1" align="right" valign="top">Upload File: </td>
     <td class="row1">
         <input type="file" name="large" size2="30" style="width:460px">
         <% if (Utilities.getValueLength(adInfo.Filename)>0) { %><br>
        <a href="../util/displayimage.jsp?filename=<%=bean.getImageFileName(adInfo.Filename)%>" target="imageview">Preview</a> &nbsp; &nbsp;&nbsp;&nbsp;
         Remove <input type="checkbox" name="delimage_0">
         <br>&nbsp;
         <% } %>
     </td>
    <td class="row1" valign="top">A image file (.gif, .png or .jpg format only) or audio or video file to update</td>
   </tr>
    <tr>
     <td class="row1" align="right" valign="top">Or Url: </td>
     <td class="row1">
        <input type="text" name="contenturl" value="<%=Utilities.getValue(adInfo.ContentUrl)%>" class="post" maxlength="1023" style="width:460px">
     </td>
    <td class="row1" valign="top">A direct url for image, audio or video content type.</td>
   </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
      <td class="row1" align="right" valign="top">Orientation: </td>
      <td class="row1">
      <select name="orientation">
 <%
     int nTotalOritation = AdsInfo.AOrientation.GetTotal();
     for (int i=0; i<nTotalOritation; i++) {
         byte value = AdsInfo.AOrientation.GetValueByIndex(i);
 %>
         <option value="<%=value%>" <%=value==adInfo.Orientation?"selected":""%>><%=AdsInfo.AOrientation.GetNameByIndex(i)%></option>
 <%
     }
 %>
      </select>&nbsp;&nbsp; &nbsp;&nbsp;
       Width
       <input type="text" name="width" value="<%=Utilities.getValue2(adInfo.Width)%>" class="post" maxlength="12" size="7">&nbsp;&nbsp;
       Height:
       <input type="text" name="height" value="<%=Utilities.getValue2(adInfo.Height)%>" class="post" maxlength="12" size="7">&nbsp;&nbsp;
      </td>
      <td class="row1" valign="top">Width, height and orientation of the ads.</td>
    </tr>
    <tr>
      <td class="row1" align="right">Border Width: </td>
      <td class="row1">
         <select name="border">
           <option value=0 <%=adInfo.Border<=0?"selected":""%>>None</option>
           <option value=1 <%=adInfo.Border==1?"selected":""%>>1</option>
           <option value=2 <%=adInfo.Border==2?"selected":""%>>2</option>
           <option value=3 <%=adInfo.Border==3?"selected":""%>>3</option>
           <option value=4 <%=adInfo.Border==4?"selected":""%>>4</option>
         </select>&nbsp;&nbsp;&nbsp;Style:
          <select name="borderstyle">
  <%
      int nTotalStyle = AdsInfo.ABorderStyle.GetTotal();
      for (int i=0; i<nTotalStyle; i++) {
          byte value = AdsInfo.ABorderStyle.GetValueByIndex(i);
  %>
          <option value="<%=value%>" <%=value==adInfo.BorderStyle?"selected":""%>><%=AdsInfo.ABorderStyle.GetNameByIndex(i)%></option>
  <%
      }
  %>
          </select>
       &nbsp;&nbsp;&nbsp;Color:
       <input type="text" name="bordercolor" value="<%=Utilities.getValue(adInfo.BorderColor)%>" maxlength="7" size="7" style="color: <%=adInfo.BorderColor%>">
       <a href="javascript:loadSelectColor(document.ads.bordercolor, 2);">Select Color</a>
      </td>
      <td class="row1">Border width, style and color of displaying the area.</td>
    </tr>
    <tr>
      <td class="row1" align="right">Background Color: </td>
      <td class="row1">
       <input type="text" name="backcolor" value="<%=Utilities.getValue(adInfo.BackColor)%>" maxlength="7" size="7" style="background-color: <%=adInfo.BackColor%>">
       <a href="javascript:loadSelectColor(document.ads.backcolor, 2);">Select Color</a>
      </td>
      <td class="row1">Ads background color of displaying.</td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Link Url: </td>
      <td class="row1" width="46%">
        <input type="text" name="linkurl" value="<%=Utilities.getValue(adInfo.LinkUrl)%>" class="post" maxlength="255" style="width:460px">
      </td>
      <td class="row1">Clicking this link url, it will redirect to the website of this url.</td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Click Show Way:</td>
      <td class="row1" width="46%">
          <select name="showway">
  <%
      int nTotalShow = AdsInfo.AShowWay.GetTotal();
      for (int i=0; i<nTotalShow; i++) {
          byte value = AdsInfo.AShowWay.GetValueByIndex(i);
  %>
          <option value="<%=value%>" <%=value==adInfo.ShowWay?"selected":""%>><%=AdsInfo.AShowWay.GetNameByIndex(i)%></option>
  <%
      }
  %>
          </select>
      </td>
      <td class="row1">Clicking the ads, it will in the same Window tab or popup ot another Window tab.</td>
    </tr>       
<% if (adInfo.AdsID>0) {
   StringBuffer sbCode = new StringBuffer();
   sbCode.append(Utilities.convert2Html2("<script type=\"text/javascript\"><!--"));
   sbCode.append("<br>webcenter_ad_domain=\"" + bean.getDomainName() +  "\";");
   sbCode.append("<br>webcenter_ad_slot=\"" + adInfo.Slot + "\";");
   sbCode.append("<br>webcenter_ad_width=" + adInfo.Width  + ";");
   sbCode.append("<br>webcenter_ad_height=" + adInfo.Height  + ";");
   sbCode.append("<br>" + Utilities.convert2Html2("//-->"));
   sbCode.append("<br>" + Utilities.convert2Html2("</script>"));
   sbCode.append("<br>" + Utilities.convert2Html2("<script type=\"text/javascript\" src=\"" + AdsConfigBean.getUserAdsScriptUrl(bean.getDomainName(), request) + "\"></script>"));
/*
<script type="text/javascript"><!--
google_ad_client = "pub-3032977611703207";
google_ad_slot = "4179295563";
google_ad_width = 468;
google_ad_height = 60;
//-->
</script>
<script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
 */
   String sLinkUrl = AdsConfigBean.getAdsAccessUrl(bean.getDomainName(), request, adInfo.Slot);
   if (sLinkUrl.indexOf("?")!=-1)
      sLinkUrl += "&";
   else
      sLinkUrl += "?";
%>
    <tr>
      <td class="row1" align="right" valign="top">Ads Code: </td>
      <td class="row1">
        <table width="100%" cellpadding="2">
         <tr>
          <td><div style="border: 1px solid #cccccc; overflow: scroll; height:100px;"><%=Utilities.convert2Html(sbCode.toString())%></div></td>   
         </tr>
        </table>
      </td>
      <td class="row1" valign="top">The ads code can insert to any place of your webpage.</td>
    </tr>
    <tr>
      <td class="row1" align="right">Access Url: </td>
      <td class="row1"><b><%=AdsConfigBean.getAdsAccessUrl(bean.getDomainName(), request, adInfo.Slot)%></b></td>
      <td>Use this url to get Ads information for test.</td>
    </tr>
    <tr>
      <td class="row1" align="right">Total Delivery: </td>
      <td class="row1">Total Views: <b><%=Utilities.getNumberFormat(adInfo.ViewCount, 'n', 0)%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       Total Clicks: <b><%=Utilities.getNumberFormat(adInfo.ClickCount, 'n', 0)%></b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="button" name="showads" value="Show Ads" style="width: 100px;" onclick="return showTestAds('<%=bean.getDomainName()%>', '<%=adInfo.Slot%>', 'id_adsarea')">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href='<%=sLinkUrl%>output=js' target="_blank">Show Ads</a>

      </td>
      <td>How many view and view and click for this ads.</td>
    </tr>
    <tr>
     <td colspan="3" id="id_adsarea" align="center">
     </td>
    </tr>
<% } %>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
      <td class="row1" align="right">Available Days: </td>
      <td class="row1">
        <select name="available">
<%
    int nTotalOption = AdsInfo.AOption.GetTotal();
    for (int i=0; i<nTotalOption; i++) {
        byte value = AdsInfo.AOption.GetValueByIndex(i);
%>
        <option value="<%=value%>" <%=value==adInfo.Available?"selected":""%>><%=AdsInfo.AOption.GetNameByIndex(i)%></option>
<%
    }
%>
        </select>
      </td>
      <td class="row1">Avialable date option.</td>
    </tr>
    <tr>
      <td class="row1" align="right">Time Limits: </td>
      <td class="row1">
          <input type="text" value="<%=Utilities.getValue(adInfo.StartTime)%>" class="timepicker" name="starttime" style="width:100px"/>&nbsp;&nbsp;To
         &nbsp;&nbsp;<input type="text" value="<%=Utilities.getValue(adInfo.EndTime)%>" class="timepicker" name="endtime" style="width:100px" />
       </td>
      <td class="row1">Time avialable range. If 'emtpy', it has no limit.</td>
    </tr>    
    <tr>
      <td class="row1" align="right">Display On:</td>
      <td class="row1">
        <select name="ondevice">
<%
    int nTotalOnly = AdsInfo.AOnDevice.GetTotal();
    for (int i=0; i<nTotalOnly; i++) {
        byte value = AdsInfo.AOnDevice.GetValueByIndex(i);
%>
        <option value="<%=value%>" <%=value==adInfo.OnDevice?"selected":""%>><%=AdsInfo.AOnDevice.GetNameByIndex(i)%></option>
<%
    }
%>
        </select>
       </td>
      <td class="row1">Only deliver this ads to selected device.</td>
    </tr>

    <tr>
      <td class="row1" align="right">Active:</td>
      <td class="row1">
        <select name="active">
          <option value=1 <%=bean.getSelected(1, adInfo.Active)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, adInfo.Active)%>>No</option>
        </select>
      </td>
      <td class="row1">If selects 'No', this ads will not be available to deliver.</td>
    </tr>
    <tr>
      <td colspan="3" height="2" class="spaceRow"><img src="/staticfile/admin/images/spacer.gif" alt="" width="1" height="1" /></td>
    </tr>    
    <tr>
      <td class="catBottom" colspan="3" align="center" height="24">
        <input type="submit" name="action2" value="<%=sAction%>" style="width: 120px">
      </td>
    </tr>
</table>
<SCRIPT>onAdsLoad(document.ads,'<%=sAction%>');</SCRIPT>
</form>
<%@ include file="../share/footer.jsp"%>