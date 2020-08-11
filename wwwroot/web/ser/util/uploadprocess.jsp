<!--SPAN id="HideUploadProcessing" style="width:100%; height:100%;display:none; border: 1px none #000000"-->
<SPAN id="MaskUploadProcessing" style="visibility: hidden; position:absolute; width:730px; padding:0px;">
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/uploadstatus.js"></SCRIPT>
<p><p>
<table class="tblBorder" border="0" cellpadding="0" cellspacing="0" align="center" width="100%" style="background-color:#e8eefa">
<!--TR>
 <TD vAlign=top align=left width=2 height=2><DIV class="tblTopLeftCorner"></DIV></TD>
 <TD height="2"></TD>
 <TD vAlign=top align=right width=2 height=2><DIV class="tblTopRightCorner"></DIV></TD>
</TR-->
<TR>
  <TD colspan="3" height="2"></TD>
</TR>
<tr>
 <td colspan="3" align="center">
  <table border="0" cellpadding="4" cellspacing="1" width="100%">
  <TR>
   <TD align="center" valign="top"><font size="3" face="Verdana, Arial, Helvetica, sans-serif"><strong><%=mcBean.getLabel("cm-process")%>...</strong></font></TD>
  </TR>
  <TR>
    <TD height="5"></TD>
  </TR>
  <TR>
    <TD align="center"><span id="uf_errormessage"></span></TD>
  </TR>
  <TR>
    <TD height="5"></TD>
  </TR>
  <TR>
   <TD align="center">
    <table width="95%">
     <tr class='prog-text'>
      <td height='30' colspan=2 valign='top'><%=mcBean.getLabel("cm-filename")%>: <font color='blue'><b><span id='uf_filename'></span></b></font></td>
     </tr>
     <tr>
      <td colspan=2><div class="prog-border"><div class="prog-bar" id="uf_barpercent" style="width: 0%;"><div align='center' id="uf_textpercent"></div></div></div></td>
     </tr>
     <tr class='prog-text'>
      <td ><%=mcBean.getLabel("fs-received")%>: <b><span id="uf_receivedbytes"></span></b> K</td>
      <td align=right><%=mcBean.getLabel("fs-totalbyte")%>: <b><span id="uf_totalbytes"></span></b> K</td>
     </tr>
     <tr class='prog-text'>
      <td><%=mcBean.getLabel("fs-tranrate")%>: <b><span id="uf_rate"></span></b> Kbs</td>
      <td align=right><%=mcBean.getLabel("fs-esttime")%>: <b><span id="uf_estimatedtime"></span></b></td>
     </tr>
     <tr class='prog-text'>
      <td><%=mcBean.getLabel("fs-elptime")%>: <b><span id="uf_elapsedtime"></span></b></td>
      <td align=right><%=mcBean.getLabel("fs-remtime")%>: <b><span id="uf_timeremain"></span></b></td>
     </tr>
     <tr class='prog-text'>
      <td colspan=2 align='center' height='10'></td>
     </tr>
     <tr class='prog-text'>
      <td colspan=2 align='center'><input type='button' id='bt_cancel' name='bt_cancel' value='<%=mcBean.getLabel("cm-cancel")%>' onClick='javascript:stopUpload(this)' style='WIDTH:80px'></td>
     </tr>
   </table>                   
   </TD>
  </TR>
  </table>
 </td>
</tr>        
<TR>
  <TD colspan="3" height="10"></TD>
</TR>
 <!--TR>
   <TD vAlign=bottom align=left width=2 height=2><DIV class="tblBotLeftCorner"></DIV></TD>
   <TD width="518" height="2"></TD>
   <TD vAlign=bottom align=right width=2 height=2><DIV class="tblBotRightCorner"></DIV></TD>
 </TR-->
</TABLE>
</SPAN>
