<table width="100%" style="border: 1px solid #2f5496"  border=1 cellpadding="2" cellspacing="2">
<tr bgcolor="#2f5496">
  <td colspan="3" height="28" align="center"><font size="3" color="#ffffff"><b>Pharmacogenomics (PGX)</b> - Clinical Information</font></td>
</tr>
<tr>
 <td height="90">&nbsp;&nbsp;The current and/or intended medications include:&nbsp;
     <INPUT type="hidden" name="medication" value="<%=Utilities.getValue(ccInfo.Medication)%>">
  <br>
  &nbsp;&nbsp;<select id="pg_0" name="medication[]" multiple="multiple" size="10">
  <br>&nbsp;
<%
List<String> ltCode = web.getDiagnosticCode("Medication");
for (int i=0; i<ltCode.size(); i++) {
 String sCodedesc = ltCode.get(i);
 int nDash = sCodedesc.indexOf("-");
 String sCode = sCodedesc.substring(0, nDash).trim();
%>
<option value="<%=sCode%>" <%=getSelected(ccInfo.Medication, sCode)%>><%=sCodedesc.substring(nDash+1).trim()%></option>
<% } %>
  </select>
 &nbsp;&nbsp;<font size="2"><i><span id="s_pg_0"><%=Utilities.getValue(ccInfo.Medication).replaceAll(",", ", ")%></span></i></font>
 <br>&nbsp;&nbsp;And/Or Other: &nbsp;<INPUT type="texx" name="medother" value="<%=Utilities.getValue(ccInfo.MedOther)%>" style="width: 300px">
 </td>
</tr>
<tr>
 <td height="90">&nbsp;&nbsp;The patient's ICD-10 diagnostic codes (clinical diagnosis) include:&nbsp;
 <INPUT type="hidden" name="icdcode" value="<%=Utilities.getValue(ccInfo.IcdCode)%>">
  <br>
  &nbsp;&nbsp;<select id="pg_1" name="icdcode[]" multiple="multiple" size="10">
  <br>&nbsp;
<%
ltCode = web.getDiagnosticCode("DiagnosticCode");
for (int i=0; i<ltCode.size(); i++) {
 String sCodedesc = ltCode.get(i);
 int nDash = sCodedesc.indexOf("-");
 String sCode = sCodedesc.substring(0, nDash).trim();
%>
<option value="<%=sCode%>" <%=getSelected(ccInfo.IcdCode, sCode)%>><%=sCodedesc.substring(nDash+1).trim()%></option>
<% } %>
  </select>
 <br>&nbsp;&nbsp;<font size="2"><i><span id="s_pg_1"><%=Utilities.getValue(ccInfo.IcdCode).replaceAll(",", ", ")%></span></i></font>
 <br>&nbsp;&nbsp;And/Or Other: &nbsp;<INPUT type="texx" name="icdother" value="<%=Utilities.getValue(ccInfo.IcdOther)%>" style="width: 300px">
 </td>
</tr>
</table>
<p><br></p>