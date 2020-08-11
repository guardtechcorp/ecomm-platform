<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{
  CustomerWeb web = new CustomerWeb(session, request, 10);
  ConfigInfo cfInfo = web.getConfigInfo();

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  CustomerInfo ctInfo =  web.getInfo(request);
  CompanyInfo info = web.getCompanyInfo();

//. 01/17/16 18:55:18^57867234^www.hepahealth.com^Website^10^nzhao@cybeye.com made a order (1357867242) from null
    
  if ("Place Order".equalsIgnoreCase(sAction))
  {//. Update credit card information first
/*Neil00
    CustomerWeb.Result ret = web.update(request, false);
    if (ret.isSuccess())
    {//. Then make order process
      ctInfo = (CustomerInfo)ret.getUpdateInfo();
    }

    ShopCartWeb shop11 = new ShopCartWeb(session, request, 100);
    ShopCartWeb.Result ret11 = shop11.processOnline(request, ctInfo);

    if (ret11.isSuccess())
    {//. Go to invoice page
      response.sendRedirect("invoice.jsp");
    }

    else
    {
      Errors errObj = (Errors)ret11.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
*/
    BasicBean.Result ret = BasicBean.getRequestResult(session);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
  }
  else if ("Callback".equalsIgnoreCase(sAction))
  {//. Update credit card information first
//    System.out.println("Callback by iTransact");
    ShopCartWeb shop11 = new ShopCartWeb(session, request, 100);
    String sRet = shop11.callback(request);
    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(sRet);
    response.getWriter().flush();
    response.getWriter().close();
    return;
  }
%>
<FORM name="customer" action="index.jsp?action=Place Order" method="post" target="PlaceOrderNow">
<input type="hidden" name="customerid" value="<%=ctInfo.CustomerID%>">
<input type="hidden" name="preorderno" value="<%=Utilities.getValue(request.getParameter("preorderno"))%>">
<input type="hidden" name="custom" value="<%=Utilities.getValue(request.getParameter("custom"))%>">
<TABLE width="99%" border=0 height="300" align="right"  bgcolor="<%=cfInfo.BackColor%>">
  <TR vAlign="middle">
    <TD height=20><img src="/staticfile/web/images/tp06.gif" align=CENTER><a href='<%=web.encodedUrl("index.jsp")%>'><%=web.getLabelText(cfInfo, "shopping-link")%></a> > <a href='<%=web.encodedUrl("index.jsp?action=shopcart")%>'><%=web.getLabelText(cfInfo, "cart-link")%></a> > <a href='<%=web.encodedUrl("index.jsp?action=orderconfirm")%>'><%=web.getLabelText(cfInfo, "confirm-link")%></a> >
     <font color="#FF0000"><%=web.getLabelText(cfInfo, "bill-link")%></font> > <%=web.getLabelText(cfInfo, "finish-link")%>
    </TD>
  </TR>
  <TR>
    <TD valign="top">
     <table align="center" border="0" cellpadding="10" cellspacing="0" width="100%" class="infobox">
      <tr>
       <td><img src="/staticfile/web/images/info.gif" height=14 width=14 alt="Payment Information">
       <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><font color="#FF6633"><%=web.getLabelText(cfInfo, "note-lab")%></font>
       <%=web.getLabelText(cfInfo, "note-des")%></font>
       </td>
      </tr>
     </table>
   </TD>
  </TR>
  <TR>
   <TD valign="top">
    <table class="table-1" width="100%" align="center" border=0>
      <tr bgColor="#4279bd" valign="middle">
       <td colspan="3" height=20><font color="#FFFFFF"><%=web.getLabelText(cfInfo, "fillbill-lab")%></font></td>
      </tr>
<% if (sDisplayMessage!=null) { %>
      <tr>
        <td colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
      </tr>
<% } %>
      <tr>
        <td colspan="3" height="12" align="center"></td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "nameoncard-lab")%></td>
        <td width="2%">&nbsp;</td>
        <td width="68%">
          <input maxlength=30 size=40 value="<%=Utilities.getValue(request.getParameter("creditname"))%>" name="creditname">
        </td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "cardtype-lab")%></td>
        <td width="2%">&nbsp; </td>
        <td width="68%">
          <select name="credittype">
            <%=web.getCreditCardList(ctInfo)%>
          </select>&nbsp;&nbsp;<%=web.getCardLinks()%>
        </td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "cardno-lab")%></td>
        <td width="2%">&nbsp;</td>
        <td width="68%">
          <input maxlength=20 size=40 value="<%=Utilities.getValue(request.getParameter("creditno"))%>" name="creditno">
        </td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "expireddate-lab")%></td>
        <td width="2%">&nbsp;</td>
        <td width="68%">
          <select name="expiredmonth">
            <option value="None" selected><%=web.getLabelText(cfInfo, "month-lab")%></option>
            <option value=01>01</option>
            <option value=02>02</option>
            <option value=03>03</option>
            <option value=04>04</option>
            <option value=05>05</option>
            <option value=06>06</option>
            <option value=07>07</option>
            <option value=08>08</option>
            <option value=09>09</option>
            <option value=10>10</option>
            <option value=11>11</option>
            <option value=12>12</option>
          </select>
          <select name="expiredyear">
            <option value="None" selected>Year</option>
            <%=web.getExpiredYear(ctInfo.ExpiredYear)%>
          </select>
        </td>
      </tr>
      <tr>
        <td width="30%" align="right"><%=web.getLabelText(cfInfo, "cardvn-lab")%></td>
        <td width="2%">&nbsp;</td>
        <td width="68%">
          <input maxlength=8 size=10 value="<%=Utilities.getValue(request.getParameter("csid"))%>" name="csid" type="text" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
          <font size=1>(<%=web.getLabelText(cfInfo, "seehelp-lab")%> <a href="javascript:ChildWin=window.open('/staticfile/web/cards-help.html','cards_help','resizable=yes,scrollbars=no,width=460,height=680');ChildWin.focus()"><%=web.getLabelText(cfInfo, "help-lab")%></a>.)</font>
        </td>
      </tr>
      <tr>
        <td width="30%">&nbsp;</td>
        <td width="2%">&nbsp;</td>
        <td width="68%">&nbsp;</td>
      </tr>
      <!--tr>
        <td class="row1" colspan=2 align="center">&nbsp; </td>
        <td class="row1" width="68%" align="left">
            <input type="submit" name="action" value="<%=sAction%>" onClick="return validateCustomerBilling(document.customer);">
            &nbsp;&nbsp;
        </td>
      </tr-->
      <!--tr>
        <td colspan=3 align="center">
