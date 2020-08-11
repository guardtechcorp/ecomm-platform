<%
    GeneralInfo glInfo = trInfo.getGeneral(0);
    CancerInfo ccInfo = trInfo.getCarcer(0);
    ConsentInfo ctInfo = trInfo.getConcent(0);
    List<HistoryInfo> ltHistory = trInfo.getHistory(0);
    String jsId2 = request.getParameter("JSID");

    String sRootUrl = "";
    if ("GetSummary".equalsIgnoreCase(request.getParameter("action"))||"pdf".equalsIgnoreCase(request.getParameter("output")))
    {
        sRootUrl = "http://localhost:8080";
        if (RequisitionWeb.getHttpsUrl()!=null)
           sRootUrl += "/ctr";
    }

    if (Utilities.getValueLength(jsId2)==0)
       jsId2 = session.getId();
    sRootUrl += "/Clinician?action=GetImage&id=" + glInfo.ID + "&customerid=" + glInfo.CustomerID +  "&JSID=" + jsId2 + "&te=" + java.util.Calendar.getInstance().getTime().getTime();
%>
<table width="100%">
<tr>
 <td height="30"><font size="3"><i>Patient Information:</i></font></td>
 <td align="right">Request Code: <font size="3" color='#f39f53'><b><%=Utilities.getValue(glInfo.RequestCode).toUpperCase()%></b>&nbsp;</font></td>
</tr>
</table>
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
       <td width="13%" align="right">Phone:</td>
       <td width="37%"><b><%=Utilities.getValue(glInfo.Phone)%></b></td>
       <td width="13%" align="right">E-Mail:</td>
       <td width="37%"><b><%=Utilities.getValue(glInfo.EMail)%></b></td>
      </tr>
    </table>
   </td>
 </tr>
</table>
<p>
<font size="3"><i>Refering Physician Information:</i></font>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
<tr>
 <td align="right" width="13%" nowrap>Name:&nbsp;</td>
 <td width="20%"><b><%=Utilities.getValue(glInfo.Phy_Name)%></b></td>
 <td align="right" width="13%" nowrap>Provider NPI#:&nbsp;</td>
  <td width="21%"><b><%=Utilities.getValue(glInfo.ProviderNpi)%></b></td>
 <td align="right" width="13%" nowrap>Institution Name:&nbsp;</td>
  <td width="20%"><b><%=Utilities.getValue(glInfo.Institution)%></b></td>
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
<tr>
    <td colspan="6">
     <table width="100%">
       <tr>
        <td width="20%" align="right">Reporting Method:&nbsp;</td>
        <td width="30%"><b><%=Utilities.getValue(GeneralInfo.AReportMethod.GetNameByValue(glInfo.ReportMethod))%></b></td>
        <td width="20%" align="right">Counselor/Recipient:&nbsp;</td>
        <td width="30%"><b><%=Utilities.getValue(glInfo.Recipient)%></b></td>
       </tr>
     </table>
    </td>
</tr>
</table>
<p>
<font size="3"><i>Sample Information:</i></font>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
<tr>
    <td align="right" width="13%" nowrap>Date Collected:&nbsp;</td>
    <td width="20%"><b><%=Utilities.getValue(glInfo.DateCollect)%></b></td>
    <td align="right" width="13%" nowrap>Sample Type:&nbsp;</td>
    <td colspan="3"><b><%=Utilities.getValue(GeneralInfo.ASampleType.GetNamesByValue(glInfo.SampleType))%></b></td>
</tr>
<tr>
    <td width="35%" nowrap align="right">&nbsp;The pattient has following situation(s):</td>
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
<% } else if (glInfo.BillType==GeneralInfo.ABillType.OnlinePay.GetValue()){ %>
  <tr>
      <td align="right" width="13%" nowrap>Online Payment:&nbsp;</td>
      <td colspan="5"><b><%=glInfo.TotalPay>0?"Paid":"Not Yet"%></b></td>
  </tr>
<% } %>

<% if (RequisitionWeb.tryEligibility(trInfo)){ %>
<tr>
    <td colspan="6" align="center" height="28" style="border-top: 1px solid #cccccc"><i>Patient Acknowledgement for Financial Responsibility</i></td>
</tr>
<tr>
    <td align="right" width="13%" nowrap>Patient's Signature:&nbsp;</td>
    <td width="21%" colspan="2">
<% if (Utilities.getValueLength(glInfo.PatientSign)>10 && glInfo.PatientSign.indexOf("lines")==2) { %>
<img src='<%=sRootUrl%>&type=Vector&data=Patient&te=<%=Calendar.getInstance().getTime().getTime()%>' height="46">
<% } else { %>
<b><%=Utilities.getValue(glInfo.PatientSign)%></b>
<% } %>
    </td>
    <td align="right" width="13%" nowrap>Date:&nbsp;</td>
    <td colspan="3"><b><%=Utilities.getValue(glInfo.SignDate)%></b></td>
</tr>
<% } %>
</table>
 <p>
 <font size="3"><i>Informed Consent and Statement of Medical Necessity:</i></font>
 <table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
     <tr>
         <td align="right" width="13%" nowrap>Physician's Signature:&nbsp;</td>
         <td width="21%" colspan="2">
