<HTML>
<HEAD>
<Title>Feedback</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<LINK href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/languages/iso-8859-1.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/windows.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/feedback.js" type="text/javascript"></SCRIPT>
</HEAD>
<body onLoad="onFeedbackLoad(document.feedback);">
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
     if (request.getParameter("course")!=null)
     {//. Specail for Wayne
       StringBuffer sbFields = new StringBuffer();
       sbFields.append("Course: <b>"+request.getParameter("course")+"</b>");
       if (request.getParameter("product")!=null)
         sbFields.append("!!Product: <b>"+request.getParameter("product")+"</b>");
       if (request.getParameter("site")!=null)
         sbFields.append("!!Site: <b>"+request.getParameter("site")+"</b>");
       if (request.getParameter("custom01")!=null)
         sbFields.append("!!Custom01: <b>"+request.getParameter("custom01")+"</b>");
       if (request.getParameter("custom02")!=null)
         sbFields.append("!!Custom02: <b>"+request.getParameter("custom02")+"</b>");
       request.setAttribute("customizedfields", sbFields.toString()+"</b>");
     }

     FeedbackWeb.Result ret = web.submit(request, null);
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

     String sReturnURL = request.getParameter("return_url");
     if (sReturnURL!=null)
     {
        response.sendRedirect(sReturnURL);
        return;
     }
  }
%>
<form name="feedback" method="post" action="form-feedback.jsp" onsubmit="return validateFeedback(this);">
<input type="hidden" name="domainname" value="<%=Utilities.getValue(web.getDomainNameFromUrl(request))%>">

<input type="hidden" name="alert_email" value="xxx@xxx.com">
<input type="hidden" name="alert_subject" value="xxx">

<table cellspacing=0 cellpadding=0 width="98%" align="center" height="100%">
  <TR vAlign="middle" >
    <TD height=5></TD>
  </TR>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td height="12" align="center"><span class="<%=sClass%>"><font size="2" face="arial"><%=sDisplayMessage%></font></span></td>
    </tr>
<% } %>
  <TR vAlign="middle">
    <TD height="5"></TD>
  </TR>
  <TR valign="top">
   <TD align="center">
   <script>createTableOpen();</script>
    <table cellpadding=0 cellspacing=0 border=0 width="90%">
      <TR vAlign="middle">
        <TD height=10 align="center" colspan="2"></TD>
      </TR>
      <tr>
        <td width="25%" align="right" height="26">Your Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td><input type="text" name="yourname" size="40" maxlength="60"></td>
      </tr>
      <tr>
        <td width="25%" align="right" height="26">Your Phone:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td><input type="text" name="phone" size="40" maxlength="60"> (Optional)</td>
      </tr>
      <tr>
        <td width="25%" align="right" height="26">Your E-Mail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td><input type="text" name="email" size="40" maxlength="60"></td>
      </tr>
      <tr>
        <td colspan=2 height="10"></td>
      </tr>
      <tr>
        <td colspan=2 align="center">
     <table>
      <tr>
        <td>Content:</td>
      </tr>
      <tr>
        <td align="left">
          <textarea name="content" rows="14" cols="61" wrap="soft"></textarea>
        </td>
      </tr>
      <tr>
        <td height="6"></td>
      </tr>
      <tr>
        <td align="center"><input type="submit" name="action" value="Submit"></td>
      </tr>
      </table>
        </td>
      </tr>
    </table>
   <script>createTableClose();</script>
  </TD>
 <TR>
</table>
</form>
</body>
</html>