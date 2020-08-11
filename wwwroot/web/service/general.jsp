<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.model.NavigationInfo" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.GeneralInfo" %>
<%
    GeneralInfo glInfo = trInfo.getGeneral(loginInfo);
    if (glInfo.RequestType<=0)
       glInfo.RequestType = RequisitionWeb.REQUEST_PHYSICIAN;

    int nGeneralId = glInfo.ID;
    if (nGeneralId<0)
       nGeneralId = 0;
    String sUploadAjaxUrl = "";
    if (web.getHttpsUrl()!=null)
       sUploadAjaxUrl = "/ctr";
    sUploadAjaxUrl += "/fileupload/acceptfiles.jsp?action=cards&id=" + nGeneralId+"&customerid=" + loginInfo.CustomerID;
    String sImageGetUrl = "/Clinician?action=GetImage&id=" + nGeneralId + "&customerid=" + glInfo.CustomerID + "&JSID=" + ss.getId();
%>
<script>
var g_imageUrl = '<%=sImageGetUrl%>';
var g_uploadUrl = '<%=sUploadAjaxUrl%>';
var g_customerId = <%=glInfo.CustomerID%>;
function getUploadUrl(person)
{
    return g_uploadUrl;
}

function getImageUrl(person)
{
    return g_imageUrl;
}

$(document).ready(function()
{
    var form = document.testform;
    setRadioValue(form.ethnicity, <%=glInfo.Ethnicity%>);
    selectDropdownMenu(form.expiremonth, "<%=glInfo.ExpireMonth%>");
    selectDropdownMenu(form.expireyear, "<%=glInfo.ExpireYear%>");
    fillBirthDay(form, "<%=Utilities.getValue(glInfo.BirthDay)%>");

    if (form.billtype.length==2)
    {
       form.billtype.selectedIndex = 1;
       onPaymentMethodChange(form.billtype);
       form.billtype.disabled = true;
    }

    $('.datepicker').datepicker({
        viewMode: 'years',
        format: 'mm/dd/yyyy'
    });

    initUploadImageFile('inscarduploader', 'insurance', 'id_uploadedfiles1', '<%=sUploadAjaxUrl%>', '<%=sImageGetUrl%>');
    initUploadImageFile('medicareuploader', 'medicare', 'id_uploadedfiles2', '<%=sUploadAjaxUrl%>', '<%=sImageGetUrl%>');
});
</script>
<table width="100%" class="well well-sm">
 <tr>
  <td>
      <ol class="breadcrumb">
      <li class="active"><b><%=NavigationInfo.Navigation.General.GetName()%></b></li>
<% if (glInfo.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
      <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Ordering.GetName()%></font></li>
<% } %>
      <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Clinical.GetName()%></font></li>
      <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Eligibility.GetName()%></font></li>
<% if (trInfo.glInfo.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
      <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Consent.GetName()%></font></li>
<% } %>
      <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Summary.GetName()%></font></li>
      </ol>
  </td>
 </tr>
</table>
<FORM name="testform" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-General">
<INPUT type="hidden" name="id" value="<%=glInfo.ID%>">
<TABLE class="table table-condensed" width="98%" align="center" border=0 cellpadding="1" cellspacing="1">
 <tr class="info">
   <td colspan=2><b>Patient Information</b></td>
 </tr>
<tr>
  <td width="26%" height="36" align="right">* First Name:</td>
  <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.FirstName)%>" name="firstname" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right" height="30">Middle Name:</td>
  <td align="left"><input maxlength=20 value="<%=Utilities.getValue(glInfo.MiddleName)%>" name="middlename" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
 <td align="right" height="30">* Last Name:</td>
 <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.LastName)%>" name="lastname" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right" height="30" nowrap>* Date of Birth:</td>
  <td>
      <select name="bmonth" class2="form-control input-sm">
        <option value="" selected>Month</option>
        <option value="01">01</option>
        <option value="02">02</option>
        <option value="03">03</option>
        <option value="04">04</option>
        <option value="05">05</option>
        <option value="06">06</option>
        <option value="07">07</option>
        <option value="08">08</option>
        <option value="09">09</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
      </select>
      /
      <select name="bday" class2="form-control input-sm">
        <option value="" selected>Day</option>
