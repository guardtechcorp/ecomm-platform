<%@ page import="com.zyzit.weboffice.database.Apollogen.model.ConsentInfo" %>
<%
    GeneralInfo glInfo = trInfo.getGeneral(0);
    ConsentInfo ctInfo = trInfo.getConcent(trInfo.glInfo.ID);
    String sImageGetUrl = "/Clinician?action=GetImage&id=" + glInfo.ID + "&customerid=" + glInfo.CustomerID + "&JSID=" + ss.getId();
%>
<script type="text/javascript">
var g_imageUrl = '<%=sImageGetUrl%>';
var g_customerId = 0;
$(document).ready(function()
{
    $('.datepicker').datepicker({
        format: 'mm/dd/yyyy'
//        startDate: '-3d'
    });
});
    
function submitConsent(form, next)
{
  if (next=="next"||next=="save")
  {
    if (checkFieldEmpty(form.patientsign2)||form.patientsign2.value.length<15)
    {
         alert("The patient has to sign.");
//         setFocus(form.patientsign2);

         return false;
    }

    if (checkFieldEmpty(form.signdate2))
    {
         alert("The patient has to enter sign date.");
         setFocus(form.signdate2);

         return false;
    }

  }

  return true;
}
</script>
<table width="100%" class="well well-sm">
<tr>
 <td>
     <ol class="breadcrumb">
       <li><a href="#" onclick="submitValidateForm(submitConsent, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.General.GetName()%>')"><%=NavigationInfo.Navigation.General.GetName()%></a></li>
       <li><a href="#" onclick="submitValidateForm(submitConsent, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Ordering.GetName()%>')"><%=NavigationInfo.Navigation.Ordering.GetName()%></a></li>
       <li class="active"><b><%=currentPage.GetName()%></b></li>
       <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Summary.GetName()%></font></li>
       <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Payment.GetName()%></font></li>
     </ol>
 </td>
</tr>
</table>
<FORM name="testform" action="/Patient" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Consent">
<INPUT type="hidden" name="id" value="<%=ctInfo.ID%>">
<table width="100%" style="border: 1px solid #2f5496">
<tr bgcolor="#2f5496">
  <td height="28" align="center" colspan="4"><font size="3" color="white"><b>Patient Informed Consent and Acknowledgement for Financial Responsibility</b></font></td>
</tr>
<tr>
 <td colspan="4" height="30" align="center">Informed Consent and Statement of Medical Necessity
 <br><b>INFORMED CONSENT FOR GENETIC TESTING</b>
 </td>
</tr>
<tr>
 <td colspan="4" height="40"></td>
</tr>
<tr>
  <td height="28" width="50%" colspan="2">&nbsp;First Name: <input type="text" maxlength=20 value="<%=Utilities.getValue(trInfo.glInfo.FirstName)%>" name="firstname" style="width:220px" disabled></td>
  <td height="28" width="50%" colspan="2">&nbsp;Last Name: <input type="text" maxlength=20 value="<%=Utilities.getValue(trInfo.glInfo.LastName)%>" name="lastname" style="width:220px" disabled></td>
</tr>
<tr>
  <td height="28" colspan="2" width="50%">&nbsp;DOB (MM/DD/YYYY): <input type="text" maxlength=20 value="<%=Utilities.getValue(trInfo.glInfo.BirthDay)%>" name="birthday" style="width:220px" disabled></td>
  <td height="28" colspan="2" width="50%"></td>
</tr>
<tr>
 <td colspan="4" height="28">I understand that my health care provider has ordered the following genetic testing for {me/my child}:</td>
</tr>
<tr>
 <td colspan="4" height="14" style="border-bottom: 1px solid #000000"></td>
</tr>
<tr>
 <td colspan="4" height="14" ><div style="text-align:justify;padding-left:10px;padding-right:10px">
<i> 
 This is a voluntary test to identify gene mutation associated with hereditary disease and health risks and you may wish to seek genetic counseling prior to signing this form. Read this form carefully before making your decision about testing.
</i>
<p><br>
<font size="3"><b>PURPOSE</b></font>
<br>
I am interested in obtaining a genetic test by submitting a biological sample of my own (blood, saliva, or other tissue). The purpose of this molecular genetic test is to ascertain if I am or my child is carrying mutation(s) predisposing to or causing disease or elevated health risks. The biological sample submitted is required for isolation and purification of DNA and molecular genetic testing by next generation sequence analysis of genes associated with hereditary health risks.
 <p></p>
