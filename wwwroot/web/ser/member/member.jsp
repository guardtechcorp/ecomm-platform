<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.RelationshipBean" %>
<%@ page import="com.zyzit.weboffice.database.Relationship" %>
<%@ page import="com.zyzit.weboffice.database.Member" %>
<%
{
    RelationshipBean bean = RelationshipBean.getObject(session);

    MemberInfo info = null;
    if (sRealAction.startsWith("Edit") || sRealAction.startsWith("View")) {
        info = bean.get(request);
//Utilities.dumpObject(info);
    } else if (sRealAction.startsWith("prev") || sRealAction.startsWith("next")||sRealAction.startsWith("goto")) {
        info = bean.getPrevOrNext(request, sRealAction);
//System.out.println("cgInfo = "+ cgInfo);
    } else if (sRealAction.startsWith("Add") || sRealAction.startsWith("Update")) {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            info = (MemberInfo) ret.getUpdateInfo();
            nDisplay = 0;
        } else {
            info = (MemberInfo) ret.getUpdateInfo();
            if (sRealAction.startsWith("Update"))
                sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "member information");
            else
            {
                if (ret.m_InfoObject==null)
                  sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "member");
                else
                  sDisplayMessage = (String)ret.getInfoObject();
                info = null;
            }
//Utilities.dumpObject(info);
        }
    }

    String sDisplayAction;
    if (info == null)
    {
        info = MemberInfo.getInstance2();
        info.Type = 0;
        sRealAction = "Add";
        sDisplayAction = bean.getLabel("cm-add");
    }
    else
    {
        sRealAction = "Update";
        sDisplayAction = bean.getLabel("cm-update");
    }
    String sEditable = " disabled";
    if (info.MemberID < 0 || (info.Type==Member.MEMBERTYPE_COMMONUSER && info.m_RelationType == Relationship.MEMBERTYPE_MEMBEROWNERADDED))
       sEditable = "";    
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<SCRIPT language="javascript" src="/staticfile/web/scripts/calendardateinput.js" type="text/javascript"></SCRIPT>
<SCRIPT language="javascript" src="/staticfile/web/scripts/dateformat.js" type="text/javascript"></SCRIPT>
<TABLE cellpadding="2" cellspacing="2" border="0" width="100%">
 <TR>
  <TD height="1">
   <%@ include file="../include/information.jsp"%>
  </TD>
 </TR>
 <TR>
  <TD>
  <table width="100%" cellpadding="0" cellspacing="1" border="0" align="center">
   <tr>
    <td>&nbsp;<%=bean.getLabel("cm-fieldrequied")%></td>
    <td align="right">
<% if (info.MemberID>0) { %>
     <%=bean.getPrevNextLinks2("index.jsp?", "_Member", true)%>&nbsp;
<% } %>
    </td>
   </tr>
  </table>
 </TD>
</TR>
<TR>
 <TD>
