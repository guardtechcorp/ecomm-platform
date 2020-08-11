<%@ page import="com.zyzit.weboffice.database.Apollogen.model.*" %>
<%
    GeneralInfo glInfo = trInfo.glInfo;
    boolean bShowPrice = false;
%>
<table width="100%" class="well well-sm">
 <tr>
  <td style="border: 1px solid #000000">
      <ol class="breadcrumb">
        <li><a href="#" onclick="submitValidateForm(submitOrdering, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.General.GetName()%>')"><%=NavigationInfo.Navigation.General.GetName()%></a></li>
        <li class="active"><b><%=currentPage.GetName()%></b></li>
          <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Clinical.GetName()%></font></li>
<% if (RequisitionWeb.tryEligibility(trInfo)) { %>
          <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Eligibility.GetName()%></font></li>
<% } %>
          <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Consent.GetName()%></font></li>
          <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Summary.GetName()%></font></li>
      </ol>
  </td>
 </tr>
</table>
<FORM name="testform" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Ordering">
<INPUT type="hidden" name="id" value="<%=glInfo.ID%>">
<table width="100%" style="border: 1px solid #2f5496">
<tr bgcolor="#2f5496">
  <td colspan="3" height="28" align="center"><font size="3" color="#ffffff">TEST REQUESTED</font></td>
</tr>
<tr bgcolor2="#b4c6e7">
  <input type="hidden" name="testtype" value="<%=glInfo.TestType%>">
  <td height="36" style="border-bottom: 1px solid #2f5496">&nbsp;&nbsp;* Select Test Category: &nbsp;&nbsp;
   <input type="checkbox" name="to_<%=GeneralInfo.ATestType.Cancer.GetName()%>" value="<%=GeneralInfo.ATestType.Cancer.GetValue()%>" onclick="onClickTestCategory(this)">&nbsp;<%=GeneralInfo.ATestType.Cancer.GetName()%> &nbsp;&nbsp;
   <input type="checkbox" name="to_<%=GeneralInfo.ATestType.Cardiology.GetName()%>" value="<%=GeneralInfo.ATestType.Cardiology.GetValue()%>" onclick="onClickTestCategory(this)">&nbsp;<%=GeneralInfo.ATestType.Cardiology.GetName()%> &nbsp;&nbsp;
   <input type="checkbox" name="to_<%=GeneralInfo.ATestType.PGx.GetName()%>" value="<%=GeneralInfo.ATestType.PGx.GetValue()%>" onclick="onClickTestCategory(this)">&nbsp;Pharmacogenomics (PGx) &nbsp;&nbsp;
   <input type="checkbox" name="to_<%=GeneralInfo.ATestType.Ophthalmology.GetName()%>" value="<%=GeneralInfo.ATestType.Ophthalmology.GetValue()%>" onclick="onClickTestCategory(this)">&nbsp;<%=GeneralInfo.ATestType.Ophthalmology.GetName()%> &nbsp;&nbsp;
   <input type="checkbox" name="to_<%=GeneralInfo.ATestType.Other.GetName()%>" value="<%=GeneralInfo.ATestType.Other.GetValue()%>" onclick="onClickTestCategory(this)">&nbsp;<%=GeneralInfo.ATestType.Other.GetName()%>
  </td>
