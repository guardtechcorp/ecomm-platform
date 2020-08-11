<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/menupage.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MenuPageBean"%>
<%@ page import="com.zyzit.weboffice.model.MenuPageInfo"%>
<%
//bean.showAllParameters(request, out);
  MenuPageBean bean = new MenuPageBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
     return;

//bean.showAllParameters(request, out);

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  MenuPageInfo info = null;
  if ("Add Menu".equalsIgnoreCase(sAction))
  {
    MenuPageBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (MenuPageInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Panel");

      response.sendRedirect("menupagelist.jsp?action=Get List");

      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Menu".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    MenuPageBean.Result ret = bean.update(request, false);
    info = (MenuPageInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Menu");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Menu";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Menu";
  }

  if (info==null)
  {
    info = MenuPageInfo.getInstance(true);
    info.Name ="User Defined";
    info.Active = 1;
    info.CanDelete = 1;
    sAction = "Add Menu";
  }

  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  String sHelpTag = "menupage";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Menu".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<a href=\"menupagelist.jsp?action=Menu List\">Menu List</a> > <b>Add a new Menu</b>";
     sDescription = "The form below will allow you to add a new Menu.";
  }
  else
  {
     sTitleLinks += "<a href=\"menupagelist.jsp?action=Get List\">Menu List</a> > <b>Edit the Menu</b>";
     sDescription = "The form below will allow you to edit & update the menu information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="menuform" action="menupage.jsp" method="post" onsubmit="return validateMenuForm(this);">
<input type="hidden" name="meunid" value="<%=info.MenuID%>">
<input type="hidden" name="name" value="<%=info.Name%>">
<input type="hidden" name="candelete" value="<%=info.CanDelete%>">
<% if (info.MenuID>=0) { %>
<table width="99%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"></td>
    <td align="right"><%=bean.getPrevNextLinks("menupage.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="99%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2"><%=info.Name%> Menu Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="20%" align="right">Title*:</td>
      <td class="row1">
        <input type="text" name="title" value="<%=Utilities.getValue(info.Title)%>" maxlength="128" style="width: 400px;"> The title of panel.
      </td>
    </tr>
<% if (info.MenuID>3||info.MenuID==-1) { %>
    <tr>
      <td class="row1" width="20%" align="right">Url</td>
      <td class="row1">
        <input type="text" name="url" value="<%=Utilities.getValue(info.URL)%>" maxlength="128" style="width: 400px;"> The url of menu will link.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Same Window:</td>
      <td class="row1">
        <select name="active">
          <option value=1 <%=bean.getSelected(0, info.Attribute)%>>Yes</option>
          <option value=0 <%=bean.getSelected(1, info.Attribute)%>>No</option>
        </select> If selects 'No', a popup window will be launched when click this menu.
      </td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="20%" align="right">Active:</td>
      <td class="row1">
        <select name="active">
          <option value=1 <%=bean.getSelected(1, info.Active)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Active)%>>No</option>
        </select> If selects 'No', this panel will not show on the more function panel.
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
<SCRIPT>onMenuFormLoad(document.menuform);</SCRIPT>
<%@ include file="../share/footer.jsp"%>