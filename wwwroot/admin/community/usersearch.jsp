<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/communityuser.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.bean.CommunityUserBean"%>
<%
  CommunityUserBean bean = new CommunityUserBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_COMMUNITY))
     return;

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  int nTotalRecords = 0;
  if ("Search".equalsIgnoreCase(sAction))
  {
     nTotalRecords = bean.searchUserList(request, "userlist.jsp?");
     if (nTotalRecords>0)
//       response.sendRedirect("userlist.jsp?action=Search List");
      ;
     else
       sDisplayMessage = "There is no any order record found. Please try another search.";
  }

  String sHelpTag = "communitymembersearch";
  String sTitleLinks = "Members Search";//bean.getNavigation(request, "Members Search");
%>
<!--SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT-->
<SCRIPT language="JavaScript" type="text/javascript">
<!--
function confirmClose(reload)
{
  try{
    //question = confirm("Are you sure you want to decline the Terms of Service? Click Cancel to continue with registration.");
    //if (question == true) { }
    if (reload)
       parent.location = "userlist.jsp?action=Search List";
    parent.searchwin.hide();
    }catch(ex){}
}

var nFound = <%=nTotalRecords%>;
if (nFound>0)
{
  confirmClose(true);
}
-->
</SCRIPT>
<form name="thisform" action="usersearch.jsp" method="post" onSubmit="return validateUserSearch(this);">
  <table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline1" align="center">
    <!--tr>
      <th class="thHead" colspan="2">Member Search</th>
    </tr-->
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td colspan="3" align="center"><span class="failed"><%=sDisplayMessage%></span></td>
    </tr>
    <tr>
      <td colspan="3" height=2></td>
    </tr>
<% } %>
    <tr>
      <td  colspan="2">
        <table cellspacing=0 cellpadding=0 width="100%" border=0>
          <tr>
            <td width="25%" align="right">First Name:</td>
            <td align=left width="1%">&nbsp;</td>
            <td align=left>
              <input maxlength=20 size=15 name="firstname" value="<%=Utilities.getValue(request.getParameter("firstname"))%>">
              &nbsp;Last Name:
              <input maxlength=20 size=15 name="lastname" value="<%=Utilities.getValue(request.getParameter("lastname"))%>">
            </td>
          </tr>
          <tr>
            <td align="right" width="25%">Member ID</td>
            <td align=left width="1%">&nbsp;</td>
            <td align=left >
              <input maxlength=20 size=12 name="userid" value="<%=Utilities.getValue(request.getParameter("userid"))%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
            &nbsp;&nbsp;&nbsp;Ref Member ID:
              <input maxlength=20 size=12 name="refid" value="<%=Utilities.getValue(request.getParameter("refid"))%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
            </td>
          </tr>
          <tr>
            <td align="right" width="25%">Email Address:</td>
            <td align=left width="1%">&nbsp;</td>
            <td align=left >
              <input maxlength=40 size=47 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>">
            </td>
          </tr>
          <tr>
            <td align="right" width="25%">MD5:</td>
            <td align=left width="1%">&nbsp;</td>
            <td align=left >
              <input maxlength=40 size=47 name="usercode" value="<%=Utilities.getValue(request.getParameter("usercode"))%>">
            </td>
          </tr>
    <tr>
      <td colspan="3" height=5></td>
    </tr>
    <tr>
      <td width="25%" align="right"></td>
      <td width="1%">&nbsp;</td>
      <td> &nbsp;From: (MM/DD/YYYY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To: (MM/DD/YYYY)</td>
    </tr>
    <tr>
      <td width="25%" align="right">Registration Date:</td>
      <td width="1%"></td>
      <td>
        <input size=20 maxlength=10 name="createdate_from" value="<%=Utilities.getValue(request.getParameter("createdate_from"))%>"
          onblur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onkeyup='autoFormat(this,"D");' size="30">&nbsp;&nbsp;&nbsp;
        <input size=20 maxlength=10 name="createdate_to" value="<%=Utilities.getValue(request.getParameter("createdate_to"))%>"
          onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");' size="30">
      </td>
    </tr>
    <tr>
      <td width="25%" align="right"></td>
      <td width="1%">&nbsp;</td>
      <td> &nbsp;From: (MM/DD/YYYY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To: (MM/DD/YYYY)</td>
    </tr>
    <tr>
      <td width="25%" align="right">Login Date:</td>
      <td width="1%"></td>
      <td>
        <input size=20 maxlength=10 name="logindate_from" value="<%=Utilities.getValue(request.getParameter("logindate_from"))%>"
          onblur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onkeyup='autoFormat(this,"D");' size="30">&nbsp;&nbsp;&nbsp;
        <input size=20 maxlength=10 name="logindate_to" value="<%=Utilities.getValue(request.getParameter("logindate_to"))%>"
          onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");' size="30">
      </td>
    </tr>

    <tr>
      <td width="25%" align="right">Member Type:</td>
      <td width="1%"></td>
      <td>
      <select name="usertype">
        <option value=-1>Select Type</option>
        <option value=0>Common Member</option>
        <option value=1>Premium Member</option>
      </select>
      </td>
    </tr>
    <tr>
      <td colspan="3" height="10"></td>
    </tr>
        </table>
      </td>
    </tr>
   <tr>
      <td class="catBottom1" align="center" colspan="2">
        <table width="100%" border="0">
          <tr>
            <td width="48%" align="right"><input type="submit" name="action" value="Search"/></td>
            <td width="8%">&nbsp;</td>
            <td width="44%"><input type="button" name="Close" value="Close" onClick="confirmClose(false)"></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<SCRIPT>onUserSearchLoad(document.thisform);</SCRIPT>
<SCRIPT>selectDropdownMenu(document.thisform.usertype, <%=Utilities.getInt(request.getParameter("usertype"), -1)%>);</SCRIPT>
<%@ include file="../share/footer.jsp"%>