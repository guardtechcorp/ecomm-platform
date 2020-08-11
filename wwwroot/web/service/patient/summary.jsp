<%
    GeneralInfo glInfo = trInfo.getGeneral(0);
    ConsentInfo ctInfo = trInfo.getConcent(0);

    String sRootUrl = "";
    if ("GetSummary".equalsIgnoreCase(request.getParameter("action"))||"pdf".equalsIgnoreCase(request.getParameter("output")))
    {
        sRootUrl = "http://localhost:8080";
        if (RequisitionWeb.getHttpsUrl()!=null)
           sRootUrl += "/ctr";
    }
    String jsId2 = request.getParameter("JSID");
    if (Utilities.getValueLength(jsId2)==0)
       jsId2 = session.getId();
    sRootUrl += "/Patient?action=GetImage&id=" + glInfo.ID + "&customerid=" + glInfo.CustomerID +  "&JSID=" + jsId2 + "&te=" + Calendar.getInstance().getTime().getTime();

    String sImageGetUrl = "/Clinician?action=GetImage&id=" + glInfo.ID + "&customerid=" + glInfo.CustomerID + "&JSID=" + ss.getId();
%>

<table width="100%" cellpadding="2" cellspacing="2">
<tr>
 <td height="36"><font size="3"><i>Process Information:</i></font></td>
<% if (Utilities.getValueLength(glInfo.RequestCode)>0) { %>
 <td align="right" nowrap width="70%">Request Code: <font size="3" color='#f39f53'><b><%=Utilities.getValue(glInfo.RequestCode).toUpperCase()%></b>&nbsp;</font></td>
<% } %>
</tr>
</table>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc" cellpadding="2" cellspacing="2">
 <tr>
 <td align="right" width="13%" nowrap>Process Status:</td>
 <td width="20%"><b><%=Utilities.getValue(RequisitionInfo.AStatus.GetNameByValue(glInfo.Status))%></b></td>
 <td align="right" width="13%" nowrap>Submitted By:</td>
 <td width="21%"><b><%=(Utilities.getValue(glInfo.FirstName) + " " + Utilities.getValue(glInfo.LastName))%></b></td>
 <td align="right" width="13%" nowrap>Time:</td>
 <td width="20%"><b><%=glInfo.CreateDate.substring(0, 16)%></b></td>
 </tr>
<% if (glInfo.Status>RequisitionInfo.AStatus.RESUBMITTED.GetValue()) {
      String sAdminName = glInfo.m_RealName;
      if (Utilities.getValueLength(sAdminName)==0)
         sAdminName = glInfo.m_Username;
%>
<tr>
<td align="right" width="13%" nowrap valign="top">Description:</td>
<td colspan="3">
 <b><%=Utilities.convertHtml(Utilities.getValue(glInfo.Description), true)%></b>
</td>
<td align="right" width="13%" nowrap valign="top">Handle By:</td>
<td width="20%"><b><%=Utilities.getValue(sAdminName)%></b></td>
</tr>
<%
   String sFiles = null;
   if (Utilities.getValueLength(glInfo.ReportFiles)>0) {
       String[] arFile = trInfo.glInfo.ReportFiles.split(",");
       StringBuffer sb = new StringBuffer();
       sb.append("<ul>");
       for (int i=0; i<arFile.length; i++)
       {
          int nIndex = arFile[i].indexOf("-");
          sb.append("<li><a href='/Clinician?action=Download&id=" + trInfo.glInfo.ID+"&index=" + i + "' title='Click to download it'>");
          sb.append(arFile[i].substring(nIndex+1) + "</a></li>");
       }
       sb.append("</ul>");

       sFiles = sb.toString();
   }
%>
<tr>
<td align="right" width="13%" nowrap valign="top">Report Files:</td>
<td colspan="3"><%=Utilities.getValue(sFiles)%></td>
<td align="right" width="13%" nowrap valign="top">Latest Update:</td>
<td width="20%"><b><%=glInfo.ModifyDate.substring(0, 16)%></b></td>
</tr>
<% } %>
</table>
 <p>
 <font size="3"><i>Patient Information:</i></font>
 <table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
