<%@ page import="java.util.Calendar" %>
<%
   GeneralInfo glInfo = trInfo.glInfo;

    String sGetFileUrl = "/Clinician?action=Download&id=" + trInfo.glInfo.ID+"&type=docfile&include=2&index=";
    String toEmail = Utilities.getValue(glInfo.Phy_Email);
    if (Utilities.getValueLength(toEmail)==0)
       toEmail = Utilities.getValue(glInfo.EMail);
%>
<style type="text/css">
.tooltip-inner {
    padding: 3px 8px; border-radius: 4px; text-align: justify; color: rgb(0, 0, 0); text-decoration: none; max-width: 200px; background-color: rgb(249, 237, 154); border: 1px solid #000000;
}
</style>
<FORM name="testform" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Status">
<INPUT type="hidden" name="id" value="<%=trInfo.glInfo.ID%>">
<INPUT type="hidden" name="wt" value="">
<INPUT type="hidden" name="JSID" value="<%=session.getId()%>">
<div class="panel panel-success">
<% if (bFront && glInfo.SampleReceive<=0) { %>
<div class="panel-heading" align="left" style="background-color: #0d4b92;"><font size="3" color="white">
Your order has been submitted successfully. Please make sure mark patient's name and Date of Birth on the sample collection tube and send the sample to:
<b>15375 Barranca Parkway, A105-A106, Irvine, CA 92618</b>
</font>
</div>
<% } %>
<div class="panel-body">
<table width="100%">
<tr>
 <td colspan="14" height="2"></td>
</tr>
<tr>
  <td colspan="14">
   <table width="100%" style="border-bottom: 1px solid #cccccc" height="36">
    <tr>
      <td width="32%">Patient Name: <b><%=Utilities.getValue(glInfo.FirstName) + " " + Utilities.getValue(glInfo.LastName)%></b></td>
      <td width="32%" align="center">Physician: <b><%=Utilities.getValue(glInfo.Phy_Name)%></b></td>
      <td align="right">Request Code: <font size="3" color='#f39f53'><b><%=Utilities.getValue(trInfo.glInfo.RequestCode).toUpperCase()%></b>&nbsp;</font></td>
    </tr>
   </table>
  </td>
</tr>
 <tr>
  <td align="center" valign="top">
   <a href="#" onclick="return false" data-toggle="tooltip" title="Order is received. Additional documentation might be required for pre-authorization if this case involves insurance payment. We will contact you to coordinate the case, or you may use the messaging and uploading functions below." data-placement="bottom">
   <font color="<%=glInfo.Status>=RequisitionInfo.AStatus.PATIENTSUBMIT.GetValue()?"#a1b8e1":"#d2d2d2"%>">
    <font size="10">&#x26AB;</font>
   <br><b>Order Received</b></font>
   </a>
  </td>
 <td align="center" valign="top">
    <font color="<%=glInfo.Status>=RequisitionInfo.AStatus.PATIENTSUBMIT.GetValue()?"#a1b8e1":"#d2d2d2"%>" size="8">&#x21E8;</font>
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

 <td align="center" valign="top"><a href="#" onclick="return false" data-toggle="tooltip" title="Your test will be completed in 2-4 weeks depending on the type of testing." data-placement="bottom"><font color="<%=glInfo.Status>=RequisitionInfo.AStatus.RUNNING.GetValue()?"#a1b8e1":"#d2d2d2"%>">
   <font size="10">&#x26AB;</font>
  <br><b>Test Running</b></font></a>
 </td>
 <td align="center" valign="top">
    <font color="<%=glInfo.Status>=RequisitionInfo.AStatus.RUNNING.GetValue()?"#a1b8e1":"#d2d2d2"%>" size="8">&#x21E8;</font>
 </td>

 <td align="center" valign="top"><a href="#" onclick="return false" data-toggle="tooltip" title="Click the below links to view or download your patient's testing report."  data-placement="bottom"><font color="<%=glInfo.Status>=RequisitionInfo.AStatus.REPORT.GetValue()?"#a1b8e1":"#d2d2d2"%>">
   <font size="10">&#x26AB;</font>
  <br><b>Report Issued</b></font></a>
 </td>
