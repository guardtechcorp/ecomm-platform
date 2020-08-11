<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/membership.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberAreaBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberAreaInfo"%>
<%
  MemberAreaBean bean = new MemberAreaBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERAREA))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  MemberAreaInfo info = null;
  if ("Add Area".equalsIgnoreCase(sAction))
  {
    MemberAreaBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (MemberAreaInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "area");
      //. Change to update of adding its sub-category
//      info = (MemberAreaInfo)ret.getUpdateInfo();
//      sAction = "Update Area";
    }
  }
  else if ("Update Area".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    MemberAreaBean.Result ret = bean.update(request, false);
    info = (MemberAreaInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "area");
    }
  }
  else if ("edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Area";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Area";
  }

  if (info==null)
  {
    info = MemberAreaInfo.getInstance(true);
    sAction = "Add Area";
  }

  String sHelpTag = "memberarea";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Area".equalsIgnoreCase(sAction))
  {
//     sTitleLinks += "<a href=\"arealist.jsp\">Member Area List</a> > <b>Create a Member Area</b>";
     sTitleLinks = bean.getNavigation(request, "Create a Member Area");
     sDescription = "The form below will allow you to create a new member area.";
  }
  else
  {
//     sTitleLinks += "<a href=\"arealist.jsp\">Member Area List</a> > <b>Edit the Member Area</b>";
     sTitleLinks = bean.getNavigation(request, "Edit the Member Area");
     sDescription = "The form below will allow you to edit and update the area.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="memberarea" action="area.jsp" method="post" onsubmit="return validateMemberArea(this);">
<input type="hidden" name="areaid" value="<%=info.AreaID%>">
<% if (!"Add Area".equalsIgnoreCase(sAction)) { %>
<table width="98%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("area.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Member Area</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="21%" align="right">Area Name:</td>
      <td class="row1" width="31%">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="80" size="34">
      </td>
      <td class="row1" height="12">The name will be content name in URL.</td>
    </tr>
    <tr>
      <td colspan="3" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
  </table>
</form>
<SCRIPT>onMemberAreaLoad(document.memberarea);</SCRIPT>
<%@ include file="../share/footer.jsp"%>