<% if (Utilities.getValueLength(glInfo.Phy_Sign)>10 && glInfo.Phy_Sign.indexOf("{\"lines\":")>=0) { %>
<img src='<%=sRootUrl%>&type=Vector&data=Physician&te=<%=Calendar.getInstance().getTime().getTime()%>' height="44">
 <% } else if (Utilities.getValueLength(glInfo.Phy_Sign)>3) { %>
 <img src='<%=sRootUrl%>&card=physciansign&te=<%=Calendar.getInstance().getTime().getTime()%>' height="44">
 <% } %>
         </td>
         <td align="right" width="13%" nowrap>Date:&nbsp;</td>
         <td width="20%" colspan="2"><b><%=Utilities.getValue(glInfo.Phy_SignDate)%></b></td>
     </tr>     
 </table>
 <hr style="border: 1px dashed">
<p>
 <font size="3"><i>Test Ordering Requests:</i></font>
<% if ((glInfo.TestType&GeneralInfo.ATestType.Cancer.GetValue())>0) { %>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
 <tr>
   <td align="center"><b>Cancer Test</b></td>
 </tr>
<%  if (glInfo.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>

 <% if (glInfo.Comprehensive>0) { %>
 <tr bgcolor="#eeeeee">
   <td>&nbsp;Comprehensive Cancer Panels:</td>
 </tr>
 <tr>
  <td>
  <ul>
<% if ((glInfo.Comprehensive&CancerInfo.ACompreh.IGENE.GetValue())!=0) { %>
  <li>9001 iGene Cancer Panel (23 gene focus panel)</li>
<% } %>
<% if ((glInfo.Comprehensive&CancerInfo.ACompreh.Hereditary.GetValue())!=0) { %>
 <li>2015 Comprehensive Hereditary Cancer Panel (119 gene expanded panel)</li>
<% } %>
  </ul>
  </td>
 </tr>
<% } %>

<% if (glInfo.Specialty>0) { %>
  <tr bgcolor="#eeeeee">
    <td>&nbsp;Specialty Panels:</td>
  </tr>
  <tr>
   <td>
   <ul>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.BRCA.GetValue())!=0) { %>
   <li>2001 BRCA1 and BRCA2 Sequencing Panel (2 genes)</li>
<% } %>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.Breast.GetValue())!=0) { %>
  <li>2005 Breast Cancer Core Panel (7 genes)</li>
<% } %>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.Gynecologic.GetValue())!=0) { %>
  <li>2011 Breast and Gynecologic Cancer Expanded Panel (35 genes)</li>
<% } %>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.Colorectal1.GetValue())!=0) { %>
  <li>2021 Colorectal Cancer Core Panel (12 genes)</li>
<% } %>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.Colorectal2.GetValue())!=0) { %>
 <li>2025 Colorectal Cancer Expanded Panel (24 genes)</li>
<% } %>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.Melanoma.GetValue())!=0) { %>
 <li>2045 Melanoma Panel (53 genes)</li>
<% } %>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.Lung.GetValue())!=0) { %>
 <li>2041 Lung Cancer Panel</li>
<% } %>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.Pancreatic.GetValue())!=0) { %>
<li>2035 Pancreatic Cancer Panel (31 genes)</li>
<% } %>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.Prostate.GetValue())!=0) { %>
<li>2031 Prostate Cancer Panel (12 genes)</li>
<% } %>
<% if ((glInfo.Specialty&CancerInfo.ASpecialty.Paraganglioma.GetValue())!=0) { %>
<li>2051 Paraganglioma-Pheochromocytoma Panel (12 genes)</li>
<% } %>      
   </ul>
   </td>
  </tr>
<% } %>

<% } else { %>
<tr>
  <td>
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
    <li>9001 iGene Cancer Panel (23 gene focus panel) -- $<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_1")%></li>
  <% } %>
  <% if ((glInfo.CancerPanel&2)!=0) {
      fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_2"), 0);
  %>
  <li>2021 Colorectal Cancer Core Panel (12 genes) -- $<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_2")%></li>
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
   <li>9002 iGene Cardiac Panel (22 gene focus panel) -- $<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "Cardiovascular_1")%></li>
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
   <li>1100 Comprehensive Pharmacogenomics (PGx) Panel -- $<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_1")%></li>
  <% } %>
  <% if ((glInfo.DrugSensitivity&2)!=0) {
      fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_2"), 0);
  %>
  <li>1110 Pain Management PGx Panel -- $<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_2")%></li>
  <% } %>
  <% if ((glInfo.DrugSensitivity&4)!=0) {
      fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_4"), 0);
  %>
  <li>1120 Mental Health PGx Panel -- $<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_4")%></li>
  <% } %>
  <% if ((glInfo.DrugSensitivity&8)!=0) {
      fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_8"), 0);
  %>
   <li>1130 Cardiovascular Health PGx Panel -- $<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_8")%></li>
  <% } %>
  <% if ((glInfo.DrugSensitivity&16)!=0) {
      fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_16"), 0);
  %>
    <li>1130 Cardiovascular Health PGx Panel -- $<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_16")%></li>
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
  <% if ((glInfo.OtherRisk&1)!=0) {
      fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_1"), 0);
  %>
   <li>1500 Clinical Focused Exome (6110 genes)  -- $<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_1")%></li>
  <% } %>

   </ul>
   </td>
  </tr>
  <% } %>
   <tr>
     <td align="right">
       Total:&nbsp;&nbsp; <font color="red" size="3">$<%=Utilities.getNumberFormat(fTotal, 'N', 0)%></font> &nbsp;&nbsp;
     </td>
   </tr>
  </table>
  </td>
