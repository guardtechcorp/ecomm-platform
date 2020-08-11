<%@ page import="com.zyzit.weboffice.bean.*" %>
<%@ page import="com.zyzit.weboffice.util.Errors" %>
<%@ page import="com.zyzit.weboffice.model.ShareAccessInfo" %>
<%@ page import="com.zyzit.weboffice.util.Definition" %>
<%@ page import="com.zyzit.weboffice.model.MemberInfo" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%
    {
        String sAction = BasicBean.getRealAction(request);
//System.out.println("Ajax sAction =" + sAction);
        String sContent = "";
        if (sAction.equalsIgnoreCase("Send_Message")) {
            MessageBean mgBean = new MessageBean(session, 10, true);
            int nRet = mgBean.addMessage(request);
            sContent = "" + nRet;
        } else if (sAction.equalsIgnoreCase("Swap_MenuOrder")) {
            WebPageBean wpBean = WebPageBean.getObject(session);
            sContent = wpBean.swapMenuLink(request);
        }
        else if (sAction.equalsIgnoreCase("Send_ShareFile"))
        {
           MemberFileBean bean = MemberFileBean.getObject(session);
           MemberFileBean.Result ret = bean.emailShareFile(request);
           sContent = "" + ret.m_nStatus + "<!--!>" + (String) ret.getUpdateInfo();
        }
        else if (sAction.equalsIgnoreCase("Download_ShareFile"))
        {
            MemberFileBean bean = MemberFileBean.getObject(session);
            MemberFileBean.Result ret = bean.startDownload(request);
            sContent = (String)ret.getUpdateInfo();
        }
        else if (sAction.equalsIgnoreCase("SubmitSignIn_ShareFile"))
        {
            MemberFileBean bean = MemberFileBean.getObject(session);
            MemberFileBean.Result ret = bean.signInDownload(request);
            sContent = (String)ret.getUpdateInfo();
        }
        else if (sAction.equalsIgnoreCase("SubmitUnlockCode_ShareFile"))
        {
            MemberFileBean bean = MemberFileBean.getObject(session);
            MemberFileBean.Result ret = bean.unLockDownload(request);
            sContent = (String)ret.getUpdateInfo();
        }
        else if (sAction.equalsIgnoreCase("CheckFileExist_UploadFile"))
        {
// BasicBean.dumpAllParameters(request);
            MemberFileBean bean = MemberFileBean.getObject(session);
            sContent = bean.checkFileExist(request);
        }
        else if (sAction.equalsIgnoreCase("GetOnlineMessage"))
        {
            OnlineMessageBean bean = OnlineMessageBean.getObject(session);
            sContent = bean.getJson(request);
        }
        else if ("Test_EMail".equalsIgnoreCase(sAction))
        {
          EmailBean bean = new EmailBean(session);
          BasicBean.Result ret = bean.sendEmail2(request);
          if (ret.isSuccess())
             sContent = "0";
          else
             sContent = "" + ret.m_nStatus;
        }
        else
        {
            BasicBean.dumpAllParameters(request);
        }

        try {
            out.clear();
            out = pageContext.pushBody();
            response.reset();
            response.setContentType("text/html; charset=utf-8");
            sContent = Utilities.convertCharset(sContent, "iso-8859-1", "utf-8");
            response.getWriter().print(sContent);
            response.flushBuffer();
        }
        catch (java.io.IOException e) {
            e.printStackTrace();
        }
        return;
    }
%>