<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.RelationshipBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.database.Relationship" %>
<%@ page import="com.zyzit.weboffice.database.Member" %>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    RelationshipBean bean = RelationshipBean.getObject(session);

    if (sRealAction.startsWith("Update Rows"))
    {
        bean.changeMaxRowsPerPage(request);
    }
    else if (sRealAction.startsWith("Delete"))
    {
        ret = bean.delete(request);
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
    }
    else if (sRealAction.startsWith("Remove")||sRealAction.startsWith("Refuse"))
    {
        ret = bean.remove(request);
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
    }
    else if (sRealAction.startsWith("Approve"))
    {
        ret = bean.approve(request, null);
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
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
    }

    List ltArray = bean.getAll(request, "index.jsp?action=Switch Page_MemberList", mbInfo.MemberID);
//bean.showAllParameters(request, out);
//Utilities.dumpObject(info);
%>
<TABLE border=0 cellspacing=0 cellpadding=2 width="100%">
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>    
 <TR>
  <TD>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
 <TR>
<% if (ltArray!=null && ltArray.size()>16) { %>
  <TD width="20%">
   &nbsp;<a href='<%=bean.encodedUrl("index.jsp?action=New_Member&pt=" + bean.getLabel("ms-addmember"))%>'><%=bean.getLabel("ms-addmember")%></a>
  </TD>
<% } %>
  <TD align="right"><%=bean.getLabel("cm-maxrow")%>:
  <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=bean.encodedUrl("index.jsp?action=Update Rows_MemberList")%>');">
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
 <td width="5%" align="center" height="22"><FONT color="#ffffff"><b><%=bean.getLabel("cm-number")%></b></FONT></td>
 <td width="20%" align="center"><%=bean.getSortNameLink("FirstName", bean.encodedUrl("index.jsp?action=Sort_MemberList"), bean.getLabel("ms-mbname"), true)%></td>
 <td width="30%" align="center"><%=bean.getSortNameLink("Email", bean.encodedUrl("index.jsp?action=Sort_MemberList"), bean.getLabel("cm-email"), true)%></td>
 <td width="7%" align="center"><%=bean.getSortNameLink("Type", bean.encodedUrl("index.jsp?action=Sort_MemberList"), bean.getLabel("ms-hassite"), true)%></td>
 <td width="10%" align="center"><%=bean.getSortNameLink("m_RelationType", bean.encodedUrl("index.jsp?action=Sort_MemberList"), bean.getLabel("ms-mshipstatus"), true)%></td>
 <td width="14%" align="center"><%=bean.getSortNameLink("m_ActionDate", bean.encodedUrl("index.jsp?action=Sort_MemberList"), bean.getLabel("cm-adddate"), true)%></td>
 <td align="center"><FONT color="#ffffff"><b><%=bean.getLabel("cm-action")%></b></FONT></td>
 </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
      <tr class="normal_row">
        <td colspan=9><%=bean.getLabel("cm-norecord")%></td>
      </tr>
