<%@ page import="com.zyzit.weboffice.database.Apollogen.model.ConsentInfo" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.HistoryInfo" %>
<%
    GeneralInfo glInfo = trInfo.getGeneral(loginInfo.CustomerID);
    CancerInfo ccInfo = trInfo.getCarcer(trInfo.glInfo.ID);
%>
<script type="text/javascript">
$(document).ready(function() {
<% if (ccInfo.BreastCheck>0) { %>
    $("#cc_0").ultraselect(null, function (el) {
     $("#s_cc_0").html(("" + $("#cc_0").val()).replace(/,/g, ", "));
    });
<% } %>

<% if (ccInfo.ColorectCheck>0) { %>
   $("#cc_1").ultraselect(null, function (el) {
     $("#s_cc_1").html(("" + $("#cc_1").val()).replace(/,/g, ", "));
   });
<% } %>
<% if (ccInfo.EndometCheck>0) { %>
   $("#cc_2").ultraselect(null, function (el) {
      $("#s_cc_2").html(("" + $("#cc_2").val()).replace(/,/g, ", "));
   });
<% } %>
<% if (ccInfo.OvarianCheck>0) { %>
    $("#cc_3").ultraselect(null, function (el) {
       $("#s_cc_3").html(("" + $("#cc_3").val()).replace(/,/g, ", "));
    });
<% } %>
<% if (ccInfo.PancreatCheck>0) { %>
    $("#cc_4").ultraselect(null, function (el) {
       $("#s_cc_4").html(("" + $("#cc_4").val()).replace(/,/g, ", "));
    });
<% } %>
<% if (ccInfo.ProstateCheck>0) { %>
   $("#cc_5").ultraselect(null, function (el) {
       $("#s_cc_5").html(("" + $("#cc_5").val()).replace(/,/g, ", "));
   });
<% } %>
<% if (ccInfo.OtherCheck>0) { %>
    $("#cc_6").ultraselect(null, function (el) {   
       $("#s_cc_6").html(("" + $("#cc_6").val()).replace(/,/g, ", "));
    });
<% } %>

    $("#pg_0").ultraselect(null, function (el) {
       $("#s_pg_0").html(("" + $("#pg_0").val()).replace(/,/g, ", "));
    });
    $("#pg_1").ultraselect(null, function (el) {
       $("#s_pg_1").html(("" + $("#pg_1").val()).replace(/,/g, ", "));
    });

//    $("#cy_0").ultraselect({selectAll: false});
    $("#cy_0").ultraselect(null, function (el) {
       $("#s_cy_0").html(("" + $("#cy_0").val()).replace(/,/g, ", "));
    });


    $(document).on('click','button.removebutton', function() {
        $(this).closest('tr').remove();

        renameRowName();

        return false;
    });
});

function submitClinical(form, next)
{
  if (next=="next"||next=="save")
  {

<% if ((trInfo.glInfo.TestType&GeneralInfo.ATestType.Cancer.GetValue())>0) { %>

     var value = getRadioValue(form.cancerhistory);
  <% if (RequisitionWeb.tryEligibility(trInfo)) { %>

     if (value!=1 && value!=2)
     {
         alert("You have to select 'Yes' or 'No' for Personal History of Cancer/Tumor/Polyp");
         return false;
     }
  <% } %>

    if (!clicicalCheck(form, value))
       return false;
<% } %>
}

<% if ((trInfo.glInfo.TestType&GeneralInfo.ATestType.Cancer.GetValue())>0) { %>
  form.breastcode.value = $("#cc_0").val();
  form.colorectcode.value = $("#cc_1").val();
  form.endometcode.value = $("#cc_2").val();
  form.ovariancode.value = $("#cc_3").val();
  form.pancreatcode.value = $("#cc_4").val();
  form.prostatecode.value = $("#cc_5").val();
  form.othercode.value = $("#cc_6").val();
<% } %>

<% if ((trInfo.glInfo.TestType&GeneralInfo.ATestType.PGx.GetValue())>0) { %>
  form.medication.value = $("#pg_0").val();
  form.icdcode.value = $("#pg_1").val();
<% } %>

<% if ((trInfo.glInfo.TestType&GeneralInfo.ATestType.Cardiology.GetValue())>0) { %>
  form.carddiagnosis.value = $("#cy_0").val();
<% } %>

   return true;
}    
</script>
<table width="100%" class="well well-sm">
 <tr>
  <td>
      <ol class="breadcrumb">
        <li><a href="#" onclick="submitValidateForm(submitClinical, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.General.GetName()%>')"><%=NavigationInfo.Navigation.General.GetName()%></a></li>
<% if (glInfo.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
        <li><a href="#" onclick="submitValidateForm(submitClinical, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Ordering.GetName()%>')"><%=NavigationInfo.Navigation.Ordering.GetName()%></a></li>
<% } %>
        <li class="active"><b><%=currentPage.GetName()%></b></li>
<% if (RequisitionWeb.tryEligibility(trInfo)) { %>
        <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Eligibility.GetName()%></font></li>
<% } %>
<% if (trInfo.glInfo.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
        <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Consent.GetName()%></font></li>
<% } %>
        <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Summary.GetName()%></font></li>
      </ol>
  </td>
 </tr>
