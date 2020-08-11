<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<title>Tell-Friends  Confirmation</title>
</head>
<body bgcolor="#FFFFFF" vlink="#FF0000" topmargin="10" leftmargin="5">
<br>
<center>
  <table border="0" bordercolor="#333399" width="466" height="134">
    <tr>
      <td height="283">
        <table border="0" cellpadding="4" cellspacing="4" width="454">
          <tr>
            <td bgcolor="#333399" width="438">
              <p align="center"><font face="Arial, Helvetica, sans-serif" size="3"><b><font face="Arial, Helvetica, sans-serif" size="3"><b><font color="#FFFFFF">Tell-A-Friend
                </font></b></font><font color="#FFFFFF">Confirmation</font></b></font>
            </td>
          </tr>
          <tr>
            <td width="438">&nbsp;</td>
          </tr>
          <tr>
            <td width="438">
              <p align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2">You
                have successfully sent the mail to your friend:<br>
                <%=request.getParameter("friendemail1")%><br>
                <%=request.getParameter("friendemail2")%><br>
                <%=request.getParameter("friendemail3")%><br>
                <%=request.getParameter("friendemail4")%><br>
                <%=request.getParameter("friendemail5")%><br>
                </font> <br>
                <font size="2" face="Verdana, Arial, Helvetica, sans-serif">Thank
                you for spreading the words.</font>
            </td>
          </tr>
          <tr>
            <td width="438" height="68">
              <p align="center"><a href="javascript:window.close(true)">Close
                Window </a>
            </td>
          </tr>
          <tr>
            <td height="14" width="438"></td>
          </tr>
        </table>
        <div align="center"></div>
      </td>
    </tr>
  </table>
</center>
</body>
</html>
