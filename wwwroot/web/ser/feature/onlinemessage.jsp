<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    CustomerWeb web = new CustomerWeb(session, request, 10);
    if (sRealAction.startsWith("Send"))
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

    ret = mcBean.getWebContentByRequest(request, onInfo.MemberID);

    String sCaptchaUrl;
    if (mcBean.getHttpsUrl()!=null)
       sCaptchaUrl = "/ctr/admin/util/captcha.jsp?action=getimage";
    else
       sCaptchaUrl = "/admin/util/captcha.jsp?action=getimage";

    byte nShowWay = Utilities.getByte(request.getParameter("showway"), (byte)0);
//Utilities.dumpObject(info);
%>
<% if (nShowWay>0) { %>
<%@ include file="../include/htmlheader.jsp"%>
<% } %>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/tellfriend.js" type="text/javascript"></SCRIPT>
<table width="100%" align="center">
<% if (nShowWay>0) { %>
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
   <TD style="border-bottom: 1px">&nbsp;&nbsp;<a onClick="javascript:addNewMessage();" href="#">Add Message</a></TD>      
 </TR>
 <tr>
  <td><hr class="line" width="99%"></td>
 </tr>

 <TR>
   <TD height="1">
    <%@ include file="../include/information.jsp"%>
   </TD>
 </TR>
 <TR>
   <TD align="center">
<form name="form_tellfriend" method="post" action="<%=mcBean.encodedUrl("index.jsp")%>" onsubmit="return validateTellFriend(this);">
<input type="hidden" name="accessby" value="<%=request.getParameter("accessby")%>">
<input type="hidden" name="showway" value="<%=request.getParameter("showway")%>">
<input type="hidden" name="memberid" value="<%=onInfo.MemberID%>">
<input type="hidden" name="sender" value="<%=(mbInfo!=null?mbInfo.MemberID:-1)%>">
<input type="hidden" name="pageid" value="<%=request.getParameter("pageid")%>">
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
    <td width="12%" align="right">* Title:&nbsp;</td>
    <td><input type="text" name="subject" maxlength=256 value="" style="width: 620px"></td>
  </tr>
  <tr>
    <td width="12%" align="right">Url:&nbsp;</td>
    <td><input type="text" name="url" maxlength=256 value="" style="width: 620px"></td>
  </tr>
  <tr>
    <td width="12%" align="right">Tags:&nbsp;</td>
    <td><input type="text" name="url" maxlength=256 value="" style="width: 400px">&nbsp;&nbsp;(Multiple tags separated by comma)</td>
  </tr>
  <tr>
     <td colspan=2 height="20">Description:</td>
  </tr>
  <tr>
     <td colspan=2 align="center">
       <textarea id="content" name="content" rows=18 cols=80 wrap="soft" style="width: 700px"><%=(String)ret.getUpdateInfo()%></textarea>
       <script language="javascript1.2">createToolbar('content', 710, 200, ",7,15,16,17,32,");</script>
     </td>
  </tr>
  <tr>
   <td colspan=2 height="5"></td>
  </tr>      
  <tr>
    <td width="12%" align="right">Attach File 1:&nbsp;</td>
    <td><input type="file" name="attachfile_0" size="86"></td>
  </tr>
  <tr>
    <td width="12%" align="right">Attach File 2:&nbsp;</td>
    <td><input type="file" name="attachfile_1" size="86"></td>
  </tr>
  <tr>
    <td width="12%" align="right">Attach File 3:&nbsp;</td>
    <td><input type="file" name="attachfile_0" size="86"></td>
  </tr>
  <tr>
    <td width="12%" align="right">Attach File 4:&nbsp;</td>
    <td><input type="file" name="attachfile_1" size="86"></td>
  </tr>
  <tr>
    <td width="12%" align="right">Attach File 5:&nbsp;</td>
    <td><input type="file" name="attachfile_1" size="86"></td>
  </tr>
  <tr>
   <td colspan=2><hr class="line" width="99%"></td>
  </tr>
  <tr>
   <td colspan=2>
   <table>
    <tr>
     <td width="12%" align="right">Your Name:&nbsp;</td>
     <td width="38%"><input type="text" name="yourname" maxlength=40 value="" style="width: 260px"></td>
     <td width="12%" align="right">E-Mail:&nbsp;</td>
     <td><input type="text" name="email" maxlength=60 value="" style="width: 262px"></td>
    </tr>
   </table>
   </td>
  </tr>
  <tr>
   <td colspan=2 height="15"><hr class="line" width="99%"></td>
  </tr>
  <tr>
   <td colspan=2 align="center"><input type="submit" name="submit" value="Submit" style="width: 100px"></td>
  </tr>
 <tr>
  <td colspan=2 height="6"></td>
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
<!--SCRIPT>onTellFriendLoad(document.form_tellfriend)</SCRIPT-->
<% if (nShowWay>0) { %>
</BODY>
</HTML>
<% } %>
<% } %>