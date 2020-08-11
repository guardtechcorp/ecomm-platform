<%@ include file="../share/uparea.jsp"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityWebsiteBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityWebsiteInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/community.js"></SCRIPT>
<%
  CommunityWebsiteBean bean = new CommunityWebsiteBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  CommunityWebsiteInfo info = null;
  if ("Add Website".equalsIgnoreCase(sAction))
  {
    CommunityWebsiteBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (CommunityWebsiteInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Website Setting");
      sAction = "Update Website";
    }
  }
  else if ("Update Website".equalsIgnoreCase(sAction))
  {
    CommunityWebsiteBean.Result ret = bean.update(request, false);
    info = (CommunityWebsiteInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "website");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Website";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Website";
  }

  if (info==null)
  {
    info = CommunityWebsiteInfo.getInstance(true);
    sAction = "Add Website";
  }

  String sHelpTag = "communtiywebsitesetting";
  String sTitleLinks;
  String sDescription;
  if ("Add Website".equalsIgnoreCase(sAction))
  {
     sTitleLinks = bean.getNavigation(request, "Add a Website");
     sDescription = "The form below will allow you to add a new website.";
  }
  else
  {
     sTitleLinks = bean.getNavigation(request, "Edit the Website");
     sDescription = "The form below will allow you to edit & update the website information.";
  }

/*
    public int SiteID; //      int NOT NULL AUTO_INCREMENT,

     public String Domain;//       varchar(255) NULL,
     public String Description;//  varchar(255) NULL,
     public String FeatuersIds;//  varchar(255) NULL,
     public String SubNames; //      varchar(255) NULL,

     public String TopLink;//       text NULL,
     public String AdPanel; //      text NULL,
     public String Toolbar;//      text NULL,

     public String CreateDate;  //    DATETIME NOT NULL,
*/
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<p>
<form name="sitesetting" action="website.jsp" method="post" onSubmit="return validateWebsite(this);">
<input type="hidden" name="siteid" value="<%=info.SiteID%>">
<% if ("Update Website".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("website.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Website Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr class="normal_row">
    <td width="25%" align="right">Website Name:</td>
    <td><input maxlength=255 size=80 name="sitename" value="<%=Utilities.getValue(info.SiteName)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Description:</td>
    <td><input maxlength=255 size=80 name="description" value="<%=Utilities.getValue(info.Description)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Feature ID:</td>
    <td>
    <select name="feature">
    <option value="">[ Select one of features below ]</option>
    <option value="favorite" <%=bean.getSelected("favorite", info.Feature)%>>Favorite</option>
    <option value="blog" <%=bean.getSelected("blog", info.Feature)%>>Blog</option>
    <option value="qa" <%=bean.getSelected("qa", info.Feature)%>>Q&A</option>
    <option value="shop" <%=bean.getSelected("shop", info.Feature)%>>Shop</option>
    <option value="storage" <%=bean.getSelected("storage", info.Feature)%>>Storage</option>
    <option value="quiz" <%=bean.getSelected("quiz", info.Feature)%>>Quiz</option>
    <option value="track" <%=bean.getSelected("track", info.Feature)%>>Track</option>
    <option value="clubs" <%=bean.getSelected("club", info.Feature)%>>Club</option>
   </select>
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Logo:</td>
    <td><input maxlength=255 size=80 name="logourl" value="<%=Utilities.getValue(info.LogoUrl)%>">
    </td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Google Map Key:</td>
    <td><input size=80 name="params" value="<%=Utilities.getValue(info.Params)%>"> (It is for track sites)</td>
  </tr>    
  <tr class="normal_row">
    <td width="25%" align="right">Top Link Html Code:</td>
    <td><textarea rows="6" cols="60" wrap="virtual" name="toplink"><%=Utilities.getValue(info.TopLink)%></textarea></td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Main Page Content:</td>
    <td><textarea rows="6" cols="60" wrap="virtual" name="maincontent"><%=Utilities.getValue(info.MainContent)%></textarea></td>
  </tr>
  <tr class="normal_row">
      <td width="25%" align="right">Main Page Content 2:</td>
      <td><textarea rows="6" cols="60" wrap="virtual" name="maincontent2"><%=Utilities.getValue(info.MainContent2)%></textarea></td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Footer Link code:</td>
    <td><textarea rows="6" cols="60" wrap="virtual" name="footer"><%=Utilities.getValue(info.Footer)%></textarea></td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<!--SCRIPT>onSiteSettingFormLoad(document.sitesetting);</SCRIPT-->
<%@ include file="../share/footer.jsp"%>