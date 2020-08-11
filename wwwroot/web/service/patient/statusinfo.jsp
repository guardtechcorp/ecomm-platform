<%
  GeneralInfo glInfo = trInfo.glInfo;
%>
<style type="text/css">
.tooltip-inner {
    padding: 3px 8px; border-radius: 4px; text-align: justify; color: rgb(0, 0, 0); text-decoration: none; max-width: 200px; background-color: rgb(249, 237, 154); border: 1px solid #000000;
}
</style>
<div class="panel panel-success">
<div class="panel-heading" align="center"><font size="3">Your Order Status (<font size="3" color='#f39f53'><b><%=Utilities.getValue(glInfo.RequestCode).toUpperCase()%></b></font>)</font></div>
<div class="panel-body">
<FORM name="testform" action="/Patient" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Status">
<INPUT type="hidden" name="id" value="<%=trInfo.glInfo.ID%>">
<INPUT type="hidden" name="include" value="2">
<INPUT type="hidden" name="wt" value="LeaveMessage">
<INPUT type="hidden" name="JSID" value="<%=session.getId()%>">
<h4><%=Utilities.getValue(glInfo.FirstName)%>, you've ordered the following test(s):</h4>
<table width="100%" class2="table table-striped table-hover" style="border: 1px solid #cccccc">
 <% if (glInfo.CancerPanel>0) { %>
 <tr bgcolor="#eeeeee">
   <td height="30">&nbsp;Cancer Panels:</td>
 </tr>
 <tr>
  <td>
  <ul>
<% if ((glInfo.CancerPanel&1)!=0) {%>
  <li>9001 iGene Cancer Panel (23 gene focus panel)</li>
<% } %>
<% if ((glInfo.CancerPanel&2)!=0) { %>
<li>2021 Colorectal Cancer Core Panel (12 genes)</li>
<% } %>
  </ul>
  </td>
 </tr>
<% } %>

<% if (glInfo.Cardiovascular>0) { %>
<tr height="30" bgcolor="#eeeeee">
  <td height="30">&nbsp;Cardiovascular Panels:</td>
</tr>
<tr>
 <td>
 <ul>
<% if ((glInfo.Cardiovascular&1)!=0) { %>
 <li>9002 iGene Cardiac Panel (22 gene focus panel)</li>
<% } %>
 </ul>
 </td>
</tr>
<% } %>

<% if (glInfo.DrugSensitivity>0) { %>
<tr height="30" bgcolor="#eeeeee">
  <td>&nbsp;Drug Sensitivity Panels:</td>
</tr>
<tr>
 <td>
 <ul>
<% if ((glInfo.DrugSensitivity&1)!=0) {%>
 <li>1100 Comprehensive Pharmacogenomics (PGx) Panel</li>
<% } %>
<% if ((glInfo.DrugSensitivity&2)!=0) {%>
<li>1110 Pain Management PGx Panel</li>
<% } %>
<% if ((glInfo.DrugSensitivity&4)!=0) {%>
<li>1120 Mental Health PGx Panel</li>
<% } %>
<% if ((glInfo.DrugSensitivity&8)!=0) {%>
 <li>1130 Cardiovascular Health PGx Panel</li>
<% } %>
<% if ((glInfo.DrugSensitivity&16)!=0) {%>
  <li>1130 Cardiovascular Health PGx Panel</li>
<% } %>
 </ul>
 </td>
</tr>
<% } %>

<% if (glInfo.OtherRisk>0) { %>
<tr bgcolor="#eeeeee">
  <td height="30">&nbsp;Other Health Risk Management Panels:</td>
</tr>
<tr>
 <td>
 <ul>
<% if ((glInfo.OtherRisk&1)!=0) {%>
 <li>1500 Clinical Focused Exome (6110 genes)</li>
<% } %>

 </ul>
 </td>
</tr>
<% } %>
</table>
<p><br></p>
<table width="100%" style="border-top: 1px solid #cccccc;border-bottom: 1px solid #cccccc">
<tr>
 <td colspan="14" height="2"></td>
</tr>
    <tr>
     <td align="center" valign="top"><a href="#" onclick="return false" data-toggle="tooltip" title="Order is received. Pending for your physician to confirm the request. Please ask your doctor to access your form online by using the request code above or just bring the printed requisition form to your doctor’s office for signature at the bottom and mail back along with the sample. If you need help finding a doctor to review your order, please leave a message to us below." data-placement="bottom"><font color="<%=glInfo.Status>=RequisitionInfo.AStatus.PATIENTSUBMIT.GetValue()?"#a1b8e1":"#d2d2d2"%>">
       <font size="10">&#x26AB;</font>
      <br><b>Order Received</b></font></a>
     </td>
    <td align="center" valign="top">
       <font color="<%=glInfo.Status>=RequisitionInfo.AStatus.PATIENTSUBMIT.GetValue()?"#a1b8e1":"#d2d2d2"%>" size="8">&#x21E8;</font>
    </td>

    <td align="center" valign="top"><a href="#" onclick="return false" data-toggle="tooltip" title="Your doctor has approved your order. We will mail you the collection kit today! Send in your sample when you are ready or wait till insurance pre-authorization is approved as you prefer." data-placement="bottom"><font color="<%=glInfo.Status>=RequisitionInfo.AStatus.TRANSFER.GetValue()?"#a1b8e1":"#d2d2d2"%>">
      <font size="10">&#x26AB;</font>
     <br><b>Doctor Approved</b></font></a>
    </td>
    <td align="center" valign="top">
       <font color="<%=glInfo.Status>=RequisitionInfo.AStatus.TRANSFER.GetValue()?"#a1b8e1":"#d2d2d2"%>" size="8">&#x21E8;</font>
    </td>

