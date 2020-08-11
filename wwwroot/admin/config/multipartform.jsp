<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/product.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ConfigBean"%>
<%
  ConfigBean bean = new ConfigBean(session);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
//     return;
  ConfigBean.Result ret = bean.update(request);
  session.setAttribute(ConfigBean.KEY_UPLOADRESULT, ret);
  String sUrl = "config.jsp?action=Update Settings";
  String sReturn = request.getParameter("return");
  if (sReturn!=null)
     sUrl = sReturn + "?action=Update Settings";

//System.out.println("Return = " + sUrl);
  response.sendRedirect(sUrl);
%>
<%@ include file="../share/footer.jsp"%>