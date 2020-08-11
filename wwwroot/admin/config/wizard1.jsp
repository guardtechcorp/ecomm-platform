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
       response.sendRedirect("wizard2.jsp?action=Step 2");
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
  String sTitleLinks = "<b>Setup Wizard -- Step One</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This step is to setup the attributes of the website.
<form name="config" action="multipartform.jsp?return=wizard1.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateStep1(this);">
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th colspan=2 class="thHead" height="2">Setup Attributes</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan=2 height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
 <tr>
  <td class="row1" colspan=2>
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right">Language:</td>
      <td class="row1" colspan="2">
        <select name="language">
          <%=bean.getLanguageList(info.Language)%>
        </select> The Language of the entire website and online store.
      </td>
    </tr>
    <tr>
     <td class="row1" width="20%" align="right">Background Color:</td>
     <td class="row1" colspan="2"><input type="text" name="backcolor" value="<%=Utilities.getValue(info.BackColor)%>" maxlength="7" size="7" style="color: <%=info.BackColor%>" onClick="javascript:loadSelectColor(this, 2);">
      <a href="javascript:loadSelectColor(document.config.backcolor, 2);">Select Color</a> The background color of whole website and online store.
    </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Background Image:</td>
      <td class="row1" colspan="2">
        <input type="hidden" name="backimage" value="<%=Utilities.getValue(info.BackImage)%>">
        <input type="file" name="backtile" size="40">
        <% if (info.BackImage!=null&&info.BackImage.length()>0) { %>
        &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=info.BackImage%>" target="imageview">Preview Image</a>&nbsp;&nbsp;<a href="wizard1.jsp?action=removeimage&name=backtile">Remove</a>
        <% } %>
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
     <td width="15%" align="right"></td>
     <td width="15%" align="center"><input type="submit" name="action" value="Next >" style="WIDTH:70px"></td>
    </tr>
   </table>
  </td>
</tr>
</table>
</form>
<!--SCRIPT>onConfigLoad(document.config);</SCRIPT-->
<%@ include file="../share/footer.jsp"%>