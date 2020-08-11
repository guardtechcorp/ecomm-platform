<%@ include file="../share/header.jsp"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.model.UserInfo"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%
  BasicBean bean = new BasicBean(session, null);
  UserInfo urInfo = (UserInfo)session.getAttribute(Definition.KEY_COMPANYUSER);
%>
<table width="93%" border="0" height="339" align="center">
  <tr>
    <td width="3%" height="15"></td>
    <td width="94%" height="15" align="center"></td>
    <td width="3%" height="15">&nbsp;</td>
  </tr>

  <tr>
    <td width="3%" height="61"></td>
    <td width="94%" height="61" align="center">
      <h2>Welcome to Administration Console of <a href="http://<%=bean.getDomainName()%>" target="_blank"><%=bean.getDomainName()%></a></h2>
    </td>
    <td width="3%" height="61">&nbsp;</td>
  </tr>
  <tr>
    <td width="3%" height="40">&nbsp;</td>
    <td width="94%" height="40" align="center">
      <font size=3>You has successfully finished all the steps of Setup Wizard.</font>
    </td>
    <td width="3%" height="40">&nbsp;</td>
  </tr>
  <tr>
    <td colspan=3>
     <table width="100%" border="0" height="400" align="center">
      <tr><td></td></tr>
     </table>
   </td>
  </tr>
  <tr>
    <td width="3%">&nbsp;</td>
    <td width="94%" align="center"><hr>
      <%=bean.getCopyRight()%><br><%=bean.getPowerBy()%>
    </td>
    <td width="3%" height="76">&nbsp;</td>
  </tr>
</table>
</body>
</html>
