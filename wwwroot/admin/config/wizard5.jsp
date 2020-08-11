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
        response.sendRedirect("wizard4.jsp?action=Step 4");
      else
        response.sendRedirect("wizard6.jsp?action=Step 6");
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
  String sTitleLinks = "<b>Setup Wizard -- Step Five</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This step is to setup the vertical panel of website.
<form name="config" action="multipartform.jsp?return=wizard5.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateStep5(this);">
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th colspan=2 class="thHead" height="2">Setup Vertical Panel</th>
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
      <td class="row1" width="20%" align="right">Vertical Panel:</td>
      <td class="row1" width="80%">
        <select name="verticalbarside" onChange="onSelectFlagChange(this, 'vericalbar')">
          <option value=0 <%=bean.getSelected(0, info.VerticalBarSide)%>>On Left Side</option>
          <option value=1 <%=bean.getSelected(1, info.VerticalBarSide)%>>On Right Side</option>
          <option value=2 <%=bean.getSelected(2, info.VerticalBarSide)%>>No Vertical Panel</option>
        </select> The vertical panel can either be on the left or right side or without showing it at all.
      </td>
    </tr>
<tr>
 <td colspan=3 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2" id="vericalbar" style="DISPLAY: <%=info.VerticalBarSide<2?"show":"none"%>">
     <tr>
      <td class="row1" width="20%" align="right">Product Category Display:</td>
      <td class="row1" colspan="2">
        <select name="categoryshow">
          <option value=1 <%=bean.getSelected(1, info.CategoryShow)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.CategoryShow)%>>No</option>
        </select> If yes, you can choose one of the layouts:
        <select name="categorymenuid">
          <%=bean.getLayoutList(info.CategoryMenuID, "CategoryMenu")%>
        </select> <a href="javascript:viewSampleMenu(document.config, 'CategoryMenu')">View</a> sample layout.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Support Membership:</td>
      <td class="row1" width="80%">
        <select name="membership">
          <option value=1 <%=bean.getSelected(1, info.Membership)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Membership)%>>No</option>
        </select>If yes, enter display name of title: <input type="text" name="memberareaname" value="<%=Utilities.getValue(info.MemberAreaName)%>" maxlength="20">
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Site News Display:<br><br>The content auto scrolling:</td>
      <td class="row1" width="80%">
        <select name="newsarea">
          <option value=0 <%=bean.getSelected(0, info.NewsArea)%>>No</option>
          <option value=1 <%=bean.getSelected(1, info.NewsArea)%>>On Vertical Panel</option>
          <option value=2 <%=bean.getSelected(2, info.NewsArea)%>>Floating in Center</option>
        </select>If not No, enter name of news title: <input type="text" name="newstitle" value="<%=Utilities.getValue(info.NewsTitle)%>" maxlength="80">
You can <a href="../util/content.jsp?contentid=<%=info.NewsAreaID%>&name=NewsAreaID&title=Site News&return=../config/wizard5.jsp">Edit</a> the content.
        <br><select name="newsareascroll">
          <option value=1 <%=bean.getSelected(1, info.NewsAreaScroll)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.NewsAreaScroll)%>>No</option>
        </select> The new content can automatically move up or not move.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Newsletter Display:</td>
      <td class="row1" width="80%">
        <select name="newsletter">
          <option value=1 <%=bean.getSelected(1, info.NewsLetter)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.NewsLetter)%>>No</option>
        </select> Show newsletter function on vertical bar panel.</td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right" valign="top">Link Page Display:</td>
      <td class="row1" width="80%">
        <select name="linkpage">
          <option value=1 <%=bean.getSelected(1, info.LinkPage)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.LinkPage)%>>No</option>
        </select> If yes, enter display name of title: <input type="text" name="linkpagetitle" value="<%=Utilities.getValue(info.LinkPageTitle)%>" maxlength="20">
        <br> <a href='../config/linkpagelist.jsp?action=Get List&returnflag=2' target='main'>Enter Link Page List</a> to edit its items or make either one to be active or not active.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right" valign="top">Google AdSense ID:</td>
      <td class="row1" width="80%">
      <input type="text" name="googleadsenseid" value="<%=Utilities.getValue(info.GoogleAdSenseID)%>" maxlength="80">
      If you enter it, the content of Ads will show on the bottom of vertical Panel.
      </td>
    </tr>

    <!--tr>
      <td class="row1" width="20%" align="right">Feedback Display:</td>
      <td class="row1" width="80%">
        <select name="feedback">
          <option value=1 <%=bean.getSelected(1, info.Feedback)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Feedback)%>>No</option>
        </select> Show customer feedback function on vertical bar panel.</td>
    </tr-->
    <!--tr>
      <td class="row1" width="20%" align="right">Tell Friend Display:</td>
      <td class="row1" width="78%">
        <select name="tellfriend">
          <option value=1 <%=bean.getSelected(1, info.TellFriend)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.TellFriend)%>>No</option>
        </select> Show Tell-Friend function on vertical bar panel. If yes, you can <a href="../util/content2.jsp?contentid=<%=info.TellFriendID%>&name=TellFriendID&title=The Content of telling friends&return=../config/wizard5.jsp">Edit</a> the content.
      </td>
    </tr-->
<% if (bean.hasAccessRole(AccessRole.ROLE_LIVECHAT_SETTING)) {%>
    <!--tr>
      <td class="row1" width="20%" align="right">Live Chat Display:</td>
      <td class="row1" width="78%">
        <select name="livechat">
          <option value=1 <%=bean.getSelected(1, info.LiveChat)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.LiveChat)%>>No</option>
        </select> Show Live Chat Link to allow the customers to launch live chat session.
      </td>
    </tr-->
<% } %>
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