</table>
<FORM name="testform" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Clinical">
<INPUT type="hidden" name="id" value="<%=ccInfo.ID%>">    
<% if ((trInfo.glInfo.TestType&GeneralInfo.ATestType.Cancer.GetValue())>0) { %>
<%@ include file="cancertest.jsp"%>    
<% } %>
<% if ((trInfo.glInfo.TestType&GeneralInfo.ATestType.Cardiology.GetValue())>0) { %>
<%@ include file="cardiologytest.jsp"%>
<% } %>
<% if ((trInfo.glInfo.TestType&GeneralInfo.ATestType.PGx.GetValue())>0) { %>
<%@ include file="pgxtest.jsp"%>
<% } %>
<% if ((trInfo.glInfo.TestType&GeneralInfo.ATestType.Ophthalmology.GetValue())>0) { %>
<%@ include file="ophthalmologytest.jsp"%>
<% } %>
<% if ((trInfo.glInfo.TestType&GeneralInfo.ATestType.Other.GetValue())>0) { %>
<%@ include file="othertest.jsp"%>
<% } %>
<%
%>
<table width="100%" style2="border: 1px solid #2f5496">
 <tr><td colspan="3" height="30"><hr style="border:2px solid #000000"></td>
</tr>
 <tr>
  <td width="20%">
     &nbsp;<input class="btn btn-default active" type="submit" name='goprev' value="< Previous" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitClinical, document.testform, 'id_mainarea', 'prev');">
  </td>
  <td align="center">
     <span id="id_buttonmessage"></span>
  </td>
  <td width="30%" align="right">
     <input class="btn btn-default active" type="submit" name='submit' value="Next >" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitClinical, document.testform, 'id_mainarea', 'next');">
 </td>
 </tr>
</table>
</FORM>

<div id="id_addinghistoryrow" style="display:none">
<table>
    <tr style="border: 1px solid #2f5496">
      <td height="30" align="center" style="border-right: 1px solid #2f5496">
        <input type="text" name="initialXXX" value="" style="width:120px" maxlength=20>
      </td>
      <td align="center" style="border-right: 1px solid #2f5496">
      <select name="relationshipXXX">
        <option value=""></option>
          <option value="Mother">Mother</option>
          <option value="Father">Father</option>
          <option value="Sister">Sister</option>
          <option value="Brother">Brother</option>
          <option value="Daughter">Daughter</option>
          <option value="Son">Son</option>
          <option value="Aunt">Aunt</option>
          <option value="Uncle">Uncle</option>
          <option value="Grandmother">Grandmother</option>
          <option value="Grandfather">Grandfather</option>
          <option value="Half-Sister">Half-Sister</option>
          <option value="Half-Brother">Half-Brother</option>
          <option value="Niece">Niece</option>
          <option value="Nephew">Nephew</option>
          <option value="GreatAunt">Great Aunt</option>
          <option value="GreatUncle">Great Uncle</option>
          <option value="First-Cousin-F">First Cousin (Female)</option>
          <option value="First-Cousin-M">First Cousin (Male)</option>
      </select>
      </td>
      <td align="center" style="border-right: 1px solid #2f5496">
          <select name="parentsideXXX">
            <option value=""></option>
            <option value="Paternal">Paternal</option>
            <option value="Maternal">Maternal</option>
            <option value="Both">Both</option>
          </select>
      </td>
      <td align="center" style="border-right: 1px solid #2f5496">
        <select name="cancertypeXXX" onchange="onChangeCancerType(this, document.testform.othertypeXXX)">
        <option value=""></option>
        <option value="breast">Breast Cancer</option>
        <option value="colorectal">Colorectal Cancer</option>
        <option value="endometrial">Endometrial Cancer</option>
        <option value="ovarian">Ovarian Cancer</option>
        <option value="pancreatic">Pancreatic Cancer</option>
        <option value="prostate">Prostate Cancer</option>
        <option value="brain">Brain Tumor/Cancer</option>
        <option value="intestine">Small Intestine Cancer</option>
        <option value="gastric">Gastric Cancer</option>
        <option value="ureter">Ureter Cancer</option>
        <option value="renal">Renal Pelvis Cancer</option>
        <option value="biliary">Biliary Tract Cancer</option>
        <option value="fallopian">Fallopian Tube Cancer</option>
        <option value="peritoneal">Peritoneal Cancer</option>
        <option value="Other-->">Other--></option>
        </select>
      <input type="text" maxlength=256 value="" name="othertypeXXX" style="width:115px" disabled>
      </td>
      <td align="center" style="border-right: 1px solid #2f5496"><input type="text" maxlength=20 value="" name="diagnosisageXXX" style="width:120px"></td>
      <td><button type="button" class="removebutton" title="Remove this row" style="width: 26px; height:26px">X</button></td>
    </tr>
</table>
</div>
<div id="id_addingtestrow" style="display:none">
<table>
    <tr>
      <td height="30" width="45%">&nbsp;&nbsp;Test: <input type="text" value="" name="titleXXX" maxlength="1023" style="width:340px"></td>
      <td>Result: <input type="text" value="" name="descriptionXXX" maxlength="1023" style="width:400px"></td>
      <td><button type="button" class="removebutton" title="Remove this row" style="width: 26px; height:26px">X</button></td>
    </tr>
</table>
</div>

<div id="id_findingtestrow" style="display:none">
<table>
    <tr style="border: 1px solid #b4c6e7">
     <td height="30">&nbsp;&nbsp;
         <select name="titleXXX">
         <option value=""></option>
 <%
 List<String> ltCode10 = web.getDiagnosticCode("Findings");
 for (int i=0; i<ltCode10.size(); i++) {
  String sCodedesc = ltCode10.get(i);
  int nDash = sCodedesc.indexOf("-");
  String sCode = sCodedesc.substring(0, nDash).trim();
 %>
 <option value="<%=sCode%>"><%=sCodedesc.substring(nDash+1).trim()%></option>
 <% } %>
         </select>
     </td>
     <td>Special Result: <INPUT type="text" name="descriptionXXX" value="" style="width: 300px"></td>
    </tr>
</table>
</div>