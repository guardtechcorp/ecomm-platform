<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    String sAction = BasicBean.getRealAction(request);
//System.out.println("sRealAction=" + sRealAction + ", " + sAction);

    CustomerWeb web = new CustomerWeb(session, request, 10);
    if (sAction.startsWith("Send"))
    {
       ret = web.tellfriends(request);
       if (ret.isSuccess())
       {
         sDisplayMessage = (String) ret.getInfoObject();
         nDisplay = 1;
       }
       else
       {
         Errors errObj = (Errors)ret.getInfoObject();
         sDisplayMessage = errObj.getError();
         nDisplay = 0;
       }
    }

    int nPageId = web.getPageID(request);// Utilities.getInt(request.getParameter("pid"), 0);
    WebPageInfo wpInfo = mcBean.getWebPageByPageId(onInfo.MemberID, nPageId);

    ret = mcBean.getWebContentByRequest(request, onInfo.MemberID);

    String sCaptchaUrl;
    if (mcBean.getHttpsUrl()!=null)
       sCaptchaUrl = "/ctr/admin/util/captcha.jsp?action=getimage";
    else
       sCaptchaUrl = "/admin/util/captcha.jsp?action=getimage";

    String sSubmitUrl;
    if (wpInfo.ShowWay==0)
       sSubmitUrl = mcBean.encodedUrl("index.jsp");
    else
       sSubmitUrl = mcBean.encodedUrl("feature/tellfriend.jsp");
%>
<% if (wpInfo.ShowWay>0) { %>
<%@ include file="../include/htmlheader.jsp"%>
<% } %>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/tellfriend.js" type="text/javascript"></SCRIPT>
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
   <TD align="center">
<form name="form_tellfriend" method="post" action="<%=sSubmitUrl%>" onsubmit="return validateTellFriend(this);">
<input type="hidden" name="memberid" value="<%=onInfo.MemberID%>">
<input type="hidden" name="sender" value="<%=(mbInfo!=null?mbInfo.MemberID:-1)%>">
<input type="hidden" name="pid" value="<%=wpInfo.PageID%>">
<input type="hidden" name="action1" value="Send_TellFriend">
 <table cellpadding=4 cellspacing=0 border=0 width=720 bgcolor="#F1F1FD">
  <TR>
   <TD align="center" valign="top" width="100%">
  <script>createTableOpen();</script>
  <table cellpadding=2 cellspacing=0 border=0 align="center" width="100%">
   <tr>
     <td colspan=2 height="10"></td>
   </tr>            
   <tr>
    <td width="40%" align="right" height="22">* <%=mcBean.getLabel("tl-email1")%>:&nbsp;&nbsp;</td>
    <td><input type="text" name="friendemail1" size="50" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail1"))%>"></td>
  </tr>
  <tr>
    <td width="40%" align="right" height="22"><%=mcBean.getLabel("tl-email2")%>:&nbsp;&nbsp;</td>
    <td><input type="text" name="friendemail2" size="50" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail2"))%>"></td>
  </tr>
  <tr>
    <td width="40%" align="right" height="22"><%=mcBean.getLabel("tl-email3")%>:&nbsp;&nbsp;</td>
    <td><input type=text name="friendemail3" size="50" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail3"))%>"></td>
  </tr>
  <tr>
    <td width="40%" align="right" height="22"><%=mcBean.getLabel("tl-email4")%>:&nbsp;&nbsp;</td>
    <td><input type=text name="friendemail4" size="50" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail4"))%>"></td>
  </tr>
  <tr>
    <td width="40%" align="right" height="22"><%=mcBean.getLabel("tl-email5")%>:&nbsp;&nbsp;</td>
    <td><input type=text name="friendemail5" size="50" maxlength="60" value="<%=Utilities.getValue(request.getParameter("friendemail5"))%>"></td>
  </tr>
  <tr>
    <td width="40" align="right" height="22">* <%=mcBean.getLabel("tl-youremail")%>:&nbsp;&nbsp;</td>
    <td><input type="text" name="email" size="50" maxlength="60" value="<%=Utilities.getValue(request.getParameter("email"))%>"></td>
  </tr>
  <tr>
    <td width="40" align="right" valign="top">* <%=mcBean.getLabel("cm-entercode")%>Enter the code shown below:&nbsp;&nbsp;
    <br>(<%=mcBean.getLabel("cm-entercodedes")%>)&nbsp;&nbsp;
    </td>
    <td height="26"><input maxlength=20 size=20 name="input" style="width: 200px">&nbsp;<a href="javascript:ChildWin=window.open('/staticfile/web/imagecode-help.html','imagecode_help','resizable=yes,scrollbars=no,width=460,height=450');ChildWin.focus()"><%=mcBean.getLabel("cm-moreinfo")%></a>
    <br><img src="<%=sCaptchaUrl%>" align="top" alt="Enter the characters appearing in this image" border="1"/>
    </td>
  </tr>
  <tr>
   <td colspan="2" width="100%">
   <table cellpadding=0 cellspacing=0 border=0>
    <tr>
      <td colspan=2 height="10"></td>
    </tr>
    <tr>
      <td width="10%" align="right">* <%=mcBean.getLabel("cm-subject")%>:&nbsp;&nbsp;</td>
      <td><input type="text" name="subject" maxlength=256 value="Check out this website" style="width: 640px">
      </td>
    </tr>
   <tr>
     <td colspan=2 height="5"></td>
   </tr>
   <tr>
     <td colspan=2 align="center">
       <textarea id="content" name="content" rows=18 cols=80 wrap="soft" style="width: 700px"><%=(String)ret.getUpdateInfo()%></textarea>
       <script language="javascript1.2">createToolbar('content', 710, 260, ",7,15,16,17,32,");</script>
     </td>
   </tr>
   <tr>
     <td colspan=2 height="15"></td>
   </tr>
    <tr>
      <td colspan=2 align="center"><input type="submit" name="submit" value="<%=mcBean.getLabel("cm-sendnow")%>" style="width: 100px"></td>
    </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td colspan=2 height="10"></td>
 </tr>
</table>
<script>createTableClose();</script>
  </TD>
 <TR>
</table>
</FORM>

 </TD>
<TR>
</table>
<SCRIPT>onTellFriendLoad(document.form_tellfriend)</SCRIPT>
<% if (wpInfo.ShowWay>0) { %>
</BODY>
</HTML>
<% } %>
<% } %>