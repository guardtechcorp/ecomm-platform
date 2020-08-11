<!--SCRIPT type="text/javascript" language="JavaScript1.2" src="/staticfile/admin/scripts/contenteditor.js"></SCRIPT-->
<!--script type="text/javascript" src="../../staticfile/admin/scripts/htmlarea/htmlarea.js"></script-->
<!--script type="text/javascript" src="../../staticfile/admin/scripts/htmlarea/textarea.js"></script-->
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ContentBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage" %>
<%
{
    ContentBean bean = new ContentBean(session);
//bean.dumpAllParameters(request);
    ContentInfo info;// = bean.get(request);
    if (sRealAction.startsWith("Update"))
    {
//bean.showAllParameters(request, out);
        if (!ret.isSuccess())
        {
           Errors errObj = (Errors) ret.getInfoObject();
           sDisplayMessage = errObj.getError();
           nDisplay = 0;
        }
        else
        {
           sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "site setting");
        }
        info = (ContentInfo) ret.getUpdateInfo();
    }
    else
    {
        info = bean.get(request);
    }

//Utilities.dumpObject(info);
%>
 <form name="post" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post">
  <input type="hidden" name="contentid" value="<%=info.ContentID%>">
  <input type="hidden" name="action1" value="Update_HtmlEditor">
  <table cellspacing="0" cellpadding="0" border="0" align="center" class="forumline" width="99%" style="border: 0px solid #DFDFDF">
    <!--tr>
      <td class="row1" align="right" valign="top">
      <OBJECT id="dlg" classid="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" width="0px" height="0px"></OBJECT>
      <INPUT type="hidden" name="msg_html" value='info.Text'>
      <INPUT type="hidden" name="msg" value="">
      <IFRAME name="editor_iframe" id="editor_iframe" width="100%" height="435" onLoad="initOuterIFrame()" style="visibility: hidden" src="editor-toolbar.jsp"></IFRAME>
      </td>
    </tr-->
    <tr>
      <td align="left">
        <textarea id="text" name="text"><%=Utilities.getValue(Utilities.convertHtml(info.Text, false))%>
        </textarea>
        <script language="javascript1.2">
         createToolbar('text', 710, 400, ",15,16,17,");
         setEditorFocus('text');
        </script>
      </td>
    </tr>
    <tr>
     <td class="catBottom" align="center" height="15"></td>
    </tr>
    <tr>
      <td class="catBottom" align="center"><input type="submit" value="Update" name="submit" style='width:120px'></td>
    </tr>
    <tr>
      <td class="catBottom" align="center" height="15"></td>
    </tr>
  </table>
</form>
<% } %>