</tr>
<tr>
  <td>
  <div id="id_<%=GeneralInfo.ATestType.Cancer.GetName()%>" style="display:<%=(glInfo.TestType&GeneralInfo.ATestType.Cancer.GetValue())>0?"block":"none"%>">
    <br>  
    <p align="center"><font size="4">Cancer Test</font></p>
    <table width="98%" align="center" style="border: 1px solid #b4c6e7">
    <tr bgcolor="#b4c6e7">
      <td colspan="3" height="28">&nbsp;&nbsp;<b>Comprehensive Cancer Panels</b></td>
    </tr>
     <tr>
     <td colspan="3" valign="top">
    <input type="hidden" name="comprehensive" value="<%=glInfo.Comprehensive%>">
    &nbsp;&nbsp;<input type="checkbox" value="<%=CancerInfo.ACompreh.IGENE.GetValue()%>" name="cc_igene"> 9001 iGene Cancer Panel (23 gene focus panel) <%=web.getSinglePrice("Comprehensive_"+CancerInfo.ACompreh.IGENE.GetValue(), bShowPrice)%>
     </td>
    </tr>
    <tr bgcolor="#b4c6e7">
      <td colspan="3" height="28">&nbsp;&nbsp;<b>Specialty Panels</b></td>
    </tr>
     <tr>
     <td colspan="3" valign="top"><input type="hidden" name="specialty" value="<%=glInfo.Specialty%>">
      &nbsp;&nbsp;<input type="checkbox" value="<%=CancerInfo.ASpecialty.BRCA.GetValue()%>" name="sp_brca"> 2001 BRCA1 and BRCA2 Sequencing Panel (2 genes) <%=web.getSinglePrice("Specialty_"+CancerInfo.ASpecialty.BRCA.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=CancerInfo.ASpecialty.Breast.GetValue()%>" name="sp_breastcancer"> 2005 Breast Cancer and Gynecologic Cancer Panel (14 genes) <%=web.getSinglePrice("Specialty_"+CancerInfo.ASpecialty.Breast.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=CancerInfo.ASpecialty.Colorectal1.GetValue()%>" name="sp_colorecore"> 2021 Colorectal Cancer Core Panel (12 genes) <%=web.getSinglePrice("Specialty_"+CancerInfo.ASpecialty.Colorectal1.GetValue(), bShowPrice)%>
     </td>
    </tr>
    </table>
    <p>  
  </div>
  <div id="id_<%=GeneralInfo.ATestType.Cardiology.GetName()%>" style="display:<%=(glInfo.TestType&GeneralInfo.ATestType.Cardiology.GetValue())>0?"block":"none"%>">
    <br>
    <p align="center"><font size="4">Cardiology Test</font></p>
    <table width="98%" align="center" style="border: 1px solid #b4c6e7">
    <tr bgcolor="#b4c6e7">
      <td colspan="3" height="28">&nbsp;&nbsp;<b>Comprehensive Cardiovascular Panels</b></td>
    </tr>
     <tr>
     <td colspan="3" valign="top">
    <input type="hidden" name="cardiovascular" value="<%=glInfo.Cardiovascular%>">
    &nbsp;&nbsp;<input type="checkbox" value="<%=CardiologyInfo.ACardiovas.Igene.GetValue()%>" name="cd_Igen"> 9002 iGene Cardiac Panel (22 gene focus panel)  <%=web.getSinglePrice("Cardiovascular_"+CardiologyInfo.ACardiovas.Igene.GetValue(), bShowPrice)%>
     <input type="hidden" name="cardiomyopathy" value="<%=glInfo.Cardiomyopathy%>">
     <input type="hidden" name="arrhythmia" value="<%=glInfo.Arrhythmia%>">
     <input type="hidden" name="aortopathy" value="<%=glInfo.Aortopathy%>">
     </td>
    </tr>
    <tr bgcolor="#b4c6e7">
      <td colspan="3" height="28">&nbsp;&nbsp;<b>Arrhythmia Panels</b></td>
    </tr>
    <tr>
      <td colspan="3" valign="top">
        &nbsp;&nbsp;<input type="checkbox" value="<%=CardiologyInfo.AArrhythmia.Long.GetValue()%>" name="at_Syndrome"> 3031 Long QT Syndrome Panel (20 genes) <%=web.getSinglePrice("Arrhythmia_"+CardiologyInfo.AArrhythmia.Long.GetValue(), bShowPrice)%>
      </td>
    </tr>
    <tr bgcolor="#b4c6e7">
      <td colspan="3" height="28">&nbsp;&nbsp;<b>Other Cardiovascular Testing Options</b></td>
    </tr>
     <tr>
     <td colspan="3" valign="top">
    <input type="hidden" name="otheroption" value="<%=glInfo.OtherOption%>">
    &nbsp;&nbsp;<input type="checkbox" value="<%=CardiologyInfo.AOther.Familial.GetValue()%>" name="op_Familial"> 3050 Familial Hypercholesterolemia Panel (4 genes) <%=web.getSinglePrice("Otheroption_"+CardiologyInfo.AOther.Familial.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=CardiologyInfo.AOther.Thrombophilia.GetValue()%>" name="op_Thrombophilia"> 1140 Thrombophilia Panel  <%=web.getSinglePrice("Otheroption_"+CardiologyInfo.AOther.Thrombophilia.GetValue(), bShowPrice)%>
     </td>
    </tr>
    </table>
    <p>
  </div>
  <div id="id_<%=GeneralInfo.ATestType.PGx.GetName()%>" style="display:<%=(glInfo.TestType&GeneralInfo.ATestType.PGx.GetValue())>0?"block":"none"%>">
    <br>
    <p align="center"><font size="4">Pharmacogenomics (PGx) Test</font></p>
    <table width="98%" align="center" style="border: 1px solid #b4c6e7">
     <tr>
     <td colspan="3" valign="top">
    <input type="hidden" name="pharmacogenomics" value="<%=glInfo.Pharmacogenomics%>">
    &nbsp;&nbsp;<input type="checkbox" value="<%=PGxInfo.APharma.Compreh.GetValue()%>" name="pg_Compreh"> 1100 Comprehensive Pharmacogenomics Panel (Full PGx) <%=web.getSinglePrice("Pharmacogenomics_"+PGxInfo.APharma.Compreh.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=PGxInfo.APharma.Pain.GetValue()%>" name="pg_Pain"> 1110 Pain Management PGx Panel <%=web.getSinglePrice("Pharmacogenomics_"+PGxInfo.APharma.Pain.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=PGxInfo.APharma.Mental.GetValue()%>" name="pg_Mental"> 1120 Mental Health PGx Panel <%=web.getSinglePrice("Pharmacogenomics_"+PGxInfo.APharma.Mental.GetValue(), bShowPrice)%>
     <p>&nbsp;&nbsp;<input type="checkbox" value="<%=PGxInfo.APharma.Cardiovas.GetValue()%>" name="pg_Cardiovas"> 1130 Cardiovascular Health PGx Panel <%=web.getSinglePrice("Pharmacogenomics_"+PGxInfo.APharma.Cardiovas.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=PGxInfo.APharma.Thrombophilia.GetValue()%>" name="pg_Thrombophilia"> 1140 Thrombophilia Panel <%=web.getSinglePrice("Pharmacogenomics_"+PGxInfo.APharma.Thrombophilia.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=PGxInfo.APharma.Obesity.GetValue()%>" name="pg_Obesity"> 1150 Obesity and Diabetes PGx Panel (DO PGx) <%=web.getSinglePrice("Pharmacogenomics_"+PGxInfo.APharma.Obesity.GetValue(), bShowPrice)%>
     </td>
    </tr>
    </table>
    <p>
  </div>
  <div id="id_<%=GeneralInfo.ATestType.Ophthalmology.GetName()%>" style="display:<%=(glInfo.TestType&GeneralInfo.ATestType.Ophthalmology.GetValue())>0?"block":"none"%>">
    <br>
    <p align="center"><font size="4">Ophthalmology Test</font></p>
    <table width="98%" align="center" style="border: 1px solid #b4c6e7">
     <tr>
     <td colspan="3" valign="top">
    <input type="hidden" name="ophthalmology" value="<%=glInfo.Ophthalmology%>">
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OphthalmologyInfo.AOphtha.Macular.GetValue()%>" name="oh_Macular"> 6111 Macular Degeneration Panel (22 genes) <%=web.getSinglePrice("Ophthalmology_"+OphthalmologyInfo.AOphtha.Macular.GetValue(), bShowPrice)%>
     </td>
    </tr>
    </table>
    <p>
  </div>

  <div id="id_<%=GeneralInfo.ATestType.Other.GetName()%>" style="display:<%=(glInfo.TestType&GeneralInfo.ATestType.Other.GetValue())>0?"block":"none"%>">
    <br>
    <p align="center"><font size="4">Other Tests</font></p>
    <table width="98%" align="center" style="border: 1px solid #b4c6e7">
     <tr>
     <td colspan="3" valign="top"><input type="hidden" name="other" value="<%=glInfo.Other%>">
     &nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.Obesity.GetValue()%>" name="ot_Obesity"> 1210 Comprehensive Obesity and Diabetes Panel (Diabetes + Obesity Genetics) <%=web.getSinglePrice("Other_"+OtherInfo.AOther.Obesity.GetValue(), bShowPrice)%>
     <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.Overweight.GetValue()%>" name="ot_Overweight"> 1213 Overweight and Obesity Panel (Obesity Genetics) <%=web.getSinglePrice("Other_"+OtherInfo.AOther.Overweight.GetValue(), bShowPrice)%>
     <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.Diabetes.GetValue()%>" name="ot_Diabetes"> 1216 Diabetes and Prediabetes Panel (Diabetes Genetics) <%=web.getSinglePrice("Other_"+OtherInfo.AOther.Diabetes.GetValue(), bShowPrice)%>
     <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.Relevant.GetValue()%>" name="ot_Relevant"> 1220 Obesity and Diabetes and related PGX (Diabetes + Obesity + DO PGx) <%=web.getSinglePrice("Other_"+OtherInfo.AOther.Relevant.GetValue(), bShowPrice)%>
     <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.FullPGX.GetValue()%>" name="ot_FullPGX"> 1230 Obesity and Diabetes and Full PGX (Diabetes +Obesity + Full PGx)<%=web.getSinglePrice("Other_"+OtherInfo.AOther.FullPGX.GetValue(), bShowPrice)%>
     <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.Clinical.GetValue()%>" name="ot_Clinical"> 1500 Clinical Focused Exome (6110 genes) <%=web.getSinglePrice("Other_"+OtherInfo.AOther.Clinical.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.Compreh.GetValue()%>" name="ot_Compreh"> 8100 Comprehensive Mitochondrial Genome Analysis <%=web.getSinglePrice("Other_"+OtherInfo.AOther.Compreh.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.Mitoch.GetValue()%>" name="ot_Mitoch"> 8300 Mitochondrial Nuclear Gene Panel <%=web.getSinglePrice("Other_"+OtherInfo.AOther.Mitoch.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.Allinc.GetValue()%>" name="ot_Allinc"> 8500 All-inclusive Mitochondrial Disorders Panel (Mitochondrial nuclear gene panel + Mitochondrial Genome) <%=web.getSinglePrice("Other_"+OtherInfo.AOther.Allinc.GetValue(), bShowPrice)%>
    <p>&nbsp;&nbsp;<input type="checkbox" value="<%=OtherInfo.AOther.MiCopy.GetValue()%>" name="ot_MiCopy"> 8700 Mitochondrial Copy Number Analysis <%=web.getSinglePrice("Other_"+OtherInfo.AOther.MiCopy.GetValue(), bShowPrice)%>
     </td>
    </tr>
    </table>
    <p>
  </div>

  <div id="id_notest" style="display:<%=glInfo.TestType==0?"block":"none"%>">
    <br>
    <table width="98%" align="center">
     <tr>
     <td align="center"><h4>Please select one or more of the above test ordering categories.</h4></td>
    </tr>
    </table>
    <p>
  </div>
  </td>
</tr>
</table>
<p>
<table width="100%">
 <tr><td colspan="3"><hr style="border:2px solid #000000"></td></tr>       
 <tr>
  <td width="20%">
     &nbsp;<input class="btn btn-default active" type="submit" name='goprev' value="< Previous" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitOrdering, document.testform, 'id_mainarea', 'prev')">
  </td>
  <td align="center">
     <span id="id_buttonmessage"></span>
  </td>
  <td width="30%" align="right">
     <input class="btn btn-default active" type="submit" name='gonext' value="Next >" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitOrdering, document.testform, 'id_mainarea', 'next');">&nbsp;
 </td>
 </tr>
</table>
</FORM>
<script type="text/javascript">
$(document).ready(function()
{
setCheckboxesByBits(document.testform, 'to_', "<%=glInfo.TestType%>");
setCheckboxesByBits(document.testform, 'cc_', "<%=glInfo.Comprehensive%>");
setCheckboxesByBits(document.testform, 'sp_', "<%=glInfo.Specialty%>");
setCheckboxesByBits(document.testform, 'cd_', "<%=glInfo.Cardiovascular%>");
setCheckboxesByBits(document.testform, 'cm_', "<%=glInfo.Cardiomyopathy%>");
setCheckboxesByBits(document.testform, 'at_', "<%=glInfo.Arrhythmia%>");
setCheckboxesByBits(document.testform, 'ap_', "<%=glInfo.Aortopathy%>");
setCheckboxesByBits(document.testform, 'op_', "<%=glInfo.OtherOption%>");
setCheckboxesByBits(document.testform, 'pg_', "<%=glInfo.Pharmacogenomics%>");
setCheckboxesByBits(document.testform, 'oh_', "<%=glInfo.Ophthalmology%>");
setCheckboxesByBits(document.testform, 'ot_', "<%=glInfo.Other%>");
});
</script>