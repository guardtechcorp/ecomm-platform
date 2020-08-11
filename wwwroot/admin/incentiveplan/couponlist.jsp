<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CouponBean"%>
<%@ page import="com.zyzit.weboffice.model.CouponInfo"%>
<%
  CouponBean bean = new CouponBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_INCENTIVEPLAN))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

//ctBean.showAllParameters(request, out);
  List ltArray = bean.getAll(request);
  String sUrl = "../incentiveplan/couponlist.jsp?" + "incid=" + request.getParameter("incid") + "&groupname=" + request.getParameter("groupname");

  String sHelpTag = "couponlist";
//  String sTitleLinks = "<a href=\"grouplist.jsp\">Coupon Group List</a> > <b>Coupon List</b>";
  String sTitleLinks = bean.getNavigation(request, "Coupon List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page you can view all the coupons in the group of <%=request.getParameter("groupname")%>.
<!--table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="20" valign="top"><font size="2"><a href="grouplist.jsp">Coupon Group List</a> > <b>Coupon List</b></font></td>
    <td width="5%"  height="20" valign="top" onmouseover="showTipHelp('couponlist');" onmouseout="showHideSpan('close','tiphelp');" >
     <a href="javascript:;" class="helplink"><IMG src="/staticfile/admin/images/quickhelp.gif" width=14 height=16 align="CENTER" border="0">Help</a>
    </td>
  </tr>
  <tr>
    <td height="1" valign="top" colspan="2">
     <DIV id="tiphelp" style="DISPLAY: none">
     <table width="100%" cellpadding="4" cellspacing="0" class="infobox">
      <tr>
       <td bgcolor="#FFFFCC"><DIV id="tipcontent"></DIV></td>
      </tr>
     </table>
     </DIV>
    </td>
  </tr>
  <tr>
    <td height="20" valign="top">From this page you can view all the coupons in the group of <%=request.getParameter("groupname")%>.</td>
  </tr>
</table-->
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'couponlist.jsp?incid=<%=request.getParameter("incid")%>&groupname=<%=request.getParameter("groupname")%>');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="8%" align="center" class="thCornerL" height="22">No.</th>
    <th width="17%" align="center" class="thCornerL" height="22"><%=bean.getSortNameLink("Name", sUrl, "Coupon Name")%></th>
    <th width="30%" align="center" class="thCornerL" height="22"><%=bean.getSortNameLink("DeliverTo", sUrl, "Deliver To")%></th>
    <th width="30%" align="center" class="thCornerL" height="22"><%=bean.getSortNameLink("UsedBy", sUrl, "Used By")%></th>
    <th width="15%" align="center" class="thCornerL" height="22"><%=bean.getSortNameLink("ModifyDate", sUrl, "Deliver To/Used By Date")%></th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr class="normal_row">
    <td colspan="5" align="center" height="20"><span class="failed"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     CouponInfo info = (CouponInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="8%"><%=(nStartNo+i)%></td>
    <td width="17%" align="center"><%=bean.getEmailLink(info, sUrl)%></td>
    <td width="30%" align="center"><%=Utilities.getValue(info.DeliverTo)%></td>
    <td width="30%" align="center"><%=Utilities.getValue(info.UsedBy)%></td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.ModifyDate, 16)%></td>
  </tr>
  <%}%>
<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=5>There is no any coupons available.</td>
  </tr>
<% } %>
  <tr>
    <td colspan="5" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
          <td width="35%">&nbsp;</td>
          <td width="65%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
