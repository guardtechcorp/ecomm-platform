<%@ page import="com.zyzit.weboffice.model.UserInfo" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.*" %>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo" %>
<%@ page import="com.zyzit.weboffice.util.AccessRole" %>
<%@ page import="com.zyzit.weboffice.bean.Apollogen.RequisitionWeb" %>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.TestResult" %>
<%@ page import="java.util.*" %>
<%@ page import="com.zyzit.weboffice.filter.HttpSessionCollector" %>
<% {
    HttpSession ss = session;
    if (request.getParameter("JSID")!=null)
    {
       String jsId = request.getParameter("JSID");
       HttpSession parent = HttpSessionCollector.find(jsId);
       if (parent!=null)
          ss = parent;
    }

   RequisitionWeb web = new RequisitionWeb(ss, request, 10);

   String sActionProp = web.getRealAction(request);
   String sError = null;

   RequisitionInfo trInfo = web.getRequistionInfo();

   if (trInfo==null)
   {
       int nId = Utilities.getInt(request.getParameter("id"), 0);
       trInfo = web.load(nId, null);

       CustomerWeb webCustomer = new CustomerWeb(ss, request, 0);
       CustomerInfo loginInfo = webCustomer.getCustomerInfo();

       if (trInfo==null|| trInfo.glInfo==null)
       {
           sError = "This summary page does not exist.";
       }
       else if (loginInfo==null)
       {//.
           UserInfo urInfo = web.getLoggedUserInfo();
           if (urInfo==null || !web.hasAccessRole(AccessRole.ROLE_PORTAL_VIEW| AccessRole.ROLE_PORTAL_UPDATE))
           {
               sError = "You do not have right to access this page.";
           }
       }
       else if ( trInfo.glInfo.CustomerID!=loginInfo.CustomerID)
       {
         sError = "You do not have right to access this page.";
       }
   }

   boolean bSummary = true;
   if ("letter".equalsIgnoreCase(request.getParameter("type")))
       bSummary = false;
%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<META charset="utf-8">
<TITLE>ApolloGen - <%=bSummary?"Requisition Summary":"Necessity-Letter"%></TITLE>
<META name="description" content="ApolloGen is dedicated to provide the most accurate and informative genetic testing services to individuals who can benefit from testing.">
<link rel="stylesheet" href="https://www.apollogen.com/staticfile/web/css/common.css">    
<% if (sActionProp.equalsIgnoreCase("PrintSummary")) { %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!--link rel="stylesheet" href="/staticfile/web/css/bootstrap.css"-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript">
$(document).ready(function()
{
<% if ("print".equalsIgnoreCase(request.getParameter("show"))) { %>
    window.print();
<% } %>    
});
function onPrint()
{
   window.print();
}
function onClose()
{
  window.close();
}
</script>
<% } %>
</HEAD>
<BODY>
<%@ include file="../../util/function.jsp"%>
<% if (false && sActionProp.equalsIgnoreCase("PrintSummary")) { %>
<table width="100%" align="center">
<tr>
 <td style="border-bottom: 2px solid #cccccc" height="36" valign="bottom">&nbsp;
<% if (sError==null) { %>
 <a href="#" onclick="return onPrint()">Print</a> |
<% } %>        
    <a href="#" onclick="return onClose()">Close</a>
</td>
</tr>
<tr><td height="10"></td></tr>
</table>
<% } %>
<div class="panel panel-success">
<div class="panel-heading" align="center"><font size="4"><b><%=bSummary?"Summary of Requisition Order":"LETTER OF MEDICAL NECESSITY"%></b></font></div>
<div class="panel-body">
<br>    
<table width="98%" align="center">
<% if (sError!=null) { %>
 <tr>
   <td><h2 align="center"><%=sError%></h2></td>
 </tr>
<% } else { %>
<FORM name="testform" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="Print-Summary">
<INPUT type="hidden" name="id" value="<%=trInfo.glInfo.ID%>">
<tr>
  <td>
  <% if (bSummary) { %>
  <%@ include file="summary.jsp"%>
  <% } else { %>
  <!--%@ include file="letter.jsp"%-->
  <% } %>
  </td>
</tr>
</FORM>
<% } %>
</table>
</div>
</div>
</BODY>
</HTML>
<% } %>