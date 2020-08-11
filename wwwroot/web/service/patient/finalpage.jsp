<%
   web.getNames(trInfo.glInfo);
%>
<script type="text/javascript">
function submitFinalPage(form, next)
{
  return true;
}

function switchTab(form, next)
{
  return true;
}
</script>
<table width="100%" class="well well-sm">
 <tr>
  <td>
      <ol class="breadcrumb">
          <li><a href="#" onclick="submitValidateForm(submitConsent, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.General.GetName()%>')"><font size="2"><%=NavigationInfo.Navigation.General.GetName()%></font></a></li>
          <li><a href="#" onclick="submitValidateForm(submitConsent, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Ordering.GetName()%>')"><%=NavigationInfo.Navigation.Ordering.GetName()%></a></li>
          <li><a href="#" onclick="submitValidateForm(submitConsent, document.testform, 'id_mainarea', '<%=NavigationInfo.Navigation.Consent.GetName()%>')"><%=NavigationInfo.Navigation.Consent.GetName()%></a></li>
          <li class="active"><b><%=NavigationInfo.Navigation.Summary.GetName()%></b></li>
          <li><font color="#aaaaaa"><%=NavigationInfo.Navigation.Payment.GetName()%></font></li>
      </ol>
  </td>
 </tr>
</table>
<div class="panel panel-success">
<div class="panel-heading" align="center"><font size="3">Summary of Requisition Order</font></div>
<div class="panel-body">
<FORM name="testform" action="/Patient" method="post">
<INPUT type="hidden" name="action1" value="FillTestForm-Summary">
<INPUT type="hidden" name="id" value="<%=trInfo.glInfo.ID%>">
<%@ include file="summary.jsp"%>
<p>
<table width="100%">
 <tr><td colspan="3"><hr style="border:2px solid #000000"></td></tr>
    <tr>
     <td width="50%">
      &nbsp;<input class="btn btn-default active" type="submit" name='goprev' value="< Previous" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitFinalPage, document.testform, 'id_mainarea', 'prev');">
     </td>
     <td width="50%" align="right">
        <input class="btn btn-default active" type="submit" name='submit' value="Next >" style="width:160px;height:40px; font-size:18px" onClick="return submitValidateForm(submitFinalPage, document.testform, 'id_mainarea', 'next');">
    </td>
    </tr>
</table>
</FORM>
 </div>
</div>