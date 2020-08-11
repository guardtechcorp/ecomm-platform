<%@ page import="com.zyzit.weboffice.bean.LinkPageBean"%>
<%@ page import="com.zyzit.weboffice.model.LinkPageInfo"%>
<%
  LinkPageBean bean = new LinkPageBean(session, 24, true);
  LinkPageInfo info = bean.getPageInfo(request);
//    String sAction = request.getParameter("action");
  if (info==null)
  {
     return;
  }

  if (info.Attribute==0)
  {//. It is a popup window
    bean.getTargetContent(info, response);
    return;
  }
%>
<table width="100%" cellpadding="6" cellspacing="1" border="0">
  <tr>
    <td valign="top"><%=bean.getContent(info)%></td>
  </tr>
</table>

