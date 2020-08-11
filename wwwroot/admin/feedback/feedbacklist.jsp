<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.FeedbackBean"%>
<%@ page import="com.zyzit.weboffice.model.FeedbackInfo"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean" %>
<%
  FeedbackBean bean = new FeedbackBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_NEWSLETTER))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }
  else if ("Delete".equalsIgnoreCase(sAction))
  {
      BasicBean.Result ret = bean.delete(request);
      if (!ret.isSuccess())
         sDisplayMessage = "Delete the record was fialed, Please try it later.";
  }
  List ltArray = bean.getAll(request, "feedbacklist.jsp?",  0);

  String sHelpTag = "feedbacklist";
  String sTitleLinks = "<b>Customer Feedback List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can get a quick view of all customer feedbacks. You can sort them. You can enter the response page to send a email to anwser him/her questions.
<!--table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="20" valign="top"><font size="2"><b>Customer Feedback List</b></font></td>
    <td width="5%"  height="20" valign="top" onmouseover="showTipHelp('feedbacklist');" onmouseout="showHideSpan('close','tiphelp');" >
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
    <td height="20" valign="top">From this page, you can get a quick view of all customer feedbacks. You can easily sort them.
     You can enter the response page to send a email to anwser him/her questions.</td>
  </tr>
</table-->
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'feedbacklist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="6%" align="center" class="thCornerL">No.</th>
    <th width="18%" align="center" class="thCornerL"><%=bean.getSortNameLink("Yourname", "feedbacklist.jsp", "Customer Name")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("Phone", "feedbacklist.jsp", "Phone No.")%></th>
    <th width="24%" align="center" class="thCornerL"><%=bean.getSortNameLink("E-Mail", "feedbacklist.jsp")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "feedbacklist.jsp", "Submit Date")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("ResponseDate", "feedbacklist.jsp", "Response Date")%></th>
    <th width="7%" align="center" class="thCornerL">Action</th>
  </tr>
  <% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="6" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
  <% } %>
  <%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     FeedbackInfo info = (FeedbackInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="6%"><%=(nStartNo+i)%></td>
    <td width="18%"><%=info.Yourname%></td>
    <td width="15%"><%=Utilities.getValue(info.Phone)%></td>
    <td width="24%"><%=Utilities.getValue(info.EMail)%></td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.ResponseDate, 16)%></td>
    <td width="7%" align="center"><a href="feedback.jsp?action=edit&feedid=<%=info.FeedID%>"><%=info.ResponseDate!=null?"View":"Response"%></a>
    | <a href="feedbacklist.jsp?action=delete&feedid=<%=info.FeedID%>" onClick="return confirm('Are you sure you want to delete this record.');">Delete</a></td>
  </tr>
  <%}%>
  <tr>
    <td colspan="7" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
<% if (ltArray==null||ltArray.size()==0){ %>
         <td width="30%">There is no any feedback available.</td>
<% }else{ %>
         <td width="30%"></td>
<% } %>
         <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