<% for (int nDay=1; nDay<=31; nDay++) { %>
        <option value="<%=nDay<10?("0"+nDay):(""+nDay)%>"><%=nDay<10?("0"+nDay):(""+nDay)%></option>
<% } %>
      </select>
      /
      <select name="byear" class2="form-control input-sm">
        <option value="" selected>Year</option>
<% for (int nYear=1900; nYear<=Calendar.getInstance().get(Calendar.YEAR); nYear++) { %>
        <option value="<%=nYear%>"><%=nYear%></option>
<% } %>
      </select><input type="hidden" value="<%=Utilities.getValue(glInfo.BirthDay)%>" name="birthday">
      </td>
</tr>
<tr>
  <td align="right">* Gender:</td>
  <td><input type="radio" value="1" name="gender" <%=glInfo.Gender==1?"checked":""%>>Male&nbsp;&nbsp;&nbsp;
       <input type="radio" value="2" name="gender" <%=glInfo.Gender==2?"checked":""%>> Female
  </td>
</tr>
<tr>
  <td align="right" height="30">* Ethnic Background:</td>
  <td><input type="radio" value="<%=GeneralInfo.AEnthic.African.GetValue()%>" name="ethnicity"> African American
     &nbsp;<input type="radio" value="<%=GeneralInfo.AEnthic.Asian.GetValue()%>" name="ethnicity"> Asian/Pacific Islander
     &nbsp;<input type="radio" value="<%=GeneralInfo.AEnthic.Caucasian.GetValue()%>" name="ethnicity"> Caucasian
     &nbsp; <input type="radio" value="<%=GeneralInfo.AEnthic.Hispanic.GetValue()%>" name="ethnicity"> Hispanic
     <br><input type="radio" value="<%=GeneralInfo.AEnthic.Mediterranean.GetValue()%>" name="ethnic"> Mediterranean
     &nbsp; <input type="radio" value="<%=GeneralInfo.AEnthic.American.GetValue()%>" name="ethnicity"> Native American
     <input type="radio" value="<%=GeneralInfo.AEnthic.Other.GetValue()%>" name="ethnicity"> &nbsp;
    Other <input type="text" value="<%=Utilities.getValue(glInfo.EthnicOther)%>" name="ethnicother" maxlength="20" style="width:160px" class="input-sm">
  </td>
</tr>
    <tr>
      <td align="right">Address:</td>
      <td ><input maxlength=60 value="<%=Utilities.getValue(glInfo.Address)%>" name="address" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right">City:</td>
      <td><input maxlength=30 value="<%=Utilities.getValue(glInfo.City)%>" name="city" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right">State:</td>
      <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.State)%>" name="state" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right">Zip:</td>
      <td><input maxlength=10 value="<%=Utilities.getValue(glInfo.Zip)%>" name="zip" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right" height="30">Phone: </td>
      <td nowrap><input maxlength=20 value="<%=Utilities.getValue(glInfo.Phone)%>" name="phone" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right">E-Mail: </td>
      <td><input maxlength=50 value="<%=Utilities.getValue(glInfo.EMail)%>" name="email" style="width:550px" class="form-control input-sm"></td>
    </tr>

 <tr class="info">
  <td colspan=2><b>Refering Physician Information</b></td>
