<%
//. http://service.molecularsoft.com/ctr/admin/order/msiorder.jsp?action=msi_itransact?first%5Fname=neiltest&last%5Fname=Zhao&address=19681%20Parkview%20Terrace&city=Yorba%20Linda&state=CA&zip=92886&country=USA&phone=%28714%29%20779-9988&email=nzhao%40molecularsoft.com&authcode=000000&xid=9999999999&cc%5Flast%5Ffour=5454&total=99.00&when=20080906223927&service=direct&service=msiservice&function=orderinfo&product=SoftChemistry&version=15&modules=Periodic%5FTable%2C%20Chemical%5FBond%2C%20Gas%5FLaws%2C%20Basic%5FMath%2C%20Equations%2C%20Solutions%2C%20Stoichiometry%2C%20Acid%5Fand%5FBase%2C%20Thermochemistry&refno=39662226%5F9617&whobuy=High%20School%20Student&referperson=web999&quantity1=1&unitprice1=28.99&subtotal1=%2499&tax1=0&shiphandle1=0
   web.getNames(trInfo.glInfo);
   GeneralInfo glInfo = trInfo.getGeneral(0);
   glInfo.Tax = 0;
   glInfo.Shipping = 0;
   float fTotal = 0;
   int nCount = 1;

    String sUploadAjaxUrl = "";
    String sIdleCheck = "";
    if (web.getHttpsUrl()!=null)
    {
       sUploadAjaxUrl = "/ctr";
       sIdleCheck ="/ctr";
    }
    sUploadAjaxUrl += "/fileupload/acceptfiles.jsp?action=cards&id=" + glInfo.ID;
    String sImageGetUrl = "/Patient?action=GetImage&id=" + glInfo.ID + "&JSID=" + ss.getId();
    sIdleCheck += "/Patient?action=IdleCheck&what=paypal&id=" + glInfo.ID + "&JSID=" + ss.getId();
%>
<script>
$(document).ready(function()
{
    $('.datepicker').datepicker({
        viewMode: 'years',
        format: 'mm/dd/yyyy'
//        startDate: '-3d'
    });

   initUploadImageFile('inscarduploader', 'insurance', 'id_uploadedfiles1', '<%=sUploadAjaxUrl%>', '<%=sImageGetUrl%>');
   initUploadImageFile('medicareuploader', 'medicare', 'id_uploadedfiles2', '<%=sUploadAjaxUrl%>', '<%=sImageGetUrl%>');
});

function submitPayment(form, next)
{
  if (g_timerid>0)
     clearInterval(g_timerid);

  g_timerid = 0;
  g_lCount = 0;

  if (next=="next")
  {
      if (form.billtype.selectedIndex<=0)
      {
          alert("You have to select one of payment methods.");
          form.billtype.focus();

          return false;
      }
      else if (form.billtype.value==2)
      {
           if (checkFieldEmpty(form.medicareno))
           {
              alert("You have to enter Medicare No.");
              setFocus(form.medicareno);

              return false;
           }

           if (checkFieldEmpty(form.medicarestate))
           {
              alert("You have to enter Medicare State");
              setFocus(form.medicarestate);

              return false;
           }
      }
      else if (form.billtype.value==3)
      {
           if (checkFieldEmpty(form.policyname))
           {
              alert("You have to enter Policyholder Name.");
              setFocus(form.policyname);

              return false;
           }

           if (checkFieldEmpty(form.holderdob))
           {
              alert("You have to enter DOB");
              setFocus(form.holderdob);

              return false;
           }

          if (checkFieldEmpty(form.holderphone))
          {
             alert("You have to enter Phone Number.");
             setFocus(form.holderphone);

             return false;
          }

          if (checkFieldEmpty(form.insureanceco))
          {
             alert("You have to enter Insureance Co");
             setFocus(form.insureanceco);

             return false;
          }
          if (checkFieldEmpty(form.memberid))
          {
             alert("You have to enter Member ID.");
             setFocus(form.memberid);

             return false;
          }

          if (checkFieldEmpty(form.groupno))
          {
             alert("You have to enter Group No");
             setFocus(form.groupno);

             return false;
          }
      }
  }

  return true;
}

