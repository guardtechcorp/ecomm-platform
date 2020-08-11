<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%@ page import="com.zyzit.weboffice.bean.OnlineMessageBean" %>
<%@ page import="com.zyzit.weboffice.model.OnlineMessageInfo" %>
<%@ page import="com.zyzit.weboffice.util.Errors" %>
<%@ page import="java.util.List" %>
<%@ include file="../include/pageheader.jsp"%>
<%
    OnlineMessageBean omBean = OnlineMessageBean.getObject(session);

    OnlineMessageInfo info;
    if (sRealAction.startsWith("prev") || sRealAction.startsWith("next")||sRealAction.startsWith("goto"))
    {
//System.out.println("sRealAction=" + sRealAction);
       info = omBean.getPrevOrNext(request, sRealAction);
    }
    else if (sRealAction.startsWith("Delete"))
    {
//        ret = omBean.delete(request, false);
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
        info = (OnlineMessageInfo)ret.getUpdateInfo();
    }
    else if (sRealAction.startsWith("View"))
    {
       info = omBean.get(request);
    }
    else// if (sRealAction.startsWith("Add_")||sRealAction.startsWith("Update_"))
    {
       if (!ret.isSuccess())
       {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
       }
       else
       {
         if (sRealAction.startsWith("Add"))
            sDisplayMessage = mcBean.getLabel("om-added");//"The message is added successfully.";
         else if (sRealAction.startsWith("Update"))
            sDisplayMessage = mcBean.getLabel("om-updated");//"The message is updated successfully.";
         else// if (sRealAction.startsWith("Update"))
            sDisplayMessage =  mcBean.getLabel("om-comment");//"You make comments/answer on the message successfully.";
       }

       info = (OnlineMessageInfo)ret.getUpdateInfo();
    }

    WebPageInfo wpInfo = mcBean.getWebPageByPageId(onInfo.MemberID, info.PageID);

    String[] arAt = Utilities.getValue(wpInfo.Attributes).split("\\|");
    byte nPostBy = 0;
    byte nModifyBy = 64;
    byte nAllow = 0;
    byte nActive = 1;
    if (arAt.length>0)
      nPostBy = Utilities.getByte(arAt[0], (byte)0);
    if (arAt.length>1)
      nModifyBy = Utilities.getByte(arAt[1], (byte)0);
    if (arAt.length>2)
      nAllow = Utilities.getByte(arAt[2], (byte)0);
    if (arAt.length>3)
      nActive = Utilities.getByte(arAt[3], (byte)1);
    String sButtonName = "Comments";
    if (arAt.length>4)
      sButtonName = arAt[4];
    
    String sPostAction = "_OnlineMessageDetail";
%>
<% if (wpInfo.ShowWay>0) { %>
<%@ include file="../include/htmlheader.jsp"%>
<% } %>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/onlinemessage.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/attachefiles.js" type="text/javascript"></SCRIPT>
<table width="100%" align="center">
<tr>
 <td>
  <%@ include file="../util/uploadprocess.jsp"%>
 </td>
</tr>
<tr>
 <td>
<SPAN id="WorkingSection">
<table width="100%" cellpadding="0" cellspacing="1" border="0" align="center" style="border-bottom: 1px dashed #cccccc">
  <tr class="normal_rowxx">
    <td align="right" height="26" id="id_gotopage">
     <span class="pagination"><%=omBean.getPrevNextLinks2("index.jsp?accessby=" +wpInfo.AccessMode +"&messageid="+info.MessageID+'&', "_OnlineMessageDetail", true)%>&nbsp;
     <a href="javascript:;" onClick="javascript:showGoToPageForm(document.gotopage_form, 'id_gotopage', 'id_pageform');" title='<%=mcBean.getLabel("cm-dropdowntip")%>'><img id="img_downarrow" src="/staticfile/web/images/arrowdown.gif" alt='<%=mcBean.getLabel("cm-gotopage")%>' border=0 /></a>
     </span>
    </td>
  </tr>
</table>
<TABLE border=0 cellspacing=0 cellpadding=5 width="100%" class="facetlist">
<% if (wpInfo.ShowWay>0) { %>
<TR>
 <TD colspan=2>
<%@ include file="../include/pagetitle.jsp"%>
 </TD>
</TR>
<% } %>
<TR>
  <TD colspan=2 height="1">
   <%@ include file="../include/information.jsp"%>
  </TD>
</TR>    
<TR>
  <td id="id_message_<%=info.MessageID%>" align="center"><font size="4"><%=info.Title%></font></td>
