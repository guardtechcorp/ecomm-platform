<%@ page import="com.zyzit.weboffice.database.Apollogen.model.ConsentInfo" %>
<%
    GeneralInfo glInfo = trInfo.getGeneral(loginInfo.CustomerID);
    ConsentInfo ctInfo = trInfo.getConcent(trInfo.glInfo.ID);
    if (Utilities.getValueLength(glInfo.PreAuthEmail)==0)
    {
       if (loginInfo!=null)
          glInfo.PreAuthEmail = loginInfo.EMail;
       else
          glInfo.PreAuthEmail = glInfo.Phy_Email;
    }

    String sImageGetUrl = "/Clinician?action=GetImage&id=" + glInfo.ID + "&customerid=" + glInfo.CustomerID + "&JSID=" + ss.getId();
%>
<script type="text/javascript">
var g_imageUrl = '<%=sImageGetUrl%>';
$(document).ready(function()
{
    $('.datepicker').datepicker({
        format: 'mm/dd/yyyy'
    });
});    
</script>
<table width="100%" class="well well-sm">
<tr>
 <td>
     <ol class="breadcrumb">
       <li><a href="#" onclick="submitValidateForm(submitConsent, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.General.GetName()%>')"><%=NavigationInfo.Navigation.General.GetName()%></a></li>
 <% if (glInfo.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
        <li><a href="#" onclick="submitValidateForm(submitConsent, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Ordering.GetName()%>')"><%=NavigationInfo.Navigation.Ordering.GetName()%></a></li>
 <% } %>
       <li><a href="#" onclick="submitValidateForm(submitConsent, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Clinical.GetName()%>')"><%=NavigationInfo.Navigation.Clinical.GetName()%></a></li>
<% if (RequisitionWeb.tryEligibility(trInfo)) { %>
       <li><a href="#" onclick="submitValidateForm(submitConsent, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Eligibility.GetName()%>')"><%=NavigationInfo.Navigation.Eligibility.GetName()%></a></li>
<% } %>
       <li class="active"><b><%=currentPage.GetName()%></b></li>
       <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Summary.GetName()%></font></li>
     </ol>
 </td>
</tr>
</table>
<FORM name="testform" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Consent">
<INPUT type="hidden" name="id" value="<%=ctInfo.ID%>">
<table  width="100%" style="border: 1px solid #2f5496">
<tr bgcolor="#2f5496">
  <td height="28" align="center" colspan="4"><font size="3" color="#ffffff"><b>INFORMED CONSENT FOR GENETIC TESTING</b></font></td>
</tr>
<tr><td height="10" colspan="4"></td></tr>
<tr>
  <td height="28" width="50%" colspan="2">&nbsp;First Name: <input type="text" maxlength=20 value="<%=Utilities.getValue(trInfo.glInfo.FirstName)%>" name="firstname" style="width:220px" disabled></td>
  <td height="28" width="50%" colspan="2">&nbsp;Last Name: <input type="text" maxlength=20 value="<%=Utilities.getValue(trInfo.glInfo.LastName)%>" name="lastname" style="width:220px" disabled></td>
</tr>
<tr>
  <td height="28" width="50%" colspan="2">&nbsp;DOB (MM/DD/YYYY): <input type="text" maxlength=20 value="<%=Utilities.getValue(trInfo.glInfo.BirthDay)%>" name="birthday" style="width:220px" disabled></td>
  <td height="28" width="50%" colspan="2"></td>
</tr>
<tr>
 <td colspan="4" height="28">&nbsp; I understand that my health care provider has ordered the following genetic testing for {me/my child}:</td>
</tr>
<tr>
 <td colspan="4" height="14" style="border-bottom: 1px solid #000000"></td>
</tr>
<tr>
 <td colspan="4" height="14" ><div style="text-align:justify;padding-left:10px;padding-right:10px">
<%=web.getDescriptionText("CONSENT-1")%>
<br>onsent to the use of my sample for anonymous research: <input type="radio" value="1" name="specimens" <%=ctInfo.Specimens==1?"checked":""%>> Yes <input type="radio" value="2" name="specimens" <%=ctInfo.Specimens==2?"checked":""%>> No
<%=web.getDescriptionText("CONSENT-2")%>
 </div>
 </td>
</tr>
<tr>
    <td width="25%" align="right"><font color="red">* Patient's Signature: &nbsp;</font></td>
    <td width="30%">
        <input type="hidden" name="patientsign2" value='<%=Utilities.getValue(glInfo.PatientSign2)%>'>
        <div id="patsignarea2" onclick="return openSignPad('Patient2')" align="center"
             style="cursor: pointer;width: 190px; height: 50px; border: 1px solid #bbbbbb;background: #ffffff;padding:2px 2px 2px 2px">
            <% if (Utilities.getValueLength(glInfo.PatientSign2)>10 && glInfo.PatientSign2.indexOf("lines")==2) {%>
            <img src='<%=sImageGetUrl%>&type=Vector&data=Patient2&te=<%=Calendar.getInstance().getTime().getTime()%>' height="44">
            <% } %>
        </div>
    </td>
    <td width="20%" align="right">* Date: &nbsp;</td>
    <td><input class="datepicker" type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.SignDate2)%>" name="signdate2" style="width:200px"></td>
</tr>
<tr><td height="10" colspan="4"></td></tr>
</table>
<table width="100%" align="center" border=0>
 <tr><td colspan="3" height="30"><hr style="border:2px solid #000000"></td>
</tr>
 <tr>
  <td width="20%">
     <input class="btn btn-default active" type="submit" name='goprev' value="< Previous" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitConsent, document.testform, 'id_mainarea', 'prev');">
  </td>
 <td align="center">
   <span id="id_buttonmessage"></span>
 </td>
  <td align="right" width="30%">
     <input class="btn btn-default active" type="submit" name='submit' value="Next >" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitConsent, document.testform, 'id_mainarea', 'next');">
  </td>
 </tr>
</table>
</FORM>