function onPaymentMethodChange(form, objSelect)
{
   for (var i=1; i<5; i++)
   {
      $('#bt_'+i).hide();
   }

   if (objSelect.selectedIndex>0)
   {
      $('#bt_'+objSelect.selectedIndex).show();
   }

   if (objSelect.value==5)
   {
      form.submit.value = "Pay Now";
   }
   else
   {
      form.submit.value = "Submit";
   }

   form.submit.disabled = objSelect.selectedIndex<=0?"disabled":"";
}

function onSubmitForm(form, idleCheck)
{
   if (form.billtype.value!=5)
     return submitValidateForm(submitPayment, form, 'id_mainarea', 'next');
   else
     return submitPaypalForm(form, document.PaypalForm, idleCheck);
}

function submitPaypalForm(form1, form2, idleUrl)
{
   form1.submit.disabled = true;

   startIdleLoop(idleUrl, 20);
   form2.submit();

   return false;
}

function finishTask(json)
{
   var form = document.testform;

   submitValidateForm(submitPayment, form, 'id_mainarea', 'next');
}
</script>
<table width="100%" class="well well-sm">
 <tr>
  <td>
      <ol class="breadcrumb">
          <li><a href="#" onclick="submitValidateForm(submitPayment, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.General.GetName()%>')"><font size="2"><%=NavigationInfo.Navigation.General.GetName()%></font></a></li>
          <li><a href="#" onclick="submitValidateForm(submitPayment, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Ordering.GetName()%>')"><%=NavigationInfo.Navigation.Ordering.GetName()%></a></li>
          <li><a href="#" onclick="submitValidateForm(submitPayment, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Consent.GetName()%>')"><%=NavigationInfo.Navigation.Consent.GetName()%></a></li>
          <li><a href="#" onclick="submitValidateForm(submitPayment, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Summary.GetName()%>')"><%=NavigationInfo.Navigation.Summary.GetName()%></a></li>
          <li class="active"><b><%=NavigationInfo.Navigation.Payment.GetName()%></b></li>
      </ol>
  </td>
 </tr>
</table>
<div class="panel panel-success">
<div class="panel-heading" align="center"><font size="3">Payment Options</font></div>
<div class="panel-body">
<FORM name="testform" action="/Patient" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Payment">
<INPUT type="hidden" name="id" value="<%=trInfo.glInfo.ID%>">
<table width="100%" cellpadding="2" cellspacing="2">
<tr>
 <td align="right" nowrap width="70%" height="34">Request Code: <font size="3" color='#f39f53'><b><%=Utilities.getValue(glInfo.RequestCode).toUpperCase()%></b>&nbsp;</font></td>
</tr>
</table>
 <table width="100%" class="table table-striped2 table-hover" style="border: 1px solid #cccccc">
 <tr bgcolor="#eeeeee">
 <td width="90%" style="border-right: 1px solid #cccccc">&nbsp;&nbsp;<b>Ordering Services/Product Kits</b></td>
 <td align="center"><b>Price</b></td>
 </tr>
 <% if ((glInfo.CancerPanel&1)!=0) {
  fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_1"), 0);
 %>
 <tr>
  <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 9001 iGene Cancer Panel (23 gene focus panel)</td>
  <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_1")%></b>&nbsp;&nbsp;</td>
 </tr>
<% } %>

<% if ((glInfo.CancerPanel&4)!=0) {
 fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_3"), 0);
%>
<tr>
 <td width="90%" style="border-right: 1px solid #cccccc"><%=nCount++%>. 2001 BRCA1 and BRCA2 Sequencing Panel</td>
 <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_2")%></b>&nbsp;&nbsp;</td>
</tr>
<% } %>

<% if ((glInfo.CancerPanel&8)!=0) {
fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_4"), 0);
%>
<tr>
<td width="90%" style="border-right: 1px solid #cccccc"><%=nCount++%>. 2005 Breast Cancer and Gynecologic Cancer Panel</td>
<td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_2")%></b>&nbsp;&nbsp;</td>
</tr>
<% } %>

<% if ((glInfo.CancerPanel&2)!=0) {
 fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_2"), 0);
%>
<tr>
 <td width="90%" style="border-right: 1px solid #cccccc"><%=nCount++%>. 2021 Colorectal Cancer Core Panel (12 genes)</td>
 <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "CancerPanel_2")%></b>&nbsp;&nbsp;</td>
