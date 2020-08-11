<%@ page import="com.zyzit.weboffice.bean.DomainBean"%>
<%
   DomainBean bean = new DomainBean(session, 20);
   String sDomainName = request.getParameter("domainname");
   String sEmailDomain   = request.getParameter("emaildomain");
   String sPassword   = request.getParameter("password");
   String sPricePlan  = request.getParameter("priceplan");
   String sTestFlag  = request.getParameter("testflag");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<title>Congratulations for signup website and online store - </title>
</head>
<body>
<div align="left">
<p>
<% if ("1".equals(sTestFlag)) {%>
Congratulations!!! You have successfully signed up a free test website and online store.<br>
Your test website and online store has open now and will be closed in 30 days.<br>
<% } else { %>
Congratulations!!! You have successfully signed up. And thank you for selecting <%=sPricePlan%>.
KZ Company will charge your credit card for the amount of the setup fee plus first monthly fee specified by the plan you choose.
We will charge your credit card for monthly fee in the first day of each month.<br><br>
Your website and online store will open within 24-hour if we confirm all the information you filled in are correct.<br>
<% } %>
You can visit your web site at: <a href="http://<%=sDomainName%>">http://<%=sDomainName%></a>.
</p>
<p>
You can login your admin account to set up and manage your web site any time from anywhere.<br>
Your administration console URL is: <a href="http://<%=sDomainName%>/console">http://<%=sDomainName%>/console</a><br>
Your username is: <b>admin</b><br>
Your password is: <b><%=sPassword%></b> </p>
<p>
An email account will also be created and you can send and receive email by using a web browser.<br>
Your email box address (URL) is: <a href="http://<%=sDomainName%>/webmail">http://<%=sDomainName%>/webmail</a><br>
Your UserID is: <b>admin@<%=sEmailDomain%></b><br>
Your Password is: <b><%=sPassword%></b> (the same as admin account of your website)</p>
<p> The six company forwarding email addresses will also be generated. They will automatically forward to
<b>admin@<%=sEmailDomain%></b> at first. You can reassign each of them to other employees of
your company later. The six forwarding emails are:<br>
   <b>1. customerservice@<%=sEmailDomain%></b><br>
   <b>2. sales@<%=sEmailDomain%></b><br>
   <b>3. support@<%=sEmailDomain%></b><br>
   <b>4. newsletter@<%=sEmailDomain%></b><br>
   <b>5. rma@<%=sEmailDomain%></b><br>
   <b>6. staff@<%=sEmailDomain%></b><br>
</p>
<p>Thank you again for using <%=bean.getConfigValue("productname")%> service from <%=bean.getConfigValue("company")%>!</p>
</div>
</body>
</html>