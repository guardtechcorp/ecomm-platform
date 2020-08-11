<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/quickbook.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.BookBean"%>
<%@ page import="com.zyzit.weboffice.model.BookInfo"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%
  BookBean bean = new BookBean(session, 10);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_QUICKBOOK))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  BookInfo info = null;
  if ("Add Book".equalsIgnoreCase(sAction))
  {
    BookBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (BookInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "book");
      //. Change to update of adding its sub-category
      info = (BookInfo)ret.getUpdateInfo();
      sAction = "Update Book";
    }
  }
  else if ("Update Book".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    BookBean.Result ret = bean.update(request, false);
    info = (BookInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "book");
    }
  }
  else if ("edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Book";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Book";
  }

  if (info==null)
  {
    info = BookInfo.getInstance(true);
    UserInfo urInfo = (UserInfo)session.getAttribute(Definition.KEY_COMPANYUSER);
    info.UserIDs = "" + urInfo.UserID +",";
    sAction = "Add Book";
  }

  String sHelpTag = "qiuckbook";
  String sTitleLinks = "<a href=\"booklist.jsp?action=Books\">Quick Book List</a> > ";
  String sDescription;
  if ("Add Book".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Create a New Book</b>";
     sDescription = "The form below will allow you to create a new quick book.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Book Information</b>";
     sDescription = "The form below will allow you to edit and update the book information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="book" action="book.jsp" method="post" onsubmit="return validateBook(this);">
<input type="hidden" name="bookid" value="<%=info.BookID%>">
<% if (!"Add Book".equalsIgnoreCase(sAction)) { %>
<!--table width="90%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("book.jsp?")%></td>
  </tr>
</table-->
<% } %>
<table width="90%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Book Information</th>
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
      <td class="row1" height="12">The name of Book.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right" valign="top">The Description:</td>
      <td class="row1" width="31%">
        <textarea name="description" rows="3" cols="45" wrap="virtual"><%=Utilities.getValue(info.Description)%></textarea>
     </td>
      <td class="row1" valign="top">The discription of this book</td>
    </tr>
    <tr>
      <td class="row1" colspan="3" align="center"><b>Grant the Access Right to Users</b></td>
    </tr>
    <tr>
      <td class="row1" colspan="3" align="center">
        <table cellpadding="1" cellspacing="1" border=1 width="70%" lass="forumline" align="center">
          <tr bgcolor="#9AAEDA">
            <td align="center" width="30%" height="20"><font color="#ffffff"><b>Access Role</b></font></td>
            <td align="center" width="70%" height="20"><font color="#ffffff"><b>User Name</b></font></td>
          </tr>
<%
 List ltArray = bean.getAllUsers();
 for (int i=0; i<ltArray.size(); i++) {
   UserInfo urInfo = (UserInfo)ltArray.get(i);
%>
          <tr>
            <td class="row1" width="30%" align="right">
              <input type="checkbox" value="1" name="check_<%=urInfo.UserID%>" <%=bean.getRelationCheckFlag(info.UserIDs, urInfo.UserID)%>>
            </td>
            <td class="row1" width="70%"><%=urInfo.RealName%></a></td>
          </tr>
<% } %>
        </table>
      </td>
    </tr>
    <tr>
      <td colspan="3" height="5" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center" height="20">
        <input type="submit" name="action" value="<%=sAction%>">
      </td>
    </tr>
  </table>
<SCRIPT>onBookLoad(document.book);</SCRIPT>
</form>
<%@ include file="../share/footer.jsp"%>