</tr>
<% } %>


<% if ((glInfo.Cardiovascular&1)!=0) {
  fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "Cardiovascular_1"), 0);
%>
 <tr>
 <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 9002 iGene Cardiac Panel (22 gene focus panel)</td>
 <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "Cardiovascular_1")%></b>&nbsp;&nbsp;</td>
 </tr>
<% } %>

<% if ((glInfo.DrugSensitivity&1)!=0) {
   fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_1"), 0);
%>
 <tr>
 <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 1100 Comprehensive Pharmacogenomics (PGx) Panel</td>
 <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_1")%></b>&nbsp;&nbsp;</td>
 </tr>
<% } %>

<% if ((glInfo.DrugSensitivity&2)!=0) {
   fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_2"), 0);
%>
 <tr>
 <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 1110 Pain Management PGx Panel</td>
 <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_2")%></b>&nbsp;&nbsp;</td>
 </tr>
<% } %>

<% if ((glInfo.DrugSensitivity&4)!=0) {
   fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_4"), 0);
%>
 <tr>
 <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 1120 Mental Health PGx Panel</td>
 <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_4")%></b>&nbsp;&nbsp;</td>
 </tr>
<% } %>

<% if ((glInfo.DrugSensitivity&8)!=0) {
fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_8"), 0);
%>
 <tr>
 <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 1130 Cardiovascular Health PGx Panel</td>
 <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_8")%></b>&nbsp;&nbsp;</td>
 </tr>
<% } %>

<% if ((glInfo.DrugSensitivity&16)!=0) {
   fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_16"), 0);
%>
 <tr>
 <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 1130 Cardiovascular Health PGx Panel</td>
 <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "DrugSensitivity_16")%></b>&nbsp;&nbsp;</td>
 </tr>
<% } %>

 <% if ((glInfo.OtherRisk&2)!=0) {
     fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_2"), 0);
 %>
 <tr>
     <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 1210 Comprehensive Obesity and Diabetes Genetic Risk Panel</td>
     <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_2")%></b>&nbsp;&nbsp;</td>
 </tr>
 <% } %>

<% if ((glInfo.OtherRisk&1)!=0) {
   fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_1"), 0);
%>
 <tr>
 <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 1500 Clinical Focused Exome (6110 genes)</td>
 <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_1")%></b>&nbsp;&nbsp;</td>
 </tr>
<% } %>

 <% if ((glInfo.OtherRisk&4)!=0) {
     fTotal += Utilities.getFloat(RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_3"), 0);
 %>
 <tr>
     <td style="border-right: 1px solid #cccccc"><%=nCount++%>. 8700 Vital Mito (Mitochondrial Copy Number Analysis)</td>
     <td align="right"><b>$<%=RequisitionWeb.getDiagnosticCodeDesc("OrderPrices", "OtherRisk_3")%></b>&nbsp;&nbsp;</td>
 </tr>
 <% } %>


 <tr>
 <td align="right" style="border-right: 1px solid #cccccc">SubTotal:
 <br>Tax:
 <br>Shipping Handing:
 <br>Total Charge:
 </td>
 <td align="right"><font><b>$<%=Utilities.getNumberFormat(fTotal, 'N', 0)%>&nbsp;&nbsp;
 <br><%=glInfo.Tax%>&nbsp;&nbsp;
 <br><%=glInfo.Shipping%>&nbsp;&nbsp;
 <br><font color="red">$<%=Utilities.getNumberFormat(fTotal, 'N', 0)%></font></b>&nbsp;&nbsp;</font>
 </td>
 </tr>
 </table>

<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc">
<tr>
 <td align="right" width="256">* Payment Methods:</td>
 <td>
 <select name="billtype" onchange="onPaymentMethodChange(document.testform, this)" style="width:300px" class="form-control input-sm">
   <option value="0">[Select one of payment methods]</option>
<%
    int nBillOption = GeneralInfo.ABillType.GetTotalValueFlag(GeneralInfo.ABillType.CreditCardPayment.GetValue()|GeneralInfo.ABillType.Institution.GetValue()
                      | GeneralInfo.ABillType.CheckPay.GetValue());
    int nTotalBill1 = GeneralInfo.ABillType.GetTotal();
    for (int i=0; i<nTotalBill1; i++) {
        if ((GeneralInfo.ABillType.GetValueByIndex(i)&nBillOption)==0)
           continue;
%>
      <option value="<%=GeneralInfo.ABillType.GetValueByIndex(i)%>" <%=(GeneralInfo.ABillType.GetValueByIndex(i)==glInfo.BillType?"selected":"")%>><%=GeneralInfo.ABillType.GetNameByIndex(i)%></option>
<% } %><br>

 </td></tr><tr><td colspan="2">

  <div id="bt_1" style="display:<%=glInfo.BillType==GeneralInfo.ABillType.Medicare.GetValue()?"inline":"none"%>">
  <table class="table table-bordered table-condensed" width="100%">
   <tr>                                                   <td colspan="2">
      <div class="panel panel-warning">
      <div class="panel-heading" align="left"><font size="2">Please fill out your Medicare information and give your doctor the request code on your order summary page to access your form. We need more detailed clinical information and family history to check your benefit eligibility for you. You will be contacted regarding your eligibility status once your doctor has provided relevant clinical information.</font></div>
      </div>    
    </td>
   </tr>
    <tr>
     <td width="26%" align="right">* Medicare/Medicaid No:</td>
     <td><input type="text" maxlength=60 value="<%=Utilities.getValue(glInfo.MedicareNo)%>" name="medicareno" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
     <td align="right">* State:</td>
     <td><input type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.MedicareState)%>" name="medicarestate" style="width:550px" class="form-control input-sm"></td>
    </tr>
      <tr>
       <td colspan="2">
        <table width="100%">
         <tr>
           <td height="26">&nbsp;<font size="2">Please upload a photo image copy of medicare card(s) both front and back for billing purposes:</font></td>
         </tr>
         <tr>
          <td>&nbsp;&nbsp;<font size="2"><span id="medicareuploader">Upload Cards</span></font><INPUT type="hidden" name="medicarecard" value="<%=Utilities.getISO(Utilities.getValue(glInfo.MedicareCard))%>"></td>
         </tr>
