<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/livechat.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.LiveChatSettingBean"%>
<%@ page import="com.zyzit.weboffice.model.LiveSettingInfo"%>

<%@ page import="com.zyzit.weboffice.model.LinkPageInfo"%>
<%
  LiveChatSettingBean bean = new LiveChatSettingBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_LIVECHAT_SETTING))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  LiveSettingInfo info = null;
  String sClass = "successful";
  if ("Update Settings".equalsIgnoreCase(sAction))
  {
    LiveChatSettingBean.Result ret = (LiveChatSettingBean.Result)session.getAttribute(LiveChatSettingBean.KEY_UPLOADRESULT);
    int nError = 0;
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      nError = errObj.getErrorNo();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
      info = (LiveSettingInfo)ret.getUpdateInfo();
    }
    else
    {
      Map hmParameter = (Map)ret.m_InfoObject;
      info = (LiveSettingInfo)ret.getUpdateInfo();
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Live Chat Setting");
    }
  }
  else if ("removeimage".equalsIgnoreCase(sAction))
  {
    info = (LiveSettingInfo)bean.getCacheMap().get(bean.KEY_TEMPINFO);
    String sImageName = request.getParameter("name");
    if ("livechat".equalsIgnoreCase(sImageName))
       info.LogoImage = "";
  }
  else
  {
    info =  bean.get(request);
  }

//  ConfigInfo cfInfo = bean.getConfigInfo();
  LinkPageInfo lpInfo = bean.getPageInfoByName("Live-Chat");

  String sHelpTag = "livechatsetting";
  String sTitleLinks = "<b>Live Chat Settings</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This form allows you to config your live chat settings.
<form name="livechatsetting" action="multipartform.jsp?return=livechatsetting.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateSetting(this);">
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th colspan=2 class="thHead" height="2">Live Chat Settings</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan=2 height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
  <tr>
    <td class="row1" width="16%" align="right">Live Chat On/Off:</td>
    <td class="row1">
      <select name="active">
        <option value=1 <%=bean.getSelected(1, lpInfo.Active)%>>On</option>
        <option value=0 <%=bean.getSelected(0, lpInfo.Active)%>>Off</option>
      </select> If On, the live chat link will show on your website and customers can launch live chat session.
    </td>
  </tr>
 <tr>
  <td class="row1" colspan=2>
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="16%" align="right" valign="top">Title Name:</td>
      <td class="row1" colspan="2">
        <input type="text" name="titletext" value="<%=Utilities.getValue(info.TitleText)%>" size="105" maxlength="255">
        <br>Color:
         <input type="text" name="titlecolor" value="<%=Utilities.getValue(info.TitleColor)%>" maxlength="7" size="7" style="color: <%=info.TitleColor%>">
        <a href="javascript:loadSelectColor(document.livechatsetting.titlecolor, 2);">Select Color</a>
        Font:
        <select name="titlefont">
          <%=bean.getFontMeun(info.TitleFont)%>
        </select> Size:
        <select name="titlesize">
          <%=bean.getSizeMenu(info.TitleSize)%>
        </select> Bold:
        <select name="titlebold">
          <option value=1 <%=bean.getSelected(1, info.TitleBold)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.TitleBold)%>>No</option>
        </select> Italic:
        <select name="titleitalic">
          <option value=1 <%=bean.getSelected(1, info.TitleItalic)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.TitleItalic)%>>No</option>
        </select>
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right">Background Color:</td>
      <td class="row1" colspan="2">
        <select name="backcolor">
          <%=bean.getColorMeun(info.BackColor)%>
        </select>The background color of chat area
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right">Display Chat Time:</td>
      <td class="row1" colspan="2">
        <select name="showtime">
          <option value=1 <%=bean.getSelected(1, info.ShowTime)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.ShowTime)%>>No</option>
        </select> If Yes, the chat time will be showing on top of chat area.
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right">Display Left Area:</td>
      <td class="row1" colspan="2">
        <select name="showleftarea">
          <option value=1 <%=bean.getSelected(1, info.ShowLeftArea)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.ShowLeftArea)%>>No</option>
        </select> If Yes, your logo image and description will be showing on left side of chat area.
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right">Logo Image:</td>
      <td class="row1" colspan="2">
        <input type="hidden" name="logoimage" value="<%=Utilities.getValue(info.LogoImage)%>">
        <input type="file" name="lsmage" size="40">