<tr>
  <td align="right" width="13%" nowrap>First Name:</td>
  <td width="20%"><b><%=Utilities.getValue(glInfo.FirstName)%></b></td>
  <td align="right" width="13%" nowrap>Middle Name:</td>
   <td width="21%"><b><%=Utilities.getValue(glInfo.MiddleName)%></b></td>
  <td align="right" width="13%" nowrap>Last Name:</td>
   <td width="20%"><b><%=Utilities.getValue(glInfo.LastName)%></b></td>
</tr>
<%
   String sGender = "Unknown";
   if (glInfo.Gender==1)
      sGender = "Male";
   else if (glInfo.Gender==2)
       sGender = "Female";
%>
 <tr>
   <td align="right" nowrap>Date of Birth:</td>
   <td><b><%=Utilities.getValue(glInfo.BirthDay)%></b></td>
   <td align="right" nowrap>Sex:</td>
    <td><b><%=sGender%></b></td>
   <td align="right" nowrap>Ethnicity:</td>
    <td><b><%=Utilities.getValue(GeneralInfo.AEnthic.GetNameByValue(glInfo.Ethnicity))%></b></td>
  </tr>
 <tr>
   <td align="right" width="13%">Address:</td>
   <td colspan="5"><b><%=Utilities.getValue(glInfo.Address)%>,
     <%=Utilities.getValue(glInfo.City)%>, <%=Utilities.getValue(glInfo.State)%>&nbsp; <%=Utilities.getValue(glInfo.Zip)%>
   </b></td>
 </tr>
 <tr>
   <td colspan="6">
    <table width="100%">
      <tr>
       <td width="13%" align="right">Phone: </td>
       <td width="37%">&nbsp;&nbsp; <b><%=Utilities.getValue(glInfo.Phone)%></b></td>
       <td width="13%" align="right">E-Mail: </td>
       <td width="37%">&nbsp;&nbsp;<b><%=Utilities.getValue(glInfo.EMail)%></b></td>
      </tr>
    </table>
   </td>
 </tr>
</table>
<p>
<font size="3"><i>Refering Physician Information:</i></font>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
<% if (!"Yes".equalsIgnoreCase(glInfo.ProviderNpi)) { %>
<tr>
 <td align="right" width="13%" nowrap>Name:&nbsp;</td>
 <td width="20%"><b><%=Utilities.getValue(glInfo.Phy_Name)%></b></td>
 <td align="right" width="13%" nowrap>Institution Name:&nbsp;</td>
  <td colspan="3"><b><%=Utilities.getValue(glInfo.Institution)%></b></td>
</tr>
<tr>
  <td align="right" width="13%">Address:&nbsp;</td>
  <td colspan="5"><b><%=Utilities.getValue(glInfo.Phy_Address)%>,
    <%=Utilities.getValue(glInfo.Phy_City)%>, <%=Utilities.getValue(glInfo.Phy_State)%>&nbsp; <%=Utilities.getValue(glInfo.Phy_Zip)%>
  </b></td>
</tr>
<tr>
  <td align="right" nowrap>Phone:&nbsp;</td>
  <td width="20%"><b><%=Utilities.getValue(glInfo.Phy_Phone)%></b></td>
  <td align="right" nowrap>Fax:&nbsp;</td>
   <td width="21%"><b><%=Utilities.getValue(glInfo.Phy_Fax)%></b></td>
  <td align="right" nowrap>E-Mail:&nbsp;</td>
   <td width="20%"><b><%=Utilities.getValue(glInfo.Phy_Email)%></b></td>
</tr>
<% } else { %>
<tr>
  <td colspan="6">&nbsp;&nbsp;Need Help Finding a Doctor: &nbsp;&nbsp;<b>Yes</b></td>
</tr>    
<% } %>
</table>
<p>
<font size="3"><i>Sample Information:</i></font>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
<tr>
    <td align="right" width="13%" nowrap>Date Collected:&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValue(glInfo.DateCollect)%></b></td>
    <td align="right" width="13%" nowrap>Sample Type:&nbsp;</td>
    <td colspan="3"><b><%=Utilities.getValue(GeneralInfo.ASampleType.GetNameByValue(glInfo.SampleType))%></b></td>
