<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.OnlineMessageBean" %>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.zyzit.weboffice.model.OnlineMessageInfo" %>
<%@ page import="com.zyzit.weboffice.internet.FetchEmail" %>
<%@ page import="com.zyzit.weboffice.internet.Pop3Client" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="static com.zyzit.weboffice.internet.Pop3Client.*" %>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    OnlineMessageBean omBean = OnlineMessageBean.getObject(session);
//OnlineMessageBean.dumpAllParameters(request);

    int nPageId;
    if (sRealAction.startsWith("Add_")||sRealAction.startsWith("Update_"))
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
            sDisplayMessage = mcBean.getLabel("om-added");//"The online message is added successfully.";
         else
            sDisplayMessage = mcBean.getLabel("om-updated");//"The online message is updated successfully.";
       }

       OnlineMessageInfo info = (OnlineMessageInfo)ret.getUpdateInfo();
       nPageId = info.PageID;//Utilities.getInt(OnlineMessageBean.getParamter(ret, "pid"), 0);
    }
    else if (sRealAction.startsWith("Delete"))
    {
        ret = omBean.delete(request, true);
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
        else
           sDisplayMessage = mcBean.getLabel("om-deleted");//"The online message is removed successfully.";

       nPageId = omBean.getPageID(request);// Utilities.getInt(request.getParameter("pid"), 0);
    }
    else
    {
        if (sRealAction.startsWith("Update Rows"))
        {
            omBean.changeMaxRowsPerPage(request);

//            int nTotalMail = OnlineMessageBean.processEmailMessage("www.webcenternode.com", "pop.gmail.com", 995, "message@webcenternode.com", "neil99759");
//            System.out.println("nTotalMail=" + nTotalMail);
/*
            FetchEmail gmail = new FetchEmail("pop.gmail.com", 995, "message@webcenternode.com", "neil99759");
            int nTotal = gmail.connect();
            for (int i=0; i<nTotal; i++)
            {
                FetchEmail.IEmail mail = gmail.fetchMessage((i+1), true);
                if (mail!=null)
                {
                    System.out.println("-------------- " + (i+1) + " ---------------------");
                    System.out.println("Content Type: " + mail.getContentType() + ", "  + mail.getSize());
                    System.out.println("Subject: " + mail.getSubject());
                    System.out.println("From: " + mail.getFrom(1) + "-->" + mail.getFrom(2));
                    System.out.println("Date: " + mail.getSendDate() + ", " + mail.getReceiveDate());
//                    System.out.println("Body: \n" + mail.getBodyText());
                    int nAttachedFiles = mail.countAttachments();
                    System.out.println("Total Attached Files: " + mail.countAttachments());
                    for (int k=0; k<nAttachedFiles; k++)
                    {
                       FetchEmail.Attachment at = mail.getAttachment(k);
                       System.out.println("-------------" + (i+1) + ". Filename: " + at.filename + ", id=" + at.contentId);
                       System.out.println(". Type: " + at.contentType + ", size=" + at.content.length);
                    }
                }
            }
//            gmail.disconnect();

          Pop3Client pop = new Pop3Client("c:\\temp", "pop.gmail.com",  "message@webcenternode.com", "neil99759", POPS_PORT, POP);
          pop.setDebug(false);
          pop.setSocketTimeout(5000);
*/

/*
            String sFilename = "c:/temp/chinese-mail11.eml";
            MimeMessage mimeMsg = FetchEmail.getMimeMessage(sFilename);

            FetchEmail.IEmail mail = FetchEmail.parseEMail(mimeMsg);
            if (mail!=null)
            {
               System.out.println("Content Type: " + mail.getContentType() + ", "  + mail.getSize());
               System.out.println("Subject: " + mail.getSubject());

               System.out.println("From: " + mail.getFrom(0));
//               System.out.println("Body: \n" + mail.getBodyText());
Utilities.storeTextFile("c:/temp/test.html", "Subject: " + mail.getSubject() + "<br>" + mail.getBodyText());

               int nAttachedFiles = mail.countAttachments();
               System.out.println("Total Attached Files: " + mail.countAttachments());
               for (int k=0; k<nAttachedFiles; k++)
               {
                  FetchEmail.Attachment at = mail.getAttachment(k);
                  System.out.println("-------------" + (k+1) + ". Filename: " + at.filename + ", id=" + at.contentId);
                  System.out.println(". Type: " + at.contentType + ", size=" + at.content.length);

                  Utilities.storeBinaryFile("c:/temp/" + at.filename, at.content); 
               }
            }
 */
        }

        nPageId = omBean.getPageID(request);// Utilities.getInt(request.getParameter("pid"), 0);
    }

    WebPageInfo wpInfo = mcBean.getWebPageByPageId(onInfo.MemberID, nPageId);

    String[] arAt = Utilities.getValue(wpInfo.Attributes).split("\\|");
    byte nPostBy = Definition.ACCESSMODE_MYSITEMEMBER;
    byte nModifyBy = Definition.ACCESSMODE_MYSITEMEMBER;
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

