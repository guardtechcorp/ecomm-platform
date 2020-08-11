<table  width="100%" style="border: 1px solid #2f5496">
<tr bgcolor="#2f5496">
  <td colspan="3" height="28" align="center"><font size="3" color="#ffffff"><b>CANCER TEST</b> - PATIENT CLINICAL HISTORY</font></td>
</tr>
<tr><td height="6" colspan="3"></td></tr>
 <tr>
 <td valign="top" height="36">
&nbsp;&nbsp;Personal History of Cancer/Tumor/Polyp: &nbsp;&nbsp;
  <input type="radio" value="1" name="cancerhistory" <%=ccInfo.Cancerhistory==1?"checked":""%> onclick="onClickPersionHistory(1,'personalhistory')">Yes &nbsp;&nbsp;
  <input type="radio" value="2" name="cancerhistory" <%=ccInfo.Cancerhistory==2?"checked":""%> onclick="onClickPersionHistory(2,'personalhistory')">No
 </td>
</tr>
<tr>
 <td>
<div id="personalhistory" style="display:<%=ccInfo.Cancerhistory==1?"block":"none"%>">

 <table width="99%" style="border: 1px solid #2f5496" align="center">
 <tr>
  <td align="center" height="32" colspan="2">
    &nbsp;&nbsp;<input type="checkbox" value="1" name="breastcheck" <%=ccInfo.BreastCheck>0?"checked":""%>  onclick="onCancerChange(this, '0')"> Breast
    &nbsp;&nbsp;<input type="checkbox" value="1" name="colorectcheck" <%=ccInfo.ColorectCheck>0?"checked":""%> onclick="onCancerChange(this, '1')"> Colorectal
    &nbsp;&nbsp;<input type="checkbox" value="1" name="endometcheck" <%=ccInfo.EndometCheck>0?"checked":""%>  onclick="onCancerChange(this, '2')"> Endometrial
    &nbsp;&nbsp;<input type="checkbox" value="1" name="ovariancheck" <%=ccInfo.OvarianCheck>0?"checked":""%>  onclick="onCancerChange(this, '3')"> Ovarian
    &nbsp;&nbsp;<input type="checkbox" value="1" name="pancreatcheck" <%=ccInfo.PancreatCheck>0?"checked":""%> onclick="onCancerChange(this, '4')"> Pancreatic
    &nbsp;&nbsp;<input type="checkbox" value="1" name="prostatecheck" <%=ccInfo.ProstateCheck>0?"checked":""%>  onclick="onCancerChange(this, '5')"> Prostate
    &nbsp;&nbsp;<input type="checkbox" value="1" name="othercheck" <%=ccInfo.OtherCheck>0?"checked":""%>  onclick="onCancerChange(this, '6')"> Other Cancers/Diagnosis
  </td>
 </tr>
 <tr>
 <td colspan="2">
  <table width="100%" border=1>
  <tr bgcolor="#b4c6e7">
    <td height="28" width="200" align="center"><b>Cancer/Tumor</b></td>
    <td align="center"><b>Diagnosis and Previous Studies</b></td>
  </tr>
