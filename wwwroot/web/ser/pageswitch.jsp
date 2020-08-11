<%@ page import="com.zyzit.weboffice.bean.BasicBean" %>
<%@ include file="include/pageheader.jsp"%>
<%
{
  if (mcBean==null)
  {//???
      mcBean = MemberAccountBean.getObject(session);
      session.setAttribute(Definition.KEY_DOMAINNAME, mcBean.getHostBaseDomainName());
      cfInfo = mcBean.getSiteConfig(request);       //. Sepecial MemberSite
//System.out.println("session 2=" + session+",  " + cfInfo+", " + mcBean);
  }
  //. It is for first time and it is a new session
//mcBean.transferDomainName(request);
//System.out.println("ret=" + ret + ", " + sRealAction);
//BasicBean.dumpAllParameters(request);
  if (sRealAction.length()==0)
  {//. Try to determine which it is home page
    sRealAction = mcBean.getHomePageAction(cfInfo);      
  }
%>
<TABLE id="MainPageTable" width="100%" border=0 cellspacing=0 cellpadding=0 class="table-area">
<TR>
 <TD height="0">
<%@ include file="include/pagehelp.jsp"%>
 </TD>
</TR>
<TR>
 <TD>
<%@ include file="include/pagetitle.jsp"%>
 </TD>
</TR>
<TR>
 <TD height="400" valign="top">
<%@ include file="util/waitprocess.jsp"%>
<SPAN id="MainPageArea">
<% if (sRealAction.endsWith("_SignUp")) { %>
<!--%@ include file="account/signup.jsp"%-->
<jsp:include page="account/signup.jsp" />
<% } else if (sRealAction.endsWith("_SignIn")) { %>
<%@ include file="account/signin.jsp"%>
<% } else if (sRealAction.endsWith("_Profile")) { %>
<%@ include file="profile/profile.jsp"%>
<% } else if (sRealAction.endsWith("_AccessMessage")) { %>
  <%@ include file="account/accessmessage.jsp"%>
<% } else if (sRealAction.endsWith("_UpgradeAccount")) { %>
  <%@ include file="account/upgradeaccount.jsp"%>    
<% } else if (sRealAction.endsWith("_Photo")) { %>
<%@ include file="profile/myphoto.jsp"%>
<% } else if (sRealAction.endsWith("_Password")) { %>
<%@ include file="profile/password.jsp"%>
<% } else if (sRealAction.endsWith("_Membership")) { %>
<%@ include file="member/membership.jsp"%>
<% } else if (sRealAction.endsWith("_MemberList")) { %>
<jsp:include page="member/memberlist.jsp" />
<% } else if (sRealAction.endsWith("_Member")) { %>
<%@ include file="member/member.jsp"%>
<% } else if (sRealAction.endsWith("_UserInvite")) { %>
<jsp:include page="member/userinvite.jsp" />
<% } else if (sRealAction.endsWith("_SiteMember")) { %>
<%@ include file="member/applymembership.jsp"%>
<% } else if (sRealAction.endsWith("_SiteList")) { %>
<jsp:include page="website/sitelist.jsp" />
<% } else if (sRealAction.endsWith("_PaidService")) { %>
<%@ include file="business/advancedservice.jsp"%>
<% } else if (sRealAction.endsWith("_MsgInboxList")) { %>
<%@ include file="message/msginboxlist.jsp"%>
<% } else if (sRealAction.endsWith("_MsgInbox")) { %>
<%@ include file="message/msginbox.jsp"%>
<% } else if (sRealAction.endsWith("_MsgSentList")) { %>
<%@ include file="message/msgsentlist.jsp"%>
<% } else if (sRealAction.endsWith("_MsgSent")) { %>
<%@ include file="message/msgsent.jsp"%>
<% } else if (sRealAction.endsWith("_Company")) { %>
<%@ include file="business/company.jsp"%>
<% } else if (sRealAction.endsWith("_SiteSetting")) { %>
<jsp:include page="website/sitesetting.jsp" />
<% } else if (sRealAction.endsWith("_ProductList")) { %>
<jsp:include page="product/productlist.jsp" />
<% } else if (sRealAction.endsWith("_Product")) { %>
<jsp:include page="product/product.jsp" />
<% } else if (sRealAction.endsWith("_CategoryList")) { %>
<jsp:include page="product/categorylist.jsp" />
<% } else if (sRealAction.endsWith("_Category")) { %>
<jsp:include page="product/category.jsp" />
<% } else if (sRealAction.endsWith("_WebPageList")) { %>
<jsp:include page="website/webpagelist.jsp" />
<% } else if (sRealAction.endsWith("_WebPage")) { %>
<jsp:include page="website/webpage.jsp" />
<% } else if (sRealAction.endsWith("_MenuLink")) { %>
<%@ include file="website/menulink.jsp"%>
<% } else if (sRealAction.endsWith("_FileCategory")) { %>
<%@ include file="website/filecategory.jsp"%>
<% } else if (sRealAction.endsWith("_CloseAccount")) { %>
<%@ include file="account/closeaccount.jsp"%>
<% } else if (sRealAction.endsWith("_Search")) { %>
<jsp:include page="product/advancesearch.jsp" />
<% } else if (sRealAction.endsWith("_CatProductList")) { %>
<jsp:include page="product/categoryswitch.jsp" />
<% } else if (sRealAction.endsWith("_ProductDetail")) { %>
<jsp:include page="product/productdetail.jsp" />
<% } else if (sRealAction.endsWith("_BuyLeadSearch")) { %>
<jsp:include page="buylead/buyleadsearch.jsp" />
<% } else if (sRealAction.endsWith("_BuyLeadList")) { %>
<jsp:include page="buylead/buyleadlist.jsp" />
<% } else if (sRealAction.endsWith("_BuyLeadDetail")) { %>
<jsp:include page="buylead/buylead.jsp" />
<% } else if (sRealAction.endsWith("_PostMessage")) { %>
<jsp:include page="buylead/postamessage.jsp" />
<% } else if (sRealAction.endsWith("_Content")) { %>
<%@ include file="util/showcontent.jsp"%>
<% } else if (sRealAction.endsWith("_WebFiles")) { %>
<%@ include file="website/filelayouts.jsp"%>
<% } else if (sRealAction.endsWith("_FileStorage")) { %>
<%@ include file="file/filelist.jsp"%>
<% } else if (sRealAction.endsWith("_HtmlEditor")) { %>
<!--%@ include file="util/htmleditor.jsp"%-->
<% } else if (sRealAction.endsWith("_ShareFile")) { %>
<%@ include file="file/fileshare.jsp"%>
<% } else if (sRealAction.endsWith("_MyHome")) { %>
<!-- %@ include file="profile/myhome.jsp"% -->
<% } else if (sRealAction.endsWith("_Feedback")) { %>
<jsp:include page="feature/feedback.jsp" />
<% } else if (sRealAction.endsWith("_FeedbackList")) { %>
<jsp:include page="feature/feedbacklist.jsp" />
<% } else if (sRealAction.endsWith("_FeedbackReply")) { %>
<jsp:include page="feature/feedbackreply.jsp" />
<% } else if (sRealAction.endsWith("_TellFriend")) { %>
<jsp:include page="feature/tellfriend.jsp" />
<% } else if (sRealAction.endsWith("_OnlineMessageList")) { %>
<jsp:include page="feature/messagelist.jsp" />
<% } else if (sRealAction.endsWith("_OnlineMessageDetail")) { %>
<jsp:include page="feature/messagedetail.jsp" />
<% } else if (sRealAction.endsWith("_ContactUs")) { %>
 <jsp:include page="feature/contactus.jsp" />
<% } else if (sRealAction.endsWith("_EMail")) { %>
 <jsp:include page="util/email.jsp" />
<% } else /*if (sRealAction.endsWith("_WebContent"))*/ { %>
<%@ include file="website/webcontent.jsp"%>
<% } %>
</SPAN>
  </TD>
  </TR>
</TABLE>
<!--table width="100%" border="0" cellspacing="2" cellpadding="0" bgcolor1="#e8eefa">
<tr>
  <td height="10"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
</tr>
<TR>
 <TD style="padding:10 0 3 0px">
  <%@ include file="ads/bottomads.jsp"%>     
 </TD>
</TR>
<tr>
  <td height="10"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
</tr>
</TABLE-->
<% } %>