<%@ page import="com.zyzit.weboffice.graphimage.CaptchaService"%>
<%
{
  String PREVIOUS_INPUT = "Captcha-Prev-Input";
  String sAction = request.getParameter("action");
  String sCaptchaKey = request.getParameter("captchakey");
  if (sCaptchaKey==null)
     sCaptchaKey = request.getSession().getId();

  if ("validate".equalsIgnoreCase(sAction))
  {
    String sUserInput = request.getParameter("userinput");
    String sOldInput = (String)session.getAttribute(PREVIOUS_INPUT);
    boolean bRet;
    if (sUserInput!=null&&sUserInput.equals(sOldInput))
       bRet = true;
    else
    {
      bRet = CaptchaService.validateInput(sCaptchaKey, sUserInput);
//System.out.println("sCaptchaKey1=" + sCaptchaKey+"," + sUserInput+", bRet=" + bRet);
      if (bRet)
      { //. If it is true and keep old input
        session.setAttribute(PREVIOUS_INPUT, sUserInput);
      }
    }

    response.reset();
    response.setContentType("text/html");
    response.getWriter().print(bRet);
    response.flushBuffer();
    return;
  }
  else if ("getimage".equalsIgnoreCase(sAction))
  {
//System.out.println("getImage Key=" + sCaptchaKey);
    byte[] btCaptchaChallengeAsJpeg = CaptchaService.getImage(sCaptchaKey);
    session.removeAttribute(PREVIOUS_INPUT);

    // flush it in the response
    response.reset();
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    response.setContentType("image/jpeg");
    response.getOutputStream().write(btCaptchaChallengeAsJpeg);
    response.getOutputStream().flush();
    response.getOutputStream().close();
    return;
  }
}
%>
<html>
<body>
<form name="captchaform" method="post" action="captcha.jsp" onsubmit="return true;">
<input type="hidden" name="captchakey1" value="test">
<table cellspacing=0 cellpadding=0 width="98%" align="center">
  <TR>
    <td width="10%"><img src="captcha.jsp?action=getimage" align="CENTER" alt="Enter the characters appearing in this image" border="1"/></td>
    <td width="50%" align="left"><input type="text" name="userinput" maxlength="256" value="" size="12"></td>
  </TR>
  <tr>
    <td colspan=2><input type="submit" name="action" value="Validate"></td>
  </tr>
</table>
</form>
</body>
</html>