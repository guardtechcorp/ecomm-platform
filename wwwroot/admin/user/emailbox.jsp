<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/emailbox.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.EmailBoxBean"%>
<%@ page import="com.zyzit.weboffice.model.EmailBoxInfo"%>
<%
  EmailBoxBean bean = new EmailBoxBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EMAILBOX))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  EmailBoxInfo info = null;
  if ("Add E-Mail".equalsIgnoreCase(sAction))
  {
    EmailBoxBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (EmailBoxInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "E-Mail");
      response.sendRedirect("emailboxlist.jsp?action=E-Mail Boxes");
    }
  }
  else if ("Update E-Mail".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    EmailBoxBean.Result ret = bean.update(request, false);
    info = (EmailBoxInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "E-Mail");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update E-Mail";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update E-Mail";
  }

  if (info==null)
  {
    info = EmailBoxInfo.getInstance(true);
    info.Type = 1;
    info.Active = 1;

    sAction = "Add E-Mail";
  }

  String sHelpTag = "emailbox";
  String sTitleLinks = "<a href=\"emailboxlist.jsp?action=E-Mail Boxes\">E-Mail Box List</a> > <b>E-Mail Box</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below will allow you to add or edit E-Mail Box's settings.
<form name="thisform" action="emailbox.jsp" method="post" onsubmit="return validateEmailBoxForm(this, '<%=bean.getEmailDomain()%>');">
<input type="hidden" name="emailid" value="<%=info.EmailID%>">
<% if (info.EmailID>=0) { %>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"></td>
    <td align="right"><%=bean.getPrevNextLinks("emailbox.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">E-Mail Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="15%" align="right">E-Mail Address:</td>
      <td class="row1">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" size=20 maxlength="40"><b>@<%=bean.getEmailDomain()%></b>
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">Password:</td>
      <td class="row1">
        <input type="password" name="password" size=20 maxlength="20" value="<%=Utilities.getValue(info.Password)%>" <%=(info.Type==1?"":"disabled")%>>
        Confirm Password: <input type="password" name="cpassword" size="20" maxlength="20" value="<%=Utilities.getValue(info.Password)%>" <%=(info.Type==1?"":"disabled")%>>
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">Description:</td>
      <td class="row1" valign="top">
       <textarea rows="3" cols="50" wrap="virtual" name="description"><%=Utilities.getValue(info.Description)%></textarea> The description for this E-Mail box.
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">Owner:</td>
      <td class="row1">
        <select name="userid" <%=(info.Type==1?"":"disabled")%>>
          <%=bean.getOwnerList(info)%>
        </select> The owner of this E-Mail Box.
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">E-Mail Type:</td>
      <td class="row1">
        <select name="type" onChange="onEmailTypeChange(document.thisform, this)">
          <option value=0 <%=bean.getSelected(0, info.Type)%>>Forward E-Mail Box</option>
          <option value=1 <%=bean.getSelected(1, info.Type)%>>Normal E-Mail Box</option>
        </select> Forward E-Mail box can only distribute incoming emails to the mail list below.
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">Forward E-Mail List:</td>
      <td class="row1" valign="top">
       <textarea rows="3" cols="50" wrap="virtual" name="forward"><%=bean.getForwardList(info)%></textarea> The email address list separated by comma.
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right">Active:</td>
      <td class="row1">
        <select name="active">
          <option value=1 <%=bean.getSelected(1, info.Active)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Active)%>>No</option>
        </select> If selects 'No', this E-Mail box will stop to send and receive E-Mails.
      </td>
    </tr>
    <TR class="normal_row">
      <TD colSpan=2 height=5></TD>
    </TR>
    <tr>
      <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
  </table>
</form>
<SCRIPT>onEmailBoxFormLoad(document.thisform);</SCRIPT>
<%@ include file="../share/footer.jsp"%>