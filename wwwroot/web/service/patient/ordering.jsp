<%@ page import="com.zyzit.weboffice.database.Apollogen.model.*" %>
<%
    GeneralInfo glInfo = trInfo.glInfo;
%>
<table width="100%" class="well well-sm">
 <tr>
  <td style="border: 1px solid #000000">
      <ol class="breadcrumb">
        <li><a href="#" onclick="submitValidateForm(submitOrdering, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.General.GetName()%>')"><%=NavigationInfo.Navigation.General.GetName()%></a></li>
        <li class="active"><b><%=currentPage.GetName()%></b></li>
          <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Consent.GetName()%></font></li>
          <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Summary.GetName()%></font></li>
          <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Payment.GetName()%></font></li>
      </ol>
  </td>
 </tr>
</table>
<FORM name="testform" action="/Patient" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Ordering">
<INPUT type="hidden" name="id" value="<%=glInfo.ID%>">
<table width="100%" style="border: 1px solid #2f5496">
<tr bgcolor="#2f5496">
  <td colspan="3" height="28" align="center"><font size="3" color="#ffffff">TEST Ordering</font></td>
</tr>
<tr>
  <td>
  <div id="id_<%=GeneralInfo.ATestType.Cancer.GetName()%>" style2="display:<%=(glInfo.TestType&GeneralInfo.ATestType.Cancer.GetValue())>0?"block":"none"%>">
    <br>  
    <table width="98%" align="center" style="border: 1px solid #b4c6e7">
    <tr bgcolor="#b4c6e7">
      <td colspan="3" height="28">&nbsp;&nbsp;<b>Cancer Panels</b></td>
    </tr>
     <tr><td colspan="3" height="4"><input type="hidden" name="cancerpanel" value="<%=glInfo.CancerPanel%>"></td></tr>
     <tr>
     <td width="50%" nowrap valign="top">
    &nbsp;&nbsp;<input type="checkbox" value="1" name="cp_igene" onchange="onCheckStatusChange(this)"> 9001 iGene Cancer Panel (23 gene focus panel)
     </td>
     <td align="right"><a here="#" onclick="return showDesc(this, 'desc_cp_igene')">Show More</a>&nbsp;&nbsp;
     <div id="desc_cp_igene" style="display:none">
         <table width="100%">
           <tr>
             <td width="92%">Informs you about your predisposition to cancer. Test results are clinically actionable with clear medical value. This panel analyzes 23 critical high-risk genes covering breast cancer, colorectal cancer, prostate cancer, ovarian cancer, uterine cancer, pancreatic cancer, renal cancer, and other types of cancers, including the common hereditary cancer syndromes.</td>
             <td align="right" valign="top">&nbsp;$<span id="cp_igene"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_1")%></span>&nbsp;</td>
           </tr>
         </table>
     </div>
     </td>
     </tr>
     <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>
    <tr>
    <td width="50%" nowrap valign="top">
     &nbsp;&nbsp;<input type="checkbox" value="4" name="cp_brca"  onchange="onCheckStatusChange(this)"> 2001 BRCA1 and BRCA2 Sequencing Panel
    </td>
    <td align="right"><a here="#" onclick="return showDesc(this, 'desc_cp_brca')">Show More</a>&nbsp;&nbsp;
       <div id="desc_cp_brca" style="display:none">
           <table width="100%">
             <tr>
               <td width="92%">Analyzes BRCA1 and BRCA2 genes, responsible for Hereditary Breast and Ovarian Cancer Syndrome (HBOC), which is also associated with pancreatic cancer, prostate cancer, melanoma, etc.</td>
               <td align="right" valign="top">&nbsp;$<span id="cp_brca"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_3")%></span>&nbsp;</td>
             </tr>
           </table>
           </div>
     </td>
    </tr>
    <tr style2="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>

    <tr>
        <td width="50%" nowrap valign="top">
            &nbsp;&nbsp;<input type="checkbox" value="8" name="cp_breastcancer"  onchange="onCheckStatusChange(this)"> 2005 Breast Cancer and Gynecologic Cancer Panel
        </td>
        <td align="right"><a here="#" onclick="return showDesc(this, 'desc_cp_breastcancer')">Show More</a>&nbsp;&nbsp;
            <div id="desc_cp_breastcancer" style="display:none">
                <table width="100%">
                    <tr>
                        <td width="92%">Tests for 14 moderate- and high-risk genes associated with breast cancer and other gynecologic cancers, also including Cowden syndrome, Li-Fraumeni syndrome, Peutz-Jegher syndrome, etc.</td>
                        <td align="right" valign="top">&nbsp;$<span id="cp_breastcancer"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_4")%></span>&nbsp;</td>
                    </tr>
                </table>
            </div>
    </tr>

    <tr style2="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>
        <tr>
            <td width="50%" nowrap valign="top">
                &nbsp;&nbsp;<input type="checkbox" value="2" name="cp_colorect"  onchange="onCheckStatusChange(this)"> 2021 Colorectal Cancer Core Panel (12 genes)
            </td>
            <td align="right"><a here="#" onclick="return showDesc(this, 'desc_cp_colorect')">Show More</a>&nbsp;&nbsp;
                <div id="desc_cp_colorect" style="display:none">
                    <table width="100%">
                        <tr>
                            <td width="92%">Analyzes the most critical high-risk genes that have been associated with colorectal cancer. It also covers common and well-described hereditary colorectal cancer syndromes, including Lynch syndrome, Familial Adenomatous Polyposis, and those that could lead to other primary cancer risks.</td>
                            <td align="right" valign="top">&nbsp;$<span id="cp_colorect"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_2")%></span>&nbsp;</td>
                        </tr>
                    </table>
                </div>
        </tr>
        <tr style2="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>

   </table>
    <p></p>
    <table width="98%" align="center" style="border: 1px solid #b4c6e7">
    <tr bgcolor="#b4c6e7">
      <td colspan="3" height="28">&nbsp;&nbsp;<b>Cardiovascular Panels</b></td>
    </tr>
     <tr><td colspan="3" height="4"><input type="hidden" name="cardiovascular" value="<%=glInfo.Cardiovascular%>"></td></tr>
     <tr>
     <td width="50%" nowrap valign="top">
    &nbsp;&nbsp;<input type="checkbox" value="1" name="ca_igene" onchange="onCheckStatusChange(this)"> 9002 iGene Cardiac Panel (22 gene focus panel)
     </td>
     <td align="right"><a here="#" onclick="return showDesc(this, 'desc_ca_igene')">Show More&nbsp;&nbsp;</a>
       <div id="desc_ca_igene" style="display:none">
           <table width="100%">
             <tr>
               <td width="92%">Informs you about your predisposition to cardiovascular disease. Test results are clinically actionable with clear medical value. This panel analyzes 23 critical genes associated with heart muscle diseases, arrhythmias, familial high cholesterol, aortopathy/aneurysm, and other cardiovascular diseases, all of which significantly increase risk for heart attack or sudden cardiac death.</td>
               <td align="right" valign="top">&nbsp;$<span id="ca_igene"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "Cardiovascular_1")%></span>&nbsp;</td>
             </tr>
           </table>
        </div>
     </td>
     </tr>
     <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>
   </table>
    <p></p>
   <table width="98%" align="center" style="border: 1px solid #b4c6e7">
    <tr bgcolor="#b4c6e7">
      <td colspan="3" height="28">&nbsp;&nbsp;<b>Drug Sensitivity Panels</b></td>
    </tr>
       <tr><td colspan="3" height="4"><input type="hidden" name="drugsensitivity" value="<%=glInfo.DrugSensitivity%>"></td></tr>
       <tr>
       <td width="50%" nowrap valign="top">
      &nbsp;&nbsp;<input type="checkbox" value="1" name="ds_comp" onchange="onCheckStatusChange(this)"> 1100 Comprehensive Pharmacogenomics (PGx) Panel
       </td>
       <td align="right"><a here="#" onclick="return showDesc(this, 'desc_ds_comp')">Show More</a>&nbsp;&nbsp;
       <div id="desc_ds_comp" style="display:none">
           <table width="100%">
             <tr>
               <td width="92%">Guides selecting medications and dosage with optimal outcomes and minimal side effect. Covers over 200 medications prescribed to treat common conditions, such as mental health conditions, acute/chronic pain, cardiovascular conditions, infectious disease, neurologic disorders, cancer, urological conditions, etc. following the most current FDA recommendations and clinical guidelines.</td>
               <td align="right" valign="top">&nbsp;$<span id="ds_comp"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_1")%></span>&nbsp;</td>
             </tr>
           </table>
        </div>
       </td>
       </tr>
       <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>
       <tr>
       <td width="50%" nowrap valign="top">
      &nbsp;&nbsp;<input type="checkbox" value="2" name="ds_pain" onchange="onCheckStatusChange(this)"> 1110 Pain Management PGx Panel
       </td>
       <td align="right"><a here="#" onclick="return showDesc(this, 'desc_ds_pain')">Show More</a>&nbsp;&nbsp;
       <div id="desc_ds_pain" style="display:none">
           <table width="100%">
             <tr>
               <td width="92%">Evaluates genetic markers affecting metabolism and response to various common pain management medications, including opiates, NSAIDs, muscle relaxant, anticonvulsants, antidepressants, and other drugs with analgesic effects.</td>
               <td align="right" valign="top">&nbsp;$<span id="ds_pain"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_2")%></span>&nbsp;</td>
             </tr>
           </table>
        </div>
       </td>
       </tr>
       <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>
       <tr>
       <td width="50%" nowrap valign="top">
      &nbsp;&nbsp;<input type="checkbox" value="4" name="ds_mental" onchange="onCheckStatusChange(this)"> 1120 Mental Health PGx Panel
       </td>
       <td align="right"><a here="#" onclick="return showDesc(this, 'desc_ds_mental')">Show More</a>&nbsp;&nbsp;
       <div id="desc_ds_mental" style="display:none">
           <table width="100%">
             <tr>
               <td width="92%">Evaluates genetic markers responsible for metabolism and response of commonly prescribed medications to treat depression, anxiety, bipolar disorder, schizophrenia and other behavioral health conditions.</td>
               <td align="right" valign="top">&nbsp;$<span id="ds_mental"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_4")%></span>&nbsp;</td>
             </tr>
           </table>
           </div></td>
       </tr>
       <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>
       <tr>
       <td width="50%" nowrap valign="top">
      &nbsp;&nbsp;<input type="checkbox" value="8" name="ds_cardio" onchange="onCheckStatusChange(this)"> 1130 Cardiovascular Health PGx Panel
       </td>
       <td align="right"><a here="#" onclick="return showDesc(this, 'desc_ds_cardio')">Show More</a>&nbsp;&nbsp;
       <div id="desc_ds_cardio" style="display:none">
           <table width="100%">
             <tr>
               <td width="92%">Provides PGx-based prescription guidance on the most frequently used drug classes in cardiology, including anti-platelets, anti-arrhythmics, statins, anti-coagulant, beta-blockers, etc. Evaluates elevated risk of heart disease, thrombosis and other cardiac and stroke-related conditions.</td>
               <td align="right" valign="top">&nbsp;$<span id="ds_cardio"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_8")%></span>&nbsp;</td>
             </tr>
           </table>
         </div></td>
       </tr>
       <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>
       <tr>
       <td width="50%" nowrap valign="top">
      &nbsp;&nbsp;<input type="checkbox" value="16" name="ds_throm" onchange="onCheckStatusChange(this)"> 1140 Thrombophilia Panel
       </td>
       <td align="right"><a here="#" onclick="return showDesc(this, 'desc_ds_throm')">Show More</a>&nbsp;&nbsp;
       <div id="desc_ds_throm" style="display:none">
           <table width="100%">
             <tr>
               <td width="92%">Analyzes gene variations known to be associated with increased risk of venous thromboembolism, pulmonary embolism and hyperhomocysteinemia.</td>
               <td align="right" valign="top">&nbsp;$<span id="ds_throm"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_16")%></span>&nbsp;</td>
             </tr>
           </table>
           </div>
        </td>
       </tr>
       <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>
     </table>

    <p></p>
     <table width="98%" align="center" style="border: 1px solid #b4c6e7">
    <tr bgcolor="#b4c6e7">
      <td colspan="3" height="28">&nbsp;&nbsp;<b>Other Health Risk Management Panels</b></td>
    </tr>
      <tr><td colspan="3" height="4"><input type="hidden" name="otherrisk" value="<%=glInfo.OtherRisk%>"></td></tr>
         </tr>
         <tr><td colspan="3" height="4"></td></tr>
         <tr>
             <td width="50%" nowrap valign="top">
                 &nbsp;&nbsp;<input type="checkbox" value="2" name="or_obesity" onchange="onCheckStatusChange(this)"> 1210 Comprehensive Obesity and Diabetes Genetic Risk Panel
             </td>
             <td align="right"><a here="#" onclick="return showDesc(this, 'desc_or_obesity')">Show More</a>&nbsp;&nbsp;
                 <div id="desc_or_obesity" style="display:none">
                     <table width="100%">
                         <tr>
                             <td width="92%">This innovative two-tiered genetic testing panel detects inherited obesity/diabetes mutations and also assesses an individual’s accrued risks for these common conditions.
                                 (Obesity and diabetes related drug response will be tested if ordered together with test code 1100)</td>
                             <td align="right" valign="top">&nbsp;$<span id="or_obesity"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_2")%></span>&nbsp;</td>
                         </tr>
                     </table>
                 </div>
             </td>
         </tr>
         <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>

         <tr>
             <td width="50%" nowrap valign="top">
                 &nbsp;&nbsp;<input type="checkbox" value="1" name="or_exome" onchange="onCheckStatusChange(this)"> 1500 Clinical Focused Exome (6110 genes)
             </td>
             <td align="right"><a here="#" onclick="return showDesc(this, 'desc_or_exome')">Show More</a>&nbsp;&nbsp;
                 <div id="desc_or_exome" style="display:none">
                     <table width="100%">
                         <tr>
                             <td width="92%">Comprehensively analyzes 6100 medically relevant and disease-associated genes to assist in efficient diagnosis and expedite targeted treatment. It is useful for obtaining a diagnosis for complex symptoms and evaluating overall health risks and diseases.</td>
                             <td align="right" valign="top">&nbsp;$<span id="or_exome"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_1")%></span>&nbsp;</td>
                         </tr>
                     </table>
                 </div>
             </td>
         </tr>
         <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>

         </tr>
         <tr><td colspan="3" height="4"></td></tr>
         <tr>
             <td width="50%" nowrap valign="top">
                 &nbsp;&nbsp;<input type="checkbox" value="4" name="or_micopy" onchange="onCheckStatusChange(this)"> 8700 Vital Mito (Mitochondrial Copy Number Analysis)
             </td>
             <td align="right"><a here="#" onclick="return showDesc(this, 'desc_or_micopy')">Show More</a>&nbsp;&nbsp;
                 <div id="desc_or_micopy" style="display:none">
                     <table width="100%">
                         <tr>
                             <td width="92%">Comprehensively and accurately analyzes mitochondrial DNA copy number and serves as an easy-to-track indicator to help clinicians and patients effectively monitor and improve general mitochondrial health.</td>
                             <td align="right" valign="top">&nbsp;$<span id="or_micopy"><%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_3")%></span>&nbsp;</td>
                         </tr>
                     </table>
                 </div>
             </td>
         </tr>
         <tr style="border-bottom: 1px solid #b4c6e7"><td colspan="3" height="4"></td></tr>

     </table>
    <p>  
  </div>
  </td>
