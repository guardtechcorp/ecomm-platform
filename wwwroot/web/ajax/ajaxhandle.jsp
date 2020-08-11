<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.bean.EmailBean" %>
<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<%
    StringBuffer sbContent = new StringBuffer("{");
    String sAction = request.getParameter("action");
    sbContent.append("\"action\":\"" + sAction + "\",");
    if ("sendProductEmail".equalsIgnoreCase(sAction))
    {
        int nProductId = Utilities.getInt(request.getParameter("productid"), 0);

        String sDomainName = request.getParameter("domainname");
        String sEmailFrom = request.getParameter("emailfrom");
        String sEmailTo = request.getParameter("emailto");
        String sSubject = request.getParameter("emailsubject");
        String sComment = request.getParameter("emailcomment");
//System.out.println(sComment);

        boolean bRet = EmailBean.sendProductEmail(sDomainName, nProductId, sEmailFrom, sEmailTo, sSubject, sComment, request);

        sbContent.append("\"ret\":" + bRet + ",");
        if (bRet)
           sbContent.append("\"message\":\"<font color='green'>It is successfully sent the email to " + sEmailTo + ".</font>\"");
        else
           sbContent.append("\"message\":\"<font color='red'>It is failed to sent the email, please try it later.</font>\"");
    }
    else
    {
        sbContent.append("\"ret\":" + false + ",");
        sbContent.append("\"message\":\"<font color='red'>It is successfully sent.</font>\"");
    }

    sbContent.append("}");
    try {
        out.clear();
        out = pageContext.pushBody();
        response.reset();
        response.setContentType("text/html; charset=utf-8");
        response.getWriter().print(sbContent.toString());

        response.flushBuffer();
    }
    catch (java.io.IOException e) {
        e.printStackTrace();
    }
%>