<%@ include file="header.jsp"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<br>
<br>
<table width="80%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th class="thHead" align="center">Information</th>
  </tr>
  <tr>
    <td class="row1" width="100%" align="center" height="61">
     <span class="gen"><%=(String)session.getAttribute(Definition.KEY_DISPLAYMESSAGE)%><br /><br />
     <%=(String)session.getAttribute(Definition.KEY_DISPLAYLINK)%><br /></span>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>