</tr>
<tr>
    <td width="35%" nowrap align="right">&nbsp;The patient has following situation(s):</td>
    <td colspan="5">
       <ul>
        <% if (glInfo.Narrow==1) { %>
         <li><b>Bone marrow transplant</b> </li>
       <% } %>
       <% if (glInfo.Transfusion==1) { %>
        <li><b>Transfusion within the past 30 days</b> </li>
      <% } %>
       <% if (glInfo.FamilypRegnant==1) { %>
        <li><b>Patient or immediate family member is pregnant</b> </li>
      <% } %>
       </ul>
    </td>
</tr>
</table>
<p>
 <font size="3"><i>Test Ordering:</i></font>
<%
   float fTotal = 0;
%>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
 <% if (glInfo.CancerPanel>0) { %>
 <tr bgcolor="#eeeeee">
   <td>&nbsp;Cancer Panels:</td>
 </tr>
 <tr>
  <td>
  <ul>
<% if ((glInfo.CancerPanel&1)!=0) {
   fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_1"), 0);
%>
  <li>9001 iGene Cancer Panel (23 gene focus panel)</li>
<% } %>

<% if ((glInfo.CancerPanel&4)!=0) {
  fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_3"), 0);
%>
<li>2001 BRCA1 and BRCA2 Sequencing Panel</li>
<% } %>

<% if ((glInfo.CancerPanel&8)!=0) {
  fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_4"), 0);
%>
<li>2005 Breast Cancer and Gynecologic Cancer Panel</li>
<% } %>

<% if ((glInfo.CancerPanel&2)!=0) {
    fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_2"), 0);
%>
<li>2021 Colorectal Cancer Core Panel (12 genes)</li>
<% } %>

  </ul>
  </td>
 </tr>
<% } %>

<% if (glInfo.Cardiovascular>0) { %>
<tr bgcolor="#eeeeee">
  <td>&nbsp;Cardiovascular Panels:</td>
</tr>
<tr>
 <td>
 <ul>
<% if ((glInfo.Cardiovascular&1)!=0) {
   fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "Cardiovascular_1"), 0);
%>
 <li>9002 iGene Cardiac Panel (22 gene focus panel)</li>
<% } %>
 </ul>
 </td>
</tr>
<% } %>

<% if (glInfo.DrugSensitivity>0) { %>
<tr bgcolor="#eeeeee">
  <td>&nbsp;Drug Sensitivity Panels:</td>
</tr>
<tr>
 <td>
 <ul>
<% if ((glInfo.DrugSensitivity&1)!=0) {
    fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_1"), 0);
%>
 <li>1100 Comprehensive Pharmacogenomics (PGx) Panel</li>
<% } %>
<% if ((glInfo.DrugSensitivity&2)!=0) {
    fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_2"), 0);
%>
<li>1110 Pain Management PGx Panel</li>
<% } %>
<% if ((glInfo.DrugSensitivity&4)!=0) {
    fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_4"), 0);
%>
<li>1120 Mental Health PGx Panel</li>
<% } %>
<% if ((glInfo.DrugSensitivity&8)!=0) {
    fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_8"), 0);
%>
 <li>1130 Cardiovascular Health PGx Panel</li>
<% } %>
<% if ((glInfo.DrugSensitivity&16)!=0) {
    fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_16"), 0);
%>
  <li>1130 Cardiovascular Health PGx Panel</li>
<% } %>
 </ul>
 </td>
</tr>
<% } %>

<% if (glInfo.OtherRisk>0) { %>
<tr bgcolor="#eeeeee">
  <td>&nbsp;Other Health Risk Management Panels:</td>
</tr>
<tr>
 <td>
 <ul>
 <% if ((glInfo.OtherRisk&2)!=0) {
     fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_2"), 0);
 %>
 <li>1210 Comprehensive Obesity and Diabetes Genetic Risk Panel</li>
 <% } %>

<% if ((glInfo.OtherRisk&1)!=0) {
    fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_1"), 0);
%>
 <li>1500 Clinical Focused Exome (6110 genes)</li>
<% } %>

<% if ((glInfo.OtherRisk&4)!=0) {
 fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_3"), 0);
%>
<li>8700 Vital Mito (Mitochondrial Copy Number Analysis)</li>
<% } %>

 </ul>
 </td>
</tr>
<% } %>
 <!--tr>
   <td align="right">
     Total:&nbsp;&nbsp; <font color="red" size="3">$<%=Utilities.getNumberFormat(fTotal, 'N', 0)%></font> &nbsp;&nbsp; 
   </td>
 </tr-->
