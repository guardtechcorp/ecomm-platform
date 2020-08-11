<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%
    String sPageTitle = mcBean.getPageTitle(request, cfInfo);
    String sHelp = mcBean.getHelpTag(sPageTitle);
   if ((sPageTitle!=null && sPageTitle.length()>0)||sHelp!=null) {
//System.out.println("spt=" + sPageTitle);
//      sPageTitle = Utilities.convertMime(sPageTitle, false);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/helptip.js" type="text/javascript"></SCRIPT>
<table width="100%" aling="center" cellspacing="0" cellpadding="0">
<TR>
  <TD height="28" align="center" style="background-color: <%=cfInfo.Title%>"><%=mcBean.getText(sPageTitle, cfInfo.TitleSize, cfInfo.TitleFont, cfInfo.TitleColor, true, false)%></TD>
<% if (sHelp!=null) { %>
  <TD width="1%" nowrap>
   <A class="topbutton" title="Click to show/hide help tip." href="javascript:;" onClick="taggleHelp();" onmouseover="showHelp('<%=sHelp%>');" onmouseout="hideHelp();"><IMG src="/staticfile/admin/images/quickhelp.gif" width=14 height=16 align="absMiddle" border="0"><b>Help Tip</b></A>
  </TD>  
<% } %>
</TR>
<% if (sHelp!=null) { %>
 <TR>
  <TD colspan="2" width1="100%" height="1" valign="top">
   <DIV id="tiphelp" style="DISPLAY: none">
   <table width="100%" cellpadding="4" cellspacing="1" class="infobox">
    <tr>
     <td id="tipcontent" bgcolor="#FFFFCC"></td>
    </tr>
   </table>
   </DIV>
  </TD>
</TR>
<% } %>
<TR>
  <TD height="1"></TD>
</TR>
</table>
<% } %>
