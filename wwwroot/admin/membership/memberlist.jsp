<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%
  MemberBean bean = new MemberBean(session, 23);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERS))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Members".equalsIgnoreCase(sAction))
  {
    int nTotalRecords = bean.getAll(request);
  }
  else if ("Search List".equalsIgnoreCase(sAction))
  {
//    int nTotalRecords = bean.getSearchList(request);
  }
  else if ("Delete".equalsIgnoreCase(sAction))
  {
    MemberBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getPageList(request);

  String sHelpTag = "memberlist";
//  String sTitleLinks = "<b>Member List</b>";
  String sTitleLinks = bean.getNavigation(request, "Member List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view a brief information of all members and you can sort them. You can enter to the email page to send a email to this member or go to the member page to edit its information.
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td><a href="membersearch.jsp?action=Search Member&return=<%=Utilities.getUrlEncode("memberlist.jsp|Members")%>&display=Member List">Search Members</a></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'memberlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL">No.</th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("FirtName", "memberlist.jsp", "First Name")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("LastName", "memberlist.jsp", "Last Name")%></th>
    <th width="28%" align="center" class="thCornerL"><%=bean.getSortNameLink("EMail", "memberlist.jsp", "E-Mail")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Type", "memberlist.jsp", "Account Type")%></th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "memberlist.jsp", "Create Date")%></th>
    <th width="10%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="6" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=6>There is no any records available.</td></tr>
<% } else {
int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
for (int i=0; i<ltArray.size(); i++) {
  MemberInfo info = (MemberInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" width="5%" align="center"><a href='member.jsp?action=Edit&memberid=<%=info.MemberID%>&return=memberlist.jsp&display=Member List'><%=(nStartNo+i)%></a></td>
      <td class="row1" width="10%"><%=info.FirstName%></td>
      <td class="row1" width="10%"><%=info.LastName%></td>
      <td class="row1" width="28%"><a href="../util/email.jsp?action=person&toemail=<%=info.EMail%>&name=<%=info.getPersonalName()%>&group=recipients&return=../membership/memberlist.jsp&display=Member List" title="Email to <%=info.EMail%>"><%=info.EMail%></a></td>
      <td class="row1" width="20%"><%=info.Type==0?"Common User":"Advanced User"%></td>
      <td class="row1" width="16%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
      <td class="row1" width="10%" align="center"><%=bean.getActions(info)%></td>
    </tr>
<%}}%>
    <tr>
    <td colspan="7" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><!-- a href="member.jsp?action=addmember&return=memberlist.jsp&display=Member List">Add a new member</a--></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
    </tr>
</table>
<%@ include file="../share/footer.jsp"%>