</tr>
<% } %>

<tr bgcolor="#eeeeee">
  <td>&nbsp;Patient Clinical and Family Cancer History:</td>
</tr>

<tr>
  <td>

<% if (ccInfo.BreastCheck>0) { %>
  <table width="100%"  style="border: 1px solid #cccccc">
   <td width="25%" align="center" style="border-right: 1px solid #cccccc">Brasst Cancer</td>
   <td>
       <table width="100%">
        <tr>
          <td height="32">
           &nbsp;Age of Diagnosis:&nbsp;<b><%=Utilities.getValue(ccInfo.Breastage)%></b>
           &nbsp;&nbsp;Triple negative:&nbsp;<b><%=three(ccInfo.BreastNegative)%></b>
          </td>
        </tr>
        <tr>
         <td height="28">
             &nbsp;An additional primary breast cancer:&nbsp;<b><%=three(ccInfo.Breast2nd)%></b>
             &nbsp;&nbsp;Ethnicity:&nbsp;<b><%=three(ccInfo.Ethnicity, "", "Ashkenazi Jewish", "Non Ashkenazi Jewish")%></b>
         </td>
        </tr>
<% if (Utilities.getValueLength(ccInfo.BreastCode)>0) {
     List<String> ltCode = RequisitionWeb.getDiagnosticCode("Breast");
%>
        <tr>
         <td>&nbsp;ICD-10 Diagnostic Code:&nbsp;<b>
          <ul>
<%  for (int i=0; i<ltCode.size(); i++) {
       String sCodedesc = ltCode.get(i);
       int nDash = sCodedesc.indexOf("-");
       String sCode = sCodedesc.substring(0, nDash).trim();
       if (isIncludeIt(ccInfo.BreastCode, sCode)) {
%>
          <li><%=sCodedesc%></li>
<% } %>

<% } %>
       </ul>
       </b>
       </td>
      </tr>
<% } %>
       <tr><td height="2"></td></tr>
      </table>
  </td>
 </table>
<% } %>

<% if (ccInfo.ColorectCheck>0) { %>
  <table width="100%" style="border: 1px solid #cccccc">
   <td width="25%" align="center" style="border-right: 1px solid #cccccc">Colorectal</td>
   <td>
       <table width="100%">
        <tr>
          <td height="32">
           &nbsp;Age of Diagnosis:&nbsp;<b><%=Utilities.getValue(ccInfo.ColorectAge)%></b>
           &nbsp;&nbsp;Had>20 cumulative colorectal adenomatous polyps:&nbsp;<b><%=three(ccInfo.ColorectPolyps)%></b>
          </td>
        </tr>
        <tr>
         <td height="28">
             &nbsp;Positive result for MSI or IHC:&nbsp;<b><%=three(ccInfo.ColorectResult)%></b>
             &nbsp;&nbsp;Known Lynch Syndrome in family:&nbsp;<b><%=three(ccInfo.ColorectLynch)%></b>
         </td>
        </tr>
<% if (Utilities.getValueLength(ccInfo.ColorectCode)>0) {
     List<String> ltCode = RequisitionWeb.getDiagnosticCode("Colorectal");
%>
        <tr>
         <td>&nbsp;ICD-10 Diagnostic Code:&nbsp;<b>
          <ul>
<%  for (int i=0; i<ltCode.size(); i++) {
       String sCodedesc = ltCode.get(i);
       int nDash = sCodedesc.indexOf("-");
       String sCode = sCodedesc.substring(0, nDash).trim();
       if (isIncludeIt(ccInfo.ColorectCode, sCode)) {
%>
          <li><%=sCodedesc%></li>
<% } %>
<% } %>
       </ul>
       </b>
       </td>
      </tr>
<% } %>
       <tr><td height="2"></td></tr>
      </table>
  </td>
 </table>
 <% } %>

<% if (ccInfo.EndometCheck>0) { %>
  <table width="100%" style="border: 1px solid #cccccc">
   <td width="25%" align="center" style="border-right: 1px solid #cccccc">Endometrial Cancer</td>
   <td>
       <table width="100%">
        <tr>
          <td height="32">
           &nbsp;Age of Diagnosis:&nbsp;<b><%=Utilities.getValue(ccInfo.EndometAge)%></b>
          </td>
        </tr>
<% if (Utilities.getValueLength(ccInfo.EndometCode)>0) {
     List<String> ltCode = RequisitionWeb.getDiagnosticCode("Endometrial");
%>
        <tr>
         <td>&nbsp;ICD-10 Diagnostic Code:&nbsp;<b>
          <ul>
<%  for (int i=0; i<ltCode.size(); i++) {
       String sCodedesc = ltCode.get(i);
       int nDash = sCodedesc.indexOf("-");
       String sCode = sCodedesc.substring(0, nDash).trim();
       if (isIncludeIt(ccInfo.EndometCode, sCode)) {
%>
          <li><%=sCodedesc%></li>
<% } %>
<% } %>
       </ul>
       </b>
       </td>
      </tr>
<% } %>
       <tr><td height="2"></td></tr>
      </table>
  </td>
 </table>
 <% } %>