<% if (info.LogoImage!=null&&info.LogoImage.length()>0) { %>
        &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=info.LogoImage%>" target="imageview">Preview
        Image</a>&nbsp;&nbsp;<a href="livechatsetting.jsp?action=removeimage&name=livechat">Remove</a>
<% } %> <br>The logo image will display on top-left area.
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right" valign="top">Service Description:</td>
      <td class="row1" colspan="2">
        <textarea name="description" rows="3" cols="79" wrap="virtual"><%=Utilities.getValue(info.Description)%></textarea>
        <br>Color:
        <select name="desccolor">
          <%=bean.getColorMeun(info.DescColor)%>
        </select> Font:
        <select name="descfont">
          <%=bean.getFontMeun(info.DescFont)%>
        </select> Size:
        <select name="descsize">
          <%=bean.getSizeMenu(info.DescSize)%>
        </select> Bold:
        <select name="descbold">
          <option value=1 <%=bean.getSelected(1, info.DescBold)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.DescBold)%>>No</option>
        </select> Italic:
        <select name="descitalic">
          <option value=1 <%=bean.getSelected(1, info.DescItalic)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.DescItalic)%>>No</option>
        </select>
      </td>
    </tr>
  </table>
  </td>
 </tr>
 <tr>
  <td class="row1" colspan=2>
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="16%" align="right">Question</td>
      <td class="row1" colspan="2">Color:
        <select name="questioncolor">
          <%=bean.getColorMeun(info.QuestionColor)%>
        </select> Font:
        <select name="questionfont">
          <%=bean.getFontMeun(info.QuestionFont)%>
        </select> Size:
        <select name="questionsize">
          <%=bean.getSizeMenu(info.QuestionSize)%>
        </select> Bold:
        <select name="questionbold">
          <option value=1 <%=bean.getSelected(1, info.QuestionBold)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.QuestionBold)%>>No</option>
        </select> Italic:
        <select name="questionitalic">
          <option value=1 <%=bean.getSelected(1, info.QuestionItalic)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.QuestionItalic)%>>No</option>
        </select><br>The display attributes of question message for a client to chat.
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right">Answer:</td>
      <td class="row1" colspan="2">Color:
        <select name="answercolor">
          <%=bean.getColorMeun(info.AnswerColor)%>
        </select> Font:
        <select name="answerfont">
          <%=bean.getFontMeun(info.AnswerFont)%>
        </select> Size:
        <select name="answersize">
          <%=bean.getSizeMenu(info.AnswerSize)%>
        </select> Bold:
        <select name="answerbold">
          <option value=1 <%=bean.getSelected(1, info.AnswerBold)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.AnswerBold)%>>No</option>
        </select> Italic:
        <select name="answeritalic">
          <option value=1 <%=bean.getSelected(1, info.AnswerItalic)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.AnswerItalic)%>>No</option>
        </select><br>The display attributes of anwser for a service person.
      </td>
    </tr>
  </table>
  </td>
 </tr>
 <tr>
  <td class="row1" colspan=2>
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="16%" align="right" valign="top">Welcome Message:</td>
      <td class="row1" colspan="2">
        <textarea name="welcome" rows="3" cols="79" wrap="virtual"><%=Utilities.getValue(info.Welcome)%></textarea>
        <br>Displays this text to clients when they start a chat session.
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right" valign="top">Good Bye Message:</td>
      <td class="row1" colspan="2">
        <textarea name="goodbye" rows="3" cols="79" wrap="virtual"><%=Utilities.getValue(info.GoodBye)%></textarea>
        <br>Displays this text to clients when a chat ends or expires.
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right">Timeout Minutes:</td>
      <td class="row1" colspan="2">
       <input type="text" name="timeout" size="5" value="<%=Utilities.getValue(info.Timeout)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
        How long a chat session will expire if there are no any activities.
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right">Maximum Sessions:</td>
      <td class="row1" colspan="2">
       <input type="text" name="maxsession" size="5" value="<%=Utilities.getValue(info.MaxSession)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
        The maximun number of concurrent sessions are allowed.
      </td>
    </tr>
  </table>
  </td>
 </tr>

<tr>
  <td colspan=2 align="center" class="catBottom">
   <table width="100%" height="10" cellspacing="1" border="0">
    <tr>
     <td align="center"><input type="submit" name="action" value="Update" style="WIDTH:70px"></td>
    </tr>
   </table>
  </td>
</tr>
</table>
</form>
<%@ include file="../share/footer.jsp"%>