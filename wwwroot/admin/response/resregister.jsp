<%
   String sDomainName = request.getParameter("domainname");
   String sEmailUrl   = request.getParameter("emailurl");
   String sPassword   = request.getParameter("password");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<title>Congratulations for registering website - </title>
</head>
<body>
<div align="left">
  <p>Congratulations!!! Your test website have been successfully setup and an
    admin account of this website is alos created.<br>
    You can visit your web site any time at:<a href="http://<%=sDomainName%>"><br>
    http://<%=sDomainName%></a>. </p>
  <p>You can login your admin account to set up and manage your web site now.<br>
    Your administration address(URL) is: <a href="http://<%=sDomainName%>/admin">
    http://<%=sDomainName%>/admin</a><br>
    Your user name is: <b>admin</b><br>
    Your password is: <b><%=sPassword%></b> </p>
  <div align="left">
    <p>Your email account is also created and you can send and receive email now.
    </p>
    <p>Your email box address(URL) is: <a href="<%=sEmailUrl%>"><%=sEmailUrl%></a><br>
      Your UserID is: <b>admin@<%=sDomainName%></b><br>
      Your Password is: <b><%=sPassword%></b> (the same as admin account of your test website)</p>
  </div>
  </div>
<p align="left">The six forwarding email addresses are also generated. They will
  automatically forward to <b>admin@<%=sDomainName%></b> now. You can change
  these forwardings and reassign each of them to other employees of your company
  later. The six forwarding emails are:</p>
<p align="left"><b>1. customerservice@<%=sDomainName%></b><br>
  <b>2. sales@<%=sDomainName%></b><br>
  <b>3. support@<%=sDomainName%></b><br>
  <b>4. newsletter@<%=sDomainName%></b><br>
  <b>5. rma@<%=sDomainName%></b><br>
  <b>6. staff@<%=sDomainName%></b><br>
</p>
<p align="left">Thank you for using Web Office service from Zyzit.com!</p>
</body>
</html>