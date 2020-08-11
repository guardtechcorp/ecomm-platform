<table width="100%" style="border: 1px solid #2f5496"  border=1 cellpadding="2" cellspacing="2">
<tr bgcolor="#2f5496">
  <td colspan="3" height="28" align="center"><font size="3" color="#ffffff"><b>Other</b> - Clinical Information</font></td>
</tr>
<tr>
 <td height="60">&nbsp; This patient has a diagnosis of or is strongly suspected to have (please specify diagnosis or ICD-10 code):&nbsp;
  <br>&nbsp; <INPUT type="text" name="othdiagnosis" value="<%=Utilities.getValue(ccInfo.OthDiagnosis)%>" style="width: 500px">
 </td>
</tr>
<tr>
    <td height="60">&nbsp; This patient has a family history of (please specify diagnosis or known familial variant):&nbsp;
        <br>&nbsp; <INPUT type="text" name="othfamily" value="<%=Utilities.getValue(ccInfo.OthFamily)%>" style="width: 500px">
    </td>
</tr>
<tr>
    <td height="60">&nbsp; <b>For Vital Mito Order:</b>
        <br><br>&nbsp; What is this test clinically for?
        <br>&nbsp; <input type="radio" name="clinicalfor" value=<%=CancerInfo.AClinicalFor.BASELINE.GetValue()%> <%=isChecked(ccInfo.ClinicalFor, CancerInfo.AClinicalFor.BASELINE.GetValue())%>> <%=CancerInfo.AClinicalFor.BASELINE.GetName()%>
        &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio" name="clinicalfor" value=<%=CancerInfo.AClinicalFor.MONITOR.GetValue()%> <%=isChecked(ccInfo.ClinicalFor, CancerInfo.AClinicalFor.MONITOR.GetValue())%>> <%=CancerInfo.AClinicalFor.MONITOR.GetName()%>
        &nbsp; &nbsp; &nbsp; &nbsp; <input type="radio" name="clinicalfor" value=<%=CancerInfo.AClinicalFor.WANT.GetValue()%> <%=isChecked(ccInfo.ClinicalFor, CancerInfo.AClinicalFor.WANT.GetValue())%>> <%=CancerInfo.AClinicalFor.WANT.GetName()%>
        <br><br>&nbsp; What type of treatment/therapy/supplementation is considered or used for this patient?
        <br>&nbsp; <INPUT type="text" name="typeused" value="<%=Utilities.getValue(ccInfo.TypeUsed)%>" style="width: 500px">
        <br><br>&nbsp; How many weeks is this patient into/after the treatment (therapy, supplementation, etc.)?
        <br>&nbsp; <INPUT type="text" name="weektreat" value="<%=Utilities.getValue(ccInfo.WeekTreat)%>" style="width: 500px">
        <br>&nbsp;
    </td>
</tr>


</table>
<p><br></p>