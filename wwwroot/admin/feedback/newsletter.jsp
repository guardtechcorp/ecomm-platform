<%@ include file="../share/uparea.jsp"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<<%@ page import="com.zyzit.weboffice.bean.NewsletterBean"%>
<%@ page import="com.zyzit.weboffice.model.NewsletterInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/newsletter.js"></SCRIPT>
<%
  NewsletterBean bean = new NewsletterBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_NEWSLETTER|AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  NewsletterInfo info = null;
  if ("Add Mail Receiver".equalsIgnoreCase(sAction))
  {
    NewsletterBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (NewsletterInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Mail Receiver");
      sAction = "Update Mail Receiver";
    }
  }
  else if ("Update Mail Receiver".equalsIgnoreCase(sAction))
  {
    NewsletterBean.Result ret = bean.update(request, false);
    info = (NewsletterInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Mail Receiver");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Mail Receiver";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Mail Receiver";
  }

  if (info==null)
  {
    info = NewsletterInfo.getInstance(true);
    sAction = "Add Mail Receiver";
  }

  String sHelpTag = "communtiywebsitesetting";
  String sTitleLinks;
  String sDescription;
  if ("Add Mail Receiver".equalsIgnoreCase(sAction))
  {
     sTitleLinks = bean.getNavigation(request, "Add a Mail Receiver");
     sDescription = "The form below will allow you to add a new mail receiver.";
  }
  else
  {
     sTitleLinks = bean.getNavigation(request, "Edit the Mail Receiver");
     sDescription = "The form below will allow you to edit & update the mail receiver information.";
  }

%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<p>
<form name="newsletter" action="newsletter.jsp" method="post" onSubmit="return onValidateMailList(this);">
<input type="hidden" name="newslid" value="<%=info.NewslID%>">
<input type="hidden" name="groupid" value="<%=bean.getReference()%>">
<% if ("Update Mail Receiver".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("newsletter.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Mail Receiver Information</th>
    </tr>
    <tr class="normal_row">
      <td colspan="2" height="10"></td>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr class="normal_row">
    <td width="25%" align="right">Receiver Name:</td>
    <td><input maxlength=255 size=80 name="yourname" value="<%=Utilities.getValue(info.Yourname)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">E-Mail:</td>
    <td><input maxlength=255 size=80 name="email" value="<%=Utilities.getValue(info.EMail)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Note:</td>
    <td><%=Utilities.getValue(info.Note)%></td>
  </tr>
  <tr>
   <td class="row1" width="25%" align="right">Subscribe:</td>
   <td class="row1" colspan="2">
     <select name="subscribe">
       <option value=1 <%=bean.getSelected(1, info.Subscribe)%>>Yes</option>
       <option value=0 <%=bean.getSelected(0, info.Subscribe)%>>No</option>
     </select> If selects 'No', the mail will not send to this receiver.
   </td>
  </tr>
  <tr class="normal_row">
    <td colspan="2" height="10"></td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<SCRIPT>onMailListLoad(document.newsletter);</SCRIPT>
<%@ include file="../share/footer.jsp"%>