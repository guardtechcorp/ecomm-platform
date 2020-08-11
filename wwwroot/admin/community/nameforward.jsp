<%@ page import="com.zyzit.weboffice.bean.CommunitySubdomainBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunitySubdomainInfo"%>
<%@ page import="com.omniserve.dbengine.entry.Service" %>
<%
    CommunitySubdomainBean bean = new CommunitySubdomainBean(session, 20);
    String sDomainName = bean.getDomainNameFromUrl(request);
/*
  int nIndex = sDomainName.indexOf(".");
  String sSiteName = sDomainName.substring(0, nIndex);
  CommunitySubdomainBean.Result ret = bean.getHomeUrl(sSiteName);
*/
    CommunitySubdomainBean.Result ret = bean.getHomeUrl(sDomainName);
    if (!ret.isSuccess()) {
        response.sendRedirect("http://subdomain." + Service.getDomain() + "/index.html?domainname=" + sDomainName);
        return;
    } else {
        if (ret.getUpdateInfo() == null) {
            CommunitySubdomainInfo info = (CommunitySubdomainInfo) ret.getInfoObject();
            response.reset();
            response.setContentType("text/html");
            response.getWriter().print("<b>" + sDomainName + "</b> is " + bean.getPayStatus(info.PayStatus));
            response.flushBuffer();

            return;
        }
    }
/*
{
System.out.println("Home Url=" + ret.getUpdateInfo());
   response.sendRedirect((String)ret.getUpdateInfo());
}
<frameset rows="0,*" frameborder="NO" border="0" framespacing="0">
    <frame name="topFrame" scrolling="NO" noresize src="">
*/
%>

<frameset rows="*" frameborder="NO" border="0" framespacing="0">
    <frame src="<%=ret.getUpdateInfo()%>" name="main" marginwidth="10" marginheight="10" scrolling="auto">
</frameset>
