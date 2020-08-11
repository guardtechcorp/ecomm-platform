<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.LiveChatBean"%>
<%@ page import="com.zyzit.weboffice.model.LiveChatInfo"%>
<%
//LiveChatBean.dumpAllParameters(request);
  HttpSession parentSession = LiveChatBean.getHttpSession(request.getParameter("domainname"), request.getParameter("sid"));
  LiveChatBean bean = new LiveChatBean(parentSession, 1000);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_LIVECHAT_USER))
//     return;
  List ltArray = bean.getAll(request);
%>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL">No.</th>
    <th width="18%" align="center" class="thCornerL">Customer Name</th>
    <th width="26%" align="center" class="thCornerL">E-Mail</th>
    <th width="28%" align="center" class="thCornerL">Service Person</th>
    <th width="14%" align="center" class="thCornerL">Start Time</th>
    <th width="9%" align="center" class="thCornerL">Status</th>
  </tr>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     LiveChatInfo info = (LiveChatInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="5%" align="center"><a href="#" onMouseover="ddrivetip('<%=bean.getDetailText(info)%>')"; onMouseout="hideddrivetip()"><%=(nStartNo+i)%></a></td>
    <td width="18%"><%=Utilities.getValue(info.FirstName)%> <%=Utilities.getValue(info.LastName)%></a></td>
    <td width="26%">
      <a href="../util/email.jsp?action=person&toemail=<%=info.EMail%>&name=<%=info.FirstName%>&group=recipients" target="_blank" title="Email to <%=info.EMail%>"><%=info.EMail%></a>
    </td>
    <td width="28%"><%=Utilities.getValue(bean.getServicePerson(info))%></td>
    <td width="14%" align="center"><%=Utilities.getDateValue(info.StartDate, 16)%></td>
    <td width="9%" align="center"><%=bean.getAction(info)%></td>
  </tr>
<%}%>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan="6">There is no any live chat session.</td>
  </tr>
<% } %>
</table>