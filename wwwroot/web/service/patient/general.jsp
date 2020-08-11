<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.model.NavigationInfo" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.GeneralInfo" %>
<%
    GeneralInfo glInfo = trInfo.getGeneral(0);
    glInfo.RequestType = RequisitionWeb.REQUEST_PATIENT;
    if (glInfo.CustomerID<0)
       glInfo.CustomerID = 0;

    int nGeneralId = glInfo.ID;
    if (nGeneralId<0)
       nGeneralId = 0;           
%>
<script>
$(document).ready(function()
{
    setRadioValue(document.testform.ethnicity, <%=glInfo.Ethnicity%>);
    setRadioValue(document.testform.sampletype, <%=glInfo.SampleType%>);
    fillBirthDay(document.testform, "<%=Utilities.getValue(glInfo.BirthDay)%>");
        
    $('.datepicker').datepicker({
        viewMode: 'years',
        format: 'mm/dd/yyyy'                
    });
});
</script>
<table width="100%" class="well well-sm">
 <tr>
  <td>
      <ol class="breadcrumb">
      <li class="active"><b><%=NavigationInfo.Navigation.General.GetName()%></b></li>
      <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Ordering.GetName()%></font></li>
      <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Consent.GetName()%></font></li>
      <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Summary.GetName()%></font></li>
      <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Payment.GetName()%></font></li>
      </ol>
  </td>
 </tr>
</table>
<FORM name="testform" action="/Patient" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-General">
<INPUT type="hidden" name="id" value="<%=glInfo.ID%>">
<TABLE class="table table-condensed" width="98%" align="center" border=0 cellpadding="1" cellspacing="1">
 <tr class="info">
   <td colspan=2><b>Patient Information</b></td>
 </tr>
<tr>
  <td width="26%" height="36" align="right">* First Name:</td>
  <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.FirstName)%>" name="firstname" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right" height="30">Middle Name:</td>
  <td align="left"><input maxlength=20 value="<%=Utilities.getValue(glInfo.MiddleName)%>" name="middlename" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
 <td align="right" height="30">* Last Name:</td>
 <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.LastName)%>" name="lastname" style="width:550px" class="form-control input-sm"></td>
</tr>
<tr>
  <td align="right" height="30" nowrap>* Date of Birth:</td>
  <td>
      <select name="bmonth" class2="form-control input-sm">
        <option value="" selected>Month</option>
        <option value="01">01</option>
        <option value="02">02</option>
        <option value="03">03</option>
        <option value="04">04</option>
        <option value="05">05</option>
        <option value="06">06</option>
        <option value="07">07</option>
        <option value="08">08</option>
        <option value="09">09</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
      </select>
      /
      <select name="bday" class2="form-control input-sm">
        <option value="" selected>Day</option>
<% for (int nDay=1; nDay<=31; nDay++) { %>
        <option value="<%=nDay<10?("0"+nDay):(""+nDay)%>"><%=nDay<10?("0"+nDay):(""+nDay)%></option>
<% } %>
      </select>
      /
      <select name="byear" class2="form-control input-sm">
        <option value="" selected>Year</option>
<% for (int nYear=1900; nYear<=Calendar.getInstance().get(Calendar.YEAR); nYear++) { %>
        <option value="<%=nYear%>"><%=nYear%></option>
<% } %>
      </select><input type="hidden" value="<%=Utilities.getValue(glInfo.BirthDay)%>" name="birthday">            
  </td>
</tr>
<tr>
  <td align="right">* Gender:</td>
  <td><input type="radio" value="1" name="gender" <%=glInfo.Gender==1?"checked":""%>>Male&nbsp;&nbsp;&nbsp;
       <input type="radio" value="2" name="gender" <%=glInfo.Gender==2?"checked":""%>> Female
  </td>
</tr>
<tr>
  <td align="right" height="30">* Ethnic Background:</td>
  <td><input type="radio" value="<%=GeneralInfo.AEnthic.African.GetValue()%>" name="ethnicity"> African American
     &nbsp;<input type="radio" value="<%=GeneralInfo.AEnthic.Asian.GetValue()%>" name="ethnicity"> Asian/Pacific Islander
     &nbsp;<input type="radio" value="<%=GeneralInfo.AEnthic.Caucasian.GetValue()%>" name="ethnicity"> Caucasian
     &nbsp; <input type="radio" value="<%=GeneralInfo.AEnthic.Hispanic.GetValue()%>" name="ethnicity"> Hispanic
     <br><input type="radio" value="<%=GeneralInfo.AEnthic.Mediterranean.GetValue()%>" name="ethnic"> Mediterranean
     &nbsp; <input type="radio" value="<%=GeneralInfo.AEnthic.American.GetValue()%>" name="ethnicity"> Native American
     <input type="radio" value="<%=GeneralInfo.AEnthic.Other.GetValue()%>" name="ethnicity"> &nbsp;
    Other <input type="text" value="<%=Utilities.getValue(glInfo.EthnicOther)%>" name="ethnicother" maxlength="20" style="width:160px" class="input-sm">
  </td>
</tr>
    <tr>
      <td align="right">* Address:</td>
      <td ><input maxlength=60 value="<%=Utilities.getValue(glInfo.Address)%>" name="address" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right">* City:</td>
      <td><input maxlength=30 value="<%=Utilities.getValue(glInfo.City)%>" name="city" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right">* State:</td>
      <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.State)%>" name="state" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right">* Zip:</td>
      <td><input maxlength=10 value="<%=Utilities.getValue(glInfo.Zip)%>" name="zip" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right">* Phone: </td>
      <td nowrap><input maxlength=20 value="<%=Utilities.getValue(glInfo.Phone)%>" name="phone" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
      <td align="right">* E-Mail: </td>
      <td><input maxlength=50 value="<%=Utilities.getValue(glInfo.EMail)%>" name="email" style="width:550px" class="form-control input-sm"></td>
    </tr>

 <tr class="info">
  <td colspan=2><b>Referring Physician Information</b>  
  </td>
