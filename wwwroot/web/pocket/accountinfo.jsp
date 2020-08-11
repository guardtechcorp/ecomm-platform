<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 10);

//bean.showAllParameters(request, out);
  String sAction = web.getRealAction(request);
  String sActionValue = "edit-accountinfo";

  String sDisplayMessage = null;
  String sClass = "successful";
  CustomerInfo ctInfo = null;

  if (sAction.endsWith("submit-edit-accountinfo"))
  {
    CustomerWeb.Result ret = web.update(request, false);
    ctInfo = (CustomerInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "account");
      ctInfo = (CustomerInfo)ret.getUpdateInfo();
    }

    sAction = "Update Account";
    sActionValue = "cp-submit-edit-accountinfo";
  }
  else  if (sAction.endsWith("edit-accountinfo"))
  {
    ctInfo = web.getCustomerInfo();
    if (ctInfo==null)
    {//. It is not login and we need to forece it to login first
      TransferWeb.sendRedirectContent(response, "index.jsp?action=cp-accountlogin&nextaction=cp-edit-accountinfo");
      return;
    }

    sAction = "Update Account";
    sActionValue = "cp-submit-edit-accountinfo";
  }
  else if (sAction.endsWith("submit-create-accountinfo"))
  {
    CustomerWeb.Result ret = web.update(request, true);
    if (!ret.isSuccess())
    {
      ctInfo = (CustomerInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//.
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "account");
      ctInfo = (CustomerInfo)ret.getUpdateInfo();
      sAction = "Update Account";
      sActionValue = "cp-submit-edit-accountinfo";
    }
  }
  else if (sAction.endsWith("create-accountinfo"))
  {
    ctInfo = CustomerInfo.getInstance2(true);
    ctInfo.Country = "USA";
    ctInfo.State = "CA";
    ctInfo.Subscribe = 1;
    ctInfo.Taxable = 1;
    sActionValue = "cp-submit-create-accountinfo";
    sAction = "Create Account";
  }
  else
     return;

  ConfigInfo cfInfo = web.getConfigInfo();

  String sTitleLinks = web.getNavigationWeb(request, "Account Information");
%>
<table cellspacing=1 cellpadding=0 width="100%" align="right">
<tr>
<td height=20><%=sTitleLinks%></td>
</tr>
<TR>
<TD height=5 valign="top"></TD>
</TR>
<TR>
<TD align="center"><font class='pagetitle'>Account Information</font></TD>
</TR>
<TR>
<TD height=10 valign="bottom"></TD>
</TR>
<TR>
 <TD>

<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/moneypocket.js" type="text/javascript"></SCRIPT>
<FORM name="customer" action="index.jsp" method="post">
<input type="hidden" name="customerid" value="<%=ctInfo.CustomerID%>">
<input type="hidden" name="action1" value="">
<TABLE class="table-1" width="99%" align="right" border=0 bgcolor="<%=cfInfo.BackColor%>">
 <TR>
  <TD>
   <table align="center" border="0" cellpadding="10" cellspacing="0" width="100%" class="infobox">
    <tr>
     <td><img src="/staticfile/web/images/info.gif" height=14 width=14 alt="Payment Information">
     <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font color="#FF6633"><%=web.getLabelText(cfInfo, "info-lab")%></font>
     <%=web.getLabelText(cfInfo, "info-des")%></font>
     </td>
    </tr>
   </table>
 </TD>
 </TR>
  <TR vAlign="middle" bgColor="#4279bd">
      <TD height=20><font color="#FFFFFF"><%=web.getLabelText(cfInfo, "filladdress-des")%></font></TD>
  </TR>
  <TR>
   <TD valign="top">
    <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<% if (sDisplayMessage!=null) { %>
      <tr>
        <td colspan="3" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
      </tr>
<% } %>
      <tr>
        <td colspan="3" height="5" align="center"></td>
      </tr>
      <tr>
        <td colspan=3><b>Your Personal or Company Information:</b></td>
      </tr>
      <tr>
        <td colspan=3 height=5></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "yourname-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=30 size=40 value="<%=ctInfo.Yourname%>" name="yourname"> <%=web.getLabelText(cfInfo, "firstname-des")%></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "companyname-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=60 size=40 value="<%=Utilities.getValue(ctInfo.CompanyName)%>" name="companyname"> <%=web.getLabelText(cfInfo, "optional-des")%></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "address-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td ><input maxlength=60 size=40 value="<%=ctInfo.Address%>" name="address"></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "city-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=25 size=40 value="<%=ctInfo.City%>" name="city"></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "state-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td>
          <select name="state" size="1" onChange="OnSelectStateChange(document.customer)">
            <option value="None"><%=web.getLabelText(cfInfo, "state-sel")%></option>
          </select> <%=web.getLabelText(cfInfo, "other-lab")%> <input type="text" size="17" maxlength="30" name="province" value=""></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "zippostal-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=10 size=24 value="<%=ctInfo.ZipCode%>" name="zipcode"></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "country-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td>
          <select name="country" size="1" onChange="OnSelectCountryChange(document.customer)">
            <option value="None"><%=web.getLabelText(cfInfo, "country-sel")%></option>
          </select>
        </td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "phone-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=40 value="<%=ctInfo.Phone%>" name="phone"></td>
      </tr>
      <tr>
        <td width="27%" align="right">Fax Number:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=40 value="<%=ctInfo.Fax%>" name="fax"> (Optional)</td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "acceptnews-lab")%>
        </td>
        <td width="1%">&nbsp;</td>
        <td>
          <select name="subscribe">
            <option value=1 <%=web.getSelected(1, ctInfo.Subscribe)%>><%=web.getLabelText(cfInfo, "yes-sel")%></option>
            <option value=0 <%=web.getSelected(0, ctInfo.Subscribe)%>><%=web.getLabelText(cfInfo, "no-sel")%></option>
          </select>
        </td>
      </tr>
      <tr>
        <td colspan=3 height=10></td>
      </tr>
