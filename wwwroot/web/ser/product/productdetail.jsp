<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo" %>
<%@ page import="com.zyzit.weboffice.bean.ContactUsBean"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.web.MemberProductWeb"%>
<%
{
    MemberProductWeb mpWeb = MemberProductWeb.getObject(session);

    int nProductId = Utilities.getInt(request.getParameter("productid"), 0);
    ProductInfo pdInfo = mpWeb.getProduct(nProductId);
    String sSeeContactLink;
    String sPayPalAccount = null;
    String sOrderLogin = null;
    if (mbInfo!=null)
    {
       sSeeContactLink = "<a class='hightlight' onClick=\"showContactSection(document.form_message, 'open', 'contact_section');\" href='javascript:;'><font size='2' color='#ff9933'>See Contact Information</font></a>";
//       sOrderButton = product.getOrderButton(cfInfo, pdInfo);
       sPayPalAccount = mpWeb.getPayPalAccount(pdInfo);
    }
    else
    {
       sSeeContactLink = "<a class='hightlight' href='" + mpWeb.encodedUrl("index.jsp?action=Load_SignIn") + "'><font size='2' color='#ff9933'>See Contact Information</font></a>";
       sOrderLogin = "";//"<img src='/staticfile/web/images/arrow.gif' align='absMiddle'><a class='hightlight' href='" + mpWeb.encodedUrl("index.jsp?action=Load_SignIn") + "'><font size='2' color='#ff9933'>Login to Buy</font></a>";
    }

    sPageTitle = "Product Details";
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/productsearch.js" type="text/javascript"></SCRIPT>
<TABLE cellSpacing=2 cellPadding=10 width="100%">
 <TR>
  <TD vAlign="middle" align="center" width="210"><%=mpWeb.getProductPicture(pdInfo, 2, 200, 200)%>
 <% if (pdInfo.LargeImageID>0){ %>
     <br><IMG src="/staticfile/web/images/xt2.gif">&nbsp;<%=mpWeb.getFullSizePhotoLink(pdInfo.LargeImageID, "Click for Full-Size Photo")%>
 <% } %>
  </TD>
  <TD vAlign="top">
  <TABLE cellSpacing=0 cellPadding=1 width="100%">
   <TR>
    <TD width="20%">Product Name:</TD>
    <TD><font color='#000000' size='2'><b><%=pdInfo.Name%></b></font></TD>
   </TR>
   <TR>
     <TD width="20%">Product Code:</TD>
     <TD><font color='#000000' size='2'><b><%=pdInfo.Code%></b></font></TD>
   </TR>
   <TR>
     <TD width="20%">Product Price:</TD>
     <TD><font color='red' size='2'><b><%=Utilities.getNumberFormat(pdInfo.Price, '$', 2)%></b></font></TD>
   </TR>
   <TR>
     <TD colspan="2" width="100%">
      <TABLE width="100%">
       <TR>
        <TD width="20%" height="110"></TD>
        <TD width="30%" valign="bottom">
<% if (sPayPalAccount!=null) { %>
              <form name="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" onSubmit="return validatePayPal(document.orderconfirm, document.paypal, '');">
              <input type="hidden" name="charset" value="utf8">
              <input type="hidden" name="cmd" value="_ext-enter">
              <input type="hidden" name="redirect_cmd" value="_xclick">
              <input type="hidden" name="first_name" value="<%=mbInfo.FirstName%>">
              <input type="hidden" name="last_name" value="<%=mbInfo.LastName%>">
              <input type="hidden" name="address1" value="<%=Utilities.getValue(mbInfo.Address1)%>">
              <input type="hidden" name="city" value="<%=Utilities.getValue(mbInfo.City)%>">
              <input type="hidden" name="state" value="<%=Utilities.getValue(mbInfo.State)%>">
              <input type="hidden" name="zip" value="<%=Utilities.getValue(mbInfo.Zip)%>">
              <!--input type="hidden" name="country" value="ctInfo.Country"-->
              <input type="hidden" name="business" value="<%=sPayPalAccount%>">
              <input type="hidden" name="item_name" value="The Shopping Item(s)">
              <input type="hidden" name="item_number" value="1">
              <!--input type="hidden" name="quantity" value="1"-->
              <input type="hidden" name="amount" value="<%=Utilities.getNumberFormat(pdInfo.Price, 'd', 2)%>">
              <!--input type="hidden" name="tax" value="shopcart.getSummary(2)"-->
              <!--input type="hidden" name="shipping" value=" shopcart.getSummary(3)"-->
              <input type="hidden" name="invoice" value="<%=Utilities.getUniqueId(10)%>">
              <input type="hidden" name="custom" value="<%="memberid:"+mbInfo.MemberID%>">
              <input type="hidden" name="rm" value="2">
              <input type="hidden" name="no_note" value="1">
              <input type="hidden" name="no_shipping" value="1">
              <input type="hidden" name="notify_url" value="shopcart.getCallbackUrl(paypalnotify" >
              <input type="hidden" name="return" value="shopcart.getCallbackUrl(paypalreturn" >
              <input type="hidden" name="cancel_return" value="shopcart.getCallbackUrl(paypalcancel" >
              <input type="image" name="submit" src="/staticfile/web/images/x-click-but01.gif" alt="It is easy to buy" border="0">
             </form>
<% } else { %>
         <%=sOrderLogin%>
<% } %>
        </TD>
        <TD align="right" valign="bottom">
        <SPAN id="open_contact_section" style="display:inline">
         <img src='/staticfile/web/images/arrow.gif' align='absMiddle'><%=sSeeContactLink%>
        </SPAN>
        <SPAN id="close_contact_section" style="display:none">
        <img src='/staticfile/web/images/arrowdown.gif' align='absMiddle'><a class='hightlight' onClick="showContactSection(document.form_message, 'close', 'contact_section');" href='javascript:;'><font size='2' color='#ff9933'>Hide Contact Information</font></a>
        </SPAN>
   <!--
    <SCRIPT>createLeftButton();</SCRIPT>
    <A class="button" onClick="showContactSection(document.email_form, 'open', 'email_section');" href="javascript:;">See Contact Information</A>
    <SCRIPT>createRightButton();</SCRIPT>
    -->
       &nbsp;
       </TD>
      </TR>
     </TABLE>
    </TD>
   </TR>
  </TABLE>
 </TD>
</TR>
<% if (mbInfo!=null) { %>
<TR>
 <TD colspan=2>
<%
    ContactUsBean web = new ContactUsBean(session, 10, true);
    CompanyInfo info = web.getContactInfo(pdInfo.MemberID);
%>
  <SPAN id="contact_section" style="display:none">
  <table width="99%" align="center" border="0" cellpadding="2" cellspacing="0"  style="border: 1px solid #DFDFDF; background-color:#EFF7FE">
   <tr>
    <td>
      <table width="100%">
       <tr>
        <td width=30 align="center" valign="top"><img src="/staticfile/web/images/info.gif" height=14 width=14></td>
        <td width="55%" align="left">
         <font size="2" face="Verdana, Arial, Helvetica, sans-serif" color1='green' color="#FF6633">
          <b>Company Address:</b><br>
          <%=Utilities.getValue(info.CompanyName)%><br>
          <%=Utilities.getValue(info.Address)%><br>
          <%=Utilities.getValue(info.City)%>, <%=Utilities.getValue(info.State)%> <%=Utilities.getValue(info.ZipCode)%><br>
         </font>
        </td>
        <td align="left">
         <font size="2" face="Verdana, Arial, Helvetica, sans-serif" color1='green' color="#FF6633">
          <b>Contact Information:</b><br>
          Phone Number: <%=Utilities.getValue(info.Phone)%>
          <%if (info.Fax!=null&&info.Fax.length()>0){%>
          <br>Fax Number: <%=Utilities.getValue(info.Fax)%>
          <%}%>
          <br>E-Mail: <%=Utilities.getValue(info.EMail)%>
         </font>
        </td>
       </tr>
      </table>
     </td>
    </tr>
  </table>
  <br>
  <form name="form_message" action="ser/ajaxresponse.jsp" method="post">
  <INPUT type="hidden" name="receiverid" value="<%=pdInfo.MemberID%>">
  <INPUT type="hidden" name="senderid" value="<%=(mbInfo!=null?mbInfo.MemberID:-1)%>">
  <INPUT type="hidden" name="productid" value="<%=pdInfo.ProductID%>">
  <INPUT type="hidden" name="action1" value="Send_Message">
  <INPUT type="hidden" name="format" value="text">
  <TABLE border=0 width="99%" align="center" class="highinfo">
  <tr>
    <td colspan=2 height="22" align="center" valign="bottom"><font size=2><b>Send a Message to the Seller</b></font></td>
  </tr>
  <tr>
   <td colspan=2 valign="top"><hr width="98%"></td>
  </tr>
  <tr>
  <td colspan="2" height="1">
   <%@ include file="../include/information.jsp"%>
  </td>
 </tr>
  <tr>
    <td align="right" width="25%">Seller's Company Name:</td>
    <td><input maxlength=255 size=87 value="<%=Utilities.getValue(info.CompanyName)%>" name="companyname"></td>
  </tr>
  <tr>
    <td align="right" width="25%">Your Name:</td>
    <td><input maxlength=50 size=87 value="<%=Utilities.getValue(mbInfo.FirstName)%>" name="yourname"></td>
  </tr>
  <!--tr>
    <td align="right" width="25%">E-Mail Address*:</td>
    <td><input maxlength=50 size=64 value="<%=Utilities.getValue("your email")%>" name="fromemail"></td>
  </tr-->
  <!--tr>
    <td align="right" width="25%"></td>
    <td><input type="checkbox" name="sendyourself" value="1">Send a copy to yourself</td>
  </tr-->
  <tr>
    <td colspan=2 height="5"></td>
  </tr>
  <tr>
    <td align="right" width="25%">Subject:</td>
    <td><input maxlength=255 size=87 value="<%=Utilities.getValue(request.getParameter("subject"))%>" name="subject"></td>
  </tr>
  <tr>
    <td align="right" width="25%" valign="top">Message:</td>
    <td> <textarea rows="8" cols="55" wrap="virtual" name="content"><%=Utilities.getValue(request.getParameter("content"))%></textarea></td>
  </tr>
  <tr>
    <td colspan=2>
     <table border="0" width="100%">
      <tr>
       <td align="center">
        <input type="button" name="submit" style='width:120px' value="Send Message" onClick="sendMessage(document.form_message, '<%=mpWeb.encodedUrl("ajaxresponse.jsp")%>');">
<!--
       <SCRIPT>createLeftButton();</SCRIPT>
       <A class="button" onClick="sendMessage(document.form_message, '<%=mpWeb.encodedUrl("ser/ajaxresponse.jsp")%>');" href="javascript:;">Send Message Now</A>
       <SCRIPT>createRightButton();</SCRIPT>
-->
       </td>
      </tr>
    </table>
   </td>
  </tr>
  <tr>
    <td colspan=2 height=5></td>
  </tr>
 </table>
</form>
</span>
</TD>
</TR>
<% } %>
<TR>
 <TD colspan=2><HR algin="left" width="100%" color="#cccccc" noShade SIZE=1></TD>
</TR>
 <TR>
  <TD colspan="2" valign="top">
 <TABLE cellSpacing=0 cellPadding=1 width="99%" height="10">
  <TR>
    <TD><font face="Verdana, Arial, Helvetica, sans-serif" size="3"><b>Description:</b></font></TD>
  </TR>
  <TR>
    <TD><br><%=mpWeb.getIntroduction(pdInfo, -1)%></TD>
  </TR>
<% if (pdInfo.ExternalUrl!=null && pdInfo.ExternalUrl.length()>0) {%>
  <TR>
    <TD><br>
      <a href="<%=pdInfo.ExternalUrl%>" target="_blank">See more details</a>
    </TD>
  </TR>
<% } %>
 </TABLE>
 </TD>
 </TR>
</TABLE>
<% } %>