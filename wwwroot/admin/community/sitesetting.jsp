<%@ include file="../share/uparea.jsp"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunitySiteBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunitySiteInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  CommunitySiteBean bean = new CommunitySiteBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  CommunitySiteInfo info = null;
  if ("Add Site".equalsIgnoreCase(sAction))
  {
    CommunitySiteBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (CommunitySiteInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Site Setting");
      sAction = "Update Site";
    }
  }
  else if ("Update Site".equalsIgnoreCase(sAction))
  {
    CommunitySiteBean.Result ret = bean.update(request, false);
    info = (CommunitySiteInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "site");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Site";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Site";
  }

  if (info==null)
  {
    info = CommunitySiteInfo.getInstance(true);
    sAction = "Add Site";
  }

  String sHelpTag = "communtiysitesetting";
  String sTitleLinks;
  String sDescription;
  if ("Add Site".equalsIgnoreCase(sAction))
  {
     sTitleLinks = bean.getNavigation(request, "Add a Site");
     sDescription = "The form below will allow you to add a new site.";
  }
  else
  {
     sTitleLinks = bean.getNavigation(request, "Edit the site");
     sDescription = "The form below will allow you to edit & update the site information.";
  }

%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<p>
<form name="sitesetting" action="sitesetting.jsp" method="post">
<input type="hidden" name="siteid" value="<%=info.SiteID%>">
<% if ("Update Site1".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("sitesetting.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Site Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr class="normal_row">
    <td width="25%" align="right">Site Name:</td>
    <td><input maxlength=255 size=80 name="name" value="<%=Utilities.getValue(info.Name)%>"></td>
  </tr>
  <tr class="normal_row">
      <td width="25%" align="right">Locale Setting:</td>
      <td><input maxlength=255 size=80 name="locale" value="<%=Utilities.getValue(info.Locale)%>">
      </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Logo:</td>
    <td><input maxlength=255 size=80 name="logourl" value="<%=Utilities.getValue(info.LogoUrl)%>">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Google AdSense Account:</td>
    <td><input maxlength=255 size=80 name="googleadsenseaccount" value="<%=Utilities.getValue(info.GoogleAdSenseAccount)%>">
    </td>
  </tr>
  <tr class="normal_row">
      <td width="25%" align="right">Google CSE Search Web ID:</td>
      <td><input maxlength=255 size=80 name="googlecsesearchwebid" value="<%=Utilities.getValue(info.GoogleCSESearchWebID)%>"></td>
  </tr>
  <tr class="normal_row">
      <td width="25%" align="right">Google CSE Search Tag ID:</td>
      <td><input maxlength=255 size=80 name="googlecsesearchtagid" value="<%=Utilities.getValue(info.GoogleCSESearchTagID)%>"></td>
  </tr>
  <tr class="normal_row">
      <td width="25%" align="right">Promotion Header:</td>
      <td><textarea rows="6" cols="60" wrap="virtual" name="promotionheader"><%=Utilities.getValue(info.PromotionHeader)%></textarea></td>
  </tr>
  <tr class="normal_row">
      <td width="25%" align="right">Tracking Code:</td>
      <td><textarea rows="6" cols="60" wrap="virtual" name="trackingcode"><%=Utilities.getValue(info.TrackingCode)%></textarea></td>
  </tr>
  <tr class="normal_row">
      <td width="25%" align="right">Home Left:</td>
      <td><textarea rows="6" cols="60" wrap="virtual" name="homeleft"><%=Utilities.getValue(info.HomeLeft)%></textarea></td>
  </tr>
  <tr class="normal_row">
     <td width="25%" align="right">Home Middle:</td>
     <td><textarea rows="6" cols="60" wrap="virtual" name="homemiddle"><%=Utilities.getValue(info.HomeMiddle)%></textarea></td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>" <%="View".equalsIgnoreCase(sAction)==true?"disabled":""%>></td>
  </tr>
  </table>
</form>
<!--SCRIPT>onSiteSettingFormLoad(document.sitesetting);</SCRIPT-->
<%@ include file="../share/footer.jsp"%>