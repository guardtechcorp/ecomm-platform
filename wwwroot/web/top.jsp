<%@ page import="com.zyzit.weboffice.web.LayoutWeb"%>
<%@ page import="com.zyzit.weboffice.util.Definition"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  LayoutWeb ly = new LayoutWeb(session, request);
  ConfigInfo cfInfo = ly.getConfigInfo();
%>
<TABLE cellSpacing=0 cellPadding=0 width=778 align="center" border=0 height="87">
  <TR>
    <TD align="center" valign="middle">
      <table width=778 border=0 cellpadding=0 cellspacing=0>
        <tr>
          <td rowspan=6> <img src="images/titlebar_01.gif" width=9 height=72></td>
          <td rowspan=2 background="images/titlebar_02.gif"><%=ly.getTitleText(cfInfo)%></td>
          <td colspan=2> <img src="images/titlebar_03.gif" width=242 height=29 alt=""></td>
          <td rowspan=4> <a href="index.jsp"><img src="images/titlebar_04.gif" width=48 height=51 border="0"></a></td>
          <td rowspan=4> <a href="index.jsp?action=shopcart"><img src="images/titlebar_05.gif" width=56 height=51 border="0"></a></td>
          <td rowspan=4> <a href="index.jsp?action=check%20out"><img src="images/titlebar_06.gif" width=63 height=51 border="0"></a></td>
          <td> <img src="images/spacer.gif" width=1 height=29 alt=""></td>
        </tr>
        <tr>
          <td colspan=2 rowspan=2 background="images/titlebar_07.gif" valign="top" align="center"><%=ly.getDomainText(cfInfo)%></td>
          <td> <img src="images/spacer.gif" width=1 height=11 alt=""></td>
        </tr>
        <tr>
          <td rowspan=3 background="images/titlebar_08.gif" valign="top"><%=ly.getSloganText(cfInfo)%></td>
          <td> <img src="images/spacer.gif" width=1 height=10 alt=""></td>
        </tr>
        <tr>
          <td> <img src="images/titlebar_09.gif" width=86 height=1 alt=""></td>
          <td rowspan=3> <img src="images/titlebar_10.gif" width=156 height=22></td>
          <td> <img src="images/spacer.gif" width=1 height=1 alt=""></td>
        </tr>
        <tr>
          <td rowspan=2> <img src="images/titlebar_11.gif" width=86 height=21></td>
          <td colspan=3 rowspan=2 background="images/titlebar_12.gif" valign="bottom" align="right">
          <script language="JavaScript" type="text/javascript">writeDate()</script>
          </td>
          <td> <img src="images/spacer.gif" width=1 height=14></td>
        </tr>
        <tr>
          <td> <img src="images/titlebar_13.gif" width=360 height=7></td>
          <td> <img src="images/spacer.gif" width=1 height=7></td>
        </tr>
      </table>
    </TD>
  </TR>
  <TR>
    <TD height=2></TD>
  </TR>
  <TR vAlign="middle" align="center" bgColor="#5a7da5">
    <TD colSpan=3 height=22 align="center">
     <A class="button" href="index.jsp"><IMG src="images/tp01-2.gif" border=0> Home Page</A>&nbsp;&nbsp;&nbsp;
     <%=ly.getNavigationLinks(cfInfo, "button")%>
     <A class="button" href="index.jsp?action=contact us"><IMG src="images/tp01-2.gif" border=0> Contact Us</A>&nbsp;&nbsp;&nbsp;&nbsp;
     <A class="button" href="index.jsp?action=shopcart"><IMG height=12 src="images/gouwu-2.gif" width=19 border=0> My Shopping Cart</A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="index.jsp?action=check out"><IMG src="images/tp01-2.gif" border=0> Check Out</A>&nbsp;&nbsp;&nbsp;
     <A class="button" href="index.jsp?action=ordertrack"><IMG src="images/tp01-2.gif" border=0> Order Tracking</A>
    </TD>
  </TR>
  <TR>
    <TD height=2></TD>
  </TR>
</TABLE>
<% } %>