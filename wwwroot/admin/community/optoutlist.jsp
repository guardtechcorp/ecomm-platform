<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityOptOutBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityOptOutInfo"%>
<%
  CommunityOptOutBean bean = new CommunityOptOutBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";

  if ("Delete".equalsIgnoreCase(sAction))
  {
    CommunityOptOutBean.Result ret = bean.delete(request);
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
  List ltArray = bean.getAll(request, "optoutlist.jsp?");

  String sHelpTag = "communityoptoutlist";
  String sTitleLinks = bean.getNavigation(request, "E-Mail Opt-Out List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all community E-Mail Opt-Out list and sort them. You can delete any of them.
<p>
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'optoutlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="8%" class="thCornerL">No.</th>
    <th width="40%" align="center" class="thCornerL"><%=bean.getSortNameLink("EMail", "optoutlist.jsp", "E-Mail")%></th>
    <th width="25%" align="center" class="thCornerL"><%=bean.getSortNameLink("AutoID", "optoutlist.jsp", "Campaign Type")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "optoutlist.jsp", "Create Date and Time")%></th>
    <th width="7%" align="center" class="thCornerL">Actions</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=7>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunityOptOutInfo info = (CommunityOptOutInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="8%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="40%"><a title="Send a email to this user"  href="../util/email.jsp?action=person&toemail=<%=info.EMail%>&group=recipients"><%=info.EMail%></a></td>
    <td class="row1" width="25%" align="center"><%=bean.getCampaignType(info.AutoID)%></td>
    <td class="row1" width="20%" align="center"><%=Utilities.getDateValue(info.CreateDate, 19)%></td>
    <td class="row1" width="7%" align="center"><a onClick="return confirm('Are you sure you want to delete it?');" href="optoutlist.jsp?action=delete&outid=<%=info.OutID%>">Delete</a>
    </td>
  </tr>
<%}}%>
  <tr>
    <td colspan="7" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><!--a href="user.jsp?action=adduser&return=userlist.jsp&display=User List">Add New User</a--></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
