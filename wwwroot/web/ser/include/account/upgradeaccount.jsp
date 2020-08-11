<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo" %>
<%
{
//bean.showAllParameters(request, out);
    String sSubjectNote = null;//mcBean.getTemplateSubject("SignUp-Note");
    String sContentNote = null;//mcBean.getTemplateContent("SignUp-Note");

    StringBuffer sbContentNode = new StringBuffer();
    String sUpgrade = null;
    if (sRealAction.startsWith("Submit"))
    {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
        else
        {
//           sDisplayMessage = "Upgrade your account is successfully upgraded and you can config your website now.<p> Enjoin to use it!";
           sSubjectNote = "Congratulation! Upgrade to the Site Ownership Account is finish successfully.";

           sbContentNode.append("<LI>Your website with a lot of features is setup ready now. It is your job to customize it.</LI><br>");
           sbContentNode.append("<LI>You can add, edit or delete any web pages any time.</LI><br>");
           sbContentNode.append("<LI>You can run membership to collect members and communicate each other if you want.</LI><br>");
           sbContentNode.append("<LI>You can upload/download file to/from the file storage from any place remotely.</LI><br>");

           sContentNote = sbContentNode.toString();
        }
    }

    if (sContentNote==null)
    {
        sSubjectNote = "Upgrade your account, you can get immediate benefits and good services!";

        sbContentNode.append("<LI>You can own a website with/without a domain name mapping to it.</LI><br>");
        sbContentNode.append("<LI>You can add, edit or delete any web pages using different sources and select security access level for each of them.</LI><br>");
        sbContentNode.append("<LI>You can run membership to invite/accept/added unlimited members of your website.</LI><br>");
        sbContentNode.append("<LI>You can have a remote online file storage with powerful functions to manage them.</LI>");

        sContentNote = sbContentNode.toString();
    }

%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="form_cancel" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post">
<input type="hidden" name="pagetitle" value="Upgrade My Account">
<input type="hidden" name="rootlink" value="yes">
<input type="hidden" name="action1" value="Submit_UpgradeAccount">
<br>
<table class="table-outline" width="100%" align="center">
<tr>
 <td>
  <%@ include file="../include/promotenote.jsp"%>
 </td>
</tr>
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>     
<tr>
  <td height="20" valign="bottom"></td>
</tr>
<% if (!sRealAction.startsWith("Submit")) { %>
<tr>
<td align="center"><input type="submit" name="submit" style='width:180px' value="Upgrade Account"></td>
</tr>
<% } else {
    ConfigInfo mcfInfo = mcBean.getConfigInfoByMemberId(mbInfo.MemberID);
    String sWebUrl = mcBean.getSiteUrl(mcfInfo);
%>
<tr>
 <td align="center"><font siz="3">Your website Url is: <b><a href="<%=sWebUrl%>"><%=sWebUrl%></a></b></font></td>
</tr>
<tr>
  <td height="10">&nbsp;</td>
</tr>
<TR>
 <TD align="center">
 <script>createLeftButton();</script>
  <a class="button" href="<%=mcBean.encodedUrl("index.jsp?action=Switch_ToMytSite&rootlink=yes&pagetile=Go to My Website")%>">&nbsp;&nbsp;Go to My Website&nbsp;&nbsp;</a>
 <script>createRightButton();</script>
 </TD>
</TR>
<% } %>
<tr>
 <td height="10"></td>
 </tr>
</TABLE>
</FORM>
<% } %>