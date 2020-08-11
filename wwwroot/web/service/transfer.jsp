<%
   web.getNames(trInfo.glInfo);
//   boolean bFormSubmitted = (trInfo.glInfo.Status==RequisitionInfo.AStatus.SUBMITTED.GetValue()
//           ||trInfo.glInfo.Status==RequisitionInfo.AStatus.RESUBMITTED.GetValue());
%>

<script type="text/javascript">
$(document).ready(function()
{
    $('.datepicker').datepicker({
        viewMode: 'years',
        format: 'mm/dd/yyyy'
//        startDate: '-3d'
    });
});

function toggleShowIAgree(idhtml)
{
   $('#'+idhtml).toggle();

   return false;
}

function submitIGree(form, next)
{
    if (checkFieldEmpty(form.phy_name))
    {
       alert("You have to enter your name.");
       setFocus(form.phy_name);

       return false;
    }

    if (checkFieldEmpty(form.phy_sign))
    {
       alert("You have to sign it.");
       setFocus(form.phy_sign);

       return false;
    }

    if (checkFieldEmpty(form.phy_signdate))
    {
       alert("You have to enter sign date.");
       setFocus(form.phy_signdate);

       return false;
    }
        
    return true;
}
</script>
<FORM name="testform" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Tranfer">
<INPUT type="hidden" name="id" value="<%=trInfo.glInfo.ID%>">
<table width="100%" class="table table-bordered2" style="border: 1px solid #cccccc">
 <tr>
  <td align="center" colspan="2"><font size="3"><b>The below is the summary of requisition from one patient. Is this your patient?</b></font></td>
 </tr>
 <tr>
  <td colspan="2">
  <div id="id_physiciansign" style="display:none">
  <table width="100%" style="border: 1px solid #2f5496">
  <tr bgcolor="#2f5496">
    <td colspan="7" height="28" align="center"><font size="3" color="#ffffff">STATEMENT OF MEDICAL NECESSITY</font></td>
  </tr>
 <tr>
    <td colspan="7" align="center" height="32"><b>Informed Consent and Statement of Medical Necessity</b></td>
  </tr>
  <tr>
    <td colspan="7"><div style="text-align:justify;padding-left:10px;padding-right:10px"><font size="1">
     I have supplied information to the patient regarding genetic testing and the patient has given consent for genetic testing to be performed. I further confirm that this test is medically necessary for the diagnosis, detection or treatment of a disease, illness, impairment, symptom, syndrome or disorder, and the results will be used in the medical management and treatment decisions for the patient. I confirm that the person listed in the Ordering Physician space above is authorized by law to order the test(s) requested herein.   </font></div>
    </td>
  </tr>
  <tr>
    <td align="right" width="17%" nowrap height="46"><font color="red">* Your Name: &nbsp; </font></td>
    <td width="33%"><input type="text" maxlength=40 value="<%=Utilities.getValue(trInfo.glInfo.Phy_Name)%>" name="phy_name" style="width:170px" class="form-control input-sm"></td>
    <td align="right" width="14%" nowrap><font color="red">* Signature: &nbsp; </font></td>
    <td width="33%"><input type="text" maxlength=40 value="<%=Utilities.getValue(trInfo.glInfo.Phy_Sign)%>" name="phy_sign" style="width:170px" class="form-control input-sm"></td>
    <td align="right" width="14%" nowrap>* Date: &nbsp; </td>
    <td width="36%"><input type="text" class="datepicker" maxlength=10 value="<%=Utilities.getValue(trInfo.glInfo.Phy_SignDate)%>" name="phy_signdate" style="width:140px" class="form-control input-sm"></td>
    <td width="2%">&nbsp;</td>
  </tr>            
  <tr><td colspan="7" height="10" style="border-bottom:1px solid #cccccc"></td></tr>
  <tr>
   <td align="center" colspan="7" height="60">
       <input class="btn btn-default active" type="submit" name='submit' value="I Agree" style="width:140px;height:36px; font-size:14px" onClick="return submitValidateForm(submitIGree, document.testform, 'id_mainarea', 'next');">
   </td>
  </tr>
  <tr><td colspan="6" height="2"></td></tr>
  </table>
  </div>
  </td>
 </tr>
 <tr>
  <td width="50%" align="center"><input class="btn btn-success" type="button" name='yes' value="Yes" style="width:120px;height:36px; font-size:14px" onClick="return toggleShowIAgree('id_physiciansign')"></td>
  <td align="center"><input class="btn btn-info" type="button" name='no' value="No" style="width:120px;height:36px; font-size:14px" onClick="return submitNavigate('Dashboard', 'id_mainarea')"></td>
 </tr>
</table>
<div class="panel panel-success">
<div class="panel-heading" align="center"><font size="3"><%="Summary of Requisition Form"%></font></div>
<div class="panel-body">
<%@ include file="patient/summary.jsp"%>
 </div>
</div>
</FORM>    