</table>
<% if (glInfo.BillType>0) { %>
<font size="3"><i>Billing Information:</i></font>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
  <tr>
     <td align="right" width="20%" nowrap>Methods of Billing:&nbsp;</td>
     <td colspan="5"><b><%=Utilities.getValue(GeneralInfo.ABillType.GetNameByValue(glInfo.BillType))%></b>
 </tr>
<% if (glInfo.BillType==GeneralInfo.ABillType.Institution.GetValue()){ %>
 <tr>
     <td align="right" width="13%" nowrap>Institution Name:&nbsp;</td>
     <td width="20%"><b><%=Utilities.getValue(glInfo.InsName)%></b></td>
     <td align="right" width="13%" nowrap>Contact Number:&nbsp;</td>
     <td colspan="3"><b><%=Utilities.getValue(glInfo.InsContact)%></b></td>
 </tr>
<% } else if (glInfo.BillType==GeneralInfo.ABillType.Medicare.GetValue()){ %>
 <tr>
     <td align="right" width="13%" nowrap>Medicare/Medicaid No.:&nbsp;</td>
     <td width="35%" colspan="3"><b><%=Utilities.getValue(glInfo.MedicareNo)%></b></td>
     <td align="right" width="13%" nowrap>State:&nbsp;</td>
     <td><b><%=Utilities.getValue(glInfo.MedicareState)%></b></td>
 </tr>
<%
     if (Utilities.getValueLength(glInfo.MedicareCard)>0) {
         String[] arFilename = glInfo.MedicareCard.split(",");
         StringBuffer sb = new StringBuffer();
         for (int i=0; i<arFilename.length; i++) {
            sb.append("&nbsp; &nbsp;");
//            String imageUrl =  sRootUrl + "&filename=" +arFilename[i];
            String imageUrl =  sRootUrl + "&index=" + (i+1) + "&card=medicare";
            sb.append("<a href='" + imageUrl +"' target='_ImageWin'  title='View Image'><img src='" + imageUrl + "' width='100' border='1'  alt='View Image'></a>");
         }
//System.out.println(sb.toString());
 %>
 <tr><td colspan="6">Uploaded Medicare Card(s):&nbsp; <%=sb.toString()%></td></tr>
<% } %>

<% } else if (glInfo.BillType==GeneralInfo.ABillType.Insurance.GetValue()){ %>
 <tr>
     <td align="right" width="13%" nowrap>Policyholder Name:&nbsp;</td>
     <td width="20%"><b><%=Utilities.getValue(glInfo.PolicyName)%></b></td>
     <td align="right" width="13%" nowrap>DOB (MM/DD/YY):&nbsp;</td>
     <td width="21%"><b><%=Utilities.getValue(glInfo.HolderDOB)%></b></td>
     <td align="right" width="13%" nowrap>Phone Number:&nbsp;</td>
     <td width="20%"><b><%=Utilities.getValue(glInfo.HolderPhone)%></b></td>
 </tr>
<tr>
    <td align="right" width="13%" nowrap>Insurance Co.:&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValue(glInfo.InsureanceCo)%></b></td>
    <td align="right" width="13%" nowrap>Memeber ID:&nbsp;</td>
    <td width="21%"><b><%=Utilities.getValue(glInfo.MemberID)%></b></td>
    <td align="right" width="13%" nowrap>Group No.:&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValue(glInfo.GroupNo)%></b></td>
</tr>
<%
   if (Utilities.getValueLength(glInfo.InsuranceCard)>0) {
   String[] arFilename = glInfo.InsuranceCard.split(",");
   StringBuffer sb = new StringBuffer();
   for (int i=0; i<arFilename.length; i++) {
      sb.append("&nbsp; &nbsp;");
      String imageUrl =  sRootUrl + "&index=" + (i+1) + "&card=insurance";
      sb.append("<a href='" + imageUrl +"' target='_ImageWin'  title='View Image'><img src='" + imageUrl + "' width='100' border='1'  alt='View Image'></a>");
   }
//System.out.println(sb.toString());
%>
<tr><td colspan="6">Uploaded Insurance Card(s):&nbsp; <%=sb.toString()%></td></tr>
<% } %>
<% } else if (glInfo.BillType==GeneralInfo.ABillType.CreditCardPayment.GetValue()){ %>
<tr>
    <td align="right" width="13%" nowrap>Name on Credit Card.:&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValue(glInfo.CreditName)%></b></td>
    <td align="right" width="13%" nowrap>Credit Card Type:&nbsp;</td>
    <td width="21%"><b><%=Utilities.getValue(glInfo.CreditType)%></b></td>
    <td align="right" width="13%" nowrap>Credit No.:&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValueLength(glInfo.CreditNo)>4?("*-"+glInfo.CreditNo.substring(glInfo.CreditNo.length()-4)):""%></b></td>
</tr>
<tr>
    <td align="right" width="13%" nowrap>Expiration Month.:&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValue(glInfo.ExpireMonth)%></b></td>
    <td align="right" width="13%" nowrap>Expiration Year:&nbsp;</td>
    <td width="21%"><b><%=Utilities.getValue(glInfo.ExpireYear)%></b></td>
    <td align="right" width="13%" nowrap>Verification No.:&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValue(glInfo.CSid)%></b></td>
</tr>
<% } else { %>
<tr>
    <td align="right" width="13%" nowrap>Billing Status:&nbsp;</td>
    <td colspan="5"><b><%=glInfo.TotalPay<=0?"Not Yet":"Paid Online"%></b></td>
</tr>
<% } %>

</table>
<% } %>
<hr style="border: 1px dashed">
<p>
<font size="3"><i>Informed Consent:</i></font>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
<tr>
    <td align="right" width="13%" nowrap>First Name:&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValue(trInfo.glInfo.FirstName)%></b></td>
    <td align="right" width="13%" nowrap>Last Name:&nbsp;</td>
    <td width="21%"><b><%=Utilities.getValue(Utilities.getValue(trInfo.glInfo.LastName))%></b></td>
    <td align="right" width="13%" nowrap>DOB (MM/DD/YYYY):&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValue(trInfo.glInfo.BirthDay)%></b></td>
