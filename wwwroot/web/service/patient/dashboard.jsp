<%
%>
<div class="panel panel-primary">
<div class="panel-heading" align="center"><font size="5"><b><%="Patient Center"%></b></font></div>
<div class="panel-body">
<FORM name="searchform" action="/Patient" method="post">
<INPUT name="action1" type="hidden" value="FillTestForm-Search">
<INPUT name="what" type="hidden" value="">
<INPUT name="id" type="hidden" value="">
<INPUT name="params" type="hidden" value="<%=java.util.Calendar.getInstance().getTime().getTime()%>">
<table width="100%" cellpadding="2" cellspacing="4">
  <tr>
    <td height="30" colspan="20">
    <% if (Utilities.getValueLength(sErrorMessage)>0) { %>
        <div class="alert alert-danger">
          <strong>Not Found! </strong> <%=sErrorMessage%>
        </div>
    <% } %>            
  </td>
  </tr>
  <tr>
   <td width="48%" valign="top">
     <table width="97%" align="center" style2="border-right: 1px solid #cccccc">
      <tr style="border-bottom: 1px solid #cccccc">
        <td height="34" align="center"><font size="4">Fill-In a new order form:</font></td>
      </tr>
     <tr><td height="30"></td></tr>
     <tr>
       <td align="center">
         <button class="btn btn-warning btn-lg" type="button" onclick="return submitNavigate('FillTestForm', 'id_mainarea')">Place New Order</button>
       </td>
     </tr>

     </table>
   </td>
   <td>
    <table width="97%" align="center" style2="border: 1px solid #cccccc">
        <tr style="border-bottom: 1px solid #cccccc">
          <td height="34" align="center"><font size="4">Find an existing requisition order:</font></td>
        </tr>
        <tr><td height="30"></td></tr>
        <tr>
          <td align="center">
            <button class="btn btn-warning btn-lg" type="button" onclick="return toggleShow('id_searcharea')">Find Existing Order</button>
          </td>
        </tr>
        <tr>
          <td id="id_searcharea" style="display: <%=Utilities.getValueLength(sErrorMessage)>0?"inline":"none"%>">
            <table width="100%" align="center" style2="border: 1px solid #cccccc">
                <tr><td height="25" colspan="3"></td></tr>
                <tr>
                  <td>
                      <div class="form-group">
                        <label for="lastname">Last Name:</label>
                        <input type="text" class="form-control" id="lastname" name="lastname" value="<%=Utilities.getValue(request.getParameter("lastname"))%>" placeholder="Your last name">
                      </div>
                  </td>
                </tr>
                <tr>
                  <td>
                      <div class="form-group">
                        <label>Day of Birth:</label>
                        <!--input type="text" class="form-control datepicker" id="birthday" name="birthday" value="<%=Utilities.getValue(request.getParameter("birthday"))%>" placeholder="Your day of birth"-->
                          <select name="bmonth" class2="form-control input-sm">
                            <option value="" selected>Month</option>
                            <option value="01">01</option>
                            <option value="02">02</option>
                            <option value="03">03</option>
                            <option value="04">04</option>
                            <option value="05">05</option>
                            <option value="06">06</option>
                            <option value="07">07</option>
                            <option value="08">08</option>
                            <option value="09">09</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                          </select>
                          /
                          <select name="bday" class2="form-control input-sm">
                            <option value="" selected>Day</option>
                    <% for (int nDay=1; nDay<=31; nDay++) { %>
                            <option value="<%=nDay<10?("0"+nDay):(""+nDay)%>"><%=nDay<10?("0"+nDay):(""+nDay)%></option>
                    <% } %>
                          </select>
                          /
                          <select name="byear" class2="form-control input-sm">
                            <option value="" selected>Year</option>
                    <% for (int nYear=1900; nYear<=Calendar.getInstance().get(Calendar.YEAR); nYear++) { %>
                            <option value="<%=nYear%>"><%=nYear%></option>
                    <% } %>
                          </select><input type="hidden" value="<%=Utilities.getValue(request.getParameter("birthday"))%>" name="birthday">
                      </div>
                  </td>
                </tr>
                 <tr>
                   <td height="50" colspan="3">
                   <label>Request Code:</label>
                    <div class="formm-group">
                       <input type="text" class="form-control" placeholder="The request code in submitted summary form" name="requestcode" value="<%=Utilities.getValue(request.getParameter("requestcode"))%>">
                     </div>
                     </td>
                  </tr>
                <tr><td height="20" colspan="3"></td></tr>                                
                <tr>
                  <td height="50" colspan="3" align="center">
                    <div class="form-group">
                     <button class="btn btn-default btn-md" type="submit" value="Search" onClick="return submitValidateForm(onSubmitSearch, document.searchform, 'id_mainarea')" style="width: 200px;font-size:20px">
                     Search
                     </button>
                    </div>
                    </td>
                 </tr>
            </table>
          </td>
        </tr>
        <tr><td height="20" colspan="3"></td></tr>                
    </table>
   </td>
  </tr>
  <tr><td height="10" colspan="2"></td></tr>
</table>
 </FORM>
</div>
</div>
<% if ("No".equalsIgnoreCase(sThirdParty)) { %>
<table width="100%">
  <tr><td align="center"><font size=3>If you have any questions or need more supplies, please contact us at <b>clientsupport@apollogen.com</b> <br>or call <b>949-916-8886</b>.</font></td></tr>
</table>
<% } %>
<script type="text/javascript">
$(document).ready(function()
{
    fillBirthDay(document.searchform, "<%=Utilities.getValue(request.getParameter("birthday"))%>");

    $('.datepicker').datepicker({
        viewMode: 'years',
        format: 'mm/dd/yyyy'
//        startDate: '-3d'
    });
});

function onSubmitSearch(form)
{
    if (checkFieldEmpty(form.lastname))
    {
         alert("You have to enter Last Name.");
         setFocus(form.lastname);

         return false;
    }

    if (form.bmonth.selectedIndex==0)
    {
          alert("You have to select Birth Month");
          form.bmonth.focus();
          return false;
    }

    if (form.bday.selectedIndex==0)
    {
        alert("You have to select Birth Day");
        form.bday.focus();
        return false;
    }

    if (form.byear.selectedIndex==0)
    {
        alert("You have to select Birth Year");
        form.byear.focus();
        return false;
    }
    form.birthday.value = form.bmonth.value + "/" + form.bday.value + "/" + form.byear.value;
    
    if (checkFieldEmpty(form.requestcode))
    {
         alert("You have to enter a requested code.");
         setFocus(form.requestcode);

         return false;
    }

    if (trim(form.requestcode.value).length!=10)
    {
         alert("The requested code you entered is invalid");
         setFocus(form.requestcode);

         return false;
    }

    return true;
}
</script>