<%
StringBuffer sb2 = new StringBuffer();
if (Utilities.getValueLength(glInfo.MedicareCard)>0)
{
    String[] arFilename2 = glInfo.MedicareCard.split(",");
    String sRootUrl2 = sImageGetUrl + "&card=medicare&te=" + Calendar.getInstance().getTime().getTime();
    for (int i=0; i<arFilename2.length; i++) {
       sb2.append("&nbsp;, &nbsp;");
       String imageUrl =  sRootUrl2 + "&index=" + (i+1);
        int start = arFilename2[i].indexOf("-");
       sb2.append("<a href='" + imageUrl +"' target='_ImageWin'  title='View Image'><img src='" + imageUrl + "' width='100' border='1'  alt='View Image'></a>");
       sb2.append(" <a onClick=\"return removeCardFile(" + (i+1) + ",'"  + Utilities.getISO(arFilename2[i].substring(start+1)) + "',");
       sb2.append("'medicare','id_uploadedfiles2','" + sImageGetUrl);
       sb2.append("')\" href='#' title='Remove it'>Remove</a>");
    }
}
%>
         <tr><td valign="top">&nbsp;&nbsp;Uploaded Medicare Card(s): <span id="id_uploadedfiles2"><%=sb2.toString()%></span></td></tr>
         <tr><td height="4"></td></tr>
        </table>
       </td>
      </tr>
  </table>
  </div>
  <div id="bt_2" style="display:<%=glInfo.BillType==GeneralInfo.ABillType.Insurance.GetValue()?"inline":"none"%>">
  <table width="100%" class="table table-bordered table-condensed">
   <tr>
    <td colspan="2">
     <div class="panel panel-warning">
     <div class="panel-heading" align="left"><font size="2">Please fill out your complete insurance information and give your doctor the request code on your order summary page to access your form. We need more detailed clinical information and family history to assist submit for insurance pre-determination for you. It typically takes 7-10 days for insurance pre-authorization once insurance request has been sent in. Please come back to the online form using the request code to check your insurance determination status.</font></div>
     </div>
   </td>
   </tr>

    <tr>
     <td width="26%" align="right">* Policyholder Name:</td>
     <td><input type="text" maxlength=40 value="<%=Utilities.getValue(glInfo.PolicyName)%>" name="policyname" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
     <td align="right">* DOB (MM/DD/YY):</td>
     <td><input class2="datepicker" type="text" maxlength=10 value="<%=Utilities.getValue(glInfo.HolderDOB)%>" name="holderdob" style="width:550px" class="form-control input-sm"></td>
    </tr>
    <tr>
     <td align="right">* Phone Number:</td>
     <td><input type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.HolderPhone)%>" name="holderphone" style="width:550px" class="form-control input-sm"></td>
   </tr>
   <tr>
    <td align="right">* Insurance Co.</td>
    <td><input type="text" maxlength=30 value="<%=Utilities.getValue(glInfo.InsureanceCo)%>" name="insureanceco" style="width:550px" class="form-control input-sm"></td>
  </tr>
  <tr>
   <td align="right">* Member ID:</td>
   <td><input type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.MemberID)%>" name="memberid" style="width:550px" class="form-control input-sm"></td>
  </tr>
  <tr>
   <td align="right">* Group No.</td>
   <td><input type="text" maxlength=20 value="<%=Utilities.getValue(glInfo.GroupNo)%>" name="groupno" style="width:550px" class="form-control input-sm"></td>
  </tr>
  <tr>
   <td colspan="2">
    <table width="100%">
     <tr>
       <td height="26">&nbsp;<font size="2">Please upload a photo image copy of insurance card(s) both front and back for billing purposes:</font></td>
     </tr>
     <tr>
      <td align="left" height="30" nowrap>&nbsp;&nbsp;<span id="inscarduploader">Upload Cards</span><INPUT type="hidden" name="insurancecard" value="<%=Utilities.getISO(Utilities.getValue(glInfo.InsuranceCard))%>"></td>
     </tr>
