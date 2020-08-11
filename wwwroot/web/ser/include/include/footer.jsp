<%@ page import="com.zyzit.weboffice.database.WebPage" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.model.MemberInfo" %>
<%@ page import="com.zyzit.weboffice.bean.WebPageBean" %>
<%
{
    MemberInfo ownerInfo = mcBean.getSiteOwnerInfo();
    String sRealAction = Utilities.getValue(WebPageBean.getRequestAction(session));
    String sPrefix = "dragbottom_";
    WebPageBean wpBean = WebPageBean.getObject(session);
    String sLinks = wpBean.getMenuLinks(cfInfo.MemberID, WebPage.PLACE_BOTTOMBAR, sPrefix, sRealAction.indexOf("_MenuLink") != -1);
    String sCallbackUrl = mcBean.encodedUrl("ajax/response.jsp?action=Swap_MenuOrder&place=" + WebPage.PLACE_BOTTOMBAR + "&prifix=" + sPrefix);
%>
<TABLE width="968" border="0" cellspacing="0" cellpadding="2" style="border-top:1px solid #E8E8E8"  bgColor="#ffffff" align="center">
<TR>
<% if (cfInfo.ShowCounter==100) { %>
<TD width="145" align="center" valign="top">
  <br><script type="text/javascript">showVisitorCount(15, 'black', '<%=mcBean.getDomainName()%>', '<%=mcBean.getPrefixCtr()%>')</script>
</TD>
<% } %>
<TD align="center">
 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
   <td align="right">
    <DIV id="bottommenuid" class="content" style="font:10px; padding:3px" align="center">
     <%=sLinks%>
    </DIV>
<script language="javascript">
initHortDrags("bottommenuid", "<%=sPrefix%>", '<%=sCallbackUrl%>');
</script>
   </td>
  </tr>
  <tr>
   <td width="98%" align="center" style="border-top: 1px dashed #DFDFDF">
<%
   sPrefix = "dragfooter_";
   sLinks = wpBean.getMenuLinks(cfInfo.MemberID, WebPage.PLACE_FOOTER, sPrefix, sRealAction.indexOf("_MenuLink") != -1);
   sCallbackUrl = mcBean.encodedUrl("ajax/response.jsp?action=Swap_MenuOrder&place=" + WebPage.PLACE_FOOTER + "&prifix=" + sPrefix);
%>
<DIV class="content" style="font:10px; padding:3px" align="center">
 <span id="footermenuid"><%=sLinks%></span> &nbsp;&nbsp;<font size=1><%=mcBean.getCopyRight3(ownerInfo)%>&nbsp;
 Power by <a href='http://www.webcenternode.com' target='_blank'>WebCenter</a></font>
</DIV>
<script language="javascript">
initHortDrags("footermenuid", "<%=sPrefix%>", '<%=sCallbackUrl%>');
</script>
   </td>
  </tr>
</table>
<!--SCRIPT src="http://www.google-analytics.com/urchin.js" type="text/javascript"></SCRIPT>
<SCRIPT type="text/javascript">
_uacct = "UA-1004241-1";
urchinTracker();
</SCRIPT-->
</TD>
</TR>
<% if ((cfInfo.AdvertiseBar&4)==(byte)4) { %>
<TR>
 <TD colspan="2" width="100%">
 <table width="100%" border="0" cellspacing="0" cellpadding="4" align="center" style1="border-top: 1px solid #DFDFDF">

<% if (cfInfo.VerticalBarSide<=1) { %>
 <TD width="232" valign1="top">
 <%@ include file="../website/webstatus_bottom.jsp"%>
 </TD>
<% } %>
 <TD>
   <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
    <TR>
     <TD width="5"></TD>
     <TD height="90" align='<%=cfInfo.VerticalBarSide<=1?"right":"left"%>'>
      <%@ include file="../ads/bottomads-graph.jsp"%>
     </TD>
     <TD width="5"></TD>
    </TR>
   </TABLE>
  </TD>
<% if (cfInfo.VerticalBarSide==2) { %>
  <TD width="232" valign="top">
  <%@ include file="../website/webstatus_bottom.jsp"%>
  </TD>
<% } %>
        
 </table>
 </TD>
</TR>
<% } %>
</TABLE>
<% } %>