</tr>
<tr>
<tr>
 <td align="right">* Name (Last, First, MI.):</td>
 <td><input type="text" maxlength=40 value="<%=Utilities.getValue(glInfo.Phy_Name)%>" name="phy_name" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
 <td align="right"> Provider NPI#:</td>
 <td><input type="text" maxlength=50 value="<%=Utilities.getValue(glInfo.ProviderNpi)%>" name="providernpi" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
 <td align="right" nowrap>* Institution:</td>
 <td><input type="text" maxlength=50 value="<%=Utilities.getValue(glInfo.Institution)%>" name="institution" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right" height="30">Address:</td>
  <td><input maxlength=60 value="<%=Utilities.getValue(glInfo.Phy_Address)%>" name="phy_address" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right">City:</td>
  <td><input maxlength=30 value="<%=Utilities.getValue(glInfo.Phy_City)%>" name="phy_city" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right">State:</td>
  <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.Phy_State)%>" name="phy_state" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right">Zip:</td>
  <td><input maxlength=10 value="<%=Utilities.getValue(glInfo.Phy_Zip)%>" name="phy_zip" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right">Phone:</td>
  <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.Phy_Phone)%>" name="phy_phone" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right">Fax:</td>
  <td ><input maxlength=20 value="<%=Utilities.getValue(glInfo.Phy_Fax)%>" name="phy_fax" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right">E-Mail:</td>
  <td ><input maxlength=50 value="<%=Utilities.getValue(glInfo.Phy_Email)%>" name="phy_email" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right">Preferred Method of reporting:</td>
  <td>
    <select name="reportmethod" style="width:200px" class="form-control input-sm">
<%
    int nTotalRM = GeneralInfo.AReportMethod.GetTotal();
    for (int i=0; i<nTotalRM; i++) {
%>
      <option value="<%=GeneralInfo.AReportMethod.GetValueByIndex(i)%>" <%=(GeneralInfo.AReportMethod.GetValueByIndex(i)==glInfo.ReportMethod?"selected":"")%>><%=GeneralInfo.AReportMethod.GetNameByIndex(i)%></option>
<% } %>
    </select>
  </td>
</tr>
<tr>
  <td align="right">Genetic Counselor<br>Additional Recipient:</td>
  <td><input type="text" maxlength=40 value="<%=Utilities.getValue(glInfo.Recipient)%>" name="recipient" style="width:550px" class="form-control input-sm"></td>
