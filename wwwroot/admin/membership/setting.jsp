<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/membership.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberSettingBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberSettingInfo"%>
<%
  MemberSettingBean bean = new MemberSettingBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERAREA))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Update Now".equalsIgnoreCase(sAction))
  {
    MemberSettingBean.Result ret = bean.update(request, false);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "membership settings");
    }
  }

  String sHelpTag = "membersetting";
  String sTitleLinks = "<b>General Settings</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below will allow you to do general settings for the membership.
<form name="setting" action="setting.jsp" method="post" onsubmit="return validateMemberSetting(this);">
<table width="99%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Membership Settings</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" align="center" height="20"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td width="18%" height="10" align="right" class="row1" valign="top"><br>Thanks Page Content:</td>
      <td class="row1" width="50%">
       <br><textarea name="thankhtml_content" rows=5 cols=48><%=Utilities.getValue(bean.getSettingInfo("thankhtml").Content)%></textarea>
      </td>
      <td width="32%" class="row1" valign="top">
      <br>.The thanks content and custom instruction HTML. It will display on the top of thanks page after a member is registered.<br>.This should be in HTML, not plain text.<br>.The max is 100K bytes.
      </td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
      <td width="18%" height="10" align="right" class="row1"><input name="thankemail_flag" type="checkbox" value="1" <%=bean.getCheckFlag("thankemail")%>></td>
      <td class="row1" width="50%">Also send a email to registered member</td>
      <td width="32%" rowspan="4" class="row1">
      The thanks content and custom instruction TEXT. It will display on the top of thanks email after a member is registered.<br>.This should be plain text, not HTML.<br>.The max is 100K bytes.
      </td>
    </tr>
    <tr>
      <td width="18%" height="10" align="right" class="row1">Thanks Email Subject:</td>
      <td class="row1" width="50%"><input type="text" name="thankemail_subject" size=63 maxlength=1024 value="<%=bean.getPartialData("thankemail", 0)%>"></td>

    </tr>
    <tr>
      <td width="18%" height="10" align="right" class="row1" valign="top">Thanks Email Content:</td>
      <td class="row1" width="50%">
      <textarea name="thankemail_content" rows=5 cols=48><%=bean.getPartialData("thankemail", 1)%></textarea></td>

    </tr>
    <tr>
      <td width="18%" height="10" align="right" class="row1">From Email Address:</td>
      <td class="row1" width="50%"><input type="text" name="thankemail_address" size=63 maxlength=1024 value="<%=bean.getPartialData("thankemail", 2)%>">
      </td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
     <td class="row1" width="18%" align="right">Login URL:</td>
     <td class="row1" width="50%"><input type="text" name="loginurl_content" size=63 maxlength=1024 value="<%=Utilities.getValue(bean.getSettingInfo("loginurl").Content)%>"></td>
     <td class="row1" width="32%">.This is the Member Login URL that will be used to login by members. <br>.The max is 1024 bytes.</td>
    </tr>
    <tr>
      <td width="18%" height="10" align="right" class="row1" valign="top">The Background Color:</td>
      <td class="row1" width="50%">
        <!--select name="loginpage_backcolor"><%=bean.getColorMeun(bean.getLoginPage(0))%></select-->
        <input type="text" name="loginpage_backcolor" value="<%=Utilities.getValue(bean.getLoginPage(0))%>" maxlength="7" size="7" style="color: <%=bean.getLoginPage(0)%>">
        <a href="javascript:loadSelectColor(document.setting.loginpage_backcolor, 2);">Select Color</a>
      </td>
     <td class="row1" width="32%">The background color of Login Page.</td>
    </tr>
    <tr>
      <td width="18%" height="10" align="right" class="row1" valign="top"><br>The Header Content:</td>
      <td class="row1" width="50%">
       <br><textarea name="loginpage_content" rows=5 cols=48><%=bean.getLoginPage(1)%></textarea>
      </td>
      <td width="32%" class="row1" valign="top">
      <br>.The header content HTML. It will display on the top of member login page.<br>.This should be in HTML, not plain text.<br>.The max is 100K bytes.
      </td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr>
     <td class="row1" width="18%" align="right" valign="top">First Page URL:</td>
     <td class="row1" width="50%" valign="top"><input type="text" name="firsturl_content" size=63 maxlength=1024 value="<%=Utilities.getValue(bean.getSettingInfo("firsturl").Content)%>"></td>
     <td class="row1" width="32%">.This is the first page URL that will be seen by a member when he/she logins the member area. <br>.The max is 1024 bytes.</td>
    </tr>
    <tr>
      <td class="spaceRow" colspan="3" height="10"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center" height="22">
        <input type="submit" name="action" value="Update Now">
      </td>
    </tr>
  </table>
</form>
<SCRIPT>onMemberSettingLoad(document.setting);</SCRIPT>
<%@ include file="../share/footer.jsp"%>