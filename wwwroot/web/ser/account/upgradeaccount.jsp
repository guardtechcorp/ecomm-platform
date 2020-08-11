<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo" %>
<%
{
//bean.showAllParameters(request, out);
    String sSubjectNote = null;
    String sContentNote = null;

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
           sSubjectNote = mcBean.getLabel("lg-upgradesite");//"Congratulation! Upgrade to the Site Ownership Account is finish successfully.";

           sbContentNode.append("<LI>" + mcBean.getLabel("lg-lotfeature") + "</LI><br>");
           sbContentNode.append("<LI>" + mcBean.getLabel("lg-changepage") + "</LI><br>");
           sbContentNode.append("<LI>" + mcBean.getLabel("lg-runmship") + "</LI><br>");
           sbContentNode.append("<LI>" + mcBean.getLabel("lg-updownload") + "</LI><br>");

           sContentNote = sbContentNode.toString();
        }
    }

    if (sContentNote==null)
    {
        sSubjectNote = mcBean.getLabel("lg-upgradeaccount");//"Upgrade your account, you can get immediate benefits and good services!";

        sbContentNode.append("<LI>" + mcBean.getLabel("lg-ownsite") + "</LI><br>");
        sbContentNode.append("<LI>" + mcBean.getLabel("lg-changesource") + "</LI><br>");
        sbContentNode.append("<LI>" + mcBean.getLabel("lg-runmship2") + "</LI><br>");
        sbContentNode.append("<LI>" + mcBean.getLabel("lg-onlinefile") + "</LI>");

        sContentNote = sbContentNode.toString();
    }

%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="form_cancel" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post">
<input type="hidden" name="pt" value="<%=mcBean.getLabel("lg-upgradenow")%>">
<input type="hidden" name="rt" value="1">
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
<td align="center"><input type="submit" name="submit" style='width:180px' value="<%=mcBean.getLabel("lg-upgradenow")%>"></td>
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
  <a class="button" href="<%=mcBean.encodedUrl("index.jsp?action=Switch_ToMySite&rl=1&pagetile=" + mcBean.getLabel("lg-gomysite"))%>">&nbsp;&nbsp;<%=mcBean.getLabel("lg-gomysite")%>&nbsp;&nbsp;</a>
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