<% } else {%>
<%
    int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
    for (int i = 0; ltArray != null && i < ltArray.size(); i++) {
        MemberInfo info = (MemberInfo) ltArray.get(i);

        String sStatus;// = "Member";
        if (info.m_RelationType==Relationship.MEMBERTYPE_APPLYWAITAPPROVE)
           sStatus = "<font color='#DD6900'>" + bean.getLabel("ms-pendapprove") + "</font>";
        else if (info.m_RelationType==Relationship.MEMBERTYPE_INVITEWAITACCEPT)
           sStatus = "<font color='#DD6900'>" + bean.getLabel("ms-pendaccept") + "</font>";
        else if (info.m_RelationType==Relationship.MEMBERTYPE_APPLYWAITPAY)
           sStatus = "<font color='#DD6900'>" + bean.getLabel("ms-pendpay") + "</font>";
        else if (info.m_RelationType==Relationship.MEMBERTYPE_MEMBERBYAPPLIED)
           sStatus = "<font color='green'>" + bean.getLabel("ms-approvemb") + "</font>";
        else if (info.m_RelationType==Relationship.MEMBERTYPE_MEMBEERBYINVITED)
           sStatus = "<font color='green'>" + bean.getLabel("ms-acceptmb") + "</font>";
        else if (info.m_RelationType==Relationship.MEMBERTYPE_MEMBEERWITHPAID)
           sStatus = "<font color='green'>" + bean.getLabel("ms-paidmb") + "</font>";
        else //if (info.m_RelationType==Relationship.MEMBERTYPE_MEMBEROWNERADDED)
           sStatus = "<font color='green'>" + bean.getLabel("ms-addedmb") + "</font>";
//System.out.println("info.m_RelationType=" + info.m_RelationType);

        String sWebsite = info.Type==0?bean.getLabel("cm-nothas"):bean.getSiteLinkUrl(info, bean.getLabel("cm-has"), bean.getLabel("ms-visitsite"));
        String sToEmail = info.getFullName() + " [" + info.EMail+"]";
%>
 <tr class="normal_row" onmouseup="selrow(this, 2)" onmouseover="selrow(this, 0)" onmouseout="selrow(this, 1)">
    <td width="5%" align="center" height="20" nowrap><%=(nStartNo+i)%></td>
    <td width="20%">
 <% if (info.m_RelationType==Relationship.MEMBERTYPE_MEMBEROWNERADDED) { %>
   <a href='<%=bean.encodedUrl("index.jsp?action=Edit_Member&memberid="+info.MemberID + "&pt=" + bean.getLabel("ms-memberinfo"))%>' title='<%=bean.getLabel("cm-editinfo")%>'><%=info.FirstName%> <%=info.LastName%></a>
 <% } else { %>
   <a href='<%=bean.encodedUrl("index.jsp?action=View_Member&memberid="+info.MemberID + "&pt=" + bean.getLabel("ms-memberinfo"))%>' title='<%=bean.getLabel("cm-viewinfo")%>'><%=info.FirstName%> <%=info.LastName%></a>
 <% } %>
    </td>
    <td width="30%"><a href='<%=bean.encodedUrl("index.jsp?action=Load_EMail&toemail="+sToEmail+"&pt="+bean.getLabel("cm-emailtitle"))%>' title='<%=bean.getLabel("cm-emailtip")%>'><%=info.EMail%></a></td>
    <td width="7%" align="center"><%=sWebsite%></td>     
    <td width="10%" nowrap><%=sStatus%></td>
    <td width="14%" align="center"><%=Utilities.getDateValue(info.m_ActionDate, 16)%></td>
    <td align="left">&nbsp;
<% if (info.m_RelationType==Relationship.MEMBERTYPE_APPLYWAITAPPROVE) { %>
    <a href='<%=bean.encodedUrl("index.jsp?action=Approve_MemberList&memberid="+info.MemberID)%>' title="<%=bean.getLabel("ms-accepthim")%>" onClick="return confirm('<%=bean.getLabel("ms-acceptit")%>');"><%=bean.getLabel("cm-accept")%></a>&nbsp;&nbsp;&nbsp;|
    <a href='<%=bean.encodedUrl("index.jsp?action=Refuse_MemberList&memberid="+info.MemberID)%>' title="<%=bean.getLabel("ms-refusehim")%>"  onClick="return confirm('<%=bean.getLabel("ms-notacceptit")%>');"><%=bean.getLabel("cm-refuse")%></a>
<% } else { %>
    <a href='<%=bean.encodedUrl("index.jsp?action=Remove_MemberList&memberid="+info.MemberID)%>' title="<%=bean.getLabel("ms-removehim")%>" onClick="return confirm('<%=bean.getLabel("ms-removeit")%>');"><%=bean.getLabel("cm-remove")%></a>
 <% if (info.Type==Member.MEMBERTYPE_COMMONUSER && info.m_RelationType==Relationship.MEMBERTYPE_MEMBEROWNERADDED) { %>
    | <a href = '<%=bean.encodedUrl("index.jsp?action=Delete_MemberList&memberid="+info.MemberID)%>' title="<%=bean.getLabel("ms-deletehim")%>" onClick="return confirm('<%=bean.getLabel("ms-deleteit")%>');"><%=bean.getLabel("cm-delete")%></a>
 <% } %>
 <% } %>        
    </td>
  </tr>
<%}%>
<%}%>
  <tr class="normal_row2">      
    <td colspan=7>
     <table width="100%">
      <tr>
        <td width="20%">&nbsp;<a href='<%=bean.encodedUrl("index.jsp?action=New_Member&pt=" + bean.getLabel("ms-addmember"))%>'><%=bean.getLabel("ms-addmember")%></a></td>
        <td width="80%" align="right"><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></td>
      </tr>
     </table>
    </td>
  </tr>
 </table>
 </TD>
</TR>
</TABLE>
<!--script type="text/javascript">
  initFormDefaultText('firstname:e.g. input first namee|lastname:e.g. input last name|email:e.g. input email address', 'HINT');
</script-->
<% } %>