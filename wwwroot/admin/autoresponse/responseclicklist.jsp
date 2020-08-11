<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.AutoResponseStatusRecordBean"%>
<%@ page import="com.zyzit.weboffice.model.AutoResponseStatusInfo" %>
<%@ page import="com.zyzit.weboffice.model.AutoResponseClickInfo" %>
<%
  AutoResponseStatusRecordBean bean = new AutoResponseStatusRecordBean(session, 30);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EMAILCAMPAIGN))
     return;

  List ltArray = bean.getUrlClickList(request);

  String sHelpTag = "AutoResponseClicklist";
  String sTitleLinks = bean.getNavigation(request, "Auto Response Url Click List");

%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all auto response url clicks.
<p>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" class="thCornerL">No.</th>
    <th width="20%" align="center" class="thCornerL">Click Url</th>
    <th width="10%" align="center" class="thCornerL">Click Count</th>
    <th width="16%" align="center" class="thCornerL">Create Date</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=10>There is no any records available.</td></tr>
<% } else {
  for (int i=0; i<ltArray.size(); i++) {
     AutoResponseClickInfo info = (AutoResponseClickInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="8%" align="center"><%=(i+1)%></td>
    <td class="row1" width="60%" align="center"><%=Utilities.getValue(info.ClickUrl)%></td>
    <td class="row1" width="10%" align="center"><%=info.ClickCount%></td>
    <td class="row1" width="12%" align="center"><%=Utilities.getDateValue(info.CreateDate, 19)%></td>
  </tr>
<%}}%>
</table>
<%@ include file="../share/footer.jsp"%>
