<%@ include file="../share/uparea.jsp"%>
<!--SCRIPT type="text/javascript" language="JavaScript1.2" src="/staticfile/admin/scripts/contenteditor.js"></SCRIPT-->
<!--script type="text/javascript" src="../../staticfile/admin/scripts/htmlarea/htmlarea.js"></script-->
<!--script type="text/javascript" src="../../staticfile/admin/scripts/htmlarea/textarea.js"></script-->
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ContentBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%
  ContentBean bean = new ContentBean(session);
//bean.showAllParameters(request, out);
//bean.dumpAllParameters(request);

  String sAction = request.getParameter("action");
  ContentInfo info;// = bean.get(request);
  String sDisplayMessage = null;
  String sClass = "successful";
  String sReturn = request.getParameter("return");
  if (sReturn!=null)
     sReturn = java.net.URLDecoder.decode(sReturn);

  if ("Update Now".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    ContentBean.Result ret = bean.update(request);
    info = (ContentInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
//      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "content");
      if (sReturn.indexOf("?")==-1)
      {
         String sFinishUrl = sReturn+"?action=finisheditcontent&name="+request.getParameter("name")+"&contentid="+info.ContentID;
         response.sendRedirect(sFinishUrl);
      }
      else
        response.sendRedirect(sReturn);
    }
  }
  else
  {
    info = bean.get(request);
  }

  String sHelpTag = "editcontent";
  String sTitleLinks = "<a href=\"" + sReturn +"\">Go Back</a> > <b>Edit the Content</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<form name="post" action="content.jsp" method="post">
  <input type="hidden" name="contentid" value="<%=info.ContentID%>">
  <input type="hidden" name="title" value="<%=request.getParameter("title")%>">
  <input type="hidden" name="name" value="<%=request.getParameter("name")%>">
  <input type="hidden" name="return" value="<%=sReturn%>">
   <table cellspacing="1" cellpadding="4" border="0" align="center" class="forumline" width="100%">
    <tr>
      <th class="thHead" align="center"><%=request.getParameter("title")%></th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <!--tr>
      <td class="row1" align="right" valign="top">
      <OBJECT id="dlg" classid="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" width="0px" height="0px"></OBJECT>
      <INPUT type="hidden" name="msg_html" value='info.Text'>
      <INPUT type="hidden" name="msg" value="">
      <IFRAME name="editor_iframe" id="editor_iframe" width="100%" height="435" onLoad="initOuterIFrame()" style="visibility: hidden" src="editor-toolbar.jsp"></IFRAME>
      </td>
    </tr-->
    <!--tr>
      <td align="left">
       <textarea id="text" name="text" style="width:830; height:390" rows="20" cols="80">info.Text</textarea>
       <script>initEditor('text');</script>
      </td>
    </tr-->
    <tr>
      <td align="left">
        <textarea id="text" name="text" style="height: 820px; width: 305px;"><%=Utilities.getValue(Utilities.convertHtml(info.Text, false))%>
        </textarea>
        <script language="javascript1.2">
         createToolbar('text', 830, 400);
         setEditorFocus('text');
        </script>
      </td>
    </tr>
    <tr>
      <td class="catBottom" align="center"><input type="submit" value="Update Now" name="action"></td>
    </tr>
  </table>
</form>
<%@ include file="../share/footer.jsp"%>