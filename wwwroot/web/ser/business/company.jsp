<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberCompanyBean" %>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo" %>
<%
{
//    if (!bean.canAccessPage(request, response, AccessRole.ROLE_INFOMATION))
//        return;
    MemberCompanyBean bean = new MemberCompanyBean(session);

    CompanyInfo info;    
    if (sRealAction.startsWith("Update"))
    {
//bean.showAllParameters(request, out);
        info = (CompanyInfo) ret.getUpdateInfo();
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
        else
        {
            sDisplayMessage = mcBean.getLabel("oi-updatedes");//DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "organization information");
        }
    }
    else if (sRealAction.startsWith("Remove"))
    {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
        else
        {
            sDisplayMessage = mcBean.getLabel("oi-removedes");//"The building photo file was removed successfully.";
        }
        info = (CompanyInfo) ret.getUpdateInfo();
    }
    else
    {
      info = bean.get(mbInfo.MemberID);
    }

    int nFileMaxSize = 1024; //(KB)

//Utilities.dumpObject(info);    
%>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
 <FORM name="form_company" method="post" action="<%=mcBean.encodedUrl("index.jsp?action=Update_Company&maxsize="+nFileMaxSize)%>" enctype="multipart/form-data" onSubmit="return validateCompany(this);" target1="target_upload">
 <input type="hidden" name="companyid" value="<%=info.CompanyID%>">
 <INPUT type="hidden" name="subdir" value="company">
 <input type="hidden" name="action1" value="Update_Company">
 <table class="table-outline" width="100%" align="center">
 <TR>
  <TD colspan="2" height="1">
   <%@ include file="../include/information.jsp"%>
  </TD>
 </TR>
 <tr>
  <td colspan="2" height="22">&nbsp;&nbsp;<b><%=bean.getLabel("oi-usinfo")%>:</b> (<%=bean.getLabel("oi-fieldmark")%>)</td>
 </tr>
 <tr>
  <td width="20%" height="22" align="right">* <%=bean.getLabel("oi-orgname")%>: </td>
  <td><input maxlength=50 name="companyname" value="<%=Utilities.getValue(info.CompanyName)%>" size="80"></td>
</tr>
<tr>
  <td width="20%" height="22" align="right"><%=bean.getLabel("cm-desc")%>:</td>
  <td><textarea name="companydesc" rows="6" cols="61" wrap="virtual"><%=Utilities.getValue(info.CompanyDesc)%></textarea></td>
</tr>
<tr>
  <td width="20%" align="right" height="22">* <%=bean.getLabel("pf-street")%>:</td>
  <td><input maxlength=60 name="address" value="<%=Utilities.getValue(info.Address)%>" size="80"></td>
</tr>
<tr>
  <td width="20%" align="right" height="22">* <%=bean.getLabel("pf-city")%>:</td>
  <td><input maxlength=60 name="city" value="<%=Utilities.getValue(info.City)%>" size="80"></td>
</tr>
<tr>
  <td width="20%" align="right" height="22">* <%=bean.getLabel("pf-state")%>:</td>
  <td><input maxlength=30 name="state" value="<%=Utilities.getValue(info.State)%>" size="80"></td>
</tr>
<tr>
  <td width="20%" align="right" height="22">* <%=bean.getLabel("pf-zip")%>:</td>
  <td><input maxlength=12 name="zipcode" value="<%=Utilities.getValue(info.ZipCode)%>" size="80"></td>
</tr>
<tr>
  <td width="20%" align="right" height="22">* <%=bean.getLabel("pf-country")%>:</td>
  <td><input maxlength=20 name="country" value="<%=Utilities.getValue(info.Country)%>" size="80"></td>
</tr>
<tr>
  <td width="20%" align="right" height="22"><%=bean.getLabel("oi-website")%>:</td>
  <td><input maxlength=255 name="website" value="<%=Utilities.getValue(info.WebSite)%>" size="80"></td>
</tr>
<tr>
  <td width="20%"><div align="right" height="22">* <%=bean.getLabel("oi-person")%>:</div></td>
  <td><input maxlength=40 name="yourname" value="<%=Utilities.getValue(info.Yourname)%>" size="80"></td>
</tr>
<tr>
  <td width="20%" height="22" align="right">* <%=bean.getLabel("cm-email")%>:</td>
  <td><input maxlength=60 name="email" value="<%=Utilities.getValue(info.EMail)%>" size="80"></td>
</tr>
<tr>
  <td width="20%" height="22" align="right">* <%=bean.getLabel("cm-phone")%>:</td>
  <td><input maxlength=20 name="phone" value="<%=Utilities.getValue(info.Phone)%>" size="80"></td>
</tr>
<tr>
  <td width="20%" height="22" align="right"><%=bean.getLabel("oi-fax")%>:</td>
  <td><input maxlength=20 name="fax" value="<%=Utilities.getValue(info.Fax)%>" size="80"></td>
</tr>
<!--
 <tr>
  <td colspan="2" height="22">&nbsp;&nbsp;<b>Payment Information:</b> (You can apply a <a href="http://www.paypal.com" target="_blank">PayPal</a> Account to sell your products.)</td>
 </tr>
 <tr>
   <td width="22%" height="22" align="right">PayPal Account:</td>
    <td><input maxlength=128 name="paypalaccount" value="<%=Utilities.getValue(info.PaypalAccount)%>" size="80"></td>
 </tr>
-->
 <tr>
  <td colspan="2" height="22">&nbsp;&nbsp;<b><%=bean.getLabel("oi-detail")%></b> (<%=bean.getLabel("oi-detaildes")%>)</td>
 </tr>
 <tr>
   <td colspan="2">
     <textarea id="contactuspage" name="contactuspage"><%=Utilities.getValue(info.ContactUsPage)%></textarea>
     <!--script language="javascript1.2">createToolbar('contactuspage', 550, 140, ",7,15,16,17,19,20,27,28,29,30,31,33,35,36");</script-->
      <script language="javascript1.2">createToolbar('contactuspage', 710, 260, ",7,15,16,17,32,");</script>  
   </td>
 </tr>
 <tr>
    <td colspan="2" height="2" valign="bottom"></td>
 </tr>
 <tr>
   <td width="20%" align="right" height="22"><%=bean.getLabel("oi-building")%>:</td>
   <td><input type="hidden" name="photoimageid" value="<%=info.PhotoImageID%>"><input type="file" name="photoimagefile" size="60">
<% if (info.PhotoImageID>0) { %>
     [<%=mcBean.getPreviewLink("BuidPhoto", bean.getLabel("oi-picture"), info.PhotoImageID, bean.getLabel("cm-preview"))%>, <a href='<%=mcBean.encodedUrl("index.jsp?action=Remove File_Company&fileid="+info.PhotoImageID)%>' onClick="return confirm('<%=bean.getLabel("cm-confirmremove")%>');"><%=bean.getLabel("cm-remove")%></a>]
<% } %>
   </td>
 </tr>
 <tr>
   <td width="20%" align="right" height="22"><%=bean.getLabel("oi-showmap")%>:</td>
   <td>
     <select name="showmap">
     <option value=1 <%=bean.getSelected(1, info.ShowMap)%>><%=bean.getLabel("cm-yes")%></option>
     <option value=0 <%=bean.getSelected(0, info.ShowMap)%>><%=bean.getLabel("cm-no")%></option>
     </select> <%=bean.getLabel("oi-showmapdes")%>
   </td>
 </tr>
 <tr>
  <td colspan="2" height="2" valign="bottom"></td>
 </tr>
 <tr>
   <td colspan="2"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
 </tr>
<tr>
  <td colspan="2" align="center" height="22"><input type="submit" name="submit" value="<%=bean.getLabel("cm-update")%>" style='width:120px'></td>
</tr>
</table>
</form>
<SCRIPT>onCompanyFormLoad(document.form_company);</SCRIPT>
<% } %>