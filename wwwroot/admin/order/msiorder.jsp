<%@ page import="com.zyzit.weboffice.bean.OrderBean"%>
<%
{
   OrderBean bean = new OrderBean(session, 20);

OrderBean.dumpAllParameters(request);

   String sAction = request.getParameter("action1");
   boolean bRet = false;
   if ("msi_itransact".equalsIgnoreCase(sAction))
   {
      bRet = bean.msiOrderProcess(request, response, sAction);
   }
   else if ("msi_notify".equalsIgnoreCase(sAction))
   {
      bRet = bean.msiOrderProcess(request, response, sAction);
   }
   else if ("msi_return".equalsIgnoreCase(sAction))
   {
     bRet = bean.msiOrderProcess(request, response, sAction);
   }
   else if ("msi_cancel".equalsIgnoreCase(sAction))
   {
     response.sendRedirect("http://www.molecularsoft.com/order.htm");
   }
}
%>