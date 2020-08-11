<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/verticalpanel.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.VerticalPanelBean"%>
<%@ page import="com.zyzit.weboffice.model.VerticalPanelInfo"%>
<%
//bean.showAllParameters(request, out);
  VerticalPanelBean bean = new VerticalPanelBean(session, 0, false);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  VerticalPanelInfo info = null;
  if ("Add Panel".equalsIgnoreCase(sAction))
  {
    VerticalPanelBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (VerticalPanelInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Panel");

      response.sendRedirect("verticalpanellist.jsp?action=Get List");

      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Panel".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    VerticalPanelBean.Result ret = bean.update(request, false);
    info = (VerticalPanelInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Panel");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Panel";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Panel";
  }

  if (info==null)
  {
    info = VerticalPanelInfo.getInstance(true);
    info.Name ="User Defined";
    info.Active = 1;
    info.CanDelete = 1;
    sAction = "Add Panel";
  }

  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  String sHelpTag = "verticalpanel";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Panel".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<a href=\"config.jsp?action=Site Settings\">Site Settings</a> > <a href=\"verticalpanellist.jsp?action=Panel List\">Vertical Panel List</a> > <b>Add a New Panel</b>";
     sDescription = "The form below will allow you to add a new panel.";
  }
  else
  {
     sTitleLinks += "<a href=\"config.jsp?action=Site Settings\">Site Settings</a> > <a href=\"verticalpanellist.jsp?action=Panel List\">Vertical Panel List</a> > <b>Edit the Panel</b>";
     sDescription = "The form below will allow you to edit & update the panel information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="panelform" action="verticalpanel.jsp" method="post" onsubmit="return validatePanelForm(this);">
<input type="hidden" name="panelid" value="<%=info.PanelID%>">
<input type="hidden" name="name" value="<%=info.Name%>">
<input type="hidden" name="candelete" value="<%=info.CanDelete%>">
<% if (info.PanelID>=0) { %>
<table width="99%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"></td>
    <td align="right"><%=bean.getPrevNextLinks("verticalpanel.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="99%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2"><%=info.Name%> Panel Information</th>
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
<% if ("Category".equals(info.Name)) { %>
    <tr>
      <td class="row1" width="20%" align="right">Category Menu:</td>
      <td class="row1">
        <select name="layout">
          <%=bean.getLayoutList(info.Layout, "CategoryMenu")%>
        </select> The Layout of Category Menu. You can <a href="javascript:viewSampleMenu(document.panelform, 'CategoryMenu')">view</a> sample category menu layout.
      </td>
    </tr>
<% } %>
<% if ("Site-News".equals(info.Name)) { %>
    <tr>
      <td class="row1" width="20%" align="right">Site News Display:</td>
      <td class="row1">
        <select name="layout">
          <option value=1 <%=bean.getSelected(1, info.Layout)%>>On Vertical Panel</option>
          <option value=2 <%=bean.getSelected(2, info.Layout)%>>Floating in Center</option>
        </select> You can <a href="../util/content.jsp?contentid=<%=info.ContentID%>&name=NewsAreaID&title=Site News&return=<%=URLEncoder.encode("../config/verticalpanel.jsp?action=edit&panelid="+info.PanelID)%>">Edit</a> the content.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">The content scrolling:</td>
      <td class="row1">
         <select name="attribute">
          <option value=1 <%=bean.getSelected(1, info.Attribute)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Attribute)%>>No</option>
        </select> The new content can automatically move up or not move.
      </td>
    </tr>
<% } %>
<% if ("Link-Page".equals(info.Name)) { %>
    <tr>
      <td class="row1" width="20%" align="right" height="25">Link Pages:</td>
      <td class="row1"><a href='../config/linkpagelist.jsp?action=Get List' target='main'>Enter Link Page List</a>
      </td>
    </tr>
<% } %>
  <tr>
    <td class="row1" width="20%" align="right">Active:</td>
    <td class="row1">
      <select name="active">
        <option value=1 <%=bean.getSelected(1, info.Active)%>>Yes</option>
        <option value=0 <%=bean.getSelected(0, info.Active)%>>No</option>
      </select> If selects 'No', this panel will not show on the vertical panel.
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
<SCRIPT>onPanelFormLoad(document.panelform);</SCRIPT>
<%@ include file="../share/footer.jsp"%>