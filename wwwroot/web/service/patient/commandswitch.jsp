<%@ page import="java.lang.Exception"%>
<%@ page import="com.zyzit.weboffice.web.SessionWeb"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="java.util.*" %>
<%@ page import="com.zyzit.weboffice.util.Errors" %>
<%@ page import="com.zyzit.weboffice.model.NavigationInfo" %>
<% {
  CustomerInfo loginInfo = null;
  String sErrorMessage = null;
  String sErrorClass = "successful";

  if (sActionProp.equalsIgnoreCase("FillTestForm-RemoveFile"))
  {
      RequisitionInfo trInfo = web.getRequistionInfo();
      String card = request.getParameter("card");
      int index = Utilities.getInt(request.getParameter("index"), 1);
      String newFiles = web.removeCardFile(trInfo.glInfo, card, index);
      if (newFiles!=null)
      {
        sErrorMessage = newFiles;
      }
      else
      {
        sErrorMessage = "<font color=green>The file is remove successfully." + "</font>";
      }

      StringBuffer sbContent = new StringBuffer("{");
      sbContent.append("\"ret\":" + (newFiles!=null) + ",\n");
      sbContent.append("\"message\":\"" + sErrorMessage +  "\"");
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

      return;
  }
//  else
//  {
//      loginInfo = webCustomer.getCustomerInfo();
//  }

  NavigationInfo.Navigation currentPage = NavigationInfo.Navigation.Dashbord;
%>
<% if (nInclude==0) { %>
 <div id="id_mainarea">
<% } %>
 <%@ include file="filltestform.jsp"%>
<script type="text/javascript">
var g_currentPage = <%=currentPage.GetValue()%>;
</script>
<% if (nInclude==0) { %>
</div>
<FORM name="navigateform" action="/Patient" method="post">
<INPUT name="action1" type="hidden" value="">
<INPUT name="what" type="hidden" value="">
<INPUT name="id" type="hidden" value="">
<INPUT name="params" type="hidden" value="<%=java.util.Calendar.getInstance().getTime().getTime()%>">
</FORM>
<% } } %>