//Utilities.dumpObject(wpInfo);
    int nViewerId = (mbInfo!=null)?mbInfo.MemberID : -1;

    List ltArray;
    if (sRealAction.startsWith("Search"))
      ltArray = omBean.search(request, "index.jsp?action=Switch Page_OnlineMessageList&pid="+nPageId, nPageId, nViewerId);
    else
       ltArray = omBean.getPage(request, "index.jsp?action=Switch Page_OnlineMessageList&pid="+nPageId, nPageId, nViewerId, sRealAction);
    String sPostAction = "_OnlineMessageList";
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
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
<% if (wpInfo.ShowWay>0) { %>
<TR>
 <TD colspan=2>
<%@ include file="../include/pagetitle.jsp"%>
 </TD>
</TR>
<% } %>
<!--TR>
  <TD colspan=2><HR class='divider' /></TD>
</TR-->
<TR>
  <TD colspan=2 height="1">
   <%@ include file="../include/information.jsp"%>
  </TD>
</TR>
<form name="common_search"  method="post" action="<%=omBean.encodedUrl("index.jsp")%>" onSubmit="return validateSearchMessage(this);">
<input type="hidden" name="action1" value="Search_OnlineMessageList">
<input type="hidden" name="accessby" value="<%=wpInfo.AccessMode%>">
<input type="hidden" name="memberid" value="<%=onInfo.MemberID%>">
<input type="hidden" name="pid" value="<%=wpInfo.PageID%>">
<TR>
 <TD colspan=2>
  <TABLE border=0 cellspacing=0 cellpadding=0 width="100%" height="30">
   <TR>
    <TD align="left" width="50%">
    <INPUT style="width:200px" name="keywords" id="keywords" type="text"/><INPUT type="submit" name="submit" class="searchbutton" value="Search" />&nbsp;
    <a href="#" onclick="return showAdvancedSearcbBox('advanced_searchbox');" class1='Toplink'><%=mcBean.getLabel("cm-advanced")%></a>
    </TD>
    <TD align="left" width="24%"><%=mcBean.getLabel("cm-sortby")%>:
     <select name="sortedby" onChange="sortByMessageField(this, '<%=omBean.encodedUrl("index.jsp?action=Sort_OnlineMessageList&pid="+nPageId)%>');">
     <option value="CreateDate DESC" <%=omBean.getSelected("CreateDate DESC", omBean.getSortFieldName())%>><%=mcBean.getLabel("om-latdate")%></option>
     <option value="CreateDate ASC" <%=omBean.getSelected("CreateDate ASC", omBean.getSortFieldName())%>><%=mcBean.getLabel("om-eardate")%></option>
     <option value="Title ASC" <%=omBean.getSelected("Title ASC", omBean.getSortFieldName())%>><%=mcBean.getLabel("om-titleasc")%></option>
     <option value="Title DESC" <%=omBean.getSelected("Title DESC", omBean.getSortFieldName())%>><%=mcBean.getLabel("om-titledesc")%></option>
     </select>
    </TD>
    <TD align="right"><%=mcBean.getLabel("cm-maxrow")%>:
     <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=omBean.encodedUrl("index.jsp?action=Update Rows_OnlineMessageList")%>');">
     <%=omBean.getRowsPerPageList(-1)%>
     </select>
     </TD>
    </TR>
   </TABLE>
  </TD>
</TR>
</form>
<TR>
 <TD id="advanced_searchbox" colspan=2 style="display:none">
 <%@ include file="advancesearch.jsp"%>
 </TD>