</tr>

<tr>
 <td align="right" height="40"><font size="3">Total Orders: <font color="red"><b>$<span id="id_total">35.90</span></b></font></font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
   <!-- &nbsp;<input class="btn btn-default active" type="submit" name='gosave' value="Save" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitOrdering, document.testform, null, 'save')">&nbsp;&nbsp; -->
     <span id="id_buttonmessage"></span>  
  </td>
  <td width="30%" align="right">
     <input class="btn btn-default active" type="submit" name='gonext' value="Next >" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitOrdering, document.testform, 'id_mainarea', 'next');">&nbsp;
 </td>
 </tr>
</table>
</FORM>
<script type="text/javascript">
function onClickTestCategory(chkObj)
{
   var blockname = "id_" + chkObj.name.substr(3);
   if (chkObj.checked)
     $('#' + blockname).show();
   else
     $('#' + blockname).hide();

   var form = document.testform;
   var value = getMultipleCheckboxValue(form, 'to_');
   if (value==0)
     $('#id_notest').show();
   else
     $('#id_notest').hide();    
}

function submitOrdering(form, next)
{
    form.cancerpanel.value = getMultipleCheckboxValue(form, 'cp_');
    form.cardiovascular.value = getMultipleCheckboxValue(form, 'ca_');
    form.drugsensitivity.value = getMultipleCheckboxValue(form, 'ds_');
    form.otherrisk.value = getMultipleCheckboxValue(form, 'or_');

  if (next=="next"||next=="save")
  {
     if ((form.cancerpanel.value+form.cardiovascular.value+form.drugsensitivity.value+form.otherrisk.value)==0)
     {
        alert("You have to at lease to select one of testing panels.");
        return false;
     }
  }

  return true;
}

