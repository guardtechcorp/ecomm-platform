<%@ page import="com.zyzit.weboffice.model.ContentInfo" %>
<%@ page import="com.zyzit.weboffice.bean.LinkPageBean"%>
<%@ page import="com.zyzit.weboffice.model.LinkPageInfo"%>
<%
{
//LinkPageBean.showAllParameters(request, out);
    LinkPageBean web = new LinkPageBean(session, 24, true);
    String sContent = "";
    if (sRealAction.startsWith("ShowFile"))
    {
       sPageTitle = request.getParameter("title");
       sContent = web.getFileContent(request);
    }
    else if (sRealAction.startsWith("Show"))
    {
       ContentInfo ctInfo = web.getContentInfo(request, cfInfo.MemberID);
//Utilities.dumpObject(ctInfo);
       sPageTitle = ctInfo.Title;
       sContent = ctInfo.Text;
    }
    else if (sRealAction.startsWith("Display"))
    {
        LinkPageInfo info = web.getPageInfo2(request);
//    String sAction = request.getParameter("action");
        if (info!=null)
        {
           if (info.Attribute==0)
           {//. It is a popup window
             web.getTargetContent(info, response);
             return;
           }

           sContent = web.getContent(info);
           sPageTitle = info.Title;
        }
        else
          sPageTitle = " Link Page";
    }
%>
<TABLE width="100%" align="right" border=0>
   <TR>
    <TD  style="padding:5 5 5 5px"><%=sContent%>
    </TD>
   </TR>
</TABLE>
<% } %>