</tr>
 <tr style="border-bottom: 2px solid #ffffff">
   <td align="right"></td>
   <td><input type="checkbox" name="providernpi" value="Yes" <%="Yes".equalsIgnoreCase(glInfo.ProviderNpi)?"checked":""%> onchange="return onShowByCheckBox(this, false, 'id_referphy')">
   Need Help Finding a Doctor</td>
 </tr>
<tr>
 <td colspan="2">
  <div id="id_referphy" style="display:<%="Yes".equalsIgnoreCase(glInfo.ProviderNpi)?"none":"inline"%>">
   <table width="100%" class="table table-condensed" align="center" border=0 cellpadding="1" cellspacing="1">
       <tr>
        <td align="right" width="26%">* Name (First, MI., Last):</td>
        <td width="74%"><input type="text" maxlength=40 value="<%=Utilities.getValue(glInfo.Phy_Name)%>" name="phy_name" style="width:550px" class="form-control input-sm"></td>
       </tr>
       <tr>
        <td align="right" nowrap>* Institution:</td>
        <td><input type="text" maxlength=50 value="<%=Utilities.getValue(glInfo.Institution)%>" name="institution" style="width:550px" class="form-control input-sm"></td>
       </tr>
       <tr>
         <td align="right" height="30">Address:</td>
         <td><input maxlength=60 value="<%=Utilities.getValue(glInfo.Phy_Address)%>" name="phy_address" style="width:550px" class="form-control input-sm"></td>
       </tr>
       <tr>
         <td align="right">City:</td>
         <td><input maxlength=30 value="<%=Utilities.getValue(glInfo.Phy_City)%>" name="phy_city" style="width:550px" class="form-control input-sm"></td>
       </tr>
       <tr>
         <td align="right">State:</td>
         <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.Phy_State)%>" name="phy_state" style="width:550px" class="form-control input-sm"></td>
       </tr>
       <tr>
         <td align="right">Zip:</td>
         <td><input maxlength=10 value="<%=Utilities.getValue(glInfo.Phy_Zip)%>" name="phy_zip" style="width:550px" class="form-control input-sm"></td>
       </tr>
       <tr>
         <td align="right">Phone:</td>
         <td><input maxlength=20 value="<%=Utilities.getValue(glInfo.Phy_Phone)%>" name="phy_phone" style="width:550px" class="form-control input-sm"></td>
       </tr>
       <tr>
         <td align="right">Fax:</td>
         <td ><input maxlength=20 value="<%=Utilities.getValue(glInfo.Phy_Fax)%>" name="phy_fax" style="width:550px" class="form-control input-sm"></td>
       </tr>
       <tr>
         <td align="right">E-Mail:</td>
         <td ><input maxlength=50 value="<%=Utilities.getValue(glInfo.Phy_Email)%>" name="phy_email" style="width:550px" class="form-control input-sm"></td>
       </tr>
    </table>
  </div>    
 </td>
</tr>
 <tr class="info">
  <td colspan=2><b>Clinical and Sample Information</b></td>
</tr>
 <tr>
   <td align="right">Clinical Indications:</td>
   <td ><input maxlength=50 value="<%=Utilities.getValue(glInfo.Indications)%>" name="indications" style="width:550px" class="form-control input-sm"></td>
 </tr>
 <tr>
   <td align="right">* Type of Sample Kit Wanted::</td>
   <td><input type="radio" value="<%=GeneralInfo.ASampleType.Blood.GetValue()%>" name="sampletype"> Blood Collection Kit &nbsp;&nbsp;
    <input type="radio" value="<%=GeneralInfo.ASampleType.Saliva.GetValue()%>" name="sampletype"> Saliva Collection Kit
<!--    SAMPLE COLLECTION DATE: <input class="datepicker" type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.DateCollect)%>" name="datecollect" style="width:180px">-->
</td>
 </tr>
 <tr>
  <td colspan="2">
    <table width="100%">
      <tr>
        <td width="45%" nowrap valign="top">&nbsp;&nbsp;<b><i>Please check all of the following situations that apply:</i></b></td>
        <td><input type="checkbox" value="1" name="narrow" <%=glInfo.Narrow>0?"checked":""%>> Patient has had bone marrow transplant
           <br><input type="checkbox" value="1" name="transfusion" <%=glInfo.Transfusion>0?"checked":""%>> Patient has had transfusion within the past 30 days
           <br><input type="checkbox" value="1" name="familypregnant" <%=glInfo.FamilypRegnant>0?"checked":""%>> Patient or immediate family member is pregnant
        </td>
      </tr>
    </table>
  </td>
 </tr>
</TABLE>
<p></p>
<table width="100%" align="center" border=0>
<tr><td colspan="3"><hr style="border:2px solid #000000"></td></tr>           
<tr>
<td width="40%" align="center">
    <span id="id_buttonmessage"></span>
</td>
 <td align="center" width="40%"></td>
 <td align="right">
   <input class="btn btn-default active" type="submit" name="update" value="Next >" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitPatientGeneralInfo, document.testform, 'id_mainarea', 'next');">
</td>
</tr>
</table>
</FORM>