</tr>    

 <tr class="info">
   <td colspan=2><b>Sample Information</b></td>
 </tr>
 <tr>
 <tr>
  <td align="right">Date Collected:</td>
  <td><input type="text" maxlength=20 class="datepicker" value="<%=Utilities.getValue(glInfo.DateCollect)%>" name="datecollect" style="width:200px" class="form-control input-sm"></td>
 </tr>
 <tr>
  <td align="right">Sample Type:</td>
  <td colspan="5"><input type="hidden" name="sampletype" value="<%=glInfo.SampleType%>">
   <input type="checkbox" value="<%=GeneralInfo.ASampleType.Blood.GetValue()%>" name="st_Blood" <%=isChecked(glInfo.SampleType,GeneralInfo.ASampleType.Blood.GetValue())%>> Blood (EDTA purple-top tube) &nbsp; &nbsp;&nbsp;
   <input type="checkbox" value="<%=GeneralInfo.ASampleType.Saliva.GetValue()%>" name="st_Saliva" <%=isChecked(glInfo.SampleType,GeneralInfo.ASampleType.Saliva.GetValue())%>> Saliva &nbsp;&nbsp;&nbsp;
   <input type="checkbox" value="<%=GeneralInfo.ASampleType.DNA.GetValue()%>" name="st_DNA" <%=isChecked(glInfo.SampleType,GeneralInfo.ASampleType.DNA.GetValue())%>> DNA
  </td>
 </tr>
 <tr>
  <td colspan="2">
    <table width="100%">
      <tr>
        <td width="45%" nowrap valign="top">&nbsp;&nbsp;<b><i>Please check all of the following situations that apply:</i></b></td>
        <td><input type="checkbox" value="1" name="narrow" <%=glInfo.Narrow>0?"checked":""%>> Patient has had bone marrow transplant
           <br><input type="checkbox" value="1" name="transfusion" <%=glInfo.Transfusion>0?"checked":""%>> Patient has had transfusion within the past 30 days
           <br><input type="checkbox" value="1" name="familypregnant" <%=glInfo.FamilypRegnant>0?"checked":""%>> Patient or immediate family member is pregnant
        </td>
      </tr>
    </table>
  </td>
 </tr>
 <tr class="info">
   <td colspan=3><b>Billing Information</b></td>
 </tr>
 <tr>
 <tr>
  <td align="right" nowrap>* Methods of Billing:</td>
  <td>
  <select name="billtype" onchange="onPaymentMethodChange(this)" style="width:300px" class="form-control input-sm">
    <option value="0">Select one of payment methods</option>
 <%
     int nBillOption = Utilities.getInt(loginInfo.Option1, 0);
     if (nBillOption<=0)
        nBillOption = GeneralInfo.ABillType.GetTotalValueFlag(GeneralInfo.ABillType.CreditCardPayment.GetValue());
     int nTotalBill1 = GeneralInfo.ABillType.GetTotal();

     for (int i=0; i<nTotalBill1; i++) {
        if ((GeneralInfo.ABillType.GetValueByIndex(i)&nBillOption)==0)
           continue;
 %>
      <option value="<%=GeneralInfo.ABillType.GetValueByIndex(i)%>" <%=(GeneralInfo.ABillType.GetValueByIndex(i)==glInfo.BillType?"selected":"")%>><%=GeneralInfo.ABillType.GetNameByIndex(i)%></option>
 <% } %><br>
  </td></tr><tr><td colspan="2">
    <div id="bt_<%=GeneralInfo.ABillType.Institution.GetValue()%>" style="display:<%=glInfo.BillType==GeneralInfo.ABillType.Institution.GetValue()?"inline":"none"%>">
     <table class="table table-bordered table-condensed" width="100%" align="center">
       <tr>
        <td width="26%" align="right">* Institution Name:</td>
        <td><input type="text" maxlength=120 value="<%=Utilities.getValueLength(glInfo.InsName)>0?glInfo.InsName:Utilities.getValue(glInfo.Institution)%>" name="insname" style="width:550px" class="form-control input-sm"></td>
       </tr>  
       <tr>
        <td align="right">* Contact Number:</td>
        <td><input type="text" maxlength=120 value="<%=Utilities.getValueLength(glInfo.InsContact)>0?glInfo.InsContact:Utilities.getValue(glInfo.Phy_Phone)%>" name="inscontact" style="width:550px" class="form-control input-sm"></td>
       </tr>
     </table>
    </div>

   <div id="bt_<%=GeneralInfo.ABillType.Medicare.GetValue()%>" style="display:<%=glInfo.BillType==GeneralInfo.ABillType.Medicare.GetValue()?"inline":"none"%>">
   <table class="table table-bordered table-condensed" width="100%">
     <tr>
      <td width="26%" align="right">* Medicare/Medicaid No:</td>
      <td><input type="text" maxlength=60 value="<%=Utilities.getValue(glInfo.MedicareNo)%>" name="medicareno" style="width:550px" class="form-control input-sm"></td>
     </tr>
     <tr>
      <td align="right">* State:</td>
      <td><input type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.MedicareState)%>" name="medicarestate" style="width:550px" class="form-control input-sm"></td>
     </tr>
       <tr>
        <td colspan="2">
         <table width="100%">
          <tr>
            <td height="26">&nbsp;<font size="2">Please upload a photo image copy of medicare card(s) both front and back for billing purposes:</font></td>
          </tr>
          <tr>
            <td>&nbsp;&nbsp;<font size="2"><span id="medicareuploader">Upload Cards</span></font><INPUT type="hidden" name="medicarecard" value="<%=Utilities.getValue(glInfo.MedicareCard)%>"></td>
          </tr>
 <%
 StringBuffer sb2 = new StringBuffer();
 if (Utilities.getValueLength(glInfo.MedicareCard)>0)
 {
     String[] arFilename2 = glInfo.MedicareCard.split(",");
     String sRootUrl2 = sImageGetUrl + "&card=medicare&te=" + Calendar.getInstance().getTime().getTime();
     for (int i=0; i<arFilename2.length; i++) {
         sb2.append("&nbsp;, &nbsp;");
         String imageUrl =  sRootUrl2 + "&index=" + (i+1);
         int start = arFilename2[i].indexOf("-");
         sb2.append("<a href='" + imageUrl +"' target='_ImageWin'  title='View Image'><img src='" + imageUrl + "' width='100' border='1'  alt='View Image'></a>");
         sb2.append(" <a onClick=\"return removeCardFile(" + (i+1) + ",'"  + Utilities.getISO(arFilename2[i].substring(start+1)) + "',");
         sb2.append("'medicare','id_uploadedfiles2','" + sImageGetUrl);
         sb2.append("')\" href='#' title='Remove it'>Remove</a>");
     }
 }
 %>
          <tr><td valign="top">&nbsp;&nbsp;Uploaded Medicare Card(s): <span id="id_uploadedfiles2"><%=sb2.toString()%></span></td></tr>
          <tr><td height="4"></td></tr>
         </table>
        </td>
       </tr>
   </table>
   </div>
   <div id="bt_<%=GeneralInfo.ABillType.Insurance.GetValue()%>" style="display:<%=glInfo.BillType==GeneralInfo.ABillType.Insurance.GetValue()?"inline":"none"%>">
   <table width="100%" class="table table-bordered table-condensed">
     <tr>
      <td width="26%" align="right">* Policyholder Name:</td>
      <td><input type="text" maxlength=40 value="<%=Utilities.getValue(glInfo.PolicyName)%>" name="policyname" style="width:550px" class="form-control input-sm"></td>
     </tr>
     <tr>
      <td align="right">* DOB (MM/DD/YY):</td>
      <td><input class2="datepicker" type="text" maxlength=10 value="<%=Utilities.getValue(glInfo.HolderDOB)%>" name="holderdob" style="width:550px" class="form-control input-sm"></td>
     </tr>
     <tr>
      <td align="right">* Phone Number:</td>
      <td><input type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.HolderPhone)%>" name="holderphone" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
     <td align="right">* Insurance Co.</td>
     <td><input type="text" maxlength=30 value="<%=Utilities.getValue(glInfo.InsureanceCo)%>" name="insureanceco" style="width:550px" class="form-control input-sm"></td>
   </tr>
   <tr>
    <td align="right">* Member ID:</td>
    <td><input type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.MemberID)%>" name="memberid" style="width:550px" class="form-control input-sm"></td>
   </tr>
   <tr>
    <td align="right">* Group No.</td>
    <td><input type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.GroupNo)%>" name="groupno" style="width:550px" class="form-control input-sm"></td>
   </tr>
   <tr>
    <td colspan="2">
     <table width="100%">
      <tr>
        <td height="26">&nbsp;<font size="2">Please upload a photo image copy of insurance card(s) both front and back for billing purposes:</font></td>
      </tr>
      <tr>
       <td height="30" nowrap>&nbsp;&nbsp;<span id="inscarduploader">Upload Cards</span><INPUT type="hidden" name="insurancecard" value="<%=Utilities.getValue(glInfo.InsuranceCard)%>"></td>
      </tr>
 <%
 StringBuffer sb = new StringBuffer();
 if (Utilities.getValueLength(glInfo.InsuranceCard)>0)
 {
     String[] arFilename = glInfo.InsuranceCard.split(",");
     String sRootUrl = sImageGetUrl + "&card=insurance&te=" + Calendar.getInstance().getTime().getTime();

     for (int i=0; i<arFilename.length; i++) {
         sb.append("&nbsp; &nbsp;");
         String imageUrl =  sRootUrl + "&index=" + (i+1) + "&JSID=" + session.getId();
         sb.append("<a href='" + imageUrl +"' target='_ImageWin'  title='View Image'><img src='" + imageUrl + "' width='100' border='1'  alt='View Image'></a>");
         int start = arFilename[i].indexOf("-");
         sb.append(" <a onClick=\"return removeCardFile(" + (i+1) + ",'"  + Utilities.getISO(arFilename[i].substring(start+1)) + "',");
         sb.append("'insurance','id_uploadedfiles1','" + sImageGetUrl);
         sb.append("')\" href='#' title='Remove it'>Remove</a>");
     }
 }
 %>
      <tr><td valign="top">&nbsp;&nbsp;Uploaded Insurance Card(s): <span id="id_uploadedfiles1"><%=sb.toString()%></span></td></tr>
      <tr><td height="4"></td></tr>
     </table>
    </td>
   </tr>
   </table>
   </div>

 <div id="bt_<%=GeneralInfo.ABillType.OnlinePay.GetValue()%>" style="display:<%=glInfo.BillType==GeneralInfo.ABillType.OnlinePay.GetValue()?"inline":"none"%>">
     <table width="100%" class="table table-bordered table-condensed">
         <tr>
             <td colspan="2">
                 <div class="panel panel-warning">
                     <div class="panel-heading" align="left">
                         <font size="2">Please continue to fill out the test requisition. You will be asked to complete the order by making payment online at the end of this form.</font>
                     </div>
                 </div>
             </td>
         </tr>
     </table>
 </div>

    <div id="bt_<%=GeneralInfo.ABillType.CheckPay.GetValue()%>" style="display:<%=glInfo.BillType==GeneralInfo.ABillType.CheckPay.GetValue()?"inline":"none"%>">
        <table width="100%" class="table table-bordered table-condensed">
            <tr>
                <td colspan="2">
                    <div class="panel panel-warning">
                        <div class="panel-heading" align="left">
                            <font size="2">Please continue to fill out the test requisition. You will be promoted to mail check with your sample at the end of this form.</font>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <div id="bt_<%=GeneralInfo.ABillType.CreditCardPayment.GetValue()%>" style="display:<%=glInfo.BillType==GeneralInfo.ABillType.CreditCardPayment.GetValue()?"inline":"none"%>">
   <table width="100%" class="table table-bordered table-condensed">
       <tr>
         <td width="26%" align="right">* Name on Credit Card:</td>
         <td>
           <input maxlength=30 size=40 value="<%=Utilities.getValue(glInfo.CreditName)%>" name="creditname" style="width:440px" class="form-control input-sm">
         </td>
       </tr>
       <tr>
         <td align="right">* Credit Card Type:</td>
         <td>
           <select name="credittype" style="width:440px" class="form-control input-sm">
             <%=web.getCreditCardList2(glInfo)%>
           </select>
         </td>
       </tr>
       <tr>
         <td align="right">* Credit Card No:</td>
         <td>
           <input maxlength=20 size=40 value="<%=Utilities.getValue(glInfo.CreditNo)%>" name="creditno" style="width:440px" class="form-control input-sm">
         </td>
       </tr>
       <tr>
         <td align="right">* Expiration Month:</td>
         <td>
           <select name="expiremonth" style="width:440px" class="form-control input-sm">
             <option value="" selected>Month</option>
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
         </td>
       </tr>
         <tr>
           <td align="right">* Expiration Year:</td>
           <td>
             <select name="expireyear" style="width:440px" class="form-control input-sm">
               <option value="" selected>Year</option>
               <%=web.getExpiredYear(null)%>
             </select>
           </td>
         </tr>
       <tr>
         <td align="right"><a title="What is it?" href="javascript:ChildWin=window.open('/staticfile/web/cards-help.html','cards_help','resizable=yes,scrollbars=no,width=460,height=680');ChildWin.focus()">* Verification Number:</a></td>
         <td>
           <input maxlength=8 size=10 value="<%=Utilities.getValue(glInfo.CSid)%>" name="csid" type="text" style="width:440px" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");' class="form-control input-sm">
         </td>
       </tr>
   </table>
   </div>

   </td>
 </tr>
