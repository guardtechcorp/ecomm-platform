<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.EmailBean"%>
<%@ include file="../include/pageheader.jsp"%>
<%
  EmailBean bean = new EmailBean(session);
  String sAction = BasicBean.getRealAction(request);
//MemberAccountBean.dumpAllParameters(request);

  if ("Send_EMail".equalsIgnoreCase(sAction))
  {
     ret = bean.sendEmail2(request);
     if (ret.isSuccess())
     {
       sDisplayMessage = bean.getLabel("cm-successemail") + " " + ret.m_UpdateInfo + ".";
     }
     else
     {
       sDisplayMessage = (String)ret.getInfoObject();
       nDisplay = 0;
     }
  }
/*
  else if ("Test_EMail".equalsIgnoreCase(sAction))
  {
    ret = bean.sendEmail2(request);
    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(ret.isSuccess()?0:1);
    response.flushBuffer();
    return;
  }
*/
    
//  String sFromEmail = mbInfo.getPersonalName() + " <" + mbInfo.EMail+">";
  String sFromEmail = mbInfo.EMail;

//  String sHelpTag = "massemail";
//  String sTitleLinks = bean.getNavigation(request, "Mass E-Mail Campaign");
%>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/tellfriend.js" type="text/javascript"></SCRIPT>
<form name="emailform" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateSendEmail(this);">
<input type="hidden" name="memberid" value="<%=onInfo.MemberID%>">
<input type="hidden" name="sender" value="<%=(mbInfo!=null?mbInfo.MemberID:-1)%>">
<input type="hidden" name="action1" value="Send_EMail">
<input type="hidden" name="pt" value="<%=bean.getLabel("cm-emailtitle")%>">
<input type="hidden" name="fromemail" value="<%=sFromEmail%>">
<table class="table-outline" width="100%" align="center">
 <TR>
   <TD colspan="3" height="1">
   <%@ include file="../include/information.jsp"%>
  </TD>
 </TR>    
  <tr>
   <td colspan="2" height="5"></td>
  </tr>
  <tr>
    <td class="row1" width="10%" align="right" height="24"><%=bean.getLabel("cm-recipient")%>:</td>
    <td width="30%"><input type="text" name="toemail" style="width: 645px" value="<%=Utilities.getValue(request.getParameter("toemail")).replaceAll("\\[", "<").replaceAll("\\]", ">")%>"></td>
  </tr>
  <tr>
    <td class="row1" width="10%" align="right"><%=bean.getLabel("cm-from")%>:</td>
    <td class="row1" width="90%"><input type="text" name="fromdisplay" style="width: 480px" value="<%=sFromEmail%>" disabled>
     <input type="checkbox" name="copyto" value="1"><%=bean.getLabel("cm-sendself")%></td>
  </tr>
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
  <tr>
   <td class="row1" width="10%" align="right" height="24"><%=bean.getLabel("cm-subject")%>:</td>
   <td width="30%"><input type="text" name="subject" style="width: 645px" value="<%=Utilities.getValue(request.getParameter("subject"))%>"></td>
  </tr>
  <tr>
    <td colspan=2>
     <table width="100%" border="0" cellspacing="1" cellpadding="1">
      <tr>
       <td width="5"></td>
       <td width="50%" valign="bottom"><%=bean.getLabel("cm-content")%>:</td>
       <td align="right" valign="bottom"><%=bean.getLabel("cm-contentformat")%>:
         <select name="format" onChange="onFormatChange(document.emailform);">
          <option value="html" selected>Html</option>
          <option value="text"><%=bean.getLabel("cm-text")%></option>
         </select>
       </td>
       <td width="5"></td>
      </tr>
    </table>
   </td>
  </tr>
  <tr>
    <td class="row1" colspan=2>
    <DIV id="HTML_MSG" style="display: inline">
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
       <tr>
         <td colspan=2 align="center">
           <textarea id="content" name="content" rows=18 cols=80 wrap="soft" style="width: 700px"><%=Utilities.getValue(request.getParameter("content"))%></textarea>
           <script language="javascript1.2">createToolbar('content', 710, 300, ",7,15,16,17,32,");</script>
         </td>
       </tr>
      </table>
    </DIV>
    <DIV id="TEXT_MSG" style="display: none">
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td>
           <textarea name="contenttext" style="width: 720px; height: 325px" wrap="virtual"><%=Utilities.getValue(request.getParameter("contenttext"))%></textarea>
          </td>
        </tr>
      </table>
    </DIV>
   </td>
  </tr>
  <tr>
   <td colspan="2" height="10"></td>
  </tr>
  <tr>
   <td align="center" colspan="2"><input type="submit" value="<%=mcBean.getLabel("cm-emailnow")%>" name="submit"></td>
  </tr>
  <tr>
   <td colspan="2" height="1"></td>
  </tr>
</table>
</form>
<form name="testform" action="email.jsp" method="post" onsubmit="return validateTestMailForm(document.emailform, this, '<%=mcBean.encodedUrl("ajax/response.jsp?action=Test_EMail")%>');">
<fieldset style="margin:0px"><legend><b><%=mcBean.getLabel("cm-sendpreview")%></b></legend>
<table cellspacing="1" cellpadding="1" border="0" align="center" class="forumline" width="100%">
  <tr>
    <td class="row1" width="10%" align="right" height="40"><%=mcBean.getLabel("cm-emailto")%>: </td>
    <td class="row1"><input type="text" name="toemail" value="<%=mbInfo.EMail%>" style="width: 520px;"> <input type="submit" name="submit" value="<%=mcBean.getLabel("cm-sendnow")%>">
    </td>
  </tr>
</table>
</fieldset>
</form>
<!--
<input type="button" id="mySubmit" class="formButton" value="Send" onclick="formObj.submit()">
<script type="text/javascript" src="/staticfile/web/scripts/form-submit.js"></script>
<script type="text/javascript" src="/staticfile/web/scripts/ajax.js"></script>
<script type="text/javascript">
var formObj = new DHTMLSuite.form({ formRef:'emailform',action:'emailform.jsp',responseEl:'formResponse'});
</script>
-->