<%
StringBuffer sb = new StringBuffer();
if (Utilities.getValueLength(glInfo.InsuranceCard)>0)
{
    String[] arFilename = glInfo.InsuranceCard.split(",");
    String sRootUrl = sImageGetUrl + "&card=insurance&te=" + Calendar.getInstance().getTime().getTime();
    for (int i=0; i<arFilename.length; i++) {
       sb.append("&nbsp; &nbsp;");
       String imageUrl =  sRootUrl + "&index=" + (i+1) + "&JSID=" + session.getId();
       sb.append("<a href='" + imageUrl +"' target='_ImageWin'  title='View Image'><img src='" + imageUrl + "' width='100' border='1'  alt='View Image'></a>");
       int start = arFilename[i].indexOf("-");
       sb.append(" <a onClick=\"return removeCardFile(" + (i+1) + ",'"  + Utilities.getISO(arFilename[i].substring(start+1)) + "',");
       sb.append("'insurance','id_uploadedfiles1','" + sImageGetUrl);
       sb.append("')\" href='#' title='Remove it'>Remove</a>");
    }
}
%>
     <tr><td valign="top">&nbsp;&nbsp;Uploaded Insurance Card(s): <span id="id_uploadedfiles1"><%=sb.toString()%></span></td></tr>
     <tr><td height="4"></td></tr>
    </table>
   </td>
  </tr>
  </table>
  </div>
  <div id="bt_3" style="display:<%=glInfo.BillType==GeneralInfo.ABillType.OnlinePay.GetValue()?"inline":"none"%>">
  <table width="100%" class="table table-bordered table-condensed">
  <tr>
   <td colspan="2">
        <div class="panel panel-warning">
        <div class="panel-heading" align="left">
        <div id="id_paid" style="display:<%=glInfo.TotalPay>0?"inline":"none"%>">
          <font size="3">You have successfully finished online payment process with total paid <font color="red" size="3">$<span id="id_totalpaid"><%=Utilities.getNumberFormat(glInfo.TotalPay, 'N', 2)%></span></font>.
          <p>Click 'Done!' button below to close your online order process and return to Patient Center. Thank your ordering online!
          </font>
        </div>

        <div id="id_onlinepay" style="display:<%=glInfo.TotalPay>0?"none":"inline"%>">
         <font size="2">Pay online and get your kit today! Please print your order summary page and take it to your doctor's office for approval signature or have your doctor access your online form via the request code. If you do not have your own doctor, we can help arranging a medical doctor review the appropriateness of your request.
        </font>
        </div>
        </div>
    </div>
  </td>
  </tr>
 </table>
 </div>