</tr>
<%
    String specimens = "";
    if (ctInfo.Specimens==1)
       specimens = "Yes";
    else if (ctInfo.Specimens==2)
       specimens = "No";
%>
<tr>
   <td colspan="6">&nbsp;Consent to the use of my sample for anonymous research: &nbsp;<b><%=specimens%></b></td>
</tr>
    <tr>
        <td align="right" width="13%" nowrap>Patient's Signature:&nbsp;</td>
        <td width="37%">
            <% if (Utilities.getValueLength(glInfo.PatientSign2)>10 && glInfo.PatientSign2.indexOf("lines")==2) { %>
            <img src='<%=sImageGetUrl%>&type=Vector&data=Patient2&te=<%=Calendar.getInstance().getTime().getTime()%>' height="46">
            <% } else { %>
            <b><%=Utilities.getValue(glInfo.PatientSign2)%></b>
            <% } %>
        </td>
        <td align="right" width="13%" nowrap>Date:&nbsp;</td>
        <td colspan="3"><b><%=Utilities.getValue(glInfo.SignDate2)%></b></td>
    </tr>
  <tr>
   <td colspan="6" align="center" height="36" valign="bottom"><font color="3"><b>Statement of Medical Necessity</b></font></td>
</tr>
<tr>
 <td colspan="6">I have supplied information to the patient regarding genetic testing and the patient has given consent for genetic testing to be performed. I further confirm that this test is medically necessary for the diagnosis, detection of a disease, illness, impairment, symptom, syndrome or disorder, and the results will be used in the medical management and treatment decisions for the patient. I confirm that I am authorized by law to order the test(s) requested herein.</td>
</tr>
<tr>
 <td colspan="6">
  <table width="100%">
  <tr>
      <td align="right" width="17%" height="40">Physician Name: &nbsp;</td>
      <td width="20%"> ________________________</td>
      <td width="14%" align="right">Signature: &nbsp;</td>
      <td width="20%"> ________________________ </td>
      <td align="right" width="10%">Date: &nbsp;</td>
      <td> _________________ </td>
  </tr>
  </table>
 </td>
</tr>
</table>