</TABLE>
<div id="id_patientack" style="display:<%=(RequisitionWeb.tryEligibility(trInfo))?"inline":"none"%>">
<TABLE class="table table-condensed" width="98%" align="center" border=0 cellpadding="1" cellspacing="1">
 <tr>
   <td colspan="4" align="center"><b>Patient Acknowledgement for Financial Responsibility</b></td>
 </tr>
 <tr>
   <td colspan="4"><div style="text-align:justify;padding-left:10px;padding-right:10px"><font size="1">
 I acknowledge that the information provided by me is true to the best of my knowledge.
 I hereby authorize my insurance benefits to be paid directly to ApolloGen, Inc.
 and authorize them to release medical information concerning my testing to my insurer.
 I understand that I am financially responsible for any amounts not covered by my insurer for this test order.
 I also fully understand that I am legally responsible for sending ApolloGen any money received from my health
 insurance company for the performance of this genetic test. Failing to do so will result in my account being sent to collection.
   </font></div>
   </td>
 </tr>
 <tr>
   <td width="25%" align="right"><font color="red">* Patient's Signature:</font></td>
   <td width="30%">
     <input type="hidden" name="patientsign" value='<%=Utilities.getValue(glInfo.PatientSign)%>'>
     <div id="patsignarea" onclick="return openSignPad('Patient')" align="center"
          style="cursor: pointer;width: 190px; height: 50px; border: 1px solid #bbbbbb;background: #ffffff;padding:2px 2px 2px 2px">
         <% if (Utilities.getValueLength(glInfo.PatientSign)>10 && glInfo.PatientSign.indexOf("{\"lines\":")>=0) {%>
         <img src='<%=sImageGetUrl%>&type=Vector&data=Patient&te=<%=Calendar.getInstance().getTime().getTime()%>' height="44">
         <% } %>
     </div>
   </td>
   <td width="20%" align="right">* Date:</td>
   <td><input class="datepicker" type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.SignDate)%>" name="signdate" style="width:200px"></td>
 </tr>
 </TABLE>
 </div>
 <TABLE class="table table-condensed" width="98%" align="center" border=0 cellpadding="1" cellspacing="1">
 <tr class="info">
   <td colspan=4><b>Statement of Medical Necessity</b></td>
 </tr>
 <tr>
   <td colspan=4 align="center"><b>Informed Consent and Statement of Medical Necessity</b></td>
 </tr>
 <tr>
   <td colspan="4"><div style="text-align:justify;padding-left:10px;padding-right:10px"><font size="1">
    I have supplied information to the patient regarding genetic testing and the patient has given consent for genetic testing to be performed. I further confirm that this test is medically necessary for the diagnosis, detection or treatment of a disease, illness, impairment, symptom, syndrome or disorder, and the results will be used in the medical management and treatment decisions for the patient. I confirm that the person listed in the Ordering Physician space above is authorized by law to order the test(s) requested herein.   </font></div>
   </td>
 </tr>
 <tr>
   <td align="right" width="25%"><font color="red">* Physician's Signature:</font></td>
   <td width="30%">
       <input type="hidden" name="phy_sign" value='<%=Utilities.getValue(glInfo.Phy_Sign)%>'>
       <div id="physignarea" onclick="return openSignPad('Physician')" align="center"
       style="cursor: pointer;width: 190px; height: 50px; border: 1px solid #bbbbbb;background: #ffffff;padding:2px 2px 2px 2px">
