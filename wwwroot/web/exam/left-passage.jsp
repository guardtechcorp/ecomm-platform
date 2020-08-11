<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.model.ContentInfo"%>
<%@ page import="com.zyzit.weboffice.model.ExamPassageInfo"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<html>
<head>
<title>Passage Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/bookmark.js" type="text/javascript"></SCRIPT>
<script language="javascript" src="/staticfile/admin/scripts/search.js" type="text/javascript"></script>
</head>
<%
  ExamSectionBean bean = new ExamSectionBean(session, 0);
  ExamSectionBean.Result ret = bean.getStepInfo(request);
  String sDisplayMessage = null;
  String sContent = "";
  if (ret.isSuccess())
  {
    if ("page".equalsIgnoreCase(ret.m_sAction))
    {
       ContentInfo info = (ContentInfo)ret.getUpdateInfo();
       sContent = info.Text;
    }
    else
    {
      ExamPassageInfo info = (ExamPassageInfo)ret.getUpdateInfo();
      sContent = info.Content;
    }
  }
  else
  {//.
    Errors errObj = (Errors)ret.getInfoObject();
    sDisplayMessage = errObj.getError();
  }
  ExamSectionInfo info = bean.getSectionInfo(request);
%>
<script LANGUAGE="JavaScript">
<% if ("page".equalsIgnoreCase(ret.m_sAction)) { %>
function onPageLoad()
{
}
<% } else { %>
function onPageLoad()
{
  restoreAllBookmark('<%=bean.getBookmark(request, 0)%>');
}
function right(e)
{
    if (navigator.appName == 'Netscape' && (e.which == 3 || e.which == 2))
       return false;
    else if (navigator.appName == 'Microsoft Internet Explorer' && (event.button == 2 || event.button == 3))
    {
       checkAction(1);
       return false;
    }

    return true;
}
document.onmouseup=right;
if (document.layers) window.captureEvents(Event.MOUSEUP);
window.onmouseup=right;
<% } %>
document.oncontextmenu= new Function("return false");
</script>
<body bgcolor="<%=info.BackColor%>" onLoad="onPageLoad();">
<%=sContent%>
<% if (request.getParameter("keyword")!=null) { %>
<SCRIPT>search('<%=request.getParameter("keyword")%>', self);</SCRIPT>
<% } %>
</body>
</html>