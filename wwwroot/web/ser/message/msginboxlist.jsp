<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MessageBean"%>
<%@ page import="com.zyzit.weboffice.model.MessageInfo"%>
<%
{
    MessageBean bean = new MessageBean(session, 16, true);

    if (sRealAction.startsWith("Update Rows"))
    {
        bean.changeMaxRowsPerPage(request);
    }
    else if (sRealAction.startsWith("Delete"))
    {
        ret = bean.delete(request);
/*
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
*/
    }

    List ltArray = bean.getAll(request, "index.jsp?action=Switch Page_MessageList");

//bean.showAllParameters(request, out);
//Utilities.dumpObject(info);
    sPageTitle = "Inbox Message List";
%>
<TABLE class1="table-1" width="100%" align="right" border=0>
 <TR>
  <TD align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'index.jsp', 'Update Rows_MessageList');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </TD>
 </TR>
  <TR>
   <TD>
    <TABLE class="table-1" width="100%" align="right" border=0>
    <TR vAlign="middle" bgColor="#4959A7">
        <td width="6%" align="center" height="22"><FONT color="#ffffff">No.</FONT></td>
        <td width="45%" align="center"><%=bean.getSortNameLink("Subject", bean.encodedUrl("index.jsp?action=Sort_MsgInboxList"), "Subject", true)%></td>
        <td width="20%" align="center"><%=bean.getSortNameLink("SenderID", bean.encodedUrl("index.jsp?action=Sort_MsgInboxList"), "From", true)%></td>
        <td width="18%" align="center"><%=bean.getSortNameLink("CreateDate", bean.encodedUrl("index.jsp?action=Sort_MsgInboxList"), "Received Date", true)%></td>
        <td width="11%" align="center"><FONT color="#ffffff">Actions</FONT></td>
    </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
      <tr class="normal_row">
        <td colspan=9>There is no any message available.</td>
      </tr>
<% } else {%>
<%
  String sBoldStart, sBoldEnd;
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     MessageInfo info = (MessageInfo)ltArray.get(i);

     if (info.ReadFlag==0)
     {
       sBoldStart = "<b>";
       sBoldEnd = "</b>";
     }
     else
     {
       sBoldStart = "";
       sBoldEnd = "";
     }
%>
 <tr class="normal_row" onmouseup="selrow(this, 2)" onmouseover="selrow(this, 0)" onmouseout="selrow(this, 1)">
    <td width="6%" align="center" height="20"><%=sBoldStart%><%=(nStartNo+i)%><%=sBoldEnd%></td>
    <td width="45%"><%=sBoldStart%><%=info.Subject%><%=sBoldEnd%></td>
    <td width="20%" align="left"><%=sBoldStart%><%=info.m_Name%><%=sBoldEnd%></td>
    <td width="18%" align="center"><%=sBoldStart%><%=sBoldStart%><%=Utilities.getDateValue(info.CreateDate, 16)%><%=sBoldEnd%></td>
    <td width="11%" align="center">
      <a href='<%=bean.encodedUrl("index.jsp?action=View_MsgInbox&messageid="+info.MessageID)%>'>View</a>|<a href='<%=bean.encodedUrl("index.jsp?action=Delete_MsgInboxList&messageid="+info.MessageID)%>' onClick="return confirm('Are you sure you want to delete this message.');">Delete</a>
    </td>
  </tr>
<%}%>

  <tr class="normal_row2">      
    <td colspan=7>
     <table width="100%">
      <tr>
        <td width="1%"></td>
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