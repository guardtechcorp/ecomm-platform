<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.CategoryInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberCategoryBean" %>
<%
{
    MemberCategoryBean bean = new MemberCategoryBean(session, 20);

    CategoryInfo info = null;
    if (sRealAction.startsWith("Edit")) {
        info = bean.get(request);
//Utilities.dumpObject(info);
    } else if (sRealAction.startsWith("prev") || sRealAction.startsWith("next")) {
        info = bean.getPrevOrNext(sRealAction);
//System.out.println("cgInfo = "+ cgInfo);
    } else if (sRealAction.startsWith("Add") || sRealAction.startsWith("Update")) {
        if (!ret.isSuccess()) {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            info = (CategoryInfo) ret.getUpdateInfo();
            nDisplay = 0;
        } else {
            info = (CategoryInfo) ret.getUpdateInfo();
            if (sRealAction.startsWith("Update"))
                sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "category information");
            else {
                sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "category");
                info = null;
            }
        }
    }

    if (info == null) {
        info = CategoryInfo.getInstance(true);
        info.Active = Definition.ACCESSMODE_PUBLIC;
        info.Reference = 0;
        info.LayoutID = 1;
        info.BackColor = "#ffffff";
        info.RowsPerPage = 10;
        info.SortOrder = 0;

        sRealAction = "Add";
    } else
        sRealAction = "Update";

//Utilities.dumpObject(info);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/product.js" type="text/javascript"></SCRIPT>
<TABLE cellpadding="0" cellspacing="0" border="0">
 <TR>
   <TD height="1">
   <%@ include file="../include/information.jsp"%>
  </TD>
 </TR>
 <TR>
  <TD>
  <table width="100%" cellpadding="0" cellspacing="1" border="0" align="center">
   <tr>
    <td>&nbsp;Fields marked with an asterisk * are required</td>
    <td align="right">
<% if (info.CategoryID>0) { %>
     <%=bean.getPrevNextLinks("index.jsp?", "_Category", true)%>&nbsp;
<% } %>
    </td>
   </tr>
  </table>
 </TD>
</TR>
<TR>
 <TD>
<FORM name="form_category" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateCategory(this);">
<input type="hidden" name="categoryid" value="<%=info.CategoryID%>">
<input type="hidden" name="action1" value="">
<table class="table-outline" width="100%" align="center">
    <tr>
      <td class="row1" width="17%" align="right">* Name:</td>
      <td class="row1" width="48%">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" class="post" maxlength="30" size="30">
      </td>
      <td class="row1">The name of category.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right" valign="top">Description:</td>
      <td class="row1" width="48%">
        <textarea rows="4" cols="40" wrap="virtual" name="description"><%=Utilities.getValue(info.Description)%></textarea>
      </td>
      <td class="row1" valign="top">Text for this category. It will appear on the top of each page of product list.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Display Layout:</td>
      <td class="row1" width="48%" >
        <select name="layoutid">
          <%=bean.getLayoutList(info.LayoutID)%>
        </select>
        <a href="javascript:viewSampleImage('Category', document.form_category.layoutid.value)">View sample layout</a></td>
      <td class="row1">The display layout of products in this category.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Background Color:</td>
      <td class="row1" width="48%">
       <input type="text" name="backcolor" value="<%=Utilities.getValue(info.BackColor)%>" maxlength="7" size="7" style="color: <%=info.BackColor%>" onClick="javascript:loadSelectColor(this, 2);">
      </td>
      <td class="row1">The background color of products displaying in this screen.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Max Rows/Page:</td>
      <td class="row1" width="48%">
        <input type="text" name="rowsperpage" value="<%=Utilities.getValue(info.RowsPerPage)%>" maxlength="6" size="4" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      </td>
      <td class="row1">The max products will display on each page.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Sort By:</td>
      <td class="row1" width="48%">
       <select name="sortfieldname">
        <option value="" <%=bean.getSelected("", info.SortFieldName)%>>Default given by system</option>
        <option value="Name" <%=bean.getSelected("Name", info.SortFieldName)%>>Name/Title</option>
        <option value="Price" <%=bean.getSelected("Price", info.SortFieldName)%>>Product Price</option>
        <option value="CreateDate" <%=bean.getSelected("CreateDate", info.SortFieldName)%>>Added Date and Time</option>
        <option value="ModifyDate" <%=bean.getSelected("ModifyDate", info.SortFieldName)%>>Modified Date and Time</option>
        <option value="VisitTime" <%=bean.getSelected("VisitTime", info.SortFieldName)%>>Visited Times</option>
       </select>&nbsp;
        <input type="radio" value="0" name="sortorder" <%=bean.getChecked(0, info.SortOrder)%>>Ascending
        <input type="radio" value="1" name="sortorder" <%=bean.getChecked(1, info.SortOrder)%>>Descending
      </td>
      <td class="row1"></td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Accessed By:</td>
      <td class="row1" width="48%">
       <select name="active">
        <%=bean.getAccessOption(info.Active, 0)%>
       </select>
      </td>
      <td class="row1">If selects 'Nobody', this category will not show on website.</td>
    </tr>
    <tr>
     <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
    </tr>
    <tr>
     <td class="row1" width="17%" align="right">&nbsp;</td>
     <td class="row1" colspan="2">
      <input type="submit" name="submit" style='width:120px' value="<%=sRealAction%>" onClick="setAction(document.form_category, this.value+'_Category');">
      </td>
    </tr>
  </table>
</FORM>
<SCRIPT>onCategoryFormLoad(document.form_category);</SCRIPT>
  </TD>
 </TR>
</TABLE>    
<% } %>