<tr>
<td colspan="2">
  <div id="id_0" style="display:<%=ccInfo.BreastCheck>0?"block":"none"%>">
  <table width="100%" border="1">
  <tr>
    <td height="28" width="200"  align="center">Breast Cancer</td>
    <td>
     <table width="100%">
      <tr>
        <td height="32">
         &nbsp;* Age of Diagnosis:&nbsp;<input type="text" value="<%=Utilities.getValue(ccInfo.Breastage)%>" name="breastage" maxlength="5" style="width: 60px">
        &nbsp;Triple negative:&nbsp;
        <select name="breastnegative">
          <option value="0" <%=ccInfo.BreastNegative==0?"selected":""%>>Unsure</option>
          <option value="1" <%=ccInfo.BreastNegative==1?"selected":""%>>Yes</option>
          <option value="2" <%=ccInfo.BreastNegative==2?"selected":""%>>No</option>
        </select>
        </td>
      </tr>
      <tr>
       <td height="28">
           &nbsp;An additional primary breast cancer:&nbsp;
           <select name="breast2nd">
             <option value="0" <%=ccInfo.Breast2nd==0?"selected":""%>>Unsure</option>
             <option value="1" <%=ccInfo.Breast2nd==1?"selected":""%>>Yes</option>
             <option value="2" <%=ccInfo.Breast2nd==2?"selected":""%>>No</option>
           </select>
       </td>
      </tr>
      <tr>
       <td>&nbsp;* ICD-10 Diagnostic Code:&nbsp;<INPUT type="hidden" name="breastcode" value="">
        <br>
        &nbsp;<select id="cc_0" name="bcode[]" multiple="multiple" size="10">
        <br>&nbsp;
<%   //. C50.019 - Malignant neoplasm of nipple and areola, unspecified female breast
    List<String> ltCode = web.getDiagnosticCode("Breast");
    for (int i=0; i<ltCode.size(); i++) {
       String sCodedesc = ltCode.get(i);
       int nDash = sCodedesc.indexOf("-");
       String sCode = sCodedesc.substring(0, nDash).trim();
%>
      <option value="<%=sCode%>" <%=getSelected(ccInfo.BreastCode, sCode)%>><%=sCodedesc%></option>
<% } %>
        </select>
       </td>
      </tr>
      <tr><td height="2">&nbsp;&nbsp;<font size="2"><i><span id="s_cc_0"><%=Utilities.getValue(ccInfo.BreastCode).replaceAll(",", ", ")%></span></i></font></td></tr>
     </table>
    </td>
  </tr>
  </table>
 </div>
  <div id="id_1" style="display:<%=ccInfo.ColorectCheck>0?"block":"none"%>">
  <table width="100%" border="1">
  <tr>
    <td height="28" width="200" align="center">Colorectal Cancer</td>
    <td>
    <table width="100%">
     <tr>
       <td height="32">
        &nbsp;* Age of Diagnosis:&nbsp;<input type="text" value="<%=Utilities.getValue(ccInfo.ColorectAge)%>" name="colorectage" maxlength="5" style="width: 60px">
        &nbsp;Had>20 cumulative colorectal adenomatous polyps:&nbsp;
        <select name="colorectpolyps">
          <option value="0" <%=ccInfo.ColorectPolyps==0?"selected":""%>>Unsure</option>
          <option value="1" <%=ccInfo.ColorectPolyps==1?"selected":""%>>Yes</option>
          <option value="2" <%=ccInfo.ColorectPolyps==2?"selected":""%>>No</option>
        </select>
       </td>
      </tr>
      <tr>
       <td height="28">
           &nbsp;Positive result for MSI or IHC:&nbsp;
           <select name="colorectresult">
             <option value="0" <%=ccInfo.ColorectResult==0?"selected":""%>>Unsure</option>
             <option value="1" <%=ccInfo.ColorectResult==1?"selected":""%>>Yes</option>
             <option value="2" <%=ccInfo.ColorectResult==2?"selected":""%>>No</option>
           </select>
           &nbsp;Known Lynch Syndrome in family:&nbsp;
           <select name="colorectlynch">
             <option value="0" <%=ccInfo.ColorectLynch==0?"selected":""%>>Unsure</option>
             <option value="1" <%=ccInfo.ColorectLynch==1?"selected":""%>>Yes</option>
             <option value="2" <%=ccInfo.ColorectLynch==2?"selected":""%>>No</option>
           </select>
       </td>
      </tr>
      <tr>
       <td>
        &nbsp;* ICD-10 Diagnostic Code:&nbsp;<INPUT type="hidden" name="colorectcode" value=""><br>
        &nbsp;<select id="cc_1" name="ccode[]" multiple="multiple" size="10">
