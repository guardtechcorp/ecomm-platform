<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityUserBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityUserInfo"%>
<%
    
  CommunityUserBean bean = new CommunityUserBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";

  if ("Member List".equalsIgnoreCase(sAction))
  {
    int nTotalRecords = bean.getAll(request);
  }
  else if ("Search List".equalsIgnoreCase(sAction))
  {
//    nTotalRecords = bean.getSearchList(request);
  }
  else  if ("Delete".equalsIgnoreCase(sAction))
  {
    CommunityUserBean.Result ret = bean.delete(request);
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
  else if ("Backup".equalsIgnoreCase(sAction))
  {
    CommunityUserBean.Result ret = bean.backup(request);
    sDisplayMessage = (String)ret.getInfoObject();
  }

  List ltArray = bean.getPageList(request, "userlist.jsp?");

  String sHelpTag = "communityuserlist";
  String sTitleLinks = bean.getNavigation(request, "Member List");
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/modalwindow/dhtmlwindow.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/modalwindow/modal.js"></SCRIPT>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all community users and sort them. You can delete any of them or enter the user page to edit it.
<p>
<SCRIPT language="JavaScript" type="text/javascript">
//var googlewin=dhtmlwindow.open("googlebox", "iframe", "http://images.google.com/", "#1: Google Web site", "width=590px,height=350px,resize=1,scrolling=1,center=1", "recal")
//googlewin.onclose=function(){ //Run custom code when window is being closed (return false to cancel action):
//return window.confirm("Close window 1?")
//}
function loadSearchPage(sUrl){
  try {
   searchwin = dhtmlmodal.open('SearchBox', 'IFRAME', sUrl, 'Member Search', 'width=630px,height=320px,center=1,resize=1,scrolling=1');
  }catch(ex){}
}
</SCRIPT>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td><a href="javascript:loadSearchPage('usersearch.jsp?action=Search Member');">Search Members</a></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'userlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="7%" class="thCornerL">No.</th>
    <th width="25%" align="center" class="thCornerL"><%=bean.getSortNameLink("EMail", "userlist.jsp", "E-Mail")%></th>
    <th width="17%" align="center" class="thCornerL"><%=bean.getSortNameLink("UserCode", "userlist.jsp", "MD5 Code")%></th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("FirstName", "userlist.jsp", "First Name")%></th>
    <th width="6%" align="center" class="thCornerL"><%=bean.getSortNameLink("RefID", "userlist.jsp", "Ref")%></th>
    <!--th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Active", "userlist.jsp", "Validate")%></th-->
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "userlist.jsp", "Register Date")%></th>
    <th width="13%" align="center" class="thCornerL">Actions</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=7>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
     CommunityUserInfo info = (CommunityUserInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="7%" align="center"><a title="View or edit user profile information" href="user.jsp?action=Edit&userid=<%=info.UserID%>"><%=(info.UserID)%></a></td>
    <td class="row1" width="25%"><a title="Send a email to this user"  href="../util/email.jsp?action=person&toemail=<%=info.EMail%>&name=<%=Utilities.getValue(info.FirstName)%> <%=Utilities.getValue(info.LastName)%>&group=recipients" title="Send E-Mail"><%=info.EMail%></a></td>
    <td class="row1" width="17%"><a href="http://home.omniserve.com/<%=Utilities.getValue(info.UserCode)%>/index.html" target="_blank" title="Go to Home Page"><%=Utilities.getValue(info.UserCode)%></a></td>
    <td class="row1" width="16%"><a href="usagelist.jsp?action=Get List&userid=<%=info.UserID%>" title="View Usage"><%=Utilities.getValue(info.FirstName)%> <%=Utilities.getValue(info.LastName)%></a></td>
    <td class="row1" width="6%"><%=bean.getRefereceLink(info.RefID)%></td>
    <!--td class="row1" width="8%" align="center"><%=bean.getActiveStatus(info.Active)%></td-->
    <td class="row1" width="14%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16).substring(5)%></td>
    <td class="row1" width="13%" align="center" ><a href="storagelist.jsp?action=Get List&userid=<%=info.UserID%>&email=<%=info.EMail%>" title="View Storage Information">Storage</a>|<a onClick="return confirm('Are you sure you want to delete it?');" href="userlist.jsp?action=delete&userid=<%=info.UserID%>">Delete</a>
    </td>
  </tr>
<%}}%>
  <tr>
    <td colspan="7" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="20%"><a href='userlist.jsp?action=Backup'>Backup Now</a></td>
          <td width="80%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
