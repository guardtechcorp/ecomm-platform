<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.web.RSPropertyWeb"%>
<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%@ page import="com.zyzit.weboffice.plugin.model.*"%>
<%@ page import="com.zyzit.weboffice.plugin.PropertyResult"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{

  RSPropertyWeb web = new RSPropertyWeb(session, 20);
  String sAction = web.getRealAction(request);
//System.out.println("sAction Property Search=" + sAction);
  PropertyResult result = null;
  if (sAction.endsWith("getfipcodebyzip"))
  { //. Try to get fip code from zip
    response.getWriter().print(web.getFipCodeByZip(request));
    response.flushBuffer();
    return;
  }
  else if (sAction.endsWith("submit-propertysearch"))
  {
     result = web.subjectSearch(request);
     if (result.Error==0)
     {
//System.out.println("total Records=" + result.getTotalRecords());
//        response.sendRedirect(web.encodedUrl("index.jsp?action=propertylist"));
        TransferWeb.sendRedirectContent(response, "index.jsp?action=pi-propertylist");
        return;
     }
     else
     {
//System.out.println("Description=" + result.Description);
     }
  }

  ConfigInfo cfInfo = web.getConfigInfo();
/*
  <TABLE cellspacing=2 cellpadding=2 width="100%" bgcolor="cfInfo.BackColor"><TR><TD valign="top">
    <web.getNavigationBar(request, "Property Search")>
    <TABLE class="table-shang" cellspacing=0 cellpadding=1 width="100%" align="right">
*/
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/uscounty.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/propertysearch.js" type="text/javascript"></SCRIPT>
<LINK href="/staticfile/web/css/tabletag1.css" type="text/css" rel="stylesheet">
<!--[if IE]>
<style type="text/css">
.ddoverlap{
height: 1%;  /*1. Apply Holly 3px jog hack to get IE to position bottom border correctly beneath the menu*/
}
</style>
<![endif]-->
<TABLE cellspacing=2 cellpadding=2 width="100%" bgcolor="<%=cfInfo.BackColor%>">
   <TR>
    <TD colspan="2"><%=web.getNavigationWeb(request, "Property Search")%></TD>
   </TR>
   <TR>
     <TD height=5 valign="top"></TD>
   </TR>
   <TR>
    <TD colspan="2" align="center"><font class='pagetitle'>Property Search</font></TD>
   </TR>
   <!--TR>
    <TD height=10 colspan="2">You have the option of changing your search page by selecting one of the tabs below. </TD>
   </TR-->
   <TR>
    <TD height=10 colspan="2"></TD>
   </TR>
   <TR>
    <TD vAlign="top" align="center" width="1"></TD>
    <TD vAlign="top" align="center" width="595">
<%@ include file="../../waitprocess.jsp"%>
<SPAN id="Search_Form">
<div class="ddoverlap" align="center">
<ul>
<li id="address_tab" class="selected"><a href="javascript:switchMode(document.propertysearch_form, 'address', true);">Street Address</a></li>
<li id="advanced_tab"><a href="javascript:switchMode(document.propertysearch_form, 'advanced', true);">Advanced Address</a></li>
<li id="owner_tab"><a href="javascript:switchMode(document.propertysearch_form, 'owner', true);">Onwer Name</a></li>
<li id="apn_tab"><a href="javascript:switchMode(document.propertysearch_form, 'apn', true);">APN Search</a></li>
</ul>
<br style="clear: left" />
</div>
<TABLE class="banner" cellSpacing=0 cellPadding=0 width=100% bgColor="#f5f5f5" border=0>
<form name="propertysearch_form" action="index.jsp" method="post" onSubmit="return validateSearchForm(this);">
<INPUT type="hidden" name="action1" value="submit-propertysearch">
<INPUT type="hidden" name="mode" value="address">
<INPUT type="hidden" name="rootlink" value="yes">
 <tr>
  <td height="15"><td>
 <tr>
<% if (result!=null) { %>
 <tr>
  <td class="failed" align="center"><%=result.Description%><td>
 <tr>
 <tr>
  <td height="15"><td>
 <tr>
<% } %>
 <tr><td>
<SPAN id="address_section" style="display:inline;">
<TABLE cellSpacing=0 cellPadding=0 border=0>
  <TR>
   <TD vAlign=top colSpan=7 height=30>&nbsp;&nbsp;Hint: this search page uses "address standardization" logic.</TD>
  </TR>
  <TR>
   <TD vAlign=center align=right width=115><FONT class=subbold><NOBR>Street Address:&nbsp;</NOBR></FONT></TD>
   <TD align=left colSpan=6><INPUT class=textbox style="WIDTH: 300px" size=25 name="address_street" value="<%=Utilities.getValue(request.getParameter("address_street"))%>"></TD>
  </TR>
  <TR>
   <TD vAlign=center align=left height=18>&nbsp;</TD>
   <TD vAlign=top colSpan=6><FONT class=desci color=#666666>For example, 123 Main Ave. </FONT></TD>
  </TR>
  <TR>
   <TD vAlign=center align=right width=115 height=30><FONT class=subbold>City:&nbsp;</FONT></TD>
   <TD width=186 height=30><INPUT class=textbox style="WIDTH: 185px" size=25 name="address_city" value="<%=Utilities.getValue(request.getParameter("address_city"))%>"></TD>
   <TD vAlign=center align=right width=65 height=30><FONT class=subbold>State:&nbsp;</FONT></TD>
   <TD width=40 height=30><INPUT class=textbox style="WIDTH: 50px" maxLength=2 name="address_state" value="<%=Utilities.getValue(request.getParameter("address_state"))%>"> </TD>
   <TD vAlign=center align=center width=40 height=30><FONT class=subbold>&nbsp;&nbsp;OR</FONT></TD>
   <TD align=right width=20 height=30><FONT class=subbold>Zip:&nbsp;</FONT></TD>
   <TD width=57 height=30><INPUT class=textbox onblur="if(this.value.length<5){this.value='';}" onkeyup="onZipChanged(this, document.propertysearch_form, 'address');"
    ondrop="return false;" style="WIDTH: 50px" maxLength=5 size=8 name="address_zip" value="<%=Utilities.getValue(request.getParameter("address_zip"))%>"></TD>
  </TR>
</TABLE>
</SPAN>
<SPAN id="advanced_section" style="display:none;">
<TABLE cellSpacing=0 cellPadding=0 border=0>
  <TR>
   <TD vAlign=top colSpan=6 height=30>&nbsp;Hint: this search page only requires a House Number AND/OR Street Name for selected county. </TD>
  </TR>
  <TR>
   <TD vAlign=center align=right width=75><FONT class=subbold><NOBR>House No:&nbsp;</NOBR></FONT></TD>
   <TD align=left><INPUT class=textbox style="WIDTH: 60px" name="advanced_houseno"  value="<%=Utilities.getValue(request.getParameter("advanced_houseno"))%>"></TD>
   <TD align=right width=60><FONT class=subbold>Pre Dir:&nbsp;</FONT></TD>
   <TD width=50><SELECT class=textbox style="WIDTH: 50px" name="advanced_predir">
      <OPTION value="" selected>---</OPTION>
      <OPTION value=N>N</OPTION>
      <OPTION value=NE>NE</OPTION>
      <OPTION value=NW>NW</OPTION>
      <OPTION value=S>S</OPTION>
      <OPTION value=SE>SE</OPTION>
      <OPTION value=SW>SW</OPTION>
      <OPTION value=E>E</OPTION>
      <OPTION value=W>W</OPTION>
   </SELECT></TD>
   <TD align=right width=60><FONT class=subbold>Street:&nbsp;</FONT></TD>
   <TD><INPUT class=textbox style="WIDTH: 130px" name="advanced_streetname"  value="<%=Utilities.getValue(request.getParameter("advanced_streetname"))%>"></TD>
  </TR>
  <TR>
    <TD height=18 width=75>&nbsp;</TD>
    <TD>&nbsp;</TD>
    <TD>&nbsp;</TD>
    <TD align=right>&nbsp;</TD>
    <TD>&nbsp;</TD>
    <TD vAlign=top><FONT class=desc color=#666666>(Exclude 'st', 'ave', etc)</FONT></TD>
  </TR>
  <TR>
    <TD width=75 align=right><FONT class=subbold>Post Dir:&nbsp;</FONT></TD>
    <TD>
      <SELECT class=textbox style="WIDTH: 50px" name="advanced_postdir">
      <OPTION value="" selected>---</OPTION>
      <OPTION value=N>N</OPTION>
      <OPTION value=NE>NE</OPTION>
      <OPTION value=NW>NW</OPTION>
      <OPTION value=S>S</OPTION>
      <OPTION value=SE>SE</OPTION>
      <OPTION value=SW>SW</OPTION>
      <OPTION value=E>E</OPTION>
      <OPTION value=W>W</OPTION>
      </SELECT>
    </TD>
    <TD align=right width=60><FONT class=subbold>Suffix:&nbsp;</FONT></TD>
    <TD><INPUT class=textbox style="WIDTH: 50px" name="advanced_suffix" value="<%=Utilities.getValue(request.getParameter("advanced_suffix"))%>"></TD>
    <TD align=right width=60><FONT class=subbold>Unit No:&nbsp;</FONT></TD>
    <TD><INPUT class=textbox style="WIDTH: 50px" name="advanced_unitno"  value="<%=Utilities.getValue(request.getParameter("advanced_unitno"))%>"></TD>
   </TR>
   <TR>
    <TD height=18>&nbsp;</TD>
    <TD>&nbsp;</TD>
    <TD>&nbsp;</TD>
    <TD vAlign=top><FONT class=desc color=#666666>('st', 'ave', etc)</FONT></TD>
    <TD>&nbsp;</TD>
    <TD vAlign=top><FONT class=desc color=#666666>(Exclude '#' sign)</FONT></TD>
  </TR>
  <TR>
    <TD width=75 height=30 align="right"><FONT class=subbold>State:&nbsp;</FONT></TD>
    <TD height=30><SELECT class=textbox style="WIDTH: 50px" onchange="onStateChanged(document.propertysearch_form, 'advanced', true)" size=1 name="advanced_state">
     <OPTION selected></OPTION>
     </SELECT></TD>
    <TD align=right height=30 width=60><FONT class=subbold>County:&nbsp;</FONT></TD>
    <TD height=30><FONT class=subbold>
     <SELECT class=textbox style="WIDTH: 185px" onchange="onCountyChanged(document.propertysearch_form, 'advanced')" size=1 name="advanced_county">
     <OPTION value="00000" selected>Select County</OPTION></SELECT></FONT>
    </TD>
    <TD align=right height=30 width=60><FONT class=subbold>OR</FONT><FONT class=subbold>&nbsp;&nbsp;&nbsp;Zip:&nbsp;</FONT></TD>
    <TD><INPUT class=textbox onblur="if(this.value.length<5){this.value='';}" onkeyup="onZipChanged(this, document.propertysearch_form, 'advanced');" style="WIDTH: 50px" maxLength=5 name="advanced_zip"></TD>
  </TR>
</TABLE>
</SPAN>
<SPAN id="owner_section" style="display:none;">
<TABLE cellSpacing=0 cellPadding=0 border=0>
  <TR>
   <TD vAlign=top colSpan=6 height=30>&nbsp;Hint: this search page uses an auto wild-card, matching all names that start with the portion.</TD>
  </TR>
  <TR>
   <TD vAlign=center align=right width=100><FONT class=subbold>Last Name:&nbsp;</FONT></TD>
   <TD align=left colSpan=5><INPUT class=textbox style="WIDTH: 120px" size=25 name="owner_lastname"  value="<%=Utilities.getValue(request.getParameter("owner_lastname"))%>">
       <FONT class=subbold>First Name:&nbsp;</FONT><INPUT class=textbox style="WIDTH: 120px" size=25 name="owner_firstname"  value="<%=Utilities.getValue(request.getParameter("owner_firstname"))%>">
   </TD>
  </TR>
  <TR>
   <TD vAlign=center align=left height=12>&nbsp;</TD>
   <TD vAlign=top colSpan=5><FONT class=desc color=#666666></FONT></TD>
  </TR>
  <TR>
   <TD vAlign=center align=right width=100><FONT class=subbold><NOBR>City:&nbsp;</NOBR></FONT></TD>
   <TD align=left colSpan=5><INPUT class=textbox style="WIDTH: 310px" size=25 name="owner_city"  value="<%=Utilities.getValue(request.getParameter("owner_city"))%>"> (Optional)</TD>
  </TR>
  <TR>
   <TD vAlign=center align=left height=12></TD>
   <TD vAlign=top colSpan=5><FONT class=desc color=#666666></FONT></TD>
  </TR>
  <TR>
    <TD width=100 height=30 align="right"><FONT class=subbold>State:&nbsp;</FONT></TD>
    <TD height=30><SELECT class=textbox style="WIDTH: 50px" onchange="onStateChanged(document.propertysearch_form, 'owner', true)" size=1 name="owner_state">
     <OPTION selected></OPTION>
     </SELECT></TD>
    <TD align=right height=30 width=60><FONT class=subbold>County:&nbsp;</FONT></TD>
    <TD height=30><FONT class=subbold>
     <SELECT class=textbox style="WIDTH: 200px" onchange="onCountyChanged(document.propertysearch_form, 'owner')" size=1 name="owner_county">
     <OPTION value="00000" selected>Select County</OPTION></SELECT></FONT>
   </TD>
    <TD align=right height=30 width=80><FONT class=subbold>OR</FONT><FONT class=subbold>&nbsp;&nbsp;&nbsp;Zip:&nbsp;</FONT></TD>
    <TD><INPUT class=textbox onblur="if(this.value.length<5){this.value='';}" onkeyup="onZipChanged(this, document.propertysearch_form, 'owner');" style="WIDTH: 50px" maxLength=5 name="owner_zip"  value="<%=Utilities.getValue(request.getParameter("owner_zip"))%>"></TD>
  </TR>
</TABLE>
</SPAN>
<SPAN id="apn_section" style="display:none;">
<TABLE cellSpacing=0 cellPadding=0 border=0>
  <TR>
   <TD vAlign=top colSpan=6 height=30>&nbsp;Hint: this search page should include all dashes and zeroes. It will auto wild-card the portion.</TD>
  </TR>
  <TR>
   <TD vAlign=center align=right width=90><FONT class=subbold><NOBR>APN:&nbsp;</NOBR></FONT></TD>
   <TD align=left colSpan=6><INPUT class=textbox style="WIDTH: 315px" size=25 name="apn_apn"  value="<%=Utilities.getValue(request.getParameter("apn_apn"))%>"></TD>
  </TR>
  <TR>
   <TD vAlign=center align=left height=18>&nbsp;</TD>
   <TD vAlign=top colSpan=6><FONT class=comps color=#666666>For Example, 234-567-890</FONT></TD>
  </TR>
  <TR>
    <TD width=90 height=30 align="right"><FONT class=subbold>State:&nbsp;</FONT></TD>
    <TD height=30><SELECT style="WIDTH: 50px" onchange="onStateChanged(document.propertysearch_form, 'apn', true)" size=1 name="apn_state">
     <OPTION selected></OPTION>
     </SELECT></TD>
    <TD align=right height=30 width=60><FONT class=subbold>County:&nbsp;</FONT></TD>
    <TD height=30><FONT class=subbold>
     <SELECT style="WIDTH: 205px" onchange="onCountyChanged(document.propertysearch_form, 'apn')" size=1 name="apn_county">
     <OPTION value="00000" selected>Select County</OPTION></SELECT></FONT>
    </TD>
    <TD align=right height=30 width=80><FONT class=subbold>OR</FONT><FONT class=subbold>&nbsp;&nbsp;&nbsp;Zip:&nbsp;</FONT></TD>
    <TD><INPUT class=textbox onblur="if(this.value.length<5){this.value='';}" onkeyup="onZipChanged(this, document.propertysearch_form, 'apn');" style="WIDTH: 50px" maxLength=5 name="apn_zip"  value="<%=Utilities.getValue(request.getParameter("apn_zip"))%>"></TD>
  </TR>
</TABLE>
</SPAN>
  </td>
 </tr>
<tr>
 <td vAlign="top">
   <TABLE height=50 cellSpacing=5 cellPadding=0 width=500 align=left border=0>
    <TR align=middle>
     <TD width=271>
      <input type="submit" value="Submit Search" name="submit" onClick="setAction(document.propertysearch_form, 'pi-submit-propertysearch');"></td>
     <TD width=124>
      <input type="reset" value="Reset" name="reset">
     </TD>
   </TR>
  </TABLE>
 </td>
</tr>
</form>
</table>
</SPAN>
   </TD>
  </TR>
</TABLE>
<SCRIPT>onSearchFormLoad(document.propertysearch_form)</SCRIPT>
<% } %>