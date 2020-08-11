<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.FeedbackBean"%>
<%@ page import="com.zyzit.weboffice.model.FeedbackInfo"%>
<%@ include file="../include/pageheader.jsp"%>
<%
  FeedbackBean bean = new FeedbackBean(session, 20);

  FeedbackInfo info = null;
  if (sRealAction.startsWith("Reply"))
  {
    ret = bean.sendReply(request, mbInfo);
    info = (FeedbackInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      nDisplay = 0;
    }
    else
    {
      sDisplayMessage = (String)ret.getInfoObject();
    }
  }
  else  if (sRealAction.startsWith("Edit"))
  {
     info =  bean.get(request);
  }
  else if (sRealAction.startsWith("prev") || sRealAction.startsWith("next")||sRealAction.startsWith("goto"))
  {
     info = bean.getPrevOrNext(request, sRealAction);
  }

  if (info==null)
     info = FeedbackInfo.getInstance(true);

%>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/feedback.js"></SCRIPT>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
<tr>
  <td align="right"><%=bean.getPrevNextLinks2("index.jsp?", "_FeedbackReply", true)%>&nbsp;</td>
</tr>
<TR>
 <TD>
<form name="feedback" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onsubmit="return validateFeedback2(this, 'response');">
<input type="hidden" name="feedid" value="<%=info.FeedID%>">
<input type="hidden" name="action1" value="Reply_FeedbackReply">
<table class="table-outline" width="100%" align="center">
    <tr>
      <td class="row1" width="18%" height="12" align="right"><%=mcBean.getLabel("fb-sendername")%>: </td>
      <td class="row1" width="37%" height="12"><b><%=Utilities.getValue(info.Yourname)%></b></td>
      <td class="row1" width="15%" height="12" align="right"><%=mcBean.getLabel("cm-submitdate")%>: </td>
      <td class="row1" width="30%" height="12"><b><%=Utilities.getDateValue(info.CreateDate, 16)%></b></td>
    </tr>
    <tr>
      <td class="row1" width="18%" height="12" align="right"><%=mcBean.getLabel("cm-phone")%>: </td>
      <td class="row1" width="37%" height="12"><b><%=Utilities.getValue(info.Phone)%></b> </td>
      <td class="row1" width="15%" height="12" align="right"><%=mcBean.getLabel("cm-email")%>: </td>
      <td class="row1" width="30%" height="12"><b><%=Utilities.getValue(info.EMail)%></b></td>
    </tr>

<% if (info.CustomizedFields!=null) { %>
    <tr>
      <td class="row1" width="18%" align="right" valign="top"><%=mcBean.getLabel("fb-moreinfo")%>: </td>
      <td class="row1" width="37%" colspan="3"><%=Utilities.getValue(bean.getMoreInformation(info.CustomizedFields))%></td>
    </tr>
<% } %>
<% if (info.ResponseDate!=null) { %>
    <tr>
      <td class="row1" width="18%" height="12" align="right"><%=mcBean.getLabel("fb-respby")%>: </td>
      <td class="row1" width="37%" height="12"><b><%=Utilities.getValue(info.Sender)%></b></td>
      <td class="row1" width="15%" height="12" align="right"><%=mcBean.getLabel("cm-sentdate")%>: </td>
      <td class="row1" width="30%" height="12"><b><%=Utilities.getDateValue(info.ResponseDate, 16)%></b></td>
    </tr>
<% } %>
    <tr>
      <td colspan="4" height="5"></td>
    </tr>
    <tr>
      <td colspan="4">&nbsp;&nbsp;<%=mcBean.getLabel("fb-comment")%>: </td>
    </tr>
    <tr>
      <td colspan="4" align="center">
        <div style="width:710px; height:200px; background-color:white; overflow:auto; BORDER:#4279bd 1px dashed;" >
        <table width="100%" cellpadding="4" cellspacing="2">
        <tr>
         <td id="feedback_content" width="100%"><%=info.Content%></td>
        </tr>
        </table>
       </div>
     </td>
    </tr>
    <tr>
      <td colspan="4" height="5"></td>
    </tr>
    <tr>
      <td colspan="4">&nbsp;&nbsp;<%=mcBean.getLabel("fb-replycontent")%>: </td>
    </tr>
    <tr>
      <td colspan="4" align="center">
        <textarea id="response" name="response" rows="12" cols="87" wrap="virtual"><%=Utilities.getValue(info.Response)%></textarea>
        <script language="javascript1.2">createToolbar('response', 710, 220, ",7,15,16,17,32,");</script>
        </td>
    </tr>
    <tr>
      <td class="row1"colspan="4"><input type="checkbox" name="sendmyself" value="1"> <%=mcBean.getLabel("cm-sendself")%> (<b><%=mbInfo.EMail%></b>)
      </td>
    </tr>
    <tr>
      <td colspan="4" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="4" align="center" height="22"><input type="submit" name="submit" value="<%=mcBean.getLabel("cm-reply")%>" style="width: 100px"></td>
    </tr>
    <tr>
      <td colspan="4" height="2" class="spaceRow"></td>
    </tr>
  </table>
</form>
<SCRIPT>onFeedbackLoad(document.feedback);</SCRIPT>
</TD>
</TABLE>