<% if (ccInfo.OvarianCheck>0) { %>
  <table width="100%" style="border: 1px solid #cccccc">
   <td width="25%" align="center" style="border-right: 1px solid #cccccc">Ovarian Cancer</td>
   <td>
       <table width="100%">
        <tr>
          <td height="32">
           &nbsp;Age of Diagnosis:&nbsp;<b><%=Utilities.getValue(ccInfo.OvarianAge)%></b>
          </td>
        </tr>
<% if (Utilities.getValueLength(ccInfo.OvarianCode)>0) {
     List<String> ltCode = RequisitionWeb.getDiagnosticCode("Ovarian");
%>
        <tr>
         <td>&nbsp;ICD-10 Diagnostic Code:&nbsp;<b>
          <ul>
<%  for (int i=0; i<ltCode.size(); i++) {
       String sCodedesc = ltCode.get(i);
       int nDash = sCodedesc.indexOf("-");
       String sCode = sCodedesc.substring(0, nDash).trim();
       if (isIncludeIt(ccInfo.OvarianCode, sCode)) {
%>
          <li><%=sCodedesc%></li>
<% } %>
<% } %>
       </ul>
       </b>
       </td>
      </tr>
<% } %>
       <tr><td height="2"></td></tr>
      </table>
  </td>
 </table>
 <% } %>

<% if (ccInfo.PancreatCheck>0) { %>
  <table width="100%" style="border: 1px solid #cccccc">
   <td width="25%" align="center" style="border-right: 1px solid #cccccc">Pancreatic Cancer</td>
   <td>
       <table width="100%">
        <tr>
          <td height="32">
           &nbsp;Age of Diagnosis:&nbsp;<b><%=Utilities.getValue(ccInfo.PancreatAge)%></b>
          </td>
        </tr>
<% if (Utilities.getValueLength(ccInfo.PancreatCode)>0) {
     List<String> ltCode = RequisitionWeb.getDiagnosticCode("Pancreatic");
%>
        <tr>
         <td>&nbsp;ICD-10 Diagnostic Code:&nbsp;<b>
          <ul>
<%  for (int i=0; i<ltCode.size(); i++) {
       String sCodedesc = ltCode.get(i);
       int nDash = sCodedesc.indexOf("-");
       String sCode = sCodedesc.substring(0, nDash).trim();
       if (isIncludeIt(ccInfo.PancreatCode, sCode)) {
%>
          <li><%=sCodedesc%></li>
<% } %>
<% } %>
       </ul>
       </b>
       </td>
      </tr>
<% } %>
       <tr><td height="2"></td></tr>
      </table>
  </td>
 </table>
 <% } %>

<% if (ccInfo.ProstateCheck>0) { %>
  <table width="100%" style="border: 1px solid #cccccc">
   <td width="25%" align="center" style="border-right: 1px solid #cccccc">Prostate Cancer</td>
   <td>
       <table width="100%">
        <tr>
          <td height="32">
           &nbsp;Age of Diagnosis:&nbsp;<b><%=Utilities.getValue(ccInfo.ProstateAge)%></b>
           &nbsp;Gleason score >= 7:&nbsp;<b><%=three(ccInfo.GleasonScore)%></b>
          </td>
        </tr>
<% if (Utilities.getValueLength(ccInfo.ProstateCode)>0) {
     List<String> ltCode = RequisitionWeb.getDiagnosticCode("Prostate");
%>
        <tr>
         <td>&nbsp;ICD-10 Diagnostic Code:&nbsp;<b>
          <ul>
<%  for (int i=0; i<ltCode.size(); i++) {
       String sCodedesc = ltCode.get(i);
       int nDash = sCodedesc.indexOf("-");
       String sCode = sCodedesc.substring(0, nDash).trim();
       if (isIncludeIt(ccInfo.ProstateCode, sCode)) {
%>
          <li><%=sCodedesc%></li>
<% } %>
<% } %>
       </ul>
       </b>
       </td>
      </tr>
<% } %>
       <tr><td height="2"></td></tr>
      </table>
  </td>
 </table>
 <% } %>

<% if (ccInfo.OtherCheck>0) { %>
  <table width="100%" style="border: 1px solid #cccccc">
   <td width="25%" align="center" style="border-right: 1px solid #cccccc">Other Cancers</td>
   <td>
       <table width="100%">
        <tr>
          <td height="32">
           &nbsp;Age of Diagnosis:&nbsp;<b><%=Utilities.getValue(ccInfo.OtherAge)%></b>
          </td>
        </tr>
<% if (Utilities.getValueLength(ccInfo.OtherCode)>0) {
     List<String> ltCode = RequisitionWeb.getDiagnosticCode("Others");
%>
        <tr>
         <td>&nbsp;ICD-10 Diagnostic Code:&nbsp;<b>
          <ul>
<%  for (int i=0; i<ltCode.size(); i++) {
       String sCodedesc = ltCode.get(i);
       int nDash = sCodedesc.indexOf("-");
       String sCode = sCodedesc.substring(0, nDash).trim();
       if (isIncludeIt(ccInfo.OtherCode, sCode)) {
%>
          <li><%=sCodedesc%></li>
<% } %>
<% } %>
       </ul>
       </b>
       </td>
      </tr>
<% } %>
       <tr>
         <td height>
          &nbsp;Other unlisted ICD-10 diagnostic codes:&nbsp;<b><%=Utilities.getValue(ccInfo.OtherMore)%></b>
         </td>
       </tr>
       <tr><td height="2"></td></tr>
      </table>
  </td>
 </table>
 <% } %>
 </td>
