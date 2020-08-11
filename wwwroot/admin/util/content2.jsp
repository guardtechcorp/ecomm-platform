<SCRIPT type="text/javascript" language="JavaScript1.2" src="/staticfile/admin/scripts/contenteditor.js"></SCRIPT>
<%@ include file="../share/header.jsp"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ContentBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%
  ContentBean bean = new ContentBean(session);
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  ContentInfo info;// = bean.get(request);
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Update Now".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    ContentBean.Result ret = bean.update(request);
    info = (ContentInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      String sFinishUrl = request.getParameter("return")+"?action=finisheditcontent&name="+request.getParameter("name")+"&contentid="+info.ContentID;
      response.sendRedirect(sFinishUrl);
    }
  }
  else
  {
    info = bean.get(request);
  }
%>
<a href="<%=request.getParameter("return")%>">Go Back</a> > <b>Edit the Content</b>
<p>Here you can edit and update the content.</p>
<form name="post" action="content2.jsp" method="post">
  <input type="hidden" name="contentid" value="<%=info.ContentID%>">
  <input type="hidden" name="title" value="<%=request.getParameter("title")%>">
  <input type="hidden" name="name" value="<%=request.getParameter("name")%>">
  <input type="hidden" name="return" value="<%=request.getParameter("return")%>">
   <table cellspacing="1" cellpadding="4" border="0" align="center" class="forumline" width="100%">
    <tr>
      <th class="thHead" align="center"><%=request.getParameter("title")%></th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" align="center" valign="top">
        <textarea name="text" rows="20" cols="95" wrap="virtual"><%=info.Text%></textarea>
      </td>
    </tr>
    <tr>
      <td class="catBottom" align="center"><input type="submit" value="Update Now" name="action"></td>
    </tr>
  </table>
</form>
<%@ include file="../share/footer.jsp"%>