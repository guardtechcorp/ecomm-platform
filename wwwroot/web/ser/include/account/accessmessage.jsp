<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo" %>
<%@ page import="com.zyzit.weboffice.model.RelationshipInfo" %>
<%@ page import="com.zyzit.weboffice.database.Relationship" %>
<%
{
    StringBuffer sbMessage = new StringBuffer();
    byte nAccessLevel = mcBean.canAccessIt(Utilities.getByte(request.getParameter("accessby"), Definition.ACCESSMODE_PRIVATE));
    String sSubjectNote = null, sContentNote = null;

    if (nAccessLevel == Definition.ACCESSLEVEL_NEEDUSERLOGIN) {
        sSubjectNote = "Only a signed-in user can access this page.";
        sbMessage.append("<UL><LI>If you are not a user, please <A class='focuslink' style='font-weight1:bold' href='" + mcBean.encodedUrl("index.jsp?action=Load_SignUp&rootlink=yes&pagetitle=Sign Up Informaton") + "'>Sign Up</A> now</LI><br>");
        sbMessage.append("<LI>If you are a user already, just sign in now.</LI></UL>");
    } else if (nAccessLevel == Definition.ACCESSLEVEL_NEEDMEMBERLOGIN) {
        sSubjectNote = "Only a member of this site can access this page.";
        sbMessage.append("<UL><LI>If you are not a user, please <A class='focuslink' style='font-weight1:bold' href='" + mcBean.encodedUrl("index.jsp?action=Load_SignUp&rootlink=yes&pagetitle=Sign Up Informaton&apply=1") + "'>Sign Up</A> ");
        sbMessage.append("with 'Apply to be a member of the site' is checked.</LI><BR>");
        sbMessage.append("<LI>If you are a signed-up user already, please sign in first, and then apply its membership.</LI><BR>");
        sbMessage.append("<LI>If you are a member of this site already, just sign in now.</LI></UL>");
    } else if (nAccessLevel == Definition.ACCESSLEVEL_NEEDOWNERLOGIN) {
        sSubjectNote = "Only the owner of this site can access this page.";
        sbMessage.append("<UL><LI>If you are the owner of this site, just sign in now.</LI></UL>");
    } else if (nAccessLevel == Definition.ACCESSLEVEL_LOGINNEEDMEMEBR) {
        sSubjectNote = "Only a member of this site can access this page.";
        sbMessage.append("<UL>");
        if (!mcBean.isPendingMember(mbInfo.MemberID)) {
            MemberInfo ownerInfo = mcBean.getSiteOwnerInfo();
            RelationshipInfo rsInfo = Relationship.getInfo(mcBean.getDomainName(), ownerInfo.MemberID, mbInfo.MemberID);
            sbMessage.append("<LI>You have applied the membership of this site on <b>" + rsInfo.CreateDate.substring(0, 10) + "</b>");
            sbMessage.append(" and are waiting for the owner to approve.</LI><br>");
        } else {
            sbMessage.append("<LI>You are not a member of this site. But you can <A class='focuslink' style='font-weight1:bold' href='" + mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rootlink=yes&pagetitle=Apply Membership of This Site&accessby="+Definition.ACCESSMODE_LOGINUSER) + "'>apply</A> ");
            sbMessage.append("the membership of this site now.</LI><br>");
        }

        sbMessage.append("<LI>After the owner accepts your membership, you can access this page immediately.</LI></UL>");
    } else if (nAccessLevel == Definition.ACCESSLEVEL_LOGINMEMBEREXPIRED) {
        MemberInfo ownerInfo = mcBean.getSiteOwnerInfo();
        RelationshipInfo rsInfo = Relationship.getInfo(mcBean.getDomainName(), ownerInfo.MemberID, mbInfo.MemberID);
        sSubjectNote = "Only a member of this site can access this page.";
        sbMessage.append("<UL>");
        sbMessage.append("<LI>You are a member of this site, but your membership was expired since " + rsInfo.ExpiredDate.substring(0, 10)).append("</LI><br>");
        sbMessage.append("<LI>You can <A class='focuslink' style='font-weight1:bold' href='" + mcBean.encodedUrl("index.jsp?action=Apply_SiteMember&rootlink=yes&pagetitle=Apply Membership of This Site") + "'>apply</A> ");
        sbMessage.append(" its membership again.</LI>");
    } else {
        sSubjectNote = "Only the owner of this site can access this page.";
        sbMessage.append("<UL><LI>You are not the owner of this site. So you can not access this page. Sorry for that.</LI></UL>");
    }

    sContentNote = sbMessage.toString();
//MemberAccountBean.dumpAllParameters(request);
        
%>
<table class1="table-outline" width="100%" align="center">
<TR>
  <TD height="1" align="center">
   <%@ include file="../include/promotenote.jsp"%> 
  </TD>
</TR>
</table>
<% } %>