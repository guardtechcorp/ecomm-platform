<%@ include file="../share/uparea.jsp"%>
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT-->
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/page.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/staticfile/admin/scripts/calendardateinput.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.PageContentBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%
//bean.showAllParameters(request, out);
  PageContentBean bean = new PageContentBean(session, 0);

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  ContentInfo info = null;
//  int nUpdating = Utilities.getInt(request.getParameter("updating"), 0);
  if (bean.isMultiPartForm(request))
  {//. It is coming from form submitting (Add Page or Update Page)
    PageContentBean.Result ret = bean.update(request);
    sAction = ret.m_sAction;
    if (ret.isSuccess())
    {
      if ("Update Page".equalsIgnoreCase(sAction))
      {
         info = (ContentInfo)ret.getUpdateInfo();
         sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "page");
      }
      else
         sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "page");

//    Map hmParameter = (Map)ret.getInfoObject();
//    nUpdating = Utilities.getInt((String)hmParameter.get("updating"), 0);
    }
    else
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      info = (ContentInfo)ret.getUpdateInfo();
      sClass = "failed";
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Page";

//    nUpdating = 1;  //From list to updating
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Page";

//     nUpdating = 1; //From list to updating
  }
  else if ("Remove File".equalsIgnoreCase(sAction))
  {
//    info = (ContentInfo)bean.getLastInfo();
    info = (ContentInfo)bean.getCacheMap().get(bean.KEY_TEMPINFO);
    info.UploadFile = "";
    sAction = "Update Page";

    sDisplayMessage = "The file is temporarily removed and you have to click 'Update Page' button to permanently remove it.";
  }
  else if ("Change Type".equalsIgnoreCase(sAction))
  {
    if ("Update Page".equalsIgnoreCase(request.getParameter("curaction")))
    {
      info = (ContentInfo)bean.getLastInfo();
      info.Type = Utilities.getShort(request.getParameter("type"), (short)0);
      sAction = "Update Page";
    }
  }

  if (info==null)
  {
    info = ContentInfo.getInstance(true);
    info.Type = 0;
    info.Display = 0;
    if ("Change Type".equalsIgnoreCase(sAction))
    {
      info.Type = Utilities.getShort(request.getParameter("type"), (short)0);
    }

    info.Title = bean.getTitle();
    sAction = "Add Page";
  }

  String sHelpTag = "contentpage";
  String sTitleLinks = "<a href=\"pagelist.jsp?action=Page List\">Page List</a> > ";
  String sDescription;
  if ("Add Page".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a New Page</b>";
     sDescription = "The form below will allow you to add a new page.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Page</b>";
     sDescription = "The form below will allow you to edit & update the page information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="page" action="page.jsp" enctype="multipart/form-data" method="post" onsubmit="return validatePage(this);">
<input type="hidden" name="title" value="<%=info.Title%>">
<input type="hidden" name="subdir" value="pagecontent">
<% if (!"Add Page".equalsIgnoreCase(sAction)) { %>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"></td>
    <td align="right"><%=bean.getPrevNextLinks("page.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Page Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
   <tr>
    <td class="row1" width="15%" align="right">Name:</td>
    <td class="row1"><input type="text" name="name" size="80" maxlength="255" value="<%=Utilities.getValue(info.Name)%>"   > The name of content.
    </td>
   </tr>
   <tr>
    <td class="row1" width="15%" align="right">Type:</td>
    <td class="row1">
      <select name="type" onChange="onSelectTypeChange(this, '<%=sAction%>')">
        <option value=0 <%=bean.getSelected(0, info.Type)%>>Edit in Place</option>
        <option value=1 <%=bean.getSelected(1, info.Type)%>>Upload File</option>
        <option value=2 <%=bean.getSelected(2, info.Type)%>>Url Link</option>
      </select> The type of content source.
    </td>
   </tr>
   <tr>
    <td class="row1" width="15%" align="right">Show Method:</td>
    <td class="row1">
       <input type="radio" value="0" name="display" <%=info.Display==0?"CHECKED":""%>>Show the content directly.
       <input type="radio" value="1" name="display" <%=info.Display==1?"CHECKED":""%>>Show the content as a link under the name.
    </td>
   </tr>
   <tr>
    <td class="row1" width="15%" align="right">Occur Date:</td>
    <!--td class="row1">
       <input maxlength=10 name="eventdate" value="<%=Utilities.getValue(info.EventDate)%>">
       Event Occurred Date (For Example: 2001-02-28).
    </td-->
    <td class="row1">
       <script>DateInput('eventdate', true, 'YYYY-MM-DD'<%=Utilities.getValue(info.EventDate).length()==0?"":", '"+info.EventDate+"'"%>)</script>
    </td>
   </tr>
<% if (info.Type==0) {%>
    <tr>
      <!--td class="row1" width="15%" align="right" valign="top"><br>Content:</td-->
      <td colspan="2" class="row1">
        <textarea id="text" name="text" style="height: 200px; width: 500px;"><%=bean.getHtmlContet(info.Text)%>
        </textarea>
        <script language="javascript1.2">createToolbar('text', 820, 290);</script>
      </td>
    </tr>
<% } else if (info.Type==1) {%>
   <tr>
    <td class="row1" width="15%" align="right">Upload File:</td>
    <td class="row1" >
      <input type="hidden" name="uploadfile" value="<%=Utilities.getValue(info.UploadFile)%>">
      <input type="file" name="filename" size="66">
      <% if (info.UploadFile!=null&&info.UploadFile.length()>0) { %>
      &nbsp;&nbsp;<a href="page.jsp?action=Remove File">Remove</a>
      <% } %>
    </td>
   </tr>
<% } else {%>
   <tr>
    <td class="row1" width="15%" align="right">Url:</td>
    <td class="row1"><input type="text" name="linkurl" size="80" maxlength="255" value="<%=Utilities.getValue(info.LinkUrl)%>"> The Url of the content source.
    </td>
   </tr>
<% } %>
  <tr class="normal_row">
    <td colSpan=2 height=5></td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<SCRIPT>onPageLoad(document.page);</SCRIPT>
<%@ include file="../share/footer.jsp"%>