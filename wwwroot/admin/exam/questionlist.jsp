<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ExamPassageBean"%>
<%@ page import="com.zyzit.weboffice.bean.ExamQuestionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamQuestionInfo"%>
<%
  ExamQuestionBean bean = new ExamQuestionBean(session, 24);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EXAM))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    ExamQuestionBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getAll(request, "questionlist.jsp?");

  String sHelpTag = "examquestion";
  String sTitleLinks  = "<a href=\"sectionlist.jsp?action=Section List\">Section List</a> > ";
         sTitleLinks += "<a href=\"passagelist.jsp?action=Pasage List&sectionid=" + bean.getReferenceId(ExamPassageBean.KEY_SECTIONID) +"\">Passage List</a> > ";
         sTitleLinks += "<a href=\"passage.jsp?action=Edit&passageid=" + bean.getReferenceId(ExamQuestionBean.KEY_PASSAGEID) + "\">Passage</a> > ";
         sTitleLinks += "<b>Question List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view a brief information of all question under this passage (<b><%=(String)bean.getAttribute(ExamQuestionBean.KEY_PASSAGENAME)%></b>) and you can sort them too. You can also create a new question or enter to a question page to edit its information.
<table width="80%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td><b><%=(String)bean.getAttribute(ExamPassageBean.KEY_SECTIONNAME)%></b> > <b><%=(String)bean.getAttribute(ExamQuestionBean.KEY_PASSAGENAME)%>:</b></td>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'questionlist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="80%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="10%" align="center" class="thCornerL">No.</th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("QuestionID", "questionlist.jsp", "Question")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("Score", "questionlist.jsp", "Score")%></th>
    <th width="25%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "questionlist.jsp", "Created Date")%></th>
    <th width="25%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="5" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row"><td colspan=6>There is no any records available.</td></tr>
<% } else {
int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
for (int i=0; i<ltArray.size(); i++) {
  ExamQuestionInfo info = (ExamQuestionInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" width="10%" align="center"><%=(nStartNo+i)%></td>
      <td class="row1" width="20%" align="center">Question <%=bean.getGlobalNoByID(info.QuestionID)%></td>
      <td class="row1" width="10%" align="center"><%=info.Score%></td>
      <td class="row1" width="25%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
      <td class="row1" width="25%" align="center"><a href="question.jsp?action=Edit&questionid=<%=info.QuestionID%>">Edit</a>
       | <a onClick="return confirm('Are you sure you want to delete it?');" href="questionlist.jsp?action=delete&questionid=<%=info.QuestionID%>">Delete</a>
      </td>
    </tr>
<%}}%>
    <tr>
    <td colspan="5" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="question.jsp?action=Add">Add Question</a></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
    </tr>
</table>
<%@ include file="../share/footer.jsp"%>