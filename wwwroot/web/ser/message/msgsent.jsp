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
<TABLE  width="100%" align="right" border=0>
 <TR>
  <TD>
   <table width="100%" cellpadding="0" cellspacing="1" border="0" align="center">
    <tr>
     <td></td>
     <td align="right">
      <%=bean.getPrevNextLinks("index.jsp?", "_MsgSent", true)%>&nbsp;
     </td>
    </tr>
   </table>
  </TD>
 </TR>
 <TR>
  <TD>
   <form name="form_message" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onsubmit="return validateForwardMessage(this);">
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
      <td class="row1" width="18%" height="20" align="right">To: &nbsp;</td>
      <td class="row1" width="45%" height="20"><b><%=Utilities.getValue(info.m_Name)%></b></td>
      <td class="row1" width="15%" height="20" align="right">Submitted Date: &nbsp;</td>
      <td class="row1" height="22"><b><%=Utilities.getDateValue(info.CreateDate, 19)%></b></td>
    </tr>
    <tr>
     <td colspan="4" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="row1" width="18%" height="20" align="right">Subject: &nbsp;</td>
      <td class="row1" height="12" colspan="3"><b><%=info.Subject%></b></td>
    </tr>
<% if (info.ReceiverID>0) { %>
    <tr>
      <td class="row1" width="18%" height="22" align="right" valign="top">Message: &nbsp;</td>
      <td class="row1" height="12" colspan="3">
      <table width="98%" align="left" border="0" cellpadding="0" cellspacing="2"  style1="border: 1px solid #DFDFDF; background-color:#EFF7FE">
       <tr>
        <td height="24" valign="top"><font color="green">
        <b><%=Utilities.replaceContent(Utilities.getValue(info.Content), "\n", "<br>")%></b>
        </font>
        </td>
       </tr>
      </table>
      </td>
    </tr>
<% } else { %>
    <tr>
     <td class="row1" width="18%" height="20" align="right">Keywords:&nbsp;</td>
     <td colspan="4"><b><%=info.Keywords%></b></td>
    </tr>
    <tr>
      <td class="row1" width="18%" height="20" align="right">Brief Description:&nbsp;</td>
      <td class="row1" height="12" colspan="3">
      <table width="98%" align="left" border="0" cellpadding="0" cellspacing="0"  style1="border: 1px solid #DFDFDF; background-color:#EFF7FE">
       <tr>
        <td height="20"><font color="green">
        <b><%=Utilities.replaceContent(Utilities.getValue(info.BriefDesc), "\n", "<br>")%></b>
        </font>
        </td>
       </tr>
      </table>
      </td>
    </tr>
    <tr>
      <td class="row1" width="18%" height="20" align="right" >Detail Description:&nbsp;</td>
      <td class="row1" height="12" colspan="3">
      <table width="98%" align="left" border="0" cellpadding="0" cellspacing="0"  style1="border: 1px solid #DFDFDF; background-color:#EFF7FE">
       <tr>
        <td height="20"><font color="green">
        <b><%=Utilities.replaceContent(Utilities.getValue(info.Content), "\n", "<br>")%></b>
        </font>
        </td>
       </tr>
      </table>
      </td>
    </tr>
    <tr>
     <td class="row1" width="18%" height="20" align="right">Purchase Type:&nbsp;</td>
     <td class="row1" height="12" colspan="3"><b><%=bean.getPurchaseType(info)%></b></td>
    </tr>
    <tr>
     <td class="row1" width="18%" height="20" align="right">Valid within:&nbsp;</td>
     <td class="row1" height="12" colspan="3"><b><%=Utilities.getDateValue(info.ActionDate, 10)%></b></td>
    </tr>
    <tr>
     <td class="row1" width="18%" height="20" align="right">Price Range:&nbsp;</td>
     <td class="row1" height="12" colspan="3"><b><%=bean.getPriceRange(info)%></b></td>
    </tr>
    <tr>
     <td class="row1" width="18%" height="20" align="right">Minimum Order:&nbsp;</td>
     <td class="row1" height="12" colspan="3"><b><%=bean.getMinOrderQty(info)%></b></td>
    </tr>
<% } %>

    <tr>
     <td colspan="4" align="center"><hr width="98%"></td>
    </tr>
    <tr>
    <td class="row1" width="18%" height="20" align="right">Forward it to:&nbsp;</td>
    <td class="row1" width="45%" height="20"><input maxlength=255 size=60 value="<%=mbInfo.EMail%>" name="emails"></td>
    <td class="row1" width="15%" height="20" colspan="2">&nbsp;<input type="submit" name="submit" value="Send" onClick="setAction(document.form_message, 'Forward_MsgSent');">
    (Multiples separated by comma).
    </td>
    </tr>
    <tr>
     <td colspan="4" height="10" class="spaceRow"></td>
    </tr>
    </table>
   </form>
  </TD>
 </TR>
</TABLE>
<% } %>