<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ForumRegisterBean"%>
<%@ page import="com.zyzit.weboffice.model.RegisterInfo"%>
<%
  ForumRegisterBean bean = new ForumRegisterBean(session, 24);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_FORUM_USER))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    ForumRegisterBean.Result ret = bean.delete(request);
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

  int nTotal = bean.getAll(request);
  List ltArray = bean.getPageList(request);

  String sHelpTag = "registerlist";
  String sTitleLinks = "<b>Register User List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view a brief information of all registered user and you can sort them. You can enter to the email page to send a email to this user.
<!--table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="20" valign="top"><font size="2"><b>Register User List</b></font></td>
    <td width="5%"  height="20" valign="top" onmouseover="showTipHelp('registerlist');" onmouseout="showHideSpan('close','tiphelp');" >
     <a href="javascript:;" class="helplink"><IMG src="/staticfile/admin/images/quickhelp.gif" width=14 height=16 align="CENTER" border="0">Help</a>
    </td>
  </tr>
  <tr>
    <td height="1" valign="top" colspan="2">
     <DIV id="tiphelp" style="DISPLAY: none">
     <table width="100%" cellpadding="4" cellspacing="0" class="infobox">
      <tr>
       <td bgcolor="#FFFFCC"><DIV id="tipcontent"></DIV></td>
      </tr>
     </table>
     </DIV>
    </td>
  </tr>
  <tr>
    <td height="20" valign="top">From this page, you can view a brief information of all registered user and you can easily sort them.
    You can enter to the email page to send a email to this user.
    </td>
  </tr>
</table-->
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'registerlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("username", "registerlist.jsp", "User Name")%></th>
    <th width="28%" align="center" class="thCornerL"><%=bean.getSortNameLink("user_email", "registerlist.jsp", "E-Mail")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("user_occ", "registerlist.jsp", "Occuption")%></th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("user_website", "registerlist.jsp", "Company")%></th>
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
  RegisterInfo info = (RegisterInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" width="6%" align="center"><%=(nStartNo+i)%></td>
      <td class="row1" width="20%"><%=info.username%></td>
      <td class="row1" width="28%"><a href="../util/email.jsp?action=person&toemail=<%=info.user_email%>&name=<%=info.username%>&group=recipients&return=../forum/registerlist.jsp&display=Forum User List" title="Email to <%=info.user_email%>"><%=info.user_email%></a></td>
      <td class="row1" width="20%"><%=Utilities.getValue(info.user_occ)%></td>
      <td class="row1" width="16%" align="center"><%=Utilities.getValue(info.user_website)%></td>
      <td class="row1" width="10%" align="center"><%=bean.getActions(info)%></td>
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