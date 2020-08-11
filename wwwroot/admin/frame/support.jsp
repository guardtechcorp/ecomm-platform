<HTML>
<HEAD>
<Title>Ask experts a question for technical support</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management Center from KZ Company'>
<link rel="stylesheet" href="/staticfile/admin/css/main.css" type="text/css">
<link rel="stylesheet" href="/staticfile/admin/css/table-style.css" type="text/css">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/languages/iso-8859-1.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/feedback.js"></SCRIPT>
</HEAD>
<body onLoad="onFeedbackLoad(document.question);">
<%@ page import="com.zyzit.weboffice.web.FeedbackWeb"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%
  FeedbackWeb web = new FeedbackWeb();
//web.showAllParameters(request, out);
//web.showSessionInfo(request, application, session, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "failed";
  if (sAction!=null&&sAction.startsWith("Submit"))//.equalsIgnoreCase(sAction))
  {
     FeedbackWeb.Result ret = web.submit(request, "iso-8859-1");
     if (ret.isSuccess())
     {
       sDisplayMessage = (String) ret.m_UpdateInfo;
       sClass = "successful";
     }
     else
     {
       Errors errObj = (Errors)ret.getInfoObject();
       sDisplayMessage = errObj.getError();
     }
  }
%>
<table cellpadding=0 cellspacing=0 border=0 width="100%"><tr><td>
<form name="question" method="post" action="support.jsp" onsubmit="return validateFeedback(this);">
<input type="hidden" name="domainname" value="www.webonlinemanage.com">
<input type="hidden" name="type" value="webcenter">
<input type="hidden" name="public" value="1">
<table cellpadding=0 cellspacing=0 border=0 width="100%">
<tr>
<td align="center" valign="top"><IMG src="/staticfile/admin/images/womglogo-about.jpg" align="CENTER"></td>
</tr>
</table>
<br>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <TR>
    <TD><IMG style="HEIGHT: 1px; Width: 0px" alt="" src="images/spacer.gif" border=0></TD>
    <!--TD class=NavBar_TabOff noWrap align=middle width=120 height=22><A class=navbar_links href="#">Browse</A></TD-->
    <!--TD><IMG style="HEIGHT: 1px; Width: 2px" alt="" src="images/spacer.gif" border=0></TD-->
    <TD class=NavBar_TabOn noWrap align=middle width=120 height=22>Ask a Question</TD>
    <TD><IMG style="HEIGHT: 1px; Width: 2px" alt="" src="images/spacer.gif" border=0></TD>
    <!--TD class=NavBar_TabOff noWrap align=middle width=120 height=22><A class=navbar_links href="#">Support</A></TD-->
    <!--TD width="95%"><IMG style="HEIGHT: 1px" alt=""  src="images/spacer.gif" border=0></TD-->
    <TD width="10%" align="right"><A href="#" onClick="javascript:window.close();">Close</A>&nbsp;&nbsp;</TD>
  </TR>
  <TR>
    <!--TD bgColor=#7898b5 height=1></TD-->
    <!--TD bgColor=#7898b5 height=1></TD-->
    <TD bgColor=#7898b5 height=1></TD>
    <TD bgColor=#ffffff height=1></TD>
    <!--TD bgColor=#7898b5 height=1></TD-->
    <!--TD bgColor=#7898b5 height=1></TD-->
    <TD bgColor=#7898b5 height=1></TD>
    <TD bgColor=#7898b5 height=1></TD>
 </TR>
</TABLE>

<TABLE cellSpacing=0 cellPadding=2 width="100%">
  <TR>
   <TD><IMG height=5 src="images/spacer.gif" width=1></TD>
  </TR>
  <TR>
    <TD class=small_blue_text height="5"><!--b>Ask a Question!</b--></TD>
  </TR>
<% if (sDisplayMessage!=null) { %>
  <TR>
    <td align="center"><span class="<%=sClass%>"><font size="2" face="arial"><%=sDisplayMessage%></font></span></td>
  </TR>
<% } %>
 <!--TR>
   <TD class=tophoz_splitter><IMG height=15 src="images/spacer.gif" width=1></TD></TR>
 <TR-->
</TABLE>
<TABLE cellSpacing=2 cellPadding=2 width="100%" border=0>
  <TR>
    <TD height=1></TD>
  </TR>
  <TR>
    <TD class=small_darkblue_text vAlign=top>If you have a query regarding any
      of our product or services, please don't hesitate to submit your question
      below. A member of our support team will review, answer and publish your
      question to the knowledge base as quickly as possible. <BR><BR>If the
      knowledge base administrator has enabled the email notification feature
      you will receive an automated email response once your question has been
      answered and is available within the knowledge base. Thank you for posting
      your question.<BR><BR>
<TABLE cellSpacing=1 cellPadding=0 width="100%" bgColor=#7898b5 border=0>
    <TR>
    <TD>
      <TABLE cellSpacing=0 cellPadding=7 width="100%" border=0>
        <TR>
          <TD class=header_cell noWrap>Ask a Question!</TD>
        <TR>
          <TD class=blue_1px_line_seperator></TD></TR>
      </TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TR>
          <TD class=mediumblue_tblCell vAlign=top>
            <TABLE cellSpacing=1 cellPadding=2 width="100%">
              <TR>
                <TD class=lightblue_tblcell align=right width="20%"><FONT class=small_darkblue_text>Your Name:</FONT></TD>
                <TD class=lightblue_tblcell><input type="text" name="yourname" size="32" maxlength="60"></TD>
              </TR>
              <TR>
                <TD class=lightblue_tblcell align=right width="20%"><FONT  class=small_darkblue_text>Your Email:</FONT></TD>
                <TD class=lightblue_tblcell><input type="text" name="email" size="32" maxlength="60"></TD>
              </TR>
              <TR>
                <TD class=lightblue_tblcell align=right width="20%"><FONT  class=small_darkblue_text>Your Phone:</FONT></TD>
                <TD class=lightblue_tblcell><input type="text" name="phone" size="32" maxlength="60"> (Optional)</TD>
              </TR>
              <TR>
                <TD class=lightblue_tblcell vAlign=top align=right width="20%"><FONT class=small_darkblue_text>Your Question:</FONT></TD>
                <TD class=lightblue_tblcell vAlign=top><textarea name="content" rows="6" cols="50" wrap="soft"></textarea></TD>
              </TR>
              <TR>
                <TD class=lightblue_tblcell align=right width="20%"></TD>
                <TD class=lightblue_tblcell><input type="submit" name="action" value="Submit">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="reset" name="Reset" value="Reset"></TD>
              </TR>
            </TABLE>
          </TD>
         </TR>
         </TABLE>
         </TD>
        </TR>
    </TABLE>
   </TD>
 </TR>
</TABLE>
</form>
</td></tr></table>
</body>
</html>