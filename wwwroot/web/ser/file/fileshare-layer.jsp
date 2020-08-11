<%@ page import="com.zyzit.weboffice.util.*"%>
<%
//<a href="#" message="showShareWin(document.form_sharefile, 'id_sharelayer', this, 'file.getName()', file.isDirectory())" title="Share file.isDirectory()?"folder":"file": file.getName()">Share</a>
%>
<SCRIPT language="JavaScript" src="/staticfile/admin/scripts/calendardateinput.js"></SCRIPT>
<DIV id="id_sharelayer" style="display:none; position:absolute; z-index: 100; border: 2px solid black;" ONSELECTSTART1="return false;">
<TABLE class1="table-1" width="600" border=0 cellspacing=1 cellpadding=0 bgColor="#ffffff" style="border: 1px solid #DFDFDF; padding: 4px;">
<form name="form_sharefile" action="#" method="post" onSubmit="return onValidateShareFile(this, '<%=bean.encodedUrl("ajax/response.jsp")%>');">
<INPUT type="hidden" name="action1" value="Send_ShareFile">
<INPUT type="hidden" name="format" value="text/html">
<INPUT type="hidden" name="currentdir" value="<%=bean.getCurrentDir()%>">
<INPUT type="hidden" name="type" value="1">
<INPUT type="hidden" name="memberids" value="">
<INPUT type="hidden" name="filename" value="">
<INPUT type="hidden" name="yourname" value="<%=mbInfo.FirstName%>">
<tr>
  <td colspan=2 height="5"></td>
</tr>
<tr>
  <td id="share_title" colspan=2 height="22" align="center" valign="bottom"><B><FONT size=2 color="#CCCCCC"><%=mcBean.getLabel("fs-sharetitle")%></FONT></B></td>
</tr>
<tr>
 <td colspan=2 valign="top"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
</tr>
<tr>
 <td colspan=2 height="1" id="id_message"></td>
</tr>
<tr>
  <td colspan=2 height=5></td>
</tr>
<!--tr>
  <td align="right" width="14%">From:</td>
  <td><input maxlength=60 size=55 value="<%=Utilities.getValue(mbInfo.FirstName)%> <<%=mbInfo.EMail%>>" name="from" disabled>
  </td>
</tr-->
<tr>
  <td align="right" width="14%"><%=mcBean.getLabel("fs-emails")%>:</td>
  <td><input style="width:490px;" value="" name="emails"></td>
</tr>

<tr>
  <td align="right" width="14%" valign="top"><%=mcBean.getLabel("fs-members")%>:</td>
  <td>
   <div id="scroll_list" style="width:490px;height:80px;background-color:white;overflow:auto;BORDER: #4279bd 1px solid; ">
    <%=bean.getMemberCheckBoxList(mbInfo.MemberID, true)%>
   </div>
  </td>
</tr>
 <tr>
  <td colspan=2 height="5"></td>
 </tr>
 <tr>
   <td align="right" width="14%"><%=mcBean.getLabel("cm-subject")%>:</td>
   <td><input style="width:490px;" value="<%=Utilities.getValue(request.getParameter("subject"))%>" name="subject"></td>
 </tr>
 <tr>
   <td align="right" width="14%" valign="top"><%=mcBean.getLabel("cm-message")%>:</td>
   <td> <textarea rows="3" style="width:490px;" wrap="virtual" name="content"><%=Utilities.getValue(request.getParameter("content"))%></textarea></td>
 </tr>
 <tr>
  <td width="14%" align="right" valign="top"><%=mcBean.getLabel("cm-authorize")%>:</td>
  <td>
   <select name="accessmode" onChange="onAccessModeChange(document.form_sharefile);">
    <option value="127"><%=mcBean.getLabel("fs-protect")%></option>
    <option value="2"><%=mcBean.getLabel("fs-needlogin")%></option>
    <option value="64"><%=mcBean.getLabel("fs-unlockkey")%></option>
   </select> &nbsp;&nbsp;<%=mcBean.getLabel("cm-unlockcode")%>: <input maxlength=32 size=16 name="unlockcode" disabled> <br>(<%=mcBean.getLabel("fs-unlockdes")%>)
  </td>
 </tr>
 <tr>
  <td align="right" width="14%"><%=mcBean.getLabel("cm-expired")%>:</td>
  <td>
   <table border=0 cellspacing=0 cellpadding=0>
    <tr>
     <td width="40%">
      <script>DateInput('expireddate', true, 'YYYY-MM-DD', '<%=Utilities.getExpiredDateByDay(7).substring(0,10)%>');</script>
     </td>
     <td>(<%=mcBean.getLabel("fs-maxday")%>) &nbsp;&nbsp;<input type="checkbox" name="sendmyself" value="1" checked><%=mcBean.getLabel("cm-sendself")%></td>
    </tr>
   </table>
  </td>
 </tr>
 <tr>
  <td colspan=2 valign="top"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
 </tr>
 <tr>
   <td colspan=2>
    <table border="0" width="100%">
     <tr>
      <td align="center">
       <input type="submit" name="submit" style='width:120px' value="<%=mcBean.getLabel("cm-sendnow")%>">
   <!--
      <SCRIPT>createLeftButton();</SCRIPT>
      <A class="button" onClick="sendMessage(document.form_message, 'TEST');" href="javascript:;">Send Message Now</A>
      <SCRIPT>createRightButton();</SCRIPT>
   -->
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="button" name="close" style='width:120px' value="<%=mcBean.getLabel("cm-close")%>" onClick="hideShareWin('id_sharelayer');">
      </td>
     </tr>
   </table>
  </td>
 </tr>
</form>
   </TABLE>
  </DIV>