<%
    List<String> ltCode2 = web.getDiagnosticCode("Colorectal");
    for (int i=0; i<ltCode2.size(); i++) {
       String sCodedesc = ltCode2.get(i);
       int nDash = sCodedesc.indexOf("-");
       String sCode = sCodedesc.substring(0, nDash).trim();
%>
      <option value="<%=sCode%>" <%=getSelected(ccInfo.ColorectCode, sCode)%>><%=sCodedesc%></option>
<% } %>
        </select>
       </td>
      </tr>
      <tr><td height="2">&nbsp;&nbsp;<font size="2"><i><span id="s_cc_1"><%=Utilities.getValue(ccInfo.ColorectCode).replaceAll(",", ", ")%></span></i></font></td></tr>
    </table>
    </td>
  </tr>
 </table>
</div>
  <div id="id_2" style="display:<%=ccInfo.EndometCheck>0?"block":"none"%>">
  <table width="100%" border="1">
  <tr>
     <td height="28" width="200"  align="center">Endometrial Cancer</td>
     <td>
     <table width="100%">
      <tr>
        <td height="32">
         &nbsp;* Age of Diagnosis:&nbsp; <input type="text" value="<%=Utilities.getValue(ccInfo.EndometAge)%>" name="endometage" maxlength="5" style="width: 60px">
        </td>
      </tr>
      <tr>
        <td>
         &nbsp;* ICD-10 Diagnostic Code:&nbsp;<INPUT type="hidden" name="endometcode" value=""><br>
         &nbsp;<select id="cc_2" name="ecode[]" multiple="multiple" size="10">
 <%
     List<String> ltCode3 = web.getDiagnosticCode("Endometrial");
     for (int i=0; i<ltCode3.size(); i++) {
        String sCodedesc = ltCode3.get(i);
        int nDash = sCodedesc.indexOf("-");
        String sCode = sCodedesc.substring(0, nDash).trim();
 %>
       <option value="<%=sCode%>" <%=getSelected(ccInfo.EndometCode, sCode)%>><%=sCodedesc%></option>
 <% } %>
         </select>
        </td>
      </tr>
      <tr><td height="2">&nbsp;&nbsp;<font size="2"><i><span id="s_cc_2"><%=Utilities.getValue(ccInfo.EndometCode).replaceAll(",", ", ")%></span></i></font></td></tr>
      </table>
     </td>
  </tr>
  </table>
  </div>
  <div id="id_3" style="display:<%=ccInfo.OvarianCheck>0?"block":"none"%>">
  <table width="100%" border="1">
  <tr>
     <td height="28"  width="200"  align="center">Ovarian Cancer</td>
     <td>
     <table width="100%">
      <tr>
        <td height="32">
         &nbsp;Age of Diagnosis:&nbsp; <input type="text" value="<%=Utilities.getValue(ccInfo.OvarianAge)%>" name="ovarianage" maxlength="5" style="width: 60px">
        </td>
       </tr>
       <tr>
       <td>
         &nbsp;* ICD-10 Diagnostic Code:&nbsp;<INPUT type="hidden" name="ovariancode" value=""><br>
         &nbsp;<select id="cc_3" name="ocode[]" multiple="multiple" size="10">
 <%
     List<String> ltCode4 = web.getDiagnosticCode("Ovarian");
     for (int i=0; i<ltCode4.size(); i++) {
        String sCodedesc = ltCode4.get(i);
        int nDash = sCodedesc.indexOf("-");
        String sCode = sCodedesc.substring(0, nDash).trim();
 %>
       <option value="<%=sCode%>" <%=getSelected(ccInfo.OvarianCode, sCode)%>><%=sCodedesc%></option>
 <% } %>
         </select>
        </td>
      </tr>
      <tr><td height="2">&nbsp;&nbsp;<font size="2"><i><span id="s_cc_3"><%=Utilities.getValue(ccInfo.OvarianCode).replaceAll(",", ", ")%></span></i></font></td></tr>
      </table>
     </td>
  </tr>
  </table>
  </div>

  <div id="id_4" style="display:<%=ccInfo.PancreatCheck>0?"block":"none"%>">
  <table width="100%" border="1">
  <tr>
     <td height="28" width="200"  align="center">Pancreatic Cancer</td>
     <td>
     <table width="100%">
      <tr>
        <td height="32">
         &nbsp;* Age of Diagnosis:&nbsp; <input type="text" value="<%=Utilities.getValue(ccInfo.PancreatAge)%>" name="pancreatage" maxlength="5" style="width: 60px">
        </td>
      </tr>
      <tr>
        <td>
         &nbsp;* ICD-10 Diagnostic Code:&nbsp;<INPUT type="hidden" name="pancreatcode" value=""><br>
         &nbsp;<select id="cc_4" name="pcode[]" multiple="multiple" size="10">
 <%
     List<String> ltCode5 = web.getDiagnosticCode("Pancreatic");
     for (int i=0; i<ltCode5.size(); i++) {
        String sCodedesc = ltCode5.get(i);
        int nDash = sCodedesc.indexOf("-");
        String sCode = sCodedesc.substring(0, nDash).trim();
 %>
       <option value="<%=sCode%>" <%=getSelected(ccInfo.PancreatCode, sCode)%>><%=sCodedesc%></option>
 <% } %>
         </select>
        </td>
      </tr>
      <tr><td height="2">&nbsp;&nbsp;<font size="2"><i><span id="s_cc_4"><%=Utilities.getValue(ccInfo.PancreatCode).replaceAll(",", ", ")%></span></i></font></td></tr>
      </table>
     </td>
  </tr>
  </table>
  </div>

  <div id="id_5" style="display:<%=ccInfo.ProstateCheck>0?"block":"none"%>">
  <table width="100%" border="1">
  <tr>
     <td height="28"  width="200"  align="center">Prostate Cancer</td>
     <td>
     <table width="100%">
      <tr>
        <td height="32">
         &nbsp;* Age of Diagnosis:&nbsp; <input type="text" value="<%=Utilities.getValue(ccInfo.ProstateAge)%>" name="prostateage" maxlength="5" style="width: 60px">
         &nbsp;Gleason score >= 7:&nbsp;
         <select name="gleasonscore">
           <option value="0" <%=ccInfo.GleasonScore==0?"selected":""%>>Unsure</option>
           <option value="1" <%=ccInfo.GleasonScore==1?"selected":""%>>Yes</option>
           <option value="2" <%=ccInfo.GleasonScore==2?"selected":""%>>No</option>
         </select>
        </td>
       </tr>
      <tr>
       <td>
         &nbsp;* ICD-10 Diagnostic Code:&nbsp;<INPUT type="hidden" name="prostatecode" value=""><br>
         &nbsp;<select id="cc_5" name="rcode[]" multiple="multiple" size="10">
 <%
     List<String> ltCode6 = web.getDiagnosticCode("Prostate");
     for (int i=0; i<ltCode6.size(); i++) {
        String sCodedesc = ltCode6.get(i);
        int nDash = sCodedesc.indexOf("-");
        String sCode = sCodedesc.substring(0, nDash).trim();
 %>
       <option value="<%=sCode%>" <%=getSelected(ccInfo.ProstateCode, sCode)%>><%=sCodedesc%></option>
 <% } %>
         </select>
        </td>
       </tr>
       <tr><td height="2">&nbsp;&nbsp;<font size="2"><i><span id="s_cc_5"><%=Utilities.getValue(ccInfo.ProstateCode).replaceAll(",", ", ")%></span></i></font></td></tr>
       </table>
      </td>
  </tr>
  </table>
  </div>

  <div id="id_6" style="display:<%=ccInfo.OtherCheck>0?"block":"none"%>">
  <table width="100%" border="1">
  <tr>
     <td height="28" width="200" align="center">Other Cancers/Diagnosis</td>
     <td>
     <table width="100%">
      <tr>
        <td height="32">
         &nbsp;* Age of Diagnosis:&nbsp; <input type="text" value="<%=Utilities.getValue(ccInfo.OtherAge)%>" name="otherage" maxlength="5" style="width: 60px">
        </td>
       </tr>
       <tr>
        <td>
         &nbsp;* ICD-10 Diagnostic Code:&nbsp;<INPUT type="hidden" name="othercode" value=""><br>
         &nbsp;<select id="cc_6" name="tcode[]" multiple="multiple" size="10">
 <%
     List<String> ltCode7 = web.getDiagnosticCode("Others");
     for (int i=0; i<ltCode7.size(); i++) {
        String sCodedesc = ltCode7.get(i);
        int nDash = sCodedesc.indexOf("-");
        String sCode = sCodedesc.substring(0, nDash).trim();
 %>
       <option value="<%=sCode%>" <%=getSelected(ccInfo.OtherCode, sCode)%>><%=sCodedesc%></option>
 <% } %>
         </select>
      </td>
     </tr>
     <tr>
       <td>
         &nbsp;Other unlisted ICD-10 diagnostic codes:&nbsp; <input type="text" value="<%=Utilities.getValue(ccInfo.OtherMore)%>" name="othermore" maxlength="1023" style="width: 250px">
      </td>
     </tr>
     <tr><td height="2">&nbsp;&nbsp;<font size="2"><i><span id="s_cc_6"><%=Utilities.getValue(ccInfo.OtherCode).replaceAll(",", ", ")%></span></i></font></td></tr>
     </table>
    </td>
  </tr>
  </table>
