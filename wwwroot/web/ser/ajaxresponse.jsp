<%@ page import="com.zyzit.weboffice.bean.MessageBean"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean" %>
<%@ page import="com.zyzit.weboffice.bean.MemberFileBean" %>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean" %>
<%
{
    String sAction = BasicBean.getRealAction(request);
//    BasicBean.dumpAllParameters(request);
//System.out.println("Ajax sAction =" + sAction);
    try {
        out.clear();
        out = pageContext.pushBody();
        response.reset();
        response.setContentType("text/html");

        if (sAction.equalsIgnoreCase("Send_Message")) {
            MessageBean mgBean = new MessageBean(session, 10, true);
            int nRet = mgBean.addMessage(request);
            response.getWriter().print(nRet);
        } else if (sAction.equalsIgnoreCase("Send_ShareFile")) {
            MemberFileBean bean = MemberFileBean.getObject(session);
            MemberFileBean.Result ret = bean.emailShareFile(request);
            int nRet = 1;//mgBean.addMessage(request);
            response.getWriter().print(nRet);
        } else if (sAction.equalsIgnoreCase("GetServiceTerms")) {
            MemberAccountBean bean = MemberAccountBean.getObject(session);
            response.getWriter().print(bean.getSignUpTerms());
        }

        response.flushBuffer();
    }
    catch (java.io.IOException e) {
        e.printStackTrace();
    }
}
%>