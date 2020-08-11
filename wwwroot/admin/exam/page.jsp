<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/exam.js"></SCRIPT>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamPageBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%
//bean.showAllParameters(request, out);
  ExamPageBean bean = new ExamPageBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EXAM))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  ContentInfo info = null;
  int nUpdating = Utilities.getInt(request.getParameter("updating"), 0);
  if ("Add Page".equalsIgnoreCase(sAction))
  {
    ExamPageBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (ContentInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "page");
      //. Change to update of adding its sub-category
//      info = (ExamPassageInfo)ret.getUpdateInfo();
//      sAction = "Update Passage";
      response.sendRedirect("pagelist.jsp?action=Page List&sectionid=" + bean.getReferenceId(ExamPageBean.KEY_SECTIONID));
      return;
    }
  }
  else if ("Update Page".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    ExamPageBean.Result ret = bean.update(request, false);
    info = (ContentInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "page");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Page";

    nUpdating = 1;  //From list to updating
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Page";

     nUpdating = 1; //From list to updating
  }

  if (info==null)
  {
    info = ContentInfo.getInstance(true);
//    info.Name = Utilities.getUniqueId(10);
    info.Title = ExamPageBean.KEY_PAGEPREFIX + bean.getReferenceId(ExamPageBean.KEY_SECTIONID);
    sAction = "Add Page";
  }

  String sHelpTag = "exampage";
  String sTitleLinks = "<a href=\"sectionlist.jsp?action=Section List\">Section List</a> > ";
  sTitleLinks += "<a href=\"pagelist.jsp?action=Page List&sectionid=" + bean.getReferenceId(ExamPageBean.KEY_SECTIONID) +"\">Page List</a> > ";
  String sDescription;
  if ("Add Page".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a New Page</b>";
     sDescription = "The form below will allow you to add a new page.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Page</b>";
     sDescription = "The form below will allow you to edit & update the page information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="page" action="page.jsp" method="post" onsubmit="return validatePage(this);">
<!--input type="hidden" name="name" value="<%=info.Name%>"-->
<input type="hidden" name="title" value="<%=info.Title%>">
<input type="hidden" name="updating" value="<%=nUpdating%>">
<% if (nUpdating!=0) { %>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"></td>
    <td align="right"><%=bean.getPrevNextLinks("page.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Page Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="12%" align="right">Name:</td>
      <td class="row1">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="128" style="width: 400px;"> The name of this page.
      </td>
    </tr>
    <tr>
      <!--td class="row1" width="15%" align="right" valign="top"><br>Content:</td-->
      <td colspan="2" class="row1" align="center">
        <textarea id="text" name="text" style="height: 200px; width: 500px;"><%=bean.getHtmlContet(info.Text)%>
        </textarea>
        <script language="javascript1.2">
         createToolbar('text', 820, 365);
         setEditorFocus('text');
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
<SCRIPT>onPageLoad(document.page);</SCRIPT>
<%@ include file="../share/footer.jsp"%>