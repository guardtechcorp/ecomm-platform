<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 10);
  ConfigInfo cfInfo = web.getConfigInfo();
//bean.showAllParameters(request, out);
  String sAction = web.getRealAction(request);
  String sCancel = web.getLabelText(cfInfo, "cancelupdate-but");//"cancelupdate-but=Cancel Update";
  String sDisplayMessage = null;
  String sClass = "successful";
  CustomerInfo ctInfo = null;
  String sSubmitValue = "Submit Update";
  String sCancelValue = "Cancel Update";

  if ("Submit Information".equalsIgnoreCase(sAction))
  {
//    CustomerWeb.Result ret = web.update(request, true);
    BasicBean.Result ret = BasicBean.getRequestResult(session);
    if (!ret.isSuccess())
    {
      ctInfo = (CustomerInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
      sCancel = web.getLabelText(cfInfo, "cancel-but");//"cancel-but=Cancel";
      sCancelValue = "Cancel";
      sSubmitValue = "Submit Information";
    }
/*Neil00
    else
    {//. Should remove
//      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "account");
//      ctInfo = (CustomerInfo)ret.getUpdateInfo();
      response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm"));
    }
*/    
  }
//  else if ("Update My Account".equalsIgnoreCase(sAction))
  else if ("Submit Update".equalsIgnoreCase(sAction))
  {
//    CustomerWeb.Result ret = web.update(request, false);
    BasicBean.Result ret = BasicBean.getRequestResult(session);
    ctInfo = (CustomerInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
/*Neil00
    else
    {// Should remove
//      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "customer");
      response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm"));
    }
*/
  }
  else
  {
    if ("EditAccount".equalsIgnoreCase(sAction))
    {
      ctInfo =  web.getInfo(request);
      sAction = web.getLabelText(cfInfo, "submitupdate-but");//"submitupdate-but=Submit Update";
      sSubmitValue = "Submit Update";
    }
  }

  if (ctInfo==null)
  {
    ctInfo = CustomerInfo.getInstance2(true);
    ctInfo.Country = "USA";
    ctInfo.State = "CA";
    ctInfo.Ship_Country = "USA";
    ctInfo.Ship_State = "CA";
    ctInfo.Subscribe = 1;
    ctInfo.Taxable = 1;
    sAction = web.getLabelText(cfInfo, "submitinfo-but");//"submitinfo-but=Submit Infomation";
    sCancel = web.getLabelText(cfInfo, "cancel-but");//"Cancel";

    sSubmitValue = "Submit Information";
    sCancelValue = "Cancel";
  }
//Utilities.dumpObject(ctInfo);
%>
<FORM name="customer" action="index.jsp" method="post">
<input type="hidden" name="customerid" value="<%=ctInfo.CustomerID%>">
<input type="hidden" name="action1" value="">
<TABLE class="table-1" width="99%" align="right" border=0 height="530"  bgcolor="<%=cfInfo.BackColor%>">
  <TR vAlign="middle">
    <TD height=20><img src="/staticfile/web/images/tp06.gif" align="CENTER"><a href="<%=web.encodedUrl("index.jsp")%>"><%=web.getLabelText(cfInfo, "shopping-link")%></a> > <a href="<%=web.encodedUrl("index.jsp?action=shopcart")%>"><%=web.getLabelText(cfInfo, "cart-link")%></a> >
        <font color="#FF0000"><%=web.getAccountLink(cfInfo, ctInfo)%></font> > <%=web.getLabelText(cfInfo, "confirm-link")%> > <%=web.getLabelText(cfInfo, "finish-link")%>
    </TD>
  </TR>
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
    <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0 height="651">
      <% if (sDisplayMessage!=null) { %>
      <tr>
        <td colspan="3" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
      </tr>
      <% } %>
      <tr>
        <td colspan="3" height="5" align="center"></td>
      </tr>
      <tr>
        <td width="27%"><b><%=web.getLabelText(cfInfo, "billaddress-lab")%></b></td>
        <td width="1%">&nbsp;</td>
        <td>&nbsp;</td>
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
        <td><input maxlength=10 size=20 value="<%=ctInfo.ZipCode%>" name="zipcode"></td>
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
        <td width="27%">&nbsp;</td>
        <td width="1%">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3"><%=web.getLabelText(cfInfo, "shipaddress-des")%></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "shipname-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=30 size=40 value="<%=ctInfo.Ship_Yourname%>" name="ship_yourname"> <%=web.getLabelText(cfInfo, "firstname-des")%></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "companyname-lab")%></td>
        <td width="1%">&nbsp; </td>
        <td><input maxlength=30 size=40 value="<%=Utilities.getValue(ctInfo.Ship_CompanyName)%>" name="ship_companyname"> <%=web.getLabelText(cfInfo, "optional-des")%></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "shipaddress-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=60 size=40 value="<%=ctInfo.Ship_Address%>" name="ship_address"></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "city-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td>
          <input maxlength=25 size=40 value="<%=ctInfo.Ship_City%>" name="ship_city">
        </td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "state-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td>
          <select name="ship_state" size="1" onChange="OnSelectShipStateChange(document.customer)">
            <option value="None"><%=web.getLabelText(cfInfo, "state-sel")%>Select State</option>
          </select> <%=web.getLabelText(cfInfo, "other-lab")%> <input type="text" size="17" maxlength="30" name="ship_province" value="">
        </td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "zippostal-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=10 size=20 value="<%=ctInfo.Ship_ZipCode%>" name="ship_zipcode"></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "country-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td>
          <select name="ship_country" size="1" onChange="OnSelectShipCountryChange(document.customer)">
            <option value="None"><%=web.getLabelText(cfInfo, "country-sel")%></option>
          </select>
        </td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "phone-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=40 value="<%=ctInfo.Ship_Phone%>" name="ship_phone"> <%=web.getLabelText(cfInfo, "optional-des")%></td>
      </tr>
      <tr>
        <td width="27%">&nbsp;</td>
        <td width="1%">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3"><%=web.getLabelText(cfInfo, "emailinfo-lab")%></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "email-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=50 size=40 value="<%=ctInfo.EMail%>" name="email"></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "acceptnews-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td>
          <select name="subscribe">
            <option value=1 <%=web.getSelected(1, ctInfo.Subscribe)%>><%=web.getLabelText(cfInfo, "yes-sel")%></option>
            <option value=0 <%=web.getSelected(0, ctInfo.Subscribe)%>><%=web.getLabelText(cfInfo, "no-sel")%></option>
          </select>
        </td>
      </tr>
      <tr>
        <td width="27%">&nbsp;</td>
        <td width="1%">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3"><!--web.getLabelText(cfInfo, "account-des")%p-->
        <b>Account Information:</b> Please enter a password, our online system will create an account for you, and the account name is your E-Mail address. You can login to your account at any time, and you do not need to fill in information again for future purchase.             
        </td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "password-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=17 value="<%=ctInfo.Password%>" name="password" type="password"></td>
      </tr>
      <tr>
        <td width="27%" align="right"><%=web.getLabelText(cfInfo, "confirmpass-lab")%></td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength=20 size=17 value="<%=ctInfo.Password%>" name="cpassword" type="password"></td>
      </tr>
      <tr>
        <td width="27%">&nbsp;</td>
        <td width="1%">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td class="row1" colspan=2>&nbsp;</td>
        <td class="row1" width="68%">
          <input type="submit" name="update" value="<%=sAction%>" onClick="setAction(document.customer, '<%=sSubmitValue%>'); return validateCustomerAccount(document.customer);">
          &nbsp;&nbsp;<input type="submit" name="cancel" value="<%=sCancel%>" onClick="setAction(document.customer, '<%=sCancelValue%>');">
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
<SCRIPT>setupOption(document.customer.country, g_Country, "<%=ctInfo.Country%>");</SCRIPT>
<SCRIPT>setupStateOption(document.customer, "<%=ctInfo.State%>", 0);</SCRIPT>
<SCRIPT>onCustomerAccountLoad(document.customer, <%=ctInfo.CustomerID%>);</SCRIPT>
<SCRIPT>setupOption(document.customer.ship_country, g_Country, "<%=ctInfo.Ship_Country%>");</SCRIPT>
<SCRIPT>setupStateOption(document.customer, "<%=ctInfo.Ship_State%>", 1);</SCRIPT>
<% } %>