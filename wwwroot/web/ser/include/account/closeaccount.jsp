<%@ page import="com.zyzit.weboffice.util.*"%>
<%
{
//bean.showAllParameters(request, out);
    if (sRealAction.startsWith("Apply"))
    {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
        else
        {
           sDisplayMessage = "Your account is successfully closed.<p> See you next time and Bye Bye!";
           sPageTitle = "Thank You and Good Bye!";
        }
    }
    else// if (sRealAction.startsWith("Edit"))
    {
       sPageTitle = "Confirm Close Account";
    }

    String sSubjectNote = "Are you sure you want to close your account?";
    StringBuffer sbContentNode = new StringBuffer();
    sbContentNode.append("<li>You will lose all of the benefits and services.</li><br>");
    sbContentNode.append("<li>Your information and data in our online system will removed immediately and permanently.</li><br>");
    sbContentNode.append("<li>But we will always welcome you to join us again any time in any place.</li><br>");
    sbContentNode.append("<li>Thank you again for using the <b>Web Center</b> online platform. Bye!</li>");    
    String sContentNote = sbContentNode.toString();
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="form_cancel" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateCancel(this);">
<input type="hidden" name="action1" value="Submit_CloseAccount">
<br>
<table class="table-outline" width="100%" align="center">
<tr>
 <td colspan="3" width="100%">
  <%@ include file="../include/promotenote.jsp"%>
 </td>
</tr>
<!--TR>
 <TD>
  <table width="99%" align="center" border="0" cellpadding="5" cellspacing="3"  style="border: 1px solid #DFDFDF; background-color1:#e8eefa" EFF7FE>
   <tr>
    <td>
    <table>
     <tr>
      <td width=15 valign="top"></td>
       <td align="left">
       <font face="Verdana, Arial, Helvetica, sans-serif" color='green'>
        <span style="font-size:16px;"><strong>Are you sure you want to close your account?</strong></span>
        <p><br>
        <ul>
         <li>You will lose all of the benefits and services.</li><br>
         <li>Your information and data in our online system will removed immediately and permanently.</li><br>
         <li>But we will always welcome you to join us again any time in any place.</li><br>
         <li>Thank you again for using the webcenter online system. Bye!</li>
        </ul>
        </p>
       </font>
       </td>
     </tr>
    </table>
   </td>
   </tr>
  </table>
 </TD>
</TR-->
<tr>
<td height="20" valign="bottom"></td>
</tr>
<tr>
<td align="center">
  <input type="submit" name="submit" style='width:120px' value="Close Now">
</td>
</tr>
<tr>
<td colspan="3" height="1">&nbsp;</td>
</tr>
</TABLE>
</FORM>
<% } %>