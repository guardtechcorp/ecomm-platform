<%@ include file="../share/uparea.jsp"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<<%@ page import="com.zyzit.weboffice.bean.NewsletterGroupBean"%>
<%@ page import="com.zyzit.weboffice.model.NewsletterGroupInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/newsletter.js"></SCRIPT>
<%
  NewsletterGroupBean bean = new NewsletterGroupBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  NewsletterGroupInfo info = null;
  if ("Add Mail List Group".equalsIgnoreCase(sAction))
  {
    NewsletterGroupBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (NewsletterGroupInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Mail List Group");
      sAction = "Update Mail List Group";
    }
  }
  else if ("Update Mail List Group".equalsIgnoreCase(sAction))
  {
    NewsletterGroupBean.Result ret = bean.update(request, false);
    info = (NewsletterGroupInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      if ("1".equals(request.getParameter("merge")))
      {
         response.sendRedirect("newslettergrouplist.jsp?action=load&rootlink=yes");
         return;
      }

      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Mail List Group");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Mail List Group";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Mail List Group";
  }

  if (info==null)
  {
    info = NewsletterGroupInfo.getInstance(true);
    sAction = "Add Mail List Group";
  }

  String sHelpTag = "maillistgroup";
  String sTitleLinks;
  String sDescription;
  if ("Add Mail list group".equalsIgnoreCase(sAction))
  {
     sTitleLinks = bean.getNavigation(request, "Add a Mail List Group");
     sDescription = "The form below will allow you to add a new mail list group.";
  }
  else
  {
     sTitleLinks = bean.getNavigation(request, "Edit the Mail List Group");
     sDescription = "The form below will allow you to edit & update the mail list group.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<p>
<form name="newslettergroup" action="newslettergroup.jsp" method="post" onSubmit="return onValidateMailListGroup(this);">
<input type="hidden" name="groupid" value="<%=info.GroupID%>">
<% if ("Update Mail List Group".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("newslettergroup.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Mail List Group Information</th>
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
    <td width="25%" align="right">Group Name:</td>
    <td><input maxlength=255 size=80 name="name" value="<%=Utilities.getValue(info.Name)%>"></td>
  </tr>
  <tr class="normal_row">
    <td width="25%" align="right">Site Url:</td>
    <td><input maxlength=255 size=80 name="siteurl" value="<%=Utilities.getValue(info.SiteUrl)%>"></td>
  </tr>
  <tr class="normal_row">
      <td width="25%" align="right">Description:</td>
      <td> <textarea rows="4" cols="60" wrap="virtual" name="description"><%=Utilities.getValue(info.Description)%></textarea></td>
  </tr>
<% if (info.GroupID>0) { %>
  <tr class="normal_row">
     <td width="25%" align="right">Merge It:</td>
     <td>
      <select name="merge" onchange="onMergeChange(document.newslettergroup);">
         <option value="0">No</option>
         <option value="1">Yes</option>
      </select> To:
      <select name="togroupid" disabled>
       <option value="-1">[Select One of Groups]</option>
        <%=bean.getToGroupList(info.GroupID)%>
      </select> If you select 'Yes', you need to select one of group.
     </td>
  </tr>
 <% } %>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<SCRIPT>onMailListGroupLoad(document.newslettergroup);</SCRIPT>
<%@ include file="../share/footer.jsp"%>