<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.database.Relationship"%>
<%@ page import="com.zyzit.weboffice.database.Membership"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.model.MembershipInfo"%>
<%@ page import="com.zyzit.weboffice.model.RelationshipInfo"%>
<%@ page import="com.zyzit.weboffice.database.Membership"%>
<%@ page import="com.zyzit.weboffice.bean.RelationshipBean"%>
<%@ page import="com.zyzit.weboffice.servlet.PaypalCallback" %>
<%
{
    RelationshipBean rsBean = RelationshipBean.getObject(session);

    MemberInfo info = null;
    if (sRealAction.startsWith("Sign Up"))
    {//. After sign up
        info = (MemberInfo) ret.getUpdateInfo();
        if (ret.isSuccess())
        {
            info = (MemberInfo) ret.getUpdateInfo();

            sDisplayMessage = rsBean.getLabel("ms-congrate") + " " + mbInfo.getPersonalName() + ", " + rsBean.getLabel("ms-signed");
//            sbMessage.append("And you can visit all the websites in this big family and enjoin the user-level service in the different sites.");
        }
/*
        else
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
*/
    }
    else if (sRealAction.startsWith("SubmitAccept"))
    {//. Accept member ship
        if (ret.isSuccess())
        {
            sDisplayMessage = rsBean.getLabel("ms-congrate") + " " + mbInfo.getPersonalName() + ", " + rsBean.getLabel("ms-accept");
        }
        else
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
    }
    else if (sRealAction.startsWith("SubmitApply"))
    {//. Apply member ship
        if (ret.isSuccess())
        {
            sDisplayMessage = rsBean.getLabel("ms-apply");//"Your have successfully apply the membership. After the owner apprive it, you will become one of members in this site.";
        }
        else
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
    }
    else if (sRealAction.startsWith("SubmitQuit"))
    {//. Apply member ship
        if (ret.isSuccess())
        {
            sDisplayMessage = rsBean.getLabel("ms-quit");//Your have successfully quit the membership. But you can join its membership again any time.";
        }
        else
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
    }
    else if (sRealAction.startsWith("SubmitBuy"))
    {//. Buy th member ship
       String sType = request.getParameter("type");
       if ("return".equalsIgnoreCase(sType))
       {//. Finish payment
         String sInvoice = request.getParameter("invoice");

       }
       else // if ("cancel".equalsIgnoreCase(sType)
       { //. You cancel payment
           sDisplayMessage = rsBean.getLabel("ms-notpay");//"Your did not finish payment. But you can implement it in anytime. Thanks.";
       }
    }

    if (info==null)
       info = mbInfo;

//Utilities.dumpObject(rsInfo);
    String sMessageTitle = rsBean.getLabel("ms-mshipstatus");//"Membership Status";
    String sSubTitle = "";
    StringBuffer sbMessage = new StringBuffer("<UL>\n");

    RelationshipInfo rsInfo = rsBean.getRelationship(mbInfo.MemberID);
    int nApplyType = 0;
    if (rsInfo!=null && rsInfo.Type<Relationship.MEMBERTYPE_APPLYWAITAPPROVE)
    {
        sbMessage.append("<LI>" + rsBean.getLabel("ms-bemember") + "</LI><br>");

        sbMessage.append("<LI>" + rsBean.getLabel("ms-quitmship")  + "</LI>");
        nApplyType = 3;

        sSubTitle = "( " + rsBean.getLabel("ms-membersince") + " " + rsInfo.CreateDate.substring(0, 10);
        if (rsInfo.ExpiredDate!=null && rsInfo.ExpiredDate.length()>=10)
           sSubTitle += ", " + rsBean.getLabel("ms-mshipexpired") + " " + rsInfo.ExpiredDate.substring(0, 10);
        sSubTitle += " )";
    }
    else
    {
      if (rsInfo!=null && rsInfo.Type==Relationship.MEMBERTYPE_APPLYWAITAPPROVE)
      {
        sSubTitle = "( " + rsBean.getLabel("ms-pendapply") + " " + rsInfo.CreateDate.substring(0, 10);
        sSubTitle += " )";

        sbMessage.append("<LI>" + rsBean.getLabel("ms-applied") + "</LI><br>");
        sbMessage.append("<LI>" + rsBean.getLabel("ms-afterapprove") + "</LI>");
        nApplyType = 2;
      }
      else if (rsInfo!=null && rsInfo.Type==Relationship.MEMBERTYPE_INVITEWAITACCEPT)
      {
        sSubTitle = "( " + rsBean.getLabel("ms-pendinvited") + " " + rsInfo.CreateDate.substring(0, 10);
        sSubTitle += " )";

        sbMessage.append("<LI>" + rsBean.getLabel("ms-invited") +"</LI><br>");
        sbMessage.append("<LI>" + rsBean.getLabel("ms-acceptmship") + "</LI>");
        nApplyType = 1;    //. Accept invite
      }
/*
      else if (rsInfo!=null && rsInfo.Type==Relationship.MEMBERTYPE_APPLYWAITPAY)
      {
        sSubTitle = "( Pending, applied on " + rsInfo.CreateDate.substring(0, 10);
        sSubTitle += " )";

        sbMessage.append("<LI>In order to become the member of this website, you have to finish payment process.</LI>");
        sbMessage.append("<LI>You just click one of payment buttons and follow its simple steps to make payment.</LI>");
        nApplyType = 4;   //Create PayPal form
      }
 */
      else
      {
        MembershipInfo msInfo = mcBean.getSiteMembershipInfo();
        if (msInfo.JoinType==Membership.JOINTYPE_NEEDTOBUYSERVICE)
        {
          sbMessage.append("<LI>" + rsBean.getLabel("ms-needpay") + "</LI><br>");
          sbMessage.append("<LI>" + rsBean.getLabel("ms-afterbecome") + "</LI>");
          nApplyType = 4;   //Create PayPal form
        }
        else if (msInfo.JoinType==Membership.JOINTYPE_FREEWITHAPPROVE)
        {
          sbMessage.append("<LI>" + rsBean.getLabel("ms-acceptmship") + "</LI><br>");
          sbMessage.append("<LI>" + rsBean.getLabel("ms-afterapprove") + "</LI>");
          nApplyType = 2;
        }
        else// if (msInfo.JoinType!=Membership.JOINTYPE_FREEWITHAPPROVE)
        {
          sbMessage.append("<LI>" + rsBean.getLabel("ms-tobemship") + "</LI><br>");
          sbMessage.append("<LI>" + rsBean.getLabel("ms-automember") + "</LI>");
          nApplyType = 2;
        }
//System.out.println("Member Type2: " + nApplyType + ", " +  msInfo.JoinType);
      }
    }

    String sSubjectNote = rsBean.getLabel("ms-applymship");//mcBean.getTemplateSubject("Apply-Membership");
    StringBuffer sbContent = new StringBuffer("<ul><br>");
    sbContent.append("<li>" + rsBean.getLabel("ms-communicate") +  "</li><br>");
    sbContent.append("<li>" + rsBean.getLabel("ms-viewdownload") + "</li><br>");
    sbContent.append("<li>" + rsBean.getLabel("ms-notify") + "</li></ul>");
    String sContentNote = sbContent.toString();//mcBean.getTemplateContent("Apply-Membership");
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<table class="table-outline" width="100%" align="center">
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
  <TD >
  <table width="100%" align="center" border="0" cellpadding="4" cellspacing="2"  style="border: 1px solid #DFDFDF; background-color:#EFF7FE">
   <tr>
    <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif"><span style="font-size:16px;"><strong><%=sMessageTitle%></strong></span>
        <br><span style="font-size:13px;"><strong><%=sSubTitle%></strong></span></font>
    </td>
   </tr>
   <tr>
    <td><b><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color='#DD6900'><%=sbMessage.toString()%></font></b>
   </td>
   </tr>
   <tr>
    <td height="1" valign="bottom"></td>
   </tr>
  </table>
 </TD>
</TR>
    
<% if (nApplyType>0) { %>
<tr>
 <td height="10"></td>
</tr>

<tr>
 <td>
<% if (nApplyType==1) { %>
<FORM name="form_accept" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post">
<input type="hidden" name="pt" value="Accept the Membership of This Site">
<input type="hidden" name="rl" value="1">
<input type="hidden" name="memberid" value="<%=info.MemberID%>">
<input type="hidden" name="action1" value="SubmitAccept_SiteMember">
<table align="center">
<tr>
 <td align="center">
  <input type="submit" name="submit" style='width:180px' value="Accept Membership">
  </td>
</tr>
 </table>
 </FORM>
<% } else if (nApplyType==2) {%>
<FORM name="form_apply" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post">
<input type="hidden" name="pt" value="Apply the Membership of This Site">
<input type="hidden" name="rl" value="1">
<input type="hidden" name="action1" value="SubmitApply_SiteMember">
<table align="center">
<tr>
<td align="center">
<input type="submit" name="submit" style='width:180px' value="Apply Membership">
</td>
</tr>
</table>
</FORM>
<% } else if (nApplyType==3) {%>
<FORM name="form_quit" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post">
<input type="hidden" name="pt" value="Quit the Membership of This Site">
<input type="hidden" name="rl" value="1">
<input type="hidden" name="action1" value="SubmitQuit_SiteMember">
<table align="center">
<tr>
<td align="center">
<input type="submit" name="submit" style='width:180px' value="<%=rsBean.getLabel("ms-quitmship")%>" onClick="return confirm('<%=rsBean.getLabel("ms-surequit")%>');">
</td>
</tr>
</table>
</FORM>
<% } else {
    MembershipInfo msInfo = mcBean.getSiteMembershipInfo();
    String sCustom  = mcBean.getDomainName() + ",";
           sCustom += "Membership" + ",";
           sCustom += mcBean.getSiteOwnerInfo().MemberID + ",";
           sCustom += info.MemberID;
%>
 <FORM name="form_paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post" onSubmit1="return validatePayPal(this);">
 <input type="hidden" name="charset" value="utf8">
 <input type="hidden" name="cmd" value="_ext-enter">
 <input type="hidden" name="redirect_cmd" value="_xclick">
 <input type="hidden" name="first_name" value="<%=info.FirstName%>">
 <input type="hidden" name="last_name" value="<%=info.LastName%>">
 <input type="hidden" name="address1" value="<%=Utilities.getValue(info.Address1)%>">
 <input type="hidden" name="city" value="<%=Utilities.getValue(info.City)%>">
 <input type="hidden" name="state" value="<%=Utilities.getValue(info.State)%>">
 <input type="hidden" name="zip" value="<%=Utilities.getValue(info.Zip)%>">
 <input type="hidden" name="country" value="<%=Utilities.getValue(info.Country)%>">
 <input type="hidden" name="business" value="<%=msInfo.Account%>">
 <input type="hidden" name="item_name" value="The Membership Service">
 <input type="hidden" name="item_number" value="Terms of <%=rsBean.getTermsName(msInfo)%>">
 <!--input type="hidden" name="quantity" value="1"-->
 <input type="hidden" name="amount" value="<%=Utilities.getNumberFormat(msInfo.Price, 'd', 2)%>">
 <!--input type="hidden" name="tax" value="0.0"-->
 <!--input type="hidden" name="shipping" value="0.0"-->
 <input type="hidden" name="invoice" value="<%=Utilities.getUniqueId(10)%>">
 <input type="hidden" name="custom" value="<%=sCustom%>">
 <input type="hidden" name="rm" value="2">
 <input type="hidden" name="no_note" value="1">
 <input type="hidden" name="no_shipping" value="1">
 <input type="hidden" name="notify_url" value='<%=PaypalCallback.getCallbackUrl(mcBean.getDomainName(), "notify")%>'>
 <!--input type="hidden" name="return" value='<%=PaypalCallback.getCallbackUrl(mcBean.getDomainName(), "return")%>'-->
 <input type="hidden" name="return" value='<%=PaypalCallback.getReturnUrl(mcBean.getDomainName(), "SubmitBuy_SiteMember")%>'>
 <input type="hidden" name="cancel_return" value='<%=PaypalCallback.getCancelUrl(mcBean.getDomainName(), "SubmitBuy_SiteMember")%>'>
 <table width="80%" align="center" border="0" cellspacing="4" cellpadding="2">
<% if (msInfo.Terms!=Membership.TERMS_PERPETUAL) { %>
 <tr>
  <td width="50%"><font size='2'><b><%=rsBean.getLabel("ms-howmany")%>:</b></font></td>
  <td align="left">
  <select name="quantity" onChange="onTermChnage('id_totalcharge', this.value, <%=msInfo.Price%>)">
   <option value=1 SELECTED>1</option>
   <option value=2>2</option>
   <option value=3>3</option>
   <option value=4>4</option>
   <option value=5>5</option>
   <option value=6>6</option>
   <option value=7>7</option>
   <option value=8>8</option>
   <option value=9>9</option>
   <option value=10>10</option>
   <option value=11>11</option>
   <option value=12>12</option>
  </select>&nbsp;&nbsp;<b><%=rsBean.getTermsName(msInfo)%></b>
  </td>
 </tr>
<% } else { %>
 <input type="hidden" name="quantity" value="1">     
<% } %>
 <tr>
  <td width="50%"><font size='2'><b><%=rsBean.getLabel("ms-totalcharge")%>:</b></font></td>
  <td align="left" id='id_totalcharge'><font color="red"><b>$<%=Utilities.getNumberFormat(msInfo.Price, 'd', 2)%></b></font></td>
 </tr>
 <tr>
  <td colspan="2"><hr class="line"></td>
 </tr>
 <tr>
   <td width="50%">
    <font size='2'><b><%=rsBean.getLabel("ms-paybycc")%></b></font>
   </td>
  <td  align="right"><input type="image" name="submit" src="/staticfile/web/images/paypal_cards.gif" alt="<%=rsBean.getLabel("ms-paybyccdes")%>" border="0" ></td>
 </tr>
 <tr>
   <td width="50%">
     <font size="2"><b><%=rsBean.getLabel("ms-payvia")%></b></font>
     </td>
     <td  align="right">
     <input type="image" name="submit" src="/staticfile/web/images/x-click-but01.gif" alt="<%=rsBean.getLabel("ms-payviades")%>" width="62" height="31" border="0">
   </td>
 </tr>
</table>
</form>
<!--tr>
 <td>
<FORM name="check" action="index.jsp" method="post" onClick1="return validatePayCheck(document.orderconfirm, document.check, '<%=msInfo.Price%>');">
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
<% } %>
</td>
</tr>
<% } %>
</table>
<% } %>