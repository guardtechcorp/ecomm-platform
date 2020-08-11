<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<%
  ExamSectionBean bean = new ExamSectionBean(session, 1000);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EXAM))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    ExamSectionBean.Result ret = bean.delete(request);
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

  List ltArray = bean.getAll(request, "sectionlist.jsp?");

  String sHelpTag = "examsectionlist";
  String sTitleLinks = "<b>Section List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page gives you a brief view of all the sections. You can create a new section or enter to an existing section to edit its information.
<p>
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<%
  for (int i=0; ltArray!=null && i<ltArray.size(); i+=3) {
    ExamSectionInfo info = (ExamSectionInfo)ltArray.get(i);
%>
<tr><td>
<table cellspacing=1 cellpadding=1 width="100%" border=0 align="center">
  <tr>
    <td valign="top" width="33%">
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign="top" width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/admin/images/book-icon.gif" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks1">
             <li><a href="pagelist.jsp?action=Page List&sectionid=<%=info.SectionID%>">Page List</a></li>
             <li><a href="passagelist.jsp?action=Passage List&sectionid=<%=info.SectionID%>&sectionname=<%=info.Name%>">Passage List</a></li>
             <br>
             <li><a href="<%=bean.getPreviewUrl(info.SectionID)%>" target="_blank">Preview</a></li>
             <li><a href="section.jsp?action=Edit&sectionid=<%=info.SectionID%>">Edit</a></li>
             <li><a href="sectionlist.jsp?action=Delete&sectionid=<%=info.SectionID%>" onClick="return confirm('Are you sure you want to delete it.');">Delete</a></li>
           </ul>
          </td>
        </tr>
      </table>
    </td>
    <td valign="top" width="34%">
<% if (i+1<ltArray.size()) {
  info = (ExamSectionInfo)ltArray.get(i+1);
%>
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign=top width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/admin/images/book-icon.gif" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks1">
             <li><a href="pagelist.jsp?action=Page List&sectionid=<%=info.SectionID%>">Page List</a></li>
             <li><a href="passagelist.jsp?action=Passage List&sectionid=<%=info.SectionID%>&sectionname=<%=info.Name%>">Passage List</a></li>
             <br>
             <li><a href="<%=bean.getPreviewUrl(info.SectionID)%>" target="_blank">Preview</a></li>
             <li><a href="section.jsp?action=Edit&sectionid=<%=info.SectionID%>">Edit</a></li>
             <li><a href="sectionlist.jsp?action=Delete&sectionid=<%=info.SectionID%>" onClick="return confirm('Are you sure you want to delete it.');">Delete</a></li>
           </ul>
          </td>
        </tr>
      </table>
<% } %>
    </td>
    <td valign="top" width="33%">
<% if (i+2<ltArray.size()) {
  info = (ExamSectionInfo)ltArray.get(i+2);
%>
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign="top" width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/admin/images/book-icon.gif" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks1">
             <li><a href="pagelist.jsp?action=Page List&sectionid=<%=info.SectionID%>">Page List</a></li>
             <li><a href="passagelist.jsp?action=Passage List&sectionid=<%=info.SectionID%>&sectionname=<%=info.Name%>">Passage List</a></li>
             <br>
             <li><a href="<%=bean.getPreviewUrl(info.SectionID)%>" target="_blank">Preview</a></li>
             <li><a href="section.jsp?action=Edit&sectionid=<%=info.SectionID%>">Edit</a></li>
             <li><a href="sectionlist.jsp?action=Delete&sectionid=<%=info.SectionID%>" onClick="return confirm('Are you sure you want to delete it.');">Delete</a></li>
           </ul>
          </td>
        </tr>
      </table>
<% } %>
    </td>
  </tr>
</table>
</td></tr>
<% } %>
<tr>
<td><br><a href="section.jsp?action=Add">Create a New Section</a></td>
</tr>
</table>
<%@ include file="../share/footer.jsp"%>
