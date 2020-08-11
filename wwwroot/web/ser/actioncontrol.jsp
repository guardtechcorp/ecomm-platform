<%@ page import="com.zyzit.weboffice.bean.*"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.util.Definition" %>
<%@ page import="com.zyzit.weboffice.web.MemberProductWeb" %>
<%@ page import="com.zyzit.weboffice.web.SiteFileWeb" %>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%
{
//<@page buffer="5kb" autoFlush="false" > <@page pageEncoding="GBK">
//<page language="java" session="true" contentType="text/html;charset=ISO-8859-1"> <page session="false">
//BasicBean.dumpAllParameters(request);
    String sAction = BasicBean.getRealAction(request);
//BasicBean.dumpAllParameters(request);
    if (sAction.equals("Switch_ToMySite")||sAction.equals("Load_ShareFile"))
    { //. Set Site Info
      mcBean.goToMemberSite(request, sAction);
    }
    else
      mcBean.tryToSwitchSite(request);

//System.out.println("Control Action1=" + sAction + "!");
    byte nAccessLevel = mcBean.getPageAccessLevel(request, sAction, cfInfo);
    if (!(sAction.endsWith("_SignIn")||sAction.endsWith("_SignUp")||sAction.startsWith("Sign Out")||sAction.endsWith("_ShareFile")))
    {
        mcBean.putLastUrl(request);
        if (nAccessLevel<=Definition.ACCESSLEVEL_NEEDOWNERLOGIN)
            sAction = "Load_SignIn";
        else if (nAccessLevel<Definition.ACCESSLEVEL_NONEEDLOGIN)
            sAction = "Load_AccessMessage";
//        System.out.println("nAccessLevel2 =" + nAccessLevel+", " + Definition.ACCESSLEVEL_NEEDOWNERLOGIN + ", " +  Definition.ACCESSLEVEL_NONEEDLOGIN);
    }
//System.out.println("Control Action2=" + sAction);

    BasicBean.Result ret = null;
    if (FileUploadBean.isMultiPartForm(request))
    {//. It is upload file
      FileUploadBean bean = new FileUploadBean(session);
      if (nAccessLevel>=Definition.ACCESSLEVEL_NONEEDLOGIN || bean.getMemberInfo()!=null)
      {//. It is not timeout
        ret = bean.parseAnyFormRequest(request, -1); //. Let jsp to determine size
        sAction = bean.getRealAction(ret, request);
//System.out.println("Before do action=" + sAction);
        if ("Update_Photo".equalsIgnoreCase(sAction)) {
            if (ret.isSuccess()) {
                PhotoBean beanPhoto = new PhotoBean(session);
                beanPhoto.update(ret, request);
            }
        } else if ("Add_Product".equalsIgnoreCase(sAction) || "Update_Product".equalsIgnoreCase(sAction)) {
            if (ret.isSuccess()) {
                MemberProductBean productBean = MemberProductBean.getObject(session, 20);
                productBean.update(ret, request);
            }
        } else if ("Update_Company".equalsIgnoreCase(sAction)) {
            if (ret.isSuccess()) {
                MemberCompanyBean beanCompany = new MemberCompanyBean(session);
                beanCompany.update(ret, request);
            }
        } else if ("Update_SiteSetting".equalsIgnoreCase(sAction)) {
            if (ret.isSuccess()) {
                SiteSettingBean siteBean = SiteSettingBean.getObject(session);
                siteBean.update(ret, request);
            }
        }
        else if ("Add_WebPage".equalsIgnoreCase(sAction) || "Update_WebPage".equalsIgnoreCase(sAction))
        {
            if (ret.isSuccess())
            {
                WebPageBean pageBean = WebPageBean.getObject(session);
                ret = pageBean.update(ret, request);
                String sReturn = pageBean.getParamter(ret, "return");
//System.out.println("sReturn=" + sReturn);                
                if (sReturn != null) //. It will directly return;
                    sAction = sReturn;
            }
        }
        else if (sAction.endsWith("_Command_FileStorage"))
        {
          MemberFileBean mfBean = MemberFileBean.getObject(session);
          ret = mfBean.runCommand(ret, request, response);
          if (ret.isSuccess()&&sAction.startsWith("DownloadZip"))
             return;
        }
        else if (sAction.endsWith("Upload_WebFiles"))
        {
          SiteFileWeb fileWeb = SiteFileWeb.getObject(session);
          ret = fileWeb.update(ret, request);
        }
        else if (sAction.endsWith("_OnlineMessageList")||sAction.endsWith("_OnlineMessageDetail"))
        {
            if (ret.isSuccess())
            {
                OnlineMessageBean messageBean = OnlineMessageBean.getObject(session);
                ret = messageBean.update(ret, request);
            }
        }
        else
        {//. This is for the uploading size is exceds the allowed max size.
        }
      }
      else
      {//. It is timeout
         sAction = "Load_SignIn";
         bean.clearLastUrl();
//sLastUrl=/web/ser/index.jsp?action=Edit_WebPage&pid=75&pt=Web Page Information
      }
    } else {
        if (sAction.equals("Submit_SignIn")) {
            ret = mcBean.signIn(request);
            if (ret.isSuccess()) {
                String sLastUrl = mcBean.getLastUrl(request);
                if (sLastUrl != null) {
                    int nStart = sLastUrl.indexOf("/web/ser/");
                    if (nStart != -1)
                        nStart += 9;
                    response.sendRedirect(mcBean.encodedUrl(sLastUrl.substring(nStart)));
//                    String sContent = mcBean.getLocalContent(sLastUrl);
//                    Utilities.writeHtmlOutput(response, sContent);
                    return;
                }
                sAction = mcBean.getHomePageAction(cfInfo);
/*
if (mcBean.getHttpsUrl()!=null)
{
 System.out.println(mcBean.getDomainName() + "-->" +mcBean.getDomainSidCGI());
    //x-forwarded-host = secure.webonlinemanage.com
    String sRedirectUrl = mcBean.getWebsiteUrl(request) + mcBean.encodedUrl("index.jsp?action="+sAction+"&pid=" + mcBean.getPageID(request))+"&" + mcBean.getDomainSidCGI();
//    System.out.println("sRedirectUrl=" + sRedirectUrl);
    response.sendRedirect(sRedirectUrl);
    return;
}
*/
            } else {
                sAction = "Load_SignIn";
            }
        } else if (sAction.equals("Sign Out_SignIn")) {
            mcBean.signOut(request);
//            session.invalidate();
            sAction =  mcBean.getHomePageAction(cfInfo);
        } else if (sAction.equals("Forgot Password_SignIn")) {
            ret = mcBean.forgotPassword(request);
        } else if (sAction.equals("Submit_SignUp")) {
            ret = mcBean.signUp(request);
            if (ret.isSuccess()) {//. Directlt go to my home page
//                sAction = "Apply_SiteMember"; //"Load_MyHome";
            }
        } else if (sAction.equals("Add_Member") || sAction.equals("Update_Member")) {
            RelationshipBean rsBean = RelationshipBean.getObject(session);
            ret = rsBean.update(request, sAction);
        } else if (sAction.equals("Add_Category") || sAction.equals("Update_Category")) {
            MemberCategoryBean ctBean = new MemberCategoryBean(session, 20);
            ret = ctBean.update(request, sAction);
        } else if (sAction.equals("Update_Profile")) {
            ret = mcBean.update(request);
        } else if (sAction.equals("Change_Password")) {
            ret = mcBean.changePassword(request);
//       } else if (sAction.equals("Update_Company")) {
//            ret = mcBean.updateCompany(request);
        } else if (sAction.equals("Update_HtmlEditor")) {
            ContentBean ctBean = new ContentBean(session);
            ret = ctBean.update(request);
        } else if (sAction.equals("Submit_UpgradeAccount")) {
            ret = mcBean.upgradeAccount(request);
        } else if (sAction.equals("Submit_CloseAccount")) {
            ret = mcBean.cancelAccount(request, response);
            if (ret.isSuccess())
                sAction = "Show_Home";
        } else if (sAction.equals("SubmitApply_SiteMember")||sAction.equals("SubmitAccept_SiteMember")||sAction.equals("SubmitQuit_SiteMember")||sAction.equals("SubmitBuy_SiteMember")) {
            RelationshipBean rsBean = RelationshipBean.getObject(session);
            ret = rsBean.submitMembership(request, sAction);
        } else if (sAction.equals("Update_Membership")) {
            MembershipBean bean = MembershipBean.getObject(session);
               ret = bean.update(request);           
        } else if (sAction.equals("Remove_Photo")) {
            PhotoBean photoBean = new PhotoBean(session);
            ret = photoBean.removeFile(request);
        }
        else if ("Delete_OnlineMessageDetail".equalsIgnoreCase(sAction))
        {
            OnlineMessageBean messageBean = OnlineMessageBean.getObject(session);
            ret = messageBean.delete(request, false);
            if (ret.getUpdateInfo()==null)
            {
                String sLinks = mcBean.getNavigationWeb(request, cfInfo, true);
                int nStart = sLinks.indexOf("href=\"");
                int nEnd =   sLinks.indexOf("\"", nStart+6);

                out.clear();
                out = pageContext.pushBody();
                response.sendRedirect(sLinks.substring(nStart+6, nEnd));
                return;
            }
        } else if (sAction.equals("Remove File_Product")) {
            MemberProductBean productBean = new MemberProductBean(session, 10);
            ret = productBean.removeFile(request);
        } else if (sAction.equals("Remove File_Company")) {
            MemberCompanyBean companyBean = new MemberCompanyBean(session);
            ret = companyBean.removeFile(request);
        } else if (sAction.equals("Remove File_SiteSetting")) {
            SiteSettingBean siteBean = SiteSettingBean.getObject(session);
            ret = siteBean.removeFile(request);
        } else if (sAction.equals("Remove File_WebPage")) {
            WebPageBean bean = WebPageBean.getObject(session);
            ret = bean.removeFile(request);
        } else if (sAction.equals("Publish_SiteSetting")) {
            SiteSettingBean siteBean = SiteSettingBean.getObject(session);
            ret = siteBean.publish(request, null, null);
        } else if (sAction.equals("Show_CatProductList")) {
            MemberProductWeb mpWeb = MemberProductWeb.getObject(session);
            ret = mpWeb.getProductByCategory(request);
        } else if (sAction.equals("Quick Search_Search")) {
            MemberProductWeb mpWeb = MemberProductWeb.getObject(session);
            ret = mpWeb.quickSearch(request);
            if (ret.isSuccess())
                sAction = "Show_CatProductList";
            else
                request.setAttribute(BasicBean.BODYPAGE_TITLE, "Try to find products");
        } else if (sAction.equals("Advance Search_Search")) {
            MemberProductWeb mpWeb = MemberProductWeb.getObject(session);
            ret = mpWeb.advancedSearch(request);
            if (ret.isSuccess())
               sAction = "Show_CatProductList";
            else
               request.setAttribute(BasicBean.BODYPAGE_TITLE, "Try to find products");
        } else if (sAction.equals("Submit_PostMessage")) {
            PostMessageBean beanPost = new PostMessageBean(session, 10, true);
            ret = beanPost.addPostMessage(request);
        } else if (sAction.equals("Submit_BuyLeadSearch")) {
            PostMessageBean beanPost = new PostMessageBean(session, 10, true);
            ret = beanPost.searchMessage(request);
            if (ret.isSuccess())
                sAction = "Show_BuyLeadList";
        } else if (sAction.equals("Forward_MsgInbox") || sAction.equals("Forward_MsgSent")) {
            MessageBean beanPost = new MessageBean(session, 10, true);
            ret = beanPost.forwardMessage(request);
        }
        else if (sAction.startsWith("Download") && sAction.endsWith(("FileStorage")))
        {
          MemberFileBean mfBean = MemberFileBean.getObject(session);
          out.clear();
          out = pageContext.pushBody();
          ret = mfBean.doDownloadProcess(sAction, request, response);
          if (ret.isSuccess())
             return;
        }
    }

    if (ret != null)
        ret.m_sAction = sAction;

    BasicBean.setRequestAction(session, sAction);
    BasicBean.setRequestResult(session, ret);
}
%>