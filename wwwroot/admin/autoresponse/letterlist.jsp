<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.AutoResponseLetterBean"%>
<%@ page import="com.zyzit.weboffice.model.AutoResponseLetterInfo"%>
<%@ page import="com.zyzit.weboffice.database.AutoResponse" %>
<%
  AutoResponseLetterBean bean = new AutoResponseLetterBean(session, 24);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EMAILCAMPAIGN))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    AutoResponseLetterBean.Result ret = bean.delete(request);
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
//AutoResponse.doAutoResponse("www.omniserve.com");      
  }

  List ltArray = bean.getAll(request, "letterlist.jsp?");

  String sHelpTag = "letterlist";
//  String sTitleLinks = "<a href=\"responselist.jsp?action=Response List\">Autoresponder Group List</a> > <b>Message List</b>";
  String sTitleLinks = bean.getNavigation(request, "Message List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view a brief information of all the E-Mail letter for auto-response. You can create a new message or enter to a message page to edit its information.
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'letterlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Name", "letterlist.jsp", "Name")%></th>
    <th width="29%" align="center" class="thCornerL"><%=bean.getSortNameLink("Subject", "letterlist.jsp", "Subject")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("Day", "letterlist.jsp", "Days Delay")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "letterlist.jsp", "Create Date")%></th>
    <th width="10%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="4" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=6>There is no any records available.</td></tr>
<% } else {
int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
for (int i=0; i<ltArray.size(); i++) {
  AutoResponseLetterInfo info = (AutoResponseLetterInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" width="6%" align="center"><%=(nStartNo+i)%></td>
      <td class="row1" width="20%"><%=info.Name%></td>
      <td class="row1" width="29%"><%=info.Subject%></td>
      <td class="row1" width="10%" align="center"><%=info.Day%></td>
      <td class="row1" width="15%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
      <td class="row1" width="10%" align="center"><a href="letter.jsp?action=Edit&letterid=<%=info.LetterID%>">Edit</a>
       | <a onClick="return confirm('Are you sure you want to delete it?');" href="letterlist.jsp?action=delete&letterid=<%=info.LetterID%>">Delete</a>
      </td>
    </tr>
<%}}%>
    <tr>
    <td colspan="6" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="letter.jsp?action=Add">Add a Message</a></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
    </tr>
</table>
<%@ include file="../share/footer.jsp"%>