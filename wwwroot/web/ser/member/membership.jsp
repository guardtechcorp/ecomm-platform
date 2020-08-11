<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MembershipBean" %>
<%@ page import="com.zyzit.weboffice.model.MembershipInfo" %>
<%
{
    MembershipBean bean = MembershipBean.getObject(session);
    MembershipInfo info;
    if (sRealAction.startsWith("Update"))
    {
//       ret = bean.update(request);
       info = (MembershipInfo)ret.getUpdateInfo();
       if (!ret.isSuccess())
       {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
       }
       else
       {
           sDisplayMessage = mcBean.getLabel("ms-updatesuccess");//DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "membership");
       }
    }
    else
    {
      info = bean.getSiteMembershipInfo();
      info.MemberID = mbInfo.MemberID;  
    }
//MembershipBean.dumpAllParameters(request);

   String sSubjectNote = null;//mcBean.getTemplateSubject("SignUp-Note");
   String sContentNote = null;//mcBean.getTemplateContent("SignUp-Note");

   boolean bCanHavePaidMembership = bean.canHavePaidService(mbInfo.MemberID, 6);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<TABLE cellpadding="2" cellspacing="2" border="0" width="100%">
 <TR>
 <TD>
<FORM name="form_membership" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateMembership(this);">
<input type="hidden" name="membershipid" value="<%=info.MembershipID%>">
<input type="hidden" name="memberid" value="<%=info.MemberID%>">
<input type="hidden" name="action1" value="Update_Membership">
<table class="table-outline" width="100%" align="center">
<tr>
 <td colspan="3" height="1">
  <%@ include file="../include/promotenote.jsp"%>
 </td>
</tr>
 <tr>
  <td colspan="3" height="1">
   <%@ include file="../include/information.jsp"%>
  </td>
</tr>
<tr>
 <td height="25" width="30%" align="right"><%=mcBean.getLabel("ms-howtojoin")%>:</td>
 <td width="1%">&nbsp;</td>
 <td>
  <select name="jointype" onChange="onJoinTypeChange(document.form_membership, <%=bCanHavePaidMembership%>)">
   <option value=0 <%=bean.getSelected(0, info.JoinType)%>><%=mcBean.getLabel("ms-freeapprove")%></option>
   <option value=1 <%=bean.getSelected(1, info.JoinType)%>><%=mcBean.getLabel("ms-withoutapprove")%></option>
   <option value=2 <%=bean.getSelected(2, info.JoinType)%>><%=mcBean.getLabel("ms-needbuy")%></option>
   <option value=3 <%=bean.getSelected(3, info.JoinType)%>><%=mcBean.getLabel("ms-notsupport")%></option>
  </select>
 </td>
</tr>
<tr>
 <td height="25" width="30%" align="right"><%=mcBean.getLabel("ms-term")%>:</td>
 <td width="1%">&nbsp;</td>
 <td>
  <select name="terms" <%=info.JoinType==3?"disabled":""%>>
   <option value=0 <%=bean.getSelected(0, info.Terms)%>><%=mcBean.getLabel("ms-perpetual")%></option>
   <option value=1 <%=bean.getSelected(1, info.Terms)%>><%=mcBean.getLabel("ms-daily")%></option>
   <option value=2 <%=bean.getSelected(2, info.Terms)%>><%=mcBean.getLabel("ms-weekly")%></option>
   <option value=3 <%=bean.getSelected(3, info.Terms)%>><%=mcBean.getLabel("ms-monthly")%></option>
   <option value=4 <%=bean.getSelected(4, info.Terms)%>><%=mcBean.getLabel("ms-quarterly")%></option>
   <option value=5 <%=bean.getSelected(5, info.Terms)%>><%=mcBean.getLabel("ms-halfyear")%></option>
   <option value=6 <%=bean.getSelected(6, info.Terms)%>><%=mcBean.getLabel("ms-annually")%></option>
  </select> <%=mcBean.getLabel("ms-howlongdes")%>
 </td>
</tr>
<tr>
 <td colspan="3">
  <SPAN id="payment_section" style='display:<%=(info.JoinType==2?"inline":"none")%>'>
   <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
     <td height="25" width="30%" align="right"><%=mcBean.getLabel("ms-servicefee")%>:</td>
     <td width="1%">&nbsp;</td>
     <td> <input type="text" name="price" value="<%=Utilities.getValue(info.Price)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");' size="8">
         <%=mcBean.getLabel("ms-servicefeedes")%>
     </td>
    </tr>
    <tr>
     <td height="25" width="18%" align="right"><%=mcBean.getLabel("ms-paythrough")%>:</td>
     <td width="1%">&nbsp;</td>
     <td>
      <select name="vendorname">
       <option value="Paypal">PayPal</option>
      </select> <%=mcBean.getLabel("ms-vendorname")%>
     </td>
    </tr>
    <tr>
     <td height="25" width="30%" align="right"><%=mcBean.getLabel("ms-accountname")%>:</td>
     <td width="1%">&nbsp;</td>
     <td> <input type="text" name="account" value="<%=Utilities.getValue(info.Account)%>" size="30" maxlength="60"> <%=mcBean.getLabel("ms-accountnamedes")%></td>
    </tr>
<% if (!bCanHavePaidMembership) { %>
   <tr>
    <td height="25" width="30%" align="right"></td>
    <td width="1%">&nbsp;</td>
    <td><%=mcBean.getLabel("ms-haveto")%> <a href="<%=mcBean.encodedUrl("index.jsp?action=Load_PaidService&rl=1&pt=My Advanced Services")%>"><%=mcBean.getLabel("ms-purchase")%></a> <%=mcBean.getLabel("ms-activeit")%></td>
   </tr>
<% } %>
  </table>
 </SPAN>
 </td>
</tr>
<tr>
 <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
</tr>
<tr>
 <td class="row1" width="30%" align="right">&nbsp;</td>
 <td width="1%">&nbsp;</td>
 <td class="row1">
  <input type="submit" name="submit" style='width:120px' value="<%=mcBean.getLabel("cm-update")%>" onClick="setAction(document.form_membership, 'Update_Membership');">
  </td>
</tr>
</table>
</FORM>
 <SCRIPT>onMembershipFormLoad(document.form_membership);</SCRIPT>
  </TD>
 </TR>
</TABLE>    
<% } %>