</tr>
<%
    List<TestResultInfo> ltTestResult = trInfo.getTestResult(trInfo.glInfo.ID, TestResult.TYPE_TESTRESULT);
    if (ltTestResult.size()>0) {
%>
<tr>
  <td height="28" style="border-top: 1px solid #cccccc">&nbsp;&nbsp;Previous genetic testing (of patient's or family members'):</td>
</tr>
<tr>
  <td>
   <table width="100%">
<% for (int i=0; i<ltTestResult.size(); i++) {
      TestResultInfo ttInfo = ltTestResult.get(i);
%>
   <tr>
     <td height="28" width="50%">&nbsp;&nbsp;Test: <b><%=Utilities.getValue(ttInfo.Title)%></b></td>
     <td>&nbsp;&nbsp;Result: <b><%=Utilities.getValue(ttInfo.Description)%></b></td>
   </tr>
<% } %>
   </table>
  </td>
</tr>
<% } %>

<% if (ltHistory!=null && ltHistory.size()>0) { %>
 <tr>
  <td>
      <table width="100%" align="center" style="border: 1px solid #cccccc">
      <tr>
        <td height="28" align="center" colspan="5">FAMILY HISTORY</td>
      </tr>
      <tr bgcolor="#eeeeee" style="border: 1px solid #cccccc">
        <td height="32" width="16%" align="center" style="border-right: 1px solid #cccccc">Affected Relative's Initial</td>
        <td height="26" width="14%" align="center" style="border-right: 1px solid #cccccc">Relationship</td>
        <td width="13%" align="center"  style="border-right: 1px solid #cccccc">Side of Parents</td>
        <td width="36%" align="center"  style="border-right: 1px solid #cccccc">Type of Cancer</td>
        <td width="14%" align="center">Age of Diagnosis/Onset</td>
      </tr>
      <%
         for (int nIndex=0; nIndex<ltHistory.size(); nIndex++) {
             String initial = null;
             String rShip = null;
             String pSide = null;
             String cType = null;
             String oType = null;
             String dAge = null;
             if (nIndex<ltHistory.size())
             {
                HistoryInfo hyInfo = ltHistory.get(nIndex);
                initial = hyInfo.Initial;
                rShip = hyInfo.Relationship;
                pSide = hyInfo.ParentSide;
                cType = Utilities.makeFirstWordLetterUpper(Utilities.getValue(hyInfo.CancerType));
                oType = hyInfo.OtherType;
                dAge = hyInfo.DiagnosisAge;
             }
      %>
      <tr style="border: 1px solid #cccccc">
        <td height="28" align="center" style="border-right: 1px solid #cccccc"><b><%=Utilities.getValue(initial)%></b></td>
        <td align="center" style="border-right: 1px solid #cccccc"><b><%=Utilities.getValue(rShip)%></b></td>
        <td align="center" style="border-right: 1px solid #cccccc"><b><%=Utilities.getValue(pSide)%></b></td>
        <td align="center" style="border-right: 1px solid #cccccc"><b><%=Utilities.getValueLength(oType)>0?oType:Utilities.getValue(cType)%></b></td>
        <td align="center"><b><%=Utilities.getValue(dAge)%></b></td>
      </tr>
      <% } %>
      </table>
  </td>
 </tr>
<% } %>
</table>
<% } %>