I authorize ZYZ IT Company to charge me for the above total.
I further affirm that the name and personal information provided on this form are true and correct.
I further declare that I have read, understand and accept ZYZ IT Company's business terms as published on their web site.
        </td>
      </tr-->
      <tr>
        <td colspan=3 align="center"><b><%=web.getLabelText(cfInfo, "agreepay-lab")%> <%=Utilities.getValue(info.CompanyName)%>.</b></td>
      </tr>
<tr>
<td colspan=3>
<!-- %@ include file="waitprocess.jsp"%-->
<SPAN id="SubmitPanel">
<table width="100%" border=0>
      <tr>
        <td class="row1" colspan=2 align="center">&nbsp;</td>
        <td class="row1" width="60%" align="left">
          <script>createLeftButton();</script>
           <a class="button" onClick="return validateCustomerBilling(document.customer);" href="javascript:document.customer.submit();showHide('close','SubmitPanel');showHide('open','Processing');"><%=web.getLabelText(cfInfo, "order-but")%></a>
          <script>createRightButton();</script>
        </td>
      </tr>
      <tr>
        <td colspan=3 align="center" ><font size="1"><%=web.getLabelText(cfInfo, "order-des")%></font></td>
      </tr>
</table>
</SPAN>
</td>
</tr>
      <tr>
        <td colspan=3 align="center" height="10">&nbsp; </td>
      </tr>
    </table>
   </TD>
  </TR>
</TABLE>
</FORM>
<SCRIPT>onCustomerBillingLoad(document.customer);</SCRIPT>
<SCRIPT>CreditCardSelect(document.customer, "<%=ctInfo.CreditType%>", "<%=ctInfo.ExpiredMonth%>", "<%=ctInfo.ExpiredYear%>");</SCRIPT>
<% } %>