<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.UserBean"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%
  UserBean bean = new UserBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_PRIVATEAREA))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Apply".equalsIgnoreCase(sAction))
  {
    UserBean.Result ret = bean.applyShare(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  String sHelpTag = "privatearea";
//  String sTitleLinks = "<b>Private Area</b>";
  String sTitleLinks = bean.getNavigation(request, "Private Area");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From here you can access all the folders (list below) in the private area. And you can share your folder with other users.
<p>
<table width="90%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="50%" align="center" height="19" class="thCornerL">Folder Name</th>
    <th width="50%" align="center" height="19" class="thCornerL">Who Own It</th>
  </tr>
<%
  List ltArray = bean.getShareUsers();
  for (int i=0; i<ltArray.size(); i++) {
    UserInfo urInfo = (UserInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="50%"><a href="../file/filelist.jsp?action=Private Area&workarea=Private&folder=<%=urInfo.Username%>"><%=urInfo.Username%></a></td>
    <td width="50%"><%=urInfo.RealName%></td>
  </tr>
<%}%>
</table>
<br>
<form name="book" action="privatearea.jsp" method="post">
<table width="90%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th class="thHead">Share My Folder</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
  <tr>
   <td>
<table cellpadding="1" cellspacing="1" border=1 width="70%" lass="forumline" align="center">
  <tr bgcolor="#9AAEDA">
    <td align="center" width="30%" height="20"><font color="#ffffff"><b>Sharing Check</b></font></td>
    <td align="center" width="70%" height="20"><font color="#ffffff"><b>User Name</b></font></td>
  </tr>
<%
  ltArray = bean.getAllUsers();
  for (int i=0; i<ltArray.size(); i++) {
  UserInfo urInfo = (UserInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="30%" align="right">
      <input type="checkbox" value="1" name="check_<%=urInfo.UserID%>" <%=bean.getAcceckCheckFlag(urInfo.UserID)%>>
    </td>
    <td class="row1" width="70%"><%=urInfo.RealName%></td>
  </tr>
<% } %>
</table>
   </td>
  </tr>
  <tr>
    <td colspan="3" height="5" class="spaceRow"></td>
  </tr>
  <tr>
    <td class="catBottom" colspan="3" align="center" height="20">
      <input type="submit" name="action" value="Apply">
    </td>
  </tr>
</table>
</form>
<%@ include file="../share/footer.jsp"%>