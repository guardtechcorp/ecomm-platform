<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.RSPropertyWeb"%>
<%@ page import="com.zyzit.weboffice.model.CoverPageInfo"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
{

  RSPropertyWeb web = new RSPropertyWeb(session, 10);

//bean.showAllParameters(request, out);
  String sAction = web.getRealAction(request);

  String sDisplayMessage = null;
  String sClass = "successful";
  CoverPageInfo info = null;
  boolean bClose = false;
  if (sAction.endsWith("cp-update-coverpageinfo"))
  {
    RSPropertyWeb.Result ret = web.updateCoverPage(request);
    info = (CoverPageInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
//      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "account");
    }
    bClose = true;
  }
  else//  if (sAction.endsWith("edit-accountinfo"))
  {
    info = web.getCoverPage(request);
  }

  if (info==null)
     info = CoverPageInfo.getInstance(true);

  ConfigInfo cfInfo = web.getConfigInfo();
%>
<HTML>
<HEAD>
<title>Cover Page Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=<%=cfInfo.Language%>">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<LINK href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet">
<!--link rel="shortcut icon" href="favicon.ico"-->
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/languages/<%=cfInfo.Language%>.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/windows.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/propertysearch.js" type="text/javascript"></SCRIPT>
</HEAD>
<body TOPMARGIN=5>
<% if (bClose) { %>
<SCRIPT language="JavaScript" type="text/javascript">
 window.close();
</SCRIPT>
<% } %>
<table cellspacing=1 cellpadding=0 width="98%" align="center">
  <TR>
    <TD height=5 valign="top"></TD>
  </TR>
  <TR>
    <TD align="center"><font class='pagetitle'>Cover Page Information</font></TD>
  </TR>
  <TR>
    <TD height=10 valign="bottom"></TD>
  </TR>
  <TR>
    <TD>
     <FORM name="coverpage" action="<%=web.encodedUrl("plugin/property/coverpageinfo.jsp")%>" method="post" onSubmit="return validateCoverPage(this);">
     <input type="hidden" name="memberid" value="<%=info.MemberID%>">
     <input type="hidden" name="pageid" value="<%=info.PageID%>">
     <input type="hidden" name="action1" value="cp-update-coverpageinfo">
     <TABLE class="table-1" width="100%" align="center" border=0 bgcolor="<%=cfInfo.BackColor%>">
      <TR>
       <TD valign="top">
        <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<% if (sDisplayMessage!=null) { %>
        <tr>
         <td colspan="3" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
        </tr>
<% } %>
         <tr>
          <td colspan="3" height="5" align="center"></td>
        </tr>
         <tr>
          <td colspan=3><b>Prepared By:</b></td>
        </tr>
         <tr>
          <td colspan=3 height=5></td>
        </tr>
         <tr>
          <td width="27%" align="right">Your Name: </td>
          <td width="1%">&nbsp;</td>
          <td ><input maxlength=40 size=60 value="<%=Utilities.getValue(info.YourName)%>" name="yourname"> </td>
        </tr>
         <tr>
          <td width="27%" align="right">Company:</td>
          <td width="1%">&nbsp;</td>
          <td ><input maxlength=100 size=60 value="<%=Utilities.getValue(info.Company)%>" name="company"> </td>
        </tr>
         <tr>
          <td width="27%" align="right">Street:</td>
          <td width="1%">&nbsp;</td>
          <td ><input maxlength=60 size=60 value="<%=Utilities.getValue(info.Street)%>" name="street"></td>
        </tr>
         <tr>
          <td width="27%" align="right">City, State &amp; Zip: </td>
          <td width="1%">&nbsp;</td>
          <td><input maxlength=128 size=60 value="<%=Utilities.getValue(info.CityStateZip)%>" name="citystatezip"></td>
        </tr>
         <tr>
          <td width="27%" align="right">Phone Number:</td>
          <td width="1%">&nbsp;</td>
          <td><input maxlength=20 size=60 value="<%=Utilities.getValue(info.Phone)%>" name="phone"></td>
        </tr>
         <tr>
          <td width="27%" align="right">Fax Number:</td>
          <td width="1%">&nbsp;</td>
          <td><input maxlength=20 size=60 value="<%=Utilities.getValue(info.Fax)%>" name="fax"></td>
        </tr>
         <tr>
          <td align="right">E-Mail:</td>
          <td>&nbsp;</td>
          <td><input maxlength=60 size=60 value="<%=Utilities.getValue(info.EMail)%>" name="email"></td>
        </tr>
         <tr>
          <td align="right">Website Url::</td>
          <td>&nbsp;</td>
          <td><input maxlength=255 size=60 value="<%=Utilities.getValue(info.WebUrl)%>" name="weburl"> </td>
        </tr>
        <tr>
          <td height="20" colspan=3><hr width="98%"> </td>
        </tr>
        <tr>
          <td colspan=3><b>Prepared For:</b></td>
        </tr>
        <tr>
          <td colspan=3 height=5></td>
        </tr>
         <tr>
          <td align="right">Name:</td>
          <td>&nbsp;</td>
          <td ><input maxlength=40 size=60 value="<%=Utilities.getValue(info.m_ct_YourName)%>" name="m_ct_yourname"> </td>
        </tr>
         <tr>
          <td align="right">Company:</td>
          <td>&nbsp;</td>
          <td ><input maxlength=100 size=60 value="<%=Utilities.getValue(info.m_ct_Company)%>" name="m_ct_company"> </td>
        </tr>
         <tr>
          <td align="right">Street:</td>
          <td>&nbsp;</td>
          <td ><input maxlength=100 size=60 value="<%=Utilities.getValue(info.m_ct_Street)%>" name="m_ct_street"></td>
        </tr>
         <tr>
          <td align="right">City, State &amp; Zip:</td>
          <td>&nbsp;</td>
          <td><input maxlength=128 size=60 value="<%=Utilities.getValue(info.m_ct_CityStateZip)%>" name="m_ct_citystatezip"></td>
        </tr>
         <tr>
          <td align="right">Phone Number:</td>
          <td>&nbsp;</td>
          <td><input maxlength=20 size=60 value="<%=Utilities.getValue(info.m_ct_Phone)%>" name="m_ct_phone"></td>
        </tr>
         <tr>
          <td align="right">Fax Number:</td>
          <td>&nbsp;</td>
          <td><input maxlength=20 size=60 value="<%=Utilities.getValue(info.m_ct_Fax)%>" name="m_ct_fax"> </td>
        </tr>
         <tr>
          <td align="right">Comments:</td>
          <td>&nbsp;</td>
          <td><textarea name="m_ct_comments" cols="39" rows="5"><%=Utilities.getValue(info.m_ct_Comments)%></textarea></td>
        </tr>
         <tr>
          <td colspan=3 height=10></td>
        </tr>
         <tr>
          <td colspan=3>&nbsp;</td>
        </tr>
         <tr>
          <td class="row1" colspan=2>&nbsp;</td>
          <td class="row1" width="68%">
          <input type="submit" name="update" value="Update">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" name="cancel" value="Cancel" onClick="javascript:window.close();"></td>
        </tr>
         <tr>
          <td colspan="3" height="10">&nbsp; </td>
        </tr>
        </table>
        </TD>
       </TR>
      </TABLE>
     </FORM>
    </td>
   </tr>
</table>
<SCRIPT>onCoverPageFormLoad(document.coverpage)</SCRIPT>
</BODY>
</HTML>
<% } %>
