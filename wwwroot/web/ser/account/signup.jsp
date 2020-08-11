<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.database.Membership"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ page import="com.zyzit.weboffice.model.MembershipInfo"%>
<%@ include file="../include/pageheader.jsp"%>
<%
{
//    I have read and understand the following policies:
    MemberInfo info = null;
    String sSubjectNote = null;//mcBean.getTemplateSubject("SignUp-Note");
    String sContentNote = null;//mcBean.getTemplateContent("SignUp-Note");
//Sign up a free account, you can get immediate benefits and good services!
//<ul><li>You can own a website with/without a domain name mapping to it.</li><br><li>You can invite/accept/added unlimited members of your website.</li><br><li>You can have a online file storage with powerful functions.</li></ul>    

    StringBuffer sbContentNode = new StringBuffer();
    String sUpgrade = null;
    if (sRealAction.startsWith("Submit")) {
        info = (MemberInfo) ret.getUpdateInfo();
        if (ret.isSuccess()) {
            info = (MemberInfo) ret.getUpdateInfo();

            sSubjectNote = "Congratulation! You are successfully sign up a free user account.";

            sbContentNode.append("<LI>You have automatically signed in the big family of <b>Web Center</b> now.</LI><br>");
            sbContentNode.append("<LI>You can enjoin all of user-level services and resources that provided by various websites from now on.</LI><br>");
            sUpgrade = "<A href='" + mcBean.encodedUrl("index.jsp?action=Load_UpgradeAccount&rl=1&pt=Upgrade Account") + "'>Upgrade</A>";
            sbContentNode.append("<LI>You can " + sUpgrade + " your account to a website ownership account to have a website with remote storage and run your membership any time.</LI><br>");
            sbContentNode.append("<LI>You can apply, accept or purchase the membership in different websites and enjoin their member-level services and resources in the future.</LI><br>");
            sbContentNode.append("<LI>Hi, " + info.getPersonalName() + ", thanks. Enjoin it.</LI>");

        } else {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
    } else {
        info = MemberInfo.getInstance2();
        info.Gender = -1;
        info.Type = 0;
        info.Slogan = "I am a very nice person.";
        info.SloganColor = "#ffffff";
        info.SloganBkColor = "#B0C4DE";
//        info.SloganFont = "Times New Roman, Times, serif";
        info.SloganSize = 2;
        info.SloganStyle = 4;
    }

    if (info == null || info.MemberID <= 0) {
        sSubjectNote = "Sign up a free account, you can get immediate benefits and good services!";

        sbContentNode.append("<LI>You can visit and navigate all the sites in <b>Web Center</b> big family.</LI><br>");
        sbContentNode.append("<LI>You can enjoin all of user-level services and resources that provided by various websites.</LI><br>");
        sbContentNode.append("<LI>You can upgrade your account to a site ownership account to have a website with remote storage and run your membership.</LI><br>");
        sbContentNode.append("<LI>You can apply, accept or purchase the membership in different websites and enjoin their member-level services and resources.</LI>");
    }

    sContentNote = sbContentNode.toString();

    MembershipInfo msInfo = mcBean.getSiteMembershipInfo();

//Utilities.dumpObject(info);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="member" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateMemberSignup(this);">
<input type="hidden" name="memebrid" value="<%=info.MemberID%>">
<input type="hidden" name="type" value="<%=info.Type%>">
<input type="hidden" name="slogan" value="<%=info.Slogan%>">
<input type="hidden" name="slogancolor" value="<%=info.SloganColor%>">
<input type="hidden" name="sloganbkcolor" value="<%=info.SloganBkColor%>">
<input type="hidden" name="slogansize" value="<%=info.SloganSize%>">
<input type="hidden" name="sloganstyle" value="<%=info.SloganStyle%>">
<input type="hidden" name="pt" value="Sign Up Information">
<!--input type="hidden" name="public" value="yes"-->
<input type="hidden" name="rl" value="1">
<input type="hidden" name="action1" value="Submit_SignUp">
<TABLE class="table-outline" width="100%" align="center">
  <tr>
   <td colspan="3" width="100%">
    <%@ include file="../include/promotenote.jsp"%>
   </td>
  </tr>
  <tr>
    <td colspan="3" height="10" align="center"></td>
  </tr>
  <TR>
   <TD colspan="3" height="2">
    <%@ include file="../include/information.jsp"%>
   </TD>
  </TR>

<% if (info.MemberID<=0) { %>
  <tr>
    <td colspan="3" height="24">&nbsp;&nbsp;<b><%=mcBean.getLabel("lg-personalinfo")%>:</b> (<%=mcBean.getLabel("lg-allfield")%>)</td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"> <%=mcBean.getLabel("pf-firstname")%>:</td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=20 size=40 value="<%=info.FirstName%>" name="firstname"></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"> <%=mcBean.getLabel("pf-lastname")%>:</td>
    <td width="1%">&nbsp;</td>
    <td ><input maxlength=20 size=40 value="<%=info.LastName%>" name="lastname"></td>
  </tr>
<!--
  <tr>
    <td height="24" width="27%" align="right">Account Type</td>
    <td width="1%">&nbsp;</td>
    <td>
    <select name="type">
     <option value=0 <%=mcBean.getSelected(0, info.Type)%>>Individual</option>
     <option value=1 <%=mcBean.getSelected(1, info.Type)%>>Business</option>
     <option value=2 <%=mcBean.getSelected(2, info.Type)%>>Business with your website name</option>
    </select>
   </td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"> Work Phone:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 value="<%=info.WorkPhone%>" name="workphone"></td>
  </tr>
  <tr>
   <td height="24" width="27%" align="right">Home Phone:</td>
   <td width="1%">&nbsp;</td>
   <td><input maxlength=20 size=40 value="<%=info.HomePhone%>" name="homephone"></td>
  </tr>
  <tr>
   <td height="24" width="27%" align="right">Cell Phone:</td>
   <td width="1%">&nbsp;</td>
   <td><input maxlength=20 size=40 value="<%=Utilities.getValue(info.CellPhone)%>" name="cellphone"></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right">Fax:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 value="<%=info.Fax%>" name="fax"></td>
  </tr>
-->
  <tr>
   <td height="24" width="27%" align="right"> <%=mcBean.getLabel("pf-gender")%></td>
   <td width="1%">&nbsp;</td>
   <td>
    <select name="gender">
     <option value=-1 >[<%=mcBean.getLabel("lg-select")%>]</option>
     <option value=1 <%=mcBean.getSelected(1, info.Gender)%>><%=mcBean.getLabel("pf-male")%></option>
     <option value=0 <%=mcBean.getSelected(0, info.Gender)%>><%=mcBean.getLabel("pf-female")%></option>
    </select>
   </td>
  </tr>
  <tr>
    <td colspan="3" height="5"></td>
  </tr>
  <tr>
    <td colspan="3" height="24">&nbsp;&nbsp;<b><%=mcBean.getLabel("lg-accountinfo")%>:</b> (<%=mcBean.getLabel("lg-accountdes")%>)</td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"> <%=mcBean.getLabel("lg-activeemail")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=50 size=40 value="<%=info.EMail%>" name="email"></td>
  </tr>
  <tr>
   <td height="24" width="27%" align="right"> <%=mcBean.getLabel("lg-retype")%>:</td>
   <td width="1%">&nbsp;</td>
   <td><input maxlength=50 size=40 value="<%=info.EMail%>" name="remail"></td>
  </tr>
  <tr>
    <td colspan="3" height="10"></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"> <%=mcBean.getLabel("lg-password")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 value="<%=info.Password%>" name="password" type="password"></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"> <%=mcBean.getLabel("lg-confirm")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 value="<%=info.Password%>" name="cpassword" type="password"></td>
  </tr>
  <!--tr>
    <td height="24" width="27%" align="right" valign="top">* Enter the code shown below:</td>
    <td width="1%">&nbsp;</td>
    <td valign="top">
      <input maxlength=20 size=40 name="imagecode">&nbsp;This will prevent automated signup. <a href="javascript:ChildWin=window.open('/staticfile/web/imagecode-help.html','imagecode_help','resizable=yes,scrollbars=no,width=300,height=400');ChildWin.focus()">Help</a>
     <br><img name="captchaimg" src="../../admin/util/captcha.jsp?action=getimage" align="top" alt="Enter the characters appearing in this image" border="1"/>
    </td>
  </tr-->
<% if (msInfo.JoinType!=Membership.JOINTYPE_NOMEMBERSHIP) { %>
  <tr>
    <td height="24">&nbsp;&nbsp;<b><%=mcBean.getLabel("lg-applymship")%>:</b></td>
    <td width="1%">&nbsp;</td>
    <td ><input type="checkbox" name="applymembership" value="1" <%=request.getParameter("applymembership")!=null?"checked":""%>>&nbsp;<%=mcBean.getLabel("lg-applytobe")%></td>
  </tr>
<% } %>
  <tr>
    <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"><input type="checkbox" name="agreeto" value="1"></td>
    <td width="1%">&nbsp;</td>
    <!--td>I agree to the terms and conditions. <a href="javascript:ChildWin=window.open('agreement.html','Agreement','resizable=yes,scrollbars=yes,width=500,height=650');ChildWin.focus()">View it </a></td-->
    <td><%=mcBean.getLabel("lg-iread")%> <a href="javascript:;" onClick="taggleViewTerms('<%=mcBean.encodedUrl("ajaxresponse.jsp?action=GetServiceTerms")%>');"><%=mcBean.getLabel("lg-viewit")%> </a></td>
  </tr>
  <TR>
   <TD colspan="3" height="1" valign="top">
    <DIV id="idtermsview" style="DISPLAY: none;">
     <div style="width:100%; height:200px; background-color:#FFFFCC; overflow:auto; BORDER:#4279bd 1px dashed;" >
     <table width="100%" cellpadding="4" cellspacing="2">
     <tr>
      <td id="idtermscontent" width="100%"></td>
     </tr>
     </table>
    </div>
   </DIV>
   </TD>
 </TR>
  <tr>
    <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
  </tr>
  <tr>
    <td colspan="3" height="10"></td>
  </tr>
  <tr>
    <td class="row1" colspan=2>&nbsp;</td>
    <td class="row1" width="68%">
      <input type="submit" name="update" style='width:120px' value="<%=mcBean.getLabel("lg-signup")%>" onClick="setAction(document.member,'Submit_SignUp');">
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="reset" name="Reset" style='width:80px' value="<%=mcBean.getLabel("cm-reset")%>">
    </td>
  </tr>
  <SCRIPT>onMemberFormLoad(document.member);</SCRIPT>
<% } else {%>
  <tr>
   <td colspan="3" height="10"></td>
  </tr>
  <tr>
   <td colspan="3" height="24">&nbsp;&nbsp;<b><%=mcBean.getLabel("lg-signupinfo")%>:</b> [ <a href="<%=mcBean.encodedUrl("index.jsp?action=Edit_Profile&rl=1&pt=Account Information")%>"><%=mcBean.getLabel("cm-edit")%></a> ] (<%=mcBean.getLabel("lg-saveit")%> <a class="hightlight" href="javascript:window.print();"><%=mcBean.getLabel("lg-print")%></a>)%>). </td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"><%=mcBean.getLabel("pf-firstname")%>:</td>
    <td width="1%">&nbsp;</td>
    <td ><b><%=info.FirstName%></b></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"><%=mcBean.getLabel("pf-lastname")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><b><%=info.LastName%></b></td>
  </tr>
  <tr>
     <td height="24" width="27%" align="right"><%=mcBean.getLabel("pf-gender")%></td>
     <td width="1%">&nbsp;</td>
     <td><b><%=info.Gender==1?mcBean.getLabel("pf-male"):mcBean.getLabel("cm-female")%></b></td>
  </tr>
  <tr>
    <td colspan="3" height="5"></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"><%=mcBean.getLabel("lg-accountname")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><b><%=info.EMail%></b></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"><%=mcBean.getLabel("pf-password")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><b><%=info.Password%></b></td>
  </tr>
  <tr>
    <td colspan="3" height="5"></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"><%=mcBean.getLabel("lg-accounttype")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><b><%=mcBean.getLabel("lg-commonaccount")%></b> (<%=sUpgrade%> <%=mcBean.getLabel("lg-owneraccount")%>)</td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"><%=mcBean.getLabel("lg-signupat")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><b><%=mcBean.getSiteUrl(cfInfo)%></b></td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"><%=mcBean.getLabel("lg-mshipat")%>:</td>
    <td width="1%">&nbsp;</td>
    <td>
<% if ("1".equalsIgnoreCase(request.getParameter("applymembership"))) { %>
    <b><%=mcBean.getLabel("lg-applied")%></b> [ <A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rl=1&pt=" + mcBean.getLabel("lg-checkmship"))%>' title="<%=mcBean.getLabel("lg-clickcheck")%> <%=cfInfo.WebTitle%>."><%=mcBean.getLabel("lg-check")%></A> ]
<% } else { %>
   <b><%=mcBean.getLabel("lg-notapply")%></b> [ <A class="content" href='<%=mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rl=1&pt=" + mcBean.getLabel("lg-applymship"))%>' title="<%=mcBean.getLabel("lg-clickapply")%> <%=cfInfo.WebTitle%>."><%=mcBean.getLabel("lg-apply")%></A> ]
<% } %>
    </td>
  </tr>
  <tr>
    <td height="24" width="27%" align="right"><%=mcBean.getLabel("lg-signupdate")%>:</td>
    <td width="1%">&nbsp;</td>
    <td><b><%=Utilities.getDateValue(info.CreateDate, 19)%></b></td>
  </tr>
<% } %>
  <tr>
    <td colspan="3" height="6"></td>
  </tr>
</TABLE>
</FORM>
<% } %>