<% if (omBean.canHandleMessage(nModifyBy, mbInfo, info.SenderID)) { %>
  <td width="1%" nowrap valign="middle">[ <a onClick="javascript:showEditMessageForm(document.form_message, 'id_message_<%=info.MessageID%>', '<%=mcBean.encodedUrl("ajax/response.jsp?action=GetOnlineMessage&messageid="+info.MessageID)%>', <%=info.MessageID%>, '<%=mcBean.getLabel("om-editmsg")%>', '<%=mcBean.getLabel("cm-update")%>');" href="#"><%=mcBean.getLabel("cm-edit")%></a>,
      <a href='<%=mcBean.encodedUrl("index.jsp?action=Delete_OnlineMessageDetail&messageid="+info.MessageID+"&pid="+info.PageID)%>' onClick="return confirm('<%=mcBean.getLabel("cm-confirmremove")%>');"><%=mcBean.getLabel("cm-delete")%></a> ]
  </td>
<% } %>
</TR>
<TR>
  <td colspan="2"><%=Utilities.getValue(info.Content)%></td>
</TR>
<TR>
  <td colspan="2" height="5"></td>
</TR>
<TR class="even">
  <td colspan="2" style1="PADDING: 5px">
   <table width="100%">
    <tr>
     <td width="14%" align="right"><b><%=mcBean.getLabel("om-title")%>:</b></td>
     <td><%=info.Title%></td>
    </tr>
<% if (info.Url!=null && info.Url.length()>0) { %>
    <tr>
     <td width="14%" align="right"><b>Url:</b></td>
     <td><a href='<%=info.Url%>' target='_blank'><%=info.Url%></a></td>
    </tr>
<% } %>
<% if (info.m_Tags!=null && info.m_Tags.length()>0) { %>
    <tr>
     <td width="14%" align="right"><b><%=mcBean.getLabel("cm-tag")%>:</b></td>
     <td><%=info.m_Tags%></td>
    </tr>
<% } %>
<% if ((info.AuthorName!=null && info.AuthorName.length()>0) || (info.EMail!=null && info.EMail.length()>0)) { %>
    <tr>
     <td width="14%" align="right"><b><%=mcBean.getLabel("cm-from")%>:</b></td>
     <td><%=Utilities.getValue(info.AuthorName)%> (<%=Utilities.getValue(info.EMail)%>)</td>
    </tr>
<% } %>       
    <tr>
     <td width="14%" align="right"><b><%=mcBean.getLabel("cm-date")%>:</b></td>
     <td>
      <table width="100%">
        <tr>
          <td width="80%"><%=Utilities.getDateValue(info.CreateDate, 19)%><% if(info.Active!=1){%>&nbsp;&nbsp; <b>(<%=mcBean.getLabel("om-notpublic")%>)</b><%}%>                    
          </td>
          <td align="right">
      </tr>
      </table>
     </td>
    </tr>
<% if (info.m_AttachedFiles!=null) { %>
    <tr>
     <td width="14%" align="right"><b><%=mcBean.getLabel("cm-attachment")%>:</b></td>
     <td></td>
    </tr>
   <tr>
    <td colspan="2" style="border-top:1px solid #DFDFDF">
     <table width="100%" cellpadding=1 cellspacing=0 border=0>
 <%
     String[] arFileId = info.m_AttachedIds.split(",");
     String[] arFileName = info.m_AttachedFiles.split("\\s*,\\s*");
     String[] arFileSize = info.m_FileSizes.split(",");
     String[] arDimension = info.m_Dimensions.split(",");

     for (int i=0; i<arFileId.length; i++) {
        String[] arLink = omBean.getAttachFileLink(Integer.parseInt(arFileId[i]), arFileName[i]);
        String sAttrInfo = Utilities.convertFileSize(Utilities.getLong(arFileSize[i], 0));
        if (!arDimension[i].startsWith("0"))
           sAttrInfo += ", " + arDimension[i];
 %>
       <tr>
        <td width="4%" height="22" align="center" style1="border-bottom:1px solid #DFDFDF"><%=(i+1)%>.</td>
        <td width="86%" style1="border-bottom:1px solid #DFDFDF"><%=arLink[0]%> (<%=sAttrInfo%>)</td>
        <td align="center" style1="border-bottom:1px solid #DFDFDF"><%=arLink[1]%></td>
       </tr>
 <% } %>
     </table>
    </td>
   </tr>
<% } %>
   </table>
  </td>
