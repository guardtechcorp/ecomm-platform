<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.AutoResponseBean"%>
<%@ page import="com.zyzit.weboffice.model.AutoResponseInfo"%>
<%
  AutoResponseBean bean = new AutoResponseBean(session, 1000);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EMAILCAMPAIGN))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
    AutoResponseBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request, "responselist.jsp?");

  String sHelpTag = "atutoresponselist";
//  String sTitleLinks = "<b>Autoresponder Group List</b>";
  String sTitleLinks = bean.getNavigation(request, "Autoresponder Group List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This page gives you a brief view of all the Autoresponder group. You can create a new Autoresponder group or enter to an existing Autoresponder group to edit its information.
<p>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<%
  for (int i=0; ltArray!=null && i<ltArray.size(); i+=3) {
    AutoResponseInfo info = (AutoResponseInfo)ltArray.get(i);
%>
<tr><td>
<table cellspacing=1 cellpadding=1 width="100%" border=0 align="center">
  <tr>
    <td valign="top" width="33%">
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign="top" width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/admin/images/icon-autoresponse.gif" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks1">
             <li><a href="letterlist.jsp?action=Letter List&autoid=<%=info.AutoID%>">Message List</a></li>
             <li><a href="response.jsp?action=Edit&autoid=<%=info.AutoID%>">Edit</a></li>
             <br>
             <li><a href="statistics.jsp?action=Design&autoid=<%=info.AutoID%>">Statistics</a></li>
             <li><a href="responselist.jsp?action=Delete&autoid=<%=info.AutoID%>" onClick="return confirm('Are you sure you want to delete it.');">Delete</a></li>
           </ul>
          </td>
        </tr>
      </table>
    </td>
    <td valign="top" width="34%">
<% if (i+1<ltArray.size()) {
  info = (AutoResponseInfo)ltArray.get(i+1);
%>
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign=top width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/admin/images/icon-autoresponse.gif" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks1">
             <li><a href="letterlist.jsp?action=Letter List&autoid=<%=info.AutoID%>">Message List</a></li>
             <li><a href="response.jsp?action=Edit&autoid=<%=info.AutoID%>">Edit</a></li>
             <br>
             <li><a href="statistics.jsp?action=Design&autoid=<%=info.AutoID%>">Statistics</a></li>
             <li><a href="responselist.jsp?action=Delete&autoid=<%=info.AutoID%>" onClick="return confirm('Are you sure you want to delete it.');">Delete</a></li>
           </ul>
          </td>
        </tr>
      </table>
<% } %>
    </td>
    <td valign="top" width="33%">
<% if (i+2<ltArray.size()) {
  info = (AutoResponseInfo)ltArray.get(i+2);
%>
      <table cellspacing=0 cellpadding=3 border=0>
        <tr>
          <td valign="top" width="15%" rowspan=2>
          <img width=32 height=32 src="/staticfile/admin/images/icon-autoresponse.gif" border=0>
          </td>
          <td><b><%=info.Name%></b></td>
        </tr>
        <tr>
          <td>
            <ul class="categorylinks1">
             <li><a href="letterlist.jsp?action=Letter List&autoid=<%=info.AutoID%>">Message List</a></li>
             <li><a href="response.jsp?action=Edit&autoid=<%=info.AutoID%>">Edit</a></li>
             <br>
             <li><a href="statistics.jsp?action=Design&autoid=<%=info.AutoID%>">Statistics</a></li>
             <li><a href="responselist.jsp?action=Delete&autoid=<%=info.AutoID%>" onClick="return confirm('Are you sure you want to delete it.');">Delete</a></li>
           </ul>
          </td>
        </tr>
      </table>
<% } %>
    </td>
  </tr>
</table>
</td></tr>
<% } %>
<tr>
<td><br><a href="response.jsp?action=Add">Create a New Autoresponder Group</a></td>
</tr>
</table>
<%@ include file="../share/footer.jsp"%>