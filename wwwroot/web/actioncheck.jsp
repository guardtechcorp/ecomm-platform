<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.web.*"%>
<%@ page import="com.zyzit.weboffice.bean.BasicBean"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="java.util.List"%>
<%
{
//    String sAction = BasicBean.getRealAction(request);
//BasicBean.dumpAllParameters(request);
    BasicBean.Result ret = null;

    if ("Check Out".equalsIgnoreCase(sIndexAction)||"CheckOut".equalsIgnoreCase(sIndexAction)||"Login My Account".equalsIgnoreCase(sIndexAction)||"forgotpassword".equalsIgnoreCase(sIndexAction)||"Cancel".equalsIgnoreCase(sIndexAction))
    {
       CustomerWeb web = new CustomerWeb(session, request, 0);
       if ("Login My Account".equalsIgnoreCase(sIndexAction))
       {
          ret = web.logon(request);
          if (ret.isSuccess())
          { //. Should remove
           response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm&shipmethod="+request.getParameter("shipmethod")));
           return;
          }
       }
       else if ("forgotpassword".equalsIgnoreCase(sIndexAction))
       {
       }
       else if ("Check Out".equalsIgnoreCase(sIndexAction))
       {
        ShopCartWeb shopcart = new ShopCartWeb(session, request, 100);
        List ltShopCart = shopcart.getShopCartList(request, response);
    //System.out.println("Go to Check out = " + web.getHttpsLink("index.jsp?action=checkout"));
        response.sendRedirect(web.getHttpsLink("index.jsp?action=checkout"));
        return;
       }
       else
       {
         if (web.getInfo(request)!=null)//. Customer has logon already
         {
           response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm&shipmethod="+request.getParameter("shipmethod")));
           return;
         }
       }
    }
    else if ("orderconfirm".equalsIgnoreCase(sIndexAction)||"Cancel Update".equalsIgnoreCase(sIndexAction)||"Order By Check".equalsIgnoreCase(sIndexAction)||"Monthly Charge".equalsIgnoreCase(sIndexAction))
    {
       ShopCartWeb shopcart = new ShopCartWeb(session, request, 100);
       if ("Order By Check".equalsIgnoreCase(sIndexAction)||"Monthly Charge".equalsIgnoreCase(sIndexAction))
       {
         int nPayType = ShopCartWeb.PAYTYPE_OFFLINE;
         if ("Order By Check".equalsIgnoreCase(sIndexAction))
           nPayType = ShopCartWeb.PAYTYPE_CHECK;
         else if ("Monthly Charge".equalsIgnoreCase(sIndexAction))
           nPayType = ShopCartWeb.PAYTYPE_MONTHLYCHARGE;
         else
         {
           if (request.getParameter("x_version")!=null)
              nPayType = ShopCartWeb.PAYTYPE_AUTHORIZE;
         }

         ret = shopcart.processOrder(request, nPayType);
         if (ret.isSuccess())
         {
           response.sendRedirect("invoice.jsp");
           return;
         }
        }
        else if ("orderconfirm".equalsIgnoreCase(sIndexAction))
        {
         String sType = request.getParameter("type");
         if ("paypalnotify".equalsIgnoreCase(sType))
         {
System.out.println("PayPal Notify = " + request.getQueryString());
//shopcart.dumpAllParameters(request);

            ret = shopcart.paypalNotify(request);
            return;// Just return to server side.
         }
         else if ("paypalreturn".equalsIgnoreCase(sType))
         {
System.out.println("PayPal Return = " + request.getQueryString());
//shopcart.dumpAllParameters(request);
           ret = shopcart.paypalReturn(request);
           if (ret.isSuccess())
           { //. Go to invoice page
             response.sendRedirect("invoice.jsp");
             return;
           }
         }
         else if ("paypalcancel".equalsIgnoreCase(sType))
         {
System.out.println("PayPal Cancel=" + request.getQueryString());
//shopcart.showAllParameters(request, out);
            ret = shopcart.paypalCancel(request);
//            sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_PAYPAL_CANCEL, null);
         }
         else if ("itransact".equalsIgnoreCase(sType))
         {
System.out.println("iTransact = " + request.getQueryString());
//shopcart.showAllParameters(request, out);
           ret = shopcart.iTransactReturn(request);
           if (ret.isSuccess())
           {//. Go to invoice page
             response.sendRedirect("invoice.jsp");
             return;
           }
         }
       }
   }
   else if (//"New Customer".equalsIgnoreCase(sIndexAction)||"EditAccount".equalsIgnoreCase(sIndexAction)||
             "Submit Information".equalsIgnoreCase(sIndexAction)||"Submit Update".equalsIgnoreCase(sIndexAction))
   {
       CustomerWeb web = new CustomerWeb(session, request, 10);
       if ("Submit Information".equalsIgnoreCase(sIndexAction))
       {
         ret = web.update(request, true);
         if (ret.isSuccess())
         {
           response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm"));
           return;
         }
       }
       else if ("Submit Update".equalsIgnoreCase(sIndexAction))
       {
         ret = web.update(request, false);
         if (ret.isSuccess())
         {
           response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm"));
           return;
         }
       }
   }
   else if ("Update Billing Information".equalsIgnoreCase(sIndexAction))//||"EditBillingInfo".equalsIgnoreCase(sIndexAction))
   {
       CustomerWeb web = new CustomerWeb(session, request, 10);
       if ("Update Billing Information".equalsIgnoreCase(sIndexAction))
       {
         ret = web.update(request, false);
         if (ret.isSuccess())
         {
           response.sendRedirect(web.encodedUrl("index.jsp?action=orderconfirm"));
           return;
         }
       }
   }
   else if ("Order By Credit Card".equalsIgnoreCase(sIndexAction)||"Place Order".equalsIgnoreCase(sIndexAction)||"Callback".equalsIgnoreCase(sIndexAction))
   {
       CustomerWeb web = new CustomerWeb(session, request, 10);
       CustomerInfo ctInfo =  web.getInfo(request);
       if ("Place Order".equalsIgnoreCase(sIndexAction))
       {//. Update credit card information first
          ret = web.update(request, false);
          if (ret.isSuccess())
          {//. Then make order process
            ctInfo = (CustomerInfo)ret.getUpdateInfo();
          }

          ShopCartWeb shop11 = new ShopCartWeb(session, request, 100);
          ret = shop11.processOnline(request, ctInfo);

          if (ret.isSuccess())
          {//. Go to invoice page
             String sCustomerId = request.getParameter("customerid");
             String preorderno  = request.getParameter("preorderno");
             String sCustom = request.getParameter("custom");
             String sUrl = "invoice.jsp?customerid=" + sCustomerId + "&preorderno=" + preorderno;
             if (Utilities.getValueLength(sCustom)>0)
                sUrl += "&custom=" + Utilities.getUrlEncode(sCustom);
                           
             response.sendRedirect(sUrl);//"invoice.jsp");
             return;
          }
       }
       else if ("Callback".equalsIgnoreCase(sIndexAction))
       {//. Update credit card information first
//    System.out.println("Callback by iTransact");
         ShopCartWeb shop11 = new ShopCartWeb(session, request, 100);
         String sRet = shop11.callback(request);
         response.reset();
         response.setContentType("text/html");
         response.getWriter().print(sRet);
         response.getWriter().flush();
         response.getWriter().close();
         return;
       }
   }
   else if ("ordertrack".equalsIgnoreCase(sIndexAction)||"Login Account".equalsIgnoreCase(sIndexAction)||"Login".equalsIgnoreCase(sIndexAction))
   {
       CustomerWeb web = new CustomerWeb(session, request, 0);
       CustomerInfo ctInfo = null;
       if ("Login Account".equalsIgnoreCase(sIndexAction))
       {
         ret = web.logon(request);
         if (ret.isSuccess())
         {
           response.sendRedirect(web.encodedUrl("index.jsp?action=ordertracklist&type=afterlogin"));
           return;
         }
       }
       else if ("forgotpassword".equalsIgnoreCase(sIndexAction))
       {
       }
       else if ("Login".equalsIgnoreCase(sIndexAction))
       {
          ret = web.memberLogon(request);
          if (!ret.isSuccess())
          {
             Errors errObj = (Errors)ret.getInfoObject();
             String sDisplayMessage = errObj.getError();
             response.sendRedirect(web.encodedUrl("index.jsp?action=memberlogin&type=failed&error=" + sDisplayMessage));
          }
          else
          {
             response.sendRedirect(web.encodedUrl("index.jsp?action=memberlogin&type=success"));
          }
          return;
        }
        else
        {
            if (web.getInfo(request)!=null)//. Customer has logon already
            {
               response.sendRedirect(web.encodedUrl("index.jsp?action=ordertracklist&type=afterlogin"));
               return;
            }
        }
   }
   else if ("advancesearch".equalsIgnoreCase(sIndexAction)||"Quick Search".equalsIgnoreCase(sIndexAction)||"Advance Search".equalsIgnoreCase(sIndexAction))
   { 
       if ("Quick Search".equalsIgnoreCase(sIndexAction)) //Search Now
       {
         ProductWeb product = new ProductWeb(session, request, 10);
         int nTotal = product.quickSearch(request);
         if (nTotal>0)
         {
           response.sendRedirect(product.encodedUrl("index.jsp?action=showproducts&categoryid=-13"));
           return;
         }
       }
       else if ("Advance Search".equalsIgnoreCase(sIndexAction)) //Search Now
       {
         ProductWeb product = new ProductWeb(session, request, 10);
         int nTotal = product.advancedSearch(request);
         if (nTotal>0)
         {
            response.sendRedirect(product.encodedUrl("index.jsp?action=showproducts&categoryid=-13"));
            return;
         }
       }
   }

   if (ret != null)
   {
       ret.m_sAction = sIndexAction;
       BasicBean.setRequestAction(session, sIndexAction);
       BasicBean.setRequestResult(session, ret);
   }
}
%>