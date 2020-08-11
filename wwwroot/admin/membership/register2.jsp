<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.Member2Bean"%>
<%@ page import="com.zyzit.weboffice.model.Member2Info"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>SCCAEPA - Online Membership Application</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/member2.js"></SCRIPT>
</HEAD>
<BODY>
<%
  Member2Bean bean = new Member2Bean(session, 0);
  String sDomainName = bean.getDomainNameFromUrl(session, request, true);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  Member2Bean.Result ret = null;
  if ("Submit Application".equalsIgnoreCase(sAction))
  {
    ret = bean.register(request, sDomainName);
  }
%>
<% if (ret==null) { %>
<FORM name="registeration" onsubmit="return validateMember(this)" action="register2.jsp" method="post" align="center">
<input type="hidden" name="domainname" value="<%=sDomainName%>">
  <TABLE width=600 border=0 align="center">
    <TR align=middle>
      <TD align=left colSpan=2><FONT color="#ff0000">* Denotes required field.</FONT></TD>
    </TR>
    <TR align=middle>
      <TD width="28%" align="right"><font color="#ff0000">*</font> Membership Type:</TD>
      <TD align="left"><INPUT type="radio" CHECKED value="Life Time Member $200" name="MemberType">Life Time Member &nbsp;&nbsp;&nbsp;$200<BR>
        <INPUT type="radio" value="Regular Member $20/Year" name="MemberType">Regular Member &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$20/Year<BR>
        <INPUT type="radio" value="Student Member $10/Year" name="MemberType">Student Member &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$10/Year<BR>
        <INPUT type="radio" value="Corporate Member $100/Year" name="MemberType">Corporate Member&nbsp;&nbsp;$100/Year
      </TD>
    </TR>
    <TR>
      <TD align="right" width="28%">
        <FONT color="#ff0000">*</FONT> Last Name:
      </TD>
      <TD ><INPUT size=60 maxlength=20 name="lastname"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> First Name:
      </TD>
      <TD ><INPUT size=60 maxlength=20 name="firstname"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%"> Middle Name:</TD>
      <TD ><INPUT size=60 maxlength=20 name="middlename"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> Address:</TD>
      <TD ><INPUT size=60 maxlength=60 name="address"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> City:</TD>
      <TD ><INPUT size=60 maxlength=20 name="city"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> State:</TD>
      <TD ><INPUT size=60 maxlength=20 name="state"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> Zip Code:</TD>
      <TD ><INPUT size=60 maxlength=10 name="zip"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> Home Phone:</TD>
      <TD ><INPUT size=60  maxlength=20 name="homephone"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Home Fax:</TD>
      <TD ><INPUT size=60 maxlength=20 name="homefax">
      </TD>
    </TR>
    <TR>
      <TD align="right" width="28%"><font color="#ff0000">*</font> Home E-Mail:</TD>
      <TD ><INPUT size=60 maxlength=50 name="email">
      </TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Home Web Site:</TD>
      <TD ><INPUT size=60 maxlength=255 name="homeurl"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Company Name:</TD>
      <TD ><INPUT size=60 maxlength=60 name="company"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Company Address:</TD>
      <TD ><INPUT size=60 maxlength=255 name="companyaddress">
      </TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Job Title:</TD>
      <TD ><INPUT size=60 maxlength=30 name="jobtitle"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Company Phone:</TD>
      <TD ><INPUT size=60 maxlength=20 name="workphone"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Company Fax:</TD>
      <TD ><INPUT size=60 maxlength=20 name="workfax"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Company E-mail:</TD>
      <TD ><INPUT size=60 maxlength=50 name="workemail"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Company Web Site:</TD>
      <TD ><INPUT size=60 maxlength=128 name="workurl"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Education<BR>&nbsp;Degree/Year:</TD>
      <TD ><INPUT size=60 maxlength=30 name="education"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Major:</TD>
      <TD ><INPUT size=60 maxlength=30 name="major"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">School:</TD>
      <TD ><INPUT size=60 maxlength=60 name="school"></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Experiences:</TD>
      <TD ><INPUT type="checkbox" value="Air" name="experiences">Air&nbsp;
        <INPUT type="checkbox" value="Water" name="experiences">Water&nbsp;
        <INPUT type="checkbox" value="Wastewater" name="experiences">Wastewater<BR>
        <INPUT type="checkbox" value="Solid &amp; Hazardous Waste" name="experiences">Solid &amp; Hazardous Waste&nbsp;
        <INPUT type="checkbox" value="Energy" name="experiences">Energy &nbsp;
        <INPUT type="checkbox" value="Noise" name="experiences">Noise<BR>
        <INPUT type="checkbox" value="Other" name="experiences">Other:<INPUT size=32 maxlength=60 name="experiencesother">
      </TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Specialty:</TD>
      <TD ><TEXTAREA name="specialty" rows=3 cols=55></TEXTAREA></TD>
    </TR>
    <TR>
      <TD align="right" width="28%">Remarks:</TD>
      <TD >
        <TEXTAREA name="remarks" rows=3 cols=55></TEXTAREA>
      </TD>
    </TR>
    <TR>
      <TD colSpan=2 height=5></TD>
    </TR>
    <TR>
      <TD align="center" colSpan=2 height=2><input type="submit" value="Submit Application" name="action">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=reset value=Reset name=B2></TD>
    </TR>
  </TABLE>
</FORM>
<% } else { %>
<% if (ret.isSuccess()) { %>
<%=(String)ret.getUpdateInfo()%>
<% } else{ %>
An error occures when you are registering. Please report this error to customerservice@<%=sDomainName%>
<%
  Errors errObj = (Errors)ret.getInfoObject();
  sDisplayMessage = errObj.getError();
%>
<%=sDisplayMessage%>
<% } %>
<% } %>
</BODY>
</HTML>