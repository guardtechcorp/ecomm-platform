<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.PaidServiceInfo"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.servlet.PaypalCallback" %>
<%@ page import="com.zyzit.weboffice.bean.ProductServiceBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.zyzit.weboffice.database.PaidService" %>
<%
{ 
    ProductServiceBean bean = ProductServiceBean.getObject(session);

    if (sRealAction.startsWith("SubmitBuy"))
    {
//ProductServiceBean.dumpAllParameters(request);
        String sType = request.getParameter("type");
        if ("cancel".equalsIgnoreCase(sType))
        {
            sDisplayMessage = bean.getLabel("as-cancelpay");//"You just canceled the payment process. But you can finish it any time.";
            nDisplay = 0;
        }
        else
        {
            sDisplayMessage = bean.getLabel("as-purchase");//"You have successfully purchased the advanced service. Thanks. ";
            nDisplay = 1;
        }
    }
    else if (sRealAction.startsWith("Update Rows"))
    {
        bean.changeMaxRowsPerPage(request);
    }

    String sSubjectNote = null;//mcBean.getTemplateSubject("Apply-Membership");
    String sContentNote = null;//mcBean.getTemplateContent("Apply-Membership");
 //Apply the membership and become one of the members, you can get a lot of benefits and good services!
 //<ul><br><li>You can communicate with the owner and other members.</li><br><li>You can view and download the pages/files that only provided for its membrs.</li><br><li>You can get any notification of this website activities and events.</li></ul>

    sSubjectNote = bean.getLabel("as-makemoney");//"With advanced services, you can make money from your website.";
    StringBuffer sbContentNode = new StringBuffer();
    sbContentNode.append("<LI>" + bean.getLabel("as-paidmship") + "</LI><br>");
    sbContentNode.append("<LI>" + bean.getLabel("as-advertise") + "</LI>");
    sContentNote = sbContentNode.toString();

    List ltArray = bean.getAll(request, "index.jsp?action=Switch Page_PaidService", mbInfo.MemberID);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<table class1="table-outline" width="100%" align="center" cellspacing="1" cellpadding="2">
<TR>
 <TD>
  <%@ include file="../include/promotenote.jsp"%>
 </TD>
 </TR>
<tr>
 <td height="10" valign="bottom"></td>
</tr>
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
<TR>
 <TD height="5"></TD>
</TR>
<tr>
<td>
 <TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
  <TR>
   <TD width="50%"><font size=3>&nbsp;<b>. <%=bean.getLabel("as-servicebought")%>:</b></font></TD>
   <TD align="right"><%=bean.getLabel("cm-maxrow")%>:
    <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=bean.encodedUrl("index.jsp?action=Update Rows_PaidService")%>');">
    <%=bean.getRowsPerPageList(-1)%>
    </select>
   </TD>
  </TR>
 </TABLE>
 </td>
</tr>
<TR>
 <TD height="1">
 <table class="table-1" width="100%" align="right" border=0 cellspacing=1 cellpadding=1>
  <tr vAlign="middle" bgColor="#4959A7">
  <td width="8%" align="center" height="22"><FONT color="#ffffff"><b><%=bean.getLabel("cm-number")%></b></FONT></td>
  <td width="25%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("as-servicename")%></b></FONT></td>
  <td width="10%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("as-quantity")%></b></FONT></td>
  <td width="15%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("as-unitprice")%></b></FONT></td>
  <td width="15%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("as-totalpaid")%></b></FONT></td>
  <td width="17%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("as-expireddate")%></b></FONT></td>
  </tr>
<% if (ltArray==null||ltArray.size()==0) { %>
  <tr class="normal_row">
   <td colspan=6 height="24"><%=bean.getLabel("as-noservicbuy")%></td>
  </tr>
<% } else { %>
<%
   int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
   for (int i = 0; ltArray != null && i < ltArray.size(); i++) {
       PaidServiceInfo info = (PaidServiceInfo)ltArray.get(i);
%>
  <tr class="normal_row">
   <td width="8%" align="center" height="20"><%=(nStartNo+i)%></td>
   <td width="25%" align="center"><%=info.m_ProductName%></td>
   <td width="10%" align="center"><%=info.Quantity%></td>
   <td width="15%" align="right"><%=Utilities.getNumberFormat(info.UnitPrice, '$', 2)%>&nbsp;&nbsp;</td>
   <td width="15%" align="right"><%=Utilities.getNumberFormat(info.UnitPrice*info.Quantity, '$', 2)%>&nbsp;&nbsp;</td>
   <td width="17%" align="center"><%=Utilities.getDateValue(info.ExpireDate, 10)%></td>
 </tr>
<% } %>
<%
    String sMembershipExpiredDate = PaidService.getExpiredDate(bean.getDomainName(), mbInfo.MemberID, 6);
    String sAdsExpiredDate = PaidService.getExpiredDate(bean.getDomainName(), mbInfo.MemberID, 7);
    StringBuffer sbMessage = new StringBuffer();
    if (sMembershipExpiredDate!=null)
    {
       if (PaidService.isActive(bean.getDomainName(), mbInfo.MemberID, 6))
         sbMessage.append(bean.getLabel("as-servicewill") + " <font color='green'><b>" + Utilities.getDateValue(sMembershipExpiredDate, 10) + "</b></font>. ");
       else
         sbMessage.append(bean.getLabel("as-serviceexpired") + " <font color='red'><b>" + Utilities.getDateValue(sMembershipExpiredDate, 10) + "</b></font>. ");
    }
    else
       sbMessage.append("." + bean.getLabel("as-notbuy"));
    sbMessage.append("<br>");    
    if (sAdsExpiredDate!=null)
    {
        if (PaidService.isActive(bean.getDomainName(), mbInfo.MemberID, 6))
          sbMessage.append(bean.getLabel("as-adwill") + " <font color='green'><b>" + Utilities.getDateValue(sAdsExpiredDate, 10) + "</b><font>.");
        else
          sbMessage.append(bean.getLabel("as-adexpired") + " <font color='red'><b>" + Utilities.getDateValue(sAdsExpiredDate, 10) + "</b><font>.");
    }
    else
       sbMessage.append(bean.getLabel("as-notbuy"));

%>
 <tr class="normal_row2">
  <td colspan=7>
   <table width="100%">
     <tr>
       <td width="60%"><%=sbMessage.toString()%></td>
       <td align="right"><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></td>
     </tr>
   </table>
  </td>
 </tr>
<% } %>
 </table>
 </TD>
</TR>
<TR>
 <TD align="center" height="10"></TD>
</TR>
<TR>
 <TD><font size=3>&nbsp;<b>. <%=bean.getLabel("as-buymore")%>:</b></font></TD>
</TR>
<tr>
 <td>
<%
    List ltProduct = bean.getProductServices();
    String sUnitPrices = "";
    String sProductIds = "";
    float fTotal = 0;
    for (int i=0; i<ltProduct.size(); i++) {
        ProductInfo info = (ProductInfo) ltProduct.get(i);

        if (sProductIds.length()>0)
           sProductIds += ",";
        sProductIds += info.ProductID;

        if (sUnitPrices.length()>0)
           sUnitPrices += ",";
        sUnitPrices += info.Price;
        fTotal += info.Price;
    }
%>
 <TABLE width="100%" align="right" cellspacing=1 cellpadding=1 border=0 bgColor="#f7f7f7">
 <FORM name="form_services" action="https://www.paypal.com/cgi-bin/webscr" method="post" onSubmit="return validateSubmitService(this, <%=mbInfo.MemberID%>, 0, '<%=sProductIds%>', '<%=sUnitPrices%>');">
 <input type="hidden" name="charset" value="utf8">
 <input type="hidden" name="cmd" value="_ext-enter">
 <input type="hidden" name="redirect_cmd" value="_xclick">
 <input type="hidden" name="first_name" value="<%=mbInfo.FirstName%>">
 <input type="hidden" name="last_name" value="<%=mbInfo.LastName%>">
 <input type="hidden" name="address1" value="<%=Utilities.getValue(mbInfo.Address1)%>">
 <input type="hidden" name="city" value="<%=Utilities.getValue(mbInfo.City)%>">
 <input type="hidden" name="state" value="<%=Utilities.getValue(mbInfo.State)%>">
 <input type="hidden" name="zip" value="<%=Utilities.getValue(mbInfo.Zip)%>">
 <input type="hidden" name="country" value="<%=Utilities.getValue(mbInfo.Country)%>">
 <input type="hidden" name="business" value="<%=Utilities.getValue(bean.getPaymentInfo("paypal").Options)%>">
 <input type="hidden" name="item_name" value="Advanced Services (Paid Membership, Your Advertisment)">
 <input type="hidden" name="item_number" value="">
 <input type="hidden" name="quantity" value="1">
 <input type="hidden" name="amount" value="">
 <!--input type="hidden" name="tax" value="0.0"-->
 <!--input type="hidden" name="shipping" value="0.0"-->
 <input type="hidden" name="invoice" value="<%=Utilities.getUniqueId(10)%>">
 <input type="hidden" name="custom" value="<%=bean.getDomainName()%>,PaidService,">
 <input type="hidden" name="rm" value="2">
 <input type="hidden" name="no_note" value="1">
 <input type="hidden" name="no_shipping" value="1">
 <input type="hidden" name="notify_url" value='<%=PaypalCallback.getCallbackUrl(mcBean.getDomainName(), "notify")%>'>
 <input type="hidden" name="return" value='<%=PaypalCallback.getReturnUrl(mcBean.getDomainName(), "SubmitBuy_PaidService")%>'>
 <input type="hidden" name="cancel_return" value='<%=PaypalCallback.getCancelUrl(mcBean.getDomainName(), "SubmitBuy_PaidService")%>'>
 <tr vAlign="middle" bgColor="#4279bd">
  <td width="8%" align="center" height="24"><FONT color="#ffffff"><b><%=bean.getLabel("cm-number")%></b></FONT></td>
  <td width="35%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("as-servicename")%></b></FONT></td>
  <td width="15%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("as-unitprice")%></b></FONT></td>
  <td width="20%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("as-quantity")%></b></FONT></td>
  <td width="12%" align="center"><FONT color="#ffffff"><b><%=bean.getLabel("as-subtotal")%></b></FONT></td>
 </tr>
<%
    for (int i=0; i<ltProduct.size(); i++) {
        ProductInfo info = (ProductInfo) ltProduct.get(i);
%>
  <tr class1="normal_row">
   <td width="8%" align="center" height="24"><b><%=(1+i)%></b></td>
   <td width="35%"><b><%=info.Name%></b></td>
   <td width="15%" align="right"><b><%=Utilities.getNumberFormat(info.Price, '$', 2)%>&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
   <td width="20%" align="center">
   <select name="term_<%=(i)%>" onChange="onQuantityChange(document.form_services, <%=i%>, '<%=sUnitPrices%>')">
    <option value=0>0</option>
    <option value=1>1</option>
    <option value=2>2</option>
    <option value=3>3</option>
    <option value=4>4</option>
    <option value=5>5</option>
    <option value=6 SELECTED>6</option>
    <option value=7>7</option>
    <option value=8>8</option>
    <option value=9>9</option>
    <option value=10>10</option>
    <option value=11>11</option>
    <option value=12>12</option>
   </select>&nbsp;&nbsp;<b>Months</b>
   </td>
   <td width="12%" align="right" id='id_subtotal_<%=i%>'><b><%=Utilities.getNumberFormat(info.Price, '$', 2)%></b>&nbsp;&nbsp;</td>
 </tr>
<% } %>
 <tr>
  <td colspan="5" height="10"></td>
 </tr>
 <tr class1="normal_row">
  <td colspan="3"></td>
  <td width="20%" align="right"><font size=2><b><%=bean.getLabel("as-total")%>:&nbsp;&nbsp;</b></font></td>
  <td width="12%" align="right" id='id_totalcharge'><font size=2><b><%=Utilities.getNumberFormat(fTotal, '$', 2)%></b>&nbsp;&nbsp;</font></td>
 </tr>
 <tr>
  <td colspan="5" height="5"></td>
 </tr>
 <tr>
  <td colspan="5"><hr class="line" width="99%"></td>
 </tr>
 <tr>
   <td colspan="3" align="right"><b><%=bean.getLabel("ms-paybycc")%></b></td>
   <td colspan="2" align="right"><input type="image" name="submit" src="/staticfile/web/images/paypal_cards.gif" alt="<%=bean.getLabel("ms-paybyccdes")%>" border="0">&nbsp;&nbsp;</td>
 </tr>
 <tr>
  <td colspan="3" align="right"><b><%=bean.getLabel("ms-payvia")%></b></td>
  <td colspan="2" align="right"><input type="image" name="submit" src="/staticfile/web/images/x-click-but01.gif" alt="<%=bean.getLabel("ms-payviades")%>" width="62" height="31" border="0">&nbsp;&nbsp;</td>
 </tr>
</form>
<SCRIPT>onServiceFormLoad(document.form_services, '<%=sUnitPrices%>');</SCRIPT>
</table>
<!--tr>
 <td>
<FORM name="check" action="index.jsp" method="post" onClick1="return validatePayCheck(document.orderconfirm, document.check, 'msInfo.Price);">
<input type="hidden" name="preorderno" value="<%=Utilities.getUniqueId(16)%>">
<input type="hidden" name="custom" value="">
<input type="hidden" name="action1" value="">
  <table width="100%" align="right" border=0>
  <TR vAlign="middle">
   <TD width="73%"><img src="/staticfile/web/images/tp06.gif" align="CENTER"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">
   Pay by check or money order -- Please mail it together with your print-out order form.
   </font>
   </TD>
    <TD width="27%" align="right"><input type="submit" value="Purchase by Check" name="orderbycheck" onClick="setAction(document.check, 'Order By Check');" style="WIDTH:138px;HEIGHT:25px"></TD>
  </TR>
  </table>
</FORM>
 </td>
</tr-->
</TD>
</TR>
</TABLE>
<% } %>