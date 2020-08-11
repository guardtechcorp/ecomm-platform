<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.NewsletterBean"%>
<%@ page import="com.zyzit.weboffice.model.NewsletterInfo"%>
<%
  NewsletterBean bean = new NewsletterBean(session, 20);
  if (!(bean.canAccessPage(request, response, AccessRole.ROLE_NEWSLETTER|AccessRole.ROLE_COMMUNITY)))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "failed";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    if (!bean.delete(request))
       sDisplayMessage = "Delete the record was fialed, Please try it later.";
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  int nTotalRecords = bean.getAll(request);
  List ltArray = bean.getPageList(request);

  String sHelpTag = "newsletterlist";
  String sTitleLinks = bean.getNavigation(request, "NewsLetter Mail List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can get a quick view of all newsletter mail list. You can sort them or delete any of them. You can enter the email page to send a email to this person.
<p>
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'newsletterlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="28%" align="center" class="thCornerL"><%=bean.getSortNameLink("EMail", "newsletterlist.jsp", "E-Mail")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("Yourname", "newsletterlist.jsp", "Name")%></th>
    <th width="12%" align="center" class="thCornerL"><%=bean.getSortNameLink("Subscribe", "newsletterlist.jsp", "Send Out")%></th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "newsletterlist.jsp", "Create Date")%></th>
    <th width="15%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="6" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>    
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=9>There is no any records available.</td></tr>
<% } else {
    
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     NewsletterInfo info = (NewsletterInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="6%" align="center"><%=(nStartNo+i)%></td>
    <td width="28%"><a href="../util/email.jsp?action=person&toemail=<%=info.EMail%>&name=<%=Utilities.getValue(info.Yourname)%>&group=recipients&return=../feedback/newsletterlist.jsp&display=Newsletter Subscriber List" title="Email to <%=info.EMail%>"><%=info.EMail%></a></td>
    <td width="20%"><%=info.Yourname%></td>
    <td width="12%" align="center"><%=bean.getCheckedValue(info.Subscribe)%></td>
    <td width="18%" align="center"><%=Utilities.getDateValue(info.CreateDate, 19)%></td>
    <td width="15%" align="center"><a title="Edit the Mail Receiver" href="newsletter.jsp?action=Edit&newslid=<%=info.NewslID%>">Edit</a>
    | <a href="newsletterlist.jsp?action=delete&newslid=<%=info.NewslID%>" onClick="return confirm('Are you sure you want to delete this record.');">Delete</a></td>
  </tr>
<% } %>
<% } %>
  <tr>
    <td colspan="7" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
         <td width="30%"><a href="newsletter.jsp?action=Add">Add Mail Receiver</a></td>
         <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>