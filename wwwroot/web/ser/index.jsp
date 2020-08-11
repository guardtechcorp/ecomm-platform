<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.web.SessionWeb" %>
<%@ page import="java.util.Locale" %>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<%
java.util.Locale ll = new Locale("zh", "TW");
session.setAttribute("org.apache.struts.action.LOCALE", ll);//Locale.CHINA);

  try {      
//<@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=ISO8859_1" >
//MemberAccountBean.dumpAllParameters(request);
//MemberAccountBean.showAllParameters(request, out);
//MemberAccountBean.showSessionInfo(request, application, session, out);
    SessionWeb web1 = new SessionWeb(session, request);
    if (!web1.setDomainName(request, response, application.getRealPath("/")))
        return; // It is static home page load

    HttpSession sn = web1.getSession();
//System.out.println("xxxxxxxxxxxxxxxxxxxx----------sn=" + sn + "-->" + web1.getMemberInfo());
    if (web1.getHttpsUrl()==null)
    {
      response.setContentType("text/html; charset=ISO8859_1");
      request.setCharacterEncoding("UTF8");
    }
      
    MemberAccountBean mcBean = MemberAccountBean.getObject(sn);
    if ("idle".equalsIgnoreCase(request.getParameter("action")))
    {//. Send idle and tell the server I am still alive
       mcBean.checkIdle(request);
       return;
    }
      ConfigInfo cfInfo = mcBean.getSiteConfig(request);       //. Sepecial MemberSite
%>
<%@ include file="actioncontrol.jsp"%>
<%
   cfInfo = mcBean.getSiteConfig(request);       //. Sepecial MemberSite    
   mcBean.setConfigInfo(sn, cfInfo);
   String sOnLoad = "";
   if (mcBean.getMemberInfo()!=null)
   {
     sOnLoad = "onLoad=\"sendIdleFlag2("+(mcBean.getTimoutSeconds()-120)+",'" + mcBean.encodedUrl("index.jsp?action=idle") + "')\"";// ../../admin/share/idle.jsp')\"";
   }
//System.out.println("session=" + session+",  " + cfInfo+", " + mcBean);
%>
<%@ include file="include/htmlheader.jsp"%>
<BODY TOPMARGIN=0 <%=sOnLoad%> onUnload="onBrowserClose('<%=mcBean.encodedUrl("index.jsp?action=Sign Out_SignIn&type=windowclose")%>', true);" <%=mcBean.getBackgroundStyle(cfInfo)%>>
<!--table>
    <tr>
      <td>
          <FORM onsubmit="return validateGoSearch(this);" method=post name=searchform action=index.jsp>
          <INPUT value="Quick Search" type=hidden name=action1>
          <INPUT value=-13 type=hidden name=categoryid>
              <INPUT maxLength=128 size=24 name=keyword>&nbsp;
              <html:submit style="width:100px" title="Search">
                <bean:message key="label.welcome" />
              </html:submit>
              &nbsp;&nbsp;
              <INPUT style="width:120px" title="Search" value='<bean:message key="label.welcome" />' type=button name=submit1 class="searchbutton">


          </FORM>

      </td>
    </tr>
</table-->
<% if (cfInfo.NewsArea==2&&mcBean.getRealAction(request).length()==0) { %>
<%@ include file="include/floatingnews.jsp"%>
<% } %>
<TABLE width="970" height="60" border="1" align="center" cellpadding="0" cellspacing="0">
<TR>
 <TD>
<% if (cfInfo.TopBar==1) { %>
<%@ include file="include/topbar.jsp"%>
<% } else if (cfInfo.TopBar>1) { %>
<%=Utilities.getValue(cfInfo.TopbarCode).trim()%>
<% } %>
<% if ((cfInfo.AdvertiseBar&1)==(byte)1) { %>
<%@ include file="ads/advertisebar.jsp"%>
<% } else if (cfInfo.AdvertiseBar==64) { %>
 <%=Utilities.getValue(cfInfo.AdvertiseCode).trim()%>
<% } %>     
 <TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgColor='<%=cfInfo.DomainColor%>'>
  <TR>
    <TD width="100%" align="center">
    <%@ include file="include/navigatebar.jsp"%>
    </TD>
  </TR>
 </TABLE>
 <TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:0px" bgColor="#ffffff">
   <TR>
    <TD valign="top">        
     <TABLE width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style1="border-top:solid 1px #D6D6D6">
     <TR>
<% if (cfInfo.VerticalBarSide==1) { %>
     <TD width="212" valign="top">
       <%@ include file="include/verticalpanel.jsp"%>
     </TD>
     <TD  width="758" valign="top" style="border-left:dotted 1px #D6D6D6">
      <!--%@ include file="mainbody.jsp"%-->
      <jsp:include page="pageswitch.jsp" />
     </TD>
<% } else if (cfInfo.VerticalBarSide==2) { %>
     <TD width="758" valign="top" style="border-right:dotted 1px #D6D6D6">
      <!--%@ include file="mainbody.jsp"%-->
      <jsp:include page="pageswitch.jsp" />
     </TD>
     <TD width="212" valign="top">
       <%@ include file="include/verticalpanel.jsp"%>
     </TD>
<% } else { %>
     <TD width="100%" valign="top" style1="border-right:dotted 1px #D6D6D6">
      <!--%@ include file="mainbody.jsp"%-->
      <jsp:include page="pageswitch.jsp" />
     </TD>
<% } %>
     </TR>
     </TABLE>
    </TD>
   </TR>
   </TABLE>
   <%@ include file="include/footer.jsp"%>
  </TD>
 </TR>
</TABLE>
<SCRIPT type="text/javascript">
function notifyServer()
{
   var sHref = location.href;
   var arArgs = sHref.split("\/");
   if ((arArgs.length==4 && arArgs[3].length>0) || (arArgs.length==5 && arArgs[3].length>0 && arArgs[4].length==0))
   {
      var sNotifyUrl = '<%=web1.encodedUrl("index.jsp?action=hompageload")%>' + '&sitename=' + arArgs[3];
      getUrlContent(sNotifyUrl);
   }
}
notifyServer();
tryadjustFrameHeight('vFrame');            
</SCRIPT>
</BODY>
</HTML>
<%
}
catch (Exception e)
{
    e.printStackTrace();
}
%>