<% if (hasBit(glInfo.TestType, GeneralInfo.ATestType.Cardiology.GetValue())) { %>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
 <tr>
   <td align="center"><b>Cardiology Test</b></td>
 </tr>

<% if (glInfo.Cardiovascular>0) { %>
<tr bgcolor="#eeeeee">
<td>&nbsp;Comprehensive Cardiovascular Panels</td>
</tr>
<tr>
<td>
<ul>
<% if (hasBit(glInfo.Cardiovascular, CardiologyInfo.ACardiovas.Igene.GetValue())) { %>
<li>9002 iGene Cardiac Panel (22 gene focus panel)</li>
<% } %>
<% if (hasBit(glInfo.Cardiovascular, CardiologyInfo.ACardiovas.Arrhythmia.GetValue())) { %>
<li>3015 Cardiomyopathy and Arrhythmia Panel (101 genes)</li>
<% } %>
<% if (hasBit(glInfo.Cardiovascular, CardiologyInfo.ACardiovas.Pan.GetValue())) { %>
<li>3011 Pan-Cardio Panel (410 genes)</li>
<% } %>
</ul>
 </td>
</tr>
<% } %>
<% if (glInfo.Cardiomyopathy>0) { %>
<tr bgcolor="#eeeeee">
  <td>&nbsp;Cardiomyopathy Panels</td>
</tr>
 <tr>
 <td>
  <ul>
 <% if (hasBit(glInfo.Cardiomyopathy, CardiologyInfo.ACardiomy.Dilated.GetValue())) { %>
   <li>3001 Dilated Cardiomyopathy Panel (33 genes)</li>
 <% } %>
 <% if (hasBit(glInfo.Cardiomyopathy, CardiologyInfo.ACardiomy.Hypertro.GetValue())) { %>
   <li>3002 Hypertrophic Cardiomyopathy Panel (18 genes)</li>
 <% } %>
 <% if (hasBit(glInfo.Cardiomyopathy, CardiologyInfo.ACardiomy.Compreh.GetValue())) { %>
   <li>3003 Comprehensive Cardiomyopathy Panel (44 genes)</li>
 <% } %>
 </td>
</tr>
<% } %>
<% if (glInfo.Arrhythmia>0) { %>
<tr bgcolor="#eeeeee">
<td>&nbsp;Arrhythmia Panels</td>
</tr>
<tr>
<td>
<ul>
<% if (hasBit(glInfo.Arrhythmia, CardiologyInfo.AArrhythmia.Arrhythmias.GetValue())) { %>
<li>3021 Arrhythmias Panel (101 genes)</li>
<% } %>
<% if (hasBit(glInfo.Arrhythmia, CardiologyInfo.AArrhythmia.Atrial.GetValue())) { %>
<li>3025 Atrial Fibrillation Panel (47 genes)</li>
<% } %>
<% if (hasBit(glInfo.Arrhythmia, CardiologyInfo.AArrhythmia.Long.GetValue())) { %>
<li>3031 Long QT Syndrome Panel (20 genes)</li>
<% } %>
<% if (hasBit(glInfo.Arrhythmia, CardiologyInfo.AArrhythmia.Sudden.GetValue())) { %>
<li>3045 Sudden Death Syndrome Panel (68 genes)</li>
<% } %>
</ul>
 </td>
</tr>
<% } %>
<% if (glInfo.Aortopathy>0) { %>
<tr bgcolor="#eeeeee">
<td>&nbsp;Aortopathy and Aneurysm Panels</td>
</tr>
<tr>
<td>
<ul>
<% if (hasBit(glInfo.Aortopathy, CardiologyInfo.AAortopathy.Marfan.GetValue())) { %>
<li>3035 Marfan Syndrome and Thoracic Aortic Aneurysm and Dissection Panel (17 genes)</li>
<% } %>
<% if (hasBit(glInfo.Aortopathy, CardiologyInfo.AAortopathy.Connective.GetValue())) { %>
<li>3055 Connective Tissue Disorder Panel (39 genes)</li>
<% } %>
</ul>
 </td>
</tr>
<% } %>
<% if (glInfo.OtherOption>0) { %>
<tr bgcolor="#eeeeee">
<td>&nbsp;Other Cardiovascular Testing Options</td>
</tr>
<tr>
<td>
<ul>
<% if (hasBit(glInfo.OtherOption, CardiologyInfo.AOther.Familial.GetValue())) { %>
<li>3050 Familial Hypercholesterolemia Panel (4 genes)</li>
<% } %>
<% if (hasBit(glInfo.OtherOption, CardiologyInfo.AOther.Pulmonary.GetValue())) { %>
<li>3041 Pulmonary Hypertension Panel (9 genes)</li>
<% } %>
<% if (hasBit(glInfo.OtherOption, CardiologyInfo.AOther.Thrombophilia.GetValue())) { %>
<li>1140 Thrombophilia Panel</li>
<% } %>
</ul>
 </td>
</tr>
<% } %>
    
 <tr>
 <td>
   <table width="100%" align="center" style="border: 1px solid #cccccc">
 <% if (Utilities.getValueLength(ccInfo.CardDiagnosis)>0||Utilities.getValueLength(ccInfo.CardiOther)>0) {
       List<String> ltCode = RequisitionWeb.getDiagnosticCode("Cardiology");
  %>
      <tr>
       <td style="border: 1px solid #cccccc">&nbsp;This patient has a diagnosis of or is strongly suspected to have:&nbsp;<b>
        <ul>
  <%  for (int i=0; i<ltCode.size(); i++) {
         String sCodedesc = ltCode.get(i);
         int nDash = sCodedesc.indexOf("-");
         String sCode = sCodedesc.substring(0, nDash).trim();
         if (isIncludeIt(ccInfo.CardDiagnosis, sCode)) {
  %>
            <li><%=sCodedesc.substring(nDash+1).trim()%></li>
        <% } %>
  <% } %>
    <% if (Utilities.getValueLength(ccInfo.CardiOther)>0) { %>
         <li><%=ccInfo.CardiOther%></li>
    <% } %>
     </ul>
     </b>
     </td>
    </tr>
<% } %>

   <tr>
    <td height="30">&nbsp;&nbsp;Are the parents of this patient related to each other by blood:&nbsp;<b><%=three(ccInfo.ParentRelated)%></b>
    </td>
   </tr>

<%
   List<TestResultInfo> ltTestResult = trInfo.getTestResult(trInfo.glInfo.ID, TestResult.TYPE_SPECIALFIND);
   if (ltTestResult.size()>0) {
%>
<tr>
 <td height="28">&nbsp;&nbsp;Previous clinical testing or additional clinical findings:</td>
</tr>
<tr>
 <td>
  <table width="100%">
<%
   List<String> ltCode = RequisitionWeb.getDiagnosticCode("Findings");
   for (int i=0; i<ltTestResult.size(); i++) {
     TestResultInfo ttInfo = ltTestResult.get(i);
%>
  <tr>
    <td height="28" width="50%">&nbsp;&nbsp;Finding: <b><%=Utilities.getValue(getDesc(ltCode, ttInfo.Title))%></b></td>
    <td>&nbsp;&nbsp;Special Result: <b><%=Utilities.getValue(ttInfo.Description)%></b></td>
  </tr>
<% } %>
<% } %>

  </table>
 </td>
</tr>
   </table>
 </td>
</tr>
</table>
<% } %>