<FORM name="form_member" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateUpdateMember(this);">
<input type="hidden" name="memberid" value="<%=info.MemberID%>">
<input type="hidden" name="type" value="<%=info.Type%>">
<input type="hidden" name="action1" value="">
<table class="table-outline" width="100%" align="center">
<% if (info.MemberID > 0) {
//System.out.println("info.m_RelationType=" + info.m_RelationType);    
    String sStatus;
    if (info.m_RelationType == Relationship.MEMBERTYPE_MEMBEROWNERADDED)
       sStatus = "<font color='green'>" + bean.getLabel("ms-addon") + " " + info.m_ActionDate.substring(0, 10) + ".</font>";
    else if (info.m_RelationType==Relationship.MEMBERTYPE_MEMBERBYAPPLIED)
       sStatus = "<font color='green'>" + bean.getLabel("ms-approveon") + " " + info.m_ActionDate.substring(0, 10) + ".</font>";
    else if (info.m_RelationType==Relationship.MEMBERTYPE_MEMBEERBYINVITED)
       sStatus = "<font color='green'>" + bean.getLabel("ms-accepton") + " " + info.m_ActionDate.substring(0, 10) + ".</font>";
    else if (info.m_RelationType==Relationship.MEMBERTYPE_MEMBEERWITHPAID)
       sStatus = "<font color='green'>" + bean.getLabel("ms-payon") + " " + info.m_ActionDate.substring(0, 10) + ".</font>";
    else if (info.m_RelationType == Relationship.MEMBERTYPE_APPLYWAITAPPROVE)
        sStatus = "<font color='#DD6900'>" + bean.getLabel("ms-applyon") + " " + info.m_ActionDate.substring(0, 10) + ".<br>" + bean.getLabel("ms-waitapprove") + "</font>";
    else if (info.m_RelationType == Relationship.MEMBERTYPE_INVITEWAITACCEPT)
        sStatus = "<font color='#DD6900'>" + bean.getLabel("ms-inviton") + " " + info.m_ActionDate.substring(0, 10) + ".<br>" + bean.getLabel("ms-becomeuntil") + "</font>";
    else if (info.m_RelationType == Relationship.MEMBERTYPE_APPLYWAITPAY)
        sStatus = "<font color='#DD6900'>The user has applied the membership since " + info.m_ActionDate.substring(0, 10) + ".<br>" + bean.getLabel("ms-willbecome") + "</font>";
    else
        sStatus = "<font color='red'>" + bean.getLabel("ms-unknown") + "</font>";
%>
<tr>
  <td height="22" width="20%" align="right"><%=bean.getLabel("ms-howtobe")%></td>
  <td width="1%">&nbsp;</td>
  <td><b><%=sStatus%></b></td>
</tr>
<% } %>
<% if (1==1) { %>
<tr>
  <td height="22" width="18%" align="right">* <%=bean.getLabel("pf-firstname")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><input maxlength=20 size=40 value="<%=info.FirstName%>" name="firstname" <%=sEditable%>></td>
</tr>
<tr>
 <td height="22" width="18%" align="right">* <%=bean.getLabel("pf-lastname")%>:</td>
 <td width="1%">&nbsp;</td>
 <td ><input maxlength=20 size=40 value="<%=info.LastName%>" name="lastname" <%=sEditable%>></td>
</tr>
<tr>
  <td height="22" width="18%" align="right">* <%=bean.getLabel("cm-email")%>:</td>
  <td width="1%">&nbsp;</td>
  <td widht="83%"><input maxlength=60 size=40 value="<%=info.EMail%>" name="email" <%=sEditable%>>
  </td>
</tr>
<% if (info.MemberID<0) { %>
<tr>
  <td height="22" width="18%" align="right"> <%=bean.getLabel("cm-password")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><input maxlength=20 size=40 value="<%=info.Password%>" name="password" type="password"> <%=bean.getLabel("ms-autopassword")%>
  </td>
</tr>
<% } %>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("ms-expired")%>:</td>
  <td width="1%">&nbsp;</td>
  <td>
   <TABLE width="100%">
    <TR>
     <TD width="46%">
<% if (info.MemberID>0 && info.m_MemershipExpiredDate!=null && info.m_MemershipExpiredDate.length()>=10) { %>
     <script>DateInput('msexpireddate', false, 'YYYY-MM-DD', '<%=info.m_MemershipExpiredDate.substring(0,10)%>')</script>
<% } else { %>
     <script>DateInput('msexpireddate', false, 'YYYY-MM-DD')</script>
<% } %>
     </TD>
     <TD><%=bean.getLabel("ms-monthempty")%></TD>
    </TR>
  </TABLE>
  </td>
</tr>
<tr>
  <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
</tr>
<tr>
 <td height="22" width="18%" align="right">* <%=bean.getLabel("pf-gender")%>:</td>
 <td width="1%">&nbsp;</td>
 <td>
  <select name="gender" <%=sEditable%>>
   <option value=-1 <%=mcBean.getSelected(-1, info.Gender)%>>[<%=bean.getLabel("cm-select")%>]</option>
   <option value=1 <%=mcBean.getSelected(1, info.Gender)%>><%=bean.getLabel("pf-male")%></option>
   <option value=0 <%=mcBean.getSelected(0, info.Gender)%>><%=bean.getLabel("pf-female")%></option>
  </select>
 </td>
</tr>
<tr>
 <td height="22" width="18%" align="right"><%=bean.getLabel("pf-nickname")%>:</td>
 <td width="1%">&nbsp;</td>
 <td ><input maxlength=20 size=40 value="<%=Utilities.getValue(info.NickName)%>" name="nickname" <%=sEditable%>></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-street")%>:</td>
  <td width="1%">&nbsp;</td>
  <td>
    <input maxlength=60 name="address1" value="<%=Utilities.getValue(info.Address1)%>" size="40" <%=sEditable%>>
  </td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-city")%>:</td>
  <td width="1%">&nbsp;</td>
  <td>
    <input maxlength=60 name="city" value="<%=Utilities.getValue(info.City)%>" size="40" <%=sEditable%>>
  </td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-state")%>:</td>
  <td width="1%">&nbsp;</td>
  <td>
    <input maxlength=30 name="state" value="<%=Utilities.getValue(info.State)%>" size="40" <%=sEditable%>>
  </td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-zip")%>:</td>
  <td width="1%">&nbsp;</td>
  <td>
    <input maxlength=12 name="zip" value="<%=Utilities.getValue(info.Zip)%>" size="40" <%=sEditable%>>
  </td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-country")%>:</td>
  <td width="1%">&nbsp;</td>
  <td>
    <input maxlength=40 name="country" value="<%=Utilities.getValue(info.Country)%>" size="40" <%=sEditable%>>
  </td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-workphone")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><input maxlength=20 size=40 value="<%=Utilities.getValue(info.WorkPhone)%>" name="workphone" <%=sEditable%>></td>
</tr>
<tr>
 <td height="22" width="18%" align="right"><%=bean.getLabel("pf-homephone")%>:</td>
 <td width="1%">&nbsp;</td>
 <td><input maxlength=20 size=40 value="<%=Utilities.getValue(info.HomePhone)%>" name="homephone" <%=sEditable%>></td>
</tr>
<tr>
 <td height="22" width="18%" align="right"><%=bean.getLabel("pf-cellphone")%>:</td>
 <td width="1%">&nbsp;</td>
 <td><input maxlength=20 size=40 value="<%=Utilities.getValue(info.CellPhone)%>" name="cellphone" <%=sEditable%>></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-fax")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><input maxlength=20 size=40 value="<%=Utilities.getValue(info.Fax)%>" name="fax" <%=sEditable%>></td>
</tr>
<% if (info.MemberID<=0) { %>
<tr>
  <td height="24" width="18%" align="right"><input type="checkbox" name="sendmail" value="1" checked></td>
  <td width="1%">&nbsp;</td>
  <td><%=bean.getLabel("ms-sendnotify")%></td>
</tr>
<% } %>
<tr>
 <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
</tr>
<tr>
 <td class="row1" width="18%" align="right">&nbsp;</td>
 <td width="1%">&nbsp;</td>
 <td class="row1">
  <input type="submit" name="submit" style='width:120px' value="<%=sDisplayAction%>" onClick="setAction(document.form_member, <%=sRealAction%>+'_Member');">
  </td>
</tr>
<SCRIPT>onMemberFormLoad(document.form_member);</SCRIPT>
<% } else { %>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-firstname")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><b><%=info.FirstName%></b></td>
</tr>
<tr>
 <td height="22" width="18%" align="right"><%=bean.getLabel("pf-lastname")%>:</td>
 <td width="1%">&nbsp;</td>
 <td ><b><%=info.LastName%></b></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("cm-email")%>:</td>
  <td width="1%">&nbsp;</td>
  <td widht="83%"><b><%=info.EMail%></b></td>
</tr>
<tr>
  <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
</tr>
<tr>
 <td height="22" width="18%" align="right"><%=bean.getLabel("pf-nickname")%>:</td>
 <td width="1%">&nbsp;</td>
 <td><%=Utilities.getValue(info.NickName)%></td>
</tr>
<tr>
 <td height="22" width="18%" align="right"><%=bean.getLabel("pf-gender")%>:</td>
 <td width="1%">&nbsp;</td>
 <td><b><%=1==info.Gender?"Male":"Femail"%></b></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-street")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><b><%=Utilities.getValue(info.Address1)%></b></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-city")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><b><%=Utilities.getValue(info.City)%></b></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-state")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><b><%=Utilities.getValue(info.State)%></b></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-zip")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><b><%=Utilities.getValue(info.Zip)%></b></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-country")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><b><%=Utilities.getValue(info.Country)%></b></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"> <%=bean.getLabel("pf-workphone")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><b><%=Utilities.getValue(info.WorkPhone)%></b></td>
</tr>
<tr>
 <td height="22" width="18%" align="right"><%=bean.getLabel("pf-homephone")%>:</td>
 <td width="1%">&nbsp;</td>
 <td><b><%=Utilities.getValue(info.HomePhone)%></b></td>
</tr>
<tr>
 <td height="22" width="18%" align="right"><%=bean.getLabel("pf-cellphone")%>:</td>
 <td width="1%">&nbsp;</td>
 <td><b><%=Utilities.getValue(info.CellPhone)%></b></td>
</tr>
<tr>
  <td height="22" width="18%" align="right"><%=bean.getLabel("pf-fax")%>:</td>
  <td width="1%">&nbsp;</td>
  <td><b><%=Utilities.getValue(info.Fax)%></b></td>
</tr>
<% } %>

</table>
</FORM>
  </TD>
 </TR>
</TABLE>    
<% } %>