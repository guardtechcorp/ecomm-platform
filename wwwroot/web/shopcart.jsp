<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.model.ShopCartInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
  ShopCartWeb shopcart = new ShopCartWeb(session, request, 100);
  ConfigInfo cfInfo = shopcart.getConfigInfo();
//shopcart.showAllParameters(request, out);
  List ltShopCart = shopcart.getShopCartList(request, response);
  String sMemberConditionPrice = "";
  if (!shopcart.isReachCondition())
  {
    sMemberConditionPrice = Utilities.getNumberFormat(shopcart.getMemberCondtionPrice(), '$', 2);
  }
%>
<FORM name="shopcart" action="<%=shopcart.getHttpLink("index.jsp")%>" method="post">
<INPUT type="hidden" name="action1" value="">
  <TABLE width="100%" align="right" cellspacing=2 cellpadding=2 border=0>
    <TR>
      <TD colSpan=5><img src="/staticfile/web/images/tp06.gif" align="CENTER"><a href="<%=shopcart.getContinueShop()%>"><%=shopcart.getLabelText(cfInfo, "shopping-link")%></a> > <font color="#FF0000"><%=shopcart.getLabelText(cfInfo, "cart-link")%></font> >
       <%=shopcart.getLogonLink(cfInfo)%> <%=shopcart.getLabelText(cfInfo, "confirm-link")%> > <%=shopcart.getLabelText(cfInfo, "finish-link")%></TD>
    </TR>
    <TR vAlign="middle" bgColor="#4279bd">
      <TD width="56%" height=20 align="center"><FONT color="#ffffff"><%=shopcart.getLabelText(cfInfo, "item-col")%></FONT></TD>
      <TD width="9%" height=20 align="center"><FONT color="#ffffff"><%=shopcart.getLabelText(cfInfo, "quantity-col")%></FONT></TD>
      <TD width="8%" height=20 align="center"><FONT color="#ffffff"><%=shopcart.getLabelText(cfInfo, "delete-col")%></FONT></TD>
      <TD width="13%" height=20 align="center"><FONT color="#ffffff"><%=shopcart.getLabelText(cfInfo, "price-col")%></FONT></TD>
      <TD width="14%" height=20 align="center"><font color="#ffffff"><%=shopcart.getLabelText(cfInfo, "total-col")%></font></TD>
    </TR>