<% if (hasBit(glInfo.TestType, GeneralInfo.ATestType.PGx.GetValue())) { %>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
 <tr>
   <td align="center"><b>Pharmacogenomics (PGx) Test</b></td>
 </tr>

 <% if (glInfo.Pharmacogenomics>0) { %>
 <tr>
 <td>
 <ul>
 <% if (hasBit(glInfo.Pharmacogenomics, PGxInfo.APharma.Compreh.GetValue())) { %>
 <li>1100 Comprehensive Pharmacogenomics Panel (Full PGx)</li>
 <% } %>
 <% if (hasBit(glInfo.Pharmacogenomics, PGxInfo.APharma.Pain.GetValue())) { %>
 <li>1110 Pain Management PGx Panel</li>
 <% } %>
 <% if (hasBit(glInfo.Pharmacogenomics, PGxInfo.APharma.Mental.GetValue())) { %>
 <li>1120 Mental Health PGx Panel</li>
 <% } %>
 <% if (hasBit(glInfo.Pharmacogenomics, PGxInfo.APharma.Cardiovas.GetValue())) { %>
 <li>1130 Cardiovascular Health PGx Panel</li>
 <% } %>
 <% if (hasBit(glInfo.Pharmacogenomics, PGxInfo.APharma.Thrombophilia.GetValue())) { %>
 <li>1140 Thrombophilia Panel</li>
 <% } %>
 <% if (hasBit(glInfo.Pharmacogenomics, PGxInfo.APharma.Obesity.GetValue())) { %>
 <li>1150 Obesity and Diabetes PGx Panel (DO PGx)</li>
 <% } %>
 </ul>
  </td>
 </tr>
 <% } %>

<tr>
<td>
  <table width="100%" align="center" style="border: 1px solid #cccccc">
<% if (Utilities.getValueLength(ccInfo.Medication)>0||Utilities.getValueLength(ccInfo.MedOther)>0) {
      List<String> ltCode = RequisitionWeb.getDiagnosticCode("Medication");
 %>
     <tr>
      <td style="border: 1px solid #cccccc">&nbsp;The current and/or intended medications include:&nbsp;<b>
       <ul>
 <%  for (int i=0; i<ltCode.size(); i++) {
        String sCodedesc = ltCode.get(i);
        int nDash = sCodedesc.indexOf("-");
        String sCode = sCodedesc.substring(0, nDash).trim();
        if (isIncludeIt(ccInfo.Medication, sCode)) {
 %>
           <li><%=sCodedesc.substring(nDash+1).trim()%></li>
 <% } %>
 <% } %>
   <% if (Utilities.getValueLength(ccInfo.MedOther)>0) { %>
        <li><%=ccInfo.MedOther%></li>
   <% } %>
    </ul>
    </b>
    </td>
   </tr>
 <% } %>

 <% if (Utilities.getValueLength(ccInfo.IcdCode)>0 || Utilities.getValueLength(ccInfo.IcdOther)>0) {
       List<String> ltCode = RequisitionWeb.getDiagnosticCode("DiagnosticCode");
  %>
      <tr>
       <td>&nbsp;The patient's ICD-10 diagnostic codes (clinical diagnosis) include:<b>
        <ul>
  <%  for (int i=0; i<ltCode.size(); i++) {
         String sCodedesc = ltCode.get(i);
         int nDash = sCodedesc.indexOf("-");
         String sCode = sCodedesc.substring(0, nDash).trim();
         if (isIncludeIt(ccInfo.IcdCode, sCode)) {
  %>
            <li><%=sCodedesc.substring(nDash+1).trim()%></li>
<% } %>
<% } %>
    <% if (Utilities.getValueLength(ccInfo.IcdOther)>0) { %>
         <li><%=ccInfo.IcdOther%></li>
    <% } %>
     </ul>
     </b>
     </td>
    </tr>
  <% } %>
</table>
</td>
</tr>
</table>
<% } %>

