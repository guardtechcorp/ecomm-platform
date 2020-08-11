<!--%@ include file="../share/header.jsp"%-->
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.FileBean"%>
<%
  FileBean bean = new FileBean(session, 10);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_PUBLICAREA|AccessRole.ROLE_PRIVATEAREA|AccessRole.ROLE_MEMBERAREA))
//     return;
  FileBean.Result ret = bean.runCommand(request, response);
  if (ret.isSuccess() && ret.m_sAction.startsWith("Download"))
  {
     return;
  }

  session.setAttribute(bean.KEY_COMMANDRESULT, ret);
  response.sendRedirect("filelist.jsp?action=Command-"+ret.m_sAction);
%>
<%@ include file="../share/footer.jsp"%>