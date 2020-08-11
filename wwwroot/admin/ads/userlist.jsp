<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.UserBean"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%
  UserBean bean = new UserBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_USER))
     return;

//  DomainInfo dmInfo = bean.getDomainInfo();
//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  if ("delete".equalsIgnoreCase(sAction))
  {
    UserBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
       Errors errObj = (Errors)ret.getInfoObject();
       session.setAttribute(Definition.KEY_DISPLAYMESSAGE, errObj.getError());
       session.setAttribute(Definition.KEY_DISPLAYLINK, "Click <a href=\"javascript:history.go(-1);\">Here</a> to return to the user list page.");
       response.sendRedirect("../share/information.jsp");
     }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  //String sRange = (String)request.getParameter("range");
  List ltUser = bean.getAll(request);

  String sHelpTag = "userlist";
  String sTitleLinks = "<b>User List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all users and sort them. You can delete any of them or enter the user page to add a new user or edit it.
<p>
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'userlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="4%" class="thCornerL">No.</th>
    <th width="19%" align="center" class="thCornerL"><%=bean.getSortNameLink("Username", "userlist.jsp")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("RealName", "userlist.jsp", "Real Name")%></th>
    <th width="12%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "userlist.jsp", "Register Date")%></th>
    <th width="8%" align="center" class="thCornerL">Total Points</th>
    <th width="7%" align="center" class="thCornerL">Spent</th>
    <th width="20%" align="center" class="thCornerL">Action</th>
    <th width="6%" align="center" class="thCornerL">Delete</th>
  </tr>
<%
  int nStartNo = Utilities.getInt((String)session.getAttribute(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltUser.size(); i++) {
  UserInfo urInfo = (UserInfo)ltUser.get(i);
%>
  <tr>
    <td class="row1"><%=(nStartNo+i)%></td>
    <td class="row1"><%=urInfo.Username%></td>
    <td class="row1"><%=Utilities.getValue(urInfo.RealName)%></td>
    <td class="row1" align="center"><%=Utilities.getDateValue(urInfo.CreateDate, 10)%></td>
    <td class="row1" align="center"></td>
    <td class="row1" align="center"></td>
    <td class="row1" align="center"><a href="user.jsp?action=Edit&userid=<%=urInfo.UserID%>">Profile</a>,
     <a href="setting.jsp?action=Edit&userid=<%=urInfo.UserID%>">Setting</a>,
     <a href="historylist.jsp?action=view&userid=<%=urInfo.UserID%>">History</a>,
     <a href="statistics.jsp?action=view&userid=<%=urInfo.UserID%>">Summery</a>
    </td>
    <td class="row1" align="center"><%=bean.getDeleteLink(urInfo)%></td>
  </tr>
  <%}%>

    <tr>
      <td class="row1"></td>
      <td class="row1"></td>
      <td class="row1"></td>
      <td class="row1" align="center"></td>
      <td class="row1" align="center"></td>
      <td class="row1" align="center"></td>
      <td class="row1" align="center">
        <a href="historylist.jsp?action=view&userid=-10">History for All</a>,
        <a href="statistics.jsp?action=view&userid=-10">Summary for All</a>
      </td>
      <td class="row1" align="center"></td>
    </tr>
  <tr>
    <td colspan="10" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="10%" nowrap><a href="user.jsp?action=adduser">Add New User</a></td>
          <td width="40%" align="right">
          </td>
          <td width="50%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
