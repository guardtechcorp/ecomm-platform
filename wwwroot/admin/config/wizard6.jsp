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
        response.sendRedirect("wizard5.jsp?action=Step 5");
      else
        response.sendRedirect("wizard7.jsp?action=Step 7");
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
  String sTitleLinks = "<b>Setup Wizard -- Step Six</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This step is to setup the bottom bar of website.
<form name="config" action="multipartform.jsp?return=wizard6.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateStep6(this);">
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th colspan=2 class="thHead" height="2">Setup Bottom Bar</th>
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
      <td class="row1" width="20%" align="right">Counter Display:</td>
      <td class="row1" colspan="2">
        <select name="showcounter">
          <option value=1 <%=bean.getSelected(1, info.ShowCounter)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.ShowCounter)%>>No</option>
        </select> Show a visiting counter to your website at left-bottom of each page.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Bottom Bar Display:</td>
      <td class="row1" colspan="2">
        <select name="bottombar" onChange="onSelectFlagChange2(this, 'bottomimage', 'bottombar')">
          <option value=1 <%=bean.getSelected(1, info.BottomBar)%>>Use default</option>
          <option value=2 <%=bean.getSelected(2, info.BottomBar)%>>Use your own</option>
          <option value=0 <%=bean.getSelected(0, info.BottomBar)%>>No bar</option>
        </select> Show the default bottom bar, display your own or not display it at all.
      </td>
    </tr>
<tr id="bottomimage" style="DISPLAY: <%=info.BottomBar==2?"show":"none"%>">
 <td colspan=3 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right">Bottom Bar Image:</td>
      <td class="row1" colspan="2">
        <input type="hidden" name="bottombarimage" value="<%=Utilities.getValue(info.BottomImage)%>">
        <input type="file" name="bottom" size="40">
        <% if (info.BottomImage!=null&&info.BottomImage.length()>0) { %>
        &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=info.BottomImage%>" target="imageview">Preview
        Image</a>&nbsp;&nbsp;<a href="wizard6.jsp?action=removeimage&name=bottom">Remove</a>
        <% } %>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Or Html Code:</td>
      <td class="row1" colspan="2">The html code allows to display more complex bottom bar.<br>
        <textarea name="bottomcode" rows="4" cols="70" wrap="virtual" <%=bean.getDisableFlag(info.BottomImage)%>><%=Utilities.getValue(info.BottomCode)%></textarea>
      </td>
    </tr>
  </table>
</td>
</tr>
<tr id="bottombar" style="DISPLAY: <%=info.BottomBar==1?"show":"none"%>">
 <td colspan=3 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2" >
    <tr>
      <td class="row1" width="20%" align="right">Security Policy Display:</td>
      <td class="row1" width="80%">
        <select name="security">
          <option value=1 <%=bean.getSelected(1, info.Security)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Security)%>>No</option>
        </select> Show Security Policy Link on the bottom. You can <a href="../util/content.jsp?contentid=<%=info.SecurityID%>&name=SecurityID&title=Security Policy&return=../config/wizard6.jsp">Edit</a> the content.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Privacy Note Display:</td>
      <td class="row1" width="80%">
        <select name="privacy">
          <option value=1 <%=bean.getSelected(1, info.Privacy)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Privacy)%>>No</option>
        </select> Show Privacy Note Link on the bottom. You can <a href="../util/content.jsp?contentid=<%=info.PrivacyID%>&name=PrivacyID&title=Privacy Note&return=../config/wizard6.jsp">Edit</a> the content.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Legal Statement Display:</td>
      <td class="row1" width="80%">
        <select name="return">
          <option value=1 <%=bean.getSelected(1, info.Legal)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Legal)%>>No</option>
        </select> Show Legal Statement Link on the bottom. You can <a href="../util/content.jsp?contentid=<%=info.LegalID%>&name=LegalID&title=Legal Statement&return=../config/wizard6.jsp">Edit</a> the content.
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