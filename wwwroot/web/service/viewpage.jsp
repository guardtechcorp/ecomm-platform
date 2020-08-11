<%@ page import="com.zyzit.weboffice.database.Apollogen.model.RequisitionInfo" %>
<%@ page import="com.zyzit.weboffice.model.NavigationInfo" %>
<%@ page import="com.zyzit.weboffice.bean.Apollogen.RequisitionBean" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.*" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.TestResult" %>
<%
    String sWhat = request.getParameter("what");

    boolean bSummary = true;
    if (sWhat.endsWith("letter"))
       bSummary = false;

    RequisitionInfo trInfo = null;
    if ("prev".equalsIgnoreCase(sWhat)||"next".equalsIgnoreCase(sWhat))
    {
       trInfo =  web.getPrevOrNext(sWhat);
//System.out.println("cgInfo = "+ cgInfo);
    }
    else// if ("view".equalsIgnoreCase(sWhat))
    {
        trInfo =  web.get(request);
    }

    //. try to get customer and user names
    web.getNames(trInfo.glInfo);

    boolean bFront = true;
%>
<table width="99%" cellpadding="0" cellspacing="1" border="0" align="center" style="border-bottom: 1px solid #cccccc">
<tr>
  <td align="left" height="30"> <a href="#" onClick="return submitNavigate('ListPage', 'id_mainarea')">< Back to List</a>
<%  if (trInfo.glInfo.Status<RequisitionInfo.AStatus.SUBMITTED.GetValue()) { %>
  | <a href='#' onclick="return loadTestForm(<%=trInfo.glInfo.ID%>,'edit')">Edit</a>
<% } %>      
  </td>
  <td align="right" height="30"><%=web.getPrevNextClickLinks("return navigatePage('what')")%></td>
</tr>
</table>
<p>
<%@ include file="statusinfo.jsp"%>