<% if (glInfo.BillType==GeneralInfo.ABillType.OnlinePay.GetValue()) {
    String color = "d2d2d2";
    String text = "Pay Pending";
    if (glInfo.Status>=RequisitionInfo.AStatus.SUBMITTED.GetValue())
    {
       color = glInfo.TotalPay>0?"#70ad47":"#ffc000";
       text = glInfo.TotalPay>0?"Paid Online":"Pay Pending";
    }
%>
    <td align="center" valign="top"><font color="<%=color%>">
      <font size="10">&#x26AB;</font>
     <br><b><%=text%></b></font>
    </td>
    <td align="center" valign="top">
       <font color="<%=color%>" size="8">&#x21E8;</font>
    </td>
<% } else {
   String color = "d2d2d2";
   String text = RequisitionInfo.AStatus.PENDING.GetName();
   if (glInfo.Status>=RequisitionInfo.AStatus.SUBMITTED.GetValue())
   {
       if ("Approved".equalsIgnoreCase(glInfo.PayDetail))
       {
          color = "#70ad47";
          text = RequisitionInfo.AStatus.AGREE.GetName();
       }
       else if ("Rejected".equalsIgnoreCase(glInfo.PayDetail))
       {
           color = "#ed7d31";
           text = RequisitionInfo.AStatus.REJECTED.GetName();
       }
       else if ("Pending".equalsIgnoreCase(glInfo.PayDetail))
       {
           color = "#ffc000";
           text = RequisitionInfo.AStatus.REJECTED.GetName();
       }
   }
%>
    <td align="center" valign="top"><font color="<%=color%>">
      <font size="10">&#x26AB;</font>
     <br><b><%=text%></b></font>
    </td>
    <td align="center" valign="top">
       <font color="<%=color%>" size="8">&#x21E8;</font>
    </td>
<% } %>
        
    <td align="center" valign="top"><a href="#" onclick="return false" data-toggle="tooltip" title="Your sample has been received in the lab. We will contact you if any additional documentation is needed." data-placement="bottom"><font color="<%=glInfo.SampleReceive>0?"#a1b8e1":"#d2d2d2"%>">
      <font size="10">&#x26AB;</font>
     <br><b>Sample Received</b></font></a>
    </td>
    <td align="center" valign="top">
       <font color="<%=glInfo.SampleReceive>0?"#a1b8e1":"#d2d2d2"%>" size="8">&#x21E8;</font>
    </td>

    <td align="center" valign="top"><a href="#" onclick="return false" data-toggle="tooltip" title="Your test will be completed in 2-4 weeks depending on the type of testing."  data-placement="bottom"><font color="<%=glInfo.Status>=RequisitionInfo.AStatus.RUNNING.GetValue()?"#a1b8e1":"#d2d2d2"%>">
      <font size="10">&#x26AB;</font>
     <br><b>Test Running</b></font></a>
    </td>
    <td align="center" valign="top">
       <font color="<%=glInfo.Status>=RequisitionInfo.AStatus.RUNNING.GetValue()?"#a1b8e1":"#d2d2d2"%>" size="8">&#x21E8;</font>
    </td>

    <td align="center" valign="top"><a href="#" onclick="return false" data-toggle="tooltip" title="Click here to view or download your report. Please make sure to consult your doctor about the testing result." data-placement="bottom"><font color="<%=glInfo.Status>=RequisitionInfo.AStatus.REPORT.GetValue()?"#a1b8e1":"#d2d2d2"%>">
      <font size="10">&#x26AB;</font>
     <br><b>Report Issued</b></font></a>
    </td>
   </tr>
    <tr>
     <td colspan="14" height="10"></td>
    </tr>
