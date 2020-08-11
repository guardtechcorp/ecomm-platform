<%@ page import="com.zyzit.weboffice.database.Apollogen.model.ConsentInfo" %>
<%
    boolean bPassed = web.eligibility(trInfo);
//    bPassed = false;
    String sDisabled = "";
    if (!bPassed)
    {
       if (trInfo.glInfo.BillType==GeneralInfo.ABillType.Medicare.GetValue())
          sDisabled = "disabled";
    }
%>
<script type="text/javascript">
function submitEligiblity(form, next)
{
  return true;
}
</script>
<table width="100%" class="well well-sm">
<tr>
 <td>
     <ol class="breadcrumb">
       <li><a href="#" onclick="submitValidateForm(submitEligiblity, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.General.GetName()%>')"><%=NavigationInfo.Navigation.General.GetName()%></a></li>
<% if (trInfo.glInfo.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
       <li><a href="#" onclick="submitValidateForm(submitEligiblity, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Ordering.GetName()%>')"><%=NavigationInfo.Navigation.Ordering.GetName()%></a></li>
<% } %>
       <li><a href="#" onclick="submitValidateForm(submitEligiblity, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Clinical.GetName()%>')"><%=NavigationInfo.Navigation.Clinical.GetName()%></a></li>
       <li class="active"><b><%=currentPage.GetName()%></b></li>
<% if (trInfo.glInfo.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
       <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Consent.GetName()%></font></li>
<% } %>
       <li class="active"><font color="#aaaaaa"><%=NavigationInfo.Navigation.Summary.GetName()%></font></li>
     </ol>
 </td>
</tr>
</table>
<p></p>
<FORM name="testform" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Eligiblity">
<table  width="100%" style="border: 1px solid #2f5496">
<tr bgcolor="#2f5496">
  <td height="28" align="center"><font size="3" color="#ffffff"><b>CLINICAL ELIGIBLITY</b></font></td>
</tr>
<tr><td height="6"></td></tr>
<tr>
 <td>
<div style="margin: 10px">

<% if (bPassed) { %>
<font color="green" size="4">
  This patient is eligible for genetic testing according to his/her medical insurance policy. Please click <b>'Next >'</b> button to proceed to informed consent page.
</font>
<% } else {
  CancerInfo ccInfo = trInfo.getCarcer(trInfo.glInfo.ID);
  StringBuffer sb = new StringBuffer();
  if (ccInfo.BreastCheck>0)
     sb.append("Breast");
  if (ccInfo.ColorectCheck>0)
  {
     if (sb.length()>0)
        sb.append(", ");
     sb.append("Breast");
  }
    if (ccInfo.EndometCheck>0)
    {
       if (sb.length()>0)
          sb.append(", ");
       sb.append("Endometrial");
    }
    if (ccInfo.OvarianCheck>0)
    {
       if (sb.length()>0)
          sb.append(", ");
       sb.append("Ovarian");
    }
    if (ccInfo.PancreatCheck>0)
    {
       if (sb.length()>0)
          sb.append(", ");
       sb.append("Pancreatic");
    }
    if (ccInfo.PancreatCheck>0)
    {
       if (sb.length()>0)
          sb.append(", ");
       sb.append("Prostate");
    }
    if (ccInfo.OtherCheck>0)
    {
       if (sb.length()>0)
          sb.append(", ");
       sb.append("Other");
    }
%>
<font size="3">
<% if (trInfo.glInfo.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
<%=web.getDescriptionText("ELIGBLITY-1")%>
<% } else { %>
<%=web.getDescriptionText("ELIGBLITY-2")%>
<% } %>
<p><br>
<%=web.getDescriptionText("ELIGBLITY-3")%>
<% if (trInfo.glInfo.BillType==GeneralInfo.ABillType.Insurance.GetValue()) { %>
<%=web.getDescriptionText("ELIGBLITY-4")%>
<% } %>
</font>
<% } %>    
</div>
 </td>
</tr>
<tr><td height="10"></td></tr>    
</table>
<table width="100%" style2="border: 1px solid #2f5496">
<tr><td colspan="3" height="30"><hr style="border:2px solid #000000"></td></tr>
 <tr>
  <td width="20%">
     <input class="btn btn-default active" type="submit" name='goprev' value="< Previous" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitEligiblity, document.testform, 'id_mainarea', 'prev');">
  </td>
 <td align="center">
   <span id="id_buttonmessage"></span>
 </td>
  <td align="right" width="30%">
     <input <%=sDisabled%> class="btn btn-default active" type="submit" name='submit' value="Next >" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitEligiblity, document.testform, 'id_mainarea', 'next');">
  </td>
 </tr>
</table>
</FORM>