<% if (ltShopCart==null||ltShopCart.size()==0) {%>
    <TR>
      <TD colSpan=5 align="center"><IMG src="/staticfile/web/images/<%=cfInfo.Language%>/cart-empty.gif"></TD>
    </TR>
    <TR vAlign="middle">
     <TD colSpan=5 align="center">
      <script>createLeftButton();</script>
      <a class="button" href="<%=shopcart.getContinueShop()%>"><%=shopcart.getLabelText(cfInfo, "continueshop-link")%></a>
      <script>createRightButton();</script>
     </TD>
    </TR>
<% } else {
   for (int i=0; i<ltShopCart.size(); i++) {
     ShopCartInfo scInfo = (ShopCartInfo) ltShopCart.get(i);
%>
    <TR vAlign="middle" bgColor="#f7f7f7">
      <TD width="56%"><A  href="<%=shopcart.encodedUrl("index.jsp?action=productdetail&productid=" + scInfo.ProductID + "&name=" + scInfo.Name)%>"><%=scInfo.Name%></a></TD>
      <TD width="9%" align="center">
        <INPUT type="text" maxLength=5 size=4 value="<%=scInfo.Quantity%>" name="qty_<%=scInfo.ProductID%>">
      </TD>
      <TD width="8%" align="center">
        <INPUT onfocus="this.blur()" type="checkbox" value="1" name="check_<%=scInfo.ProductID%>">
      </TD>
      <TD width="13%" nowrap align="right"><%=shopcart.getUnitPrice(scInfo)%></TD>
      <TD width="14%" align="right"><%=Utilities.getNumberFormat(shopcart.getPrice(scInfo)*scInfo.Quantity,'$',2)%></TD>
    </TR>
<% } %>
    <TR vAlign="middle" bgColor="#f7f7f7">
      <TD height=46 colspan="3" rowspan="<%=(shopcart.hasDiscount()&&!shopcart.isMember())?5:4%>">
        <table width="100%" border="0">
          <tr>
            <td colspan=2><font color="#CC6600"><%=shopcart.getShippingNote()%></font></td>
          </tr>
          <tr>
            <td width="68%" align="right">
             <%=shopcart.getLabelText(cfInfo, shopcart.getShipOption()==1?"zip-des":"zipship-des")%>
            </td>
            <td width="32%">
             <input type="text" name="zipcode" size="6" maxlength="10" value="<%=shopcart.getSavedZipcode()%>" onKeyUp="validateDigits(this, 5);" onBlur="if(this.value.length<5){this.value='';}">
            </td>
          </tr>
<% if (shopcart.supportCoupon()&&!shopcart.isMember()){ %>
          <tr>
            <td width="68%" align="right"><%=shopcart.getLabelText(cfInfo, "coupon-des")%></td>
            <td width="32%"><input type="text" name="coupon" size="16" maxlength="20" value="<%=shopcart.getPrevCoupon()%>"></td>
          </tr>
<% } %>
<% if (shopcart.getShipOption()==1){ %>
          <tr>
            <td width="68%" align="right"><%=shopcart.getLabelText(cfInfo, "ship-des")%></td>
            <td width="32%">
              <select name="shipmethod">
                <%=shopcart.getShipMethodList(request)%>
              </select>
            </td>
          </tr>
<% } %>
          <tr>
            <td colspan="2"><%=shopcart.getLabelText(cfInfo, "clear-des")%></td>
          </tr>
        </table>
      </TD>
      <TD width="15%" align="right" height="10"><%=shopcart.getLabelText(cfInfo, "subtotal-col")%></TD>
      <TD width="15%" align="right" height="10"><%=Utilities.getNumberFormat(shopcart.getSummary(1),'$',2)%></TD>
    </TR>
<% if (shopcart.hasDiscount()&&!shopcart.isMember()) {%>
    <TR vAlign="middle" bgColor="#f7f7f7">
      <TD width="15%" align="right" height="10"><%=shopcart.getLabelText(cfInfo, "discount-col")%></TD>
      <TD width="15%" align="right" height="10">-<%=Utilities.getNumberFormat(shopcart.getSummary(5),'$',2)%></TD>
    </TR>
<% } %>
    <TR vAlign="middle" bgColor="#f7f7f7">
      <TD width="15%" align="right" height="10"><%=shopcart.getLabelText(cfInfo, "tax-col")%></TD>
      <TD width="15%" align="right" height="10"><%=Utilities.getNumberFormat(shopcart.getSummary(2),'$',2)%></TD>
    </TR>
    <TR vAlign="middle" bgColor="#f7f7f7">
      <TD width="15%" align="right" height="10"><%=shopcart.getLabelText(cfInfo, "ship-col")%></TD>
      <TD width="15%" align="right" height="10"><%=Utilities.getNumberFormat(shopcart.getSummary(3),'$',2)%></TD>
    </TR>
    <TR vAlign="middle" bgColor="#f7f7f7">
      <TD width="15%" align="right" height="10"><%=shopcart.getLabelText(cfInfo, "grant-col")%></TD>
      <TD width="15%" align="right" height="10"><b><%=Utilities.getNumberFormat(shopcart.getSummary(4),'$',2)%></b></TD>
    </TR>
    <TR vAlign="middle" bgColor="#f7f7f7">
     <TD colspan="3" align="center"  height="20">&nbsp;
     <input type="submit" value="<%=shopcart.getLabelText(cfInfo, "updatecart-but")%>" name="updatecart" onClick="setAction(document.shopcart, 'Update Cart');">&nbsp;
     <input type="submit" value="<%=shopcart.getLabelText(cfInfo, "clearcart-but")%>" name="clearcart" onClick="setAction(document.shopcart, 'Clear Cart');return confirm('Are you sure you want to clear your shopping cart?');">&nbsp;
     <!--input type="submit" value="<%=shopcart.getLabelText(cfInfo, "checkout-but")%>" name="checkout" onClick="setAction(document.shopcart, 'Check Out');"-->
     <input type="submit" value="<%=shopcart.getLabelText(cfInfo, "checkout-but")%>" name="checkout" onClick="return validateCheckOut(document.shopcart, 'Check Out', '<%=sMemberConditionPrice%>');">
     </TD>
     <TD colSpan=2 align="center" height="20">
      <script>createLeftButton();</script>
      <a class="button" href="<%=shopcart.getContinueShop()%>"><%=shopcart.getLabelText(cfInfo, "continueshop-link")%></a>
      <script>createRightButton();</script>
     </TD>
    </TR>
    <TR vAlign="middle">
      <TD colSpan=5 height=10></TD>
    </TR>
    <TR vAlign="middle">
      <TD colSpan=5 height=25><IMG src="/staticfile/web/images/tp06.gif" align="CENTER"> <%=shopcart.getLabelText(cfInfo, "shop-des1")%></TD>
    </TR>
    <TR vAlign="middle">
      <TD colSpan=5 height=25><IMG src="/staticfile/web/images/tp06.gif" align="CENTER"> <%=shopcart.getLabelText(cfInfo, "shop-des2")%></TD>
    </TR>
    <TR vAlign="middle">
      <TD colSpan=5 height=25><IMG src="/staticfile/web/images/tp06.gif" align="CENTER"> <%=shopcart.getLabelText(cfInfo, "shop-des3")%></TD>
    </TR>
    <TR vAlign="middle">
      <TD colSpan=5 height=25><IMG src="/staticfile/web/images/tp06.gif" align="CENTER"> <%=shopcart.getLabelText(cfInfo, "shop-des4")%></TD>
    </TR>
<% } %>
  </TABLE>
</FORM>
<SCRIPT>writeDataOnId("totalshopitems", "<%=shopcart.getTotalItems(request, response)%>");</SCRIPT>
<% } %>