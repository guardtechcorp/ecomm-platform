<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/exam.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<%
//bean.showAllParameters(request, out);
  ExamSectionBean bean = new ExamSectionBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EXAM))
     return;

//bean.showAllParameters(request, out);

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  ExamSectionInfo info = null;
  if ("Add Section".equalsIgnoreCase(sAction))
  {
    ExamSectionBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (ExamSectionInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "section");
      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Section".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    ExamSectionBean.Result ret = bean.update(request, false);
    info = (ExamSectionInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "section");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Section";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Section";
  }

  if (info==null)
  {
    info = ExamSectionInfo.getInstance(true);
    info.ShowPos = 1; // Show left side
    info.BackColor = "#FFFFFF";
    info.Random = 0;  // No Random Pick
    info.GradeRanges = "90-100=A;80-90=B;70-80=C;60-70=D;50-60=E;0-50=F";
    sAction = "Add Section";
  }

  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  String sHelpTag = "examsection";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Section".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<a href=\"sectionlist.jsp?action=Section List\">Section List</a> > <b>Add a New Section</b>";
     sDescription = "The form below will allow you to add a new section.";
  }
  else
  {
     sTitleLinks += "<a href=\"sectionlist.jsp?action=Section List\">Section List</a> > <b>Edit the Secton</b>";
     sDescription = "The form below will allow you to edit & update the section information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="section" action="section.jsp" method="post" onsubmit="return validateSection(this);">
<input type="hidden" name="sectionid" value="<%=info.SectionID%>">
<% if (!"Add Section".equalsIgnoreCase(sAction)) { %>
<table width="99%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"><!--a href="passagelist.jsp?action=Passage List&sectionid=<%=info.SectionID%>">Passage List</a--></td>
    <td align="right"><%=bean.getPrevNextLinks("section.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="99%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Section Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="15%" align="right">Name:</td>
      <td class="row1">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="128" style="width: 400px;"> The name of section.
      </td>
    </tr>
    <tr>
      <td class="row1" width="15%" align="right" valign="top">Description:</td>
      <td class="row1">
        <textarea rows="2" style="width: 400px;" wrap="virtual" name="description"><%=Utilities.getValue(info.Description)%></textarea> The Description for this section.
      </td>
    </tr>
    <!--tr>
      <td class="row1" width="15%" align="right">Show Content On:</td>
      <td class="row1">
        <select name="showpos" style="width: 180px;">
          <option value=1 <%=bean.getSelected(1, info.ShowPos)%>>On Left Side</option>
          <option value=2 <%=bean.getSelected(2, info.ShowPos)%>>On Right Side</option>
          <option value=0 <%=bean.getSelected(0, info.ShowPos)%>>Not Show</option>
        </select>The guide content can be display on left, right or not show at all.
      </td>
    </tr-->
     <tr>
      <td class="row1" width="15%" align="right">Background Color:</td>
      <td class="row1" width="50%"><input type="text" name="backcolor" value="<%=Utilities.getValue(info.BackColor)%>" maxlength="7" size="7" style="color: <%=info.BackColor%>">
        <a href="javascript:loadSelectColor(document.section.backcolor, 2);">Select Color</a> The background color of entire section pages.
      </td>
    </tr>
    <tr>
     <td class="row1" width="15%" align="right">Score Range:</td>
     <td class="row1" width="50%"><input type="text" name="graderanges" value="<%=Utilities.getValue(info.GradeRanges)%>" maxlength="255" style="width: 400px;">
      The grade level of score percentage.
     </td>
    </tr>
    <tr>
     <td class="row1" width="15%" align="right">Exam/Practice Time:</td>
     <td class="row1" width="50%"><input type="text" name="maxtime" value="<%=Utilities.getValue(info.MaxTime)%>" size="10" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      The exam or practice time in minutes. If it is zero, no timer is displayed to limit testing time.
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
<SCRIPT>onSecontLoad(document.section);</SCRIPT>
<%@ include file="../share/footer.jsp"%>