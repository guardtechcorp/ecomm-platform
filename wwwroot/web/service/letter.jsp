<%
    GeneralInfo glInfo = trInfo.getGeneral(0);
    CancerInfo ccInfo = trInfo.getCarcer(0);
    List<String> ltCriteria = RequisitionWeb.getCancerCriteria(trInfo);
%>
<table width="100%" class2="table table-striped table-hover" style2="border: 1px solid #cccccc" cellpadding="2" cellspacing="2">
 <tr>
  <td width="3%">Patient:&nbsp;</td>
  <td><b><%=Utilities.getValue(glInfo.LastName)%>, <%=glInfo.FirstName%></b></td>
</tr>
<tr>
  <td></td>
  <td>DOB:&nbsp;&nbsp;<%=glInfo.BirthDay%></td>
</tr>
<% if (glInfo.BillType==GeneralInfo.ABillType.Medicare.GetValue()){ %>
  <tr>
    <td></td>
    <td>Medicare, <%=Utilities.getValue(glInfo.MedicareState)%></td>
  </tr>
 <tr>
   <td></td>
   <td>ID No.:&nbsp;&nbsp;<%=Utilities.getValue(glInfo.MedicareNo)%></td>
 </tr>
<% } else if (glInfo.BillType==GeneralInfo.ABillType.Insurance.GetValue()){ %>
  <tr>
    <td></td>
    <td><%=Utilities.getValue(glInfo.InsureanceCo)%></td>
  </tr>
 <tr>
   <td></td>
   <td>ID No.:&nbsp;&nbsp;<%=Utilities.getValue(glInfo.MemberID)%></td>
 </tr>
<% } %>
 <tr><td height="10"></td></tr>
 <tr>
  <td style="border-bottom: 1px solid lightblue" colspan="2">
    ICD-10 Diagnostic Codes: <b><%=Utilities.getValue(RequisitionWeb.getAllSelectedCode(trInfo).replaceAll(",", ", "))%></b>
    <br>Possible CPT Codes:
<% if (glInfo.LetterType==RequisitionWeb.LETTER_Breast) { %>
      <i>81201, 81211, 81213, 81292, 81295, 81298, 81317, 81321, 81404, 81405, 81406, 81408, 81432, 81479</i>
<% } else if (glInfo.LetterType==RequisitionWeb.LETTER_Colorectal) { %>
      <i>81201, 81292, 81295, 81298, 81317, 81321, 81405, 81406, 81435, 81479</i>
<% } %>
  </td>
 </tr>
 <tr>
   <td colspan="2"><br>
    I am writing this letter to request medically necessary genetic testing on behalf of my patient, <%=Utilities.getValue(glInfo.FirstName)%> <%=Utilities.getValue(glInfo.LastName)%>.
    Based on the medical and family history of <%=Utilities.getValue(glInfo.FirstName)%>, I recommend iGene Cancer Panel at ApolloGen,
    a CLIA-certified clinical diagnostic laboratory located in Irvine, California, to determine the hereditary risks for <%=glInfo.LetterType==RequisitionWeb.LETTER_Breast?"breast":"colorectal"%> cancer
    and related cancers in <%=Utilities.getValue(glInfo.FirstName)%>.
   </td>
 </tr>
 <tr>
   <td colspan="2">
     My patient’s medical history is suggestive of hereditary <%=glInfo.LetterType==RequisitionWeb.LETTER_Breast?"breast":"colorectal"%> cancer.
     <%=Utilities.getValue(glInfo.FirstName)%> is eligible for the recommended genetic testing as they meet
     the following clinical criteria for coverage, and this test is medically necessary to assess this patient's
     inherited risk of having a hereditary <%=glInfo.LetterType==RequisitionWeb.LETTER_Breast?"breast cancer syndrome":"colorectal cancer syndrome, such as Lynch Syndrome"%>, and developing related cancers:
<%
    if (ltCriteria.size()>0) {
%>
     <ul>
<%  for (int i=0; i<ltCriteria.size(); i++) {
        String criteria = ltCriteria.get(i);
        int start = Utilities.getValue(criteria).indexOf(".");
//start = -1;
%>
      <li><%=criteria.substring(start+1).trim()%>.</li>
<% } %>
     </ul>
<% } %>
   </td>
 </tr>
 <tr>
   <td colspan="2">
<% if (glInfo.LetterType==RequisitionWeb.LETTER_Breast) { %>
 The results from this recommended genetic test will have a direct impact on first name of patient’s treatment and management. If a mutation is identified, we will adjust medical care to reduce my patient’s risk of developing (and potentially die of) an advanced stage cancer. Each hereditary cancer syndrome tested on this panel has gene-specific and site-specific cancer risks for which National Comprehensive Cancer Network (NCCN) management recommendations differ. These may include increased cancer surveillance, options for prophylactic surgeries and chemoprevention. Thus, it is essential that an accurate diagnosis is established for this patient in order to determine the most appropriate medical management.              
<% } else if (glInfo.LetterType==RequisitionWeb.LETTER_Colorectal) { %>
The results from this recommended genetic test will have a direct impact on first name of patient’s treatment and management.
Many hereditary colorectal cancer pedigrees display significant phenotypic overlap with those of other hereditary cancer
syndromes. If a mutation is identified, we will adjust medical care to reduce my patient’s risk of developing (and potentially
die of) an advanced stage cancer. Each hereditary cancer syndrome tested on this panel has gene-specific and site-specific
cancer risks for which National Comprehensive Cancer Network (NCCN) management recommendations differ. These may include
increased cancer surveillance, options for prophylactic surgeries and chemoprevention. Thus, it is essential that an accurate
diagnosis is established for this patient in order to determine the most appropriate medical management.
<% } %>
  </td>
 </tr>
 <tr><td height="15" colspan="2"></td></tr>
 <tr>
   <td colspan="2">
Thank you for your review and consideration. I hope you will support this request for genetic testing coverage for <%=Utilities.getValue(glInfo.FirstName)%> <%=Utilities.getValue(glInfo.LastName)%>.
If you have questions, please do not hesitate to call me at <%=Utilities.getValue(glInfo.Phy_Phone)%>.
   </td>
 </tr>
<tr><td height="25" colspan="2"></td></tr>
 <tr>
   <td style="border-bottom: 1px dashed" colspan="2">
    <b>Statement of Medical Necessity</b>
   </td>
 </tr>
 <tr>
   <td colspan="2">
I confirm that this test is medically necessary in accordance with medical guidelines and that the information provided is
accurate and factual based on the patient’s medical records and history. The results will directly impact my patient's medical
management and treatment decisions. I have personally performed genetic counselling and reviewed three-generation family history
with my patient. I am a physician with experience in cancer genetics, as I provide cancer risk assessment on a regular basis
and have received specialized ongoing training in cancer genetics. I have supplied information to the patient regarding this
genetic test, discussed cancer risk assessments and the patient has given consent for this testing to be performed. I will
provide the patient with post-test follow-up counselling as necessary.
 <p><br></p>
 <p></p>
 Sincerely,
   </td>
 </tr>
 <tr><td height="25" colspan="2"></td></tr>
 <tr>
   <td colspan="2">
     <%=Utilities.getValue(glInfo.Phy_Name)%>, MD
   </td>
 </tr>
 <tr>
   <td colspan="2">
     Date: <%=glInfo.CreateDate.substring(0, 10)%>
   </td>
 </tr>
</table>