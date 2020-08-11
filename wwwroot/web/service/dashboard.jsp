<div class="panel panel-primary">
<div class="panel-heading" align="center"><font size="3"><%="My Dashboard"%></font></div>
<div class="panel-body">
<FORM name="searchform" action="/Clinician" method="post">
<INPUT name="action1" type="hidden" value="FillTestForm-Search">
<INPUT name="what" type="hidden" value="">
<INPUT name="id" type="hidden" value="">
<INPUT name="params" type="hidden" value="<%=java.util.Calendar.getInstance().getTime().getTime()%>">
<table width="100%" height="200">
<tr><td height="1" colspan="2"></td></tr>
<tr>
  <td colspan="2" align="center">
   <table align="center" width="94%">
    <tr>
      <td colspan="2">
          <% if (Utilities.getValueLength(sErrorMessage)>0) { %>
          <div class="alert alert-danger">
              <%=sErrorMessage%>
          </div>
          <% } %>
      </td>
    </tr>
    <tr><td height="30" colspan="2"></td></tr>
       <tr>
       <td width="55%"><a href="#" onClick="return submitNavigate('FillTestForm', 'id_mainarea')">
           <img class2="img-circle" width="128" src='/staticfile/web/images/place-order2.png' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
           &nbsp;<font size='4' color='#964635'><b>Place New Order</b></font>
           </a>
       </td>
       <td nowrap>
          <table width="100%">
           <tr>
            <td width="42"><a href="#" onClick="return showSubmitSearch()">
               <img width="128" src='/staticfile/web/images/search-form2.png' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')"></a>
            </td>
            <td>
                <a href="#" onClick="return showSubmitSearch(document.searchform)">&nbsp;<font size='4' color='#964635'><b>Access Form via Code</b></font></a>
                <div id="id_searchcode" style="display:<%=sAction.equalsIgnoreCase("FillTestForm-Search")?"block":"none"%>">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Enter request code" name="requestcode" value="<%=Utilities.getValue(request.getParameter("requestcode"))%>">
                        <div class="input-group-btn">
                            <button class="btn btn-default" type="submit" onClick="return submitValidateForm(onSubmitSearch, document.searchform, 'id_mainarea')">
                                <i class="glyphicon glyphicon-search"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </td>
           </tr>
          </table>
       </td>
       </tr>
       <tr><td height="40" colspan="2"></td></tr>
       <tr>
       <td width="55%"><a href="#" onClick="return submitNavigate('ListPage', 'id_mainarea')">
           <img class2="img-circle" width="128" src='/staticfile/web/images/order-list2.png' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
           &nbsp;<font size='4' color='#964635'><b>Order List</b></font>
           </a>
       </td>
       <td><a href="#" onClick="return submitNavigate('Profile', 'id_mainarea')">
           <img width="128" src='/staticfile/web/images/edit-profile2.png' border=0 class="borderimage" onMouseover="borderit(this,'black')" onMouseout="borderit(this,'white')">
           &nbsp;<font size='4' color='#964635'><b>Account Profile</b></font>
           </a>
       </td>
       </tr>
       <tr><td height="10" colspan="2"></td></tr>
   </table>
    </td>
 </tr>
 <tr><td height="20" colspan="2" align="cengter"></td></tr>
</table>
 </FORM>
</div>
</div>
<% if ("No".equalsIgnoreCase(sThirdParty)) { %>
<table width="100%">
   <tr><td align="center"><font size=3>If you have any questions or need more supplies, please contact us at <b>clientsupport@apollogen.com</b> <br>or call <b>949-916-8886</b>.</font></td></tr>
</table>
<% } %>