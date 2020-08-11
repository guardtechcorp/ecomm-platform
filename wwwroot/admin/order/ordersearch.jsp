<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/order.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.OrderBean"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%
//CustomerBean.showAllParameters(request, out);
  OrderBean bean = new OrderBean(session, 10);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ORDER))
    return;

  String sAction = request.getParameter("action");

  String sDisplayMessage = null;
  if ("Search".equalsIgnoreCase(sAction))
  {
     int nTotalRecords = bean.getSearchList(request);
     if (nTotalRecords>0)
        response.sendRedirect("orderlist.jsp?action=searchlist&return=javascript:history.go(-1)&display=Search Orders");
     else
       sDisplayMessage = "There is no any order record found. Please try another search.";
  }

  String sHelpTag = "ordersearch";
//  String sReturn = request.getParameter("return");
//  String sDisplay = request.getParameter("display");
//  String sTitleLinks = "";
//  if (sReturn!=null)
//    sTitleLinks += "<a href=\"" + Utilities.replaceContent(sReturn, "|", "?action=", false) +"\">" + sDisplay + "</a> > ";
//  sTitleLinks += "<b>Search Orders</b>";
  String sTitleLinks = bean.getNavigation(request, "Search Orders");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below allows you to search the specific orders by the search filters below.
<%@ include file="../share/waitprocess.jsp"%>
<form name="ordersearch" action="ordersearch.jsp" method="post" onSubmit="return validateSearch(document.ordersearch);showHideSpan('open','Processing');">
<!--input type="hidden" name="return" value="Utilities.getValue(sReturn)"-->
<!--input type="hidden" name="display" value="Utilities.getValue(sDisplay)"-->
<table width="92%" cellpadding="0" cellspacing="0" border="0" class="forumline" align="center">
    <tr>
      <th colspan="4" class="thHead">Order Search</th>
    </tr>
    <% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="4" align="center"><span class="failed"><%=sDisplayMessage%></span></td>
    </tr>
    <% } %>
    <tr class="normal_row">
      <td colspan="4" align="right" height="16"></td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Customer Name:</td>
      <td width="25%">
        <input maxlength=20 name="yourname" value="<%=Utilities.getValue(request.getParameter("yourname"))%>" size="30">
      </td>
      <td width="22%">
        <div align="right">Company Name:</div>
      </td>
      <td width="30%">
        <input maxlength=30 name="companyname" value="<%=Utilities.getValue(request.getParameter("companyname"))%>" size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Phone:</td>
      <td width="25%">
        <input maxlength=20 name="phone" value="<%=Utilities.getValue(request.getParameter("phone"))%>" size="30">
      </td>
      <td width="22%">
        <div align="right">E-Mail:</div>
      </td>
      <td width="30%">
        <input maxlength=50 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>" size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Shipping Address:</td>
      <td width="25%">
        <input maxlength=60 name="ship_address" value="<%=Utilities.getValue(request.getParameter("ship_address"))%>" size="30">
      </td>
      <td width="22%">
        <div align="right">Shipping City:</div>
      </td>
      <td width="30%">
        <input maxlength=25 name="ship_city" value="<%=Utilities.getValue(request.getParameter("ship_city"))%>" size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right" height="7">Shipping State/Province:</td>
      <td width="25%" height="7">
        <input maxlength=16 name="ship_state" value="<%=Utilities.getValue(request.getParameter("ship_state"))%>" size="30">
      </td>
      <td width="22%" height="7">
        <div align="right">Shipping Zip/Postal Code:</div>
      </td>
      <td width="30%" height="7">
        <input maxlength=10 name="ship_zipcode" value="<%=Utilities.getValue(request.getParameter("ship_zipcode"))%>">
      </td>
    </tr>
    <tr class="normal_row">
      <td colspan="4" align="right" height="16"></td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Order No:&nbsp;</td>
      <td colspan="3">
        <input maxlength=10 name="orderno" value="<%=Utilities.getValue(request.getParameter("orderno"))%>" size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%">&nbsp;</td>
      <td colspan="2">From: (MM/DD/YYYY) </td>
      <td width="30%">To: (MM/DD/YYYY) </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Order Date:&nbsp;</td>
      <td colspan="2">
        <input maxlength=10 name="createdate_from" value="<%=Utilities.getValue(request.getParameter("orderdate_from"))%>"
        onblur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onkeyup='autoFormat(this,"D");' size="30">
      </td>
      <td width="30%">
        <input maxlength=10 name="createdate_to" value="<%=Utilities.getValue(request.getParameter("orderdate_to"))%>"
        onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");' size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" height="8">&nbsp;</td>
      <td colspan="2">From: </td>
      <td width="30%">To: </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Grand Total:&nbsp;</td>
      <td colspan="2">
        <input maxlength=20 name="grandtotal_from" value="<%=Utilities.getValue(request.getParameter("grandtotal_from"))%>"
        onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");' size="30">
      </td>
      <td width="30%">
        <input maxlength=20 name="grandtotal_to" value="<%=Utilities.getValue(request.getParameter("grandtotal_to"))%>"
        onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");' size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Shipment:&nbsp;</td>
      <td width="25%">
        <select name="shipment">
        <option value="None" selected>Select</option>
        <option value="Yes">Order shipped</option>
        <option value="No">Order unshipped</option>
      </select>
      </td>
      <td width="22%">
        <div align="right">Payment Status:&nbsp;</div>
      </td>
      <td width="30%">
        <select name="payment">
        <option value="None" selected>Select</option>
        <option value="Waiting">Waiting</option>
        <option value="Pending">Pending</option>
        <option value="Completed">Completed</option>
      </select>
      </td>
    </tr>
    <tr class="normal_row">
      <td colspan="4" height="2">&nbsp;</td>
    </tr>
    <tr class="normal_row">
      <td colspan="4" class="catBottom" align="center">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="48%" align="right"><input type="submit" name="action" value="Search"></td>
            <td width="8%">&nbsp;</td>
            <td width="44%"><input type="reset" name="Reset" value="Reset"></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<SCRIPT>onOrderSearchLoad(document.ordersearch, "<%=Utilities.getValue(request.getParameter("shipment"))%>", "<%=Utilities.getValue(request.getParameter("payment"))%>");</SCRIPT>
<%@ include file="../share/footer.jsp"%>
