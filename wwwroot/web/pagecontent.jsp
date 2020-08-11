<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.PageContentBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%
  PageContentBean bean = new PageContentBean(session, 24);
  String sAction = request.getParameter("action");
  if ("Get Content".equalsIgnoreCase(sAction)||"Get UploadFile".equalsIgnoreCase(sAction))
  {//. It is get the content of a file
    bean.getContent(request, response);
    return;
  }

  PageContentBean.Result ret = bean.getDynamicDomainName(request);
  if (!ret.isSuccess()) //. For some reason it is failed
     return;

  String sTitle = request.getParameter("title");
  List ltArray = bean.getAllByRequest(request);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<title>Page of Content</title>
</head>
<body>
<% if (ltArray!=null&&ltArray.size()>0) { %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" align="center">
<%
int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
for (int i=0; i<ltArray.size(); i++) {
  ContentInfo info = (ContentInfo)ltArray.get(i);
%>
    <tr>
      <td width="25%">
       <ul><li><%=Utilities.getValue(info.EventDate)%>: </li></ul>
      </td>
      <td valign="top" ><%=bean.getPageContent(info, true, true)%></td>
    </tr>
<% } %>
</table>
<%}%>
</body>
</html>