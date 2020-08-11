<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/quickbook.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/staticfile/admin/scripts/calendardateinput.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.BookItemBean"%>
<%@ page import="com.zyzit.weboffice.model.BookItemInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%
  BookItemBean bean = new BookItemBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_QUICKBOOK))
     return;
//bean.showAllParameters(request, out);
  DomainInfo dmInfo = bean.getDomainInfo();
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  BookItemInfo info = null;
  if ("Add Book Item".equalsIgnoreCase(sAction))
  {
    BookItemBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (BookItemInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "book item");
      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Book Item".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    BookItemBean.Result ret = bean.update(request, false);
    info = (BookItemInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "book item");
    }
  }
  else if ("edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Book Item";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Book Item";
  }

  if (info==null)
  {
    info = BookItemInfo.getInstance(true);
//    info.OccurDate = Utilities.getTodayDateTime();
    sAction = "Add Book Item";
  }

  String sHelpTag = "bookcategory";
  String sTitleLinks = "<a href=\"booklist.jsp?action=Books\">Books</a> > <a href=\"bookitemlist.jsp?action=Book Items&bookid=" + bean.getBookID() +"\">Book Item List</a> > ";
  String sDescription;
  if ("Add Book Item".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Create a Book Item</b>";
     sDescription = "The form below will allow you to create a new book Item.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Book Item</b>";
     sDescription = "The form below will allow you to edit and update the book item.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="bookitem" action="bookitem.jsp" method="post" onsubmit="return validateBookItem(document.bookitem, '<%=Utilities.getDateValue(dmInfo.CreateDate, 10)%>', '<%=Utilities.getDateValue(Utilities.getTodayDateTime(), 10)%>');">
<input type="hidden" name="itemid" value="<%=info.ItemID%>">
<% if (!"Add Book Item".equalsIgnoreCase(sAction)) { %>
<table width="98%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("bookitem.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Book Item</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="21%" align="right">Item Name*:</td>
      <td class="row1" width="31%">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="128" size="34">
      </td>
      <td class="row1" height="12">The name of book item.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Description:</td>
      <td class="row1" colspan="2"><textarea name="description"  rows="3" cols="70"><%=Utilities.getValue(info.Description)%></textarea>
      </td>
    </tr>
    <tr>
      <td class="row1" width="21%"align="right">Category*:</td>
      <td class="row1" width="31%">
        <select name="cateid">
          <%=bean.getCategoryList(info.CateID)%>
        </select>
<% if (info.ItemID<0) {%>
        <br><!--a href="bookcategory.jsp?itemid=<%=info.ItemID%>">Define a new category</a-->
<% } %>
     </td>
      <td class="row1">The category to which the book item belog.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Amount*:</td>
      <td class="row1" width="31%">
       <input type="text" name="amount" size="34" value="<%=Utilities.getValue(info.Amount)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
      </td>
      <td class="row1" height="15">The amount of income or expense.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Amount Type*:</td>
      <td class="row1" width="31%">
        <select name="type">
          <option value="1">Income</option>
          <option value="0">Expense</option>
        </select>
      </td>
      <td class="row1">The type of amount.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Person/Organization:</td>
      <td class="row1" width="31%">
        <input type="text" name="who" value="<%=Utilities.getValue(info.Who)%>" maxlength="128" size="34">
      </td>
      <td class="row1" height="12">Who the income came from or expense went to.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Occur Date*:</td>
      <!--td class="row1" width="31%">
        <input maxlength=10 name="when" value="<%=Utilities.convertDateValue(info.OccurDate, false)%>"
        onblur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onkeyup='autoFormat(this,"D");' size="34">
      </td-->
      <td class="row1" width="31%">
       <script>DateInput('when', true, 'YYYY-MM-DD', '<%=Utilities.getDateValue(bean.getDefaultOccurDate(info.OccurDate), 10)%>')</script>
      </td>
      <td class="row1" height="12">The event occured date.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Quantity:</td>
      <td class="row1" width="31%">
        <input type="text" name="quantity" size="34" value="<%=Utilities.getValue(info.Quantity)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      </td>
      <td class="row1">Total quantity in your stock.</td>
    </tr>
    <tr>
      <td class="row1" width="21%" align="right">Used Count:</td>
      <td class="row1" width="31%">
        <input type="text" name="usedcount" size="34" value="<%=Utilities.getValue(info.UsedCount)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      </td>
      <td class="row1" height="15">How many quantity was used.</td>
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
</form>
<SCRIPT>selectDropdownMenu(document.bookitem.type, '<%=info.Type%>');</SCRIPT>
<SCRIPT>onBookItemLoad(document.bookitem);</SCRIPT>
<%@ include file="../share/footer.jsp"%>