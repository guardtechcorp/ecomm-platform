
<TABLE width="682" border="0" cellspacing="0" cellpadding="0" align="center">
  <TR align="center" valign="top">
    <TD valign="middle" width="645">
      <DIV id="ALERT_MSG_TEXT" style="display: none">
        <TABLE width="550" border="0" cellpadding="0" cellspacing="0">
          <TR>
            <TD height="23" width="405"><B><FONT class="sub">Message:</FONT></B></TD>
            <TD height="23" width="65" align="left" valign="middle"> <FONT class="sub"><B><FONT class="sub"><A href="javascript:showHide('close','ALERT_MSG_TEXT');showHide('open','ALERT_MSG')"><FONT color="#0000FF">HTML</FONT></A></FONT></B></FONT></TD>
            <TD height="23" width="80" align="right" valign="middle"><FONT class="sub"><A href="javascript:showHide('close','ALERT_MSG_TEXT');showHide('open','ALERT_MSG')"></A><B><FONT class="sub"><A href="javascript:showHide('close','ALERT_MSG_TEXT');showHide('open','ALERT_MSG')"><FONT color="#0000FF"></FONT></A><A href="javascript:resize('decrease');"><IMG src="../images/collapse.gif" width="9" height="9" border="0"></A>&nbsp;&nbsp;&nbsp;Height&nbsp;&nbsp;&nbsp;<A href="javascript:resize('increase');"><IMG src="../images/expand.gif" width="9" height="9" border="0"></A></FONT></B></FONT></TD>
          </TR>
        </TABLE>
        <TABLE width="550" cellspacing="0" cellpadding="0" align="center">
          <FORM method="post" action="#">
            <INPUT type="hidden" name="action" value="admin">
            <INPUT type="hidden" name="page" value="">
            <INPUT type="hidden" name="type" value="addmsg">
            <TR valign="top">
              <TD colspan="3" align="left">
                <HR>
              </TD>
            </TR>
            <TR valign="middle">
              <TD width="122" align="left" height="45"><B><FONT class="sub"><B>Message
                Name&nbsp;:</B></FONT></B></TD>
              <TD width="342" height="45" align="left">
                <INPUT type="text" name="msg_name" maxlength="16" size="25">
                <INPUT type="submit" name="submit" value="Save Message">
              </TD>
              <TD width="84" height="45" align="right"><FONT class="sub">
                <INPUT type="checkbox" name="admin_do_preview" value="y" checked>
                Preview</FONT></TD>
            </TR>
            <TR align="center">
              <TD colspan="3" valign="top">
                <TEXTAREA name="msg" rows="5" cols="66"></TEXTAREA>
              </TD>
            </TR>
          </FORM>
        </TABLE>
      </DIV>
      <DIV id="ALERT_MSG">
        <TABLE width="550" border="0" cellpadding="0" cellspacing="0" align="center">
          <TR>
            <TD height="23" width="405"><B><FONT class="sub">Message:</FONT></B></TD>
            <TD height="23" width="65" align="left" valign="middle"> <B><FONT class="sub"><A href="javascript:showHide('open','ALERT_MSG_TEXT');showHide('close','ALERT_MSG')"><FONT color="#0000FF">TEXT</FONT></A></FONT></B></TD>
            <TD height="23" width="80" align="right" valign="middle"><B><FONT class="sub"><A href="javascript:resize('decrease');"><IMG src="../images/collapse.gif" width="9" height="9" border="0"></A>&nbsp;&nbsp;&nbsp;Height&nbsp;&nbsp;&nbsp;<A href="javascript:resize('increase');"><IMG src="../images/expand.gif" width="9" height="9" border="0"></A></FONT></B></TD>
          </TR>
        </TABLE>
        <TABLE width="550" border="1" cellspacing="0" cellpadding="0" align="center" class="top_nav_color" bordercolor="#999999">
          <TR>
            <TD valign=top>
              <TABLE width="99%" align=center border="0" cellspacing="1" cellpadding="1" height=97%>
                <FORM name="post" action="#" method="post">
                  <INPUT type="hidden" name="action" value="admin">
                  <INPUT type="hidden" name="page" value="#">
                  <INPUT type="hidden" name="type" value="addmsg">
                  <SCRIPT type="text/javascript" language="JavaScript1.2" src="/staticfile/admin/scripts/contenteditor.js"></SCRIPT>
                  <OBJECT id="dlg" classid="clsid:3050f819-98b5-11cf-bb82-00aa00bdce0b" width="0px" height="0px">
                  </OBJECT>
                  <TR>
                    <TD>
                      <TABLE width='100%' border="0" cellspacing="1" cellpadding="1">
                        <TR valign="middle" >
                          <TD width=23%><FONT class="sub">&nbsp;<B>Message Name&nbsp;:</B></FONT></TD>
                          <TD width="62%">
                            <INPUT type="text" name="msg_name">
                            <INPUT type="submit" name="submit" value="Save Message">
                          </TD>
                          <TD width="15%" align="right"><FONT class="sub">
                            <INPUT type="checkbox" name="admin_do_preview" value="y" checked>
                            Preview</FONT></TD>
                        </TR>
                      </TABLE>
                    </TD>
                  </TR>
                  <TR>
                    <TD align=center>
                      <INPUT type="hidden" name="msg_html" value="<b>This is a test.</p>">
                      <INPUT type="hidden" name="msg" value="">
                      <IFRAME name="editor_iframe" id="editor_iframe" width="100%" height="200" onLoad="initOuterIFrame()" style="visibility: hidden" src="/cards-help1.html"></IFRAME>
                    </TD>
                  </TR>
                </FORM>
              </TABLE>
            </TD>
          </TR>
        </TABLE>
      </DIV>
    </TD>
  </TR>
</TABLE>
