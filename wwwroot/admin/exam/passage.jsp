<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/exam.js"></SCRIPT>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamPassageBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamPassageInfo"%>
<%
//bean.showAllParameters(request, out);

  ExamPassageBean bean = new ExamPassageBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EXAM))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  ExamPassageInfo info = null;
  int nUpdating = Utilities.getInt(request.getParameter("updating"), 0);
  if ("Add Passage".equalsIgnoreCase(sAction))
  {
    ExamPassageBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (ExamPassageInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDUPDATE_SUCCESS, null).replaceAll("%s", "passage");
      //. Change to update of adding its sub-category
      info = (ExamPassageInfo)ret.getUpdateInfo();
      sAction = "Update Passage";
      nUpdating = -1;  //From list to updating
    }
  }
  else if ("Update Passage".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    ExamPassageBean.Result ret = bean.update(request, false);
    info = (ExamPassageInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "passage");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Passage";

    nUpdating = 1;  //From list to updating
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Passage";

     nUpdating = 1; //From list to updating
  }

  if (info==null)
  {
    info = ExamPassageInfo.getInstance(true);
    info.Cols = 1; // One column
    info.Lable = 1;
    info.Random = 0;  // No Random Pick
    sAction = "Add Passage";
  }

  String sHelpTag = "exampassage";
  String sTitleLinks = "<a href=\"sectionlist.jsp?action=Section List\">Section List</a> > ";
  sTitleLinks += "<a href=\"passagelist.jsp?action=Pasage List&sectionid=" + bean.getReferenceId(ExamPassageBean.KEY_SECTIONID) +"\">Passage List</a> > ";
  String sDescription;
  if ("Add Passage".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a New Passage</b>";
     sDescription = "The form below will allow you to add a new passage.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Passage</b>";
     sDescription = "The form below will allow you to edit & update the passage information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="passage" action="passage.jsp" method="post" onsubmit="return validatePassage(this);">
<input type="hidden" name="sectionid" value="<%=info.SectionID%>">
<input type="hidden" name="updating" value="<%=nUpdating%>">
<% if (nUpdating!=0) { %>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"><a href="questionlist.jsp?action=Question List&passageid=<%=info.PassageID%>&passagename=<%=info.Name%>">Question List</a></td>
    <td align="right"><%=nUpdating==1?bean.getPrevNextLinks("passage.jsp?"):""%></td>
  </tr>
</table>
<% } %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Passage Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="15%" align="right">Name:</td>
      <td class="row1">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="128" style="width: 400px;"> The name of this passage.
      </td>
    </tr>
    <!--tr>
      <td class="row1" width="15%" align="right">Columns:</td>
      <td class="row1">
        <select name="cols" style="width: 180px;">
          <option value=1 <%=bean.getSelected(1, info.Cols)%>>One Column</option>
          <option value=2 <%=bean.getSelected(2, info.Cols)%>>Two Columns</option>
          <option value=3 <%=bean.getSelected(3, info.Cols)%>>Three Columns</option>
          <option value=4 <%=bean.getSelected(4, info.Cols)%>>Four Columns</option>
        </select>The vertical columns to show questions in each page.
      </td>
    </tr-->
    <!--tr>
      <td class="row1" width="15%" align="right">List by:</td>
      <td class="row1">
        <select name="lable" style="width: 180px;">
          <option value=1 <%=bean.getSelected(1, info.Lable)%>>A, B, C, ...</option>
          <option value=2 <%=bean.getSelected(2, info.Lable)%>>1, 2, 3, ...</option>
        </select>The numbered list of choices in each question.
      </td>
    </tr-->
    <tr>
      <!--td class="row1" width="15%" align="right" valign="top">Content:</td-->
      <td colspan="2" class="row1">
        <textarea id="content" name="content" style="height: 200px; width: 500px;"><%=bean.getHtmlContet(info.Content)%>
        </textarea>
        <script language="javascript1.2">
         createToolbar('content', 820, 360);
        </script>
      </td>
    </tr>
    <TR class="normal_row">
      <TD colSpan=2 height=5></TD>
    </TR>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<SCRIPT>onPassageLoad(document.passage);</SCRIPT>
<%@ include file="../share/footer.jsp"%>