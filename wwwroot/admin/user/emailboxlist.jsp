<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.EmailBoxBean"%>
<%@ page import="com.zyzit.weboffice.model.EmailBoxInfo"%>
<%
  EmailBoxBean bean = new EmailBoxBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EMAILBOX))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    EmailBoxBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  else  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request, "emailboxlist.jsp?");

  String sHelpTag = "emailboxlist";
  String sTitleLinks = "<b>E-Mail Box List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can get a quick view of all E-Mail Boxes. You can sort them. You can enter the E-Mail Box page to add a new or edit an exsiting E-Mail.
<br>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'emailboxlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL">No.</th>
    <th width="30%" align="center" class="thCornerL"><%=bean.getSortNameLink("name", "emailboxlist.jsp", "E-Mail Address")%></th>
    <th width="25%" align="center" class="thCornerL">Owner Name</th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Type", "emailboxlist.jsp")%></th>
    <th width="7%" align="center" class="thCornerL"><%=bean.getSortNameLink("Active", "emailboxlist.jsp")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "emailboxlist.jsp", "Create Date")%></th>
    <th width="10%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="6" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
  <%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     EmailBoxInfo info = (EmailBoxInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="5%" align="center"><%=(nStartNo+i)%></td>
    <td width="30%"><%=Utilities.getValue(info.Name)%>@<%=bean.getEmailDomain()%></td>
    <td width="25%"><%=bean.getOwnerName(info)%></td>
    <td width="8%" align="center"><font color='<%=info.Type==1?"black":"green"%>'><%=info.Type==1?"Normal":"Forward"%></font></td>
    <td width="7%" align="center"><font color='<%=info.Active==1?"black":"red"%>'><%=info.Active==1?"Yes":"No"%></font></td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="10%" align="center"><a href="emailbox.jsp?action=edit&emailid=<%=info.EmailID%>">Edit</a>
    | <a href="emailboxlist.jsp?action=delete&emailid=<%=info.EmailID%>" onClick="return confirm('Are you sure you want to delete this E-Mail box.');">Delete</a></td>
  </tr>
  <%}%>
  <tr>
    <td colspan="7" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
         <td width="30%"><a href="emailbox.jsp?action=addemailbox">Add New E-Mail</a></td>
         <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
