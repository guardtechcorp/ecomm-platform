<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.model.OrderInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.bean.OrderBean"%>
<%@ page import="com.zyzit.weboffice.model.OrderItemInfo"%>
<%
  HttpSession parentSession = ShopCartWeb.getHttpSession(request.getParameter("domainname"), request.getParameter("sid"));
  ShopCartWeb web = new ShopCartWeb(parentSession, request, 10);

    String preorderno  = request.getParameter("preorderno");
    OrderInfo orInfo;
    List ltShopItems;

    if (Utilities.getValueLength(preorderno)>0)
    {
        orInfo = web.getOrderInfo(preorderno);
        ltShopItems = web.getOrderItem(preorderno);
    }
    else
    {
        orInfo = web.getOrderInfo();
        ltShopItems = web.getOrderItem();
    }

//  OrderInfo orInfo = web.getOrderInfo();
//  List ltShopItems = web.getOrderItem();
%>
Hi, <%=orInfo.Yourname%>:

This email is to confirm the receipt of your recent order from <%=web.getDomainName()%>.

Date:  <%=Utilities.getDateValue(orInfo.CreateDate, 16)%>
Ship to:
<% if (orInfo.Ship_Address!=null && orInfo.Ship_Address.trim().length()>0) {%>
        <%=orInfo.Ship_Yourname%>
        <%=orInfo.Ship_Address%>
        <%=orInfo.Ship_City+", "+orInfo.Ship_State+" "+orInfo.Ship_ZipCode+", " + orInfo.Ship_Country%>

Bill to:
        <%=orInfo.Yourname%>
<% } else { %>
        <%=orInfo.Yourname%>
        <%=orInfo.Address%>
        <%=orInfo.City+", "+orInfo.State+" "+orInfo.ZipCode+", "+orInfo.Country%>

Bill to: Same
<% } %>
E-Mail:   <%=orInfo.EMail%>
<%=web.getPaymentDesc(orInfo, true)%>

Product                             Code        Quantity   Unit Price   Total Price
-----------------------------------------------------------------------------------
<% for (int i=0; i<ltShopItems.size(); i++) {
  OrderItemInfo oiInfo = (OrderItemInfo)ltShopItems.get(i);
%>
<%=Utilities.getFixedLengthValue(oiInfo.Name, 32, 1)%>  <%=Utilities.getFixedLengthValue(oiInfo.Code, 12, 0)%>  <%=Utilities.getFixedLengthValue(""+oiInfo.Quantity, 8, 0)%>  <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(oiInfo.Price,'$',2), 12, -1)%>  <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(oiInfo.Quantity*oiInfo.Price,'$',2), 12, -1)%>
-----------------------------------------------------------------------------------
<% } %>
                                                        Subtotal:    <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(orInfo.SubTotal,'$',2), 12, -1)%>
<% if (orInfo.Discount>0) { %>
                                                        Discount:   -<%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(orInfo.Discount,'$',2), 12, -1)%>
<% } %>
                                                        Tax:         <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(orInfo.Tax,'$',2), 12, -1)%>
                                                        Shipping:    <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(orInfo.ShipFee,'$',2), 12, -1)%>
                                                        Grand Total: <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(orInfo.GrandTotal,'$',2), 12, -1)%>
-----------------------------------------------------------------------------------
<% if ("play.atozmate.com".equalsIgnoreCase(web.getDomainName())) { %>
We normally dispatch within 1 week of orders being received but occasionally we may have a period of high demand. When that happens, we do ask that you allow up to 2 weeks for delivery. We thank you for your understandings and apologize for any inconvenience.
<% } %>
<% if ("www.hepahealth.com".equalsIgnoreCase(web.getDomainName())||"www.test101.wlmg.net".equalsIgnoreCase(web.getDomainName())) {
  if (orInfo.Comment!=null)
  {
     String sComment = Utilities.replaceContent(orInfo.Comment, "<b>", "");
     sComment = Utilities.replaceContent(sComment, "</b>", "");
     String[] arComment = sComment.split("<br>");
     for (int j=0; j<arComment.length; j++) {
%>
<%=arComment[j]%>
<% }}} %>
<%=web.getOnlineProducts(orInfo, true)%>

If you have questions about the shipping and tracking of your purchased item or service, please contact us at sales@<%=web.getEmailDomain()%>.

Thank you again for ordering our products.