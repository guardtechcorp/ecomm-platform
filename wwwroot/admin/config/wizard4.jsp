<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/config.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ConfigBean"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
  ConfigBean bean = new ConfigBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  ConfigInfo info = null;
  String sClass = "successful";
  if ("Update Settings".equalsIgnoreCase(sAction))
  {
    ConfigBean.Result ret = (ConfigBean.Result)session.getAttribute(ConfigBean.KEY_UPLOADRESULT);
    int nError = 0;
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      nError = errObj.getErrorNo();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
      info = (ConfigInfo)ret.getUpdateInfo();
    }
    else
    {
      Map hmParameter = (Map)ret.m_InfoObject;
      info = (ConfigInfo)ret.getUpdateInfo();
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "configuration");
    }

    if (nError==0 || nError==DisplayMessage.DM_NOANYCHANGE_ERROR)
    {
      if (ret.m_sAction.indexOf("Back")!=-1)
        response.sendRedirect("wizard3.jsp?action=Step 3");
      else
        response.sendRedirect("wizard5.jsp?action=Step 5");
    }
  }
  else if ("removeimage".equalsIgnoreCase(sAction))
  {
    info = (ConfigInfo)bean.getCacheMap().get(bean.KEY_TEMPINFO);
    String sImageName = request.getParameter("name");
    if ("backtile".equalsIgnoreCase(sImageName))
       info.BackImage = "";
    else if ("title".equalsIgnoreCase(sImageName))
       info.TitleImage = "";
    else if ("advertise".equalsIgnoreCase(sImageName))
       info.AdvertiseImage = "";
    else if ("bottom".equalsIgnoreCase(sImageName))
       info.BottomImage = "";
    sDisplayMessage = "You have to click <b>Next</b> or <b>Back</b> button to remove it permanently.";
  }
  else if ("finisheditcontent".equalsIgnoreCase(sAction))
  {
    String sSet = request.getParameter("name")+"="+request.getParameter("contentid");
    info = bean.updateContentID(request, sSet);
  }
  else
  {
    info =  bean.get(request);
  }

  String sHelpTag = "setupwizard";
  String sTitleLinks = "<b>Setup Wizard -- Step Four</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This step is to setup the content and link of home page.
<form name="config" action="multipartform.jsp?return=wizard4.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateStep4(this);">
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th colspan=2 class="thHead" height="2">Setup Home Page</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan=2 height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>

 <tr>
  <td colspan=2 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right" valign="top">Home Page Gategory:</td>
      <td class="row1" colspan="2">
        <select name="homecategoryid">
        <%=bean.getAllCategoryList(info.HomeCategoryID)%>
        </select> Select 'My Content', or one of categories. If select the category, its products will show on your home page.
         If select 'My Content', the home page will show your own content and you can <a href="../util/content.jsp?contentid=<%=info.HomePageID%>&name=HomePageID&title=Home Page Content&return=../config/wizard4.jsp">Edit</a> it.
        </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right" valign="middle"><br>Home Link:</td>
      <td class="row1" colspan="2" height="2">If you want the Home button of online store to link to your main website, please enter the URL:<br>
        <input type="text" name="homeurl" value="<%=Utilities.getValue(info.HomeURL)%>" maxlength="255" size="80">  (for example, http://www.yourdomainame.com)
     </td>
    </tr>
   </table>
  </td>
 </tr>

<tr>
  <td colspan=2 align="center" class="catBottom">
   <table width="100%" height="10" cellspacing="1" border="0">
    <tr>
     <td width="70%"></td>
     <td width="15%" align="right"><input type="submit" name="action" value="< Back" style="WIDTH:70px"></td>
     <td width="15%" align="center"><input type="submit" name="action" value="Next >" style="WIDTH:70px"></td>
    </tr>
   </table>
  </td>
</tr>
</table>
</form>
<!--SCRIPT>onConfigLoad(document.config);</SCRIPT-->
<%@ include file="../share/footer.jsp"%>