</div>
</td>
</tr>
 </table>
</td>
</table>
<p>
  </div>
 </td>
</tr>
<tr><td colspan="3" height="4"></td></tr>
 <tr>
   <td height="32" colspan="3" style="border-bottom: 1px solid #cccccc; border-top: 1px solid #cccccc">&nbsp;&nbsp;<b>Has Ashkenazi Jewish Ancestry? </b>
   <select name="ethnicity">
     <option value="0" <%=ccInfo.Ethnicity==0?"selected":""%>>Unsure</option>
     <option value="1" <%=ccInfo.Ethnicity==1?"selected":""%>>Yes</option>
     <option value="2" <%=ccInfo.Ethnicity==2?"selected":""%>>No</option>
   </select>
   </td>
 </tr>
 <tr>
  <td height="28" colspan="3">&nbsp;&nbsp;<b>Previous genetic testing (of patient's or family members'):</b></td>
</tr>
<tr>
  <td colspan="3">
    <table width="100%" align="center" style2="border: 1px solid #b4c6e7" id="id_testresult">
<%
   List<TestResultInfo> ltTestResult = trInfo.getTestResult(trInfo.glInfo.ID, TestResult.TYPE_TESTRESULT);
   int nTestRow = Math.max(2, ltTestResult.size());
   for (int nIndex=0; nIndex<nTestRow; nIndex++) {
       String title = null;
       String desc = null;
       if (nIndex<ltTestResult.size())
       {
          TestResultInfo ttInfo = ltTestResult.get(nIndex);
          title = ttInfo.Title;
          desc = ttInfo.Description;
       }
%>
    <tr>
      <td height="30" width="45%">&nbsp;&nbsp;Test: <input type="text" value="<%=Utilities.getValue(title)%>" name="title<%=nIndex%>" maxlength="1023" style="width:340px"></td>
      <td>Result: <input type="text" value="<%=Utilities.getValue(desc)%>" name="description<%=nIndex%>" maxlength="1023" style="width:400px"></td>
      <td><button type="button" class="removebutton" title="Remove this row" style="width: 26px; height:26px">X</button></td>
    </tr>
<% } %>
    </table>
      <p>
      <table width="99%" align="center">
      <tr>
       <td>
         <input class="btn btn-default active" type="button" name="addmore2" value="Add More Row" style2="width:120px;height:40px; font-size:12px" onClick="addMoreResultRow()">
       </td>
      </tr>
      <tr><td height="6"></td></tr>
      </table>
  </td>
