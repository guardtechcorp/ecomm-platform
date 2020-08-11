<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberPlanBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberPlanInfo"%>
<%
  MemberPlanBean bean = new MemberPlanBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERAREA))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    MemberPlanBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request);

  String sHelpTag = "memberplanlist";
//  String sTitleLinks = "<b>Memeber Plan List</b>";
  String sTitleLinks = bean.getNavigation(request, "Member Plan List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all the member plan definations.
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'planlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="8%" align="center" class="thCornerL">No.</th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("PlanID", "planlist.jsp", "Plan ID")%></th>
    <th width="44%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "planlist.jsp", "Plan Name")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "planlist.jsp", "Create Date")%></th>
    <th width="20%" align="center" class="thCornerL">Actions</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="8" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=5>There is no any record available.</td>
  </tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     MemberPlanInfo info = (MemberPlanInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="8%"><%=(nStartNo+i)%></td>
    <td width="8%" align="center"><%=info.PlanID%></td>
    <td width="44%"><%=info.Name%></td>
    <td width="20%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="20%" align="center"><a href="plan.jsp?action=edit&planid=<%=info.PlanID%>">Edit</a> | <a href="planlist.jsp?action=delete&planid=<%=info.PlanID%>" onClick="return confirm('Are you sure you want to delete this one.');">Delete</a></td>
  </tr>
<%}}%>
  <tr>
    <td colspan="5" class="catBottom">
      <table width="100%" border="0">
        <tr>
         <td width="30%"><a href="plan.jsp?action=New Plan">Add a new Plan</a></td>
         <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>