<% if (hasBit(glInfo.TestType, GeneralInfo.ATestType.Ophthalmology.GetValue())) { %>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
 <tr>
   <td align="center"><b>&nbsp;Ophthalmology Test</b></td>
 </tr>
<% if (glInfo.Ophthalmology>0) { %>
<tr>
<td>
<ul>
<% if (hasBit(glInfo.Ophthalmology, OphthalmologyInfo.AOphtha.Compreh.GetValue())) { %>
<li>6101 Comprehensive Eye Disorder Panel (211 genes)</li>
<% } %>
<% if (hasBit(glInfo.Ophthalmology, OphthalmologyInfo.AOphtha.Macular.GetValue())) { %>
<li>6111 Macular Degeneration Panel (22 genes)</li>
<% } %>
<% if (hasBit(glInfo.Ophthalmology, OphthalmologyInfo.AOphtha.Cone.GetValue())) { %>
<li>6125 Cone Rod Dystrophies Panel (30 genes)</li>
<% } %>
<% if (hasBit(glInfo.Ophthalmology, OphthalmologyInfo.AOphtha.Usher.GetValue())) { %>
<li>6121 Usher Syndrome Panel (20 genes)</li>
<% } %>
<% if (hasBit(glInfo.Ophthalmology, OphthalmologyInfo.AOphtha.Retinitis.GetValue())) { %>
<li>6115 Retinitis Pigmentosa Panel (111 genes)</li>
<% } %>
</ul>
 </td>
</tr>
<% } %>
<% if (Utilities.getValueLength(ccInfo.OphDiagnosis)>0) { %>
<tr>
 <td>
     &nbsp;This patient has a diagnosis of or is strongly suspected to have (please specify diagnosis or ICD-10 code):
     <br><b><%=Utilities.getValue(ccInfo.OphDiagnosis)%></b>
 </td>
</tr>
<% } %>
<% if (Utilities.getValueLength(ccInfo.OphFamily)>0) { %>
<tr>
 <td>
     &nbsp;This patient has a family history of (please specify diagnosis or known familial variant):
     <br><b><%=Utilities.getValue(ccInfo.OphFamily)%></b>
 </td>
</tr>
<% } %>
</table>
<% } %>

<% if (hasBit(glInfo.TestType, GeneralInfo.ATestType.Other.GetValue())) { %>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
 <tr>
   <td align="center"><b>&nbsp;Other Test</b></td>
 </tr>
<% if (glInfo.Other>0) { %>
<tr>
<td>
<ul>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.Obesity.GetValue())) { %>
<li>1210 Comprehensive Obesity and Diabetes Panel (Diabetes + Obesity Genetics)</li>
<% } %>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.Overweight.GetValue())) { %>
<li>1213 Overweight and Obesity Panel (Obesity Genetics)</li>
<% } %>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.Diabetes.GetValue())) { %>
<li>1216 Diabetes and Prediabetes Panel (Diabetes Genetics)</li>
<% } %>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.Relevant.GetValue())) { %>
<li>1220 Obesity and Diabetes and related PGX (Diabetes + Obesity + DO PGx)</li>
<% } %>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.FullPGX.GetValue())) { %>
<li>1230 Obesity and Diabetes and Full PGX (Diabetes + Obesity + Full PGx)</li>
<% } %>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.Clinical.GetValue())) { %>
<li>1500 Clinical Focused Exome (6110 genes)</li>
<% } %>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.Compreh.GetValue())) { %>
<li>8100 Comprehensive Mitochondrial Genome Analysis</li>
<% } %>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.Mitoch.GetValue())) { %>
<li>8300 Mitochondrial Nuclear Gene Panel</li>
<% } %>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.Allinc.GetValue())) { %>
<li>8500 All-inclusive Mitochondrial Disorders Panel (Mitochondrial nuclear gene panel + Mitochondrial Genome)</li>
<% } %>
<% if (hasBit(glInfo.Other, OtherInfo.AOther.MiCopy.GetValue())) { %>
<li>8700 Mitochondrial Copy Number Analysis</li>
<% } %>
</ul>
 </td>
</tr>
<% } %>

<% if (Utilities.getValueLength(ccInfo.OthDiagnosis)>0) { %>
<tr>
 <td>
     &nbsp;This patient has a diagnosis of or is strongly suspected to have (please specify diagnosis or ICD-10 code):
     <b><%=Utilities.getValue(ccInfo.OthDiagnosis)%></b>
 </td>
</tr>
<% } %>
<% if (Utilities.getValueLength(ccInfo.OthFamily)>0) { %>
<tr>
 <td>
     &nbsp;This patient has a family history of (please specify diagnosis or known familial variant):
     <b><%=Utilities.getValue(ccInfo.OthFamily)%></b>
 </td>
</tr>
<% } %>
<% if (ccInfo.ClinicalFor>0) { %>
<tr>
    <td>
        &nbsp;Test clinically for: <b><%=Utilities.getValue(CancerInfo.AClinicalFor.GetNameByValue(ccInfo.ClinicalFor))%></b>
    </td>
</tr>
<% } %>
<% if (Utilities.getValueLength(ccInfo.TypeUsed)>0) { %>
<tr>
    <td>
        &nbsp;Type of treatment/therapy/supplementation is considered or used for this patient:
        <b><%=Utilities.getValue(ccInfo.TypeUsed)%></b>
    </td>
</tr>
<% } %>
<% if (Utilities.getValueLength(ccInfo.WeekTreat)>0) { %>
<tr>
    <td>
        &nbsp;Weeks is this patient into/after the treatment (therapy, supplementation, etc.):
        <b><%=Utilities.getValue(ccInfo.WeekTreat)%></b>
    </td>
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
<img src='<%=sRootUrl%>&type=Vector&data=Patient2&te=<%=Calendar.getInstance().getTime().getTime()%>' height="46">
<% } else { %>
<b><%=Utilities.getValue(glInfo.PatientSign2)%></b>
<% } %>
    </td>
    <td align="right" width="13%" nowrap>Date:&nbsp;</td>
    <td colspan="3"><b><%=Utilities.getValue(glInfo.SignDate2)%></b></td>
</tr>
</table>