</td>
</tr>
</TABLE>

<p>
<table width="100%">
 <tr><td colspan="3"><hr style="border:2px solid #000000"></td></tr>
<% if (sErrorMessage!=null) { %>
<tr>
  <td colspan="2" align="center">
   <% if (sErrorClass.equalsIgnoreCase("successful")) { %>
  <div class="alert alert-success">
    <strong>Success!</strong> <%=sErrorMessage%>
  </div>
   <% } else { %>
  <div class="alert alert-danger">
    <strong>Failed!</strong> <%=sErrorMessage%>
  </div>
   <% } %>
  </td>
</tr>
<% } %>
<tr>
 <td width="50%">
<%
   String sSubmitButton;
   if (glInfo.Status<=RequisitionInfo.AStatus.SUBMITTED.GetValue())
   {
     if (glInfo.BillType!=GeneralInfo.ABillType.OnlinePay.GetValue())
        sSubmitButton = "Submit";
     else
        sSubmitButton = "Pay Now";
   }
   else
     sSubmitButton = "Update";
%>
&nbsp;<input class="btn btn-default active" type="submit" name='goprev' value="< Previous" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitPayment, document.testform, 'id_mainarea', 'prev');">
 </td>
 <td width="50%" align="right">
     <input class="btn btn-primary active" <%=(glInfo.BillType<=0||glInfo.TotalPay>0)?"disabled":""%> type="submit" name='submit' value="<%=sSubmitButton%>" style="width:160px;height:40px; font-size:18px" onClick="return onSubmitForm(document.testform, '<%=sIdleCheck%>')">
 </td>
</tr>
</table>
</FORM>
<%
 //. https://developer.paypal.com/docs/classic/paypal-payments-standard/integration-guide/Appx_websitestandard_htmlvariables/
  String sUri = "Patient?action=PaypalPay&id=" + glInfo.ID + "&JSID=" + ss.getId();
  String sCustom = ""+ glInfo.ID;
  //. billing-facilitator@apollogen.com
//. fTotal = (float).99;
%>
<form action="https://www.paypal.com/cgi-bin/webscr" name="PaypalForm" method="post" onSubmit2="return prePostToPayPal(this);" target="_PayPalWin">
    <input type="hidden" name="cmd" value="_xclick">
    <input type="hidden" name="business" value="billing@apollogen.com">
    <input type="hidden" name="item_number" value="">
    <input type="hidden" name="item_name" value="Order Test Payment">
    <input type="hidden" name="amount" value="<%=Utilities.getNumberFormat(fTotal, 'H', 2)%>">
    <!--input type="hidden" name="quantity2" value="1"-->
    <input type="hidden" name="invoice" value="<%=glInfo.RequestCode%>">
    <input type="hidden" name="custom" value="<%=sCustom%>">
    <input type="hidden" name="notify_url" value="https://www.apollogen.com/<%=sUri%>&what=notify">
    <input type="hidden" name="return" value="https://www.apollogen.com/<%=sUri%>&what=return">
    <input type="hidden" name="cancel_return" value="https://www.apollogen.com/<%=sUri%>&what=return">

    <INPUT TYPE="hidden" NAME="first_name" VALUE="<%=Utilities.getValue(glInfo.FirstName)%>">
    <INPUT TYPE="hidden" NAME="last_name" VALUE="<%=Utilities.getValue(glInfo.LastName)%>">
    <INPUT TYPE="hidden" NAME="address1" VALUE="<%=Utilities.getValue(glInfo.Address)%>">
    <!--INPUT TYPE="hidden" NAME="address2" VALUE=""-->
    <INPUT TYPE="hidden" NAME="city" VALUE="<%=Utilities.getValue(glInfo.City)%>">
    <INPUT TYPE="hidden" NAME="state" VALUE="<%=Utilities.getValue(glInfo.State)%>">
    <INPUT TYPE="hidden" NAME="zip" VALUE="<%=Utilities.getValue(glInfo.Zip)%>">
    <INPUT TYPE="hidden" NAME="email" VALUE="<%=Utilities.getValue(glInfo.EMail)%>">
    <INPUT TYPE="hidden" NAME="night_phone_a" VALUE="<%=Utilities.getValue(glInfo.Phone)%>">
</form>
 </div>
</div>