</tr>
<tr>
 <td>
     <table width="99%" align="center" style="border: 1px solid #b4c6e7" id="id_familyhistory">
     <tr bgcolor="#b4c6e7">
       <td height="28" align="center" colspan="6"><font size="3"><b>FAMILY HISTORY</b></font></td>
     </tr>
     <tr>
      <td colspan="6" height="28">&nbsp;Family History of cancer or tumor in relatives by blood:
      <font size="1"><br>&nbsp;<b>Note:</b> If one person has more than one of cancers, you can enter multiple rows for the same person with same initial, relationship and side of parents.</font>
      </td>
     </tr>
     <tr bgcolor="#eeeeee" style="border: 1px solid #2f5496">
       <td height="32" width="15%" align="center" style="border-right: 1px solid #2f5496">Affected Relative's Initial</td>
       <td width="16%" align="center" style="border-right: 1px solid #2f5496">Relationship</td>
       <td width="13%" align="center" style="border-right: 1px solid #2f5496">Side of Parents</td>
       <td width="33%" align="center" style="border-right: 1px solid #2f5496">Type of Cancer</td>
       <td width="14%" align="center" style="border-right: 1px solid #2f5496">Age of Diagnosis/Onset</td>
       <td width="2%"></td>
     </tr>
 <%
        List<HistoryInfo> ltHistory = trInfo.getHistory(trInfo.glInfo.ID);
        int nHistoryRow = Math.max(4, ltHistory.size());         
        for (int nIndex=0; nIndex<nHistoryRow; nIndex++) {
            String initial = null;
            String rShip = null;
            String pSide = null;
            String cType = null;
            String oType = null;
            String dAge = null;
            if (nIndex<ltHistory.size())
            {
               HistoryInfo hyInfo = ltHistory.get(nIndex);
               initial = hyInfo.Initial;
               rShip = hyInfo.Relationship;
               pSide = hyInfo.ParentSide;
               cType = hyInfo.CancerType;
               oType = hyInfo.OtherType;
               dAge = hyInfo.DiagnosisAge;
            }
     %>
     <tr style="border: 1px solid #2f5496">
       <td height="30" align="center" style="border-right: 1px solid #2f5496">
          <input type="text" name="initial<%=nIndex%>" value="<%=Utilities.getValue(initial)%>" style="width:120px" maxlength=20>
       </td>
       <td align="center" style="border-right: 1px solid #2f5496">
       <select name="relationship<%=nIndex%>">
         <option value=""></option>
         <option value="Mother" <%=getSelected(rShip, "Mother")%>>Mother</option>
         <option value="Father" <%=getSelected(rShip, "Father")%>>Father</option>
         <option value="Sister" <%=getSelected(rShip, "Sister")%>>Sister</option>
         <option value="Brother" <%=getSelected(rShip, "Brother")%>>Brother</option>
         <option value="Daughter" <%=getSelected(rShip, "Daughter")%>>Daughter</option>
         <option value="Son" <%=getSelected(rShip, "Son")%>>Son</option>
         <option value="Aunt" <%=getSelected(rShip, "Aunt")%>>Aunt</option>
         <option value="Uncle" <%=getSelected(rShip, "Uncle")%>>Uncle</option>
         <option value="Grandmother" <%=getSelected(rShip, "Grandmother")%>>Grandmother</option>
         <option value="Grandfather" <%=getSelected(rShip, "Grandfather")%>>Grandfather</option>
         <option value="Half-Sister" <%=getSelected(rShip, "Half-Sister")%>>Half-Sister</option>
         <option value="Half-Brother" <%=getSelected(rShip, "Half-Brother")%>>Half-Brother</option>
         <option value="Niece" <%=getSelected(rShip, "Niece")%>>Niece</option>
         <option value="Nephew" <%=getSelected(rShip, "Nephew")%>>Nephew</option>
         <option value="GreatAunt" <%=getSelected(rShip, "GreatAunt")%>>Great Aunt</option>
         <option value="GreatUncle" <%=getSelected(rShip, "GreatUncle")%>>Great Uncle</option>
         <option value="First-Cousin-F" <%=getSelected(rShip, "First-Cousin-F")%>>First Cousin (Female)</option>
         <option value="First-Cousin-M" <%=getSelected(rShip, "First-Cousin-M")%>>First Cousin (Male)</option>
       </select>
       </td>
       <td align="center" style="border-right: 1px solid #2f5496">
           <select name="parentside<%=nIndex%>">
             <option value=""></option>
             <option value="Paternal" <%=getSelected(pSide, "Paternal")%>>Paternal</option>
             <option value="Maternal" <%=getSelected(pSide, "Maternal")%>>Maternal</option>
             <option value="Both" <%=getSelected(pSide, "Both")%>>Both</option>
           </select>
       </td>
       <td align="center" style="border-right: 1px solid #2f5496">
         <select name="cancertype<%=nIndex%>" onchange="onChangeCancerType(this, document.testform.othertype<%=nIndex%>)">
         <option value=""></option>
         <option value="breast" <%=getSelected(cType, "breast")%>>Breast Cancer</option>
         <option value="colorectal" <%=getSelected(cType, "colorectal")%>>Colorectal Cancer</option>
         <option value="endometrial" <%=getSelected(cType, "endometrial")%>>Endometrial Cancer</option>
         <option value="ovarian" <%=getSelected(cType, "ovarian")%>>Ovarian Cancer</option>
         <option value="pancreatic" <%=getSelected(cType, "pancreatic")%>>Pancreatic Cancer</option>
         <option value="prostate" <%=getSelected(cType, "prostate")%>>Prostate Cancer</option>
         <option value="brain" <%=getSelected(cType, "brain")%>>Brain Tumor/Cancer</option>
         <option value="intestine" <%=getSelected(cType, "intestine")%>>Small Intestine Cancer</option>
         <option value="gastric" <%=getSelected(cType, "gastric")%>>Gastric Cancer</option>
         <option value="ureter" <%=getSelected(cType, "ureter")%>>Ureter Cancer</option>
         <option value="renal" <%=getSelected(cType, "renal")%>>Renal Pelvis Cancer</option>
         <option value="biliary" <%=getSelected(cType, "biliary")%>>Biliary Tract Cancer</option>
         <option value="fallopian" <%=getSelected(cType, "fallopian")%>>Fallopian Tube Cancer</option>
         <option value="peritoneal" <%=getSelected(cType, "peritoneal")%>>Peritoneal Cancer</option>
         <option value="Other-->">Other--></option>
         </select>
          <input type="text" maxlength=256 value="<%=Utilities.getValue(oType)%>" name="othertype<%=nIndex%>" <%=Utilities.getValueLength(oType)>0?"":"disabled"%> style="width:115px">
       </td>
       <td align="center" style="border-right: 1px solid #2f5496"><input type="text" maxlength=20 value="<%=Utilities.getValue(dAge)%>" name="diagnosisage<%=nIndex%>" style="width:120px"></td>
       <td><button type="button" class="removebutton" title="Remove this row" style="width: 26px; height:26px">X</button></td>
     </tr>
     <% } %>
     </table>
     <p>
     <table width="99%" align="center">
     <tr>
      <td>
        <input class="btn btn-default active" type="button" name="addmore" value="Add More Row" style2="width:120px;height:40px; font-size:12px" onClick="addMoreHistoryRow()">
      </td>
     </tr>
     <tr><td height="6"></td></tr>
     </table>
 </td>
</tr>
</table>
<p><br></p>