<% if (Utilities.getValueLength(glInfo.Phy_Sign)>10 && glInfo.Phy_Sign.indexOf("{\"lines\":")>=0) {%>
        <img src='<%=sImageGetUrl%>&type=Vector&data=Physician&te=<%=Calendar.getInstance().getTime().getTime()%>' height="44">
<% } else if (Utilities.getValueLength(glInfo.Phy_Sign)>3) { %>
        <img src='<%=sImageGetUrl%>&card=physciansign&te=<%=Calendar.getInstance().getTime().getTime()%>' height="44">
<% } %>
       </div>
   </td>
   <td align="right" width="20%">* Date:</td>
   <td><input type="text" class="datepicker" maxlength=10 value="<%=Utilities.getValue(glInfo.Phy_SignDate)%>" name="phy_signdate" style="width:200px" class="form-control input-sm"></td>
 </tr>
 </TABLE>

<table width="100%" align="center" border=0>
<tr><td colspan="3"><hr style="border:2px solid #000000"></td></tr>           
<tr>
<td width="40%" align="center">
    <span id="id_buttonmessage"></span>
</td>
 <td align="center" width="40%"></td>
 <td align="right">
   <input class="btn btn-default active" type="submit" name="update" value="Next >" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitGeneralInfo, document.testform, 'id_mainarea', 'next');">
</td>
</tr>
</table>
</FORM>