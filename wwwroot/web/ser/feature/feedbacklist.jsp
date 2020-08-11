<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.bean.FeedbackBean"%>
<%@ page import="com.zyzit.weboffice.model.FeedbackInfo"%>
<%@ page import="com.zyzit.weboffice.util.Errors" %>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    FeedbackBean bean = new FeedbackBean(session, 20);
    if (sRealAction.startsWith("Update Rows")) {
        bean.changeMaxRowsPerPage(request);
    } else if (sRealAction.startsWith("Delete")) {

        ret = bean.delete(request);
        if (!ret.isSuccess()) {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
    }

    List ltArray;
    if (sRealAction.startsWith("Switch")||sRealAction.startsWith("Sort"))
       ltArray = bean.getPageList(request, "index.jsp?action=Switch Page_FeedbackList");
    else
       ltArray = bean.getAll(request, "index.jsp?action=Switch Page_FeedbackList", onInfo.MemberID);
%>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
 <TR>
  <TD><HR class='line' /></TD>
 </TR>
 <TR>
  <TD>
   <table width="100%" cellpadding="1" cellspacing="0" border="0" align="center">
    <tr>
     <td align="right"><%=mcBean.getLabel("cm-maxrow")%>:
     <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=bean.encodedUrl("index.jsp?action=Update Rows_FeedbackList")%>');">
     <%=bean.getRowsPerPageList(-1)%>
     </select>
     </td>
    </tr>
   </table>
  </TD>
 </TR>
 <TR>
  <TD>
<table width="100%" cellpadding="1" cellspacing="0" border="0" class="forumline" align="center">
  <TR>
   <TD colspan="8">
     <%@ include file="../include/information.jsp"%>
   </TD>
  </TR>
  <TR>
   <TD>
    <TABLE class="table-1" width="100%" align="right" border=0 cellspacing=1 cellpadding=1>
    <TR vAlign="middle" bgColor="#4959A7">
     <td width="5%" align="center" height="22"><FONT color="#ffffff"><%=mcBean.getLabel("cm-number")%>.</FONT></td>
     <td width="22%" align="center"><%=bean.getSortNameLink("Yourname", bean.encodedUrl("index.jsp?action=Sort_FeedbackList"), mcBean.getLabel("fb-sendername"), true)%></td>
     <td width="31%" align="center"><%=bean.getSortNameLink("EMail", bean.encodedUrl("index.jsp?action=Sort_FeedbackList"), mcBean.getLabel("cm-email"), true)%></td>
     <td width="15%" align="center"><%=bean.getSortNameLink("CreateDate", bean.encodedUrl("index.jsp?action=Sort_FeedbackList"), mcBean.getLabel("cm-submitdate"), true)%></td>
     <td width="15%" align="center"><%=bean.getSortNameLink("ResponseDate", bean.encodedUrl("index.jsp?action=Sort_FeedbackList"), mcBean.getLabel("cm-replydate"), true)%></td>
     <td align="center"><FONT color="#ffffff"><%=mcBean.getLabel("cm-action")%></FONT></td>
    </TR>
<% if (ltArray==null||ltArray.size()==0){ %>
    <TR class="normal_row">
      <td colspan=8><%=mcBean.getLabel("fb-norecord")%></td>
    </TR>
<% } else {%>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     FeedbackInfo info = (FeedbackInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="5%" align="center"><%=(nStartNo+i)%></td>
    <td width="22%"><%=info.Yourname%></td>
    <td width="31%"><%=Utilities.getValue(info.EMail)%></td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.ResponseDate, 16)%></td>
    <td align="center">
     <a href='<%=bean.encodedUrl("index.jsp?action=Edit_FeedbackReply&feedid="+info.FeedID+"&pt=" + mcBean.getLabel("fb-title"))%>'><%=info.ResponseDate!=null?mcBean.getLabel("cm-view"):mcBean.getLabel("cm-reply")%></a>
   | <a href='<%=bean.encodedUrl("index.jsp?action=Delete_FeedbackList&feedid="+info.FeedID)%>' onClick="return confirm('<%=mcBean.getLabel("cm-confirmremove")%>');"><%=mcBean.getLabel("cm-delete")%></a>
    </td>
  </tr>
<%}%>
  <tr class="normal_row2">
   <td colspan=6>
     <table width="100%">
      <tr>
        <td width="3%"></td>
        <td width="80%" align="right"><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></td>
      </tr>
     </table>
   </td>
  </tr>
<%}%>
</table>
</TD>
</TR>
</TABLE>
<% } %>