<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/feedback.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.FeedbackBean"%>
<%@ page import="com.zyzit.weboffice.model.FeedbackInfo"%>
<%
  FeedbackBean bean = new FeedbackBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_NEWSLETTER))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  FeedbackInfo info = null;
  if ("Send Now".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    FeedbackBean.Result ret = bean.update(request, false);
    info = (FeedbackInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = (String)ret.getInfoObject();
    }
  }
  else if ("edit".equalsIgnoreCase(sAction))
  {
     info =  bean.get(request);
//System.out.println("cgInfo = "+ cgInfo);
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
//System.out.println("cgInfo = "+ cgInfo);
  }

  if (info==null)
    info = FeedbackInfo.getInstance(true);

  sAction = "Send Now";

  String sHelpTag = "feedback";
  String sTitleLinks = "<a href=\"feedbacklist.jsp?action=list\">Customer Feedback List</a> > <b>View and Response Customer Feedback</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below will allow you to view and response customer feedback by sending an email to him/her.
<form name="feedback" action="feedback.jsp" method="post" onsubmit="return validateFeedback(this);">
<input type="hidden" name="feedid" value="<%=info.FeedID%>">
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("feedback.jsp?")%></td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="4">Customer Feedback</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row2" colspan="4" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="18%" height="12" align="right">Customer Name: </td>
      <td class="row1" width="37%" height="12"><b><%=Utilities.getValue(info.Yourname)%></b></td>
      <td class="row1" width="15%" height="12" align="right">Submitted Date: </td>
      <td class="row1" width="30%" height="12"><b><%=Utilities.getDateValue(info.CreateDate, 16)%></b></td>
    </tr>
    <tr>
      <td class="row1" width="18%" height="12" align="right">Phone No: </td>
      <td class="row1" width="37%" height="12"><b><%=Utilities.getValue(info.Phone)%></b> </td>
      <td class="row1" width="15%" height="12" align="right">E-Mail: </td>
      <td class="row1" width="30%" height="12"><b><%=Utilities.getValue(info.EMail)%></b></td>
    </tr>

<% if (info.CustomizedFields!=null) { %>
    <tr>
      <td class="row1" width="18%" align="right" valign="top">More Information: </td>
      <td class="row1" width="37%" colspan="3"><%=Utilities.getValue(bean.getMoreInformation(info.CustomizedFields))%></td>
    </tr>
<% } %>
<% if (info.ResponseDate!=null) { %>
    <tr>
      <td class="row1" width="18%" height="12" align="right">Response By: </td>
      <td class="row1" width="37%" height="12"><b><%=Utilities.getValue(info.Sender)%></b></td>
      <td class="row1" width="15%" height="12" align="right">Sent Date: </td>
      <td class="row1" width="30%" height="12"><b><%=Utilities.getDateValue(info.ResponseDate, 16)%></b></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="18%" height="12" align="right" valign="top">Content: </td>
      <td class="row1" height="12" colspan="3"><textarea name="content1" rows="11" cols="77" wrap="virtual"><%=Utilities.getValue(info.Content)%></textarea></td>
    </tr>
    <tr>
      <td class="row1" width="18%" height="12" align="right" valign="top">Your Response: </td>
      <td class="row1" height="12" colspan="3"><textarea name="response" rows="12" cols="77" wrap="virtual"><%=Utilities.getValue(info.Response)%></textarea></td>
    </tr>
    <tr>
      <td colspan="4" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="4" align="center" height="22"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
  </table>
</form>
<SCRIPT>onFeedbackLoad(document.feedback);</SCRIPT>
<%@ include file="../share/footer.jsp"%>