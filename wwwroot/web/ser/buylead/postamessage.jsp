<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.PostMessageBean"%>
<%@ page import="com.zyzit.weboffice.model.MessageInfo"%>
<%
{
//PostMessageBean.showAllParameters(request, out);
//Utilities.dumpObject(info);
    MessageInfo info = null;
    if (sRealAction.startsWith("Submit_PostMessage"))
    {
        if (!ret.isSuccess())
        {
          info = (MessageInfo)ret.getUpdateInfo();
          sDisplayMessage = (String)ret.getInfoObject();
          nDisplay = 0;
        }
        else
          sDisplayMessage = "You successfully posted a buying lead message.";
    }

    if (info==null)
    {
       info = MessageInfo.getInstance2();
       info.SenderID = mbInfo.MemberID;
    }
        
    sPageTitle = "Post Buying Lead";
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/message.js" type="text/javascript"></SCRIPT>
 <TABLE style="background-color:#ffffff;border:#C3D9FF 1px solid;" border="0" cellpadding="5" cellspacing="3" width="100%" height1="300">
 <TR>
  <TD style="text-align: center;" bgcolor="#e8eefa" nowrap="nowrap" valign="top">
  <FORM name="form_postmessage" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validatePostMessage(this);">
  <input type="hidden" name="senderid" value="<%=mbInfo.MemberID%>">
  <input type="hidden" name="categoryids" value="">  
  <input type="hidden" name="action1" value="">
  <TABLE width="100%" align="center" border=0 cellpadding="1" cellspacing="0">
   <TR>
    <TD valign="top">
     <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
      <TR>
       <TD colspan="3">
        <table width="99%" align="center" border="0" cellpadding="5" cellspacing="3"  style="border: 1px solid #DFDFDF; background-color:#e8eefa" EFF7FE>
         <tr>
          <td>
          <table>
           <tr>
            <td width=15 valign="top"></td>
             <td align="left">
             <font face="Verdana, Arial, Helvetica, sans-serif" color1='green'>
              <span style="font-size:14px;"><strong>Posting buying leads delivers immediate benefits!</strong></span>
              <ul>
               <li>Let suppliers know what you're looking to buy.</li>
               <li>Reach all of Suppliers and Companies.</li>
               <li>Receive prompt and precise responses.</li>
              </ul>
             </font>
             </td>
           </tr>
          </table>
         </td>
         </tr>
        </table>
       </TD>
      </TR>

      <tr>
         <td colspan="3" height="5" align="center"></td>
       </tr>    
       <tr>
         <td colspan="3" height="24">&nbsp;&nbsp;<b>Baisc Information:</b> (Fields marked with an asterisk * are required)</td>
       </tr>
       <tr>
         <td height="22" width="21%" align="right">* Subject:</td>
         <td width="1%">&nbsp;</td>
         <td ><input maxlength=255 size=101 value="<%=info.Subject%>" name="subject"></td>
       </tr>
       <tr>
         <td height="22" width="21%" align="right">* Keywords:</td>
         <td width="1%">&nbsp;</td>
         <td><input maxlength=255 size=101 value="<%=info.Keywords%>" name="keywords"></td>
       </tr>
       <tr>
        <td height="22" width="21%" align="right" valign="top">* Brief Description:<br>(Limits 255 characters)</td>
        <td width="1%">&nbsp;</td>
        <td><textarea name="briefdesc" rows="2" cols="64" wrap="virtual"><%=info.BriefDesc%></textarea></td>
       </tr>
       <tr>
        <td height="22" width="21%" align="right" valign="top">Detailed Description:</td>
        <td width="1%">&nbsp;</td>
        <td><textarea name="content" rows="5" cols="64" wrap="virtual"><%=info.Content%></textarea></td>
       </tr>
       <tr>
         <td height="22" width="21%" align="right" valign="top">* Category:</td>
         <td width="1%">&nbsp;</td>
         <td>
          <div id="scroll_list" style="width:375px;height:90px;background-color:white;overflow:auto;BORDER: #4279bd 1px solid; ">
           mcBean.getCategoryList(null)
          </div>
         </td>
       </tr>       
       <tr>
       <td height="26" width="21%" align="right">Purchase Type:</td>
       <td width="1%">&nbsp;</td>
        <td>
         <table border="0" cellpadding="0" cellspacing="0">
         <tr>
          <td width="30%">
           <select name="purchasetype">
            <option value=1 <%=mcBean.getSelected(1, info.PurchaseType)%>>Long-time Purchase</option>
            <option value=2 <%=mcBean.getSelected(2, info.PurchaseType)%>>Short-time Purchase</option>
            <option value=3 <%=mcBean.getSelected(2, info.PurchaseType)%>>Urgent Purchase</option>
           </select>
          </td>
          <td height="26" width="21%" align="right">* Valid for:</td>
          <td width="1%">&nbsp;</td>
          <td>
           <select name="validmonths">
            <option value=1 selected>One Month</option>
            <option value=2 selected>Two Months</option>
            <option value=3 selected>Three Months</option>
            <option value=6 selected>Six Months</option>
            <option value=9 selected>Nine Months</option>
            <option value=12 selected>One Year</option>
           </select>
          </td>
         </tr>
         </table>
        </td>           
       </tr>
       <tr>
         <td colspan="3" height="5"></td>
       </tr>
       <tr>
         <td colspan="3" height="24">&nbsp;&nbsp;<b>My requirement for products:</b></td>
       </tr>
       <tr>
         <td height="24" width="21%" align="right">Price Range:</td>
         <td width="1%">&nbsp;</td>
         <td>
         <select name="currencyunit">
          <option value="">Select One</option>
          <option value="USD"> USD </option>
          <option value="GBP"> GBP </option>
          <option value="RMB"> RMB </option>
          <option value="EUR"> EUR </option>
          <option value="AUD"> AUD </option>
          <option value="CAD"> CAD </option>
          <option value="EHF"> CHF </option>
          <option value="JPY"> JPY </option>
          <option value="HKD"> HKD </option>
          <option value="ZND"> NZD </option>
          <option value="SGD"> SGD </option>
          <option value="OTH"> Other </option>
         </select>&nbsp;
         <input name="pricefrom" size="14" maxlength="14" value="" type="text" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
            &nbsp; - &nbsp;
         <input name="priceto" size="14" maxlength="14" value="" type="text" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
          (e.g.:10 - 1000)                 
         </td>
       </tr>
       <tr>
        <td height="22" width="21%" align="right">Minimum Order Quantity:</td>
        <td width="1%">&nbsp;</td>
        <td><input maxlength="14" name="minquantity" size="14" value="" type="text" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
            <select name="quantityunit">
              <option value="">Select One</option>
              <option value="Bag"> Bags </option>
              <option value="Barrel"> Barrels </option>
              <option value="Bushels"> Bushels </option>
              <option value="Cubic Meter"> Cubic Meter </option>
              <option value="Dozen"> Dozen </option>
              <option value="Gallon"> Gallon </option>
              <option value="Gram"> Gram </option>
              <option value="Kilogram"> Kilogram </option>
              <option value="Kilometer"> Kilometer </option>
              <option value="Long Ton"> Long Ton </option>
              <option value="Meter"> Meter </option>
              <option value="Metric Ton"> Metric Ton </option>
              <option value="Ounce"> Ounce </option>
              <option value="Pair"> Pair </option>
              <option value="Packs"> Packs </option>
              <option value="Pieces"> Pieces </option>
              <option value="Pound"> Pound </option>
              <option value="Sets"> Sets </option>
              <option value="Short Ton"> Short Ton </option>
              <option value="Square Meter"> Square Meter </option>
              <option value="Ton"> Ton </option>
              <option value="Others"> Others </option>
            </select>
        </td>
       </tr>
       <tr>
         <td colspan="3" height="5"></td>
       </tr>
       <tr>
         <td colspan="3"><HR align="center" width="98%" color="#D6D6D6" noShade SIZE=1></td>
       </tr>
       <tr>
         <td colspan="3" height="5"></td>
       </tr>
       <tr>
         <td class="row1" width="21%">&nbsp;</td>
         <td width="1%">&nbsp;</td>
         <td>
           <table border="0" cellpadding="0" cellspacing="0">
           <tr>
            <td width="50%" align="right"><input type="submit" name="update" style='width:120px' value="Submit" onClick="setAction(document.form_postmessage,'Submit_PostMessage');"></td>
            <td width="30%">&nbsp;</td>
            <td><input type="reset" name="Reset" style='width:80px' value="Reset"></td>
           </tr>
           </table>
          </td>
       </tr>
     </table>
    </TD>
   </TR>
 </TABLE>
 </FORM>
 <SCRIPT>onPostMessageFormLoad(document.form_postmessage);</SCRIPT>
  </TD>
 </TR>
 </TABLE>
<% } %>