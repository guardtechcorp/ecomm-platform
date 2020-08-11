<%
/*
  xyz - An arbitrary variable name to store the bar reference and must be unique. This variable will have a few different methods (explained later) which can be used to control some of each bar's behavior. This variable IS REQUIRED if you wish to use these methods. However, if you do not plan to use the methods, then the variable assignment is not necessary, but it won't hurt to use it anyway.
  width- Total width of the entire bar in pixels.
  height- Total height of the entire bar in pixels.
  backgroundColor- Background color of the bar. Use valid CSS color or HEX color code value.
  borderWidth- The width of the border around the bar, in pixels.
  borderColor- The color of the border around the bar. Use valid CSS color or HEX color code value.
  blockColor- The darkest color of the individual blocks. The color will progressively become more transparent. Use valid CSS color or HEX color code value.
  scrollSpeed- The delay, in milliseconds, between each scroll step. Use smaller values for faster scroll speeds.
  blockCount- The total number of blocks to use.
  actionCount - The number of times the bar is to scroll before actionString is performed.
  actionString - The javascript function, in string form, to execute once the bar has scrolled actionCount times. Set this to an empty string to do nothing. If doing nothing, you can use any number as actionCount.
#FF9933,#daa520
createBar(width, height, backgroundColor, borderWidth, borderColor, blockColor, scrollSpeed, blockCount, actionCount, actionString)
*/
%>
<SPAN id="Processing" style="width:100%; height:100%;display:none; background-color: #E8EBF4; layer-background-color: #FFFFFF; border: 1px none #000000">
<TABLE align="left" width="100%" height="100%" cellspacing="0" cellpadding="0" border="0">
  <TR>
    <TD height="40"></TD>
  </TR>
  <TR>
    <TD align="center" valign="top"><B><FONT size=4>It is processing request, please wait ...<BR><BR></FONT></B>
      <SCRIPT>createBar(400,25,'#FFFFFF',2,'#F5F5F5','blue',300,15,3,"");</SCRIPT>
    </TD>
  </TR>
</TABLE>
</SPAN>