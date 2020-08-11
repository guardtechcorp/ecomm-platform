<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/category.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.CategoryBean"%>
<%@ page import="com.zyzit.weboffice.model.CategoryInfo"%>
<%
  CategoryBean bean = new CategoryBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_PRODUCT))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  boolean bSuccessful = true;
  String sDisplayMessage = null;
  String sClass = "successful";
  CategoryInfo cgInfo = null;
  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  if ("Add Category".equalsIgnoreCase(sAction))
  {
    CategoryBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      cgInfo = (CategoryInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
      bSuccessful = false;
    }
    else
    {//. Continue add
//      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "category");
      //. Change to update of adding its sub-category
      cgInfo = (CategoryInfo)ret.getUpdateInfo();
      sAction = "Update Category";
    }
  }
  else if ("Update Category".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    CategoryBean.Result ret = bean.update(request, false);
    cgInfo = (CategoryInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
      bSuccessful = false;
    }
    else
    {
      if (cgInfo.Reference>=0)
         sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "category");
      else
      {
        response.sendRedirect(sReturn);//"../config/config.jsp");
      }
    }
  }
  else if ("Add >>".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    cgInfo = bean.updateSelection(request, true);
    sAction = "Update Category";
  }
  else if ("<< Remove".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    cgInfo = bean.updateSelection(request, false);
    sAction = "Update Category";
  }
  else if ("editcategory".equalsIgnoreCase(sAction))
  {
    cgInfo =  bean.get(request);
    sAction = "Update Category";
  }
  else if ("editspecialcategory".equalsIgnoreCase(sAction))
  {
    cgInfo =  bean.getSpecial(request);
    sAction = "Update Category";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     cgInfo =  bean.getPrevOrNext(sAction);
     sAction = "Update Category";
  }

  if (cgInfo==null)
  {
    cgInfo = CategoryInfo.getInstance(true);
    cgInfo.Active = 1;
    cgInfo.Reference = 0;
    cgInfo.LayoutID = 1;
    cgInfo.BackColor = "#ffffff";
    cgInfo.RowsPerPage = 10;
    sAction = "Add Category";
  }

  String sHelpTag = "category";
  String sTitleLinks = "";
  if (sReturn!=null)
    sTitleLinks = "<a href=\"" + sReturn +"\">" + sDisplay + "</a> > ";
  String sDescription;
  if ("Add Category".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a New Category</b>";
     sDescription = "The form below allows you to create a new categeory.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Category</b>";
     sDescription = "The form below allows you to edit and update the category information. You can also enter its sub-category list.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="category" action="category.jsp" method="post" onsubmit="return validateCategory(this);">
  <input type="hidden" name="categoryid" value="<%=cgInfo.CategoryID%>">
  <input type="hidden" name="reference" value="<%=cgInfo.Reference%>">
  <input type="hidden" name="sequence" value="<%=cgInfo.Sequence%>">
  <input type="hidden" name="return" value="<%=Utilities.getValue(sReturn)%>">
  <input type="hidden" name="display" value="<%=Utilities.getValue(sDisplay)%>">

<% if (!"Add Category".equalsIgnoreCase(sAction)) { %>
<% if (cgInfo.Reference>=0) { %>
<table width="99%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="50%"><a href="subcategorylist.jsp?action=sublist&maincategoryid=<%=cgInfo.CategoryID%>&return=<%=sReturn%>&display=<%=sDisplay%>">Go to Sub-Category List</a></td>
    <td align="right"><%=bean.getPrevNextLinks("category.jsp?return="+sReturn+"&display="+sDisplay+"&")%></td>
  </tr>
</table>
<% } %>
<% } %>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Category Settings</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="18%" align="right">Name:*</td>
      <td class="row1" width="50%">
        <input type="text" name="name" value="<%=Utilities.getValue(cgInfo.Name)%>" class="post" maxlength="30" size="30">
      </td>
      <td class="row1">The name of category.</td>
    </tr>
    <tr>
      <td class="row1" width="18%" align="right" valign="top">Description:</td>
      <td class="row1" width="50%">
        <textarea rows="4" cols="50" wrap="virtual" name="description"><%=Utilities.getValue(cgInfo.Description)%></textarea>
      </td>
      <td class="row1" valign="top">Text for this category. It will appear on the top of each page of product list.</td>
    </tr>
    <tr>
      <td class="row1" width="18%" align="right">Display Layout:</td>
      <td class="row1" width="50%" >
        <select name="layoutid">
          <%=bean.getLayoutList(cgInfo.LayoutID)%>
        </select>
        <a href="javascript:viewSampleImage(document.category, 'Category')">View sample layout</a></td>
      <td class="row1">The display layout of products in this category.</td>
    </tr>
    <tr>
      <td class="row1" width="18%" align="right">Background Color:</td>
      <td class="row1" width="50%">
       <input type="text" name="backcolor" value="<%=Utilities.getValue(cgInfo.BackColor)%>" maxlength="7" size="7" style="color: <%=cgInfo.BackColor%>">
       <a href="javascript:loadSelectColor(document.category.backcolor, 2);">Select Color</a>
      </td>
      <td class="row1">The background color of products displaying in this screen.</td>
    </tr>
    <tr>
      <td class="row1" width="18%" align="right">Max Rows Per Page:</td>
      <td class="row1" width="50%">
        <input type="text" name="rowsperpage" value="<%=Utilities.getValue(cgInfo.RowsPerPage)%>" maxlength="6" size="4" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      </td>
      <td class="row1">The max products will display on each page.</td>
    </tr>
    <tr>
      <td class="row1" width="18%" align="right">Active:</td>
      <td class="row1" width="50%">
        <select name="active">
            <option value=0 <%=bean.getSelected(0, cgInfo.Active)%>>No</option>
            <option value=1 <%=bean.getSelected(1, cgInfo.Active)%>>Show for Visitors</option>
            <option value=2 <%=bean.getSelected(2, cgInfo.Active)%>>Show only for Logged Customers</option>
            <option value=3 <%=bean.getSelected(3, cgInfo.Active)%>>Show only for Logged Members</option>
        </select>
      </td>
      <td class="row1">If selects 'No', this category will not show on website.</td>
    </tr>
<% if (!"Add Category".equalsIgnoreCase(sAction) && cgInfo.Reference>=0) { %>
    <!--tr>
      <td class="row1" width="18%" align="right">&nbsp;</td>
      <td class="row1" width="50%">
        <a href="subcategorylist.jsp?action=sublist&maincategoryid=<%=cgInfo.CategoryID%>&return=<%=sReturn%>&display=<%=sDisplay%>">Go to Sub-Category List</a>
      </td>
      <td class="row1">Add more sub-category or edit the existing sub-category.</td>
    </tr-->
<% } %>
    <tr>
      <td colspan="3" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center" height="21">
        <input type="submit" name="action" value="<%=sAction%>">
      </td>
    </tr>
</table>
<SCRIPT>onCategoryLoad(document.category);</SCRIPT>
<% if (cgInfo.CategoryID>=0 && cgInfo.Reference>=0) { %>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th colspan="3" class="thHead" align="center"><b>Add/Remove Products to/from the Category</b></th>
  </tr>
  <tr class="normal_row">
      <td width="46%" valign="top">Available Products:<br>
        <select name="available" size="9" multiple style="WIDTH: 345px">
         <%=bean.getProductList(cgInfo.CategoryID, false)%>
        </select>
      </td>
      <td width="8%" valign="top">
     <table width="100%" cellspacing="1" border="0" class="forumline1" align="center">
      <tr>
        <td colspan="3" height="15"></td>
      </tr>
      <tr>
        <td width="1%"></td>
        <td width="98%" align="center"><input type="submit" name="action" value="Add >>" style="WIDTH:90px" onClick="return validateSelections(document.category.available);"></td>
        <td width="1%"></td>
      </tr>
      <tr>
        <td colspan="3" height="30">Hold down the Shift or Ctrl key and click on the items you want to select. Each item clicked is selected.</td>
      </tr>
      <tr>
        <td width="1%"></td>
        <td width="98%" align="center" nowrap><input type="submit" name="action" value="<< Remove" style="WIDTH:90px" onClick="return validateSelections(document.category.selection);"></td>
        <td width="1%"></td>
      </tr>
     </table>
    </td>
      <td width="46%" valign="top">Selected Products:<br>
        <!--iframe src="productselection.jsp" name="vFrameSelect" id="vFrameSelect" width="370" height="275" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe-->
        <select name="selection" size="9" multiple style="WIDTH:345px">
         <%=bean.getProductList(cgInfo.CategoryID, true)%>
        </select>
      </td>
  </tr>
</table>
<% } %>
</form>
<%@ include file="../share/footer.jsp"%>