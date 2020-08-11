<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityFavoriteBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityFavoriteInfo"%>
<%

  CommunityFavoriteBean bean = new CommunityFavoriteBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  if ("delete".equalsIgnoreCase(sAction))
  {
    CommunityFavoriteBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
       Errors errObj = (Errors)ret.getInfoObject();
       session.setAttribute(Defination.KEY_DISPLAYMESSAGE, errObj.getError());
       session.setAttribute(Defination.KEY_DISPLAYLINK, "Click <a href=\"javascript:history.go(-1);\">Here</a> to return to the user list page.");
       response.sendRedirect("../share/information.jsp");
     }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  String sRange = (String)request.getParameter("range");
  List ltArray = bean.getAll(request,  "favoritelist.jsp?");

  String sHelpTag = "favoritelist";
  String sTitleLinks = "<a href=\"userlist.jsp?action=User List\">User List</a> > <b>Favorite List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all favorites of this user.
<p>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'favoritelist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="7%" class="thCornerL">No.</th>
    <th width="28%" align="center" class="thCornerL"><%=bean.getSortNameLink("Title", "favoritelist.jsp")%></th>
    <th width="11%" align="center" class="thCornerL"><%=bean.getSortNameLink("Category", "favoritelist.jsp")%></th>
    <th width="30%" align="center" class="thCornerL"><%=bean.getSortNameLink("Url", "favoritelist.jsp")%></th>
    <th width="14%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "favoritelist.jsp", "Create Date")%></th>
    <th width="10%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=7>There is no any records available.</td></tr>
<% } else {
  int nStartNo = Utilities.getInt((String)session.getAttribute(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
    CommunityFavoriteInfo info = (CommunityFavoriteInfo)ltArray.get(i);
%>
  <tr>
    <td class="row1" width="7%" align="center"><%=(nStartNo+i)%></td>
    <td class="row1" width="28%" align="center"><%=Utilities.getValue(info.Title)%></td>
    <td class="row1" width="11%" align="center"><%=Utilities.getValue(info.Category)%></td>
    <td class="row1" width="30%" align="left"><%=Utilities.getValue(info.Url)%></td>
    <td class="row1" width="14%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td class="row1" width="10%" align="center" ><a href="#">Edit</a> |
    <a onClick="return confirm('Are you sure you want to delete it?');" href="favoritelist.jsp?action=delete&favoriteid=<%=info.FavoriteID%>">Delete</a>
    </td>
  </tr>
<%}}%>
  <tr>
    <td colspan="7" class="catBottom">
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
