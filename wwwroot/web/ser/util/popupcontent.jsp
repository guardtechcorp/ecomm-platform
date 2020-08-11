<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean" %>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo" %>
<%
{
    MemberAccountBean bean = MemberAccountBean.getObject(session);
    ConfigInfo cfInfo = bean.getSiteConfig(request);       //. Sepecial MemberSite
    MemberAccountBean.Result ret1 = bean.getWebContentByRequest(request, cfInfo.MemberID);
    String sRedir = Utilities.getValue((String)ret1.getUpdateInfo());

//System.out.println("sRedir=" + sRedir);
    response.sendRedirect(sRedir);
}    
%>
