<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.EmailBean"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%
  EmailBean bean = new EmailBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_NEWSLETTER|AccessRole.ROLE_EMAILCAMPAIGN))
     return;

//System.out.println("str=" + request.getQueryString());
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("E-Mail Now".equalsIgnoreCase(sAction))
  {
     EmailBean.Result ret = bean.sendEmail(request);
     if (ret.isSuccess())
     {
       sDisplayMessage = (String)ret.getUpdateInfo();
     }
     else
     {
       sClass = "failed";
       sDisplayMessage = (String)ret.getInfoObject();
     }
  }
  else if ("Test Mail".equalsIgnoreCase(sAction))
  {
    int nRet = bean.testMail(request);
    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(nRet);
    response.flushBuffer();
    return;
  }

/*
  String sReturn = request.getParameter("return");
  if ("emailcoupon".equalsIgnoreCase(sAction))
  {
     sReturn = bean.getEncodeUrl(request);
  }
  String sDisplay = request.getParameter("display");

  String sTitleLinks = "";
  if (sReturn!=null)
    sTitleLinks = "<a href=\"" + Utilities.replaceContent(sReturn, "|", "?action=", false)  +"\">" + sDisplay + "</a> > ";
  sTitleLinks += "<b>Mass E-Mail Campaign</b>";
*/
  String sHelpTag = "massemail";
  String sTitleLinks = bean.getNavigation(request, "Mass E-Mail Campaign");
%>
<%@ include file="../share/uparea.jsp"%>
<SCRIPT type="text/javascript" language="JavaScript1.2" src="/staticfile/admin/scripts/contenteditor.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/email.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/selection.js"></SCRIPT>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
Here you can email a message (either in Text or Html format) either to a single/multiple recipients (separate multiple addresses with commas ',') or to a group of recipients (customers, selected customers, newsletter subscribers or members).
<form name="post" action="email.jsp"  method="post">
<!--input type="hidden" name="return" value="Utilities.getValue(sReturn)%>"-->
<!--input type="hidden" name="display" value="Utilities.getValue(sDisplay)%>"-->
<input type="hidden" name="incid" value="<%=Utilities.getValue(request.getParameter("incid"))%>">
<input type="hidden" name="cpname" value="<%=Utilities.getValue(request.getParameter("cpname"))%>">
<table cellspacing="1" cellpadding="1" border="0" align="center" class="forumline" width="100%">
  <tr>
    <th class="thHead" colspan="2">Compose</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
  <tr>
    <td class="row1" width="10%" align="right" height="24">Recipients:</td>
    <td class="row1" width="90%" align="left" height="24">
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="50%">
            <select name="group" onChange="onGroupChange(document.post)">
              <option value="recipients" selected>Recipients</option>
              <%=bean.getMassEmailOption(request)%>
            </select>
<span id="EDIT_SELECTION" style="display: none">
   <a href="javascript:newWindow('../customer/selectlist.jsp?action=Customers&page=1','SelectionWin',800,600,'yes','center')">Edit Selection</a>
   (<span id="totalselection"></span>)
</span>
          </td>
          <td width="20%" align="right">To:</td>
          <td width="30%"><input type="text" name="toemail" size="30" value="<%=Utilities.getValue(request.getParameter("toemail"))%>"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="row1" width="10%" align="right">From:</td>
    <td class="row1" width="90%">
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="50%">
            <select name="fromemail">
             <%=bean.getFromEmails()%>
            </select>
          </td>
          <td width="20%" align="right"><input type="checkbox" name="copyto" value="yes">Send a copy To:</td>
          <td width="30%"><input type="text" name="ccemail" size="30"  value="<%=bean.getCCEmail(session)%>"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="row1" width="10%" align="right">Subject:</td>
    <td class="row1" width="90%">
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="50%"><input type="text" name="subject" size="56" value="<%=Utilities.getValue(request.getParameter("subject"))%>"></td>
          <td width="20%" align="right">Message Format:</td>
          <td width="30%">
            <select name="format" onChange="onFormatChange(document.post);">
              <option value="text" selected>Text</option>
              <option value="html">Html</option>
            </select>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="row1" colspan=2>Message Content:
    <DIV id="TEXT_MSG" style="display1: none">
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td>
           <textarea name="content" rows="15" cols="99" wrap="virtual"><%=bean.getDefaltContent(request)%></textarea>
          </td>
        </tr>
      </table>
    </DIV>
    <DIV id="HTML_MSG" style="display: none">
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td>
           <OBJECT id="dlg" classid="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" width="0px" height="0px" BaseHref="https://secure.webonlinemanage.com"></OBJECT>
           <INPUT type="hidden" name="msg_html" value='<%=bean.getDefaltContent(request).replaceAll("\n", "<br>")%>'>
           <INPUT type="hidden" name="msg" value=''>
           <!--IFRAME name="editor_iframe" id="editor_iframe" width="100%" height="350" onLoad="initOuterIFrame()" style="visibility: hidden"></IFRAME-->
           <IFRAME name="editor_iframe" id="editor_iframe" width="100%" height="240" style="visibility: hidden" src="editor-toolbar.jsp"></IFRAME>
         </td>
        </tr>
      </table>
    </DIV>
   </td>
  </tr>
  <tr>
    <td class="catBottom" align="center" colspan="2"><input type="submit" value="E-Mail Now" name="action" onClick="return validateSendEmail(document.post);"></td>
  </tr>
</table>
</form>
<form name="testform" action="email.jsp" method="post" onsubmit="return validateTestMailForm(document.post, this);">
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
<SCRIPT>selectDropdownMenu(document.post.group, '<%=Utilities.getValue(request.getParameter("group"))%>');</SCRIPT>
<SCRIPT>onEmailLoad(document.post);</SCRIPT>
<SCRIPT>displaySelection(<%=bean.getTotalSelection()%>);</SCRIPT>
<%@ include file="../share/footer.jsp"%>