function calculateTotal(form)
{
    var fTotal = 0;
    for(i=0; i<form.elements.length; i++)
    {
      var e = form.elements[i];
      if (e.type=='checkbox' && e.checked)
      {
         if (e.name.indexOf("cp_")==0 ||
             e.name.indexOf("ca_")==0 ||
             e.name.indexOf("ds_")==0 ||
             e.name.indexOf("or_")==0
            )
         {
            var subTotal = $('#' + e.name).html();
            fTotal += parseFloat(subTotal);
         }
      }
    }

    $('#id_total').html(fTotal);
}

function onCheckStatusChange(objCheck)
{
    calculateTotal(document.testform);    
}

function showDesc(objLink, idhtml)
{
   $('#'+ idhtml).toggle();

  var isV = $('#'+ idhtml).is(':visible');
  if (isV)
  {
     objLink.style.color = 'orange';
     objLink.text = "Hide Detail";
  }
  else
  {
     objLink.style.color = '#4279bd';
     objLink.text = "Show More";
  }

  return false;
}

$(document).ready(function()
{
    setCheckboxesByBits(document.testform, 'cp_', "<%=glInfo.CancerPanel%>");
    setCheckboxesByBits(document.testform, 'ca_', "<%=glInfo.Cardiovascular%>");
    setCheckboxesByBits(document.testform, 'ds_', "<%=glInfo.DrugSensitivity%>");
    setCheckboxesByBits(document.testform, 'or_', "<%=glInfo.OtherRisk%>");

    calculateTotal(document.testform);
});
</script>
