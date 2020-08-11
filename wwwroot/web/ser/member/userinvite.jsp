<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.UserSearchBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.database.Relationship" %>
<%@ page import="com.zyzit.weboffice.database.Member" %>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    UserSearchBean bean = UserSearchBean.getObject(session);

    if (sRealAction.startsWith("Load"))
    {
       bean.clearLatestQuery();
    }
    else if (sRealAction.startsWith("Search User"))
    {
       int nTotalRecords = bean.searchUsers(request, onInfo);
       if (nTotalRecords==0)
       {
          nDisplay = 0;
          sDisplayMessage = bean.getLabel("ms-nouser");
       }
//System.out.println("ltUsers = " + ltUsers.size());
    }
    else if (sRealAction.startsWith("Update Rows"))
    {
        bean.changeMaxRowsPerPage(request);
    }
    else if (sRealAction.startsWith("Invite"))
    {
        ret = bean.invite(request);
        if (!ret.isSuccess())
        {
           Errors errObj = (Errors) ret.getInfoObject();
           nDisplay = 0;
           sDisplayMessage = errObj.getError();
        }
        else
        {
           sDisplayMessage = bean.getLabel("ms-invitesuccess").replaceAll("\\%s", (String)ret.getUpdateInfo()); //It is successful to nvite 'Neil Zhao' to become a member of your site.    
        }
    }

    List ltUsers = bean.getAll(request, "index.jsp?action=Switch Page_UserInvite");
%>
<TABLE border=0 cellspacing=0 cellpadding=2 width="100%">
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
<% if (ltUsers!=null) { %>
<TR>
 <TD>
   <TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
    <TR>
     <TD width="5%"></TD>
     <TD align="right"><%=bean.getLabel("cm-maxrow")%>:
     <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=bean.encodedUrl("index.jsp?action=Update Rows_UserInvite")%>');">
     <%=bean.getRowsPerPageList(-1)%>
     </select>
     </TD>
    </TR>
   </TABLE>
 </TD>
</TR>
<TR>
 <TD>
 <table class="table-1" width="100%" align="right" border=0 cellspacing=1 cellpadding=1>
  <tr vAlign="middle" bgColor="#4959A7">
  <td width="4%" align="center" height="22"><FONT color="#ffffff"><b>No</b></FONT></td>
  <td width="17%" align="center"><%=bean.getSortNameLink("FirstName", bean.encodedUrl("index.jsp?action=Sort_UserInvite"), bean.getLabel("cm-username"), true)%></td>
  <td width="32%" align="center"><%=bean.getSortNameLink("Email", bean.encodedUrl("index.jsp?action=Sort_UserInvite"), bean.getLabel("cm-email"), true)%></td>
  <td width="7%" align="center"><%=bean.getSortNameLink("Type", bean.encodedUrl("index.jsp?action=Sort_UserInvite"), bean.getLabel("ms-hassite"), true)%></td>
  <td width="12%" align="center"><%=bean.getSortNameLink("CreateDate", bean.encodedUrl("index.jsp?action=Sort_UserInvite"), bean.getLabel("cm-signdate"), true)%></td>
  <td width="8%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("cm-action")%></b></FONT></td>
  </tr>
<%
     int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
     for (int i = 0; i < ltUsers.size(); i++) {
         MemberInfo info = (MemberInfo) ltUsers.get(i);
         String sToEmail = info.getFullName() + " [" + info.EMail+"]";
         String sWebsite = info.Type==0?bean.getLabel("cm-nothas"):bean.getSiteLinkUrl(info, bean.getLabel("cm-has"), bean.getLabel("ms-visitsite"));
%>
  <tr class="normal_row">
     <td width="4%" align="center" height="20" nowrap><%=(nStartNo+i)%></td>
     <td width="17%"><%=info.getFullName()%></td>
     <td width="32%"><a href='<%=bean.encodedUrl("index.jsp?action=Load_EMail&toemail="+sToEmail+"&pt="+bean.getLabel("cm-emailtitle"))%>' title='<%=bean.getLabel("cm-emailtip")%>'><%=info.EMail%></a></td>
     <td width="7%" align="center"><%=sWebsite%></td>
     <td width="12%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
     <td width="8%" align="center">&nbsp;
     <a href='<%=bean.encodedUrl("index.jsp?action=Invite_UserInvite&memberid="+info.MemberID+"&name="+info.getFullName())%>' title="<%=bean.getLabel("ms-invituser")%>" onClick="return confirm('<%=bean.getLabel("ms-sureinvit")%>');"><%=bean.getLabel("cm-invite")%></a>
     </td>
   </tr>
<% } %>
<TR class="normal_row2">
  <td colspan=7>
   <table width="100%">
    <tr>
      <td width="5%"></td>
      <td align="right"><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></td>
    </tr>
   </table>
  </td>
</TR>
</table>
</TD>
</TR>
<% } %>
<TR>
 <TD height="10"></TD>
</TR>
<TR>
 <TD>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
 <FORM name="form_searchuser" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateSearchUser(this);">
 <input type="hidden" name="action1" value="Search User_UserInvite">
 <table class="table-outline" width="95%" align="center">
 <TR>
  <TD colspan="3" align="center" width="100%" height="30" ><font size="3"><b><%=bean.getLabel("ms-searchuser")%></b></font></TD>
 </TR>
 <TR>
  <TD height="10" colspan="3"></TD>
 </TR>
 <tr>
   <td height="20" width="25%" align="right"><%=bean.getLabel("pf-firstname")%>:</td>
   <td width="1%">&nbsp;</td>
   <td><input maxlength=20 size=50 value="<%=Utilities.getValue(request.getParameter("firstname"))%>" id="firstname" name="firstname" onFocus1='onInputFocus(this);' onBlur1='onInputBlur(this);'> <%=mcBean.getLabel("cm-and")%></td>
 </tr>
 <tr>
  <td height="20" width="25%" align="right"><%=bean.getLabel("pf-lastname")%>:</td>
  <td width="1%">&nbsp;</td>
  <td ><input maxlength=20 size=50 value="<%=Utilities.getValue(request.getParameter("lastname"))%>" id="lastname" name="lastname" onFocus1='onInputFocus(this);' onBlur1='onInputBlur(this);'> <%=mcBean.getLabel("cm-and")%></td>
 </tr>
 <tr>
   <td height="20" width="25%" align="right"><%=bean.getLabel("cm-email")%>:</td>
   <td width="1%">&nbsp;</td>
   <td widht="83%"><input maxlength=60 size=50 value="<%=Utilities.getValue(request.getParameter("email"))%>" id="email" name="email" onFocus1='onInputFocus(this);' onBlur1='onInputBlur(this);'>
   </td>
 </tr>
 <TR>
  <TD height="5" colspan="3"></TD>
 </TR>
 <tr>
  <td  width="25%" align="right">&nbsp;</td>
  <td width="1%">&nbsp;</td>
  <td align="align">
   <input type="submit" name="submit" style='width:120px' value="<%=bean.getLabel("cm-search")%>">
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
   <input type="reset" name="reset" style='width:100px' value="<%=bean.getLabel("cm-reset")%>">
   </td>
 </tr>     
 </table>
 </FORM>
<script type="text/javascript">onLoadSearchUser(document.form_searchuser);</script>
 </TD>
</TR>
</TABLE>
<!--script type="text/javascript">
  initFormDefaultText('firstname:e.g. input first namee|lastname:e.g. input last name|email:e.g. input email address', 'HINT');
</script-->
<% } %>