<%@ page import="com.zyzit.weboffice.bean.OrderBean" %>
<%
{
    OrderBean bean = new OrderBean(session, 21);

//      int short, getOutputStream() could not be used more than once, and also it will conflict with JSPWriter's out.
//      So, the quick workaround would be, at the end of the JSP page, add the following:
    out.clear();
    out = pageContext.pushBody();

    bean.getInvoiceFile(request, response);
}
%>