<% if (ctInfo.CustomerID>0) {%>
      <tr>
        <td width="27%">
<DIV id="show_accountsection" style="display:inline"><A class="reportoptions" onClick="showAccountInfo('show', 'account_section');" href="javascript:;"><IMG border="0" align="absmiddle" src="/staticfile/admin/images/arrowdown.gif">Change Passowrd</A></DIV>
<DIV id="hide_accountsection" style="display:none"><A class="reportoptions" onClick="showAccountInfo('hide', 'account_section');" href="javascript:;"><IMG border="0" align='absmiddle' src="/staticfile/admin/images/arrow.gif">Hide Password</A></DIV>
        </td>
        <td colspan="2">
      </tr>
<% } %>
      <tr>
        <td colspan=3>
<SPAN id="account_section" style="display:<%=ctInfo.CustomerID>0?"none":"inline"%>">
     <TABLE border=0>
      <tr>
        <td colspan="3"><b>Account Information:</b> (Your email will be the account name in the online system)
        </td>
      </tr>
      <tr>
        <td colspan=3 height=5></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "email-lab")%>
        </td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=50 size=40 value="<%=ctInfo.EMail%>" name="email"></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "password-lab")%>
        </td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=17 value="<%=ctInfo.Password%>" name="password" type="password">
         <%=web.getLabelText(cfInfo, "confirmpass-lab")%>&nbsp;<input maxlength=20 size=17 value="<%=ctInfo.Password%>" name="cpassword" type="password">
        </td>
      </tr>
     </TABLE>
</SPAN>
       </td>
      </tr>
      <tr>
        <td colspan=3><hr width="98%"></td>
      </tr>
      <tr>
        <td class="row1" colspan=2>&nbsp;</td>
        <td class="row1" width="68%">
          <input type="submit" name="update" value="<%=sAction%>" onClick="setAction(document.customer, '<%=sActionValue%>'); return validateAccount(document.customer);">
          &nbsp;&nbsp;<!--input type="submit" name="cancel" value="Cancel" onClick="setAction(document.customer, 'Cancel');"-->
        </td>
      </tr>
      <tr>
        <td colspan="3" height="10">&nbsp; </td>
      </tr>
    </table>
   </TD>
  </TR>
</TABLE>
</FORM>
<SCRIPT>setupOption(document.customer.state, g_State, "<%=ctInfo.State%>");</SCRIPT>
<SCRIPT>setupOption(document.customer.country, g_Country, "<%=ctInfo.Country%>");</SCRIPT>
<SCRIPT>onAccountFormLoad(document.customer, <%=ctInfo.CustomerID%>);</SCRIPT>
 </td>
 </tr>
</table>
<% } %>