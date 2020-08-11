<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/product.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.AccessRole"%>
<%@ page import="com.zyzit.weboffice.bean.LiveChatSettingBean"%>
<%
  LiveChatSettingBean bean = new LiveChatSettingBean(session);
//  if (!bean.canAccessPage(request, response, AccessRole.ROLE_LIVECHAT_SETTING))
//     return;
  LiveChatSettingBean.Result ret = bean.update(request);
  session.setAttribute(LiveChatSettingBean.KEY_UPLOADRESULT, ret);
  String sUrl = "livechatsetting.jsp?action=Update Settings";
  String sReturn = request.getParameter("return");
  if (sReturn!=null)
     sUrl = sReturn + "?action=Update Settings";
//System.out.println("Return = " + sUrl);
  response.sendRedirect(sUrl);
%>
<%@ include file="../share/footer.jsp"%>