</tr>
</table>
<p>
<% if (glInfo.Status==RequisitionInfo.AStatus.REPORT.GetValue()) { %>
<table width="100%" class="table table-striped table-hover" style="border: 1px solid #cccccc" cellpadding="2" cellspacing="2">
 <tr>
 <td align="right" width="13%" nowrap>Process Status:</td>
 <td width="54%"><b><%=Utilities.getValue(RequisitionInfo.AStatus.GetNameByValue(glInfo.Status))%></b></td>
 <td align="right" width="13%" nowrap>Date and Time:</td>
 <td width="20%"><b><%=glInfo.CreateDate.substring(0, 16)%></b></td>
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
<td align="right" width="13%" nowrap valign="top">Report Files:</td>
<td ><%=Utilities.getValue(sFiles)%></td>
<td align="right" width="13%" nowrap valign="top">Handle By:</td>
<td width="20%"><b><%=Utilities.getValue(sAdminName)%></b></td>
</tr>
<% } %>
</table>
<% } %>
<table width="100%" align="right">
<tr>
 <td colspan="2" height="5"></td>
</tr>
 <tr style="border-top: 1px solid #cccccc">
   <td width="35%" height="40" valign="bottom">
     <ul>
      <li><b>Requisition Form</b></li>
     </ul>
   </td>
   <td>
       <a href="/Clinician?action=PrintSummary&id=<%=glInfo.ID%>&type=input&show=view" target="_printWin">View</a>
     | <a href="/Clinician?action=PrintSummary&id=<%=glInfo.ID%>&type=input&show=print" target="_printWin">Print</a>
     | <a href="/Clinician?action=Export&id=<%=glInfo.ID%>&output=pdf&type=input" target="_printWin">Download</a>
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
     <td width="87%"><input type="text" name="emailto" id="id_emailto" value="<%=toEmail%>" style="width:97%" class="form-control input-sm"></td>
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

<% if (RequisitionWeb.tryEligibility(trInfo)) {
    boolean bPassed = RequisitionWeb.eligibility(trInfo);
%>
 <tr>
   <td height="40">
   <ul>
    <li><b><%=bPassed?"Letter of Medical Necessity":"Eligibility"%></b></li>
   </ul>
   </td>
   <td>
<% if (bPassed) { %>
       <a href="/Clinician?action=PrintSummary&id=<%=trInfo.glInfo.ID%>&type=letter&show=view" target="_printWin">View</a>
     | <a href="/Clinician?action=PrintSummary&id=<%=trInfo.glInfo.ID%>&type=letter&show=print" target="_printWin">Print</a>
     | <a href="/Clinician?action=Export&id=<%=trInfo.glInfo.ID%>&output=pdf&type=letter" target="_printWin">Download</a>
<% } else { %>
     <font color="#f39f53">Further qualification needed, refer to pre-authorization section below</font>
<% } %>
   </td>
 </tr>
<% } %>

 <tr>
   <td height="40">
      <ul><li><a href="#" onclick="return false" data-toggle="tooltip" data-placement="bottom" title="Please upload additional clinical documentation for pre-authorization approval AND/OR signed pre-auth form here"><b>Upload additional documents</b></a></li></ul>
    </td>
   <td valign="bottom">
<% if (bFront) { %>
       <table width="100%">
        <tr>
         <td width="65%"><font size="2"><span id="docfileuploader">Upload Files</span></font><INPUT type="hidden" name="docfiles" value="<%=Utilities.getValue(glInfo.DocFiles)%>"></td>
        </tr>
       </table>
<% } %>
   </td>
 </tr>
 <%
    StringBuffer sb = new StringBuffer();
    if (Utilities.getValueLength(glInfo.DocFiles)>0)
    {
        String[] arFile = trInfo.glInfo.DocFiles.split(",");
        sb.append("<table width='100%'>");
        for (int i=0; i<arFile.length; i++)
        {
           int nIndex = arFile[i].indexOf("-");
           sb.append("<tr style='border-bottom: 1px solid #cccccc'><td width='80%' height='28'>" + (i+1) + ". <a href='" + sGetFileUrl + i + "' title='Click to download it'>");
           sb.append(arFile[i].substring(nIndex+1) + "</a></td>");
//           sb.append("<td align='center'><a onClick=\"return removeCardFile('docfile'," + (i+1) + ",'"  + arFile[i].substring(nIndex+1) + "')\" href='#' title='Remove it'>Remove</a></td>");          
           sb.append("<td align='center'><a onClick=\"return removeCardFile(" + (i+1) + ",'"  + arFile[i].substring(nIndex+1) + "','docfile','id_uploadedfiles1','");
           sb.append(sGetFileUrl + "')\" href='#' title='Remove it'>Remove</a></td>");

           sb.append("</tr>");
        }
        sb.append("</table>");
    }
    else
    {
       sb.append("N/A");
    }
 %>
 <tr style="border-bottom: 1px solid #cccccc">
   <td height="40" align="right">Uploaded Files: &nbsp; &nbsp;</td>
   <td><span id="id_uploadedfiles1"><%=sb.toString()%></span></td>
 </tr>
 <tr><td colspan="2" height="10"></td></tr>
