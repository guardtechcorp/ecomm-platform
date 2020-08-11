<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/member2.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.Member2Bean"%>
<%@ page import="com.zyzit.weboffice.model.Member2Info"%>
<%
  Member2Bean bean = new Member2Bean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_MEMBERS))
     return;

//bean.showAllParameters(request, out);
//System.out.println("Value1 Leng="+request.getParameterValues("experiences").length);
//System.out.println("Value2 Leng="+request.getParameterValues("lastname").length);
//experiences =Water|Wastewater|SolidHazard|Noise|Other|

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  Member2Info info = null;
  if ("Add Member".equalsIgnoreCase(sAction))
  {
    Member2Bean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (Member2Info)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "member");
      //. Change to update of adding its sub-category
//      info = (CategoryInfo)ret.getUpdateInfo();
//      sAction = "Update Category";
    }
  }
  else if ("Update Member".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    Member2Bean.Result ret = bean.update(request, false);
    info = (Member2Info)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "member");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Member";
  }
  else if ("View".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "View";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Member";
  }

  if (info==null)
  {
    info = Member2Info.getInstance(true);
    sAction = "Add Member";
  }

  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  String sHelpTag = "member";
  String sTitleLinks = "";
  if (sReturn!=null)
    sTitleLinks = "<a href=\"" + sReturn +"\">" + sDisplay + "</a> > ";
  String sDescription;
  if ("Add Member".equalsIgnoreCase(sAction))
  {
     sTitleLinks += "<b>Add a New Member</b>";
     sDescription = "The form below will allow you to add a new member.";
  }
  else
  {
     sTitleLinks += "<b>Edit the Member</b>";
     sDescription = "The form below will allow you to edit & update or view the member information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>

<form name="member" action="member2.jsp" method="post" onsubmit="return validateMember(this);">
<input type="hidden" name="memberid" value="<%=info.MemberID%>">
<input type="hidden" name="return" value="<%=Utilities.getValue(sReturn)%>">
<input type="hidden" name="display" value="<%=Utilities.getValue(sDisplay)%>">
<% if (!"Add Member".equalsIgnoreCase(sAction)) { %>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("member2.jsp?return="+sReturn+"&display="+sDisplay+"&")%></td>
  </tr>
</table>
<% } %>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Member Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>

    <TR class="normal_row" align="center">
      <TD align="left" colSpan=2><FONT color="#ff0000">* Denotes required field.</FONT></TD>
    </TR>
    <TR class="normal_row" align="center">
      <TD width="28%" align="right"><font color="#ff0000">*</font> Membership Type:</TD>
      <TD align="left">
              <INPUT type="radio" value="Life Time Member $200" name="membertype" <%="Life Time Member $200".equalsIgnoreCase(info.MemberType)?"CHECKED":""%>>Life Time Member &nbsp;&nbsp;&nbsp;$200<BR>
        &nbsp;<INPUT type="radio" value="Regular Member $20/Year" name="membertype" <%="Regular Member $20/Year".equalsIgnoreCase(info.MemberType)?"CHECKED":""%>>Regular Member &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$20/Year<BR>
        &nbsp;<INPUT type="radio" value="Student Member $10/Year" name="membertype" <%="Student Member $10/Year".equalsIgnoreCase(info.MemberType)?"CHECKED":""%>>Student Member &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$10/Year<BR>
        &nbsp;<INPUT type="radio" value="Corporate Member $100/Year" name="membertype" <%="Corporate Member $100/Year".equalsIgnoreCase(info.MemberType)?"CHECKED":""%>>Corporate Member&nbsp;&nbsp;$100/Year
      </TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">
        <FONT color="#ff0000">*</FONT> Last Name:
      </TD>
      <TD ><INPUT size=60 maxlength=20 name="lastname" value="<%=Utilities.getValue(info.LastName)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> First Name:
      </TD>
      <TD ><INPUT size=60 maxlength=20 name="firstname" value="<%=Utilities.getValue(info.FirstName)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%"> Middle Name:</TD>
      <TD ><INPUT size=60 maxlength=20 name="middlename" value="<%=Utilities.getValue(info.MiddleName)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> Address:</TD>
      <TD ><INPUT size=60 maxlength=60 name="address" value="<%=Utilities.getValue(info.Address)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> City:</TD>
      <TD ><INPUT size=60 maxlength=20 name="city" value="<%=Utilities.getValue(info.City)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> State:</TD>
      <TD ><INPUT size=60 maxlength=20 name="state" value="<%=Utilities.getValue(info.State)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> Zip Code:</TD>
      <TD ><INPUT size=60 maxlength=10 name="zip" value="<%=Utilities.getValue(info.Zip)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%"><FONT color="#ff0000">*</FONT> Home Phone:</TD>
      <TD ><INPUT size=60  maxlength=20 name="homephone" value="<%=Utilities.getValue(info.HomePhone)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Home Fax:</TD>
      <TD ><INPUT size=60 maxlength=20 name="homefax" value="<%=Utilities.getValue(info.HomeFax)%>">
      </TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%"><font color="#ff0000">*</font> Home E-Mail:</TD>
      <TD ><INPUT size=60 maxlength=50 name="email" value="<%=Utilities.getValue(info.EMail)%>">
      </TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Home Web Site:</TD>
      <TD ><INPUT size=60 maxlength=255 name="homeurl" value="<%=Utilities.getValue(info.HomeURL)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Company Name:</TD>
      <TD ><INPUT size=60 maxlength=60 name="company" value="<%=Utilities.getValue(info.Company)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Company Address:</TD>
      <TD ><INPUT size=60 maxlength=255 name="companyaddress" value="<%=Utilities.getValue(info.CompanyAddress)%>">
      </TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Job Title:</TD>
      <TD ><INPUT size=60 maxlength=30 name="jobtitle" value="<%=Utilities.getValue(info.JobTitle)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Company Phone:</TD>
      <TD ><INPUT size=60 maxlength=20 name="workphone" value="<%=Utilities.getValue(info.WorkPhone)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Company Fax:</TD>
      <TD ><INPUT size=60 maxlength=20 name="workfax" value="<%=Utilities.getValue(info.WorkFax)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Company E-mail:</TD>
      <TD ><INPUT size=60 maxlength=50 name="workemail" value="<%=Utilities.getValue(info.WorkEMail)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Company Web Site:</TD>
      <TD ><INPUT size=60 maxlength=128 name="workurl" value="<%=Utilities.getValue(info.WorkURL)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Education<BR>&nbsp;Degree/Year:</TD>
      <TD ><INPUT size=60 maxlength=30 name="education" value="<%=Utilities.getValue(info.Education)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Major:</TD>
      <TD ><INPUT size=60 maxlength=30 name="major" value="<%=Utilities.getValue(info.Major)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">School:</TD>
      <TD ><INPUT size=60 maxlength=60 name="school" value="<%=Utilities.getValue(info.School)%>"></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Experiences:</TD>
      <TD>
        <INPUT type="checkbox" value="Air" name="experiences" <%=bean.getExperienceCheck(info, "Air")%>>Air&nbsp;
        <INPUT type="checkbox" value="Water" name="experiences" <%=bean.getExperienceCheck(info, "Water")%>>Water&nbsp;
        <INPUT type="checkbox" value="Wastewater" name="experiences" <%=bean.getExperienceCheck(info, "Wastewater")%>>Wastewater<BR>
        <INPUT type="checkbox" value="SolidHazard" name="experiences" <%=bean.getExperienceCheck(info, "SolidHazard")%>>Solid &amp; Hazardous Waste&nbsp;
        <INPUT type="checkbox" value="Energy" name="experiences" <%=bean.getExperienceCheck(info, "Energy")%>>Energy &nbsp;
        <INPUT type="checkbox" value="Noise" name="experiences" <%=bean.getExperienceCheck(info, "Noise")%>>Noise<BR>
        <INPUT type="checkbox" value="Other" name="experiences" <%=bean.getExperienceCheck(info, "Other")%>>Other:
        <INPUT size=50 maxlength=128 name="experiencesother" value="<%=Utilities.getValue(info.ExperiencesOther)%>">
      </TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Specialty:</TD>
      <TD ><TEXTAREA name="specialty" rows=3 cols=55><%=Utilities.getValue(info.Specialty)%></TEXTAREA></TD>
    </TR>
    <TR class="normal_row">
      <TD align="right" width="28%">Remarks:</TD>
      <TD >
        <TEXTAREA name="remarks" rows=3 cols=55><%=Utilities.getValue(info.Remarks)%></TEXTAREA>
      </TD>
    </TR>
    <TR class="normal_row">
      <TD colSpan=2 height=5></TD>
    </TR>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>" <%="View".equalsIgnoreCase(sAction)==true?"disabled":""%>></td>
  </tr>
  </table>
</form>
<!--SCRIPT>onMemberLoad(document.member);</SCRIPT-->
<%@ include file="../share/footer.jsp"%>