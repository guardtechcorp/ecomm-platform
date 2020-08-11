<%@ page import="com.zyzit.weboffice.bean.Apollogen.RequisitionWeb" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.RequisitionInfo" %>
<%@ page import="com.zyzit.weboffice.model.NavigationInfo" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.TestResult" %>
<%@ page import="com.zyzit.weboffice.bean.BasicBean" %>
<%
    String sAction = web.getRealAction(request);
    RequisitionInfo trInfo = web.getRequistionInfo();

//web.dumpAllParameters(request);

    currentPage = NavigationInfo.Navigation.Dashbord;
    byte saveFlag = NavigationInfo.Navigation.All.GetValue();
//    trInfo.glInfo.Status = RequisitionInfo.AStatus.SAVED.GetValue();
    if (sAction.equalsIgnoreCase("Dashboard"))
    {
        currentPage = NavigationInfo.Navigation.Dashbord;       
    }
    else if (sAction.equalsIgnoreCase("FillTestForm"))
    {
        if (trInfo==null || trInfo.glInfo==null || trInfo.glInfo.ID>0)
        {
            trInfo = RequisitionInfo.getInstance(true);
            trInfo.CreateDate = Utilities.getTodayDateTime();
            web.setRequistionInfo(trInfo);

        }
        currentPage = NavigationInfo.Navigation.General;
    }
    else if (sAction.equalsIgnoreCase("FillTestForm-Edit")||sAction.equalsIgnoreCase("FillTestForm-View"))
    {
        int nId = Utilities.getInt(request.getParameter("id"), -1);
        trInfo = web.load(nId, null);
        if (trInfo!=null && trInfo.glInfo!=null)
           trInfo.ID = trInfo.glInfo.ID;
        web.setRequistionInfo(trInfo);
    }
    else if (sAction.equalsIgnoreCase("FillTestForm-Search"))
    {
        String sRequestCode = Utilities.getValue(request.getParameter("requestcode")).trim();
        RequisitionInfo findInfo = web.findByRequestCode(sRequestCode);
        if (findInfo==null)
        {
            sErrorMessage = "It could not find a requisition form with your requested code -- " + sRequestCode;
            sErrorClass = "failed";
            currentPage = NavigationInfo.Navigation.Dashbord;
        }
        else
        {
            String sLastName = Utilities.getValue(request.getParameter("lastname"));
            String sBirthDay = Utilities.getValue(request.getParameter("birthday"));
            if (sLastName.equalsIgnoreCase(findInfo.glInfo.LastName)&&sBirthDay.equalsIgnoreCase(findInfo.glInfo.BirthDay))
            {
                trInfo = findInfo;
                web.setRequistionInfo(trInfo);

                if (trInfo.glInfo.Status<RequisitionInfo.AStatus.PATIENTSUBMIT.GetValue())
                   currentPage = NavigationInfo.Navigation.General;
                else
                   currentPage = NavigationInfo.Navigation.Status;
            }
            else
            {
                sErrorMessage = "The last name and/or day of birth is not matched with them inside requisition order.";
                sErrorClass = "failed";
                currentPage = NavigationInfo.Navigation.Dashbord;
            }
        }
    }
    else if (sAction.startsWith("FillTestForm-General"))
    {
       Utilities.fillObjectInfo2(trInfo.glInfo, request);
   //    web.dateleteCardFile(request, trInfo.glInfo);

       currentPage = NavigationInfo.Navigation.Ordering;
       saveFlag = NavigationInfo.Navigation.General.GetValue();
    }
    else if (sAction.startsWith("FillTestForm-Ordering"))
    {
      //. Get input information
      trInfo.glInfo.CancerPanel = Utilities.getInt(request.getParameter("cancerpanel"), 0);
      trInfo.glInfo.Cardiovascular = Utilities.getInt(request.getParameter("cardiovascular"), 0);
      trInfo.glInfo.DrugSensitivity = Utilities.getInt(request.getParameter("drugsensitivity"), 0);
      trInfo.glInfo.OtherRisk = Utilities.getInt(request.getParameter("otherrisk"), 0);

      if (sAction.endsWith("-next"))
         currentPage = NavigationInfo.Navigation.Consent;
      else// if (sAction.endsWith("-prev"))
         currentPage = NavigationInfo.Navigation.General;


      saveFlag = NavigationInfo.Navigation.Ordering.GetValue();
    }
    else if (sAction.startsWith("FillTestForm-Consent"))
    {
       Utilities.fillObjectInfo2(trInfo.ctInfo, request);
       Utilities.fillObjectInfo2(trInfo.glInfo, request);

       if (sAction.endsWith("-prev"))
       {
         currentPage = NavigationInfo.Navigation.Ordering;           
       }
       else if (sAction.endsWith("-next"))
       { //. Write to Database here
          currentPage = NavigationInfo.Navigation.Summary;
       }

       saveFlag = NavigationInfo.Navigation.Consent.GetValue();

    }
    else if (sAction.startsWith("FillTestForm-Summary"))
    {
//       Utilities.fillObjectInfo2(trInfo.ctInfo, request);

       if (sAction.endsWith("-prev"))
       {
         currentPage = NavigationInfo.Navigation.Consent;
       }
       else if (sAction.endsWith("-next"))
       { //. Write to Database here
          currentPage = NavigationInfo.Navigation.Payment;
       }

       saveFlag = NavigationInfo.Navigation.Consent.GetValue();

    }
    else if (sAction.equals("PaypalPay"))
    {
        if (trInfo.glInfo.TotalPay<=0)
           currentPage = NavigationInfo.Navigation.Payment;
        else
           currentPage = NavigationInfo.Navigation.Status;
    }
    else if (sAction.startsWith("FillTestForm-Payment"))
    {
       Utilities.fillObjectInfo2(trInfo.glInfo, request);
//       web.dateleteCardFile(request, trInfo.glInfo);

       if (sAction.endsWith("-prev"))
          currentPage = NavigationInfo.Navigation.Summary;
       else if (sAction.endsWith("-next"))
       { //. Write to Database here
          currentPage = NavigationInfo.Navigation.Payment;
          if (trInfo.glInfo.Status<=RequisitionInfo.AStatus.SAVED.GetValue())
             trInfo.glInfo.Status = RequisitionInfo.AStatus.PATIENTSUBMIT.GetValue();
//          else if (trInfo.glInfo.Status<=RequisitionInfo.AStatus.SUBMITTED.GetValue())
//             trInfo.glInfo.Status = RequisitionInfo.AStatus.RESUBMITTED.GetValue();
          else
             trInfo.glInfo.Status = -1; //Not update it

       //   trInfo.glInfo.CustomerID = loginInfo.CustomerID;
          if (trInfo.ID>0 && trInfo.ID!=trInfo.glInfo.ID)
             trInfo.glInfo.ID = trInfo.ID;

          BasicBean.Result ret = web.update(trInfo, NavigationInfo.Navigation.All.GetValue());
          if (!ret.isSuccess())
          {
            Errors errObj = (Errors)ret.getInfoObject();
            sErrorMessage = errObj.getError();
            sErrorClass = "failed";
          }
          else
          {
             sErrorMessage = "Your Test-Requisition is submitted and waiting for process.";
//             bFormSubmitted = true;

             currentPage = NavigationInfo.Navigation.Status;              
          }
       }
       else
       {
           currentPage = NavigationInfo.Navigation.Summary;           
       }
    }

    else
    {
       if (trInfo==null)
       {
          trInfo = RequisitionInfo.getInstance(true);
          trInfo.CreateDate = Utilities.getTodayDateTime();

          web.setRequistionInfo(trInfo);
       }
    }

    if (sAction.endsWith("-prev") || sAction.endsWith("-next")||sAction.endsWith("-save"))
    {
        if (!(sAction.startsWith("FillTestForm-Eligiblity")||sAction.startsWith("FillTestForm-Summary")))
        {
            if (trInfo.ID>0 && trInfo.ID!=trInfo.glInfo.ID)
               trInfo.glInfo.ID = trInfo.ID;

            if (trInfo.glInfo.Status<=RequisitionInfo.AStatus.STARTED.GetValue())
               trInfo.glInfo.Status = RequisitionInfo.AStatus.SAVED.GetValue();
//            else if (trInfo.glInfo.Status<=RequisitionInfo.AStatus.SAVED.GetValue())
//               trInfo.glInfo.Status = RequisitionInfo.AStatus.PATIENTSUBMIT.GetValue();
            BasicBean.Result ret = web.update(trInfo, saveFlag);

            if (sAction.endsWith("-save"))
            {
                if (!ret.isSuccess())
                {
                  Errors errObj = (Errors)ret.getInfoObject();
                  sErrorMessage = "<font color='red'>" + errObj.getError() + "</font>";
                  sErrorClass = "failed";
                }
                else
                {
                   sErrorMessage = "<font color='green'>Successfully saved!</font>";
//                   bFormSubmitted = true;
                }

                StringBuffer sbContent = new StringBuffer("{");
                sbContent.append("\"ret\":" + ret.isSuccess() + ",\n");
                sbContent.append("\"message\":\"" + sErrorMessage +  "\"");
                sbContent.append("}");

                try {
                    out.clear();
                    out = pageContext.pushBody();
                    response.reset();
                    response.setContentType("text/html; charset=utf-8");
                    response.getWriter().print(sbContent.toString());

                    response.flushBuffer();
                }
                catch (java.io.IOException e) {
                    e.printStackTrace();
                }

                return;
            }
        }
    }
    else if (sAction.startsWith(("FillTestForm-")) && !"FillTestForm-General".equalsIgnoreCase(sAction))
    {
        if (!(sAction.endsWith("-next")||sAction.endsWith("-prev")||sAction.endsWith("-Search")||sAction.endsWith("-input")||sAction.endsWith("-letter")))
        {
           int nIndex = sAction.lastIndexOf("-");
           String name =  sAction.substring(nIndex+1);
           if (nIndex>0)
              currentPage = NavigationInfo.Navigation.GetObjectByName(name);
           if (currentPage==null)
              currentPage = NavigationInfo.Navigation.Dashbord;//General;
        }
    }

%>
<% if (currentPage!=NavigationInfo.Navigation.Dashbord) { %>
<%@ include file="topbar.jsp"%>
<% } %>
<% if (currentPage==NavigationInfo.Navigation.General) { %>
<%@ include file="general.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Ordering) { %>
<%@ include file="ordering.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Consent) { %>
<%@ include file="consent.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Summary) { %>
<%@ include file="finalpage.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Payment) { %>
<%@ include file="payment.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Status) { %>
<%@ include file="statusinfo.jsp"%>
<% } else { %>
<%@ include file="dashboard.jsp" %>
<% } %>
