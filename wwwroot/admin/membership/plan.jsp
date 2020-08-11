<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/membership.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberPlanBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberPlanInfo"%>
<%
  MemberPlanBean bean = new MemberPlanBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERAREA))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  MemberPlanInfo info = null;
  if ("Add Plan".equalsIgnoreCase(sAction))
  {
    MemberPlanBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (MemberPlanInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "plan");
      //. Change to update of adding its sub-category
      info = (MemberPlanInfo)ret.getUpdateInfo();
      sAction = "Update Plan";
    }
  }
  else if ("Update Plan".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    MemberPlanBean.Result ret = bean.update(request, false);
    info = (MemberPlanInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "plan");
    }
  }
  else if ("edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Plan";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Plan";
  }
  if ("Add >>".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    info = bean.updateSelection(request, true);
    sAction = "Update Plan";
  }
  else if ("<< Remove".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    info = bean.updateSelection(request, false);
    sAction = "Update Plan";
  }

  if (info==null)
  {
    info = MemberPlanInfo.getInstance(true);
    sAction = "Add Plan";
  }

  String sHelpTag = "memberplan";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Plan".equalsIgnoreCase(sAction))
  {
//     sTitleLinks += "<a href=\"planlist.jsp?action=Plan List\">Member Plan List</a> > <b>Create a Member Plan</b>";
     sTitleLinks = bean.getNavigation(request, "Create a Member Plan");
     sDescription = "The form below will allow you to create a new member plan.";
  }
  else
  {
//     sTitleLinks += "<a href=\"planlist.jsp?action=Plan List\">Member Plan List</a> > <b>Edit the Member Plan</b>";
     sTitleLinks = bean.getNavigation(request, "Edit the Member Plan");
     sDescription = "The form below will allow you to edit and update the plan.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="memberplan" action="plan.jsp" method="post" onsubmit="return validateMemberPlan(this);">
<input type="hidden" name="planid" value="<%=info.PlanID%>">
<% if (!"Add Plan".equalsIgnoreCase(sAction)) { %>
<table width="90%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("plan.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="90%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Member Plan</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="21%" align="right">Plan Name:</td>
      <td class="row1" width="31%">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="255" size="30">
      </td>
      <td class="row1" height="12">The name of member plan.</td>
    </tr>
    <tr>
      <td colspan="3" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
</table>
<% if (info.PlanID>0) { %>
<br>

<table width="90%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th colspan="3" class="thHead" align="center"><b>Add/Remove Member Areas to/from the Plan</b></th>
  </tr>
  <tr class="normal_row">
      <td width="46%" valign="top" align="center"><br>Available Member Areas/Exam Sections:<br>
        <select name="available" size="10" multiple style="WIDTH: 200px">
         <%=bean.getAreaList(info.PlanID, false)%>
        </select><br>&nbsp;
      </td>
      <td width="8%" valign="top">
    <table width="100%" cellspacing="1" border="0" class="forumline1" align="center">
      <tr>
        <td colspan="3" height="15"></td>
      </tr>
      <tr>
        <td width="1%"></td>
        <td width="98%" align="center"><input type="submit" name="action" value="Add >>" style="WIDTH:90px" onClick="return validateSelections(document.memberplan.available);"></td>
        <td width="1%"></td>
      </tr>
      <tr>
        <td colspan="3" height="30"></td>
      </tr>
      <tr>
        <td width="1%"></td>
        <td width="98%" align="center" nowrap><input type="submit" name="action" value="<< Remove" style="WIDTH:90px" onClick="return validateSelections(document.memberplan.selection);"></td>
        <td width="1%"></td>
      </tr>
     </table>
    </td>
      <td width="46%" valign="top" align="center"><br>Selected Member Areas/Exam Sections:<br>
        <select name="selection" size="10" multiple style="WIDTH:200px">
         <%=bean.getAreaList(info.PlanID, true)%>
        </select><br>&nbsp;
      </td>
  </tr>
</table>
<% } %>
</form>
<SCRIPT>onMemberPlanLoad(document.memberplan);</SCRIPT>
<%@ include file="../share/footer.jsp"%>