</TR>
 <tr class="normal_row">
  <td colspan=2>
   <table width="100%">
    <tr>
      <td id="id_newmessage1" style="border-bottom: 1px">
<% if (omBean.canHandleMessage(nPostBy, mbInfo, -1)) { %>
      &nbsp;&nbsp;<a onClick="javascript:showNewMessageForm(document.form_message, 'id_newmessage1', '<%=mcBean.getLabel("om-addmsg")%>', '<%=mcBean.getLabel("cm-add")%>');" href="javascript:;" class='Titlelink'><%=mcBean.getLabel("om-addmsg")%></a>
<% } %>
      </td>
      <td id="id_gotopage" width="80%" align="right"><%=omBean.encodedHrefLink(omBean.getCacheData(omBean.KEY_PAGELINKS), true)%>
      </td>
    </tr>
   </table>
  </td>
 </tr>
<TR>
  <TD colspan=2 height="5"></TD>
</TR>
<TR>
  <TD colspan=2>
   <TABLE border=0 cellspacing=0 cellpadding=0 width="100%" class="facetlist">
<% if (ltArray==null||ltArray.size()==0) { %>
   <tr class="even">
    <td colspan="2" style="PADDING: 5px"><%=mcBean.getLabel("cm-norecord")%></td>
   </tr>
<% } else { %>
<%
  int nStartNo = Utilities.getInt(omBean.getCacheData(omBean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
    OnlineMessageInfo info = (OnlineMessageInfo)ltArray.get(i);
    StringBuffer sbContent = new StringBuffer();
//    sbContent.append("<a href='" + omBean.encodedUrl("index.jsp?action=View_OnlineMessageDetail&messageid="+info.MessageID+"&pt=") + "' class='Titlelink'><IMG border=0 style='PADDING-RIGHT: 0px; FLOAT: right' alt='View Message' src='/staticfile/web/images/linkarrow.gif'> " + info.Title + "</a>");
    String sTitle = "<a href='" + omBean.encodedUrl("index.jsp?action=View_OnlineMessageDetail&pid="+nPageId+"&messageid="+info.MessageID+"&pt=") + "' class='Titlelink'>" + info.Title + "</a>";
    if (info.Url!=null && info.Url.length()>0)
       sbContent.append("Url:&nbsp;&nbsp;<a href='" + info.Url + "' target='_blank'>" + info.Url + "</a>");
    sbContent.append("<div style='COLOR: rgb(1,116,22)'>");
    if (info.AuthorName!=null && info.AuthorName.length()>0)
       sbContent.append(mcBean.getLabel("om-authorname") + ":&nbsp;&nbsp;" + info.AuthorName);
    if (info.EMail!=null && info.EMail.length()>0)
       sbContent.append("&nbsp;&nbsp;&nbsp;&nbsp;" + mcBean.getLabel("cm-email") + ":&nbsp;&nbsp;" + info.EMail);
    if (info.m_Tags!=null)
       sbContent.append("<br>" + mcBean.getLabel("cm-tag") + ":&nbsp;&nbsp;" + info.m_Tags);
    if (info.m_AttachedFiles!=null && info.m_AttachedFiles.length()>0)
       sbContent.append("<br>" + mcBean.getLabel("om-attachfile") + ":&nbsp;&nbsp;" + omBean.getAttachFileGroupLink(info.m_AttachedIds, info.m_AttachedFiles));
    sbContent.append("<br><a href='" + omBean.encodedUrl("index.jsp?action=View_OnlineMessageDetail"+"&pid="+nPageId +"&messageid="+info.MessageID+"&pt=") + "'><IMG border=0 style='PADDING-RIGHT: 0px; FLOAT: right' alt='" + mcBean.getLabel("om-viewmsg") +"' src='/staticfile/web/images/linkarrow.gif'></a>");
    sbContent.append(mcBean.getLabel("om-createon") + ":&nbsp;&nbsp;" + Utilities.getDateValue(info.CreateDate, 19));
    if (info.Active!=1)
       sbContent.append("&nbsp;&nbsp; <b>(" + mcBean.getLabel("om-notpublic") + ")</b>");    
    if (info.m_CommentsCount>0)
       sbContent.append("&nbsp;&nbsp;&nbsp;&nbsp;" + mcBean.getLabel("om-comment") + "&nbsp;&nbsp;" + info.m_CommentsCount);       
    sbContent.append("</div>");
%>
<tr class="even">
 <td colspan="2" style="PADDING: 5px">
  <table border=0 cellspacing=0 cellpadding=0 width="100%">
   <tr>
    <td id="id_message_<%=i%>"><%=sTitle%></td>
<% if (omBean.canHandleMessage(nModifyBy, mbInfo, info.SenderID)) { %>
   <td width="1%" nowrap valign="top" style="PADDING: 5px">[ <a onClick="javascript:showEditMessageForm(document.form_message, 'id_message_<%=i%>', '<%=mcBean.encodedUrl("ajax/response.jsp?action=GetOnlineMessage&messageid="+info.MessageID)%>', <%=info.MessageID%>, '<%=mcBean.getLabel("om-editmsg")%>', '<%=mcBean.getLabel("cm-update")%>');" href="#"><%=mcBean.getLabel("cm-edit")%></a>,
     <a href='<%=mcBean.encodedUrl("index.jsp?action=Delete_OnlineMessageList&messageid="+info.MessageID+"&pid="+info.PageID)%>' onClick="return confirm('<%=mcBean.getLabel("cm-confirmremove")%>');"><%=mcBean.getLabel("cm-delete")%></a> ]
   </td>
<% } %>
  </tr>
  <tr>
   <td colspan="2" ><%=sbContent.toString()%></td>
  </tr>
 </table>
</td>
</tr>
<% if (i<ltArray.size()-1) { %>
 <tr>
  <td colspan=2 height="5"></td>
 </tr>
<% } %>
<% } %>
<% } %>
  </TABLE>
 </TD>
</TR>
<% if (ltArray!=null && ltArray.size()>10) { %>
<tr>
 <td colspan="2" height="5"></td>
</tr>
<tr class="normal_row">
  <td colspan=2>
   <table width="100%">
    <tr>
     <td id="id_newmessage2" style="border-bottom: 1px"><!-- &nbsp;&nbsp;<a onClick="javascript:showNewMessageForm(document.form_message, 'id_newmessage2');" href="javascript:;" class='Titlelink'>Add Message</a>--></td>
     <td id="id_gotopage2" width="80%" align="right"><%=omBean.encodedHrefLink(omBean.getCacheData(omBean.KEY_PAGELINKS), true)%></td>
    </tr>
   </table>
  </td>
</tr>
<% } %>
 <TR>
   <TD colspan=2 align="center">
   <%@ include file="messageform.jsp"%>
   <DIV id="id_pageform" style="BORDER1: 1px solid; DISPLAY: none; Z-INDEX: 100; PADDING: 0px; MARGIN: 0px; POSITION: absolute">
   <FORM id="gotopage_form" name="gotopage_form" action='<%=omBean.encodedUrl("index.jsp")%>' method="post" onSubmit="return validateJumpPage(this, 1, <%=omBean.getTotalPages()%>);">
   <input type="hidden" name="action1" value="goto_OnlineMessageList">
   <input type="hidden" name="pid"  value="<%=nPageId%>">
   <TABLE cellSpacing=1 cellPadding=4 border=0 class="dwform_popup">
     <TR>
       <TD class='dwform_field' noWrap><%=mcBean.getLabel("cm-gotopage")%>...</TD>
     </TR>
     <TR>
       <TD class='dwform_option'>
         <INPUT class="dwform_input" name='page' style="FONT-SIZE: 11px" size=4 onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
         <INPUT class="dwform_button" type="submit" name="submit" value='<%=mcBean.getLabel("cm-go")%>' title='<%=mcBean.getLabel("cm-jumpto")%>'>
      </TD>
     </TR>
   </TABLE>
   </FORM>
   </DIV>
<!--
<TABLE cellSpacing=1 cellPadding=4 border=0>
<tr>
 <td width="500"></td>
 <td id="id_gotopage"><a href="javascript:;" onClick="javascript:showGoToPageForm(document.gotopage_form, 'id_gotopage', 'id_pageform');"><img id="img_downarrow" src="arrowdown.gif" alt="Go to Page" border=0 /></a></td>
</tr>
</TABLE>
-->       
   </TD>
 <TR>
</table>
</SPAN>
</td>
</tr>
</table>
<% if (wpInfo.ShowWay>0) { %>
</BODY>
</HTML>
<% }}%>
