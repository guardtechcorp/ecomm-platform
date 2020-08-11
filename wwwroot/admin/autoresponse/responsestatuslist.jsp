<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.AutoResponseStatusRecordBean"%>
<%@ page import="com.zyzit.weboffice.model.AutoResponseStatusInfo" %>
<%
  AutoResponseStatusRecordBean bean = new AutoResponseStatusRecordBean(session, 30);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EMAILCAMPAIGN))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";

  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }
  List ltArray = bean.getAll(request, "responsestatuslist.jsp?");

  String sHelpTag = "AutoResponseStatuslist";
  String sTitleLinks = bean.getNavigation(request, "Auto Response Status List");

%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all auto response status and sort them.
<p>
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'responsestatuslist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" class="thCornerL">No.</th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Email", "responsestatuslist.jsp", "E-Mail")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("Status", "responsestatuslist.jsp", "Status")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("ReadCount", "responsestatuslist.jsp", "Read Count")%></th>
    <th width="12%" align="center" class="thCornerL"><%=bean.getSortNameLink("IPAddress", "responsestatuslist.jsp", "IP Address")%></th>
    <th width="17%" align="center" class="thCornerL"><%=bean.getSortNameLink("LatestReadTime", "responsestatuslist.jsp", "Latest Read Time")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("ClickTotal", "responsestatuslist.jsp", "Total Clicks")%></th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "optoutlist.jsp", "Create Date")%></th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=10>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     AutoResponseStatusInfo info = (AutoResponseStatusInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="5%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="20%"><a title="Send a email to this user"  href="../util/email.jsp?action=person&toemail=<%=info.Email%>&group=recipients"><%=info.Email%></a></td>
    <td class="row1" width="10%" align="center"><%=info.Status==1?"Success":"Failed"%></td>
    <td class="row1" width="10%" align="center"><%=info.ReadCount%></td>
    <td class="row1" width="12%" align="center"><%=Utilities.getValue(info.IPAddress)%></td>
    <td class="row1" width="17%" align="center"><%=Utilities.getDateValue(info.LatestReadTime, 19)%></td>
    <td class="row1" width="10%" align="center">
<% if (info.ClickTotal>0) { %>
<a href='responseclicklist.jsp?action=Load&statusid=<%=info.StatusID%>'><%=info.ClickTotal%></a>
<% } else { %>
   <%=info.ClickTotal%>
<% } %>
    </td>
    <td class="row1" width="16%" align="center"><%=Utilities.getDateValue(info.CreateDate, 19)%></td>
  </tr>
<%}}%>
  <tr>
    <td colspan="10" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
