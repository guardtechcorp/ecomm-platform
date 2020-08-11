<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%
    MemberAccountBean mcBean = MemberAccountBean.getMemberAccount(session);
    int nMemberId = Utilities.getInt(request.getParameter("memberid"), 0);
%>
<%=mcBean.getPreviewPage(request, nMemberId)%>
