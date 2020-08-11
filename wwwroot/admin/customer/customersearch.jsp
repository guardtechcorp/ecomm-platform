<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/customer.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.bean.CustomerBean"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%
//CustomerBean.showAllParameters(request, out);
  CustomerBean bean = new CustomerBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CUSTOMER))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  if ("Search".equalsIgnoreCase(sAction))
  {
     int nTotalRecords = bean.getSearchList(request);
    if (nTotalRecords>0)
        response.sendRedirect("customerlist.jsp?action=Search List&return=javascript:history.go(-1)&display=Search Customers");
     else
       sDisplayMessage = "There is no any order record found. Please try another search.";
  }

  String sHelpTag = "customersearch";

  String sTitleLinks = bean.getNavigation(request, "Search Customer");

  String sState = request.getParameter("state");
  if (sState==null)
     sState = "CA";
  String sCountry = request.getParameter("country");
//  if (sCountry==null)
//     sCountry = "USA";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below will allow you to search the specific customers by the below filters.
<form name="customersearch" action="customersearch.jsp" method="post">
  <table width="65%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Customer Search</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="failed"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="10"></td>
    </tr>
    <tr>
      <td class="row1" colspan="2">
        <table cellspacing=0 cellpadding=0 width="100%" border=0>
        <tr>
          <td align=left width="32%">
            <div align="right">Customer ID:</div>
          </td>
          <td align=left width="1%">&nbsp;</td>
          <td align=left>
            <input maxlength=20 size=46 name="customerid" value="<%=Utilities.getValue(request.getParameter("customerid"))%>">
          </td>
        </tr>
          <tr>
            <td align=left width="32%">
              <div align="right">Name:</div>
            </td>
            <td align=left width="1%">&nbsp;</td>
            <td align=left>
              <input maxlength=20 size=46 name="yourname" value="<%=Utilities.getValue(request.getParameter("yourname"))%>">
            </td>
          </tr>
          <tr>
            <td align=left width="32%">
              <div align="right">Email Address:</div>
            </td>
            <td align=left width="1%">&nbsp;</td>
            <td align=left >
              <input maxlength=40 size=46 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>">
            </td>
          </tr>
          <tr>
            <td align=left width="32%">
              <div align="right">Phone Number:</div>
            </td>
            <td align=left width="1%">&nbsp;</td>
            <td valign=top align=left >
              <input maxlength=20 size=46 name="phone" value="<%=Utilities.getValue(request.getParameter("phone"))%>">
            </td>
          </tr>
          <!--tr>
            <td align=left width="38%">
              <div align="right">Name On Your Credit Card:</div>
            </td>
            <td align=left width="2%">&nbsp;</td>
            <td valign=top align=left >
              <input maxlength=20 name=creditname value="<%=Utilities.getValue(request.getParameter("creditname"))%>">
            </td>
          </tr-->
          <tr>
            <td align=left width="32%">
              <div align="right">Address: </div>
            </td>
            <td align=left width="1%">&nbsp;</td>
            <td align=left>
              <input maxlength=60 size=46 name="address" value="<%=Utilities.getValue(request.getParameter("address"))%>">
          </tr>
          <tr>
            <td align=left width="32%">
              <div align="right">City:</div>
            </td>
            <td align=left width="1%">&nbsp;</td>
            <td align=left>
              <input maxlength=25 size=46 name="city" value="<%=Utilities.getValue(request.getParameter("city"))%>">
            </td>
          </tr>
          <tr>
            <td width="32%">
              <div align="right">State: </div>
            </td>
            <td width="1%">&nbsp;</td>
            <td>
              <input maxlength=60 size=25 name="state" value="<%=Utilities.getValue(request.getParameter("state"))%>">
              Zip:
              <input maxlength=10 size=12 name="zipcode" value="<%=Utilities.getValue(request.getParameter("zipcode"))%>">
            </td>
          </tr>
          <tr>
            <td width="32%">
              <div align="right">Country:</div>
            </td>
            <td width="1%">&nbsp;</td>
            <td>
              <select name="country" size="1">
                <option value=""></option>
              </select>
            </td>
         </tr>
    <tr>
      <td colspan="3" height=5></td>
    </tr>
    <tr>
      <td width="32%">
        <div align="right"></div>
      </td>
      <td width="1%">&nbsp;</td>
      <td >From: (MM/DD/YYYY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To: (MM/DD/YYYY)</td>
    </tr>
    <tr>
      <td width="32%" align="right">Registration Date:</td>
      <td width="1%"></td>
      <td >
        <input size=20 maxlength=10 name="createdate_from" value="<%=Utilities.getValue(request.getParameter("createdate_from"))%>"
          onblur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onkeyup='autoFormat(this,"D");' size="30">&nbsp;&nbsp;&nbsp;
        <input size=20 maxlength=10 name="createdate_to" value="<%=Utilities.getValue(request.getParameter("createdate_to"))%>"
          onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");' size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td colspan="3" height="2">&nbsp;</td>
    </tr>
        </table>
      </td>
    </tr>
   <tr>
      <td class="catBottom" align="center" colspan="2">
        <table width="100%" border="0">
          <tr>
            <td width="48%" align="right"><input type="submit" name="action" value="Search" onClick="return validateSearch(document.customersearch);"/></td>
            <td width="8%">&nbsp;</td>
            <td width="44%"><input type="reset" name="Reset" value="Reset"></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<!--SCRIPT>setupOption(document.customersearch.state, g_State, "<%=sState%>");</SCRIPT-->
<SCRIPT>setupOption2(document.customersearch.country, g_Country, "<%=sCountry%>");</SCRIPT>
<SCRIPT>onCustomerSearchLoad(document.customersearch);</SCRIPT>
<%@ include file="../share/footer.jsp"%>