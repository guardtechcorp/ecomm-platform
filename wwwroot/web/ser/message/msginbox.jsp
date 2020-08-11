<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MessageBean"%>
<%@ page import="com.zyzit.weboffice.model.MessageInfo"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%
{
    MessageBean bean = new MessageBean(session, 16, true);

    MessageInfo info = null;
    if (sRealAction.startsWith("prev") || sRealAction.startsWith("next"))
    {
       info = bean.getPrevOrNext(sRealAction);
//System.out.println("cgInfo = "+ cgInfo);
    }
    else if (sRealAction.startsWith("Replay"))
    {
//MessageBean.dumpAllParameters(request);
        ret = bean.replayMessage(request);
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
        else
           sDisplayMessage = "Your replay message is successfully send to the sender.";

        info = (MessageInfo) ret.getUpdateInfo();
    }
    else if (sRealAction.startsWith("Forward"))
    {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
        else
            sDisplayMessage = (String)ret.getInfoObject();
        info = (MessageInfo) ret.getUpdateInfo();
    }    
    else// if (sRealAction.startsWith("Edit"))
    {
       info = bean.get(request);
//Utilities.dumpObject(info);
    }

    MemberInfo senderInfo = bean.getSenderInfo(info.SenderID);
//bean.showAllParameters(request, out);
//Utilities.dumpObject(info);
    sPageTitle = "View/Apply Message";
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/message.js" type="text/javascript"></SCRIPT>
   <table width="100%" cellpadding="0" cellspacing="1" border="0" align="center">
    <tr>
     <td></td>
     <td align="right">
      <%=bean.getPrevNextLinks("index.jsp?", "_MsgInbox", true)%>&nbsp;
     </td>
    </tr>
   </table>
   <form name="form_message" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onsubmit="return validateMessage(this);">
   <input type="hidden" name="messageid" value="<%=info.MessageID%>">
   <input type="hidden" name="senderid" value="<%=info.SenderID%>">
   <input type="hidden" name="receivedid" value="<%=info.ReceiverID%>">
   <input type="hidden" name="productid" value="<%=info.ProductID%>">
   <input type="hidden" name="action1" value="">       
   <table class="table-1" width="100%" cellpadding="0" cellspacing="0" border="0" align="center" style="background-color:#EEEEEE">
    <tr>
      <td colspan="4" height="6"></td>
    </tr>
    <tr>
      <td class="row1" width="14%" height="20" align="right">Sender: &nbsp;</td>
      <td class="row1" width="37%" height="20"><b><%=Utilities.getValue(senderInfo.FirstName)%></b></td>
      <td class="row1" width="14%" height="20" align="right">Received Date: &nbsp;</td>
      <td class="row1" height="22"><b><%=Utilities.getDateValue(info.CreateDate, 16)%></b></td>
    </tr>
    <tr>
      <td class="row1" width="14%" height="20" align="right">Phone No: &nbsp;</td>
      <td class="row1" width="37%" height="20"><b><%=Utilities.getValue((senderInfo.WorkPhone!=null)?senderInfo.WorkPhone:senderInfo.HomePhone)%></b> </td>
      <td class="row1" width="14%" height="20" align="right">E-Mail: &nbsp;</td>
      <td class="row1" height="20"><b><%=Utilities.getValue(senderInfo.EMail)%></b></td>
    </tr>
    <tr>
     <td colspan="4" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="row1" width="14%" height="20" align="right">Subject: &nbsp;</td>
      <td class="row1" height="12" colspan="3"><b><%=info.Subject%></b></td>
    </tr>
    <tr>
      <td class="row1" width="14%" height="20" align="right" valign="top">Message: &nbsp;</td>
      <td class="row1" height="12" colspan="3">
      <table width="98%" align="left" border="0" cellpadding="0" cellspacing="2"  style1="border: 1px solid #DFDFDF; background-color:#EFF7FE">
       <tr>
        <td height="20" valign="top"><font color="green">
        <b><%=Utilities.replaceContent(Utilities.getValue(info.Content), "\n", "<br>")%></b>
        </font>
        </td>
       </tr>
      </table>
      </td>
    </tr>
    <tr>
     <td colspan="4" align="center"><hr width="98%"></td>
    </tr>
    <tr>
      <td class="row1" width="14%" height="12" align="right" valign="top">Response: &nbsp;</td>
      <td class="row1" height="12" colspan="3"><textarea name="response" rows="8" cols="72" wrap="virtual"></textarea></td>
    </tr>
    <tr>
      <td colspan="4" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="4" align="center" height="22"><input type="submit" name="submit" value="Replay" onClick="setAction(document.form_message, 'Replay_MsgInbox');"></td>
    </tr>
   <tr>
    <td colspan="4" align="center"><hr width="98%"></td>
   </tr>
   <tr>
   <td class="row1" width="14%" height="20" align="right">Forward it to:&nbsp;</td>
   <td class="row1" width="45%" height="20"><input maxlength=255 size=60 value="<%=mbInfo.EMail%>" name="emails"></td>
   <td class="row1" width="14%" height="20" colspan="2">&nbsp;<input type="submit" name="submit" value="Send" onClick="setAction(document.form_message, 'Forward_MsgInbox');">
   (Multiples separated by comma).
   </td>
   </tr>

    <tr>
     <td colspan="4" height="10" class="spaceRow"></td>
    </tr>
    </table>
   </form>
  <SCRIPT>onMessageLoad(document.form_message);</SCRIPT>
<% } %>