<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.ShopCartWeb"%>
<%@ page import="com.zyzit.weboffice.model.ShopCartInfo"%>
<%
  ShopCartWeb shopcart = new ShopCartWeb(session, request, 100);
//shopcart.showAllParameters(request, out);
  List ltShopCart = shopcart.getShopCartList(request, response);
%>
<FORM name="shopcart" action="index.jsp" method="post">
<!--INPUT type="hidden" value="shopcartid" name="shopcart.getShopcartId(request)"-->
  <TABLE width="98%" align="center" border=0>
    <TBODY>
    <TR>
      <TD colSpan=5><FONT color=#0000cc>Your shopping cart (Purchasing Activity
        Summary):</FONT></TD>
    </TR>
    <TR vAlign="middle" bgColor="#4279bd">
      <TD width="56%" height=20 align="center"><FONT color="#ffffff">Item</FONT></TD>
      <TD width="10%" height=20 align="center"><FONT color="#ffffff">Quantity</FONT></TD>
      <TD width="8%" height=20 align="center"><FONT color="#ffffff">Delete</FONT></TD>
      <TD width="13%" height=20 align="center"><FONT color="#ffffff">Unit Price</FONT></TD>
      <TD width="13%" height=20 align="center"><font color="#ffffff">Total Price</font></TD>
    </TR>
    <% if (ltShopCart==null||ltShopCart.size()==0) {%>
    <TR>
      <TD colSpan=5 align="center"><font face="arial" color="red" size="3">This
        website is for test purposes only and will be deleted in no more than
        30 days. Please DO NOT try to buy from this website unless you are testing
        this site. Orders placed on this site is for test purposes only and will
        NOT be shipped under any circumstances. </font></TD>
    </TR>
    <% } else {
   for (int i=0; i<ltShopCart.size(); i++) {
     ShopCartInfo scInfo = (ShopCartInfo) ltShopCart.get(i);
//     shopcart.addSubTotal(scInfo);
%>
    <% } %>
    <% } %>
    <TR vAlign=center>
      <TD align=middle colSpan=5 height=22>

        <table cellspacing=0 cellpadding=0 width="100%" border=0 height="264">
          <tbody>
          <tr>
            <td align=middle colspan=2><font face=arial size=2><b>Logon to check
              out or create a new account if you don't have one.</b></font></td>
          </tr>
          <tr>
            <td width="40%"><br>
            </td>
          </tr>
          <tr>
            <td align=middle width="40%" height="32">
              <div align="right"><font face=arial size=2><b>Enter Your eMail Address:</b></font></div>
            </td>
            <td valign=bottom align=middle width="60%" height="32"><font face=arial size=2><b>
              <input maxlength=50 size=22  name=email>
              </b></font></td>
          </tr>
          <tr>
            <td align=middle width="40%">
              <div align="right"><font face=arial size=2><b>Enter Your Password:</b></font></div>
            </td>
            <td valign=top align=middle width="60%">
              <input type=password maxlength=25 size=22 name=password>
            </td>
          </tr>
          <tr>
            <td align=middle width="40%">
              <div align="right"><font face=arial size=2></font> </div>
            </td>
            <td valign=top align=middle width="60%">&nbsp; </td>
          </tr>
          <tr>
            <td colspan=2 height="18">&nbsp;</td>
          </tr>
          <tr>
            <td align=middle colspan=2>
              <input type=submit value=Logon name="submit">
            </td>
          </tr>
          <tr>
            <td colspan=2 height="20"><br>
            </td>
          </tr>
          <tr>
            <td align=middle colspan=2><font face=arial size=3><a
            href="https://secure.box88.com/.sc/ms/demo3.aacart.com/co3/1119627733203059/0/nc/ee/new"><b>Create
              A New Account</b></a><br>
              <br>
              <a
            href="https://secure.box88.com/.sc/ms/demo3.aacart.com/pfp/1119627733203059/0/nc/ee">Forgot
              Your Password?</a></font></td>
          </tr>
          </tbody>
        </table>
      </TD>
    </TR>
    <TR vAlign="middle">
      <TD colSpan=5 height=25><IMG src="images/tp06.gif" align="CENTER"></TD>
    </TR>
    </TBODY>
  </TABLE>
</FORM>