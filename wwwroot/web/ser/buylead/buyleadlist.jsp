<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.PostMessageBean"%>
<%@ page import="com.zyzit.weboffice.model.MessageInfo"%>
<%
{
    PostMessageBean bean = new PostMessageBean(session, 20, true);

    if (sRealAction.startsWith("Update Rows"))
    {
       bean.changeMaxRowsPerPage(request);
    }
    else if (sRealAction.startsWith("Show"))
    {
    }

    List ltArray = bean.getPageList(request, "index.jsp?action=Switch Page_BuyLeadList");
    sPageTitle = "Buying Lead List";
%>
<TABLE class1="table-1" width="100%" align="right" border=0>
  <TR>
    <TD align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'index.jsp', 'Update Rows_BuyLeadList');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </TD>
   </TR>
   <TR><TD>
    <TABLE class="table-1" width="100%" align="right" border=0>
    <TR vAlign="middle" bgColor="#4959A7">
     <td width="6%" align="center" height="22"><FONT color="#ffffff">No.</FONT></td>
     <td width="45%" align="center"><%=bean.getSortNameLink("Subject", bean.encodedUrl("index.jsp?action=Sort_BuyLeadList"), "Subject", true)%></td>
     <td width="22%" align="center"><%=bean.getSortNameLink("SenderID", bean.encodedUrl("index.jsp?action=Sort_BuyLeadList"), "To", true)%></td>
     <td width="15%" align="center"><%=bean.getSortNameLink("CreateDate", bean.encodedUrl("index.jsp?action=Sort_BuyLeadList"), "Submitted Date", true)%></td>
     <td width="12%" align="center"><FONT color="#ffffff">Actions</FONT></td>
    </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
      <tr class="normal_row">
        <td colspan=9>There is no any buying lead message available.</td>
      </tr>
<% } else {%>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     MessageInfo info = (MessageInfo)ltArray.get(i);
%>
 <tr class="normal_row" onmouseup="selrow(this, 2)" onmouseover="selrow(this, 0)" onmouseout="selrow(this, 1)">
    <td width="6%" align="center" height="20"><%=(nStartNo+i)%></td>
    <td width="45%"><%=info.Subject%></td>
    <!td width="22%" align="left">bean.getSenderName(info)</td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="12%" align="center">
      <a href='<%=bean.encodedUrl("index.jsp?action=View_BuyLeadDetail&messageid="+info.MessageID+"&pt=Message Content")%>'>View</a>
    </td>
  </tr>
<% } %>
  <tr class="normal_row2">      
    <td colspan=6>
     <table width="100%">
      <tr>
        <td width="10%"></td>
        <td align="right"><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></td>
      </tr>
     </table>
    </td>
  </tr>
 </table>        
 </td>
</tr>
<%}%>
</TABLE>
<% } %>