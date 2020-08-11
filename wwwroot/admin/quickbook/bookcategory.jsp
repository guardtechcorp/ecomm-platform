<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/quickbook.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.BookCategoryBean"%>
<%@ page import="com.zyzit.weboffice.model.BookCategoryInfo"%>
<%
  BookCategoryBean bean = new BookCategoryBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_QUICKBOOK))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  BookCategoryInfo info = null;
  if ("Add Category".equalsIgnoreCase(sAction))
  {
    BookCategoryBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (BookCategoryInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "category");
      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Category".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    BookCategoryBean.Result ret = bean.update(request, false);
    info = (BookCategoryInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "book category");
    }
  }
  else if ("edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Category";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Category";
  }

  if (info==null)
  {
    info = BookCategoryInfo.getInstance(true);
    info.ForeColor = "#000000";
    sAction = "Add Category";
  }

  String sHelpTag = "bookcategory";
  String sTitleLinks = "<a href=\"booklist.jsp?action=Books\">Books</a> > <a href=\"bookcategorylist.jsp?action=Book Category&bookid=" + bean.getBookID() +"\">Book Category List</a> > ";
  String sDescription;
  if ("Add Category".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Create a Category</b>";
     sDescription = "The form below will allow you to create a new category of quick book.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Category</b>";
     sDescription = "The form below will allow you to edit and update the category of quick book.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="bookcategory" action="bookcategory.jsp" method="post" onsubmit="return validateBookCategory(this);">
<input type="hidden" name="cateid" value="<%=info.CateID%>">
<% if (!"Add Category".equalsIgnoreCase(sAction)) { %>
<table width="98%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("bookcategory.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Category of Quick Book</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="21%" align="right">Name:</td>
      <td class="row1" width="31%">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="40" size="34">
      </td>
      <td class="row1" height="12">The name of category.</td>
    </tr>
    <tr>
      <td class="row1" width="21%"align="right">The color:</td>
      <td class="row1" width="31%">
      <input type="text" name="forecolor" value="<%=Utilities.getValue(info.ForeColor)%>" maxlength="7" size="7" style="color: <%=info.ForeColor%>">
        <a href="javascript:loadSelectColor(document.bookcategory.forecolor, 2);">Select Color</a> The background color of whole website and online store.
      </td>

      <td class="row1">The display color of book item in this category.</td>
    </tr>
    <tr>
      <td colspan="3" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center" height="21">
        <input type="submit" name="action" value="<%=sAction%>">
      </td>
    </tr>
  </table>
<SCRIPT>onBookCategoryLoad(document.bookcategory);</SCRIPT>
</form>
<%@ include file="../share/footer.jsp"%>