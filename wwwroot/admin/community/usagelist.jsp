<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityUsageBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityUsageInfo"%>
<%
  CommunityUsageBean bean = new CommunityUsageBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";

  if ("Delete".equalsIgnoreCase(sAction))
  {
    CommunityUsageBean.Result ret = bean.delete(request);
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
  List ltArray = bean.getAll(request, "usagelist.jsp?");

  String sHelpTag = "communityusagelist";
  String sTitleLinks = bean.getNavigation(request, "Usage List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view the usage list.
<p>
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'usagelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" class="thCornerL">No.</th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("UsageType", "usagelist.jsp", "Usage Type")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("ClientIP", "usagelist.jsp", "IP Address")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("SessionID", "usagelist.jsp", "Session ID")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("LoginDate", "usagelist.jsp", "Login Date")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("LogoutDate", "usagelist.jsp", "Logout Date")%></th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=7>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunityUsageInfo info = (CommunityUsageInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="6%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="20%" align="center"><%=bean.getUsageType(info.UsageType)%></td>
    <td class="row1" width="20%" align="center"><%=info.ClientIP%></td>
    <td class="row1" width="18%" align="center"><%=info.SessionID%></td>
    <td class="row1" width="18%" align="center"><%=Utilities.getDateValue(info.LoginDate, 19)%></td>
    <td class="row1" width="18%" align="center"><%=Utilities.getDateValue(info.LogoutDate, 19)%></td>
  </tr>
<%}}%>
  <tr>
    <td colspan="7" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="10%"></td>
          <td width="90%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
