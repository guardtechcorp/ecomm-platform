<%@ page import="com.zyzit.weboffice.bean.OnlineProcessBean"%>
<%@ page import="com.zyzit.weboffice.model.OnlineProcessInfo" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%
{
   OnlineProcessBean bean = new OnlineProcessBean(session, 20);

   String sAction = request.getParameter("action");
   String sResponse = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n" +
                      "<service>\n" +
                      " <version>Molecularsoft 4.11</version>\n";
   sResponse += "<action>" + sAction +"</action>\n";
   //. Check the sigature
   String sClientSignature = request.getParameter("signature");
   String sSignature = bean.getSignature(request.getParameter("email") + '+' + sAction);
// System.out.println(sAction + " Signature=" + sClientSignature + "," + sSignature);

   bean.writeToLog(bean.getDomainNameFromUrl(request), bean.getClientIp(request), sAction + " by " + request.getParameter("email"), 1);

   if (!sSignature.equals(sClientSignature))
   { //. Signature is not same
       sResponse += " <status>1</status>\n";
       sResponse += " <message>Signature is not the same.</message>\n";
   }
   else
   {
       if ("login".equalsIgnoreCase(sAction))
       {//a3ac714b
          OnlineProcessBean.Result ret = bean.login(request);
          OnlineProcessInfo info = (OnlineProcessInfo)ret.getInfoObject();
          if (ret.isSuccess())
          {
              sResponse += " <status>0</status>\n" +
                          // " <serialno>B1100081fff000041-9140</serialno>\n" +
                           " <serialno>" + info.SerialNo + "</serialno>\n" +
                           " <expireddate>" + info.ExpiredDate.substring(0, 19) + "</expireddate>\n";
          }
          else
          {
              sResponse += " <status>" + ret.m_nStatus + "</status>\n";
              sResponse += " <message>";
              if (ret.m_nStatus==1 || ret.m_nStatus==2)
              {
                sResponse += "The username or password you entered is incorrect.";
              }
              else if (ret.m_nStatus==3)
              {
//System.out.println("ret2=" + ret.m_nStatus);
//Utilities.dumpObject(info);

                sResponse += "Your membership was expired on " + info.ExpiredDate.substring(0, 10) + " and you need to buy more terms to continue using it.";
              }
              else //if (ret.m_nStatus==4)
              {
                sResponse += "Your SoftChemistry program is using in another computer. Since this is a single license version, you may work only on one computer at a time.";
              }

              sResponse += "</message>\n";
          }
       }
       else if ("staylive".equalsIgnoreCase(sAction))
       {
          int nRet = bean.stayLive(request);
          sResponse += " <status>" + nRet + "</status>\n";
          sResponse += " <currentdatetime>" + Utilities.getTodayDateTime() + "</currentdatetime>\n";
       }
       else if ("logout".equalsIgnoreCase(sAction))
       {
          int nRet = bean.logoutNow(request);
          sResponse += " <status>" + nRet + "</status>\n";
       }
       else if ("forgotpassword".equalsIgnoreCase(sAction))
       {
          int nRet = bean.forgotPassword(request);
          String sEmail = request.getParameter("email");
          if (nRet==0)
          {
             sResponse += " <status>0</status>\n";
             sResponse += " <message>Your password information is sent to " + sEmail + " now. Please check it later.</message>\n";
          }
          else
          {
             sResponse += " <status>1</status>\n";
             sResponse += " <message>The E-Mail address you entered does not exist, please try another one.</message>\n";
          }
       }
       else //if ("forgotpassword".equalsIgnoreCase(sAction))
       {
           sResponse += " <status>1</status>\n";
           sResponse += " <message>Unknown action.</message>\n";
       }
   }

   sResponse += "</service>";

    try {
        out.clear();
        out = pageContext.pushBody();
        response.reset();
        response.setContentType("text/html; charset=utf-8");
//System.out.println("sResponse\n" + sResponse);
        response.getWriter().print(sResponse);
        response.flushBuffer();
    }
    catch (java.io.IOException e) {
        e.printStackTrace();
    }
    return;
}

/*
<?xml version="1.0" encoding="UTF-8" ?>
<service>
 <version>Molecularsoft 4.1</version>
 <action>login</action>
 <status>0</status>
 <serialno>B1100081fff000041-9140</serialno>
 <expireddate>2010-10-31 23:59:59</expireddate>
</service>
or
<?xml version="1.0" encoding="UTF-8" ?>
<service>
 <version>Molecularsoft 4.1</version>
 <action>login</action>
 <status>1</status>
 <message>The E-Mail and the password entered do not find any record in our online system.</message>
</service>

<?xml version="1.0" encoding="UTF-8" ?>
<service>
 <version>Molecularsoft 4.1</version>
 <action>staylive</action>
 <status>0</status>
</service>

<?xml version="1.0" encoding="UTF-8" ?>
<service>
 <version>Molecularsoft 4.1</version>
 <action>logout</action>
 <status>0</status>
</service>

<?xml version="1.0" encoding="UTF-8" ?>
<service>
 <version>Molecularsoft 4.1</version>
 <action>forgotpassword</action>
 <status>0</status>
 <message>Your password information is sent to nzhao@molecularsoft.com.</message>
</service>

<?xml version="1.0" encoding="UTF-8" ?>
<service>
 <version>Molecularsoft 4.1</version>
 <action>getCredits</action>
 <status>0</status>
 <message>Your expired date will be in 2010-02-13.</message>
</service>
*/
%>