<b>THE FOLLOWING POINTS WERE EXPLAINED AND I UNDERSTAND THAT:</b>
<p>
1. Due to the complexity of DNA based testing and the implications of the results, these results will be reported only through my designated physician(s) or genetic counselor (where allowed) and that I must contact my provider to obtain the results of the test. The test results, in addition, could be released to all who, by law, may have access to such data.
<p>
2. DNA-based studies performed are specific to the condition indicated above. The results should be evaluated in the context of personal and family health history, the results of physical examination, laboratory and hospital test, and clinical impression of my healthcare provider. I understand that possible result outcomes include positive, negative, and uncertain.
<p>
3. If results of the tests are uncertain (in the case of variants of unknown clinical significance) it may indicate that there is not enough information to determine whether this change is associated with an increased risk after thorough search of current literature and databases.
<p>
4. Unexpected results may be revealed by this test in rare instances. This test is designed to detect changes in genes that predispose a person to a certain health condition; however, it can sometimes uncover genetic conditions in a family unrelated to the targeted disease risks. Results also have the potential to reveal unexpected biological relationships, such as a different biological parent.
<p>
5. It is the responsibility of the referring physician or health care provider to understand the specific utility and limitations of the testing ordered, and to educate the patient regarding these limitations. While this test is designed to identify most detectable mutations in the genes analyzed, it is still possible there are mutations that this testing technology is unable to detect. In addition, there may be other genes associated with disease susceptibility that are not included on this panel or that are not known at this time.
<p>
6. The molecular genetic test occasionally may not generate results and that an additional blood, saliva, or tissue sample may be needed to obtain interpretable results.
<p>
7. Inaccurate results, though rare, may occur for (but are not limited to) the following reasons: sample mix-up, samples unavailable from critical family members, maternal contamination of prenatal samples, inaccurate reporting of family relationships, or technical problems.
<p>
8. The genetic tests results have implications for blood relatives. In consultation with an appropriate healthcare provider, I may wish to discuss sharing the test results with certain blood relatives who may be at risk.

 <p><br>
 <font size="3"><b>USE OF SPECIMENS FOR RESEARCH</b></font>
<br>After testing is completed, I understand that my blood, saliva, or tissue specimens may be disposed of or retained indefinitely for de-identified research, test validation, and/or education as long as my privacy is maintained. I understand that no compensation will be given for using the specimens submitted. I understand that I may refuse to submit my specimen for use in this way and may withdraw my consent at any time by contacting the laboratory. I understand that my refusal to consent to medical research will not affect my results. Indicate consent or denial below. If neither box is marked, consent is implied.
<br><br>Consent to the use of my sample for anonymous research:<input type="radio" value="1" name="specimens" <%=ctInfo.Specimens==1?"checked":""%>> Yes <input type="radio" value="2" name="specimens" <%=ctInfo.Specimens==2?"checked":""%>> No

 <p><br>
<font size="3"><b>RECOMMENDATIONS</b></font>
<br>
I understand that due to the dynamics of the medical genetics field, there continues to be new information and data. It is recommended that I keep in contact with my healthcare provider annually, to learn of any new developments in medical genetics and to provide any updates to my personal or family history which may affect my disease susceptibility risks.
<p><br>
<font size="3"><b>PATIENT CONSENT STATEMENT</b></font>
<br>
By signing below, I, the patient having the test performed, acknowledge that:
<br>
I have read or have had read to me all of the above statements and understand the information above and have had the opportunity to ask questions. I understand the procedure, the risks, benefits, limitations and the alternatives associated with this test. I can request a copy of this consent form. 
</div>
 </td>
</tr>
<tr>
    <td colspan="4" height="10" style="border-top: 1px solid #000000"></td>
</tr>
<tr>
    <td width="25%" align="right"><font color="red">* Patient's Signature: &nbsp;</font></td>
    <td width="30%">
        <input type="hidden" name="patientsign2" value='<%=Utilities.getValue(glInfo.PatientSign2)%>'>
        <div id="patsignarea2" onclick="return openSignPad('Patient2')" align="center"
             style="cursor: pointer;width: 190px; height: 50px; border: 1px solid #bbbbbb;background: #ffffff;padding:2px 2px 2px 2px">
            <% if (Utilities.getValueLength(glInfo.PatientSign2)>10 && glInfo.PatientSign2.indexOf("\"lines\":")>0) {%>
            <img src='<%=sImageGetUrl%>&type=Vector&data=Patient2&te=<%=Calendar.getInstance().getTime().getTime()%>' height="44">
            <% } %>
        </div>
    </td>
    <td width="20%" align="right">* Date: &nbsp;</td>
    <td><input class="datepicker" type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.SignDate2)%>" name="signdate2" style="width:200px"></td>
</tr>
<tr>
    <td colspan="4" height="10" style2="border-bottom: 1px solid #000000"></td>
</tr>
</table>
<table width="100%" align="center" border=0>
 <tr><td colspan="3" height="30"><hr style="border:2px solid #000000"></td>
</tr>
 <tr>
  <td width="20%">
     <input class="btn btn-default active" type="submit" name='goprev' value="< Previous" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitConsent, document.testform, 'id_mainarea', 'prev');">
  </td>
 <td align="center">
   <!--&nbsp;<input class="btn btn-default active" type="submit" name='gosave' value="Save" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitConsent, document.testform, null, 'save')">&nbsp;&nbsp;-->
   <span id="id_buttonmessage"></span>
 </td>
  <td align="right" width="30%">
     <input class="btn btn-default active" type="submit" name='submit' value="Next >" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitConsent, document.testform, 'id_mainarea', 'next');">
  </td>
 </tr>
</table>
</FORM>