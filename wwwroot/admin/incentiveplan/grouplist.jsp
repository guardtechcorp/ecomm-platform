<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.IncentiveBean"%>
<%@ page import="com.zyzit.weboffice.model.IncentiveInfo"%>
<%
  IncentiveBean bean = new IncentiveBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_INCENTIVEPLAN))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  if ("delete".equalsIgnoreCase(sAction))
  {
    IncentiveBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
     }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

//ctBean.showAllParameters(request, out);
  List ltArray = bean.getCouponGroupList(request);

  String sHelpTag = "coupongrouplist";
//  String sTitleLinks = "<b>Coupon Group List</b>";
  String sTitleLinks = bean.getNavigation(request, "Coupon Group List");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page you can view all the coupon group and make some actions.

<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'grouplist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="98%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL" height="22">No.</th>
    <th width="25%" align="center" class="thCornerL" height="22"><%=bean.getSortNameLink("Name", "grouplist.jsp", "Group Name")%></th>
    <th width="11%" align="center" class="thCornerL" height="22"><%=bean.getSortNameLink("Count", "grouplist.jsp", "Quantity")%></th>
    <th width="15%" align="center" class="thCornerL"  height="22"><%=bean.getSortNameLink("AutoDelivery", "grouplist.jsp", "Auto Delivery")%></th>
    <th width="15%" align="center" class="thCornerL" height="22"><%=bean.getSortNameLink("CreateDate", "grouplist.jsp", "Generate Date")%></th>
    <th width="13%" align="center" class="thCornerL" height="22">Mass Delivery</th>
    <th width="16%" align="center" class="thCornerL" height="22">Actions</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td colspan="7" align="center" height="20"><span class="failed"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     IncentiveInfo info = (IncentiveInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="5%"><%=(nStartNo+i)%></td>
    <td width="25%"><%=info.Name%></td>
    <td width="11%" align="center"><%=info.Count%></td>
    <td width="15%" align="center"><%=bean.getAutoDeliver(info.AutoDelivery)%></td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="13%" align="center"><a href="../util/email.jsp?action=delivery&incid=<%=info.IncID%>&groupname=<%=info.Name%>&group=customers&subject=A coupon for discount ordering to save your money&return=../incentiveplan/grouplist.jsp&display=Coupon Group List" title="Email each of this group coupon to all customers or subscribers">Email Delivery</a></td>
    <td width="16%" align="center"><a href="couponlist.jsp?action=list&incid=<%=info.IncID%>&groupname=<%=info.Name%>">View</a>
    | <a href="group.jsp?action=Edit Group&&incid=<%=info.IncID%>">Edit</a>
    | <a href="grouplist.jsp?action=delete&incid=<%=info.IncID%>" onClick="return confirm('Are you sure you want to delete this group?');">Delete</a>
    </td>
  </tr>
<%}%>
<% if (ltArray==null||ltArray.size()==0){ %>
   <tr class="normal_row">
     <td colspan=7>There is no any coupon group available.</td>
   </tr>
<% } %>
  <tr>
    <td colspan="7" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
          <td width="35%"><a href="group.jsp?action=Generate Coupons">Generate new coupon group</a></td>
          <td width="65%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>
