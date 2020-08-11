<table width="100%" style="border: 1px solid #2f5496"  border=1 cellpadding="2" cellspacing="2">
<tr bgcolor="#2f5496">
  <td colspan="3" height="28" align="center"><font size="3" color="#ffffff"><b>Cardiology</b> - Clinical Information</font></td>
</tr>
<tr>
 <td height="90">&nbsp;&nbsp;This patient has a diagnosis of or is strongly suspected to have:&nbsp;
     <INPUT type="hidden" name="carddiagnosis" value="<%=Utilities.getValue(ccInfo.CardDiagnosis)%>">
  <br>
  &nbsp;&nbsp;<select id="cy_0" name="medication[]" multiple="multiple" size="10">
  <br>&nbsp;
<%
List<String> ltCode = web.getDiagnosticCode("Cardiology");
for (int i=0; i<ltCode.size(); i++) {
 String sCodedesc = ltCode.get(i);
 int nDash = sCodedesc.indexOf("-");
 String sCode = sCodedesc.substring(0, nDash).trim();
%>
<option value="<%=sCode%>" <%=getSelected(ccInfo.CardDiagnosis, sCode)%>><%=sCodedesc.substring(nDash+1).trim()%></option>
<% } %>
  </select>
 <br>&nbsp;&nbsp;<font size="2"><i><span id="s_cy_0"><%=Utilities.getValue(ccInfo.Medication).replaceAll(",", ", ")%></span></i></font>
 <br>&nbsp;&nbsp;And/Or Other: &nbsp;<INPUT type="texx" name="cardiother" value="<%=Utilities.getValue(ccInfo.CardiOther)%>" style="width: 300px">
 </td>
</tr>
<tr>
 <td height="30">&nbsp;&nbsp;Are the parents of this patient related to each other by blood:&nbsp;
     <select name="parentrelated">
       <option value="0" <%=ccInfo.ParentRelated==0?"selected":""%>>Unsure</option>
       <option value="1" <%=ccInfo.ParentRelated==1?"selected":""%>>Yes</option>
       <option value="2" <%=ccInfo.ParentRelated==2?"selected":""%>>No</option>
     </select>
 </td>
</tr>
<tr>
 <td height="30" valign="top"><br>&nbsp;&nbsp;Previous clinical testing or additional clinical findings:&nbsp;</td>
</tr>
<tr>
  <td>
   <table width="100%" style="border: 1px solid #b4c6e7" id="id_specialfinding">
<%
    int nStartNo = 200;
    List<TestResultInfo> ltFinding = trInfo.getTestResult(trInfo.glInfo.ID, TestResult.TYPE_SPECIALFIND);
    int nFindingRow = Math.max(2, ltFinding.size());
    for (int nIndex=0; nIndex<nFindingRow; nIndex++) {
        String title = "";
        String desc = "";
        if (nIndex<ltFinding.size())
        {
           TestResultInfo ttInfo = ltFinding.get(nIndex);
           title = ttInfo.Title;
           desc = ttInfo.Description;
        }
%>
        <tr style="border: 1px solid #b4c6e7">
         <td height="30">&nbsp;&nbsp;
             <select name="title<%=(nStartNo+nIndex)%>">
             <option value=""></option>
 <%
 ltCode = web.getDiagnosticCode("Findings");
 for (int i=0; i<ltCode.size(); i++) {
  String sCodedesc = ltCode.get(i);
  int nDash = sCodedesc.indexOf("-");
  String sCode = sCodedesc.substring(0, nDash).trim();
 %>
 <option value="<%=sCode%>" <%=getSelected(title, sCode)%>><%=sCodedesc.substring(nDash+1).trim()%></option>
 <% } %>
            </select>
         </td>
         <td>Special Result: <INPUT type="text" name="description<%=(nStartNo+nIndex)%>" value="<%=Utilities.getValue(desc)%>" style="width: 300px"></td>
        </tr>
<% } %>
    </table>
  <p>
  <table width="99%" align="center">
  <tr>
   <td>
     <input class="btn btn-default active" type="button" name="addmore" value="Add More Row" onClick="addMoreFindingRow()">
   </td>
  </tr>
  <tr><td height="6"></td></tr>
  </table>      
  </td>
</tr>
</table>
<p><br></p>