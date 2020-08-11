<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  ConfigInfo cfInfo = web.getConfigInfo();
//web.showAllParameters(request, out);
   String sNextAction = request.getParameter("nextaction");
   if (Utilities.getValueLength(sNextAction)==0)
   {
      sNextAction = request.getParameter("action"); 
   }
%>
 <div class="panel panel-default">
   <div class="panel-heading" align="center"><font size="3">Clinician Sign In</font></div>
   <div class="panel-body">

<FORM name="clientlogin" action="/Clinician" method="post">
<INPUT type="hidden" name="action1" value="SignIn-Submit">
<INPUT type="hidden" name="thirdparty" value="<%=Utilities.getValue(request.getParameter("thirdparty"), "No")%>">
<INPUT type="hidden" name="nextaction" value="<%=Utilities.getValue(sNextAction)%>">
<INPUT type="hidden" name="requestcode" value="<%=Utilities.getValue(request.getParameter("requestcode"))%>">
 <table width="80%" align="center">
  <tr>
   <td>
   <% if (true||sErrorMessage!=null) { %>
   <div class="form-group" align="center">
       <span class="<%=sErrorClass%>" id="id_message"><font size="3"><%=Utilities.getValue(sErrorMessage)%></font></span>
   </div>
   <% } %>
    <div class="form-group">
        <label for="email"><font size="3">Account E-Mail:</font></label>
        <input type="email" class="form-control" id="email" maxlength=50 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>" placeholder="Enter email" style2="width: 250px">
      </div>
      <div class="form-group">
        <label for="pwd"><font size="3">Password:</font></label>
        <input type="password" class="form-control" id="pwd" maxlength=20 name="password" value="<%=Utilities.getValue(request.getParameter("password"))%>"  placeholder="Enter password" style2="width: 250px">
      </div>
      <div class="checkbox">
        <label>
         <input type="checkbox" name="rememberaccount" value="1" <%="1".equalsIgnoreCase(request.getParameter("rememberaccount"))?"checked":""%>>
         <font size="3">Remember me</font></label>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <label align="right"><font2 size="3"><a onClick="return tryToGetPassword(document.clientlogin)" href="#"><%=web.getLabelText(cfInfo, "forgot-password")%></a></font2></label>
      </div>
      <div>
        <hr class2="form-group">  
      </div>
      <div align="center">
         <input type="submit" value="Sign In" class="btn btn-default btn-md" name="sumbit" onClick="return submitValidateForm(validateClientSignIn, document.clientlogin, 'id_mainarea')" style="width:120px;height:40px">
      </div>
   </td>
  </tr>
 </table>
</FORM>
<SCRIPT>onClientSignInLoad(document.clientlogin)</SCRIPT>
   </div>
 </div>
<script type="text/javascript">
function tryToGetPassword(form)
{
  if (checkFieldEmpty(form.email))
  {
     alert(getAlertMsg(6));
     setFocus(form.email);
     return false;
  }

  if (!validateEmail(form.email))
     return false;

  var temp = form.action1.value;
  form.action1.value = "Forgot-Password";
  var formdata = getFormQuery(form) + "&te="+new Date().getTime();
//alert("form data=" + formdata);
  form.action1.value = temp;

  $.ajax({
      url: "/Clinician",
      method: 'post',
      data: formdata,
      dataType: 'json',
      async: true,
      success: function (json) {
//alert("json=" + json.message);
       $('#id_message').html(json.message)
     }
  });

  return false;
}

</script>