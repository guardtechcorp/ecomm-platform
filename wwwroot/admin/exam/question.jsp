<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/exam.js"></SCRIPT>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.bean.ExamPassageBean"%>
<%@ page import="com.zyzit.weboffice.bean.ExamQuestionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamQuestionInfo"%>
<%@ page import="com.zyzit.weboffice.model.ExamChoiceInfo"%>
<%
//bean.showAllParameters(request, out);
  ExamQuestionBean bean = new ExamQuestionBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EXAM))
     return;

//bean.dumpAllParameters(request);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  ExamQuestionInfo info = null;
  List ltChoice = null;
  String sActionLink = request.getParameter("actionlink");
  int nUpdating = Utilities.getInt(request.getParameter("updating"), 0);
  if (sActionLink!=null && sActionLink.startsWith("Delete"))
  {
    info = (ExamQuestionInfo)bean.getLastInfo();
    ExamQuestionBean.Result ret = bean.deleteChoice(request);
    sAction = "Update Question";
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  else if ("addchoice".equalsIgnoreCase(sActionLink)||"Add New Choice".equalsIgnoreCase(sAction))
  {
//bean.dumpAllParameters(request);
    info =  (ExamQuestionInfo)bean.getLastInfo();
    ExamQuestionBean.Result ret = bean.addItem(request);
    sAction = "Update Question";
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  else if ("Add Question".equalsIgnoreCase(sAction))
  {
    ExamPassageBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (ExamQuestionInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
//      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDUPDATE_SUCCESS, null).replaceAll("%s", "question");
//      info = (ExamQuestionInfo)ret.getUpdateInfo();
//      sAction = "Update Question";
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "question");
    }
  }
  else if ("Update Question".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    ExamQuestionBean.Result ret = bean.update(request, false);
    info = (ExamQuestionInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "question");
      info = (ExamQuestionInfo)ret.getUpdateInfo();
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Question";
    nUpdating = 1;
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Question";
     nUpdating = 1;
  }

  if (info==null)
  {
    info = ExamQuestionInfo.getInstance(true);
//    info.Name = Utilities.getUniqueId(10);
    info.Score = 1;
    ltChoice = bean.getDefaultChoiceList();

    sAction = "Add Question";
  }
  else
  {
    ltChoice = bean.getChoiceList(info);
  }

  String sHelpTag = "exampassage";
  String sTitleLinks = "<a href=\"sectionlist.jsp?action=Section List\">Section List</a> > ";
  sTitleLinks += "<a href=\"passagelist.jsp?action=Pasage List&sectionid=" + bean.getReferenceId(ExamPassageBean.KEY_SECTIONID) +"\">Passage List</a> > ";
  sTitleLinks += "<a href=\"passage.jsp?action=Edit&passageid=" + bean.getReferenceId(ExamQuestionBean.KEY_PASSAGEID) + "\">Passage</a> > ";
  sTitleLinks += "<a href=\"questionlist.jsp?action=Question List&passageid=" + bean.getReferenceId(ExamQuestionBean.KEY_PASSAGEID) + "\">Question List</a> > ";

  String sDescription;
  if ("Add Question".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a New Question</b>";
     sDescription = "The form below will allow you to add a new question.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Question</b>";
     sDescription = "The form below will allow you to edit & update the question information and add and/or edit choices.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="question" action="question.jsp" method="post" onsubmit="return validateQuestion(this);">
<input type="hidden" name="questionid" value="<%=info.QuestionID%>">
<input type="hidden" name="name" value="<%=Utilities.getValue(info.Name)%>">
<input type="hidden" name="updating" value="<%=nUpdating%>">
<input type="hidden" name="actionlink" value="">
<% if (nUpdating!=0) { %>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="20%"><input type="submit" name="action" value="<%=sAction%>"></td>
    <td width="50%" align="center">Question Global No: <b><%=bean.getCurrentGlobalNo()%></b></td>
    <td align="right"><%=bean.getPrevNextLinks("question.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Question Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="8%" align="right" valign="top"><br>Question:</td>
      <td class="row1">
        <textarea id="content" name="content" style="height: 310px; width: 700px;"><%=bean.getHtmlContet(info.Content)%>
        </textarea>
        <script language="javascript1.2">createToolbar('content', 760, 75, ',30,31,');</script>
      </td>
    </tr>
    <!--tr>
      <td class="row1" width="14%" align="right" valign="top">Guide/Hint:</td>
      <td class="row1">
        <textarea id="guide" name="guide" style="height: 310px; width: 700px;"><%=bean.getHtmlContet(info.Guide)%>
        </textarea>
        <script language="javascript1.2">
          createToolbar('guide', 720, 60);
        </script>
      </td>
    </tr-->
    <tr>
      <td class="row1" width="8%" align="right">Points:</td>
      <td class="row1">
        <input type="text" name="score" size=4 value="<%=Utilities.getValue(info.Score)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
        The points of this question.</td>
    </tr>
    <!--tr class="normal_row">
      <td class="spaceRow" colspan="2" height="5"></td>
    </tr-->
    <tr class="normal_row">
     <td class="row1" width="8%" align="right" valign="top">Choices:</td>
     <td>
  <table width="100%" cellpadding="0" cellspacing="1" border="0" class="forumline2" align="center">
   <tr bgcolor="#4279bd">
     <td class="catBottom1" width="3%" align="center" height="20"><font color="#ffffff">No</font></td>
     <td class="catBottom1" width="7%" align="center"><font color="#ffffff">Correct</font></td>
     <td class="catBottom1" width="82%"><font color="#ffffff">&nbsp;&nbsp;Content and Solution</font></td>
     <td class="catBottom1" align="center"><font color="#ffffff">Actions</font></td>
   </tr>
<%
  char cOrder = 'A';
  for (int i=0; ltChoice!=null&&i<ltChoice.size(); i++) {
     ExamChoiceInfo ciInfo = (ExamChoiceInfo)ltChoice.get(i);
     String sContentID = "content_" + i;
     String sSolutionID = "solution_" + i;
     String sOrder = new String(new char[] {cOrder});
     cOrder += 1;
%>
<tr class="normal_row">
  <td colspan="4">
   <table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
   <tr class="normal_row">
     <td width="3%" align="center" valign="top"><br><%=sOrder%></td>
     <td width="7%" align="center" valign="top"><br><input type="radio" value="<%=i%>" name="rightchoice" <%=ciInfo.RightChoice==1?"CHECKED":""%>>
     </td>
     <td width="81%">
      <textarea id="<%=sContentID%>" name="<%=sContentID%>" style="height: 310px; width: 700px;"><%=bean.getHtmlContet(ciInfo.Content)%>
      </textarea>
      <script language="javascript1.2">createToolbar('<%=sContentID%>', 600, 35, ',19,22,23,24,25,26,27,28,29,30,31,34,35,36,')</script>
     </td>
     <td align="center" valign="top">
<% if (!"Add Question".equalsIgnoreCase(sAction)) {%>
      <IMG border="0" align='absmiddle' src="/staticfile/admin/images/delete2.gif">&nbsp;<a href="javascript:submitForm(document.question, 'Delete_<%=ciInfo.ChoiceID%>')">Delete</a>
<% } %>
     <p>
      <DIV id="show_<%=sSolutionID%>" style="display: inline"><IMG border="0" align='absmiddle' src="/staticfile/admin/images/arrow.gif"><A onClick="showSolution('<%=sSolutionID%>', true);" href="javascript:;">Solution</A></DIV>
      <DIV id="hide_<%=sSolutionID%>" style="display: none"><IMG border="0" align='absmiddle' src="/staticfile/admin/images/arrowdown.gif"><A onClick="showSolution('<%=sSolutionID%>', false);" href="javascript:;">Solution</A></DIV>
     </td>
   </tr>
   <tr class="row2">
     <td colspan="4">
      <DIV id='TS_<%=sSolutionID%>' style='display: none'>
      <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
       <tr class="row2">
        <td width"10%" align="right" valign="top"><br>Solution:&nbsp;</td>
        <td width="90%">
         <textarea id="<%=sSolutionID%>" name="<%=sSolutionID%>" style="height: 310px; width: 700px;"><%=bean.getHtmlContet(ciInfo.Solution)%>
         </textarea>
         <script language="javascript1.2">createToolbar('<%=sSolutionID%>', 600, 60, ',19,22,23,24,25,26,27,28,29,30,31,,34,35,36,')</script>
        </td>
      </tr>
     </table>
     </DIV>
    </td>
   </tr>
</table>
</td>
</tr>
<% } %>

<% if (!"Add Question".equalsIgnoreCase(sAction)) {%>
   <tr class="normal_row">
     <td width="10%" colspan="2"></td>
     <td colspan="2"><input type="submit" name="action" value="Add New Choice">
       <!--a href="javascript:submitForm(document.question, 'addchoice')">Add New Choice</a-->
     </td>
   </tr>
<% } %>
    </table>
   </td>
  </tr>
    <tr class="normal_row">
      <td colSpan=2 height=5></td>
    </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<SCRIPT>onQuestionLoad(document.question);</SCRIPT>
<%@ include file="../share/footer.jsp"%>