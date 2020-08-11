<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
//    MemberAccountBean bean = new MemberAccountBean(session);
//bean.showAllParameters(request, out);
//    MemberInfo info = null;
    if (sRealAction.startsWith("Change"))
    {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
        else
        {
            sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "your account password");
        }
    }
    else// if (sRealAction.startsWith("Edit"))
    {
    }

//Utilities.dumpObject(info);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="form_password" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validatePassword(this);">
<input type="hidden" name="memebrid" value="<%=mbInfo.MemberID%>">
<input type="hidden" name="pt" value="Change Password">
<input type="hidden" name="action1" value="">
<TABLE width="100%" align="right" border=0>
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
 <TR>
   <TD valign="top">
     <table class="table-outline" width="100%" align="center">
      <tr>
        <td colspan="3" height="1" align="center"></td>
      </tr>
      <tr>
        <td height="30" colspan="3">&nbsp;<b><%=mcBean.getLabel("cp-fillpassword")%>:</b> (<%=mcBean.getLabel("cm-fieldrequied")%>)</td>
      </tr>
      <tr>
       <td height="24" width="27%" align="right">* <%=mcBean.getLabel("cp-oldpassword")%>:</td>
       <td width="1%">&nbsp;</td>
       <td><input maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("opassword"))%>" name="opassword" type="password"></td>
      </tr>
      <tr>
       <td height="24" width="27%" align="right">* <%=mcBean.getLabel("cp-newpassword")%>:</td>
       <td width="1%">&nbsp;</td>
       <td><input maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("password"))%>" name="password" type="password"></td>
      </tr>
      <tr>
       <td height="24" width="27%" align="right">* <%=mcBean.getLabel("cp-compassword")%>:</td>
       <td width="1%">&nbsp;</td>
       <td><input maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("cpassword"))%>" name="cpassword" type="password"></td>
      </tr>

      <tr>
       <td colspan="3" height="16" valign="bottom"></td>
      </tr>
      <tr>
        <td class="row1" colspan=2>&nbsp;</td>
        <td class="row1" width="68%">
          <input type="submit" name="submit" style='width:120px' value="<%=mcBean.getLabel("cm-update")%>" onClick="setAction(document.form_password, 'Change_Password');">
        </td>
      </tr>
      <tr>
        <td colspan="3" height="5">&nbsp;</td>
      </tr>
    </table>
   </TD>
  </TR>
</TABLE>
</FORM>
<SCRIPT>onPasswordFormLoad(document.form_password);</SCRIPT>
<% } %>