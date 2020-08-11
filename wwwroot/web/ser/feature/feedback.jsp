<%@ page import="com.zyzit.weboffice.web.FeedbackWeb"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    String sAction = BasicBean.getRealAction(request);
//System.out.println("sRealAction=" + sRealAction + ", " + sAction);
    FeedbackWeb web = new FeedbackWeb(session);
    if (sAction.startsWith("Submit")) {
        ret = web.submitNow(request);
        if (ret.isSuccess()) {
            sDisplayMessage = (String) ret.m_UpdateInfo;
            nDisplay = 1;
        } else {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
        }
    }

    int nPageId = web.getPageID(request);// Utilities.getInt(request.getParameter("pid"), 0);
    WebPageInfo wpInfo = mcBean.getWebPageByPageId(onInfo.MemberID, nPageId);

    ret = mcBean.getWebContentByRequest(request, onInfo.MemberID);
    String sSubmitUrl;
    if (wpInfo.ShowWay==0)
       sSubmitUrl = mcBean.encodedUrl("index.jsp");
    else
       sSubmitUrl = mcBean.encodedUrl("feature/feedback.jsp");
%>
<% if (wpInfo.ShowWay>0) { %>
<%@ include file="../include/htmlheader.jsp"%>
<% } %>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/feedback.js" type="text/javascript"></SCRIPT>
<table width="100%" align="center">
<% if (wpInfo.ShowWay>0) { %>
<TR>
 <TD>
<%@ include file="../include/pagetitle.jsp"%>
 </TD>
</TR>
<% } %>
  <TR vAlign="middle" >
    <TD><HR class='divider' /></TD>
  </TR>
  <TR>
   <TD height="1">
    <%@ include file="../include/information.jsp"%>
   </TD>
  </TR>
  <TR>
   <TD><%=(String)ret.getUpdateInfo()%></TD>
  </TR>
  <TR vAlign="middle" >
    <TD height=10></TD>
  </TR>
  <TR valign="top">
   <TD align="center">
       <form name="feedback" method="post" action="<%=sSubmitUrl%>" onsubmit="return validateFeedback2(this, 'content');">
       <input type="hidden" name="pid" value="<%=nPageId%>">
       <input type="hidden" name="memberid" value="<%=onInfo.MemberID%>">
       <input type="hidden" name="sender" value="<%=(mbInfo!=null?mbInfo.MemberID:-1)%>">
       <input type="hidden" name="action1" value="Submit_Feedback">
       <table cellpadding=4 cellspacing=0 border=0 width=720 bgcolor="#F1F1FD">
        <tr>
        <td>
         <script>createTableOpen();</script>
         <table cellpadding=2 cellspacing=0 border=0 width="640" align="center">
          <tr>
            <td colspan=2 height="10"></td>
          </tr>
          <tr>
            <td width="24%" align="right">* <%=mcBean.getLabel("fb-name")%>:&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><input type="text" name="yourname" size="55" maxlength="60" value="<%=mbInfo!=null?mbInfo.getFullName():Utilities.getValue(request.getParameter("yourname"))%>"></td>
          </tr>
          <tr>
            <td width="24%" align="right"><%=mcBean.getLabel("fb-phone")%>:&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><input type="text" name="phone" size="55" maxlength="60" value="<%=mbInfo!=null?Utilities.getValue(mbInfo.getPhoneNo()):Utilities.getValue(request.getParameter("yourname"))%>"></td>
          </tr>
          <tr>
            <td width="24%" align="right">* <%=mcBean.getLabel("fb-email")%>:&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td><input type="text" name="email" size="55" maxlength="60" value="<%=mbInfo!=null?mbInfo.EMail:Utilities.getValue(request.getParameter("email"))%>"></td>
          </tr>
          <tr>
            <td colspan=2 height="20"></td>
          </tr>
          <tr>
            <td colspan=2>&nbsp;&nbsp;* <%=mcBean.getLabel("fb-comment")%>Comment/Suggestion/Ask Questions:</td>
          </tr>         
          <tr>
            <td colspan=2 align="center">
              <textarea id="content" name="content" rows=18 cols=80 wrap="soft" style="width: 700px"></textarea>
              <script language="javascript1.2">createToolbar('content', 710, 300, ",7,15,16,17,32,");</script>
            </td>
          </tr>
          <tr>
            <td colspan=2 height="10"></td>
          </tr>
          <tr>
            <td colspan=2 align="center"><input type="submit" name="submit" value="<%=mcBean.getLabel("cm-submit")%>" style="width: 100px"></td>
          </tr>
         <tr>
           <td colspan=2 height="10"></td>
         </tr>
        </table>
       <script>createTableClose();</script>
       </td></tr>
     </table> 
    </form>
  </TD>
 <TR>
</table>
<SCRIPT>onFeedbackLoad(document.feedback)</SCRIPT>
<% if (wpInfo.ShowWay>0) { %>
</BODY>
</HTML>
<% } %>
<% } %>