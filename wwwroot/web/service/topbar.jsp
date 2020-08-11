<table width="100%" align="center" style="border-bottom: 2px solid #cccccc">
 <tr>
<% if (loginInfo!=null) { %>
 <td width="20%" nowrap>
    <button class="btn btn-warning" type="button" onclick="submitNavigate('Dashboard', 'id_mainarea')">My Dashboard</button>
 </td>
 <td width="60%" align="center"><span id2="id_waiting"><font color="#aaaaaa">Hi, Dr. <%=loginInfo.Yourname%></font></span></td>
 <td width="20%" align="right" nowrap>
  <a href="#" onClick="return submitNavigate('Logout')"><font size="3"><span class="glyphicon glyphicon-log-out"></span> Log Out</font></a>
 <!--div class="dropdown">
   <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><font size="3">Manage Menu (<%=loginInfo.Yourname%>)</font>
   <span class="caret"></span></button>
   <ul class="dropdown-menu">
       <li><a href="#" onClick="return submitNavigate('Dashboard', 'id_mainarea')">Dashboard</a></li>
       <li class="divider"></li>
       <li><a href="#" onClick="return submitNavigate('Logout')">Logout</a></li>
	 </ul>
</div-->
<% } else { %>
<td>
<ul class="nav navbar-nav navbar-right">
 <li><a href="#" onClick="return submitNavigate('SignIn', 'id_mainarea')"><font size="3"><span class="glyphicon glyphicon-log-in"></span> Sign In</font></a></li>
 <li><a href="#" onClick="return submitNavigate('SignUp', 'id_mainarea')"><font size="3"><span class="glyphicon glyphicon-user"></span> Sign Up</font></a></li>
</ul>
<% } %>
<td>
</tr>
<tr><td colspan="3" height="5"></td></tr>
</table>
<p></p>