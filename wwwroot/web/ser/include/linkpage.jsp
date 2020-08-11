<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.database.WebPage" %>
<%@ page import="com.zyzit.weboffice.bean.WebPageBean" %>

<%
   String sDivName = "";
   String sUlName = "";//arrowlistmenu";
   String sColor = "#FFEFD5";
   if (cfInfo.LinkPage==1)
   {
     sDivName = "class='arrowlistmenu'";
     sColor = "#FFEFD5";
   }
   else if (cfInfo.LinkPage==2)
   {
     sUlName = "class='slidedoormenu'";
     sColor = "#FFDFE0";
   }
   else if (cfInfo.LinkPage==3)
   {
      sUlName = "class='glossymenu'";
       sColor = "#669BE9";
   }
   else if (cfInfo.LinkPage==4)
   {
      sUlName = "class='markermenu'";
      sColor = "#FFFFFF";
   }
   else if (cfInfo.LinkPage==5)
   {
      sDivName = "id='ddblueblockmenu'";
      sColor = "#2175bc";
   }
   else if (cfInfo.LinkPage==6)
   {
      sDivName = "class='wireframemenu'";
      sColor = "#FFFFFF";
   }
   else if (cfInfo.LinkPage==7)
   {
      sUlName = "class='buttonmenu'";
//      sColor = "#704968";
   }
   else if (cfInfo.LinkPage==8)
   {
      sUlName = "class='bevelmenu'";
      sColor = "#FFF2BF";
   }
   else if (cfInfo.LinkPage==9)
   {
      sUlName = "class='leftmenu'";
      sColor = "#006599";
   }
   else if (cfInfo.LinkPage==10)
   {
      sUlName = "class='categorylinks'";//chromemenu'";
      sDivName = "id='leftcolumn'";
      sColor = "#ffffff";//"#FFEFD5";
   }
   else if (cfInfo.LinkPage==11)
   {
      sDivName = "class='coolmenu'";
//      sColor = "#FFFFFF";
   }
 //<ul class=categoryitems id=linkpagemenuid>
%>
<tr>
 <td>
<table width="100%" cellspacing=0 cellpadding=2 align="left" border=0 bgcolor="<%=sColor%>">
<% if (Utilities.getValue(cfInfo.LinkPageTitle).length()>0) { %>    
<tr>
   <td valign="middle" class="eg-bar"><img src="/staticfile/web/images/tp05.gif" width=10 height=10>
   <b><font color="#ffffff">&nbsp;<%=Utilities.getValue(cfInfo.LinkPageTitle)%></font></b></td>
</tr>
<% } %>
 <tr>
   <td height="0"></td>
 </tr>
 <tr>
  <!--td width="6"></td-->
  <td align="center" valign="top">
   <table width="100%">
    <tr>
      <td align="left">
<% if (cfInfo.LinkPage==2) { %>
<!--[if IE]>
<style type="text/css">
.slidedoormenu li a{ /* Menu link width value for IE */
width: 100%;
}
</style>
<![endif]-->
<% } %>
 <div <%=sDivName%>>
  <ul <%=sUlName%> id="linkpagemenuid">
<%
    String sRealAction = Utilities.getValue(WebPageBean.getRequestAction(session));
    String sPrefix = "draglinkpage_";
    WebPageBean wpBean = WebPageBean.getObject(session);
    String sLinks = wpBean.getMenuLinks(cfInfo.MemberID, WebPage.PLACE_VERTICALPANEL, sPrefix, sRealAction.indexOf("_MenuLink") != -1);
    String sCallbackUrl = mcBean.encodedUrl("ajax/response.jsp?action=Swap_MenuOrder&place=" + WebPage.PLACE_VERTICALPANEL+ "&prifix=" + sPrefix);
%>
<%=sLinks%>
<script language="javascript">
initVertDrags('linkpagemenuid', '<%=sPrefix%>', '<%=sCallbackUrl%>');
</script>
  </ul>
  </div>          
      </td>
    </tr>
   </table>    
  </td>
 </tr>
</table>
</td>
</tr>