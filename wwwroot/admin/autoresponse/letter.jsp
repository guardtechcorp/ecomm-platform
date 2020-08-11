<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.AutoResponseLetterBean"%>
<%@ page import="com.zyzit.weboffice.model.AutoResponseLetterInfo"%>
<%
  AutoResponseLetterBean bean = new AutoResponseLetterBean(session, 24);
//bean.showAllParameters(request, out);
//bean.dumpAllParameters(request);

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  AutoResponseLetterInfo info = null;
  int nUpdating = Utilities.getInt(request.getParameter("updating"), 0);
  if ("Add Message".equalsIgnoreCase(sAction))
  {
    AutoResponseLetterBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (AutoResponseLetterInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "message");
      response.sendRedirect("letterlist.jsp?action=Letter List");
    }
  }
  else if ("Update Message".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    AutoResponseLetterBean.Result ret = bean.update(request, false);
    info = (AutoResponseLetterInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "message");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Message";

    nUpdating = 1;  //From list to updating
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Message";

     nUpdating = 1; //From list to updating
  }
  else if ("Test Mail".equalsIgnoreCase(sAction))
  {
/*
    int nRet = bean.testMail(request);
    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(nRet);
    response.flushBuffer();
    return;
*/
      AutoResponseLetterBean.Result ret = bean.sendTestMail(request);
      info = (AutoResponseLetterInfo)ret.getUpdateInfo();
      if (!ret.isSuccess())
      {
        Errors errObj = (Errors)ret.getInfoObject();
        sDisplayMessage = errObj.getError();
        sClass = "failed";
      }
      else
      {
        sDisplayMessage = "Sending a testing mail is successful";
      }

      sAction = "Update Message";
      nUpdating = 1; //From list to updating
  }

  if (info==null)
  {
    info = AutoResponseLetterInfo.getInstance(true);
    info.Day = 1;
    info.Content = "Hello [$name$],<br>";
    sAction = "Add Message";
  }

  String sHelpTag = "editemailletter";
  String sTitleLinks;// = "<a href=\"responselist.jsp?action=Response List\">Autoresponder Group List</a> > <a href=\"letterlist.jsp?action=Letter List\">Message List</a> > ";
  String sDescription;
  if ("Add Message".equalsIgnoreCase(sAction))
  {
//     sTitleLinks += "<b>Add a Message</b>";
     sTitleLinks = bean.getNavigation(request, "Add a Message");
     sDescription = "The form below will allow you to add a new Message. ";
  }
  else
  {
//     sTitleLinks += "<b>Edit the Message</b>";
     sTitleLinks = bean.getNavigation(request, "Edit the Message");
     sDescription = "The form below will allow you to edit & update the Message information. ";
  }
  sDescription += "You can use the tag [$name$] to be a placeholder in the content to replace the name of the customers, subscribers or members when send the e-mail to them.";
%>
<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/autoresponse.js"></SCRIPT>
<!--SCRIPT type="text/javascript" language="JavaScript1.2" src="/staticfile/admin/scripts/contenteditor.js"></SCRIPT-->
<!--script type="text/javascript" src="/staticfile/admin/scripts/htmlarea/htmlarea.js"></script-->
<!--script type="text/javascript" src="/staticfile/admin/scripts/htmlarea/textarea.js"></script-->
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="letterform" action="letter.jsp" method="post" onsubmit="return validateLetterForm(this);">
  <input type="hidden" name="letterid" value="<%=info.LetterID%>">
<% if (info.LetterID>=0) { %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" align="center">
  <tr>
    <td width="30%"></td>
    <td align="right"><%=bean.getPrevNextLinks("letter.jsp?")%></td>
  </tr>
</table>
<% } %>
  <table cellspacing="1" cellpadding="2" border="0" align="center" class="forumline" width="100%">
    <tr>
      <th colspan=2 class="thHead" align="center">Message</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="12%" align="right">Days Delay:</td>
      <td class="row1">
       <input type="text" name="day" value="<%=Utilities.getValue(info.Day)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
       How many days this email will be sent to customers, subscribers or members.
      </td>
    </tr>
    <tr>
     <td class="row1" width="12%" align="right">Name:</td>
     <td class="row1">
      <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="128" style="width: 480px;"> The name of the mail (Internal use)
     </td>
    </tr>
    <tr>
      <td class="row1" width="12%" align="right">Subject:</td>
      <td class="row1">
        <input type="text" name="subject" value="<%=Utilities.getValue(info.Subject)%>" maxlength="128" style="width: 480px;"> The subject of the mail.
      </td>
    </tr>
    <!--tr>
      <td class="row1" align="right" valign="top">
      <OBJECT id="dlg" classid="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" width="0px" height="0px"></OBJECT>
      <INPUT type="hidden" name="msg_html" value='info.Content'>
      <INPUT type="hidden" name="msg" value="">
      <IFRAME name="editor_iframe" id="editor_iframe" width="100%" height="435" onLoad="initOuterIFrame()" style="visibility: hidden" src="editor-toolbar.jsp"></IFRAME>
      </td>
    </tr-->
    <!--tr>
      <td colspan=2 align="left">
       <textarea id="content" name="content" style="width:820; height:305" rows="20" cols="80">Utilities.getValue(Utilities.convertHtml(info.Content, false)></textarea>
       <script>initEditor('content');</script>
      </td>
    </tr-->
    <tr>
      <td colspan="2" class="row1" align="center">
        <textarea id="content" name="content" style="height: 780px; width: 305px;"><%=Utilities.getValue(Utilities.convertHtml(info.Content, false))%>
        </textarea>
        <script language="javascript1.2">
         createToolbar('content', 816, 252);
         //setEditorFocus('content');
        </script>
      </td>
    </tr>
    <tr>
      <td colspan=2 class="catBottom" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
      <!--td colspan=2 class="catBottom" align="center"><input type="submit" name="action" value="<%=sAction%>" onclick="return validateTaskForm(document.taskform);"></td-->
    </tr>
  </table>
</form>
<form name="testform" action="letter.jsp" method="post" onsubmit="return validateTestMailForm(document.letterform, this);">
<input type="hidden" name="letterid" value="<%=info.LetterID%>">
<input type="hidden" name="subject" value="">
<input type="hidden" name="emailcontent" value="">
<input type="hidden" name="action" value="Test Mail">
<table cellspacing="1" cellpadding="1" border="0" align="center" class="forumline" width="100%">
  <tr>
    <th colspan=2 class="thHead" align="center">Send this message to myself for testing</th>
  </tr>
  <tr>
    <td class="row1" width="12%" align="right">Your Name:</td>
    <td class="row1" >
     <input type="text" name="yourname" value="" style="width: 200px;"> E-Mail:
     <input type="text" name="email" value="" style="width: 350px;"> <input type="submit" name="submit" value="Send">
    </td>
  </tr>
</table>
</form>
<SCRIPT>onLetterFormLoad(document.letterform);</SCRIPT>
<%@ include file="../share/footer.jsp"%>