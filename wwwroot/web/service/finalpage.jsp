<%
   GeneralInfo glInfo2 = trInfo.glInfo;
   web.getNames(glInfo2);
   boolean bSummary = !sAction.endsWith("-letter");
    String sIdleCheck = "";
    if (web.getHttpsUrl()!=null)
    {
       sIdleCheck ="/ctr";
    }
    sIdleCheck += "/Clinician?action=IdleCheck&what=paypal&id=" + trInfo.glInfo.ID + "&JSID=" + ss.getId();
%>
<script type="text/javascript">
function submitFinalPage(form, next)
{
  if (next=="next")
  {
  }
  if (g_timerid>0)
     clearInterval(g_timerid);
  g_timerid = 0;
  g_lCount = 0;

  return true;
}
function switchTab(form, next)
{
  return true;
}
function finishTask(json)
{
   var form = document.testform;
   submitValidateForm(submitFinalPage, form, 'id_mainarea', 'next');
}
</script>
<table width="100%" class="well well-sm">
 <tr>
  <td>
      <ol class="breadcrumb">
          <li><a href="#" onclick="submitValidateForm(submitFinalPage, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.General.GetName()%>')"><font size="2"><%=NavigationInfo.Navigation.General.GetName()%></font></a></li>
<% if (glInfo2.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
         <li><a href="#" onclick="submitValidateForm(submitFinalPage, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Ordering.GetName()%>')"><%=NavigationInfo.Navigation.Ordering.GetName()%></a></li>
<% } %>
          <li><a href="#" onclick="submitValidateForm(submitFinalPage, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Clinical.GetName()%>')"><%=NavigationInfo.Navigation.Clinical.GetName()%></a></li>
<% if (RequisitionWeb.tryEligibility(trInfo)) { %>
          <li><a href="#" onclick="submitValidateForm(submitFinalPage, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Eligibility.GetName()%>')"><%=NavigationInfo.Navigation.Eligibility.GetName()%></a></li>
<% } %>

<% if (glInfo2.RequestType!=RequisitionWeb.REQUEST_PATIENT) { %>
          <li><a href="#" onclick="submitValidateForm(submitFinalPage, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Consent.GetName()%>')"><%=NavigationInfo.Navigation.Consent.GetName()%></a></li>          
<% } %>
          <li class="active"><b><%=NavigationInfo.Navigation.Summary.GetName()%></b></li>
      </ol>
  </td>
 </tr>
</table>
<% if (RequisitionWeb.tryEligibility(trInfo)) {
    boolean bPassed = web.eligibility(trInfo);
    if (bPassed && false) {
%>
<table width="100%">
 <tr>
   <td width="70%">
  <ul class="nav nav-tabs">
<% if (bSummary) { %>
    <li class="active"><a href="#">Summary of Requisition</a></li>
    <li><a href="#" onclick="submitValidateForm(switchTab, document.testform, 'id_mainarea', 'letter')">Letter of Medical Necessity</a></li>
<% } else { %>
    <li><a href="#" onclick="submitValidateForm(switchTab, document.testform, 'id_mainarea', 'input')">Summary of Requisition</a></li>
    <li class="active"><a href="#" >Letter of Medical Necessity</a></li>
<% } %>
  </ul>
   </td>
     <td align="right">
      <a href="/Clinician?action=PrintSummary&id=<%=glInfo2.ID%>&show=print&type=<%=bSummary?"input":"letter"%>" target="printWin">Print</a>
     | <a href="/Clinician?action=Export&id=<%=glInfo2.ID%>&output=pdf&type=<%=bSummary?"input":"letter"%>">Download</a>&nbsp;
     </td>
 </tr>
</table>
<% } %>
<% } %>
<div class="panel panel-success">
<div class="panel-heading" align="center"><font size="3"><%=bSummary?"Summary of Requisition Form":"LETTER OF MEDICAL NECESSITY"%></font></div>
<div class="panel-body">
<FORM name="testform" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Summary">
<INPUT type="hidden" name="id" value="<%=glInfo2.ID%>">
<% if (bSummary) { %>
<%@ include file="summary.jsp" %>
<% } else { %>
<%@ include file="letter.jsp"%>
<% } %>
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
        <input class="btn btn-default active" type="submit" name='goprev' value="< Previous" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitFinalPage, document.testform, 'id_mainarea', 'prev');">
     </td>
     <td width="50%" align="right">
<% if (glInfo2.BillType!=GeneralInfo.ABillType.OnlinePay.GetValue()) { %>
        <input class="btn btn-primary active" type="submit" name='submit' value="<%=glInfo2.Status<=RequisitionInfo.AStatus.SUBMITTED.GetValue()?"Submit":"Update"%>" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitFinalPage, document.testform, 'id_mainarea', 'next');">
<% } else { %>
        <input class="btn btn-primary active" <%=glInfo2.TotalPay>0?"disabled":""%> type="button" name='onlinepay' value="Pay Now" style="width:160px;height:40px; font-size:18px" onClick="return submitPaypalForm(document.testform, document.PaypalForm, '<%=sIdleCheck%>');">
<% } %>
    </td>
    </tr>
</table>
</FORM>
 </div>
</div>
<%
if (glInfo2.BillType==GeneralInfo.ABillType.OnlinePay.GetValue()) {
  float fTotal = web.getPaymentTotal(trInfo);
  String sUri = "Clinician?action=PaypalPay&id=" + glInfo2.ID + "&JSID=" + ss.getId();
  String sCustom = ""+ glInfo2.ID;
%>
<form action="https://www.paypal.com/cgi-bin/webscr" name="PaypalForm" method="post" target="_PayPalWin">
    <input type="hidden" name="cmd" value="_xclick">
    <input type="hidden" name="business" value="billing@apollogen.com">
    <input type="hidden" name="item_number" value="">
    <input type="hidden" name="item_name" value="Order Tests Payment">
    <input type="hidden" name="amount" value="<%=Utilities.getNumberFormat(fTotal, 'H', 2)%>">
    <input type="hidden" name="invoice" value="<%=glInfo2.RequestCode%>">
    <input type="hidden" name="custom" value="<%=sCustom%>">
    <input type="hidden" name="notify_url" value="https://www.apollogen.com/<%=sUri%>&what=notify">
    <input type="hidden" name="return" value="https://www.apollogen.com/<%=sUri%>&what=return">
    <input type="hidden" name="cancel_return" value="https://www.apollogen.com/<%=sUri%>&what=return">
    <INPUT TYPE="hidden" NAME="first_name" VALUE="<%=Utilities.getValue(glInfo2.FirstName)%>">
    <INPUT TYPE="hidden" NAME="last_name" VALUE="<%=Utilities.getValue(glInfo2.LastName)%>">
    <INPUT TYPE="hidden" NAME="address1" VALUE="<%=Utilities.getValue(glInfo2.Address)%>">
    <INPUT TYPE="hidden" NAME="city" VALUE="<%=Utilities.getValue(glInfo2.City)%>">
    <INPUT TYPE="hidden" NAME="state" VALUE="<%=Utilities.getValue(glInfo2.State)%>">
    <INPUT TYPE="hidden" NAME="zip" VALUE="<%=Utilities.getValue(glInfo2.Zip)%>">
    <INPUT TYPE="hidden" NAME="email" VALUE="<%=Utilities.getValue(glInfo2.EMail)%>">
    <INPUT TYPE="hidden" NAME="night_phone_a" VALUE="<%=Utilities.getValue(glInfo2.Phone)%>">
</form>
<% } %>