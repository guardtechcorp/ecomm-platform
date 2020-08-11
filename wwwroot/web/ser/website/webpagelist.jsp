<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo"%>
<%@ page import="com.zyzit.weboffice.bean.WebPageBean" %>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    WebPageBean bean = WebPageBean.getObject(session);
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

    List ltArray = bean.getAll(request, "index.jsp?action=Switch Page_WebPageList", mbInfo.MemberID);

//bean.showAllParameters(request, out);
//Utilities.dumpObject(info);
%>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
 <TR>
  <TD>
   <TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
    <TR>
<% if (ltArray!=null && ltArray.size()>16) { %>
     <TD width="20%"> &nbsp;<a href='<%=bean.encodedUrl("index.jsp?action=New_WebPage&pt=" + bean.getLabel("wp-addpage"))%>'><%=mcBean.getLabel("wp-addpage")%></a></TD>
<% } %>
     <TD align="right"><%=mcBean.getLabel("cm-maxrow")%>:
      <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=bean.encodedUrl("index.jsp?action=Update Rows_WebPageList")%>');">
      <%=bean.getRowsPerPageList(-1)%>
      </select>
      </TD>
     </TR>
    </TABLE>
   </TD>
 </TR>
 <TR>
  <TD>
   <%@ include file="../include/information.jsp" %>
  </TD>
 </TR>
 <TR>
   <TD>
    <TABLE class="table-1" width="100%" align="right" border=0 cellspacing=1 cellpadding=1>
    <TR vAlign="middle" bgColor="#4959A7">
     <td width="5%" align="center" height="22"><FONT color="#ffffff"><%=mcBean.getLabel("cm-number")%></FONT></td>
     <td width="17%" align="center"><%=bean.getSortNameLink("Name", bean.encodedUrl("index.jsp?action=Sort_WebPageList"), mcBean.getLabel("wp-linkname"), true)%></td>
     <td width="39%" align="center"><%=bean.getSortNameLink("Title", bean.encodedUrl("index.jsp?action=Sort_WebPageList"), mcBean.getLabel("wp-pagetitle"), true)%></td>
     <td width="13%" align="center"><%=bean.getSortNameLink("Type", bean.encodedUrl("index.jsp?action=Sort_WebPageList"), mcBean.getLabel("wp-sourcetype"), true)%></td>
     <td width="15%" align="center"><%=bean.getSortNameLink("AccessMode", bean.encodedUrl("index.jsp?action=Sort_WebPageList"), mcBean.getLabel("wp-accessby"), true)%></td>
     <td width="11%" align="center"><FONT color="#ffffff"><%=mcBean.getLabel("cm-action")%></FONT></td>
    </TR>
 <% if (ltArray==null||ltArray.size()==0){ %>
    <TR class="normal_row">
      <td colspan=9><%=mcBean.getLabel("wp-nopage")%></td>
    </TR>
<% } else {%>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
    WebPageInfo info = (WebPageInfo)ltArray.get(i);
%>
 <tr class="normal_row" onmouseup="selrow(this, 2)" onmouseover="selrow(this, 0)" onmouseout="selrow(this, 1)">
    <td width="5%" align="center" height="20"><%=(nStartNo+i)%></td>
    <td width="17%" align="left"><%=info.Name%></td>
    <td width="39%" align="left"><%=info.Title%></td>
    <td width="13%" align="left"><%=bean.getSourceTypeName(info.Type)%></td>
    <td width="15%" align="left"><%=bean.getAccessName(info.AccessMode)%></td>
    <td width="11%" align="center">
     <a href='<%=bean.encodedUrl("index.jsp?action=Edit_WebPage&pageid="+info.PageID+"&pt="+bean.getLabel("wp-webinfo"))%>'><%=mcBean.getLabel("cm-edit")%></a>
<% if (info.Type>=0) { %>         
     | <a href='<%=bean.encodedUrl("index.jsp?action=Delete_WebPageList&pageid="+info.PageID)%>' onClick="return confirm('<%=mcBean.getLabel("cm-confirmremove")%>');"><%=mcBean.getLabel("cm-delete")%></a>
<% } %>
    </td>
  </tr>
<%}%>
<%}%>
  <tr class="normal_row2">
    <td colspan=7>
     <table width="100%">
      <tr>
        <td width="20%">&nbsp;<a href='<%=bean.encodedUrl("index.jsp?action=New_WebPage&pt="+bean.getLabel("wp-addpage"))%>'><%=mcBean.getLabel("wp-addpage")%></a></td>
        <td width="80%" align="right"><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></td>
      </tr>
     </table>
    </td>
  </tr>
 </table>
 </TD>
 </TR>
</TABLE>
<% } %>