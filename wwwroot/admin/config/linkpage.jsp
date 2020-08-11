<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/linkpage.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.LinkPageBean"%>
<%@ page import="com.zyzit.weboffice.model.LinkPageInfo"%>
<%
  LinkPageBean bean = new LinkPageBean(session, 100, false);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
//     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  LinkPageInfo info = null;

  if (bean.isMultiPartForm(request))
  {//. It is coming from form submitting (Add Page or Update Page)
    LinkPageBean.Result ret = bean.update(request);
    sAction = ret.m_sAction;
    //. Update tracing table
    bean.updateAccessHit(request, LinkPageBean.WEBHIT_ADMIN, sAction);

    if (ret.isSuccess())
    {
      info = (LinkPageInfo)ret.getUpdateInfo();
      if ("Update Link".equalsIgnoreCase(sAction))
      {
//        info = (LinkPageInfo)ret.getUpdateInfo();
        sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "link");
      }
      else
      {
        sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "link");
        response.sendRedirect("linkpagelist.jsp?action=Get List");
      }
    }
    else
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      info = (LinkPageInfo)ret.getUpdateInfo();
      sClass = "failed";
    }
  }
  else
  {
    if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
        return;

    if ("Edit".equalsIgnoreCase(sAction))
    {
      info =  bean.get(request);
      sAction = "Update Link";
    }
    else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
    {
      info =  bean.getPrevOrNext(sAction);
      sAction = "Update Link";
    }
    else if ("Remove File".equalsIgnoreCase(sAction))
    {
//    info = (ContentInfo)bean.getLastInfo();
      info = (LinkPageInfo)bean.getCacheMap().get(bean.KEY_TEMPINFO);
      info.UploadFile = "";
      sAction = "Update Link";

      sDisplayMessage = "The file is temporarily removed and you have to click 'Update Link' button to permanently remove it.";
    }
    else if ("Change Type".equalsIgnoreCase(sAction))
    {
      if ("Update Link".equalsIgnoreCase(request.getParameter("curaction")))
      {
        info = (LinkPageInfo)bean.getLastInfo();
        info.Type = Utilities.getShort(request.getParameter("type"), (short)0);
        sAction = "Update Link";
      }
    }
  }

  if (info==null)
  {
    info = LinkPageInfo.getInstance(true);
    info.Name ="User Defined";
    info.Attribute = 1;
    info.Active = 1;
    info.CanDelete = 1;
    info.Type = 0;
    if ("Change Type".equalsIgnoreCase(sAction))
    {
      info.Type = Utilities.getShort(request.getParameter("type"), (short)0);
    }
//System.out.println("nType=" + info.Type +"," + );
    sAction = "Add Link";
  }

  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  String sHelpTag = "linkpage";
  String sTitleLinks = "<a href=\"javascript:history.go(-2)\">Site Settings</a> > <a href=\"linkpagelist.jsp?action=Get List\">Link Page List</a> > ";
  if ("2".equalsIgnoreCase(bean.getReferenceId()))
    sTitleLinks = "<a href=\"wizard5.jsp?action=Wizard 5\">Setup Wizard</a>";
  else
    sTitleLinks = "<a href=\"config.jsp?action=Site Settings\">Site Settings</a>";
  sTitleLinks += " > <a href=\"linkpagelist.jsp?action=Get List\">Link Page List</a> > ";

  String sDescription;
  if ("Add Link".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a new Link</b>";
     sDescription = "The form below will allow you to add a new link page.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Link</b>";
     sDescription = "The form below will allow you to edit & update the link page information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="linkform" action="linkpage.jsp" enctype="multipart/form-data" method="post" onsubmit="return validateLinkForm(this);">
<input type="hidden" name="linkid" value="<%=info.LinkID%>">
<input type="hidden" name="name" value="<%=info.Name%>">
<input type="hidden" name="candelete" value="<%=info.CanDelete%>">
<input type="hidden" name="attribute" value="<%=info.Attribute%>">
<input type="hidden" name="subdir" value="pagecontent">
<% if (info.CanDelete==0) { %>
<input type="hidden" name="type" value="<%=info.Type%>">
<% } %>
<% if (info.LinkID>=0) { %>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"></td>
    <td align="right"><%=bean.getPrevNextLinks("linkpage.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2"><%=info.Name%> Link Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="20%" align="right">Title:</td>
      <td class="row1">
        <input type="text" name="title" value="<%=Utilities.getValue(info.Title)%>" maxlength="128" style="width: 450px;"> The title of link.
      </td>
    </tr>
<% if ("Tell-Friends".equalsIgnoreCase(info.Name)) { %>
    <tr>
      <td class="row1" width="20%" align="right" valign="top">Email Content:</td>
      <td class="row1">
        <textarea name="content" rows="20" cols="80" wrap="virtual"><%=Utilities.getValue(info.Content)%></textarea>
      </td>
    </tr>
<% } %>
<% if (info.CanDelete!=0) { %>
   <tr>
    <td class="row1" width="20%" align="right">Type:</td>
    <td class="row1">
      <select name="type" onChange="onSelectTypeChange(this, '<%=sAction%>')">
        <option value=0 <%=bean.getSelected(0, info.Type)%>>Edit in Place</option>
        <option value=1 <%=bean.getSelected(1, info.Type)%>>Upload File</option>
        <option value=2 <%=bean.getSelected(2, info.Type)%>>Url Link</option>
      </select> The type of content source.
    </td>
   </tr>
<% if (info.Type==0) {%>
    <tr>
      <td colspan="2" class="row1" align="center">
        <textarea id="content" name="content" style="height: 200px; width: 500px;"><%=bean.getHtmlContent(info.Content)%>
        </textarea>
        <script language="javascript1.2">createToolbar('content', 820, 290);</script>
      </td>
    </tr>
<% } else if (info.Type==1) {%>
   <tr>
    <td class="row1" width="15%" align="right">Upload File:</td>
    <td class="row1" >
      <input type="hidden" name="uploadfile" value="<%=Utilities.getValue(info.UploadFile)%>">
      <input type="file" name="filename" style="width: 534px;">
      <% if (info.UploadFile!=null&&info.UploadFile.length()>0) { %>
      &nbsp;&nbsp;<a href="linkpage.jsp?action=Remove File">Remove</a>
      <% } %>
    </td>
   </tr>
<% } else {%>
   <tr>
    <td class="row1" width="15%" align="right">Link Url:</td>
    <td class="row1"><input type="text" name="linkurl" style="width: 450px;" maxlength="255" value="<%=Utilities.getValue(info.LinkUrl)%>"> The Url of the content source.
    </td>
   </tr>
<% } %>
    <tr>
      <td class="row1" width="20%" align="right">Same Window:</td>
      <td class="row1">
        <select name="attribute">
          <option value=1 <%=bean.getSelected(1, info.Attribute)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Attribute)%>>No</option>
        </select> If selects 'No', a popup window will be launched when click this link.
      </td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="20%" align="right">Active:</td>
      <td class="row1">
        <select name="active">
          <option value=1 <%=bean.getSelected(1, info.Active)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Active)%>>No</option>
        </select> If selects 'No', this link will not show on the Link Page panel.
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
<SCRIPT>onLinkFormLoad(document.linkform);</SCRIPT>
<%@ include file="../share/footer.jsp"%>