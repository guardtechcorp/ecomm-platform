<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
    if (sRealAction.startsWith("Update"))
    {
        mbInfo = (MemberInfo) ret.getUpdateInfo();
        if (!ret.isSuccess()) {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        } else {
            sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", mcBean.getLabel("pf-accountinfo"));//"Account Information");
        }
    }
    else// if (sRealAction.startsWith("Edit"))
    {
//        info = bean.getMemberInfo();
    }

//    sPageTitle = "Profile Information";
//Utilities.dumpObject(info);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="form_account" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateAccount(this);">
<input type="hidden" name="memebrid" value="<%=mbInfo.MemberID%>">
<input type="hidden" name="action1" value="Update_Profile">
<table class="table-outline" width="100%" align="center">
 <TR>
   <TD colspan="3" height="1">
   <%@ include file="../include/information.jsp"%>
  </TD>
 </TR>
  <tr>
    <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-accountname")%> :</td>
    <td width="1%">&nbsp;</td>
    <td ><font size=2><b><%=mbInfo.EMail%></b></font></td>
  </tr>
  <tr>
    <td height="22" width="16%" align="right">* <%=mcBean.getLabel("pf-firstname")%> :</td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=30 size=40 value="<%=mbInfo.FirstName%>" name="firstname"></td>
  </tr>
  <tr>
   <td height="22" width="16%" align="right">* <%=mcBean.getLabel("pf-lastname")%>:</td>
   <td width="1%">&nbsp;</td>
   <td ><input maxlength=30 size=40 value="<%=mbInfo.LastName%>" name="lastname"></td>
  </tr>
  <tr>
   <td height="22" width="16%" align="right"> <%=mcBean.getLabel("pf-nickname")%>:</td>
   <td width="1%">&nbsp;</td>
   <td ><input maxlength=30 size=40 value="<%=Utilities.getValue(mbInfo.NickName)%>" name="nickname"></td>
  </tr>
  <tr>
   <td height="22" width="16%" align="right"> <%=mcBean.getLabel("pf-gender")%></td>
   <td width="1%">&nbsp;</td>
   <td>
    <select name="gender">
     <option value=1 <%=mcBean.getSelected(1, mbInfo.Gender)%>><%=mcBean.getLabel("pf-male")%></option>
     <option value=0 <%=mcBean.getSelected(0, mbInfo.Gender)%>><%=mcBean.getLabel("pf-female")%></option>
    </select>
   </td>
  </tr>
  <tr>
    <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
  </tr>
  <tr>
    <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-accounttype")%></td>
    <td width="1%">&nbsp;</td>
    <td>
<% if (mbInfo.Type==0) { %>
    <b><%=mcBean.getLabel("pf-commonuser")%></b>
<% } else if (mbInfo.Type==1) { %>
    <b><%=mcBean.getLabel("pf-siteownership")%></b>
<% } else { %>
    <b><%=mcBean.getLabel("pf-advanceduser")%></b>
<% } %>
    <!--select name="type">
      <option value=0 <%=mcBean.getSelected(0, mbInfo.Type)%>>Common Account</option>
      <option value=1 <%=mcBean.getSelected(1, mbInfo.Type)%>>Business</option>
      <option value=2 <%=mcBean.getSelected(2, mbInfo.Type)%>>Advanced Account</option>
    </select-->
   </td>
  </tr>
  <tr>
   <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-organization")%>:</td>
   <td width="1%">&nbsp;</td>
   <td>
     <input maxlength=60 name="company" value="<%=Utilities.getValue(mbInfo.Company)%>" size="40">
   </td>
  </tr>
  <tr>
    <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-street")%>:</td>
    <td width="1%">&nbsp;</td>
    <td>
      <input maxlength=60 name="address1" value="<%=Utilities.getValue(mbInfo.Address1)%>" size="40">
    </td>
  </tr>
  <tr>
    <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-city")%>:</td>
    <td width="1%">&nbsp;</td>
    <td>
      <input maxlength=60 name="city" value="<%=Utilities.getValue(mbInfo.City)%>" size="40">
    </td>
  </tr>
  <tr>
    <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-state")%>:</td>
    <td width="1%">&nbsp;</td>
    <td>
      <input maxlength=30 name="state" value="<%=Utilities.getValue(mbInfo.State)%>" size="40">
    </td>
  </tr>
  <tr>
    <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-zip")%>:</td>
    <td width="1%">&nbsp;</td>
    <td>
      <input maxlength=12 name="zip" value="<%=Utilities.getValue(mbInfo.Zip)%>" size="40">
    </td>
  </tr>
  <tr>
    <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-country")%>:</td>
    <td width="1%">&nbsp;</td>
    <td>
      <input maxlength=40 name="country" value="<%=Utilities.getValue(mbInfo.Country)%>" size="40">
    </td>
  </tr>
  <tr>
    <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-workphone")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 value="<%=mbInfo.WorkPhone%>" name="workphone"></td>
  </tr>
  <tr>
   <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-homephone")%>:</td>
   <td width="1%">&nbsp;</td>
   <td><input maxlength=20 size=40 value="<%=mbInfo.HomePhone%>" name="homephone"></td>
  </tr>
  <tr>
   <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-cellphone")%>:</td>
   <td width="1%">&nbsp;</td>
   <td><input maxlength=20 size=40 value="<%=Utilities.getValue(mbInfo.CellPhone)%>" name="cellphone"></td>
  </tr>
  <tr>
    <td height="22" width="16%" align="right"><%=mcBean.getLabel("pf-fax")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 value="<%=mbInfo.Fax%>" name="fax"></td>
  </tr>
  <tr>
    <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
  </tr>
  <tr>
    <td class="row1" colspan=2>&nbsp;</td>
    <td class="row1" width="68%">
      <input type="submit" name="submit" style='width:120px' value="<%=mcBean.getLabel("cm-update")%>">
    </td>
  </tr>
</table>
</FORM>
<SCRIPT>onMemberFormLoad(document.form_account);</SCRIPT>
<% } %>