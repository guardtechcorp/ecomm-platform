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
        response.sendRedirect("wizard2.jsp?action=Step 2");
      else
        response.sendRedirect("wizard4.jsp?action=Step 4");
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
    sDisplayMessage = "You have to press <b>Next</b> or <b>Back</b> button to remove it permanently.";
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
  String sTitleLinks = "<b>Setup Wizard -- Step Three</b>";
%>
This step is to setup the advertisment bar of the website.
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<form name="config" action="multipartform.jsp?return=wizard3.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateStep3(this);">
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th colspan=2 class="thHead" height="2">Setup Advertisment Bar</th>
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
      <td class="row1" width="20%" align="right">Advertisement Display:</td>
      <td class="row1" colspan="2">
        <select name="advertisebar" onChange="onSelectFlagChange(this, 'advertise')">
          <option value=1 <%=bean.getSelected(1, info.AdvertiseBar)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.AdvertiseBar)%>>No</option>
        </select>Show Advertisement Bar below the titlebar (Width should be 778 pixel or less.)
      </td>
    </tr>
<tr  id="advertise" style="DISPLAY: <%=info.AdvertiseBar==1?"show":"none"%>">
 <td colspan=3 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right">Advertise Image:</td>
      <td class="row1" colspan="2">
        <input type="hidden" name="advertiseimage" value="<%=Utilities.getValue(info.AdvertiseImage)%>">
        <input type="file" name="advertise" size="40">
        <% if (info.AdvertiseImage!=null&&info.AdvertiseImage.length()>0) { %>
        &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=info.AdvertiseImage%>" target="imageview">Preview
        Image</a>&nbsp;&nbsp;<a href="wizard3.jsp?action=removeimage&name=advertise">Remove</a>
        <% } %>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Or Html Code:</td>
      <td class="row1" colspan="2">The html code allows to display more complex advertisement.<br>
        <textarea name="advertisecode" rows="4" cols="70" wrap="virtual" <%=bean.getDisableFlag(info.AdvertiseImage)%>><%=Utilities.getValue(info.AdvertiseCode)%></textarea>
      </td>
    </tr>
  </table>
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