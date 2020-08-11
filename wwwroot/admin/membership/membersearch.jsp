<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/membership.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%
  MemberBean bean = new MemberBean(session, 10);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERS))
    return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  if ("Search".equalsIgnoreCase(sAction))
  {
     int nTotalRecords = bean.getSearchList(request);
     if (nTotalRecords>0)
        response.sendRedirect("memberlist.jsp?action=Search List&return=javascript:history.go(-1)&display=Search Members");
     else
        sDisplayMessage = "There is no any order record found. Please try another search.";
  }

//  String sReturn = request.getParameter("return");
//  String sDisplay = request.getParameter("display");
  String sHelpTag = "membersearch";
//  String sTitleLinks = "";
//  if (sReturn!=null)
//    sTitleLinks += "<a href=\"" + Utilities.replaceContent(sReturn, "|", "?action=", false) +"\">" + sDisplay + "</a> > ";
//  sTitleLinks += "<b>Search Members</b>";
  String sTitleLinks = bean.getNavigation(request, "Search Members");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below allows you to search the specific members by the search filters below.
<%@ include file="../share/waitprocess.jsp"%>
<form name="membersearch" action="membersearch.jsp" method="post" onSubmit="return validateSearch(this);showHideSpan('open','Processing');">
<table width="92%" cellpadding="0" cellspacing="0" border="0" class="forumline" align="center">
    <tr>
      <th colspan="4" class="thHead">Member Search</th>
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
      <td width="23%" align="right">Member Name:</td>
      <td width="25%">
        <input maxlength=20 name="name" value="<%=Utilities.getValue(request.getParameter("name"))%>" size="30">
      </td>
      <td width="22%">
        <div align="right">Company:</div>
      </td>
      <td width="30%">
        <input maxlength=30 name="company" value="<%=Utilities.getValue(request.getParameter("company"))%>" size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Work Phone:</td>
      <td width="25%">
        <input maxlength=20 name="workphone" value="<%=Utilities.getValue(request.getParameter("workphone"))%>" size="30">
      </td>
      <td width="22%">
        <div align="right">E-Mail:</div>
      </td>
      <td width="30%">
        <input maxlength=50 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>" size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Address:</td>
      <td width="25%">
        <input maxlength=60 name="address1" value="<%=Utilities.getValue(request.getParameter("address1"))%>" size="30">
      </td>
      <td width="22%">
        <div align="right">City:</div>
      </td>
      <td width="30%">
        <input maxlength=25 name="city" value="<%=Utilities.getValue(request.getParameter("city"))%>" size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right" height="7">State/Province:</td>
      <td width="25%" height="7">
        <input maxlength=16 name="state" value="<%=Utilities.getValue(request.getParameter("state"))%>" size="30">
      </td>
      <td width="22%" height="7">
        <div align="right">Zip/Postal Code:</div>
      </td>
      <td width="30%" height="7">
        <input maxlength=10 name="zip" value="<%=Utilities.getValue(request.getParameter("zip"))%>" size="30" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Country:</td>
      <td colspan="3">
        <input maxlength=50 name="country" value="<%=Utilities.getValue(request.getParameter("country"))%>" size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td colspan="4" align="right" height="10"></td>
    </tr>
    <tr class="normal_row">
      <td width="23%">&nbsp;</td>
      <td colspan="2">From: (MM/DD/YYYY) </td>
      <td width="30%">To: (MM/DD/YYYY) </td>
    </tr>
    <tr class="normal_row">
      <td width="23%" align="right">Registration Date:&nbsp;</td>
      <td colspan="2">
        <input maxlength=10 name="createdate_from" value="<%=Utilities.getValue(request.getParameter("createdate_from"))%>"
        onblur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onkeyup='autoFormat(this,"D");' size="30">
      </td>
      <td width="30%">
        <input maxlength=10 name="createdate_to" value="<%=Utilities.getValue(request.getParameter("createdate_to"))%>"
        onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");' size="30">
      </td>
    </tr>
    <tr class="normal_row">
      <td colspan="4" height="2">&nbsp;</td>
    </tr>
    <tr class="normal_row">
      <td colspan="4" class="catBottom" align="center">
        <table width="100%" border="0">
          <tr>
            <td width="48%" align="right">
              <input type="submit" name="action" value="Search">
            </td>
            <td width="8%">&nbsp;</td>
            <td width="44%">
              <input type="reset" name="Reset" value="Reset">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<SCRIPT>onSearchFormLoad(document.membersearch);</SCRIPT>
<%@ include file="../share/footer.jsp"%>