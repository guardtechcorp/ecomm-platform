<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/page.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/staticfile/admin/scripts/calendardateinput.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.PageContentBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%@ page import="com.zyzit.weboffice.bean.SearchPageBean" %>
<%@ page import="com.zyzit.weboffice.model.SearchPageInfo" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%
  SearchPageBean bean = new SearchPageBean(session, 20);

//bean.showAllParameters(request, out);
//  bean.dumpAllParameters(request);

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  SearchPageInfo info = null;
//  int nUpdating = Utilities.getInt(request.getParameter("updating"), 0);
    if ("Add Search Page".equalsIgnoreCase(sAction))
    {
      SearchPageBean.Result ret = bean.update(request, true);
      if (!ret.isSuccess())
      {
        info = (SearchPageInfo)ret.getUpdateInfo();
        Errors errObj = (Errors)ret.getInfoObject();
        sDisplayMessage = errObj.getError();
        sClass = "failed";
      }
      else
      {//. Continue add
        sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Search Page");
        response.sendRedirect("searchpagelist.jsp?action=Load");
      }
    }
    else if ("Update Search Page".equalsIgnoreCase(sAction))
    {
//bean.showAllParameters(request, out);
      SearchPageBean.Result ret = bean.update(request, false);
      info = (SearchPageInfo)ret.getUpdateInfo();
      if (!ret.isSuccess())
      {
        Errors errObj = (Errors)ret.getInfoObject();
        sDisplayMessage = errObj.getError();
        sClass = "failed";
      }
      else
      {
        sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Search Page");
      }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Search Page";

//    nUpdating = 1;  //From list to updating
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Search Page";

//     nUpdating = 1; //From list to updating
  }

  if (info==null)
  {
    info = SearchPageInfo.getInstance(true);
    sAction = "Add Search Page";
  }

  String sHelpTag = "searchpage";
  String sTitleLinks = "<a href=\"searchpagelist.jsp?action=Search Page List\">SearchPage List</a> > ";
  String sDescription;
  if ("Add Search Page".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a New Search Page</b>";
     sDescription = "The form below will allow you to add a new search page.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Search Page</b>";
     sDescription = "The form below will allow you to edit & update the search page information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="searchpage" action="searchpage.jsp" method="post" onsubmit="return validateSearchPage(this);">
<% if (!"Add Search Page".equalsIgnoreCase(sAction)) { %>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"></td>
    <td align="right"><%=bean.getPrevNextLinks("searchpage.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Search Page Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center" height="40"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
   <tr>
    <td class="row1" width="15%" align="right">Keyword:</td>
    <td class="row1"><input type="text" name="keyword" size="80" maxlength="255" value="<%=Utilities.getUnicode(Utilities.getValue(info.Keyword))%>">
    </td>
   </tr>
   <tr>
     <td class="row1" width="15%" align="right">Title:</td>
     <td class="row1"><input type="text" name="title" size="80" maxlength="1024" value="<%=Utilities.getUnicode(Utilities.getValue(info.Title))%>">
     </td>
   </tr>

   <!--tr>
    <td class="row1" width="15%" align="right">Type:</td>
    <td class="row1">
      <select name="type" onChange="onSelectTypeChange(this, '<%=sAction%>')">
    </td>
   </tr-->
   <tr>
     <td colspan="2" class="row1">Description:</td>
   </tr>
    <tr>
      <!--td class="row1" width="15%" align="right" valign="top"><br>Content:</td-->
      <td colspan="2" class="row1">
        <textarea id="text" name="description" style="height: 200px; width: 500px;"><%=Utilities.getUnicode(bean.getHtmlContet(info.Description))%>
        </textarea>
        <script language="javascript1.2">createToolbar('text', 820, 290);</script>
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
<SCRIPT>onSearchPageLoad(document.searchpage);</SCRIPT>
<%@ include file="../share/footer.jsp"%>