</table>
<p><br></p>
<% if (glInfo.Status==RequisitionInfo.AStatus.REPORT.GetValue()) { %>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc" cellpadding="2" cellspacing="2">
 <tr>
 <td align="right" width="13%" nowrap>Process Status:</td>
 <td width="34%"><b><%=Utilities.getValue(RequisitionInfo.AStatus.GetNameByValue(glInfo.Status))%></b></td>
 <td align="right" width="13%" nowrap>Date and Time:</td>
 <td width="34%"><b><%=glInfo.CreateDate.substring(0, 16)%></b></td>
 </tr>
<% if (glInfo.Status>RequisitionInfo.AStatus.RESUBMITTED.GetValue()) {
      String sAdminName = glInfo.m_RealName;
      if (Utilities.getValueLength(sAdminName)==0)
         sAdminName = glInfo.m_Username;
%>
<tr>
<td align="right" width="13%" nowrap valign="top">Description:</td>
<td colspan="3">
 <b><%=Utilities.convertHtml(Utilities.getValue(glInfo.Description), true)%></b>
</td>
</tr>
<%
   String sFiles = null;
   if (Utilities.getValueLength(glInfo.ReportFiles)>0) {
       String[] arFile = trInfo.glInfo.ReportFiles.split(",");
       StringBuffer sb = new StringBuffer();
       sb.append("<ul>");
       for (int i=0; i<arFile.length; i++)
       {
          int nIndex = arFile[i].indexOf("-");
          sb.append("<li><a href='/Clinician?action=Download&id=" + trInfo.glInfo.ID+"&index=" + i + "' title='Click to download it'>");
          sb.append(arFile[i].substring(nIndex+1) + "</a></li>");
       }
       sb.append("</ul>");

       sFiles = sb.toString();
   }
%>
<tr>
<td align="right" nowrap valign="top">Report Files:</td>
<td ><%=Utilities.getValue(sFiles)%></td>
<td align="right" nowrap valign="top">Handle By:</td>
<td><b><%=Utilities.getValue(sAdminName)%></b></td>
</tr>
<% } %>
</table>
<% } %>
<br>
<table width="98%" align="center" class="table table-striped2 table-hover" style="border: 1px solid #cccccc">
  <tr>
    <td width="60%"><b>Your Requisition Form</b></td>
    <td nowrap align="right" valign="bottom">
        <a href="/Patient?action=PrintSummary&id=<%=trInfo.glInfo.ID%>&type=input&show=view&JSID=<%=ss.getId()%>" target="_printWin">View</a>
      | <a href="/Patient?action=PrintSummary&id=<%=trInfo.glInfo.ID%>&type=input&show=print&JSID=<%=ss.getId()%>" target="_printWin">Print</a>
      | <a href="/Patient?action=Export&id=<%=trInfo.glInfo.ID%>&output=pdf&type=input>&JSID=<%=ss.getId()%>">Download</a>
      | <a href="#" onclick="return toggleShow('id_emailarea')">E-Mail</a>
    </td>
 </tr>
<tr>
 <td colspan="2" id="id_emailarea" style="display:none">
     <table width="100%" class="table table-condensed" style="border: 1px solid #cccccc">
     <tr style="border-bottom: 2px solid #ffffff">
     <td colspan="2" align="center" height="22"><font size="2"><span id="id_emailmessage"></span></font></td>
     </tr>
     <tr style="border-bottom: 2px solid #ffffff">
     <td align="right" width="12%">Email(s): </td>
     <td width="87%"><input type="text" name="emailto" id="id_emailto" value="<%=Utilities.getValue(glInfo.EMail)%>" style="width:97%" class="form-control input-sm"></td>
     </tr>
     <tr style="border-bottom: 2px solid #ffffff">
     <td align="right">Subject: </td>
     <td align="left"><INPUT type="text" name="subject" value="Your requisition form summary with attachment PDF file" style="width:97%" class="form-control input-sm"></td>
     <tr>
     <td align="right" valign="top">Content:</td>
     <td align="left"><textarea rows="6" style="width:97%" wrap="virtual" name="content" class="form-control input-sm"></textarea></td>
     </tr>
     <tr style="border-bottom: 2px solid #ffffff">
     <td colspan="2" align="center" height="5"></td>
     </tr>
     <tr>
     <td align="center" colspan="2" height="50" valign="bottom"><INPUT type="button" name="sendbutton" value="Send Now" class="btn btn-default active" style="width:140px;height:34px; font-size:14px" onclick="return submitSendEmail(document.testform, 'id_emailmessage')"></td>
     </tr>
     </table>
 </td>
</tr>
   <tr>
     <td height="30" colspan="2"><b>Leave us a message if you have any questions or concerns.</b></td>
   </tr>
   <tr>
    <td colspan="2"><input type="hidden" name="messagesubject" value="The patient of <%=Utilities.getValue(glInfo.FirstName) + " " + Utilities.getValue(glInfo.LastName)%> leave a message for the requisition order -- <%=glInfo.RequestCode%>">
    <div class="input-group">
        <input type="text" class="form-control" placeholder="Enter your message" name="message" value="<%=Utilities.getValue(request.getParameter("comments"))%>">
        <div class="input-group-btn">
          <button class="btn btn-default" type="button" onClick="return submitValidateForm(onSubmitMessage, document.testform, 'id_mainarea')">
            <i class="glyphicon glyphicon-plus"></i>
          </button>
        </div>
      </div>        
    </td>
   </tr>
    <tr>
      <td align="center" colspan="2"><span id="id_leavemessage"></span></td>
    </tr>
</table>
</FORM>
</div>
</div>
<script type="text/javascript">
$(document).ready(function()
{
   $('[data-toggle="tooltip"]').tooltip();
});
</script>