<% if (RequisitionWeb.tryEligibility(trInfo)){ %>
 <tr>
   <td height="40">
      <ul><li><b>Pre-authorization</b></li></ul>
   </td>
   <td align="right"><a href="#" onclick="return toggleShow('id_preauth')">Show More</a></td>
 </tr>
<tr>
  <td height="30" colspan="2">&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Your patient's insurance requires pre-certification prior to the testing.</td>
</tr>
 <tr>
  <td colspan="2" id="id_preauth" style="display:none">
   <table align="center" width="90%" style2="border: 1px solid #cccccc">
       <tr>
        <td height="34">&nbsp;&nbsp;<input type="radio" name="preauth" value="1" <%=glInfo.PreAuth==1?"checked":""%>>&nbsp;&nbsp; <font color='#f39f53'><b>Do it yourself.</b></font> Please feel free to use the letter of medical necessity provided as a courtesy.</td>
      </tr>
      <tr>
        <td height="34">&nbsp;&nbsp;<input type="radio" name="preauth" value="2" <%=glInfo.PreAuth==2?"checked":""%>>&nbsp;&nbsp;<font color='#f39f53'><b>Need our help? No problem!</b></font> Please upload any additional supporting clinical documentation and signed pre-auth form onto this page. Our client support staff will email you
          <input type="text" maxlength="60" name="preauthemail" value="<%=Utilities.getValue(glInfo.PreAuthEmail)%>" style="width: 240px"> shortly to send you the appropriate pre-auth form.</td>
      </tr>
      <tr>
       <td height="50" valign="bottom">&nbsp;&nbsp;<font size="2"><i>* The pre-authorization process typically takes 7-10 days. We will hold the sample till the pre-authorization result has been communicated to your office or you may check the status here as well.</i></font></td>
      </tr>
<% if (bFront) { %>
       <tr>
         <td align="center" height="10" style="border-bottom: 1px solid #cccccc"></td>
       </tr>
       <tr>
         <td align="center" height="10"><span id="id_submitmessage"></span></td>
       </tr>
      <tr>
        <td align="center">
           <input class="btn btn-default active" type="button" name='submitpreauth' value="Update" style="width:140px;height:34px; font-size:16px" onClick="return submitValidateForm(onSubmitPreAuth, document.testform, 'id_mainarea')">
       </td>
      </tr>
<% } %>       
   </table>
  </td>
 </tr>
<% } %>

 <% if (bFront) { %>
    <tr><td height="10" colspan="2">&nbsp;</td></tr>
    <tr style="border-top: 1px solid #cccccc">
        <td height="40" colspan="2"><b>Leave us a message if you have any questions or concerns.</b></td>
    </tr>
    <tr>
        <td colspan="2"><input type="hidden" name="messagesubject" value="The doctor of <%=Utilities.getValue(glInfo.FirstName) + " " + Utilities.getValue(glInfo.LastName)%> leave a message for the requisition order -- <%=glInfo.RequestCode%>">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Enter your message" name="message" value="<%=Utilities.getValue(request.getParameter("comments"))%>">
                <div class="input-group-btn">
                    <button class="btn btn-default" type="button" onClick="return onSubmitMessage(document.testform)">
                        <i class="glyphicon glyphicon-plus"></i>
                    </button>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td align="center" colspan="2"><span id="id_leavemessage"></span></td>
    </tr>
 <% } %>
</table>
 </div>
</div>
</FORM>
<% if (bFront) { 
    String sUploadAjaxUrl = "";
    if (web.getHttpsUrl()!=null)
       sUploadAjaxUrl = "/ctr";
    sUploadAjaxUrl += "/fileupload/acceptfiles.jsp?action=cards&id=" + glInfo.ID + "&customerid=" + glInfo.CustomerID;
%>
<script>
var g_uploadedfile1;
var g_uploadObj1;
$(document).ready(function()
{
    $('[data-toggle="tooltip"]').tooltip();

    $('.datepicker').datepicker({
        viewMode: 'years',
        format: 'mm/dd/yyyy'
//        startDate: '-3d'
    });

    initUploadAnyFile('docfileuploader', 'docfile', 'id_uploadedfiles1', '<%=sUploadAjaxUrl%>', '<%=sGetFileUrl%>');

});
</script>
<% } %>
 