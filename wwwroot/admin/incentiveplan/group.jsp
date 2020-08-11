<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/incentiveplan.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.IncentiveBean"%>
<%@ page import="com.zyzit.weboffice.model.IncentiveInfo"%>
<%
  IncentiveBean bean = new IncentiveBean(session, 10);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_INCENTIVEPLAN))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  IncentiveInfo info = null;
  if ("Generate Now".equalsIgnoreCase(sAction))
  {
    IncentiveBean.Result ret = bean.addGroup(request, true);
    if (!ret.isSuccess())
    {
      info = (IncentiveInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      response.sendRedirect("grouplist.jsp");
    }
  }
  else if ("Update Infomation".equalsIgnoreCase(sAction))
  {
    IncentiveBean.Result ret = bean.updateGroup(request);
    info = (IncentiveInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "this group");
    }
  }
  else if ("Edit Group".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Infomation";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
    info =  bean.getPrevOrNext(sAction);
//System.out.println("cgInfo = "+ cgInfo);
    sAction = "Update Infomation";
  }

  if (info==null)
  {
    info = IncentiveInfo.getInstance(true);
    info.Name = "New Group";
    info.Count = 100;
    info.AutoDelivery = -1;
    sAction = "Generate Now";
  }

  String sDisable = info.IncID!=-1?"disabled":"";

  String sHelpTag = "coupongroup";
  String sTitleLinks;
  String sDescription;
  if ("Generate Now".equalsIgnoreCase(sAction))
  {
//     sTitleLinks = "<a href=\"grouplist.jsp\">Coupon Group List</a> > <b>Generate New Group of Coupons</b>";
     sTitleLinks = bean.getNavigation(request, "Generate New Group of Coupons");
     sDescription = "The form below will allow you to generate a new group of coupons.";
  }
  else
  {
//     sTitleLinks = "<a href=\"grouplist.jsp\">Coupon Group List</a> > <b>Edit the Group Information</b>";
     sTitleLinks = bean.getNavigation(request, "Edit the Group Information");
     sDescription = "The form below will allow you to edit and update the group information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="coupongroup" action="group.jsp" method="post" onsubmit="return validateCoupon(this);">
<input type="hidden" name="incid" value="<%=info.IncID%>">
<% if (!"Generate Now".equalsIgnoreCase(sAction)) { %>
<table width="98%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("group.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="98%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3"><b>Generate a new group of coupons</b></th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" align="center" height="20"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" align="right" width="16%">Group Name:</td>
      <td class="row1" height="17">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength=20>
      </td>
      <td class="row1" width="57%">The name of new coupon group.</td>
    </tr>
    <tr>
      <td class="row1" align="right" width="16%">Total Count:</td>
      <td class="row1" height="17">
        <input maxlength=10 name="count" value="<%=info.Count%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");' <%=sDisable%>> (Max: 1000)
      </td>
      <td class="row1" width="57%">How many coupons will grenerate in this group.</td>
    </tr>
    <tr>
      <td class="row1" align="right" height="18" width="16%">Prefix:</td>
      <td class="row1" height="18">
        <input maxlength=10 name="prefix" value="<%=Utilities.getValue(request.getParameter("prefix"))%>" <%=sDisable%>> (Optional)
      </td>
      <td class="row1" height="18" width="57%">The prefix for each coupon to help to easily identify coupon group (Max length of chars must be less than 10.</td>
    </tr>
    <tr>
      <td class="row1" align="right" height="18" width="16%">String Length:</td>
      <td class="row1" height="18">
        <input maxlength=10 name="nolength" value="<%=Utilities.getInt(request.getParameter("nolength"), 6)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");' <%=sDisable%>>
      </td>
      <td class="row1" height="18" width="57%">The string lenght for each coupon in this group(Max length must be less than 10).</td>
    </tr>
    <tr>
      <td class="row1" align="right" width="16%">Max Used Count:</td>
      <td class="row1" height="17">
        <input maxlength=10 name="maxcount" value="<%=bean.getMaxCount(info)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      </td>
      <td class="row1" width="57%">The Maximum Used Count for each coupon.</td>
    </tr>
    <tr>
      <td class="row1" align="right" height="18" width="16%" valign="top">Auto Delivery:</td>
      <td class="row1"  height="18" valign="top">
        <select name="autodelivery">
          <option value=0 selected>Not Auto-Delivery</option>
          <option value=1>Customer</option>
          <option value=2>Newsletter Subscriber</option>
          <option value=4>Both of them</option>
        </select>
      </td>
      <td class="row1" height="18" width="57%">If select Customer, one of the coupons will automatically issue to the customer who will make a order, displaying on the invoice.<br>
      If select Newsletter Subscriber, one of coupons will automatically email to the subscriber who wants newsletter.<br>
      If select Both, one of coupons will send to ordering customer and newsletter subscriber.
      </td>
    </tr>
    <tr>
      <td class="row1" align="right" width="16%" valign="top">Description</td>
      <td class="row1" ><textarea name="description" rows="3" cols="35"><%=Utilities.getValue(info.Description)%></textarea></td>
      <td class="row1" height="18" width="57%">The group description will display on the invoice with a coupon of this group when it is selected as Auto-delivery
      to Customers or show on the email to a newsletter subscriber when it is selected as Auto-Delivery to Newsletter Subscriber.
      </td>
    </tr>
    <tr>
      <td class="row1" colspan="3" height="6">&nbsp;</td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center" height="22"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
  </table>
</form>
<SCRIPT>onCouponLoad(document.coupongroup);</SCRIPT>
<SCRIPT>selectDropdownMenu(document.coupongroup.autodelivery, '<%=info.AutoDelivery%>');</SCRIPT>
<%@ include file="../share/footer.jsp"%>