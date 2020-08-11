<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/community.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityProxyServerBean"%>
<%@ page import="com.omniserve.dbengine.model.CommunityProxyServerInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  CommunityProxyServerBean bean = new CommunityProxyServerBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  CommunityProxyServerInfo info = null;
  if ("Add Server".equalsIgnoreCase(sAction))
  {
    CommunityProxyServerBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (CommunityProxyServerInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "proxy server");
      response.sendRedirect("proxyserverlist.jsp?action=Server List&range=all&rootlink=yes");
    }
  }
  else if ("Update Server".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    CommunityProxyServerBean.Result ret = bean.update(request, false);
    info = (CommunityProxyServerInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "proxy server");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Server";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Server";
  }

  if (info==null)
  {
    info = CommunityProxyServerInfo.getInstance(true);
    info.Port = 80;
    info.Active = 1;
    sAction = "Add Server";
  }

  String sHelpTag = "communtiyproxyserver";
  String sTitleLinks;
  String sDescription;
  if ("Add Server".equalsIgnoreCase(sAction))
  {
     sTitleLinks = bean.getNavigation(request, "Add a Proxy Server");
     sDescription = "The form below will allow you to add a new proxy server.";
  }
  else
  {
     sTitleLinks = bean.getNavigation(request, "Edit the Proxy Server");
     sDescription = "The form below will allow you to edit & update the proxy server information.";
  }

%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="proxyserver" action="proxyserver.jsp" method="post" onsubmit="return validateProxyServer(this);">
<input type="hidden" name="serverid" value="<%=info.ServerID%>">
<% if ("Update Server".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("proxyserver.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Proxy Server Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
  <tr class="normal_row">
    <td width="20%" align="right">Server Name:</td>
    <td><input maxlength=255 size=40 name="name" value="<%=Utilities.getValue(info.Name)%>"></td>
  </tr>

  <tr class="normal_row">
    <td width="20%" align="right">IP Address:</td>
    <td><input maxlength=128 size=20 name="ip" value="<%=Utilities.getValue(info.IP)%>">
    </td>
  </tr>
  <tr class="normal_row">
      <td width="20%" align="right">Port:</td>
      <td><input maxlength=20 size=20 name="port" value="<%=info.Port%>">
      </td>
  </tr>
  <tr>
    <td class="row1" width="20%" align="right">Active:</td>
    <td class="row1">
      <select name="active">
        <option value=1 <%=bean.getSelected(1, info.Active)%>>On</option>
        <option value=0 <%=bean.getSelected(0, info.Active)%>>Off</option>
      </select>
    </td>
  </tr>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>" <%="View".equalsIgnoreCase(sAction)==true?"disabled":""%>></td>
  </tr>
  </table>
</form>
<SCRIPT>onProxyServerLoad(document.proxyserver);</SCRIPT>
<%@ include file="../share/footer.jsp"%>