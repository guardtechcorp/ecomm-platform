<%@ page import="com.zyzit.weboffice.bean.BasicBean" %>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo" %>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.model.MemberInfo" %>
<%@ page import="com.zyzit.weboffice.web.SessionWeb" %>
<%
//    SessionWeb web1 = new SessionWeb(session, request);
    HttpSession sn = session;//web1.getSession();

    BasicBean.Result ret = BasicBean.getRequestResult(sn);//session);
    String sRealAction = Utilities.getValue(BasicBean.getRequestAction(sn));//session));
    MemberAccountBean mcBean = MemberAccountBean.getObject(sn);//session);
    ConfigInfo cfInfo = mcBean.getSiteConfig(sn);//session);
    MemberInfo mbInfo = mcBean.getMemberInfo();
    MemberInfo onInfo = mcBean.getSiteOwnerInfo();

    String sDisplayMessage = null;
    int nDisplay = 1;
//System.out.println("request=" + request.getRequestURL().toString());
//System.out.println("sRealAction=" + sRealAction + ", " + BasicBean.getRealAction(request));    
%>