</TR>
<% if (info.m_CommentsCount>0) {
    List ltComments = omBean.getCommentsList(info.MessageID);
%>
<TR>
   <td colspan="2" height="10"><!--hr class="divider"--></td>
</TR>
<TR>
   <td colspan="2">&nbsp;&nbsp;<span class='pagetitle'>"<%=info.Title%>" <%=mcBean.getLabel("cm-has")%> <%=ltComments.size()%> <%=mcBean.getLabel("cm-comment")%>.</span></td>
</TR>
<tr>
 <td colspan="2">
  <table width="100%" cellpadding=4 cellspacing=0 border=0>
<%
  for (int i=0; i<ltComments.size(); i++) {
     OnlineMessageInfo commentInfo = (OnlineMessageInfo)ltComments.get(i);
%>
    <tr>
     <td width="1%" height="22" align="center" valign="top"><%=(i+1)%>.</td>
     <td valign="top"><font size="3" color="#bbbbbb"><%=Utilities.getValue(commentInfo.AuthorName)%> comments</font><br><font size="1" color="#bbbbbb"><%=Utilities.getDateValue(commentInfo.CreateDate, 19)%>
<% if (commentInfo.SenderWebUrl!=null && commentInfo.SenderWebUrl.length()>0) { %>
      &nbsp;&nbsp; <%=mcBean.getLabel("om-weburl")%>:&nbsp;&nbsp;<a href='<%=commentInfo.SenderWebUrl%>' target='_blank'><%=commentInfo.SenderWebUrl%></a>
<% } %>
<% if (commentInfo.m_AttachedFiles!=null && commentInfo.m_AttachedFiles.length()>0) { %>
   <br><%=mcBean.getLabel("cm-attachfile")%>:&nbsp;&nbsp;<%=omBean.getAttachFileGroupLink(commentInfo.m_AttachedIds, commentInfo.m_AttachedFiles)%>
<% } %>                                                                                                                      
     </font>
     </td>
    </tr>
    <tr style="border-bottom:1px solid #DFDFDF">
     <td width="1%" height="22" align="center"></td>
     <td><%=Utilities.getValue(commentInfo.Content)%></td>
    </tr>
  <% } %>
  </table>
 </td>
</tr>
<% } %>
<% if (nAllow!=0) { %>
<!-- TR>
   <td colspan="2" height="10"><hr class="line"></td>
</TR-->
<tr>
 <td id="id_comments_<%=info.MessageID%>" colspan="2">
  <table width="100%" cellpadding=0 cellspacing=0 border=0 style="border-top:1px solid #DFDFDF">
    <tr>
      <td width="98%" >&nbsp;</td>
      <td align="center" nowrap>
      <a onClick="javascript:showCommentMessageForm(document.form_message, 'id_comments_<%=info.MessageID%>', '<%=mcBean.encodedUrl("ajax/response.jsp?action=GetOnlineMessage&messageid="+info.MessageID)%>', <%=info.MessageID%>, '<%=sButtonName%>', '<%=(mbInfo!=null?mbInfo.getFullName():"")%>', '<%=(mbInfo!=null?mbInfo.EMail:"")%>');" href="#" title="<%=mcBean.getLabel("om-make")%> <%=sButtonName.toLowerCase()%>."><%=sButtonName%></a></td>
    </tr>
  </table>
 </td>
</tr>
<% } %>
</TABLE>
</SPAN>
</td>
</tr>
<TR>
  <TD colspan=1 align="center">
  <%@ include file="messageform.jsp"%>
  <DIV id="id_pageform" style="BORDER1: 1px solid; DISPLAY: none; Z-INDEX: 100; PADDING: 0px; MARGIN: 0px; POSITION: absolute">
  <FORM id="gotopage_form" name="gotopage_form" action='<%=omBean.encodedUrl("index.jsp")%>' method="post" onSubmit="return validateJumpPage(this, 1, <%=omBean.getTotalRows()%>);">
  <input type="hidden" name="action1" value="goto_OnlineMessageDetail">
  <input type="hidden" name="pid"  value="<%=info.PageID%>">
  <TABLE cellSpacing=1 cellPadding=4 border=0 class="dwform_popup">
    <TR>
      <TD class='dwform_field' noWrap><%=mcBean.getLabel("cm-gotopage")%>...</TD>
    </TR>
    <TR>
      <TD class='dwform_option'>
        <INPUT class="dwform_input" name='page' style="FONT-SIZE: 11px" size=4 onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
        <INPUT class="dwform_button" type="submit" name="submit" value="<%=mcBean.getLabel("cm-go")%>" title='<%=mcBean.getLabel("cm-jumpto")%>'>
     </TD>
    </TR>
  </TABLE>
  </FORM>
  </DIV>
  </TD>
<TR>
</table>
<% if (wpInfo.ShowWay>0) { %>
</BODY>
</HTML>
<% }%>