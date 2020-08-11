<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/customer.js"></SCRIPT>
<script language="JavaScript" src="/staticfile/admin/scripts/choosedate.js"></script>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MoneyPocketBean"%>
<%@ page import="com.zyzit.weboffice.database.MoneyPocket"%>
<%@ page import="com.zyzit.weboffice.model.MoneyPocketInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  MoneyPocketBean bean = new MoneyPocketBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CUSTOMER))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  MoneyPocketInfo info = null;
  if ("Add Credit".equalsIgnoreCase(sAction))
  {
    MoneyPocketBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (MoneyPocketInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "add credit");
      response.sendRedirect("moneypocketlist.jsp?action=Added Credit");
      return;
    }
  }
  else if ("View".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "View";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "View";
  }

  if (info==null)
  {
    info = MoneyPocketInfo.getInstance(true);
    info.Money = 100;
    info.Type = MoneyPocket.TYPE_BUYCREDIT_BONUS;
    info.MemberID = bean.getCustomerId();
    sAction = "Add Credit";
  }

  String sHelpTag = "moneypocket";
  String sTitleLinks;// = "<a href=\"userlist.jsp?action=User List\">Community Member List</a> > ";
  String sDescription;
  if ("Add Credit".equalsIgnoreCase(sAction))
  {
     sTitleLinks = bean.getNavigation(request, "Add Credit");
     sDescription = "The form below will allow you to add a new credit to <b>" + bean.getCustomerName() + "</b>.";
  }
  else
  {
     sTitleLinks = bean.getNavigation(request, "View Credit Information");
     sDescription = "The form below allow you to view the credit information of <b>" + bean.getCustomerName() + "</b>.";
  }

%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="moneypocket_form" action="moneypocket.jsp" method="post" onsubmit="return validateMoneyPocketForm(this);">
<input type="hidden" name="pocketid" value="<%=info.PocketID%>">
<input type="hidden" name="memberid" value="<%=info.MemberID%>">
<input type="hidden" name="type" value="<%=info.Type%>">
<% if (!"Add Credit".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("moneypocket.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Credit Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>

  <tr class="normal_row">
    <td width="20%" align="right">Money:</td>
    <td><input type="text" name="money" value="<%=info.Money%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'></td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">Expired Date:</td>
    <td><input maxlength=10 name="expireddate" value="<%=Utilities.getValue(info.ExpiredDate)%>"
        onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'>
       <input type="button" value="Choose one..." onClick="getCalendarFor(document.moneypocket_form.expireddate)">
        (MM/DD/YYYY) If it is empty, no expired date is apply.
    </td>
  </tr>
  <tr class="normal_row">
    <td width="20%" align="right">How To Get:</td>
    <td><b><%=bean.getCreditType(info)%></b></td>
  </tr>

  <!--tr class="normal_row">
    <td width="20%" align="right">More Information:</td>
    <td>bean.getExtraInfo(info.UserID)</td>
  </tr-->
  <tr>
    <td class="catBottom" colspan="2" align="center">
<% if ("Add Credit".equalsIgnoreCase(sAction)){ %>
      <input type="submit" name="action" value="<%=sAction%>">
<% } %>
    </td>
  </tr>
  </table>
</form>
<SCRIPT>onMoneyPocketFormLoad(document.moneypocket_form);</SCRIPT>
<%@ include file="../share/choosedate.jsp"%>
<%@ include file="../share/footer.jsp"%>